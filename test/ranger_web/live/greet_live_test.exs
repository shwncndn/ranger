defmodule RangerWeb.GreetLiveTest do

  # used same as in controller tests.
  # conn struct is needed in every test to mount the live view.
  use RangerWeb.ConnCase

  # brings in all of the helper functions needed to mount,
  # interact with, and assert things about the live view.
  import Phoenix.LiveViewTest

  # checks the disconnected state of the live view
  # conn variable pattern matches on :conn value from the test context
  test "rendering disconnected state", %{conn: conn} do
    disconnected = conn |> get(~p"/greet")

    # asserts that the returned HTML contains text
    assert html_response(disconnected, 200) =~ "Welcome to stateless HTTP"
  end

  # checks that HTML is returned from connected state
  test "upgrading to connected state", %{conn: conn} do
    disconnected = conn |> get(~p"/greet")
    # live/2 helper function upgrades connection
    {:ok, _view, html} = live(disconnected)

    # asserts that the returned HTML string contains text
    assert html =~ "Welcome to Testing LiveView"
  end

  # stateless HTTP request/response not typically tested
  # simplify by using live/2 and pass path as second argument
  test "rendering connected state", %{conn: conn} do

    # live/2 performs stateless request behind the scenes
    # then upgrades the connection
    # then returns connected HTML as the third element of the tuple
    {:ok, _view, html} = live(conn, ~p"/greet")

    assert html =~ "Welcome to Testing LiveView"
  end

  test "rendering with the view", %{conn: conn} do
    {:ok, view, _html} = live(conn, "/greet")

  # the view contains:

    # the module being tested
    assert view.module == RangerWeb.GreetLive

    # the process ID of the LiveView
    assert is_pid(view.pid)

    # view passed to render function to render HTML on the page
    assert render(view) =~ "Welcome to Testing LiveView"
  end

end
