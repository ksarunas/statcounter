RSpec.describe Statcounter::SummaryStats do
  before { Timecop.freeze(Time.at(1466614800)) }

  describe '.daily' do
    subject do
      described_class.daily(
        project_ids: project_ids,
        date_from: date_from,
        date_to: date_to,
        credentials: default_credentials
      )
    end

    let(:project_ids) { 1 }
    let(:date_from) { Date.new(2016, 6, 28) }
    let(:date_to) { Date.new(2016, 6, 28) }
    let(:request_uri) { 'http://api.statcounter.com/stats?s=summary&g=daily&pi=1&sd=28&sm=6&sy=2016&ed=28&em=6&ey=2016&vn=3&t=1466614800&u=john_brown&f=json&sha1=9c16ca0e1034bc8d878396b0c34a5232e971ce35' }
    let(:response_file) { 'spec/assets/summary_stats_daily.json' }

    before { stub_request(:get, request_uri).to_return(body: File.read(response_file)) }

    it 'returns summery stats' do
      expect(subject).to be_instance_of Array
      expect(subject[0]).to include(
        :date,
        :page_views,
        :unique_visits,
        :returning_visits,
        :first_time_visits,
      )
    end

    context 'when multiple ids passed' do
      let(:project_ids) { [1, 2] }
      let(:request_uri) { 'http://api.statcounter.com/stats?s=summary&g=daily&pi=1&pi=2&sd=28&sm=6&sy=2016&ed=28&em=6&ey=2016&vn=3&t=1466614800&u=john_brown&f=json&sha1=ab0a3d2be2b3a7270ee1c2c0655e1cd7c3de818e' }
      let(:response_file) { 'spec/assets/summary_stats_daily_multiple.json' }

      it 'returns multiple project summery stats' do
        expect(subject).to be_instance_of Hash
        expect(subject.keys.size).to eq 2
        expect(subject[2][0]).to include(
          :date,
          :page_views,
          :unique_visits,
          :returning_visits,
          :first_time_visits,
        )
      end
    end
  end
end
