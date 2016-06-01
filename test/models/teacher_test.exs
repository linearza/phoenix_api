defmodule PhoenixApi.TeacherTest do
  use PhoenixApi.ModelCase

  alias PhoenixApi.Teacher

  @valid_attrs %{age: 42, name: "some content"}
  @invalid_attrs %{}

  test "changeset with valid attributes" do
    changeset = Teacher.changeset(%Teacher{}, @valid_attrs)
    assert changeset.valid?
  end

  test "changeset with invalid attributes" do
    changeset = Teacher.changeset(%Teacher{}, @invalid_attrs)
    refute changeset.valid?
  end
end
