ExUnit.start

Mix.Task.run "ecto.create", ~w(-r PhoenixApi.Repo --quiet)
Mix.Task.run "ecto.migrate", ~w(-r PhoenixApi.Repo --quiet)
Ecto.Adapters.SQL.begin_test_transaction(PhoenixApi.Repo)

