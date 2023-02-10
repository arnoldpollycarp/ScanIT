defmodule BarcodesWeb.DashboardController do
  use BarcodesWeb, :controller

  plug :put_layout, "dashboard.html"

  def index(conn, _params) do
    render(conn, "index.html")
  end
end
