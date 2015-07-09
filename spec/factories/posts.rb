FactoryGirl.define do
  factory :post do
    image { Rack::Test::UploadedFile.new(File.join(Rails.root, 'spec', 'images', 'WWJP.png'), 'image/png' ) }

  end

end
