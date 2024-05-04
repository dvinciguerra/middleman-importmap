# frozen_string_literal: true

require 'erb'
require 'yaml'
require 'middleman-core'

module Middleman
  class ImportmapExtension < Extension
    option :entrypoint, 'site', 'define js entrypoint file'
    option :importmap, 'importmap.yml', 'define importmap file'
    option :use_shim, true, 'use ES module shim'
    option :shim_src, 'https://ga.jspm.io/npm:es-module-shims@1.8.2/dist/es-module-shims.js', 'define ES module shim source path'

    expose_to_template :javascript_importmap_tags,
                       :javascript_importmap_shim_tag,
                       :javascript_inline_importmap_tag,
                       :javascript_inline_module_tag 

    def initialize(app, options_hash = {}, &block)
      super
    end

    def after_configuration; end

    def javascript_importmap_tags(entrypoint = options.entrypoint, 
                                    importmap: options.importmap,
                                         shim: options.use_shim,
                                     shim_src: options.shim_src)
      [
        (javascript_importmap_shim_tag(shim_src) if shim),
        javascript_inline_importmap_tag(importmap, shim: shim),
        javascript_inline_module_tag(entrypoint, shim: shim)
      ].join
    end

    def javascript_importmap_shim_tag(shim_src = options.shim_src)
      template = File.join(File.dirname(__FILE__), 'views/javascript_importmap_shim_tag.html.erb')
      
      erb = ERB.new(File.read(template))
      erb.result_with_hash(src: shim_src)
    end

    def javascript_inline_importmap_tag(importmap = options.importmap, shim: options.use_shim)
      template = File.join(File.dirname(__FILE__), 'views/javascript_inline_importmap_tag.html.erb')
      importmap_config = load_importmap(File.join(app.root_path, importmap))

      erb = ERB.new(File.read(template))
      erb.result_with_hash(importmap: importmap_config, 
                                type: shim ? "importmap-shim" : "importmap")
    end

    def javascript_inline_module_tag(entrypoint = options.entrypoint, shim: options.use_shim)
      template = File.join(File.dirname(__FILE__), 'views/javascript_inline_module_tag.html.erb')
      
      erb = ERB.new(File.read(template))
      erb.result_with_hash(entrypoint: entrypoint, 
                                 type: shim ? "module-shim" : "module")
    end

    private

    def load_importmap(path)
      if path.end_with?('.yml', '.yaml')
        importmap = YAML.load_file(path, symbolize_names: true)
        JSON.pretty_generate(importmap)
      elsif path.end_with?('.json')
        File.read(path)
      else
        raise "Importmap format must be YAML or JSON"
      end
    end
  end
end
