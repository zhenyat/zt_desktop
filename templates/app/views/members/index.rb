require 'tk'
require './app/controllers/members_controller'

class MembersViewIndex
  def self.load(members)
    out = ''
    members.each do |member|
      out << "\n#{member.id}. #{member.last_name}: #{member.first_name}  #{member.sex} #{member.birthday} #{member.parent_id}"
    end

    app_win = TkRoot.new {
      title "Family Members"; padx = 50; pady = 15
    }

    TkLabel.new(app_win) {
      text out
      pack {padx = 100; pady = 50; side = 'center'}
    }

    Tk.mainloop
  end
end
