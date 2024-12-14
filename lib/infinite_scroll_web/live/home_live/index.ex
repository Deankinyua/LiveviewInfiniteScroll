# infinite_scroll_web/live/home_live/index.ex
defmodule InfiniteScrollWeb.HomeLive.Index do
  use InfiniteScrollWeb, :live_view

  alias InfiniteScrollWeb.Components.GalleryComponent

  @impl true
  def mount(_params, _session, socket) do
    # connected?(socket)
    # * The initial page number is 1
    # *  By using temporary assigns and phx-update,
    # * we don't need to keep anything in memory,
    # * and new elements will be appended to the UI only when there are new ones.
    {:ok,
     socket
     |> assign(page: 1), temporary_assigns: [images: []]}
  end

  # * Map destructuring in Elixir => %{assigns: assigns} = socket implemented as pattern matching
  # * Just like object destructuring in JavaScript

  @impl true
  def handle_event("load-more", _, %{assigns: assigns} = socket) do
    {:noreply, assign(socket, page: assigns.page + 1) |> get_images()}
  end

  defp get_images(%{assigns: %{page: page}} = socket) do
    socket
    |> assign(page: page)
    |> assign(images: images())
  end

  defp images do
    url = "/images/"

    ~W(
 1 2 3 4 5 6 7 8 9 10 11 12 13
    )
    |> Enum.map(&"#{url}image#{&1}.jpeg")
    |> Enum.shuffle()

    # "https://api.pexels.com/v1/photos/2014422"

    # dbg(images)

    # GzbgJpzeWPezpw9pbwjWAanFy4jgUnHwZywCgvzl6QSms3RLDF5vEbnx
  end
end
