defmodule Discuss.Router do
  use Discuss.Web, :router

  pipeline :browser do
    plug :accepts, ["html"]
    plug :fetch_session
    plug :fetch_flash
    plug :protect_from_forgery
    plug :put_secure_browser_headers
    plug Discuss.Plugs.SetUserPlug
  end

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/", Discuss do
    pipe_through :browser # Use the default browser stack

    # Phoenix uses RESTful conventions, that's why func new
    get "/", TopicController, :index
    # get "/topics/new", TopicController, :new
    # post "/topics", TopicController, :create
    # get "/topics/:id/edit", TopicController, :edit
    # put "/topics/:id", TopicController, :update
    # delete "/topics/:id", TopicController, :delete
    resources "/topics", TopicController
  end

  scope "/auth", Discuss do
    pipe_through :browser

    # route to AuthController.request function, which is inside the used Ueberauth-plug
    get "/signout", AuthController, :sign_out
    get "/:provider", AuthController, :request
    get "/:provider/callback", AuthController, :callback
  end

  # Other scopes may use custom stacks.
  # scope "/api", Discuss do
  #   pipe_through :api
  # end
end
