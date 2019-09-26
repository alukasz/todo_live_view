defmodule Todo.TodoManager do
  alias Todo.TodoStorage
  alias Todo.TodoSupervisor

  def start(id) do
    TodoSupervisor.start_child(id)
  end

  def get(id) do
    TodoStorage.get(id)
  end

  defp put(id, todos) do
    TodoStorage.put(id, todos)
    todos
  end

  def add(id, todo_params) do
    case Todo.create(todo_params) do
      {:ok, todo} ->
        todos = put(id, get(id) ++ [todo])
        {:ok, todos}

      error -> error
    end
  end

  def toggle(id, todo_id) do
    todos = toggle_todo(get(id), todo_id)
    put(id, todos)
  end

  defp toggle_todo(todos, todo_id) do
    Enum.map(todos, fn
      %Todo{id: ^todo_id, completed: completed} = todo -> %{todo | completed: !completed}
      todo -> todo
    end)
  end

  def delete(id, todo_id) do
    todos = delete_todo(get(id), todo_id)
    put(id, todos)
  end

  defp delete_todo(todos, todo_id) do
    Enum.reject(todos, &(&1.id == todo_id))
  end
end
