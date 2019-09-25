defmodule TodoWeb.TodoView do
  use TodoWeb, :view

  def filter_todos(todos, "all"), do: todos
  def filter_todos(todos, "active"), do: Enum.reject(todos, &(&1.completed))
  def filter_todos(todos, "completed"), do: Enum.filter(todos, &(&1.completed))

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

  def filter_link(socket, filter, active_filter) do
    route = Routes.todo_path(socket, TodoWeb.TodoLive, filter)
    live_link String.capitalize(filter), to: route, class: filter_class(filter, active_filter)
  end

  defp filter_class(filter, filter), do: "selected"
  defp filter_class(_, _), do: nil
end
