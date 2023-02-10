defmodule BarcodesWeb.BarcodesController do
  use BarcodesWeb, :controller
  alias Phoenix.LiveView.Route
  alias Barcodes.Barcode
  alias Barcodes.Barcode.Code
  alias Barcodes.Accounts
  alias Barcodes.Repo

  plug :put_layout, "dashboard.html"

  def action(conn, _) do
    apply(__MODULE__, action_name(conn), [conn, conn.params, conn.assigns.current_user])
  end

  def listing(number, zero) do
    number
    |> Enum.chunk_every(1)
    |> Enum.map(fn [a] -> zero <> to_string(a) end)
end

  def index(conn, _params, current_user) do
    changeset = Barcode.change_code(%Code{})
    list_of_users = Accounts.list_clients_barcodes()
    barcodes =
      if current_user.user_type == "admin" do
        Barcode.list_code()
      else
        Barcode.list_code(current_user.id)
      end
    render(conn, "index.html", changeset: changeset, list_of_users: list_of_users,
    barcodes: barcodes)
  end

  def create(conn, %{"product_name" => product_name, "weight" => weight, "uom" => uom,
  "product_description" => product_description, "code" => %{"user_id" => user_id}}, current_user) do
    prefix = "727800" <> current_user.id_number
    barcodes = Enum.concat(Enum.map(listing(1..9, "00") ++ listing(10..99, "0"),
    fn x -> (ExGtin.generate!(prefix <> to_string(x) )) end),
    Enum.map(Enum.to_list(100..999), fn x -> (ExGtin.generate!(prefix <> to_string(x) )) end))

    list_barcodes =
      barcodes
      |> Enum.chunk_every(1)
      |> Enum.map(fn [a] -> %{"barcode" => a} end)

    list_prod_name =
      product_name
      |> Enum.chunk_every(1)
      |> Enum.map(fn [b] -> %{"product_name" => b} end)

    list_prod_desc =
      product_description
      |> Enum.chunk_every(1)
      |> Enum.map(fn [c] -> %{"product_description" => c} end)

    list_prod_uom =
      uom
      |> Enum.chunk_every(1)
      |> Enum.map(fn [d] -> %{"uom" => d} end)

    list_prod_weight =
      weight
      |> Enum.chunk_every(1)
      |> Enum.map(fn [e] -> %{"weight" => e} end)

    list =
      Enum.map( for {a, b, c, d, e} <- Enum.zip([list_barcodes, list_prod_name, list_prod_desc, list_prod_uom, list_prod_weight]) do
        Enum.concat([a, b, c, d, e])
      end,
      fn x ->
        Enum.into(x, %{"client_id"=> user_id, "user_id"=> current_user.id, "status" => "Active"})
      end
      )

    changesets =
      Enum.map(list, fn code ->
        Code.changeset(%Code{}, code) end)

    result =
      changesets
      |> Enum.with_index()
      |> Enum.reduce(Ecto.Multi.new(), fn {changeset, index}, multi ->
        Ecto.Multi.insert(multi, Integer.to_string(index), changeset)
      end)
      |> Repo.transaction()


    case result do
      {:ok, _} ->
        conn
        |> put_flash(:info, "Product details Have been Barcoded Successfully")
        |> redirect(to: Routes.barcodes_path(conn, :index))
      {:error, _} ->
        conn
        |> put_flash(:error, "Something went wrong. Kindly Try again")
        |> redirect(to: Routes.barcodes_path(conn, :index))
    end

  end

  def edit_barcodes(conn, %{"code" => code_params}, current_user) do
    code = Barcode.get_code!(code_params["id"])

    if current_user.user_type == "client" do
      conn
      |> put_flash(:error, "You Are Not Authorized To Edit a Product. Contact Admin for help")
      |> redirect(to: Routes.barcodes_path(conn, :index))
    else
      case Barcode.update_code(code, code_params) do
        {:ok, _} ->
          conn
          |> put_flash(:info, "Product Details Updated Successfully")
          |> redirect(to: Routes.barcodes_path(conn, :index))
        {:error, _} ->
          conn
          |> put_flash(:error, "Something went wrong kindly contact admin.")
          |> redirect(to: Routes.barcodes_path(conn, :index))
      end
    end
  end

  def delete(conn, %{"id"=>id}, current_user) do
    code = Barcode.get_code!(id)
    if current_user.user_type == "client" do
      conn
      |> put_flash(:error, "You Are Not Authorized To Delete a Product. Contact Admin for help")
      |> redirect(to: Routes.barcodes_path(conn, :index))
    else
      Repo.delete(code)
      conn
      |> put_flash(:info, "Deleted")
      |> redirect(to: Routes.barcodes_path(conn, :index))
    end
  end
end
