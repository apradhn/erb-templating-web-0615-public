class Movie
  attr_accessor :title, :release_date, :director, :summary
  @@all = []

  def initialize(title, release_date, director, summary)
    @title = title
    @release_date = release_date
    @director = director
    @summary = summary
    @@all << self
  end

  def url
    url_title = @title.split(" ").collect{|s| s.downcase}.join("_")
    url_title + ".html"
  end

  def self.all
    @@all
  end

  def self.reset_movies!
    @@all.clear
  end

  def self.make_movies!
    # parses a file with a list of movies into movie instances
    File.open("./spec/fixtures/movies.txt").each do |line|
      data = line.split(" - ")
      title = data[0]
      release_date = data[1].to_i
      director = data[2]
      summary = data[3]
      Movie.new(title, release_date, director, summary)
    end
  end

  def self.recent
    # returns movies released during or after 2012
    self.all.select{|movie| movie.release_date >= 2012}
  end
end

