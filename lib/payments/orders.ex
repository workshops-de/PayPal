defmodule PayPal.Payments.Orders do
  @moduledoc """
  Documentation for PayPal.Payments.Orders

  https://developer.paypal.com/docs/api/orders/v2
  """

  @doc """
  Create an order

  [docs](https://developer.paypal.com/docs/api/orders/v2/#orders_create)

  Possible returns:

  - {:ok, order}
  - {:error, reason}

  ## Examples

    iex> PayPal.Payments.Orders.create(%{
      intent: "CAPTURE",
      payer: %{
        payment_method: "paypal"
      },
      purchase_units: [%{
        amount: %{
          total: "30.11",
          currency: "USD",
          details: %{
            subtotal: "30.00",
            tax: "0.07",
            shipping: "0.03",
            handling_fee: "1.00",
            shipping_discount: "-1.00",
            insurance: "0.01"
          }
        },
        description: "The payment transaction description.",
        custom: "EBAY_EMS_90048630024435",
        invoice_number: "48787589673",
        payment_options: %{
          allowed_payment_method: "INSTANT_FUNDING_SOURCE"
        },
        soft_descriptor: "ECHI5786786",
        item_list: %{
          items: [%{
            name: "hat",
            description: "Brown hat.",
            quantity: "5",
            price: "3",
            tax: "0.01",
            sku: "1",
            currency: "USD"
          },
          %{
            name: "handbag",
            description: "Black handbag.",
            quantity: "1",
            price: "15",
            tax: "0.02",
            sku: "product34",
            currency: "USD"
          }],
          shipping_address: %{
            recipient_name: "Brian Robinson",
            line1: "4th Floor",
            line2: "Unit #34",
            city: "San Jose",
            country_code: "US",
            postal_code: "95131",
            phone: "011862212345678",
            state: "CA"
          }
        }
      }
      ],
      application_context: %{}
    })
    {:ok, %{
      id: "PAY-1B56960729604235TKQQIYVY",
      create_time: "2017-09-22T20:53:43Z",
      update_time: "2017-09-22T20:53:44Z",
      state: "created",
      intent: "sale",
      payer: %{
        payment_method: "paypal"
      },
      transactions: [
        %{
          amount: %{
            total: "30.11",
            currency: "USD",
            details: %{
              subtotal: "30.00",
              tax: "0.07",
              shipping: "0.03",
              handling_fee: "1.00",
              insurance: "0.01",
              shipping_discount: "-1.00"
            }
          },
          description: "The payment transaction description.",
          custom: "EBAY_EMS_90048630024435",
          invoice_number: "48787589673",
          item_list: %{
            items: [
              %{
                name: "hat",
                sku: "1",
                price: "3.00",
                currency: "USD",
                quantity: "5",
                description: "Brown hat.",
                tax: "0.01"
              },
              %{
                name: "handbag",
                sku: "product34",
                price: "15.00",
                currency: "USD",
                quantity: "1",
                description: "Black handbag.",
                tax: "0.02"
              }
            ],
            shipping_address: %{
              recipient_name: "Brian Robinson",
              line1: "4th Floor",
              line2: "Unit #34",
              city: "San Jose",
              state: "CA",
              phone: "011862212345678",
              postal_code: "95131",
              country_code: "US"
            }
          }
        }
      ],
      links: [
        %{
          href: "https://api.sandbox.paypal.com/v1/payments/payment/PAY-1B56960729604235TKQQIYVY",
          rel: "self",
          method: "GET"
        },
        %{
          href: "https://api.sandbox.paypal.com/v1/payments//cgi-bin/webscr?cmd=_express-checkout&token=EC-60385559L1062554J",
          rel: "approval_url",
          method: "REDIRECT"
        },
        %{
          href: "https://api.sandbox.paypal.com/v1/payments/payment/PAY-1B56960729604235TKQQIYVY/execute",
          rel: "execute",
          method: "POST"
        }
      ]
    }}
  """
  @spec create(map) :: {atom, any}
  def create(params) do
    PayPal.API.post("v2/checkout/orders", params)
  end

  @doc """
  Show an order

  [docs](https://developer.paypal.com/docs/api/orders/v2/#orders_get)

  Possible returns:

  - {:ok, order}
  - {:error, reason}

  ## Examples

    iex> PayPal.Payments.Orders.show(order_id)
    {:ok, order}
  """
  @spec show(String.t()) :: {atom, any}
  def show(order_id) do
    PayPal.API.get("v2/checkout/orders/#{order_id}")
  end

  @doc """
  Update an order

  [docs](https://developer.paypal.com/docs/api/orders/v2/#orders_patch)

  Possible returns:

  - {:ok, order}
  - {:error, reason}

  ## Examples

    iex> PayPal.Payments.Orders.update(order_id, params)
    {:ok, order}
  """
  @spec update(String.t(), map) :: {atom, any}
  def update(order_id, params) do
    PayPal.API.patch("v2/checkout/orders/#{order_id}", params)
  end

  @doc """
  Authorize an order

  [docs](https://developer.paypal.com/docs/api/payments/#order_authorize)

  Possible returns:

  - {:ok, refund}
  - {:error, refund}

  ## Examples

    iex> PayPal.Payments.Orders.authorize(order_id, %{
      amount: %{
        total: "1.50",
        currency: "USD"
      }
    })
    {:ok, refund}
  """
  @spec authorize(String.t(), map) :: {atom, any}
  def authorize(payment_id, params) do
    PayPal.API.post("v2/checkout/orders/#{payment_id}/authorize", params)
  end

  @doc """
  Capture an order

  [docs](https://developer.paypal.com/docs/api/orders/v2/#orders_capture)

  Possible returns:

  - {:ok, capture}
  - {:error, refund}

  ## Examples

    iex> PayPal.Payments.Orders.capture(order_id)
    {:ok, capture}
  """
  @spec capture(String.t(), map) :: {atom, any}
  def capture(order_id, params) do
    PayPal.API.post("v2/checkout/orders/#{order_id}/capture", params)
  end
end
