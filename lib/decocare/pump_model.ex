defmodule Decocare.PumpModel do
  @doc """
  Return the model number of the pump from its model string

  ## Examples

      iex> Decocare.PumpModel.model_number("723")
      {:ok, 723}
      iex> Decocare.PumpModel.model_number("522")
      {:ok, 522}
      iex> Decocare.PumpModel.model_number("677")
      {:error, "Bad Pump Model"}
      iex> Decocare.PumpModel.model_number("invalid")
      {:error, "Bad Pump Model"}
  """
  def model_number(model_string) when is_binary(model_string),               do: Integer.parse(model_string) |> model_number
  def model_number(model_number) when model_number == :error,                do: {:error, "Bad Pump Model"}
  def model_number({model_number, _}) when div(model_number, 100) in [5, 7], do: {:ok, model_number}
  def model_number(_),                                                       do: {:error, "Bad Pump Model"}

  @doc """
  Return true if history records use larger format

  ## Examples

      iex> Decocare.PumpModel.large_format?(723)
      true
      iex> Decocare.PumpModel.large_format?(522)
      false
  """
  def large_format?(model_number) when rem(model_number, 100) >= 23, do: true
  def large_format?(_),                                              do: false

  @doc """
  Return true if pump supports MySentry

  ## Examples

      iex> Decocare.PumpModel.supports_my_sentry?(723)
      true
      iex> Decocare.PumpModel.supports_my_sentry?(522)
      false
  """
  def supports_my_sentry?(model_number) when rem(model_number, 100) >= 23, do: true
  def supports_my_sentry?(_),                                              do: false

  @doc """
  Return true if pump supports low suspend

  ## Examples

      iex> Decocare.PumpModel.supports_low_suspend?(723)
      false
      iex> Decocare.PumpModel.supports_low_suspend?(751)
      true
  """
  def supports_low_suspend?(model_number) when rem(model_number, 100) >= 51, do: true
  def supports_low_suspend?(_),                                              do: false

  @doc """
  Return true if pump writes a square wave bolus to history as it starts,
  then updates the same entry upon completion

  ## Examples

      iex> Decocare.PumpModel.records_square_wave_bolus_before_delivery?(723)
      true
      iex> Decocare.PumpModel.records_square_wave_bolus_before_delivery?(522)
      false
  """
  def records_square_wave_bolus_before_delivery?(model_number) when rem(model_number, 100) >= 23, do: true
  def records_square_wave_bolus_before_delivery?(_),                                              do: false

  @doc """
  Return how many turns the pump motor takes to deliver 1U of insulin

  ## Examples

      iex> Decocare.PumpModel.strokes_per_unit(722)
      10
      iex> Decocare.PumpModel.strokes_per_unit(751)
      40
  """
  def strokes_per_unit(model_number) when rem(model_number, 100) >= 23, do: 40
  def strokes_per_unit(_),                                              do: 10

  @doc """
  Returns how much the pump's reservoir can hold

  ## Examples

      iex> Decocare.PumpModel.reservoir_capacity(522)
      176
      iex> Decocare.PumpModel.reservoir_capacity(751)
      300
  """
  def reservoir_capacity(model_number) when div(model_number, 100) == 5, do: 176
  def reservoir_capacity(model_number) when div(model_number, 100) == 7, do: 300
end