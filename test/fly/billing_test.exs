defmodule Fly.BillingTest do
  use Fly.DataCase

  alias Fly.Billing

  describe "invoices" do
    alias Fly.Billing.Invoice

    import Fly.BillingFixtures

    @invalid_attrs %{due_date: nil, invoiced_at: nil, stripe_customer_id: nil, stripe_id: nil}

    test "list_invoices/0 returns all invoices" do
      invoice = invoice_fixture()
      assert Billing.list_invoices() == [invoice]
    end

    test "get_invoice!/1 returns the invoice with given id" do
      invoice = invoice_fixture()
      assert Billing.get_invoice!(invoice.id) == invoice
    end

    test "create_invoice/1 with valid data creates a invoice" do
      valid_attrs = %{due_date: ~D[2023-07-22], invoiced_at: ~U[2023-07-22 12:39:00Z], stripe_customer_id: "some stripe_customer_id", stripe_id: "some stripe_id"}

      assert {:ok, %Invoice{} = invoice} = Billing.create_invoice(valid_attrs)
      assert invoice.due_date == ~D[2023-07-22]
      assert invoice.invoiced_at == ~U[2023-07-22 12:39:00Z]
      assert invoice.stripe_customer_id == "some stripe_customer_id"
      assert invoice.stripe_id == "some stripe_id"
    end

    test "create_invoice/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Billing.create_invoice(@invalid_attrs)
    end

    test "update_invoice/2 with valid data updates the invoice" do
      invoice = invoice_fixture()
      update_attrs = %{due_date: ~D[2023-07-23], invoiced_at: ~U[2023-07-23 12:39:00Z], stripe_customer_id: "some updated stripe_customer_id", stripe_id: "some updated stripe_id"}

      assert {:ok, %Invoice{} = invoice} = Billing.update_invoice(invoice, update_attrs)
      assert invoice.due_date == ~D[2023-07-23]
      assert invoice.invoiced_at == ~U[2023-07-23 12:39:00Z]
      assert invoice.stripe_customer_id == "some updated stripe_customer_id"
      assert invoice.stripe_id == "some updated stripe_id"
    end

    test "update_invoice/2 with invalid data returns error changeset" do
      invoice = invoice_fixture()
      assert {:error, %Ecto.Changeset{}} = Billing.update_invoice(invoice, @invalid_attrs)
      assert invoice == Billing.get_invoice!(invoice.id)
    end

    test "delete_invoice/1 deletes the invoice" do
      invoice = invoice_fixture()
      assert {:ok, %Invoice{}} = Billing.delete_invoice(invoice)
      assert_raise Ecto.NoResultsError, fn -> Billing.get_invoice!(invoice.id) end
    end

    test "change_invoice/1 returns a invoice changeset" do
      invoice = invoice_fixture()
      assert %Ecto.Changeset{} = Billing.change_invoice(invoice)
    end
  end
end
