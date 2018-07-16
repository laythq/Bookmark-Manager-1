require 'user'

describe '#create' do
  it 'creates a new user' do
    user = User.create(email: 'laythq@gmail.com', password: 'password')
    expect(user.id).not_to be_nil
  end
end

describe '#all' do
  it 'returns all users, wrapped in a User instance' do
    user = User.create(email: 'laythq@gmail.com', password: 'password')
    expect(User.all.map(&:id)).to include user.id
  end
end

describe '#find' do
  it 'finds a user by their ID' do
    user = User.create(email: 'laythq@gmail.com', password: 'password')
    expect(User.find(user.id).email).to eq user.email
  end

  it 'returns nil if there is no ID given' do
    expect(User.find(nil)).to eq nil
  end
end

describe '#authenticate' do
  it 'returns a user given the correct email and password' do
    user = User.create(email: 'laythq@gmail.com', password: 'password')
    authenticated_user = User.authenticate(user.email, user.password)
    expect(authenticated_user.id).to eq user.id
  end

  it 'returns nil given an incorrect email address' do
    user = User.create(email: 'laythq@gmail.com', password: 'password')
    expect(User.authenticate('wrong@gmail.com', 'asdasda')).to be_nil
  end
end
