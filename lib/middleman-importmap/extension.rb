# frozen_string_literal: true

require "middleman-core"
require "moddleman-importmap/helpers"

module Middleman
  class ImportmapExtension < Extension
    option :entrypoint, "site", "define js entrypoint file"
    option :use_shim, true, "use importmapdefine js entrypoint file"

    def initialize(app, options_hash = {}, &block)
      super
    end

    def after_configuration; end

    helpers do
      include ::Middleman::Importmap::Helpers
    end
  end
end
