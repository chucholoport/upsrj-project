#!/usr/bin/env bash
# =============================================================================
# ROS2 Development Environment Resolver
# =============================================================================
#
# This script resolves the ROS2 development environment configuration
# based on CLI arguments. It is shared by multiple launcher scripts
# such as:
#
#   dev.sh
#   enter.sh
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
# Resolve project root directory
# -----------------------------------------------------------------------------
SCRIPT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
PROJECT_ROOT="$( cd "$SCRIPT_DIR/../../.." && pwd )"


# -----------------------------------------------------------------------------
# Load platform defaults
# -----------------------------------------------------------------------------
ENV_FILE="$SCRIPT_DIR/platforms.env"

if [ -f "$ENV_FILE" ]; then
    source "$ENV_FILE"
fi


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
ARG1="$1"
ARG2="$2"

# Initialize defaults
DEFAULT_PLATFORM="${DEFAULT_PLATFORM:-arduino}"
DEFAULT_ROS="${DEFAULT_ROS:-ros2_jazzy}"


# If first argument matches ROS distro
if [[ -n "${ROS_MAP[$ARG1]}" ]]; then

    ROS_DISTRO="${ROS_MAP[$ARG1]}"
    PLATFORM="$DEFAULT_PLATFORM"

elif [ -n "$ARG1" ]; then

    PLATFORM="$ARG1"

fi


# If second argument matches ROS distro
if [[ -n "${ROS_MAP[$ARG2]}" ]]; then

    ROS_DISTRO="${ROS_MAP[$ARG2]}"

fi


# -----------------------------------------------------------------------------
# Compose directory
# -----------------------------------------------------------------------------
COMPOSE_DIR="$PROJECT_ROOT/.docker/$PLATFORM/$ROS_DISTRO"


# -----------------------------------------------------------------------------
# Container naming convention
# -----------------------------------------------------------------------------
CONTAINER_NAME="${ROS_DISTRO}_${PLATFORM}"