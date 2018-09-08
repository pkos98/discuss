defmodule Discuss.LayoutView do
  use Discuss.Web, :view

  def get_name(user) do
    if user.nickname, do: user.nickname, else: user.email
  end
end
