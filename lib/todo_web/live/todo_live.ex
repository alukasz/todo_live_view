defmodule TodoWeb.TodoLive do
  use Phoenix.LiveView

  alias Todo.TodoManager

  def render(assigns) do
    TodoWeb.TodoView.render("index.html", assigns)
  end

  def mount(%{todo_token: todos_id}, socket) do
    TodoManager.start(todos_id)
    todos = TodoManager.get(todos_id)
    {:ok, assign(socket, todos: todos, filter: "all", todos_id: todos_id)}
  end

  def handle_params(%{"status" => status}, _uri, socket) when status in ["active", "completed"] do
    {:noreply, assign(socket, :filter, status)}
  end

  def handle_params(_params, _uri, socket) do
    {:noreply, assign(socket, :filter, "all")}
  end

  def handle_event("add_todo", %{"todo" => todo_params}, socket) do
    case TodoManager.add(socket.assigns.todos_id, todo_params) do
      {:ok, todos} ->
        {:noreply, assign(socket, :todos, todos)}

      _ ->
        {:noreply, socket}
    end
  end

  def handle_event("toggle_todo", %{"id" => todo_id}, socket) do
    todos = TodoManager.toggle(socket.assigns.todos_id, todo_id)
    {:noreply, assign(socket, :todos, todos)}
  end

  def handle_event("delete_todo", %{"id" => todo_id}, socket) do
    todos = TodoManager.delete(socket.assigns.todos_id, todo_id)
    {:noreply, assign(socket, :todos, todos)}
  end
end
