namespace :books do
  namespace :gutenberg do
    desc "import from gutenberg catalog file"
    task :import_from_catalog => :environment do      
      Gutenberg::Catalog::Parser.new(ENV['CATALOG_FILE']).books.each do |gb|
        Book.find_or_create_by_gutenberg_id(gb.book_id) do |book|
          book.title         = gb.title
          book.friendlytitle = gb.friendlytitle
          book.rights        = gb.rights
          book.publisher     = Publisher.find_or_create_by_name(gb.publisher)
        end
      end
    end

    desc "import meta data for all books"
    task :get_meta_data => :environment do
      Book.where("gutenberg_id IS NOT null").find_each do |book|
        gb = Gutenberg::Book.new(book.gutenberg_id)
        
        # Query gutenberg.org
        gb.get_data

        # Add the downloads
        gb.downloads.each do |gb_download|
          book.downloads.find_or_create_by_url(gb_download.url.truncate(255)) do |download|
            download.filesize = gb_download.extent
            download.last_modified = Date.parse(gb_download.modified)
            # TODO d.fileype = ...
          end  
        end
        
        # Add the author meta data
        author =  Author.find_or_create_by_gutenberg_id(gb.author.author_id) do |author|
                    author.name    = gb.author.name
                    author.alias   = gb.author.alias
                    author.webpage = gb.author.webpage
                    %w(birthdate deathdate).each do |date|
                      if gb.author.send(date).match(/\d\d\d\d/)
                        author.send("#{ date }=", Date.strptime(gb.author.send(date), "%Y")) 
                      end
                    end
                  end

        # Get the book language
        book.language ||= gb.language
        book.author = author
        book.save
      end
    end
  end
end