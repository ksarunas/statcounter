RSpec.describe Statcounter::Projects do
  before { Timecop.freeze(Time.at(1466614800)) }

  describe '.all' do
    subject { described_class.all(credentials: default_credentials) }

    before do
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

  describe '.find' do
    subject { described_class.find(project_id, credentials: default_credentials) }
    let(:project_id) { 1 }

    before do
      stub_request(:get, 'http://api.statcounter.com/select_project?f=json&pi=1&sha1=229b79fa8787e1a8bf8d09c3a1cbec96a8219364&t=1466614800&u=john_brown&vn=3')
        .to_return(body: File.read('spec/assets/select_project.json'))
    end

    it 'returns project details' do
      expect(subject).to be_instance_of Hash
      expect(subject).to include(
        :project_name,
        :log_size,
        :timezone,
        :url,
        :log_oldest_entry,
        :log_latest_entry,
        :created_at,
      )
    end
  end
end
