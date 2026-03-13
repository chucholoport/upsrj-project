#!/usr/bin/env bash
# =============================================================================
# ROS2 Container Image Builder
# =============================================================================
#
# This script builds the ROS2 development container image without starting
# the container. It is useful for validating Dockerfile changes.
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
echo "Building ROS2 Development Image"
echo "Platform      : $PLATFORM"
echo "ROS Distro    : $ROS_DISTRO"
echo "Compose Dir   : $COMPOSE_DIR"
echo "------------------------------------------------------------"


# -----------------------------------------------------------------------------
# Build container environment
# -----------------------------------------------------------------------------
cd "$COMPOSE_DIR" || exit 1

docker compose build