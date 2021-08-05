defmodule MessageApp.MessagesTest do
  use MessageApp.DataCase

  alias MessageApp.Messages

  describe "messages" do
    alias MessageApp.Messages.Message

    @valid_attrs %{messageText: "some messageText", personType: "some personType", title: "some title"}
    @update_attrs %{messageText: "some updated messageText", personType: "some updated personType", title: "some updated title"}
    @invalid_attrs %{messageText: nil, personType: nil, title: nil}

    def message_fixture(attrs \\ %{}) do
      {:ok, message} =
        attrs
        |> Enum.into(@valid_attrs)
        |> Messages.create_message()

      message
    end

    test "list_messages/0 returns all messages" do
      message = message_fixture()
      assert Messages.list_messages() == [message]
    end

    test "get_message!/1 returns the message with given id" do
      message = message_fixture()
      assert Messages.get_message!(message.id) == message
    end

    test "create_message/1 with valid data creates a message" do
      assert {:ok, %Message{} = message} = Messages.create_message(@valid_attrs)
      assert message.messageText == "some messageText"
      assert message.personType == "some personType"
      assert message.title == "some title"
    end

    test "create_message/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Messages.create_message(@invalid_attrs)
    end

    test "update_message/2 with valid data updates the message" do
      message = message_fixture()
      assert {:ok, %Message{} = message} = Messages.update_message(message, @update_attrs)
      assert message.messageText == "some updated messageText"
      assert message.personType == "some updated personType"
      assert message.title == "some updated title"
    end

    test "update_message/2 with invalid data returns error changeset" do
      message = message_fixture()
      assert {:error, %Ecto.Changeset{}} = Messages.update_message(message, @invalid_attrs)
      assert message == Messages.get_message!(message.id)
    end

    test "delete_message/1 deletes the message" do
      message = message_fixture()
      assert {:ok, %Message{}} = Messages.delete_message(message)
      assert_raise Ecto.NoResultsError, fn -> Messages.get_message!(message.id) end
    end

    test "change_message/1 returns a message changeset" do
      message = message_fixture()
      assert %Ecto.Changeset{} = Messages.change_message(message)
    end
  end
end
