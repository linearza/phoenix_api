defmodule PhoenixApi.Repo.Migrations.CreateTeacher do
  use Ecto.Migration

  def change do
    create table(:teachers) do
      add :name, :string
      add :age, :integer

      timestamps
    end

  end
end
