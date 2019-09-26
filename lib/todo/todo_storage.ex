defmodule Todo.TodoStorage do
  use Agent

  def start_link(id) do
    Agent.start_link(fn -> [] end, name: name(id))
  end

  def get(id) do
    Agent.get(name(id), &(&1))
  end

  def put(id, todos) do
    Agent.update(name(id), fn _ -> todos end)
  end

  defp name(id) do
    {:via, Registry, {Todo.TodoRegistry, id}}
  end
end
