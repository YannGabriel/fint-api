postgres:
	docker run --name fint-container -p 5432:5432 -e POSTGRES_USER=fint-admin -e POSTGRES_PASSWORD=root -d postgres:latest

createdb:
	docker exec -it fint-container createdb --username=fint-admin --owner=fint-admin fint-db

dropdb:
	docker exec -it fint-container dropdb --username=fint-admin fint-db

migrateup:
	migrate -path db/migration -database 'postgres://fint-admin:root@localhost:5432/fint-db?sslmode=disable' -verbose up

migratedown:
	migrate -path db/migration -database 'postgres://fint-admin:root@localhost:5432/fint-db?sslmode=disable' -verbose down

sqlc:
	sqlc generate

test:
	go test -v -cover ./...
	
.PHONY: createdb dropdb postgres migratedown migrateup 
