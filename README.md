
# middleman-importmap

[![Maintainability](https://api.codeclimate.com/v1/badges/aab4c3c09d920639f962/maintainability)](https://codeclimate.com/github/dvinciguerra/middleman-importmap/maintainability)

An Importmap extension for Middleman.


## Install

**Add gem to `Gemfile`**

`gem 'middleman-importmap'`


## Usage

#### Activate extension in `config.rb`**

```ruby
activate :importmap
```

#### Create the `importmap.yml` file at middleman root path

```shell
$ cd middleman_project && touch importmap.yml
```

#### Add importmaps to file (example)

```yaml
imports:
  "@hotwired/stimulus": https://unpkg.com/@hotwired/stimulus/dist/stimulus.js
```

The importmap.yml file keep the same structure of importmap in HTML


#### Replace default javascript tag by importmap

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

## Examples
- [Creating an app using Stimulus JS](#creating-an-app-using-stimulus-js)
- [Creating an app using React and React Router](#creating-an-app-using-react-and-react-router)


### Creating an app using Stimulus JS

#### Add the following code to `/source/javascripts/site.js`

```javascript
import { Application } from "@hotwired/stimulus"

import HelloController from "./controllers/hello_controller.js"

window.Stimulus = Application.start()
Stimulus.register("hello", HelloController)
```

#### Create `controllers` directory

```shell
$ mkdir -p source/javascripts/controllers
```

#### Now add HelloController at `controllers/hello_controller.js`

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

#### One last and important thing is add element binding at `index.html.erb`

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

### Creating an app using React and React Router

This example is based on [DHH's Youtube video presenting rails-importmap gem using React and htm](https://www.youtube.com/watch?v=k73LKxim6tw).

#### Change `importmap.yml` file to be like this

```yaml
---
imports:
  "htm": "https://ga.jspm.io/npm:htm@3.1.1/dist/htm.module.js"
  "react": "https://ga.jspm.io/npm:react@18.2.0/index.js"
  "react-dom": "https://ga.jspm.io/npm:react-dom@18.2.0/index.js"
  "react-router-dom": "https://ga.jspm.io/npm:react-router-dom@6.21.1/dist/main.js"
  "htm_create_element": "/javascripts/htm_create_element.js"

scopes:
  "https://ga.jspm.io/":
    "@remix-run/router": "https://ga.jspm.io/npm:@remix-run/router@1.14.1/dist/router.js"
    "react-router": "https://ga.jspm.io/npm:react-router@6.21.1/dist/main.js"
    "scheduler": "https://ga.jspm.io/npm:scheduler@0.23.0/index.js"
```

#### Create `source/javascripts/htm_create_element.js` file

This file is necessary to use htm with React in an environment that doesn't have build process of JSX files.

```javascript
import { createElement } from 'react'
import htm from 'htm'

export const h = htm.bind(createElement)
```

#### Create `components` and `pages` directories

```shell
mkdir -p source/javascripts/components && mkdir -p source/javascripts/pages 
```

#### Create `components/Page.js` file

Creating this file to avoid code duplication of components and demonstrate how to use composition in this environment.

```javascript
import { h } from "htm_create_element"

const Footer = () => h`
  <footer class="footer mt-auto py-3 bg-body-tertiary">
    <div class="container">
      <span class="text-body-secondary">
        Build by <a href="https://github.com/dvinciguerra">dvinciguerra<//> using <a href="https://github.com/dvinciguerra/middleman-importmap">middleman-importmap<//>.
      </span>
    </div>
  </footer>
`

const Container = ({ children }) => h`
  <main class="flex-shrink-0">
    <div class="container">
      ${children}
    </div>
  </main>

  <${Footer} />
`

const Title = ({ children }) => h`
  <h1 class="mt-5">${children}</h1>
`

const Lead = ({ children }) => h`
  <p class="lead">${children}</p>
`

export default {
  Container,
  Title,
  Lead
}
```


#### Create `pages/Home.js` file

Now, let's create the Home page using the components created above and react-router-dom `Link` component.


```javascript
import { h } from "htm_create_element"
import { Link } from "react-router-dom"

import Page from "../components/Page.js"
 
export default () => h`
  <${Page.Container}>
    <${Page.Title}>Middleman Importmap React<//>
    <${Page.Lead}>
      This is a simple page created using Middleman-importmap and React to demonstrate how it is possible to build
      frontends in Middleman using importmap without any build.
    <//>

    <hr class="my-4" />
    
    <p>
      <${Link}
        to="/getting-started"
        class="btn btn-dark btn-lg"
        role="button"
      >
        Getting Started
      <//>
      <a
        href="https://github.com/dvinciguerra/middleman-importmap"
        class="btn btn-secondary btn-lg ms-1"
        role="button"
        target="_new"
      >
        GitHub
      <//>
    </p>
  <//>
`
```

#### Create `pages/About.js` file

Creating just another page to demonstrate how to use react-router-dom `Link` behaviour.

```javascript
import { h } from "htm_create_element"
import { Link } from "react-router-dom"

import Page from "../components/Page.js"
 
export default () => h`
  <${Page.Container}>
    <${Page.Title}>About<//>
    <${Page.Lead}>
      This is a simple About page
    <//>

    <hr class="my-4" />
    
    <p>
      <${Link}
        to="/"
        class="btn btn-dark btn-lg"
        role="button"
      >
        Back
      <//>
    </p>
  <//>
```

#### Create `components/App.js` file

Creating a component to wrap all pages and use react-router-dom `RouterProvider` component.

```javascript
import { createBrowserRouter, RouterProvider } from 'react-router-dom'
import { h } from 'htm_create_element'

import Home from "../pages/Home.js"
import About from "../pages/About.js"

const router = createBrowserRouter([
  { path: '/', element: h`<${Home} />`  },
  { path: '/about', element: h`<${About} />` }
])

export default () => h`<${RouterProvider} router=${router} />`
```

#### Add the following code to `site.js`

```javascript
import { render } from 'react-dom'
import { h } from 'htm_create_element'

import App from "./components/App.js"

const root = document.getElementById('root')
render(h`<${App} />`, root)
```

#### Add the following code to `source/index.html.erb`

```ruby
---
title: Welcome to Middleman
---

<div id="root"></div>

```

If all things are OK, than start middleman server using command `bundle exec middleman server`, open your browser and
access [http://127.0.0.1:4567/](http://127.0.0.1:4567/).


## See more

- [Importmap polyfill at guybedford/es-module-shims](https://github.com/guybedford/es-module-shims)
- [Can I Use about Import Maps browser support](https://caniuse.com/import-maps)
- [W3C Import Maps Spec](https://wicg.github.io/import-maps/)
- [The helper tags are inspired by rails/importmap-rails gem](https://github.com/rails/importmap-rails)

## License

See `./LICENSE` file for more details.

## Author

Daniel Vinciguerra
