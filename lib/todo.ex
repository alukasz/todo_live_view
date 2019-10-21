defmodule Todo do
  @moduledoc """
  Todo keeps the contexts that define your domain
  and business logic.

  Contexts are also responsible for managing your data, regardless
  if it comes from the database, an external API or others.
  """

  defstruct [:id, :title, completed: false]

  def create(%{"title" => title}) when byte_size(title) >= 3 do
    {:ok, %Todo{id: Ecto.UUID.generate(), title: title}}
  end

  def create(_) do
    {:error, :invalid_title}
  end
end
