# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

Movie.create!([
  {
    title: 'Avengers: Endgame',
    description:
    %{
      After the devastating events of Avengers: Infinity War, the universe
      is in ruins. With the help of remaining allies, the Avengers assemble
      once more in order to undo Thanos' actions and restore order to the universe.
    }.squish,
    released_on: "2019-04-26",
    rating: 'PG-13',
    total_gross: 1_223_641_414,
    director: 'Anthony Russo',
    duration: '181 min',
    image_file_name: 'avengers-end-game.png'
  },
  {
    title: 'Captain Marvel',
    description:
    %{
      Carol Danvers becomes one of the universe's most powerful heroes when Earth is caught in the middle of a galactic war between two alien races.
    }.squish,
    released_on: "2019-03-08",
    rating: 'PG-13',
    total_gross: 1_110_662_849,
    director: 'Anna Boden',
    duration: '124 min',
    image_file_name: 'captain-marvel.png'
  },
  {
    title: 'Black Panther',
    description:
    %{
      T'Challa, heir to the hidden but advanced kingdom of Wakanda, must step forward to lead his people into a new future and must confront a challenger from his country's past.
    }.squish,
    released_on: "2018-02-16",
    rating: 'PG-13',
    total_gross: 1_346_913_161,
    director: 'Ryan Coogler',
    duration: '134 min',
    image_file_name: 'black-panther.png'
  },
  {
    title: 'Avengers: Infinity War',
    description:
    %{
      The Avengers and their allies must be willing to sacrifice all in an attempt to defeat the powerful Thanos before his blitz of devastation and ruin puts an end to the universe.
    }.squish,
    released_on: "2018-04-27",
    rating: 'PG-13',
    total_gross: 2_048_359_754,
    director: 'Anthony Russo',
    duration: '149 min',
    image_file_name: 'avengers-infinity-war.png'
  },
  {
    title: 'Green Lantern',
    description:
    %{
      Reckless test pilot Hal Jordan is granted an alien ring that bestows him with otherworldly powers that inducts him into an intergalactic police force, the Green Lantern Corps.
    }.squish,
    released_on: "2011-06-17",
    rating: 'PG-13',
    total_gross: 219_851_172,
    director: 'Martin Campbell',
    duration: '114 min',
    image_file_name: 'green-lantern.png'
  },
  {
    title: 'Fantastic Four',
    description:
    %{
      Four young outsiders teleport to an alternate and dangerous universe which alters their physical form in shocking ways. The four must learn to harness their new abilities and work together to save Earth from a former friend turned enemy.
    }.squish,
    released_on: "2015-08-07",
    rating: 'PG-13',
    total_gross: 168_257_860,
    director: 'Josh Trank',
    duration: '100 min',
    image_file_name: 'fantastic-four.png'
  },
  {
    title: 'Iron Man',
    description:
    %{
      When wealthy industrialist Tony Stark is forced to build an
      armored suit after a life-threatening incident, he ultimately
      decides to use its technology to fight against evil.
    }.squish,
    released_on: "2008-05-02",
    rating: 'PG-13',
    total_gross: 585_366_247,
    director: 'Jon Favreau',
    duration: '126 min',
    image_file_name: 'ironman.png'
  },
  {
    title: 'Superman',
    description:
    %{
      An alien orphan is sent from his dying planet to Earth, where
      he grows up to become his adoptive home's first and greatest
      super-hero.
    }.squish,
    released_on: "1978-12-15",
    rating: 'PG',
    total_gross: 300_451_603,
    director: 'Richard Donner',
    duration: '143 min',
    image_file_name: 'superman.png'
  },
  {
    title: 'Spider-Man',
    description:
    %{
      When bitten by a genetically modified spider, a nerdy, shy, and
      awkward high school student gains spider-like abilities that he
      eventually must use to fight evil as a superhero after tragedy
      befalls his family.
    }.squish,
    released_on: "2002-05-03",
    rating: 'PG-13',
    total_gross: 825_025_036,
    director: 'Sam Raimi',
    duration: '121 min',
    image_file_name: 'spiderman.png'
  },
  {
    title: 'Batman',
    description:
    %{
      The Dark Knight of Gotham City begins his war on crime with his
      first major enemy being the clownishly homicidal Joker.
    }.squish,
    released_on: "1989-06-23",
    rating: 'PG-13',
    total_gross: 411_348_924,
    director: 'Tim Burton',
    duration: '126 min',
    image_file_name: 'batman.png'
  },
  {
    title: "Catwoman",
    description:
    %{
      Patience Philips seems destined to spend her life apologizing for taking up space. Despite her artistic ability she has a more than respectable career as a graphic designer.
    }.squish,
    released_on: "2004-07-23",
    rating: "PG-13",
    total_gross: 82_102_379,
    director: "Jean-Christophe 'Pitof' Comar",
    duration: "101 min",
    image_file_name: "catwoman.png"
  },
  {
    title: "Wonder Woman",
    description:
    %{
      When a pilot crashes and tells of conflict in the outside world, Diana, an Amazonian warrior in training, leaves home to fight a war, discovering her full powers and true destiny.
    }.squish,
    released_on: "2017-06-02",
    rating: "PG-13",
    total_gross: 821_847_012,
    director: "Patty Jenkins",
    duration: "141 min",
    image_file_name: "wonder-woman.png"
  },
  # My movies
  {
    title: 'Dune',
      description:
      %{
        A noble family becomes embroiled in a war for control over the galaxy's most valuable
        asset while its heir becomes troubled by visions of a dark future.
      }.squish,
      released_on: "2021-10-22",
      rating: 'PG-13',
      total_gross: 402_027_830,
      director: 'Denis Villeneuve',
      duration: "155 min",
      image_file_name: "dune.jpg"
  },
    {
      title: '1917',
      description:
        %{
        April 6th, 1917. As an infantry battalion assembles to wage war deep in enemy territory,
        two soldiers are assigned to race against time and deliver a message that will stop
        1,600 men from walking straight into a deadly trap.
      }.squish,
      released_on: "2020-01-10",
      rating: 'R',
      total_gross: 384_577_421,
      duration: "119 min"
    },
    {
      title: 'Tenet',
      description:
        %{
        Armed with only one word, Tenet, and fighting for the survival of the entire world, a
        Protagonist journeys through a twilight world of international espionage on a mission
        that will unfold in something beyond real time.
      }.squish,
      released_on: "2020-09-03",
      rating: 'PG-13',
      total_gross: 365_304_105,
      duration: "150 min"
    },
    {
      title: 'Interstellar',
      description:
        %{
        A team of explorers travel through a wormhole in space in an attempt to ensure
        humanity's survival.
      }.squish,
      released_on: "2014-10-07",
      rating: 'PG-13',
      total_gross: 773_867_216,
      duration: "169 min"
    },
  {
    title: 'Dune: Part Two',
    description:
      %{
      Paul Atreides unites with Chani and the Fremen while seeking revenge against the
      conspirators who destroyed his family.
    }.squish,
    released_on: "2024-03-15",
    rating: 'PG-13',
    director: 'Denis Villeneuve',
    image_file_name: "dune2.jpg",
    total_gross: 0,
    duration: "120 min"
  },
])
# TODO: What about unreleased movies which are missing details like total_gross and duration?

Genre.create!([
  { name: "Action" },
  { name: "Comedy" },
  { name: "Drama" },
  { name: "Romance" },
  { name: "Thriller" },
  { name: "Fantasy" },
  { name: "Documentary" },
  { name: "Adventure" },
  { name: "Animation" },
  { name: "Sci-Fi" }
])
