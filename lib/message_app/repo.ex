defmodule MessageApp.Repo do
  use Ecto.Repo,
    otp_app: :message_app,
    adapter: Ecto.Adapters.Postgres
end
