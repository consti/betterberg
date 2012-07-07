namespace :books do
  namespace :gutenberg do
    desc "import from gutenberg catalog file"
    task :import_from_catalog => :environment do      
      Gutenberg::Catalog::Parser.new(ENV['CATALOG_FILE']).books.each do |book|
        Author.find_or_create_by_name(book.creator).
          books.find_or_create_by_gutenberg_id(book.book_id) do |b|
            b.title         = book.title
            b.friendlytitle = book.friendlytitle
            b.rights        = book.rights
            b.publisher     = Publisher.find_or_create_by_name(book.publisher)
          end
      end  
    end

    desc "import meta data for all books"
    task :get_meta_data => :environment do
      Book.where("gutenberg_id IS NOT null").find_each do |book|
        b = Gutenberg::Book.new(book.gutenberg_id)
        
        # Query gutenberg.org
        b.get_data

        # Get the book language
        book.language ||= b.language
        book.save

        # Add the downloads
        b.downloads.each do |download|
          book.downloads.find_or_create_by_url(download.url) do |d|
            d.filesize = download.extent
            d.last_modified = Date.parse(download.modified)
            # TODO d.fileype = ...
          end  
        end
        
        # Add the author meta data
        author = book.author
        author.name         ||= b.author.name
        author.alias        ||= b.author.alias

        %w(birthdate deathdate).each do |date|
          if b.author.send(date).match(/\d\d\d\d/)
            author.send("#{ date }=", Date.strptime(b.author.send(date), "%Y")) 
          end
        end
        author.webpage      ||= b.author.webpage
        author.gutenberg_id ||= b.author.author_id
        author.save
      end
    end
  end
end