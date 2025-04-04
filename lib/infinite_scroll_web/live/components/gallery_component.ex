# infinite_scroll_web/live/components/gallery_component.ex
defmodule InfiniteScrollWeb.Components.GalleryComponent do
  use InfiniteScrollWeb, :live_component

  # * Remember any child element added to the page must have a unique identifier
  defp random_id, do: Enum.random(1..1_000_000)

  def render(assigns) do
    ~H"""
    <div>
      <div
        id="infinite-scroll-body"
        phx-update="append"
        class="grid grid-cols-3 gap-2"
      >
        <%= for image <- @images do %>
          <img id={"image-#{random_id()}"} src={image} />
        <% end %>
      </div>

    <div id="push-from-another-liveview">This Illustrates how</div>

      <div id="infinite-scroll-marker" phx-hook="InfiniteScroll" data-page={@page}></div>
    </div>
    """
  end

  def handle_event("nothing", params, socket) do
    dbg(params)
    {:noreply, socket}
  end
end
