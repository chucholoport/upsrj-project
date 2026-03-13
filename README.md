# ROS2 Robotics Development Template

Author: Jesus Lopez
Contact: https://github.com/chucholoport

---

## Overview

This repository provides a **containerized development environment template for robotics projects using ROS2**.

The goal of this template is to provide a **clean and reproducible infrastructure** that integrates:

* ROS2 development
* Embedded firmware (Arduino / microcontrollers)
* Python robotics utilities
* Containerized tooling with Docker

This repository **does not contain robot-specific code**. Instead, it provides a **base architecture** that can be reused across multiple robotics projects.

---

## Supported Platforms

The infrastructure is designed to support multiple robotics platforms.

Currently supported platforms include:

* **Arduino**
* **Raspberry Pi**

The architecture allows adding new platforms easily by creating additional container configurations inside:

```
.docker/<platform>/<ros_distro>/
```

Example:

```
.docker/
 ├── arduino/
 │   └── ros2_jazzy/
 └── raspberry/
     └── ros2_jazzy/
```

---

## Project Architecture

The repository separates **infrastructure**, **firmware**, and **robotics software**.

```
project
│
├── python/        Python utilities or robotics scripts
│
├── sketch/        Arduino firmware or microcontroller code
│
├── ws/            ROS2 workspace
│   └── src/       ROS packages (cloned per project)
│
└── .docker/       Development infrastructure
    │
    ├── arduino/
    │   └── ros2_jazzy/
    │
    └── scripts/
        ├── robot
        ├── dev.sh
        ├── build.sh
        ├── stop.sh
        ├── clean.sh
        └── lib/
```

The entire repository is mounted inside the container as:

```
/app
```

---

## Architecture Philosophy

Robotics projects typically involve **multiple technology layers**:

* Embedded firmware running on microcontrollers
* Robotics middleware (ROS2)
* High-level applications written in Python or C++
* Hardware-specific dependencies

Managing all these components directly on the host system often leads to:

* dependency conflicts
* difficult setup procedures
* inconsistent development environments across machines

This template solves these problems by adopting three design principles.

### 1. Containerized Development

All development tools run inside Docker containers.
This guarantees that every developer uses the **same environment** regardless of host system.

### 2. Clear Separation of Layers

The repository separates the main components of a robotics system:

| Layer          | Directory  | Purpose                     |
| -------------- | ---------- | --------------------------- |
| Firmware       | `sketch/`  | Microcontroller programs    |
| Robotics       | `ws/`      | ROS2 workspace              |
| Utilities      | `python/`  | Scripts, ML models, helpers |
| Infrastructure | `.docker/` | Container configuration     |

This separation keeps projects maintainable as they grow.

### 3. Reusable Infrastructure

The repository is designed as a **template**, not as a robot-specific project.

Each project can:

* clone its own ROS packages
* add firmware for its hardware
* reuse the same development environment

---

## ROS2 Workspace

The ROS2 workspace is located at:

```
ws/
```

ROS packages should be cloned inside:

```
ws/src
```

Example:

```
ws/src
 ├── ur_robot_driver
 ├── vision_node
 └── micro_ros_agent
```

Build the workspace using:

```
colcon build
```

Build artifacts (`build`, `install`, `log`) are ignored by Git.

---

## Development Environment

The development environment is managed through a small CLI tool called **robot**.

The CLI is located at:

```
.docker/scripts/robot
```

It wraps the Docker infrastructure and provides simplified commands for development.

---

## Setup

Clone the repository:

```
git clone <repo>
cd <repo>
```

Make sure Docker and Docker Compose are installed.

---

## Adding the CLI to Your Shell

You can register the `robot` command in your shell by adding it to your `.bashrc`.

Run the following command from the project root:

```
echo "alias robot=\"$PWD/.docker/scripts/robot\"" >> ~/.bashrc
```

Reload the shell configuration:

```
source ~/.bashrc
```

You can now use the command directly:

```
robot build
```

---

## Basic Usage

Build the development container:

```
robot build
```

Start the development environment:

```
robot dev
```

This will:

1. Build the container if needed
2. Start the container
3. Open an interactive shell

Enter a running container:

```
robot enter
```

Stop the development environment:

```
robot stop
```

Remove containers and images:

```
robot clean
```

---

## ROS2 Development Workflow

Start the container:

```
robot dev
```

Inside the container:

```
cd /app/ws
colcon build
```

Run nodes using:

```
ros2 run <package> <node>
```

---

## Adding ROS Packages

Clone packages inside the workspace:

```
cd ws/src

git clone <package_repo>
```

Then build:

```
cd /app/ws
colcon build
```

---

## Extending the Template

New platforms can be added by creating new container configurations:

```
.docker/<platform>/<ros_distro>/
```

For example:

```
.docker/jetson/ros2_jazzy
.docker/esp32/ros2_jazzy
```

---

## Goals of This Template

This template was designed to support robotics systems combining:

* ROS2
* Embedded microcontrollers
* Computer vision
* Machine learning
* Industrial robots

while maintaining a **reproducible and portable development environment**.

---

## License

This project is released under the MIT License.
See the LICENSE file for details.