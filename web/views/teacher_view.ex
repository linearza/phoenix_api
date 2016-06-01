defmodule PhoenixApi.TeacherView do
  use PhoenixApi.Web, :view
  use JaSerializer.PhoenixView

  attributes [:name, :age, :inserted_at, :updated_at]
  

end
