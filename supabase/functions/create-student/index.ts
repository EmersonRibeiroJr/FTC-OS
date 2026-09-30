import { createClient } from "https://esm.sh/@supabase/supabase-js@2";

const cors = {
  "Access-Control-Allow-Origin": "*",
  "Access-Control-Allow-Headers": "authorization, x-client-info, apikey, content-type",
};
const json = (body: unknown, status = 200) =>
  new Response(JSON.stringify(body), {
    status,
    headers: { ...cors, "Content-Type": "application/json" },
  });

Deno.serve(async (req) => {
  if (req.method === "OPTIONS") return new Response("ok", { headers: cors });

  const admin = createClient(
    Deno.env.get("SUPABASE_URL")!,
    Deno.env.get("SUPABASE_SERVICE_ROLE_KEY")!,
  );

  // 1) Quem está chamando?
  const token = (req.headers.get("Authorization") ?? "").replace("Bearer ", "");
  const { data: auth } = await admin.auth.getUser(token);
  if (!auth.user) return json({ error: "unauthorized" }, 401);

  // 2) Validar entrada.
  const b = await req.json().catch(() => ({}));
  const username = String(b.username ?? "").trim().toLowerCase();
  const displayName = String(b.displayName ?? "").trim();
  const password = String(b.password ?? "");
  if (!/^[a-z0-9._-]{3,30}$/.test(username)) return json({ error: "invalid username" }, 400);
  if (!displayName || password.length < 8) return json({ error: "invalid input" }, 400);

  // 3) O chamador precisa ser coach ou mentor DESTA equipe.
  const { data: caller } = await admin.from("members").select("role")
    .eq("team_id", b.teamId).eq("user_id", auth.user.id).is("deleted_at", null).maybeSingle();
  if (!caller || !["coach", "mentor"].includes(caller.role)) return json({ error: "forbidden" }, 403);

  const { data: team } = await admin.from("teams").select("code").eq("id", b.teamId).single();
  if (!team) return json({ error: "team not found" }, 404);

  // 4) Criar usuário (e-mail sintético, igual ao do app) + perfil + vínculo.
  const email = `${username}@${String(team.code).toLowerCase()}.ftcos.local`;
  const { data: created, error } = await admin.auth.admin.createUser({
    email, password, email_confirm: true,
  });
  if (error || !created.user) return json({ error: error?.message ?? "create failed" }, 400);

  const uid = created.user.id;
  const p = await admin.from("profiles").insert({
    user_id: uid, display_name: displayName, username, must_change_password: true,
  });
  const m = await admin.from("members").insert({
    team_id: b.teamId, user_id: uid, role: "member", discipline: b.discipline ?? null,
  });
  if (p.error || m.error) {
    await admin.auth.admin.deleteUser(uid); // desfaz tudo
    return json({ error: "could not create member" }, 500);
  }
  return json({ userId: uid }, 201);
});
