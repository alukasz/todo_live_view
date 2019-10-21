defmodule TodoWeb.TodoLive do
  use Phoenix.LiveView

  alias Todo.TodoServer

  def render(assigns) do
    TodoWeb.TodoView.render("index.html", assigns)
  end

  def mount(%{todo_token: todos_id}, socket) do
    TodoServer.start_link(todos_id)
    todos = TodoServer.get(todos_id)
    {:ok, assign(socket, todos: todos, filter: "all", todos_id: todos_id)}
  end

  def handle_params(%{"filter" => filter}, _uri, socket) when filter in ["active", "completed"] do
    {:noreply, assign(socket, :filter, filter)}
  end

  def handle_params(_params, _uri, socket) do
    {:noreply, assign(socket, :filter, "all")}
  end

  def handle_event("add_todo", %{"todo" => todo_params}, socket) do
    case TodoServer.add(socket.assigns.todos_id, todo_params) do
      {:ok, todos} -> {:noreply, assign(socket, :todos, todos)}
      error -> {:noreply, socket}
    end
  end

  def handle_event("toggle_todo", %{"id" => todo_id}, socket) do
    todos = TodoServer.toggle(socket.assigns.todos_id, todo_id)
    {:noreply, assign(socket, :todos, todos)}
  end
end
