# frozen_string_literal: true

require "erb"
require "yaml"
require "middleman-core"

module Middleman
  class ImportmapExtension < Extension
    option :entrypoint, "site", "define js entrypoint file"
    option :use_shim, true, "use importmapdefine js entrypoint file"

    def initialize(app, options_hash = {}, &block)
      super
    end

    def after_configuration; end

    helpers do
      def javascript_importmap_tags(entrypoint = "site", shim: true)
        [
          javascript_importmap_shim_tag,
          javascript_inline_importmap_tag,
          javascript_inline_module_tag(entrypoint),
        ].join
      end

      def javascript_importmap_shim_tag
        template = File.join(File.dirname(__FILE__), "views/javascript_impotmap_shim_tag.html.erb")
        erb = ERB.new(File.read(template))
        erb.result
      end

      def javascript_inline_importmap_tag(importmap = "importmap.yml")
        template = File.join(File.dirname(__FILE__), "views/javascript_inline_impotmap_tag.html.erb")
        importmap_config = YAML.load_file(File.join(app.root_path, importmap), symbolize_names: true)

        erb = ERB.new(File.read(template))
        erb.result_with_hash(importmap: importmap_config)
      end

      def javascript_inline_module_tag(entrypoint)
        template = File.join(File.dirname(__FILE__), "views/javascript_inline_module_tag.html.erb")
        erb = ERB.new(File.read(template))
        erb.result_with_hash(entrypoint: entrypoint)
      end
    end
  end
end
