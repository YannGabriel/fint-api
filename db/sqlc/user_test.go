package database

import (
	"testing"
	"context"
	"utils"
	"github.com/stretchr/testify/require"
	"github.com/stretchr/fint-api/utils"
)

func TestCreateUser (t *testing.T){
	Username := utils.;


	user, err := testQueries.CreateUser(context.Background(), Username);

	require.NoError(t, err)
	require.NotEmpty(t, user)
	require.Equal(t, Username, user.Username)

	require.NotZero(t, user.ID)
	require.NotZero(t, user.CreatedAt)
}