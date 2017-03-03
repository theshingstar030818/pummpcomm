defmodule Decocare.History.InsulinMarker do
  use Bitwise
  alias Decocare.DateDecoder

  def decode_insulin_marker(<<amount_low_bits::8, timestamp::binary-size(5), amount_high_bits::2, _::6>>) do
    %{
      amount: ((amount_high_bits <<< 8) + amount_low_bits) / 10.0,
      timestamp: DateDecoder.decode_history_timestamp(timestamp)
    }
  end
end