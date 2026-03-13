#!/usr/bin/env bash
# =============================================================================
# ROS2 Development Container Shell
# =============================================================================
#
# This script opens an interactive shell inside an already running
# ROS2 development container.
#
# It reuses the same environment resolution logic used by dev.sh
# to ensure consistent platform and ROS distribution selection.
#
# Example usage:
#
#   ./enter.sh
#   ./enter.sh jazzy
#   ./enter.sh raspberry
#   ./enter.sh raspberry humble
#
# Author: Jesus Lopez
# Contact: https://github.com/chucholoport
# =============================================================================


# -----------------------------------------------------------------------------
# Resolve script directory
# -----------------------------------------------------------------------------
SCRIPT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"


# -----------------------------------------------------------------------------
# Load shared environment resolver
# -----------------------------------------------------------------------------
source "$SCRIPT_DIR/lib/env.sh" "$@"


# -----------------------------------------------------------------------------
# Display selected configuration
# -----------------------------------------------------------------------------
echo "------------------------------------------------------------"
echo "ROS2 Development Environment"
echo "Platform    : $PLATFORM"
echo "ROS Distro  : $ROS_DISTRO"
echo "Container   : $CONTAINER_NAME"
echo "------------------------------------------------------------"


# -----------------------------------------------------------------------------
# Verify container exists
# -----------------------------------------------------------------------------
if ! docker ps --format '{{.Names}}' | grep -q "^${CONTAINER_NAME}$"; then

    echo "Error: Container is not running."
    echo ""
    echo "Expected container:"
    echo "  $CONTAINER_NAME"
    echo ""
    echo "Start it first using:"
    echo ""
    echo "  ./.docker/scripts/dev.sh $@"
    echo ""

    exit 1

fi


# -----------------------------------------------------------------------------
# Open interactive shell
# -----------------------------------------------------------------------------
echo "Opening shell inside container..."

docker exec -it "$CONTAINER_NAME" bash