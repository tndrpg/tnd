defmodule Tnd.Factory do
  use ExMachina.Ecto, repo: Tnd.Repo

  def user_factory do
    %Tnd.Accounts.User{
      email: Faker.Internet.email(),
      hashed_password: Bcrypt.hash_pwd_salt("supersecretpassword")
    }
  end

  def confirmed_user_factory do
    %Tnd.Accounts.User{
      email: Faker.Internet.email(),
      hashed_password: Bcrypt.hash_pwd_salt("supersecretpassword"),
      confirmed_at: NaiveDateTime.utc_now()
    }
  end
end
