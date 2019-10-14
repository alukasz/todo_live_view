defmodule Todo.TodoServer do
  use GenServer

  def start_link(id) do
    GenServer.start_link(__MODULE__, [], name: name(id))
  end

  def get(id) do
    GenServer.call(name(id), :get)
  end

  def add(id, todo_params) do
    GenServer.call(name(id), {:add, todo_params})
  end

  def toggle(id, todo_id) do
    GenServer.call(name(id), {:toggle, todo_id})
  end

  def delete(id, todo_id) do
    GenServer.call(name(id), {:delete, todo_id})
  end

  defp name(id) do
    {:via, Registry, {Todo.TodoRegistry, id}}
  end

  def init(_opts) do
    {:ok, []}
  end

  def handle_call(:get, _from, todos) do
    {:reply, todos, todos}
  end

  def handle_call({:add, todo_params}, _from, todos) do
    case Todo.create(todo_params) do
      {:ok, todo} ->
        new_todos = todos ++ [todo]
        {:reply, {:ok, new_todos}, new_todos}

      error ->
        {:reply, error, todos}
    end
  end

  def handle_call({:toggle, todo_id}, _from, todos) do
    todos = toggle_todo(todos, todo_id)
    {:reply, todos, todos}
  end

  def handle_call({:delete, todo_id}, _from, todos) do
    todos = delete_todo(todos, todo_id)
    {:reply, todos, todos}
  end

  defp toggle_todo(todos, todo_id) do
    Enum.map(todos, fn
      %Todo{id: ^todo_id, completed: completed} = todo -> %{todo | completed: !completed}
      todo -> todo
    end)
  end

  defp delete_todo(todos, todo_id) do
    Enum.reject(todos, &(&1.id == todo_id))
  end
end
