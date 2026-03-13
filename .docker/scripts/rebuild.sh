#!/usr/bin/env bash
# =============================================================================
# ROS2 Development Container Rebuilder
# =============================================================================
#
# This script forces a full rebuild of the ROS2 development container
# used in Arduino App Lab robotics projects.
#
# The rebuild process performs the following tasks:
#
#   1. Loads the shared environment resolver
#   2. Resolves platform and ROS distribution from CLI arguments
#   3. Navigates to the corresponding Docker Compose directory
#   4. Stops the running container
#   5. Rebuilds the image without using Docker cache
#   6. Restarts the container
#   7. Opens an interactive shell inside the container
#
# This script is useful when:
#
#   * Modifying the Dockerfile
#   * Installing new ROS packages
#   * Fixing dependency issues
#   * Resetting the container environment
#
# The environment resolution logic is implemented in:
#
#   .docker/scripts/lib/env.sh
#
# Example usage:
#
#   ./rebuild.sh
#   ./rebuild.sh jazzy
#   ./rebuild.sh raspberry
#   ./rebuild.sh raspberry humble
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
echo "Rebuilding ROS2 Development Environment"
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
# Navigate to compose directory
# -----------------------------------------------------------------------------
cd "$COMPOSE_DIR" || exit 1


# -----------------------------------------------------------------------------
# Stop existing container
# -----------------------------------------------------------------------------
echo "Stopping existing container..."

docker compose down


# -----------------------------------------------------------------------------
# Rebuild container image
# -----------------------------------------------------------------------------
echo "Rebuilding container image (no cache)..."

docker compose build --no-cache


# -----------------------------------------------------------------------------
# Start container
# -----------------------------------------------------------------------------
echo "Starting container..."

docker compose up -d


# -----------------------------------------------------------------------------
# Open interactive shell
# -----------------------------------------------------------------------------
echo "Opening shell inside container..."

docker exec -it "$CONTAINER_NAME" bash