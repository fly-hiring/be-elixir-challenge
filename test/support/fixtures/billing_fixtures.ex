defmodule Fly.BillingFixtures do
  @moduledoc """
  This module defines test helpers for creating
  entities via the `Fly.Billing` context.
  """

  @doc """
  Generate a invoice.
  """
  def invoice_fixture(attrs \\ %{}) do
    {:ok, invoice} =
      attrs
      |> Enum.into(%{
        due_date: ~D[2023-07-22],
        invoiced_at: ~U[2023-07-22 12:39:00Z],
        stripe_customer_id: "some stripe_customer_id",
        stripe_id: "some stripe_id"
      })
      |> Fly.Billing.create_invoice()

    invoice
  end
end
