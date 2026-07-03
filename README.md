# Wireshark QBSS Channel Utilization Percentage Column

A small Wireshark Lua post-dissector that converts `wlan.qbss.cu` from its raw `0–255` value into a human-readable channel utilization percentage.

## Overview

Beacon and Probe Response frames may include QBSS Load IEs. Wireshark exposes the channel utilization value as:

```text
wlan.qbss.cu
```

That field is encoded as an integer from `0` to `255`, where:

```text
0   = 0% channel utilization
255 = 100% channel utilization
```

This plugin adds derived fields so the value can be displayed as a percentage in packet details, display filters, and custom columns.

## Added Fields

This plugin adds the following Wireshark fields:

```text
qbss_cu.percent
```

Numeric percentage value.

Example:

```text
37.6471
```

```text
qbss_cu.percent_text
```

Formatted percentage string.

Example:

```text
37.6%
```

## Formula

```text
QBSS CU % = wlan.qbss.cu × 100 / 255
```

## Installation

1. Save the Lua script as:

```text
qbss_cu_percent.lua
```

2. Copy the file into your Wireshark personal Lua plugins folder.

To find this folder in Wireshark:

```text
Help → About Wireshark → Folders
```

Look for:

```text
Personal Lua Plugins
```

3. Restart Wireshark.

## Creating the Custom Column

After installing the plugin and restarting Wireshark:

1. Open Wireshark preferences.
2. Go to:

```text
Edit → Preferences → Appearance → Columns
```

3. Add a new column.
4. Set the column type to:

```text
Custom
```

5. Set the custom field to:

```text
qbss_cu.percent_text
```

This will display values such as:

```text
12.5%
37.6%
81.2%
```

## Display Filter Examples

Show frames where QBSS channel utilization is greater than 50%:

```text
qbss_cu.percent > 50
```

Show frames where QBSS channel utilization is less than or equal to 25%:

```text
qbss_cu.percent <= 25
```

Show frames that contain the original QBSS channel utilization field:

```text
wlan.qbss.cu
```

## Recommended Usage

Use this field for packet list display:

```text
qbss_cu.percent_text
```

Use this field for filtering, sorting, or analysis:

```text
qbss_cu.percent
```
