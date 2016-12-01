require './app/controllers/application_controller'

class DummiesController < ApplicationController

  def self.index
    db      = DbHandle::open
    dummies = Dummy.all
    DbHandle::close(db)

    DummiesViewIndex.load(dummies)
  end
end
