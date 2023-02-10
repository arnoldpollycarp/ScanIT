defmodule Barcodes.Barcode.Code do
  use Ecto.Schema
  import Ecto.Changeset

  schema "code" do
    field :barcode, :string
    field :product_description, :string
    field :product_name, :string
    field :status, :string
    field :uom, :string
    field :user_id, :integer
    field :weight, :string
    field :client_id, :integer

    timestamps()
  end

  @doc false
  def changeset(code, attrs) do
    code
    |> cast(attrs, [:barcode, :status, :user_id, :product_name, :product_description, :uom, :weight, :client_id])
    |> validate_required([:barcode, :status, :user_id, :product_name, :product_description, :uom, :weight])
  end
end
