package database

import (
	"context"
	"log"
	"os"
	"testing"
	"github.com/jackc/pgx/v5/pgxpool"
)

const (
	dbSource = "postgres://flint-admin:root@localhost:5432/fint-database?sslmode=disable"
)

var testQueries *Queries
  
func TestMain(m *testing.M) {
	ctx := context.Background()
	pool, err := pgxpool.New(ctx, dbSource)
	if err != nil {
		log.Fatal("Cannot connect to DataBase: ", err)
	}

	testQueries = New(pool)
	os.Exit(m.Run())
}
