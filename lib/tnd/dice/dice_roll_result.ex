defmodule Tnd.Dice.DiceRollResult do
  alias Tnd.Dice.DicePool

  defstruct pool: %DicePool{},
            success: 0,
            advantage: 0,
            triumph: 0,
            failure: 0,
            threat: 0,
            despair: 0
end
