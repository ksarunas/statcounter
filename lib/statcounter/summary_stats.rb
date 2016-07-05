module Statcounter
  class SummaryStats
    def self.daily(project_ids:, date_from:, date_to:, credentials: nil)
      params = {
        s: :summary,
        g: :daily,
        pi: project_ids,
        sd: date_from.day,
        sm: date_from.month,
        sy: date_from.year,
        ed: date_to.day,
        em: date_to.month,
        ey: date_to.year,
      }
      response = Statcounter.client.get('stats', params: params, credentials: credentials)
      if response[:project]
        response[:project].each_with_object({}) do |project, result|
          result[project[:id].to_i] = project[:sc_data]
        end
      else
        response[:sc_data]
      end
    end
  end
end
