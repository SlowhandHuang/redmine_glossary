require_dependency "redmine/wiki_formatting/textile/helper"

module Redmine
  module WikiFormatting
    module Textile
      module Helper

        def heads_for_wiki_formatter_with_glossary
          heads_for_wiki_formatter_without_glossary
          unless @heads_for_wiki_formatter_glossary_included
            content_for :header_tags do
              out = stylesheet_link_tag("termlink", :plugin => "redmine_glossary")
              out += javascript_tag <<-javascript_tag
              jsToolBar.prototype.elements.termlink = {
                type: 'button',
                title: '#{l(:label_tag_termlink)}',
                fn: {
                  wiki: function() { this.encloseSelection("{{term(", ")}}") }
                }
              }
              javascript_tag
              out
            end
            @heads_for_wiki_formatter_glossary_included = true
          end
        end

        alias_method_chain :heads_for_wiki_formatter, :glossary

      end
    end
  end
end
