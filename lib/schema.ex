defmodule Tnd.Schema do
  @moduledoc """
  Extends `use Ecto.Schema` to bring in some niceness when dealing with schemas.
  """

  defmacro __using__(_opts) do
    quote do
      use Ecto.Schema
      import Ecto.Changeset
      import Ecto.Query, warn: false

      @primary_key {:id, Tnd.NanoidEctoType, read_after_writes: true}
      @foreign_key_type Tnd.NanoidEctoType
    end
  end
end
