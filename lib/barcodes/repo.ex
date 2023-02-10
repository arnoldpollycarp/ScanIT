defmodule Barcodes.Repo do
  use Ecto.Repo,
    otp_app: :barcodes,
    adapter: Ecto.Adapters.MyXQL
end
