-- qbss_cu_percent.lua
--
-- Adds derived QBSS Channel Utilization percentage fields:
--   qbss_cu.percent
--   qbss_cu.percent_text
--
-- Formula:
--   percent = wlan.qbss.cu * 100 / 255

local qbss_cu_percent_proto = Proto("qbss_cu_percent", "QBSS CU Percent")

local f_cu_percent = ProtoField.float(
    "qbss_cu.percent",
    "QBSS Channel Utilization Percent",
    base.NONE
)

local f_cu_percent_text = ProtoField.string(
    "qbss_cu.percent_text",
    "QBSS Channel Utilization Percent Text"
)

qbss_cu_percent_proto.fields = {
    f_cu_percent,
    f_cu_percent_text
}

local wlan_qbss_cu = Field.new("wlan.qbss.cu")

function qbss_cu_percent_proto.dissector(tvb, pinfo, tree)
    local cu_field = wlan_qbss_cu()

    if cu_field ~= nil then
        local cu = tonumber(tostring(cu_field))

        if cu ~= nil then
            local percent = cu * 100.0 / 255.0
            local percent_text = string.format("%.1f%%", percent)

            local subtree = tree:add(qbss_cu_percent_proto, "QBSS CU Percent")
            subtree:add(f_cu_percent, percent)
            subtree:add(f_cu_percent_text, percent_text)
        end
    end
end

register_postdissector(qbss_cu_percent_proto)