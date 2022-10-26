defmodule Elixirgame do
  use Application

  def start(_, _) do
    run()
    {:ok, self()}
  end

  def run() do
    IO.puts("::::::::::: Vamos jogar Adivinhe o Número! :::::::::::")

    IO.gets("Escolha a o nível de dificuldade (1, 2 ou 3): ")
    |> parse_input()
    |> pickup_number()
    |> play()
  end

  def play(picked_num) do
    IO.gets("Eu já escolhi meu número, qual seu palpite? ")
    |> parse_input()
    |> guess(picked_num, 1)
  end

  # Pattern Matching
  def guess(usr_guess, picked_num, count) when usr_guess > picked_num do
    IO.gets("Muito alto, tente novamente: ")
    |> parse_input()
    |> guess(picked_num, count + 1)
  end

  def guess(usr_guess, picked_num, count) when usr_guess < picked_num do
    IO.gets("Muito baixo, tente novamente: ")
    |> parse_input()
    |> guess(picked_num, count + 1)
  end

  def guess(_usr_guess, _picked_num, count) do
    IO.puts("Você acertou! #{count} tentativas")
    show_score(count)
  end

  # Random Number
  def pickup_number(level) do
    level
    |> get_range()
    |> Enum.random()
  end

  def get_range(level) do
    case level do
      1 ->
        1..10

      2 ->
        1..100

      3 ->
        1..1000

      _ ->
        IO.puts("Nível de dificuldade não disponível!")
        run()
    end
  end

  def show_score(guesses) when guesses > 6 do
    IO.puts("Mais sorte da proxíma vez!")
  end

  def show_score(guesses) do
    {_, msg} =
      %{
        (1..1) => "Você realmente lê mentes!",
        (2..4) => "Impressionante!",
        (3..6) => "Você pode fazer melhor que isso!"
      }
      |> Enum.find(fn {range, _} ->
        Enum.member?(range, guesses)
      end)

    IO.puts(msg)
  end

  # Validations
  def parse_input(:error) do
    IO.puts("Selecione um dos níveis válidos!")
    run()
  end

  def parse_input({num, _}), do: num

  def parse_input(data) do
    data
    |> Integer.parse()
    |> parse_input()
  end
end
