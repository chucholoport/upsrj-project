#!/usr/bin/env bash
# =============================================================================
# ROS2 Environment Cleanup
# =============================================================================
#
# This script removes the development container and its associated image.
#
# It is useful when resetting the environment or reclaiming disk space.
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
echo "Cleaning ROS2 Development Environment"
echo "Platform      : $PLATFORM"
echo "ROS Distro    : $ROS_DISTRO"
echo "Container     : $CONTAINER_NAME"
echo "------------------------------------------------------------"


# -----------------------------------------------------------------------------
# Stop container environment
# -----------------------------------------------------------------------------
cd "$COMPOSE_DIR" || exit 1


echo "Stopping container..."
docker compose down


# -----------------------------------------------------------------------------
# Remove container environment
# -----------------------------------------------------------------------------
echo "Removing container image..."
docker compose down --rmi all


echo "Environment cleaned."