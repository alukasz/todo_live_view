defmodule TodoWeb.TodoLive do
  use Phoenix.LiveView

  def render(assigns) do
    TodoWeb.TodoView.render("index.html", assigns)
  end

  def mount(_, socket) do
      {:ok, socket}
  end
end
