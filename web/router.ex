defmodule Bbb.Router do
  use Bbb.Web, :router

  pipeline :browser do
    plug :accepts, ["html"]
    plug :fetch_session
    plug :fetch_flash
    plug :protect_from_forgery
    plug :put_secure_browser_headers
  end

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/", Bbb do
    pipe_through :browser # Use the default browser stack

    get "/", PageController, :index
    resources "/users", UserController, only: [:new, :create, :delete]
    resources "/books", BookController
    resources "/sessions", SessionController, only: [:new, :create, :delete]

    get "/login", SessionController, :new
    get "/signup", UserController, :new
  end

  # Other scopes may use custom stacks.
  # scope "/api", Bbb do
  #   pipe_through :api
  # end
end
