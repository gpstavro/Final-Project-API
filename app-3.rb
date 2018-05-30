require 'uri'
require 'net/http'
require 'json'

 
  puts "What topic would you like to search for?"
  
  search = $stdin.gets.chomp
  
  puts "What would you like photos, publishing dates, headline, biography, word count, source, articles, or headlines and articles?"
  puts "*please type it in exactly as it is written"
  
  result = $stdin.gets.chomp
  
  uri = URI("https://api.nytimes.com/svc/search/v2/articlesearch.json")
  http = Net::HTTP.new(uri.host, uri.port)
  http.use_ssl = true
  uri.query = URI.encode_www_form({
    "api-key" => "d4c8e20ab3134c6d9aa3d20c1a1d084e",
    "q" => search,
    "sort" => "newest"
  })
  request = Net::HTTP::Get.new(uri.request_uri)
  @result = JSON.parse(http.request(request).body, {:symbolize_names => true})

  
  if result == 'photos'
    
    @result[:response][:docs].each do |doc|
      if doc[:multimedia][0]
        puts "https://static01.nyt.com/" + doc[:multimedia][0][:url]
      end
    end
  elsif result == 'publishing dates'
    @result[:response][:docs].each do |doc|
      if doc[:pub_date]
         puts doc[:pub_date]
      end
    end
    
  elsif result == "articles"
        
      @result[:response][:docs].each do |doc|
        if doc[:web_url]
         puts doc[:web_url]
        end
    end
  elsif result == "biography"
      @result[:response][:docs].each do |doc|
        if doc[:snippet]
          puts doc[:snippet]
        end
      end
  elsif result == "headline"
    @result[:response][:docs].each do |doc|
        if doc[:headline]
          print "title: "
          puts doc[:headline][:main]
        end
    end
  
  elsif result == "word count"
    @result[:response][:docs].each do |doc|
        if doc[:word_count]
          puts "This is in one article"
          print "# of words in this article: "
          puts doc[:word_count]
        end
    end
    
  elsif result == "source"
    @result[:response][:docs].each do |doc|
        if doc[:source]
          print "The source for is: "
          puts doc[:source]
        end
    end
  elsif result == "headlines and articles"
        @result[:response][:docs].each do |doc|
        if doc[:headline]
          print "title: "
          puts doc[:headline][:main]
        end
        if doc[:web_url]
         puts doc[:web_url]
        end
    end
  end

