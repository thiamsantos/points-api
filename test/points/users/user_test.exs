defmodule Points.Users.UserTest do
  use Points.DataCase, async: true

  alias Points.Users.User

  describe "changeset/2" do
    test "valid attrs" do
      attrs = %{points: 10}

      changeset = User.changeset(attrs)
      assert changeset.valid?
    end

    test "accepts 0 points" do
      attrs = %{points: 0}

      changeset = User.changeset(attrs)
      assert changeset.valid?
    end

    test "accepts 100 points" do
      attrs = %{points: 100}

      changeset = User.changeset(attrs)
      assert changeset.valid?
    end

    test "does not accept negative points" do
      attrs = %{points: -1}

      changeset = User.changeset(attrs)
      assert errors_on(changeset) == %{points: ["must be greater than or equal to 0"]}
    end

    test "does not accepts points above 100" do
      attrs = %{points: 101}

      changeset = User.changeset(attrs)
      assert errors_on(changeset) == %{points: ["must be less than or equal to 100"]}
    end
  end
end
