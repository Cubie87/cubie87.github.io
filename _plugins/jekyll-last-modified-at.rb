# _plugins/jekyll-last-modified-at.rb
module Jekyll
    class LastModifiedAt < Liquid::Tag
      def initialize(tag_name, file, tokens)
        super
        @file = file
      end
  
      def render(context)
        site = context.registers[:site]
        page = site.pages.find { |p| p.url == @file }
  
        if page
          last_modified = page.last_modified_at
          formatted_date = last_modified.strftime(site.config['last_modified_at']['date_format'])
          formatted_time = last_modified.strftime(site.config['last_modified_at']['time_format'])
  
          "#{formatted_date} #{formatted_time}"
        else
          "File not found: #{@file}"
        end
      end
    end
  end
  
  Liquid::Template.register_tag('last_modified_at', Jekyll::LastModifiedAt)
  