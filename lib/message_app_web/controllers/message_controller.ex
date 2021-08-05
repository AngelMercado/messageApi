defmodule MessageAppWeb.MessageController do
  use MessageAppWeb, :controller

  require Logger
  alias MessageApp.Messages
  alias MessageApp.Messages.Message

  action_fallback MessageAppWeb.FallbackController

  def index(conn, _params) do

    #init_time = Time.utc_now
  messages = Messages.list_messages()
#    messages =   [%MessageApp.Messages.Message{
#      id: 18,
#      inserted_at: ~N[2021-07-31 01:05:06],
#      messageText: "Mensaje sin consultar base de datos",
#      personType: "M",
#      title: "titulo",
#      updated_at: ~N[2021-07-31 01:05:06]
#    }
#  ]
    #total_time = Time.utc_now

    #msg = Time.diff(total_time,ini)
    #Logger.info "test"
    render(conn, "index.json", messages: messages)

  end

  def create(conn, %{"message" => message_params}) do
    with {:ok, %Message{} = message} <- Messages.create_message(message_params) do
      conn
      |> put_status(:created)
      |> put_resp_header("location", Routes.message_path(conn, :show, message))
      |> render("show.json", message: message)
    end
  end

  def show(conn, %{"id" => id}) do
    message = Messages.get_message!(id)
    render(conn, "show.json", message: message)
  end

  def update(conn, %{"id" => id, "message" => message_params}) do
    message = Messages.get_message!(id)

    with {:ok, %Message{} = message} <- Messages.update_message(message, message_params) do
      render(conn, "show.json", message: message)
    end
  end

  def delete(conn, %{"id" => id}) do
    message = Messages.get_message!(id)

    with {:ok, %Message{}} <- Messages.delete_message(message) do
      send_resp(conn, :no_content, "")
    end
  end
end
