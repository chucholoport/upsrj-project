#!/usr/bin/env bash
# =============================================================================
# Firmware Flash Utility
# =============================================================================
#
# This script flashes firmware to a microcontroller connected to the host
# system using stable device aliases created via udev rules.
#
# Unlike the development environment scripts (dev.sh, enter.sh, stop.sh),
# this script does NOT use the development PLATFORM as the flashing target.
#
# Instead it uses a separate TARGET parameter representing the firmware
# device being programmed.
#
# Example:
#
#   Development platform:
#       arduino
#       raspberry
#
#   Firmware targets:
#       arduino
#       esp32
#       stm32
#       pico
#
# Example usage:
#
#   ./flash.sh
#   ./flash.sh esp32
#   ./flash.sh pico
#
# Author: Jesus Lopez
# Contact: https://github.com/chucholoport
# =============================================================================


# -----------------------------------------------------------------------------
# Resolve script directory
# -----------------------------------------------------------------------------
SCRIPT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"


# -----------------------------------------------------------------------------
# Load platform defaults
# -----------------------------------------------------------------------------
source "$SCRIPT_DIR/lib/platforms.env"


# -----------------------------------------------------------------------------
# Resolve target
# -----------------------------------------------------------------------------
TARGET="${1:-$DEFAULT_TARGET}"


# -----------------------------------------------------------------------------
# Resolve device alias
# -----------------------------------------------------------------------------
case "$TARGET" in

    arduino)
        DEVICE="/dev/arduino"
        ;;

    esp32)
        DEVICE="/dev/esp32"
        ;;

    stm32)
        DEVICE="/dev/stm32"
        ;;

    pico)
        DEVICE="/dev/pico"
        ;;

    *)
        echo "Unsupported firmware target: $TARGET"
        exit 1
        ;;

esac


# -----------------------------------------------------------------------------
# Display configuration
# -----------------------------------------------------------------------------
echo "------------------------------------------------------------"
echo "Firmware Flash Utility"
echo "Target device : $TARGET"
echo "Device alias  : $DEVICE"
echo "------------------------------------------------------------"


# -----------------------------------------------------------------------------
# Validate device
# -----------------------------------------------------------------------------
if [ ! -e "$DEVICE" ]; then

    echo "Error: device not found."
    echo "Expected device:"
    echo "  $DEVICE"
    exit 1

fi


# -----------------------------------------------------------------------------
# Flash placeholder
# -----------------------------------------------------------------------------
echo "Flashing firmware to $DEVICE..."

echo "Insert platform-specific flashing command here."