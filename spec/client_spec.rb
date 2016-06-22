RSpec.describe Statcounter::Client do
  describe '#get' do
    subject { described_class.new.get('user_projects', credentials: default_credentials) }
    let(:response_body) { 'spec/assets/user_projects.json' }
    let(:response_status) { 200 }

    before do
      Timecop.freeze(Time.at(1466614800))
      stub_request(:get, 'http://api.statcounter.com/user_projects?f=json&sha1=06290316a4a4aa9911db04b42294609a8a4694e4&t=1466614800&u=john_brown&vn=3')
        .to_return(body: File.read(response_body), status: response_status)
    end

    shared_examples 'raises error' do
      it 'raises an exception' do
        expect { subject }.to raise_error(Statcounter::Error)
      end
    end

    it 'returns body' do
      expect(subject[:sc_data]).to be_instance_of Array
      expect(subject[:sc_data].first).to include(:project_id)
    end

    context 'when failure response' do
      let(:response_body) { 'spec/assets/failure.json' }

      it_behaves_like 'raises error'
    end

    context 'when client error' do
      let(:response_status) { 500 }

      it_behaves_like 'raises error'
    end
  end
end
