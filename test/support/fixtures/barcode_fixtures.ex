defmodule Barcodes.BarcodeFixtures do
  @moduledoc """
  This module defines test helpers for creating
  entities via the `Barcodes.Barcode` context.
  """

  @doc """
  Generate a code.
  """
  def code_fixture(attrs \\ %{}) do
    {:ok, code} =
      attrs
      |> Enum.into(%{
        barcode: "some barcode",
        product_description: "some product_description",
        product_name: "some product_name",
        status: "some status",
        uom: "some uom",
        user_id: 42,
        weight: "some weight"
      })
      |> Barcodes.Barcode.create_code()

    code
  end
end
