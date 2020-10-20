defmodule Community.Resolvers.UserResolver do
  alias Community.Accounts

  def all(_args, _info) do
    {:ok, Accounts.list_users()}
  end

  def find(%{id: id}, _info) do
    case Accounts.get_user!(id) do
      nil -> {:error, "User id #{id} not found!"}
      user -> {:ok, user}
    end
  end

  def update(%{id: id, user: user_params}, _info) do
    Accounts.get_user!(id) |> Accounts.update_user(user_params)
  end

  def login(params, _info) do
    
    with  {:ok, user} <- Community.Accounts.User.authenticate(params),
          {:ok, jwt, _} <- Community.Guardian.encode_and_sign(user),
          {:ok, _} <- Community.Accounts.store_user(user, jwt)
    do
      {:ok, %{token: jwt}}
    end
  end

end
