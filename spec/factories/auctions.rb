FactoryGirl.define do
  factory :auction do
    describe '#new' do
      context 'user not signed in' do
        it "redirects to sign-in page" do
        end
      end
      context 'user signed in' do
        it "renders the new Auction template" do
        end
        it "creates a new auction object" do
        end
      end
    end    
    describe '#create' do
      context 'user not signed in' do
        it "redirects to sign-in page" do
        end
      end
      context 'user signed in' do
        context 'with valid Auction parameters' do
          it "adds Auction to the database" do
          end
          it "redirects to the Auction Show page" do
          end
          it "associates the Auction with the signed-in user" do
          end
        end
        context 'with invalid Auction parameters' do
          it "renders the :new template" do
          end
          it "does not add Auction to the database" do
          end
        end
      end
    end
  end

end
