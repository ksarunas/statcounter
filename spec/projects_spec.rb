RSpec.describe Statcounter::Projects do
  describe '.all' do
    subject { described_class.all(credentials: default_credentials) }

    before do
      Timecop.freeze(Time.at(1466614800))
      stub_request(:get, 'http://api.statcounter.com/user_projects?f=json&sha1=06290316a4a4aa9911db04b42294609a8a4694e4&t=1466614800&u=john_brown&vn=3')
        .to_return(body: File.read('spec/assets/user_projects.json'))
    end

    it 'returns projects array' do
      expect(subject).to be_instance_of Array
      expect(subject.first).to include(
        :project_id,
        :project_name,
        :url,
        :project_group_id,
        :project_group_name,
        :hidden_group,
      )
    end
  end
end
