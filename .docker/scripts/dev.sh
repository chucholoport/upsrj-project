#!/usr/bin/env bash
# =============================================================================
# ROS2 Development Environment Launcher
# =============================================================================
#
# This script builds and launches the ROS2 development container used
# in Arduino App Lab robotics projects.
#
# The script performs the following tasks:
#
#   1. Loads the shared environment resolver
#   2. Resolves platform and ROS distribution from CLI arguments
#   3. Navigates to the corresponding Docker Compose directory
#   4. Builds the container image if necessary
#   5. Starts the container
#   6. Opens an interactive shell inside the container
#
# The environment resolution logic is implemented in:
#
#   .docker/scripts/lib/env.sh
#
# This avoids duplication and ensures all tooling scripts share the
# same configuration behavior.
#
# Example usage:
#
#   ./dev.sh
#   ./dev.sh jazzy
#   ./dev.sh humble
#   ./dev.sh raspberry
#   ./dev.sh raspberry jazzy
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
# Start container environment
# -----------------------------------------------------------------------------
echo "Starting ROS2 development container..."

cd "$COMPOSE_DIR" || exit 1

docker compose up -d --build


# -----------------------------------------------------------------------------
# Open interactive shell
# -----------------------------------------------------------------------------
echo "Opening shell inside container..."

docker exec -it "$CONTAINER_NAME" bash