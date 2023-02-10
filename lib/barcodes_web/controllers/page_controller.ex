defmodule BarcodesWeb.PageController do
  use BarcodesWeb, :controller

  def index(conn, _params) do
    render(conn, "index.html")
  end
end
