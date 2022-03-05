
# middleman-importmap

An Importmap extension for Middleman.


## Install

**Add gem to `Gemfile`**

`gem 'middleman-importmap'`


## Usage

**Activate extension in `config.rb`**

```ruby
activate :importmap
```

**Create the `importmap.yml` file at middleman root path**

```shell
$ cd middleman_project && touch importmap.yml
```

**Add importmaps to file (example)**

```yaml
imports:
  "@hotwired/stimulus": https://unpkg.com/@hotwired/stimulus/dist/stimulus.js
```

The importmap.yml file keep the same structure of importmap in HTML


**Replace default javascript tag by importmap**

```ruby
<!doctype html>
<html>
  <head>
    <meta charset="utf-8">
    <meta http-equiv="x-ua-compatible" content="ie=edge">
    <meta name="viewport"
          content="width=device-width, initial-scale=1, shrink-to-fit=no">
    <!-- Use the title from a page's frontmatter if it has one -->
    <title><%= current_page.data.title || "Middleman" %></title>
    <%= stylesheet_link_tag "site" %>
    <%= javascript_importmap_tags %>
  </head>
  <body>
    <%= yield %>
  </body>
</html>

```

## Sample (using Stimulus JS)

**Add the following code to `/source/javascripts/site.js`**

```javascript
import { Application } from "@hotwired/stimulus"

import HelloController from "./controllers/hello_controller.js"

window.Stimulus = Application.start()
Stimulus.register("hello", HelloController)
```

**Create `/source/javascripts/controllers` directory**

```shell
$ mkdir -p source/javascripts/controllers
```

**Now add HelloController at `/source/javascripts/controllers/hello_controller.js`**

```javascript
import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  connect() {
    console.log("Hello, Stimulus!", this.element)
  }

  greet() {
    console.log("Clicked Greet Button")
  }
}
```

**One last and important thing is add element binding at `source/index.html.erb`**

```ruby
---
title: Welcome to Middleman
---

<h1>
  Middleman is Running
</h1>

<div data-controller="hello">
  <input type="text">
  <button data-action="click->hello#greet">Greet</button>
</div>

<%= link_to(
  "Read Documentation",
  "https://middlemanapp.com/basics/templating_language/",
  target: "_blank"
) %>
```

If all things are OK, than start middleman server using command `bundle exec middleman server` and open your browser devtools to see the messages.

## License

See `./LICENSE` file for more details.

## Author

Daniel Vinciguerra
