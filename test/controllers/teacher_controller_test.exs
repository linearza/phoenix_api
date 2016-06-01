defmodule PhoenixApi.TeacherControllerTest do
  use PhoenixApi.ConnCase

  alias PhoenixApi.Teacher
  alias PhoenixApi.Repo

  @valid_attrs %{age: 42, name: "some content"}
  @invalid_attrs %{}

  setup do
    conn = conn()
      |> put_req_header("accept", "application/vnd.api+json")
      |> put_req_header("content-type", "application/vnd.api+json")

    {:ok, conn: conn}
  end
  
  defp relationships do
    %{}
  end

  test "lists all entries on index", %{conn: conn} do
    conn = get conn, teacher_path(conn, :index)
    assert json_response(conn, 200)["data"] == []
  end

  test "shows chosen resource", %{conn: conn} do
    teacher = Repo.insert! %Teacher{}
    conn = get conn, teacher_path(conn, :show, teacher)
    data = json_response(conn, 200)["data"]
    assert data["id"] == "#{teacher.id}"
    assert data["type"] == "teacher"
    assert data["attributes"]["name"] == teacher.name
    assert data["attributes"]["age"] == teacher.age
  end

  test "does not show resource and instead throw error when id is nonexistent", %{conn: conn} do
    assert_error_sent 404, fn ->
      get conn, teacher_path(conn, :show, -1)
    end
  end

  test "creates and renders resource when data is valid", %{conn: conn} do
    conn = post conn, teacher_path(conn, :create), %{
      "meta" => %{},
      "data" => %{
        "type" => "teacher",
        "attributes" => @valid_attrs,
        "relationships" => relationships
      }
    }

    assert json_response(conn, 201)["data"]["id"]
    assert Repo.get_by(Teacher, @valid_attrs)
  end

  test "does not create resource and renders errors when data is invalid", %{conn: conn} do
    conn = post conn, teacher_path(conn, :create), %{
      "meta" => %{},
      "data" => %{
        "type" => "teacher",
        "attributes" => @invalid_attrs,
        "relationships" => relationships
      }
    }

    assert json_response(conn, 422)["errors"] != %{}
  end

  test "updates and renders chosen resource when data is valid", %{conn: conn} do
    teacher = Repo.insert! %Teacher{}
    conn = put conn, teacher_path(conn, :update, teacher), %{
      "meta" => %{},
      "data" => %{
        "type" => "teacher",
        "id" => teacher.id,
        "attributes" => @valid_attrs,
        "relationships" => relationships
      }
    }

    assert json_response(conn, 200)["data"]["id"]
    assert Repo.get_by(Teacher, @valid_attrs)
  end

  test "does not update chosen resource and renders errors when data is invalid", %{conn: conn} do
    teacher = Repo.insert! %Teacher{}
    conn = put conn, teacher_path(conn, :update, teacher), %{
      "meta" => %{},
      "data" => %{
        "type" => "teacher",
        "id" => teacher.id,
        "attributes" => @invalid_attrs,
        "relationships" => relationships
      }
    }

    assert json_response(conn, 422)["errors"] != %{}
  end

  test "deletes chosen resource", %{conn: conn} do
    teacher = Repo.insert! %Teacher{}
    conn = delete conn, teacher_path(conn, :delete, teacher)
    assert response(conn, 204)
    refute Repo.get(Teacher, teacher.id)
  end

end
