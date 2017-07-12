require 'pry'
require_relative './parser.rb'
require_relative './army.rb'
require "sqlite3"

class Battle
  include Parser

  ATTRIBUTES = @@columns
  #sets attributes hash equal to @@columns hash parsed from CSV

  attr_accessor(*ATTRIBUTES.keys)

  def initialize(attributes = {})
    self.id = attributes[:id]
    self.class.public_attributes.each do |attribute|
      self.send("#{attribute}=", attributes[attribute])
    end
  end

  def self.db
    @@db = SQLite3::Database.new "../db/got_battles.db"
  end

  def self.create_table
  #call create_table using attributes hash with @@columns from CSV
    values = ATTRIBUTES.map {|attribute| attribute.join(" ")}.join(", ")
    sql = <<-SQL
        CREATE TABLE IF NOT EXISTS #{self.table_name}
        (#{values})
      SQL
    db.execute(sql)
  end

  def self.table_name
	   "#{self.to_s.downcase}s"
  end

  def self.drop_table
    sql = <<-SQL
      DROP TABLE #{self.table_name}
    SQL
    self.db.execute(sql)
  end

  def self.all
    sql_statement = <<-SQL
      SELECT * FROM #{self.table_name};
    SQL

    rows = self.db.execute(sql_statement)
    rows.map do |row|
       self.new_from_row(row)
    end
  end

  def self.seed_from_csv
  #call self.seed_from_CSV to seed the rows from CSV into the table using #insert method
    @@rows.map do |row|
      #to create smaller tables from rows we'd need to select individual data elements
      #from each row (which is an array), take that specific data as a new collection,
      #and seed that into the rows from csv method for our new table and rows
      Army.all.each do |army|
        if army.name == row[5]
          row[5] = army.id
        elsif army.name == row[6]
          row[6] = army.id
        elsif army.name == row[7]
          row[7] = army.id
        elsif army.name == row[8]
          row[8] = army.id
        elsif army.name == row[9]
          row[9] = army.id
        elsif army.name == row[10]
          row[10] = army.id
        elsif army.name == row[11]
          row[11] = army.id
        elsif army.name == row[12]
          row[12] = army.id
        end
      end
        self.rows_from_csv(row)
    end
  end

  def self.rows_from_csv(row)
    zipped = ATTRIBUTES.keys.zip(row).to_h
    instance = self.new(zipped)
    instance.insert
  end

  def self.new_from_row(row) #call new from csv
    zipped = ATTRIBUTES.keys.zip(row).to_h
    instance = self.new(zipped)
  end

  def values
    values = self.class.public_attributes.map {|attribute| self.send(attribute)}
  end

  def self.public_attributes
    ATTRIBUTES.keys.reject { |attribute| attribute == :id  }
  end

  def insert
    attributes = self.class.public_attributes.join(", ")
    question_marks = self.class.public_attributes.map {|attribute| "?" }.join(", ")
    sql_statement = <<-SQL
      INSERT INTO #{self.class.table_name} (#{attributes})
      VALUES (#{question_marks})
    SQL

    self.class.db.execute(sql_statement, *self.values)
  end

  def self.find(id)
    sql_statement = <<-SQL
     SELECT * FROM #{self.table_name} where id = #{id};
   SQL

   row = self.db.execute(sql_statement).first
   self.new_from_row(row)
  end
end
