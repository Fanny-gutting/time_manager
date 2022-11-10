defmodule TimeManager.ContentTest do
  use TimeManager.DataCase

  alias TimeManager.Content

  describe "users" do
    alias TimeManager.Content.User

    import TimeManager.ContentFixtures

    @invalid_attrs %{email: nil, status: nil, username: nil}

    test "list_users/0 returns all users" do
      user = user_fixture()
      assert Content.list_users() == [user]
    end

    test "get_user!/1 returns the user with given id" do
      user = user_fixture()
      assert Content.get_user!(user.id) == user
    end

    test "create_user/1 with valid data creates a user" do
      valid_attrs = %{email: "some email", status: 42, username: "some username"}

      assert {:ok, %User{} = user} = Content.create_user(valid_attrs)
      assert user.email == "some email"
      assert user.status == 42
      assert user.username == "some username"
    end

    test "create_user/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Content.create_user(@invalid_attrs)
    end

    test "update_user/2 with valid data updates the user" do
      user = user_fixture()
      update_attrs = %{email: "some updated email", status: 43, username: "some updated username"}

      assert {:ok, %User{} = user} = Content.update_user(user, update_attrs)
      assert user.email == "some updated email"
      assert user.status == 43
      assert user.username == "some updated username"
    end

    test "update_user/2 with invalid data returns error changeset" do
      user = user_fixture()
      assert {:error, %Ecto.Changeset{}} = Content.update_user(user, @invalid_attrs)
      assert user == Content.get_user!(user.id)
    end

    test "delete_user/1 deletes the user" do
      user = user_fixture()
      assert {:ok, %User{}} = Content.delete_user(user)
      assert_raise Ecto.NoResultsError, fn -> Content.get_user!(user.id) end
    end

    test "change_user/1 returns a user changeset" do
      user = user_fixture()
      assert %Ecto.Changeset{} = Content.change_user(user)
    end
  end

  describe "clocks" do
    alias TimeManager.Content.Clock

    import TimeManager.ContentFixtures

    @invalid_attrs %{status: nil, time: nil}

    test "list_clocks/0 returns all clocks" do
      clock = clock_fixture()
      assert Content.list_clocks() == [clock]
    end

    test "get_clock!/1 returns the clock with given id" do
      clock = clock_fixture()
      assert Content.get_clock!(clock.id) == clock
    end

    test "create_clock/1 with valid data creates a clock" do
      valid_attrs = %{status: true, time: ~N[2022-11-04 19:03:00]}

      assert {:ok, %Clock{} = clock} = Content.create_clock(valid_attrs)
      assert clock.status == true
      assert clock.time == ~N[2022-11-04 19:03:00]
    end

    test "create_clock/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Content.create_clock(@invalid_attrs)
    end

    test "update_clock/2 with valid data updates the clock" do
      clock = clock_fixture()
      update_attrs = %{status: false, time: ~N[2022-11-05 19:03:00]}

      assert {:ok, %Clock{} = clock} = Content.update_clock(clock, update_attrs)
      assert clock.status == false
      assert clock.time == ~N[2022-11-05 19:03:00]
    end

    test "update_clock/2 with invalid data returns error changeset" do
      clock = clock_fixture()
      assert {:error, %Ecto.Changeset{}} = Content.update_clock(clock, @invalid_attrs)
      assert clock == Content.get_clock!(clock.id)
    end

    test "delete_clock/1 deletes the clock" do
      clock = clock_fixture()
      assert {:ok, %Clock{}} = Content.delete_clock(clock)
      assert_raise Ecto.NoResultsError, fn -> Content.get_clock!(clock.id) end
    end

    test "change_clock/1 returns a clock changeset" do
      clock = clock_fixture()
      assert %Ecto.Changeset{} = Content.change_clock(clock)
    end
  end

  describe "workingtimes" do
    alias TimeManager.Content.WorkingTime

    import TimeManager.ContentFixtures

    @invalid_attrs %{end: nil, start: nil}

    test "list_workingtimes/0 returns all workingtimes" do
      working_time = working_time_fixture()
      assert Content.list_workingtimes() == [working_time]
    end

    test "get_working_time!/1 returns the working_time with given id" do
      working_time = working_time_fixture()
      assert Content.get_working_time!(working_time.id) == working_time
    end

    test "create_working_time/1 with valid data creates a working_time" do
      valid_attrs = %{end: ~N[2022-11-04 19:05:00], start: ~N[2022-11-04 19:05:00]}

      assert {:ok, %WorkingTime{} = working_time} = Content.create_working_time(valid_attrs)
      assert working_time.end == ~N[2022-11-04 19:05:00]
      assert working_time.start == ~N[2022-11-04 19:05:00]
    end

    test "create_working_time/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Content.create_working_time(@invalid_attrs)
    end

    test "update_working_time/2 with valid data updates the working_time" do
      working_time = working_time_fixture()
      update_attrs = %{end: ~N[2022-11-05 19:05:00], start: ~N[2022-11-05 19:05:00]}

      assert {:ok, %WorkingTime{} = working_time} = Content.update_working_time(working_time, update_attrs)
      assert working_time.end == ~N[2022-11-05 19:05:00]
      assert working_time.start == ~N[2022-11-05 19:05:00]
    end

    test "update_working_time/2 with invalid data returns error changeset" do
      working_time = working_time_fixture()
      assert {:error, %Ecto.Changeset{}} = Content.update_working_time(working_time, @invalid_attrs)
      assert working_time == Content.get_working_time!(working_time.id)
    end

    test "delete_working_time/1 deletes the working_time" do
      working_time = working_time_fixture()
      assert {:ok, %WorkingTime{}} = Content.delete_working_time(working_time)
      assert_raise Ecto.NoResultsError, fn -> Content.get_working_time!(working_time.id) end
    end

    test "change_working_time/1 returns a working_time changeset" do
      working_time = working_time_fixture()
      assert %Ecto.Changeset{} = Content.change_working_time(working_time)
    end
  end

  describe "teams" do
    alias TimeManager.Content.Team

    import TimeManager.ContentFixtures

    @invalid_attrs %{title: nil}

    test "list_teams/0 returns all teams" do
      team = team_fixture()
      assert Content.list_teams() == [team]
    end

    test "get_team!/1 returns the team with given id" do
      team = team_fixture()
      assert Content.get_team!(team.id) == team
    end

    test "create_team/1 with valid data creates a team" do
      valid_attrs = %{title: "some title"}

      assert {:ok, %Team{} = team} = Content.create_team(valid_attrs)
      assert team.title == "some title"
    end

    test "create_team/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Content.create_team(@invalid_attrs)
    end

    test "update_team/2 with valid data updates the team" do
      team = team_fixture()
      update_attrs = %{title: "some updated title"}

      assert {:ok, %Team{} = team} = Content.update_team(team, update_attrs)
      assert team.title == "some updated title"
    end

    test "update_team/2 with invalid data returns error changeset" do
      team = team_fixture()
      assert {:error, %Ecto.Changeset{}} = Content.update_team(team, @invalid_attrs)
      assert team == Content.get_team!(team.id)
    end

    test "delete_team/1 deletes the team" do
      team = team_fixture()
      assert {:ok, %Team{}} = Content.delete_team(team)
      assert_raise Ecto.NoResultsError, fn -> Content.get_team!(team.id) end
    end

    test "change_team/1 returns a team changeset" do
      team = team_fixture()
      assert %Ecto.Changeset{} = Content.change_team(team)
    end
  end

  describe "teamusers" do
    alias TimeManager.Content.TeamUser

    import TimeManager.ContentFixtures

    @invalid_attrs %{}

    test "list_teamusers/0 returns all teamusers" do
      team_user = team_user_fixture()
      assert Content.list_teamusers() == [team_user]
    end

    test "get_team_user!/1 returns the team_user with given id" do
      team_user = team_user_fixture()
      assert Content.get_team_user!(team_user.id) == team_user
    end

    test "create_team_user/1 with valid data creates a team_user" do
      valid_attrs = %{}

      assert {:ok, %TeamUser{} = team_user} = Content.create_team_user(valid_attrs)
    end

    test "create_team_user/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Content.create_team_user(@invalid_attrs)
    end

    test "update_team_user/2 with valid data updates the team_user" do
      team_user = team_user_fixture()
      update_attrs = %{}

      assert {:ok, %TeamUser{} = team_user} = Content.update_team_user(team_user, update_attrs)
    end

    test "update_team_user/2 with invalid data returns error changeset" do
      team_user = team_user_fixture()
      assert {:error, %Ecto.Changeset{}} = Content.update_team_user(team_user, @invalid_attrs)
      assert team_user == Content.get_team_user!(team_user.id)
    end

    test "delete_team_user/1 deletes the team_user" do
      team_user = team_user_fixture()
      assert {:ok, %TeamUser{}} = Content.delete_team_user(team_user)
      assert_raise Ecto.NoResultsError, fn -> Content.get_team_user!(team_user.id) end
    end

    test "change_team_user/1 returns a team_user changeset" do
      team_user = team_user_fixture()
      assert %Ecto.Changeset{} = Content.change_team_user(team_user)
    end
  end
end
