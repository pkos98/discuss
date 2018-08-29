# by convention: singular form (not topics)
defmodule Discuss.TopicController do
  # elixir-way of code-sharing: importing functions defined (also imported) in Discuss.Web.controller/0
  # equivalent of OOP inheritance
  use Discuss.Web, :controller

  def new(conn, params) do
    IO.puts "++++"
    IO.inspect conn
    IO.puts "++++"
    IO.inspect params
  end

end
