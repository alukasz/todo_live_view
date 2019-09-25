defmodule TodoWeb.TodoLive do
  use Phoenix.LiveView

  @todos [
    %Todo{title: "Taste Elixir & Phoenix LiveView", completed: true},
    %Todo{title: "Buy a unicorn", completed: false}
  ]

  def render(assigns) do
    TodoWeb.TodoView.render("index.html", assigns)
  end

  def mount(_, socket) do
    {:ok, assign(socket, :todos, @todos)}
  end

  def handle_event("add_todo", %{"todo" => %{"title" => title}}, socket) do
    todo = %Todo{title: title}
    {:noreply, assign(socket, :todos, socket.assigns.todos ++ [todo])}
  end
end
