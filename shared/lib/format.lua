-- copied from voithos :: https://stackoverflow.com/a/10990007
function FormatNumberWithCommas(amount)
    local formatted = amount
    while true do
        formatted, k = string.gsub(formatted, "^(-?%d+)(%d%d%d)", '%1,%2')
        if (k == 0) then
            break
        end
    end
    return formatted
end

REE.Lib.Format = {
    FormatNumberWithCommas = FormatNumberWithCommas,
}