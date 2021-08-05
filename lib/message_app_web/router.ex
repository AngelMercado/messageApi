defmodule MessageAppWeb.Router do
  use MessageAppWeb, :router

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/api/v1", MessageAppWeb, log: false do
    pipe_through :api
    resources "/message", MessageController, log: false, except: [:new, :edit]
  end

  # Enables LiveDashboard only for development
  #
  # If you want to use the LiveDashboard in production, you should put
  # it behind authentication and allow only admins to access it.
  # If your application does not have an admins-only section yet,
  # you can use Plug.BasicAuth to set up some basic authentication
  # as long as you are also using SSL (which you should anyway).
  if Mix.env() in [:test] do
    import Phoenix.LiveDashboard.Router

    scope "/" do
      pipe_through [:fetch_session, :protect_from_forgery]
      live_dashboard "/dashboard", metrics: MessageAppWeb.Telemetry
    end
  end
end
