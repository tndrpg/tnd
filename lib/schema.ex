defmodule Tnd.Schema do
  @moduledoc """
  Extends `use Ecto.Schema` to bring in some niceness when dealing with schemas.
  """

  defmacro __using__(_opts) do
    quote do
      use Ecto.Schema
      import Ecto.Changeset
      import Ecto.Query, warn: false

      @primary_key {:id, Ecto.ULID, autogenerate: true}
      @foreign_key_type Ecto.ULID
    end
  end
end
