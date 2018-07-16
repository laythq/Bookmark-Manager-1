require 'database_connection'

describe DatabaseConnection do
  describe '#self.setup(name)' do
    it 'connects to the correct database' do
    database = DatabaseConnection.setup('bookmark_manager')
    expect(DatabaseConnection.connection).to eq database
    end

    it 'connects to the correct database' do
      database = DatabaseConnection.setup('bookmark_manager_test')
      expect(DatabaseConnection.connection).to eq database
    end
  end

end
