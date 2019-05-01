defmodule BankAccount do
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
    {:ok, account} = BankServer.start()
    account
  end

  @doc """
  Close the bank. Makes the account unavailable.
  """
  @spec close_bank(account) :: none
  def close_bank(account), do: GenServer.stop(account)

  @doc """
  Get the account's balance.
  """
  @spec balance(account) :: integer
  def balance(account) do
    operation = fn -> BankServer.get_balance(account) end
    operation_based_on_state(account, operation)
  end

  @doc """
  Update the account's balance by adding the given amount which may be negative.
  """
  @spec update(account, integer) :: any
  def update(account, amount) do
    operation = fn -> BankServer.update_balance(account, amount) end
    operation_based_on_state(account, operation)
  end

  defp operation_based_on_state(account, operation) do
    Process.alive?(account) && operation.() || {:error, :account_closed}
  end
end

defmodule BankServer do
  use GenServer

  def start, do: GenServer.start(BankServer, nil)

  def get_balance(account), do: GenServer.call(account, :get_balance)

  def update_balance(account, amount) do
    GenServer.cast(account, {:update_balance, amount})
  end

  @impl GenServer
  def init(_), do: {:ok, %{balance: 0}}

  @impl GenServer
  def handle_call(:get_balance, _, account) do
    {:reply, account.balance, account}
  end

  @impl GenServer
  def handle_cast({:update_balance, amount}, account) do
    {:noreply, updated_balance(account, amount)}
  end

  defp updated_balance(account, amount) do
    Map.put(account, :balance, account.balance + amount)
  end
end
