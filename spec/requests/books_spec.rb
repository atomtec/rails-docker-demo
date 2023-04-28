require 'rails_helper'

describe 'Books API', type: :request do
    let(:first_author){FactoryBot.create(:author, first_name: 'George', last_name:'Orwel', age:40)}
    let(:second_author){FactoryBot.create(:author, first_name: 'Henry', last_name:'Wells', age:60)}
    let!(:user){FactoryBot.create(:user, username: 'Abc123',password: 'password')}
    describe 'GET /books' do
        before do
            FactoryBot.create(:book,title:'1984',author:first_author)
            FactoryBot.create(:book,title:'The Time Machine',author:second_author)
        end
        it 'resturns all books' do
            

            get '/api/v1/books'

            expect(response).to have_http_status(:ok)
            expect(JSON.parse(response.body).size).to eq(2)
            expect(JSON.parse(response.body)).to eq(
                [
                {
                    'id' => first_author.id,
                    'title' => '1984',
                    'author_name' => 'George Orwel',
                    'author_age' => 40
                },
                {
                    'id' => second_author.id,
                    'title' => 'The Time Machine',
                    'author_name' => 'Henry Wells',
                    'author_age' => 60
                }
                ]
            )
        end

        it 'returns a subset of books on pagination' do
            get '/api/v1/books', params: {limit: 1}

            expect(response).to have_http_status(:ok)
            expect(JSON.parse(response.body).size).to eq(1)
            expect(JSON.parse(response.body)).to eq(
                [
                {
                    'id' => first_author.id,
                    'title' => '1984',
                    'author_name' => 'George Orwel',
                    'author_age' => 40
                }
                ]
            )
        end
        it 'returns a subset of books on pagination and offset ' do
            get '/api/v1/books', params: {limit: 1, offset: 1}

            expect(response).to have_http_status(:ok)
            expect(JSON.parse(response.body).size).to eq(1)
            expect(JSON.parse(response.body)).to eq(
                [
                {
                    'id' => second_author.id,
                    'title' => 'The Time Machine',
                    'author_name' => 'Henry Wells',
                    'author_age' => 60
                }
                ]
            )
        end


    end

    describe 'POST /books' do
        it 'create a new book' do 
            expect {
                post '/api/v1/books', params:
                 { book: {title: 'The Martian'},
                   author: {first_name: 'Andy', last_name: 'Weir', age: '48'}
                 }, headers: {"Authorization" => "Bearer eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1c2VyX2lkIjoiQWJjMTIzIn0.7nWnKVutuDBEj3n0i-UoVcCuj-bFlPHuEyjcHuHMelU"}
        }.to change {Book.count}.from(0).to(1)

        expect(response).to have_http_status(:created)
        expect(Author.count).to eq(1)
        bookinDb = Book.where(title: 'The Martian')
        expect(JSON.parse(response.body)[0]).to eq(
            {
                'id' => bookinDb.ids[0],
                'title' => 'The Martian',
                'author_name' => 'Andy Weir',
                'author_age' => 48
            })
        end
    end

    describe 'DELETE /books/;id' do
        let!(:book) { FactoryBot.create(:book,title: '1984', author: first_author)}

        it 'deletes a book' do
           

            expect {
                delete "/api/v1/books/#{book.id}",
                headers: {"Authorization" => "Bearer eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1c2VyX2lkIjoiQWJjMTIzIn0.7nWnKVutuDBEj3n0i-UoVcCuj-bFlPHuEyjcHuHMelU"}
            }.to change {Book.count}.from(1).to(0)

            expect(response).to have_http_status(:no_content)
        end
    end

end