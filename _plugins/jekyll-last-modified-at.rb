# _plugins/jekyll-last-modified-at.rb
module Jekyll
    class LastModifiedAt < Liquid::Tag
      def render(context)
        page = context.registers[:page]
  
        if page
          last_modified = page["last_modified_at"] || page["date"] || page["published_at"] || page["created_at"] || File.mtime(page["path"])
          formatted_date = last_modified.strftime(context.registers[:site].config['last_modified_at']['date_format'])
          formatted_time = last_modified.strftime(context.registers[:site].config['last_modified_at']['time_format'])
  
          "#{formatted_date} #{formatted_time}"
        else
          "Page not found"
        end
      end
    end
  end
  
  Liquid::Template.register_tag('last_modified_at', Jekyll::LastModifiedAt)
  