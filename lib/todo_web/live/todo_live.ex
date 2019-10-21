defmodule TodoWeb.TodoLive do
  use Phoenix.LiveView

  @todos [
    %Todo{id: "1", title: "Taste Elixir & Phoenix LiveView", completed: true},
    %Todo{id: "2", title: "Buy a unicorn", completed: false}
  ]

  def render(assigns) do
    TodoWeb.TodoView.render("index.html", assigns)
  end

  def mount(_, socket) do
    {:ok, assign(socket, todos: @todos, filter: "all")}
  end

  def handle_params(%{"filter" => filter}, _uri, socket) when filter in ["active", "completed"] do
    {:noreply, assign(socket, :filter, filter)}
  end

  def handle_params(_params, _uri, socket) do
    {:noreply, assign(socket, :filter, "all")}
  end

  def handle_event("add_todo", %{"todo" => todo_params}, socket) do
    case Todo.create(todo_params) do
      {:ok, todo} ->
        {:noreply, assign(socket, :todos, socket.assigns.todos ++ [todo])}
      error ->
        {:noreply, socket}
    end
  end

  def handle_event("toggle_todo", %{"id" => todo_id}, socket) do
    todos = toggle_todo(socket.assigns.todos, todo_id)
    {:noreply, assign(socket, :todos, todos)}
  end

  defp toggle_todo(todos, todo_id) do
    Enum.map(todos, fn
      %Todo{id: ^todo_id, completed: completed} = todo ->
        %{todo | completed: !completed}

      todo ->
        todo
    end)
  end
end
