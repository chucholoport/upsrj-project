# =============================================================================
# ROS2 Jazzy Base Container for Arduino App Lab Robotics Development
# =============================================================================
#
# This Dockerfile defines a minimal ROS2 Jazzy container used as the base
# development environment for robotics projects integrating:
#
#   • Arduino Cloud App Lab firmware
#   • Python cloud client
#   • ROS2 robotics nodes
#
# The container expects the host project folders to be mounted under /app
# using Docker Compose.
#
# Expected directory layout inside the container:
#
#   /app
#      ├── python
#      ├── sketch
#      └── ws
#
# Author: Jesus Lopez
# Contact: https://github.com/chucholoport
# =============================================================================


# -----------------------------------------------------------------------------
# Base Image
# -----------------------------------------------------------------------------
# Use the official ROS2 Jazzy base image.
#
FROM docker.io/ros:jazzy-ros-base


# -----------------------------------------------------------------------------
# Environment Configuration
# -----------------------------------------------------------------------------
ENV DEBIAN_FRONTEND=noninteractive
ENV ROS_DOMAIN_ID=0
ENV WORKSPACE=/app/ws


# -----------------------------------------------------------------------------
# System Dependencies
# -----------------------------------------------------------------------------
# Install common development tools typically required for ROS2 projects.
#
RUN apt-get update && apt-get install -y \
    python3-pip \
    python3-colcon-common-extensions \
    git \
    nano \
    tmux \
    vim \
    && rm -rf /var/lib/apt/lists/*


# -----------------------------------------------------------------------------
# Application Root Directory
# -----------------------------------------------------------------------------
# All project files will be mounted here from the host.
#
RUN mkdir -p /app
WORKDIR /app


# -----------------------------------------------------------------------------
# ROS Environment Setup
# -----------------------------------------------------------------------------
# Automatically source ROS2 and the workspace when a shell starts.
#
RUN echo "source /opt/ros/jazzy/setup.bash" >> /root/.bashrc && \
    echo "if [ -f /app/ws/install/setup.bash ]; then source /app/ws/install/setup.bash; fi" >> /root/.bashrc


# -----------------------------------------------------------------------------
# Default Command
# -----------------------------------------------------------------------------
CMD ["bash"]