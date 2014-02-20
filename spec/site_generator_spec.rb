require 'spec_helper'

describe 'SiteGenerator' do
  let(:site_generator) { SiteGenerator.new }
  let(:file_name) {[
    "the_matrix.html",
    "the_lego_movie.html",
    "robocop.html",
    "the_wolf_of_wall_street.html",
    "frozen.html",
    "logan's_run.html",
    "a_fish_called_wanda.html",
    "the_godfather.html",
    "apocalypse_now.html",
    "the_sting.html",
    "temple_grandin.html",
    "gravity.html",
    "empire_of_the_sun.html",
    "the_big_lebowski.html",
    "pan's_labyrinth.html",
    "unbreakable.html",
    "gattaca.html",
    "the_dark_knight.html",
    "donnie_darko.html",
    "rescue_dawn.html",
    "the_prestige.html",
    "memento.html",
    "avatar.html",
    "killing_them_softly.html",
    "300.html"
  ]}

  before do
    Movie.reset_movies!
    Movie.make_movies!
  end

  describe '#make_index!' do
    it 'creates index.html in the _site directory' do
      site_generator.make_index!
      comparison = File.read('spec/fixtures/index.html')
      index = File.read('_site/index.html')
      expect(index).to eq(comparison)
    end

    it 'does NOT use erb' do
      expect(ERB).to_not receive(:new)
      site_generator.make_index!
    end
  end

  describe '#generate_pages!' do
    it 'creates an html page for each movie in the _site/movies directory' do
      site_generator.generate_pages!
      expect(Dir.entries('_site/movies').reject{|e| e.start_with?('.')}.size).to eq(25)
    end

    it 'makes html pages that follow a specific layout' do
      site_generator.generate_pages!
      the_matrix = File.read('_site/movies/the_matrix.html')
      comparison = File.read('spec/fixtures/the_matrix.html')
      expect(the_matrix).to eq(comparison)
    end

    it 'uses ERB' do
      expect(ERB).to receive(:new)
      expect_any_instance_of(ERB).to receive(:result)
      site_generator.generate_pages!
    end
  end
end