require './app/controllers/application_controller'

class MembersController < ApplicationController

  def self.index
    db      = DbHandle::open
    members = Member.all
    DbHandle::close(db)

    MembersViewIndex.load(members)
  end
end
