module Statcounter
  class Projects
    def self.all(credentials: nil)
      response = Statcounter.client.get('user_projects', credentials: credentials)
      response[:sc_data]
    end

    def self.find(project_ids, credentials: nil)
      params = { pi: project_ids }
      response = Statcounter.client.get('select_project', params: params, credentials: credentials)
      response[:sc_data].size > 1 ? response[:sc_data] : response[:sc_data][0]
    end

    def self.create(project_name:, url:, public_stats: false, timezone: Statcounter.config.timezone, credentials: nil)
      params = {
        wt: project_name,
        wu: url,
        ps: public_stats ? 1 : 0,
        tz: timezone,
      }

      response = Statcounter.client.get('add_project', params: params, credentials: credentials)
      response[:sc_data][0]
    end

    def self.delete(project_id:, admin_username:, admin_password:, credentials: nil)
      params = {
        pi: project_id,
        u: admin_username,
        up: admin_password,
      }

      response = Statcounter.client.get('remove_project', params: params, credentials: credentials)
      response[:@attributes][:status]
    end
  end
end
