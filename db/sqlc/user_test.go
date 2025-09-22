package database

import (
	"testing"
	"context"
	"fmt"

	"github.com/stretchr/testify/require"

	"github.com/YannGabriel/fint-api/utils"
)

func CreateRandomUser(t *testing.T) User{
	Username := utils.RandomUsername();

	user, err := testQueries.CreateUser(context.Background(), Username);

	require.NoError(t, err)
	require.NotEmpty(t, user)
	require.Equal(t, Username, user.Username)

	require.NotZero(t, user.ID)
	require.NotZero(t, user.CreatedAt)
	fmt.Println("Usuário criado:", user)

	return user
}


func TestCreateUser (t *testing.T){
	CreateRandomUser(t)
}

func TestGetUser(t *testing.T) {
	user1 := CreateRandomUser(t)
	user2, err := testQueries.GetUserByID(context.Background(), user1.ID)

	require.NoError(t, err)
	require.NotEmpty(t, user2)

	require.Equal(t, user1.ID, user2.ID)
	require.Equal(t, user1.Username, user2.Username)
}

func TestListUsers (t *testing.T){
	_ = CreateRandomUser(t)

	users, err := testQueries.ListUsers(context.Background())
	require.NoError(t, err)
	require.NotEmpty(t, users)
}

func TestDeleteUser (t *testing.T){
	user1 := CreateRandomUser(t)
	err := testQueries.DeleteUser(context.Background(), user1.ID)

	require.NoError(t, err)
	require.NotEmpty(t, user1)

}

func TestUpdateUser (t *testing.T){
	user1 := CreateRandomUser(t)

	arg := UpdateUserParams{
		ID: user1.ID,
		Username: "TESTE DE UPDATE",
	}

	user2, err := testQueries.UpdateUser(context.Background(), arg)

	require.NoError(t, err)
	require.NotEmpty(t, user2)

	require.Equal(t, arg.Username, user2.Username)
	require.Equal(t, user1.ID, user2.ID)
}

