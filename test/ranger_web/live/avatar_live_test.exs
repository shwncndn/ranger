defmodule RangerWeb.AvatarLiveTest do
  use RangerWeb.ConnCase

  import Phoenix.LiveViewTest

  alias Ranger.Gravatar

  test "renders avatar for given email", %{conn: conn} do
    email = "shawn@condon.com"
    avatar = Gravatar.generate(email)
    {:ok, _view, html} = live(conn, ~p"/avatar/#{email}")

    assert html =~ avatar_url
  end

end
