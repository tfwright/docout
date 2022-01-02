import Config

config :docout,
  app_name: :docout,
  formatters: [Docout.Formatters.Demo]

config :docout, Docout.Formatters.Demo,
  output_path: "docs/demo.md"
