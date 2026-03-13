#!/usr/bin/env bash
# =============================================================================
# ROS2 Development Environment Resolver
# =============================================================================
#
# This script resolves the ROS2 development environment configuration
# based on CLI arguments. It is shared by multiple launcher scripts such as:
#
#   dev.sh
#   build.sh
#   enter.sh
#   stop.sh
#
# Responsibilities:
#
#   • Resolve project root
#   • Parse CLI arguments
#   • Determine platform
#   • Determine ROS distribution
#   • Generate container name
#   • Generate compose directory path
#
# Author: Jesus Lopez
# Contact: https://github.com/chucholoport
# =============================================================================


# -----------------------------------------------------------------------------
# Resolve script directory
# -----------------------------------------------------------------------------
SCRIPT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"


# -----------------------------------------------------------------------------
# Resolve project root directory
# -----------------------------------------------------------------------------
PROJECT_ROOT="$( cd "$SCRIPT_DIR/../../.." && pwd )"


# -----------------------------------------------------------------------------
# Load platform defaults
# -----------------------------------------------------------------------------
ENV_FILE="$SCRIPT_DIR/platforms.env"

if [ -f "$ENV_FILE" ]; then
    source "$ENV_FILE"
fi


# -----------------------------------------------------------------------------
# Default configuration
# -----------------------------------------------------------------------------
DEFAULT_PLATFORM="${DEFAULT_PLATFORM:-arduino}"
DEFAULT_ROS="${DEFAULT_ROS:-ros2_jazzy}"

PLATFORM="$DEFAULT_PLATFORM"
ROS_DISTRO="$DEFAULT_ROS"


# -----------------------------------------------------------------------------
# Supported ROS distro aliases
# -----------------------------------------------------------------------------
declare -A ROS_MAP
ROS_MAP["jazzy"]="ros2_jazzy"
ROS_MAP["humble"]="ros2_humble"
ROS_MAP["iron"]="ros2_iron"


# -----------------------------------------------------------------------------
# Parse CLI arguments
# -----------------------------------------------------------------------------
ARG1="${1:-}"
ARG2="${2:-}"


# -----------------------------------------------------------------------------
# Argument 1
# -----------------------------------------------------------------------------
if [ -n "$ARG1" ]; then

    # If ARG1 matches a ROS alias
    if [[ -v ROS_MAP["$ARG1"] ]]; then
        ROS_DISTRO="${ROS_MAP[$ARG1]}"
    else
        PLATFORM="$ARG1"
    fi

fi


# -----------------------------------------------------------------------------
# Argument 2
# -----------------------------------------------------------------------------
if [ -n "$ARG2" ]; then

    if [[ -v ROS_MAP["$ARG2"] ]]; then
        ROS_DISTRO="${ROS_MAP[$ARG2]}"
    fi

fi


# -----------------------------------------------------------------------------
# Compose directory
# -----------------------------------------------------------------------------
COMPOSE_DIR="$PROJECT_ROOT/.docker/$PLATFORM/$ROS_DISTRO"


# -----------------------------------------------------------------------------
# Container naming convention
# -----------------------------------------------------------------------------
CONTAINER_NAME="${ROS_DISTRO}_${PLATFORM}"


# -----------------------------------------------------------------------------
# Validate configuration
# -----------------------------------------------------------------------------
if [ ! -d "$COMPOSE_DIR" ]; then

    echo ""
    echo "ERROR: Docker configuration not found"
    echo ""
    echo "Expected directory:"
    echo "  $COMPOSE_DIR"
    echo ""
    exit 1

fi