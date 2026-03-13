#!/usr/bin/env bash
# =============================================================================
# ROS2 Development Container Stopper
# =============================================================================
#
# This script stops the ROS2 development container associated with the
# current Arduino App Lab robotics project.
#
# The script performs the following tasks:
#
#   1. Loads the shared environment resolver
#   2. Resolves platform and ROS distribution from CLI arguments
#   3. Navigates to the corresponding Docker Compose directory
#   4. Stops and removes the container using Docker Compose
#
# The environment resolution logic is implemented in:
#
#   .docker/scripts/lib/env.sh
#
# Example usage:
#
#   ./stop.sh
#   ./stop.sh jazzy
#   ./stop.sh raspberry
#   ./stop.sh raspberry humble
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
echo "Stopping ROS2 Development Environment"
echo "Platform      : $PLATFORM"
echo "ROS Distro    : $ROS_DISTRO"
echo "Compose Dir   : $COMPOSE_DIR"
echo "Container     : $CONTAINER_NAME"
echo "------------------------------------------------------------"


# -----------------------------------------------------------------------------
# Validate compose directory
# -----------------------------------------------------------------------------
if [ ! -d "$COMPOSE_DIR" ]; then

    echo "Error: Unsupported configuration."
    echo ""
    echo "Expected directory:"
    echo "  $COMPOSE_DIR"
    echo ""
    echo "Verify that the platform and ROS distribution folders exist."
    exit 1

fi


# -----------------------------------------------------------------------------
# Stop container environment
# -----------------------------------------------------------------------------
echo "Stopping ROS2 development container..."

cd "$COMPOSE_DIR" || exit 1

docker compose down


echo "Container stopped successfully."