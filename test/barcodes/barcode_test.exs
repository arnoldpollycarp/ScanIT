defmodule Barcodes.BarcodeTest do
  use Barcodes.DataCase

  alias Barcodes.Barcode

  describe "code" do
    alias Barcodes.Barcode.Code

    import Barcodes.BarcodeFixtures

    @invalid_attrs %{barcode: nil, product_description: nil, product_name: nil, status: nil, uom: nil, user_id: nil, weight: nil}

    test "list_code/0 returns all code" do
      code = code_fixture()
      assert Barcode.list_code() == [code]
    end

    test "get_code!/1 returns the code with given id" do
      code = code_fixture()
      assert Barcode.get_code!(code.id) == code
    end

    test "create_code/1 with valid data creates a code" do
      valid_attrs = %{barcode: "some barcode", product_description: "some product_description", product_name: "some product_name", status: "some status", uom: "some uom", user_id: 42, weight: "some weight"}

      assert {:ok, %Code{} = code} = Barcode.create_code(valid_attrs)
      assert code.barcode == "some barcode"
      assert code.product_description == "some product_description"
      assert code.product_name == "some product_name"
      assert code.status == "some status"
      assert code.uom == "some uom"
      assert code.user_id == 42
      assert code.weight == "some weight"
    end

    test "create_code/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Barcode.create_code(@invalid_attrs)
    end

    test "update_code/2 with valid data updates the code" do
      code = code_fixture()
      update_attrs = %{barcode: "some updated barcode", product_description: "some updated product_description", product_name: "some updated product_name", status: "some updated status", uom: "some updated uom", user_id: 43, weight: "some updated weight"}

      assert {:ok, %Code{} = code} = Barcode.update_code(code, update_attrs)
      assert code.barcode == "some updated barcode"
      assert code.product_description == "some updated product_description"
      assert code.product_name == "some updated product_name"
      assert code.status == "some updated status"
      assert code.uom == "some updated uom"
      assert code.user_id == 43
      assert code.weight == "some updated weight"
    end

    test "update_code/2 with invalid data returns error changeset" do
      code = code_fixture()
      assert {:error, %Ecto.Changeset{}} = Barcode.update_code(code, @invalid_attrs)
      assert code == Barcode.get_code!(code.id)
    end

    test "delete_code/1 deletes the code" do
      code = code_fixture()
      assert {:ok, %Code{}} = Barcode.delete_code(code)
      assert_raise Ecto.NoResultsError, fn -> Barcode.get_code!(code.id) end
    end

    test "change_code/1 returns a code changeset" do
      code = code_fixture()
      assert %Ecto.Changeset{} = Barcode.change_code(code)
    end
  end
end
