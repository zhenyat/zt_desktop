require 'tk'
require './app/controllers/dummies_controller'

class DummiesViewIndex
  def self.load(dummies)
    out = ''
    dummies.each do |dummy|
      out << "\n#{dummy.id}. #{dummy.name}: #{dummy.title}  #{dummy.price} #{dummy.qty}"
    end

    app_win = TkRoot.new {
      title "Dummies List"; padx = 50; pady = 15
    }

    TkLabel.new(app_win) {
      text out
      pack {padx = 100; pady = 50; side = 'center'}
    }

    Tk.mainloop
  end
end
