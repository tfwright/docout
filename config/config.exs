import Config

config :docout,
  app_name: :docout,
  formatters: [Docout.Demo.Formatter]

config :docout, Docout.Demo.Formatter, output_path: "docs/demo.md"
