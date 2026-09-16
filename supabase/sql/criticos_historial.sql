-- Tabla de snapshots para el gráfico de "Tendencia" de críticos activos de polines.
-- Cada envío del correo (Edge Function enviar-resumen-criticos) hace UPSERT de un
-- punto por día (fecha = PK), y el correo grafica los últimos ~12 puntos.
-- Ejecutar UNA vez en Supabase → SQL Editor.

create table if not exists public.criticos_historial (
  fecha        date primary key,
  total        integer not null default 0,
  muy_alta     integer not null default 0,
  alta         integer not null default 0,
  media        integer not null default 0,
  magnetita    integer not null default 0,
  cnn          integer not null default 0,
  embarque     integer not null default 0,
  actualizado  timestamptz not null default now()
);

-- La Edge Function usa la SERVICE_ROLE key (omite RLS), así que no se requieren
-- políticas para que escriba/lea. Si activas RLS, deja sin política de acceso anónimo:
alter table public.criticos_historial enable row level security;
