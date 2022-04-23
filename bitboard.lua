function new_Bitboard(inputs, outputs)

    local actual_input_count = #inputs[1]
    local actual_output_count = #outputs[1]

    local processed_inputs = {}
    for i = 1, #inputs do
        local s = ""
        for j = 1, #inputs[i] do
            s = s .. inputs[i][j]
        end
        processed_inputs[i] = bin2dec(s)
    end

    local processed_outputs = {}
    for i = 1, #outputs do
        local s = ""
        for j = 1, #outputs[i] do
            s = s .. outputs[i][j]
        end
        processed_outputs[i] = bin2dec(s)
    end

    local bitboard = {}
    bitboard.board = {}
    for i = 1, #processed_inputs do
        bitboard.board[processed_inputs[i]] = processed_outputs[i]
    end

    bitboard.inputs_count = #inputs 
    bitboard.outputs_count = #outputs

    bitboard.AIC = actual_input_count
    bitboard.AOC = actual_output_count

    bitboard.evaluate = function(self, values)

        -- values is a table of values, each value is a table of 0s and 1s

        local s = ""
        for i = 1, #values do
            s = s .. values[i]
        end

        local dec = bin2dec(s)

        local eval = bitboard.board[dec]
        local bin = dec2bin(eval)


        if bin == "0" then
            output = {}
            for i = 1, bitboard.AOC do
                output[i] = 0
            end
        else 
            output = {}
            for i = 1, bitboard.AOC do
                output[i] = bin:sub(i, i)
            end
        end

        return output
    end

    return bitboard
end