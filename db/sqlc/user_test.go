package database

import (
	"testing"
	"context"
	"github.com/YannGabriel/fint-api/utils"
	"github.com/stretchr/testify/require"
)

func TestCreateUser (t *testing.T){
	Username := utils.RandomUsername();


	user, err := testQueries.CreateUser(context.Background(), Username);

	require.NoError(t, err)
	require.NotEmpty(t, user)
	require.Equal(t, Username, user.Username)

	require.NotZero(t, user.ID)
	require.NotZero(t, user.CreatedAt)
}