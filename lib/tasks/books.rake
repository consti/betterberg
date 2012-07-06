namespace :books do
  namespace :gutenberg do
    desc "import from gutenberg catalog file"
    task :import => :environment do      
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
  end
end