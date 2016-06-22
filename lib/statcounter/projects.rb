module Statcounter
  class Projects
    def self.all(params: {}, credentials: nil)
      response = Statcounter.client.get('user_projects', params: params, credentials: credentials)
      response[:sc_data]
    end
  end
end
