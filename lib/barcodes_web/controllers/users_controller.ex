defmodule BarcodesWeb.UsersController do
  use BarcodesWeb, :controller

  alias Barcodes.Accounts
  alias Barcodes.Accounts.User

  plug :put_layout, "dashboard.html"

  def index(conn,_) do
    clients = Accounts.list_clients
    changeset = Accounts.change_user_registration(%User{})
    render(conn, "index.html", clients: clients, changeset: changeset)
  end

  def staff(conn, _) do
    staff = Accounts.list_staff
    changeset = Accounts.change_user_registration(%User{})
    render(conn, "staff.html", staff: staff, changeset: changeset)
  end

  def create(conn, %{"user" => user_params}) do
    case IO.inspect(Accounts.register_user(user_params)) do
      {:ok, _} ->
        conn
        |> put_flash(:info, "User created successfully.")
        |> redirect(to: Routes.users_path(conn, :index))
      {:error, _} ->
        conn
        |> put_flash(:error, "Something went wrong. Kindly Try again or Contact the Admin")
        |> redirect(to: Routes.users_path(conn, :index))
    end
  end

  def create_staff(conn, %{"user" => user_params}) do
    case IO.inspect(Accounts.register_user(user_params)) do
      {:ok, _} ->
        conn
        |> put_flash(:info, "User created successfully.")
        |> redirect(to: Routes.users_path(conn, :staff))
      {:error, _} ->
        conn
        |> put_flash(:error, "Something went wrong. Kindly Try again or Contact the Admin")
        |> redirect(to: Routes.users_path(conn, :staff))
    end
  end
end
