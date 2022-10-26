defmodule ApiPhoenixWeb.Router do
  use ApiPhoenixWeb, :router

  pipeline :browser do
    plug :accepts, ["html"]
    plug :fetch_session
    plug :fetch_live_flash
    plug :put_root_layout, {ApiPhoenixWeb.LayoutView, :root}
    plug :protect_from_forgery
    plug :put_secure_browser_headers
  end

  pipeline :csrf do
    plug :protect_from_forgery
  end

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/", ApiPhoenixWeb do
    pipe_through [:browser, :csrf]

    get "/", PageController, :index
    resources "/users", UsersController, except: [:new, :edit]
  end

  # Other scopes may use custom stacks.
  # scope "/api", ApiPhoenixWeb do
  #   pipe_through :api
  # end

  # Enables LiveDashboard only for development
  #
  # If you want to use the LiveDashboard in production, you should put
  # it behind authentication and allow only admins to access it.
  # If your application does not have an admins-only section yet,
  # you can use Plug.BasicAuth to set up some basic authentication
  # as long as you are also using SSL (which you should anyway).
  if Mix.env() in [:dev, :test] do
    import Phoenix.LiveDashboard.Router

    scope "/" do
      pipe_through :browser

      live_dashboard "/dashboard", metrics: ApiPhoenixWeb.Telemetry
    end
  end

  # Enables the Swoosh mailbox preview in development.
  #
  # Note that preview only shows emails that were sent by the same
  # node running the Phoenix server.
  if Mix.env() == :dev do
    scope "/dev" do
      pipe_through :browser

      forward "/mailbox", Plug.Swoosh.MailboxPreview
    end
  end
end
# defmodule Foo.Router do
#   use Foo.Web, :router

#   pipeline :browser do
#     plug :accepts, ["html"]
#     plug :fetch_session
#     plug :fetch_flash
#     #plug :protect_from_forgery - move this
#   end

#   pipeline :csrf do
#     plug :protect_from_forgery # to here
#   end

#   pipeline :api do
#     plug :accepts, ["json"]
#   end

#   scope "/", Foo do
#     pipe_through [:browser, :csrf] # Use both browser and csrf pipelines

#     get "/", PageController, :index
#   end

#   scope "/", Foo do
#     pipe_through :browser # Use only the browser pipeline

#     get "/facebook", PageController, :index #You can use the same controller and actions if you like
#   end

# end
