defmodule Todo.TodoSupervisor do
  use DynamicSupervisor

  # public API
  def start_link(opts) do
    DynamicSupervisor.start_link(__MODULE__, opts, name: __MODULE__)
  end

  def start_child(id) do
    DynamicSupervisor.start_child(__MODULE__, {Todo.TodoServer, id})
  end

  # callbacks
  def init(_) do
    DynamicSupervisor.init(strategy: :one_for_one)
  end
end
