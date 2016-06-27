RSpec.describe Statcounter::Projects do
  before { Timecop.freeze(Time.at(1466614800)) }

  describe '.all' do
    subject { described_class.all(credentials: default_credentials) }

    before do
      stub_request(:get, 'http://api.statcounter.com/user_projects?vn=3&t=1466614800&u=john_brown&f=json&sha1=06290316a4a4aa9911db04b42294609a8a4694e4')
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
    subject { described_class.find(project_ids, credentials: default_credentials) }
    let(:project_ids) { 1 }
    let(:request_uri) { 'http://api.statcounter.com/select_project?pi=1&vn=3&t=1466614800&u=john_brown&f=json&sha1=229b79fa8787e1a8bf8d09c3a1cbec96a8219364' }
    let(:response_file) { 'spec/assets/select_project.json' }

    before { stub_request(:get, request_uri).to_return(body: File.read(response_file)) }

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

    context 'when multiple ids passed' do
      let(:project_ids) { [1, 2] }
      let(:request_uri) { 'http://api.statcounter.com/select_project?pi=1&pi=2&vn=3&t=1466614800&u=john_brown&f=json&sha1=397509ff17b98ad6abc394d97e7d761d768c8b22' }
      let(:response_file) { 'spec/assets/select_project_multiple.json' }

      it 'returns multiple project details' do
        expect(subject).to be_instance_of Array
        expect(subject.size).to eq 2
      end
    end
  end
end
