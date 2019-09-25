defmodule Todo do
  @moduledoc """
  Todo keeps the contexts that define your domain
  and business logic.

  Contexts are also responsible for managing your data, regardless
  if it comes from the database, an external API or others.
  """

  use Ecto.Schema

  import Ecto.Changeset

  @primary_key {:id, :binary_id, []}
  embedded_schema do
    field :title, :string
    field :completed, :boolean, default: false
  end

  def create(params) do
    %Todo{}
    |> cast(params, [:title])
    |> validate_required([:title])
    |> generate_id()
    |> apply_action(:insert)
  end

  defp generate_id(changeset) do
    put_change(changeset, :id, Ecto.UUID.generate())
  end
end
