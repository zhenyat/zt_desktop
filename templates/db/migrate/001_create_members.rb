require "./app/models/member.rb"

class CreateMembers < ActiveRecord::Migration
  def self.up
    create_table :members do |t|
      t.string  :last_name
      t.string  :first_name
      t.string  :sex
      t.string  :birthday
      t.integer :parent_id
    end

  Member.create last_name: 'Telyukov',    first_name: 'Evgeny', sex: 'M', birthday: '1950-02-25', parent_id: 0
  m = Member.first
  Member.create last_name: 'Telyukova',   first_name: 'Rada',   sex: 'F', birthday: '2007-08-25', parent_id: m.id
  Member.create last_name: 'Kruglyakova', first_name: 'Julia',  sex: 'F', birthday: '1977-12-08', parent_id: m.id
  Member.create last_name: 'Kutukova',    first_name: 'Darya',  sex: 'F', birthday: '1980-07-23', parent_id: m.id

  end

  def self.down
    drop_table :members
  end
end