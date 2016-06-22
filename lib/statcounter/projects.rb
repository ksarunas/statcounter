module Statcounter
  class Projects
    def self.all(credentials: nil)
      response = Statcounter.client.get('user_projects', credentials: credentials)
      response[:sc_data]
    end
  end
end
