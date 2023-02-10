defmodule Barcodes.Repo.Migrations.CreateCode do
  use Ecto.Migration

  def change do
    create table(:code) do
      add :barcode, :string
      add :status, :string
      add :user_id, :integer
      add :product_name, :string
      add :product_description, :string
      add :uom, :string
      add :weight, :string

      timestamps()
    end
  end
end
