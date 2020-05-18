defmodule Tnd.NanoidEctoType do
  use Ecto.Type

  @doc "The ecto type."
  def type, do: :string

  def cast(value) when is_binary(value), do: {:ok, value}
  def cast(_), do: :error

  def load(value), do: {:ok, value}

  def dump(value) when is_binary(value), do: {:ok, value}
  def dump(_), do: :error

  @doc """
  Delegates generation of the field to `Nanoid.generate/0`.
  """
  def autogenerate, do: Nanoid.generate()
end
