require "sqlite3"
require 'csv'
require 'pry'

module Parser

  battle_data = CSV.read('./battles.csv', {encoding: "UTF-8", headers: true, header_converters: :symbol, converters: :all})

  replacements = {
    'Fixnum' => 'INTEGER',
    'NilClass'=> "NULL",
    'String' => 'TEXT'
  }
  matcher = /#{replacements.keys.join('|')}/
  hashed_data = battle_data.map { |d| d.to_hash }
  @@keys = hashed_data.first.keys
  @@values = hashed_data.first.values.map do |value|
    value.class.to_s.gsub(matcher) do |match|
      replacements[match] || match
    end
  end
  @@columns = Hash[@@keys.zip(@@values)]
  @@columns[:id] = "INTEGER PRIMARY KEY"
  @@columns[:summer] = "BOOLEAN"

  @@rows = CSV.foreach('./battles.csv').map {|row| row}[1..-1]

  #array or arrays where each element is a battle
end
