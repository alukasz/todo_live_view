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
    {:ok, assign(socket, :todos, @todos)}
  end
end
