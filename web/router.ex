defmodule PhoenixApi.Router do
  use PhoenixApi.Web, :router

  pipeline :api do
    plug :accepts, ["json-api"]
  end

  scope "/api", PhoenixApi do
    pipe_through :api
    resources "/teachers", TeacherController, except: [:new, :edit]
  end
end