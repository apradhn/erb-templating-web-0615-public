require "movie.rb"

class SiteGenerator

  def make_index!

    html = "<!DOCTYPE html><html><head><title>Movies</title></head><body><ul>"
    Movie.all.each do |movie|
      html += "<li>"
      html += "<a href=\"movies/#{movie.url}\">"
      html += movie.title
      html += "</a>"
      html += "</li>"
    end
    html += "</ul></body></html>"
    File.write("_site/index.html", html)
  end

  def generate_pages!
    # creates an html page for each movie 
    # in the _site/movies directory
    reset_dir
    require "erb"
    html = File.read("./views/movies/show.html.erb")
    template = ERB.new(html)

    Movie.all.each do |movie|
      @movie = movie
      @all_movies = Movie.all
      result = template.result(binding)
      File.write("_site/movies/#{movie.url}", result)
    end

  end

  def reset_dir
    FileUtils.rm_rf("_site/movies")
    FileUtils.mkdir_p("_site/movies")
  end
end