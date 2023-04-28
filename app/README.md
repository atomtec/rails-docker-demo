Run Command in Order

docker-compose build
docker-compose run app rake db:create  
docker-compose run app rails db:migrate 
docker-compose run app rails db:seed 

Run Tests
docker-compose run app bundle exec rspec 

Run App
docker-compose up