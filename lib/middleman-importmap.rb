# frozen_string_literal: true

require 'middleman-core'

Middleman::Extensions.register(:importmap) do
  require 'middleman-importmap/extension'
  Middleman::ImportmapExtension
end
