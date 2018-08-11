#### Routing
* `web/router.ex` contains the routing logic
* `get "/", PageController, :index` means _"Every HTTP-GET request to '/' invokes `PageController.index\2`"_

#### Rendering
* The `PageController` typically invokes the `PageView.render/2` function, here in `PageView.index/2`
* The `PageView` is responsible for rendering, thus containing the `render/2` function
    * `render/2` merges the `web/templates/page/index.html.eex` witht the appropiate `web/templates/layout`
    and returns the rendered html as string as part of the `Conn` struct

#### Migrations
* In order to document and reliably reproduce/rollback database changes (like schema), Phoenix provides so called `migrations`
* A `migration` is a an elixir-script (`.exs`) which changes the database (adds tables, alters schemas etc...)