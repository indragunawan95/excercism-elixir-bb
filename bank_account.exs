defmodule BankAccount do
  use GenServer
  @impl GenServer
  def init(_) do
    {:ok, 0}
  end
  @impl GenServer
  def handle_call(:balance, _, balance), do: {:reply, balance, balance}
  @impl GenServer
  def handle_cast({:update, amount}, state), do: {:noreply, state + amount}
  @moduledoc """
  A bank account that supports access from multiple processes.
  """

  @typedoc """
  An account handle.
  """
  @opaque account :: pid

  @doc """
  Open the bank. Makes the account available.
  """
  @spec open_bank() :: account
  def open_bank() do
    {:ok, pid} = GenServer.start(__MODULE__, nil)
    pid
  end

  @doc """
  Close the bank. Makes the account unavailable.
  """
  @spec close_bank(account) :: none
  def close_bank(account) do
    GenServer.stop(account)
  end

  @doc """
  Get the account's balance.
  """
  @spec balance(account) :: integer
  def balance(account) do
    if Process.alive?(account) do
      GenServer.call(account, :balance)
    else
      {:error, :account_closed}
    end
  end

  @doc """
  Update the account's balance by adding the given amount which may be negative.
  """
  @spec update(account, integer) :: any
  def update(account, amount) do
    if Process.alive?(account) do
      GenServer.cast(account, {:update, amount})
    else
      {:error, :account_closed}
    end
  end
end

account = BankAccount.open_bank()
IO.inspect(BankAccount.balance(account))
BankAccount.update(account, 10)
IO.inspect(BankAccount.balance(account))
BankAccount.close_bank(account)
IO.inspect(BankAccount.balance(account))
IO.inspect(BankAccount.update(account, 10))
