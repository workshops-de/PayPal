defmodule PayPal.Mixfile do
  use Mix.Project

  def project do
    [
      app: :pay_pal,
      version: "0.0.2",
      elixir: "~> 1.5",
      build_embedded: Application.get_env(:pay_pal, :environment) == :prod,
      start_permanent: Application.get_env(:pay_pal, :environment) == :prod,
      description: description(),
      package: package(),
      test_coverage: [tool: ExCoveralls],
      deps: deps(),
      docs: [extras: ["README.md"], main: "readme"],
      dialyzer: [plt_add_deps: true]
    ]
  end

  def application do
    [
      extra_applications: [:logger, :httpoison],
      mod: {PayPal.Application, []}
    ]
  end

  defp deps do
    [
      {:httpoison, "~> 2.0"},
      {:poison, "~> 3.1"},
      {:oauth2, "~> 2.0"},
      {:exvcr, "~> 0.15", only: [:dev, :test]},
      {:ex_doc, "~> 0.23", only: [:dev, :docs]},
      {:excoveralls, "~> 0.10", only: [:dev, :test]},
      {:inch_ex, github: "rrrene/inch_ex", only: [:dev, :test]},
      {:credo, "~> 1.5", only: [:dev, :test], runtime: false},
      {:dialyxir, "~> 1.0", only: [:dev], runtime: false}
    ]
  end

  defp description do
    """
    Elixir library for working with the PayPal REST API.
    """
  end

  defp package do
    [
      licenses: ["MIT"],
      keywords: ["Elixir", "PayPal", "REST", "Payments", "API"],
      maintainers: ["Zen Savona"],
      links: %{
        "GitHub" => "https://github.com/zensavona/paypal",
        "Docs" => "https://hexdocs.pm/paypal"
      }
    ]
  end
end
