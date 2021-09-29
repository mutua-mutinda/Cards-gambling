defmodule Cards do
  @moduledoc """
    provides methods for creating and handling the deck of cards
  """

  @doc """
    returns a list of cards in string type to be used in playing
  """
  def create_deck do
    values = ["Ace", "Two", "Three", "Four", "Five"]
    suits = ["Spades", "Clubs", "Diamond", "Heart"]

    for suit <- suits, value <- values do
      value <> " of " <> suit
    end
  end

  @doc """
    Shuffles the deck of cards created
  """
  def shuffle(deck) do
    Enum.shuffle(deck)
  end

  @doc """
    Searches if a card provided is in the deck of created cards
  """
  def contains?(deck, card) do
    Enum.member?(deck, card)
  end

  @doc """
    Deals specified cards to a player by dividing the deck into a hand.
    The `hand_size` argument indicates the size of cards should a hand have.

  ## Example
      iex>deck = Card.create_deck
      iex>{hand, deck} = Cards.deal(deck, 1)
      iex>hand
      ["Ace of Spades"]

  """
  def deal(deck, hand_size) do
    Enum.split(deck, hand_size)
  end

  @doc """
    saves the deck of card created into a file
  """
  def save(deck, filename) do
    binary = :erlang.term_to_binary(deck)
    File.write(filename, binary)
  end

  @doc """
    Loads the deck of saved cards to used to play from a file
  """
  def load(filename) do
    case File.read(filename) do
      {:ok, binary} -> :erlang.binary_to_term(binary)
      {:error, _reason} -> IO.puts("Failed to load the file")
    end
  end

  @doc """
    It creates a hand size of cards to get the player started.
    The `hand_size` argument indicates the size of cards should a hand have.

  ## Example
      iex>{hand, deck} = Card.create_hand(3)
      iex>hand
      ["Four of Heart", "Five of Spades", "Ace of Heart"]

  """
  def create_hand(hand_size) do
    Cards.create_deck()
    |> Cards.shuffle()
    |> Cards.deal(hand_size)
  end
end
