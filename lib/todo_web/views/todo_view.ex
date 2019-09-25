defmodule TodoWeb.TodoView do
  use TodoWeb, :view

  def left_todos(todos) do
    left_todos = Enum.reject(todos, &(&1.completed))

    [
      content_tag :strong do
        length(left_todos)
      end,
      items(left_todos),
      "left"
    ]
    |> Enum.intersperse(" ")
  end

  defp items([_]), do: "item"
  defp items(_), do: "items"
end
