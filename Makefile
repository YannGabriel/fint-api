postgres:
	docker run --name flint-container -p 5432:5432 -e POSTGRES_USER=flint-admin -e POSTGRES_PASSWORD=root -d postgres:latest

createdb:
	docker exec -it flint-container createdb --username=flint-admin --owner=flint-admin fint-database

dropdb:
	docker exec -it flint-container dropdb --username=flint-admin fint-database

migrateup:
	migrate -path db/migration -database 'postgres://flint-admin:root@localhost:5432/fint-database?sslmode=disable' -verbose up

migratedown:
	migrate -path db/migration -database 'postgres://flint-admin:root@localhost:5432/fint-database?sslmode=disable' -verbose down

sqlc:
	sqlc generate

test:
	go test -v -cover ./...
	
.PHONY: createdb dropdb postgres migratedown migrateup 
