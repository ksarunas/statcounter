module Statcounter
  class Projects
    def self.all(credentials: nil)
      response = Statcounter.client.get('user_projects', credentials: credentials)
      response[:sc_data]
    end

    def self.find(project_id, credentials: nil)
      params = { pi: project_id }
      response = Statcounter.client.get('select_project', params: params, credentials: credentials)
      response[:sc_data][0]
    end
  end
end
