defmodule CommunityWeb.Schema do
  use Absinthe.Schema
  import_types CommunityWeb.Schema.Types



  query do
    field :hello, :string do
      resolve fn _, _ -> {:ok, "world!"} end
    end

    field :posts, type: list_of(:post) do
      resolve &Community.Resolvers.PostResolver.all/2
    end

    field :post, type: (:post) do
      arg :id, non_null(:id)
      resolve &Community.Resolvers.PostResolver.find/2
    end

    field :users, type: list_of(:user) do
      resolve &Community.Resolvers.UserResolver.all/2
    end

    field :user, type: :user do
      arg :id, non_null(:id)
      resolve &Community.Resolvers.UserResolver.find/2
    end
  end

  input_object :update_post_params do
    field :title, non_null(:string)
    field :body, non_null(:string)
    field :user_id, non_null(:integer)
  end

  input_object :update_user_params do
    field :name, non_null(:string)
    field :email, non_null(:string)
    field :password, non_null(:string)
  end

  mutation do
    field :update_user, type: :user do
      arg :id, non_null(:integer)
      arg :user, :update_user_params

      resolve &Community.Resolvers.UserResolver.update/2
    end


    field :create_post, type: :post do
      arg(:title, non_null(:string))
      arg(:body, non_null(:string))
      arg(:user_id, non_null(:integer))

      resolve(&Community.Resolvers.PostResolver.create/2)
    end

    field :update_post, type: :post do
      arg :id, non_null(:integer)
      arg :post, :update_post_params

      resolve &Community.Resolvers.PostResolver.update/2
    end

    field :delete_post, type: :post do
      arg :id, non_null(:integer)

      resolve &Community.Resolvers.PostResolver.delete/2
    end

    field :login, type: :session do
      arg :email, non_null(:string)
      arg :password, non_null(:string)

      resolve &Community.Resolvers.UserResolver.login/2
    end
  end

end
