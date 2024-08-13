# Reverse Planning - STRIPS Domain Project

## Overview

This project is part of the mini-project for the Advanced Topics in A.I. 2 course. The objective was to implement a STRIPS planning domain where at least one action is uniformly reversible. The domain has been implemented in both PDDL and K languages.

## Project Structure

The project is organized as follows:

- **report.pdf**: The project report.
- **pddl/**: Contains the PDDL encoding of the domain and an example problem.
- **k/**: Contains the K encoding of the domain, an example problem, and the background information for the problem.
- **img/**: Contains images used in the report.

## Domain Description

The domain represents a moving company that must relocate furniture between various locations. The company must perform several actions to move furniture, such as assembling, disassembling, packing, and moving the items.

### Actions

The following actions are defined in the domain:

- **assemble**: Assemble a piece of furniture.
- **disassemble**: Disassemble a piece of furniture.
- **pack**: Pack a piece of furniture.
- **unpack**: Unpack a piece of furniture.
- **load**: Load a piece of furniture onto a truck.
- **unload**: Unload a piece of furniture from a truck.
- **move**: Move a piece of furniture from one location to another.

### Predicates

The domain uses the following predicates:

- **assembled**: A piece of furniture is assembled.
- **packed**: A piece of furniture is packed.
- **loaded**: A piece of furniture is loaded onto a truck.
- **moved**: A piece of furniture is moved from one location to another.

### Process

To move a piece of furniture from one location to another, the company must perform the following steps:

1. Disassemble the furniture.
2. Pack the furniture.
3. Load the furniture onto a truck.
4. Move the truck to the destination.
5. Unload the furniture from the truck.
6. Unpack the furniture.
7. Assemble the furniture.

## PDDL Implementation

### Domain Description

The PDDL encoding of the domain is provided in `pddl/domain.pddl`. The domain defines two types of objects: `furniture` and `truck`. Each action involves a piece of furniture, and some actions also involve a truck. The domain includes actions and their corresponding preconditions and effects.

### Problem Description

The PDDL problem is defined in `pddl/problem.pddl`. The initial state involves furniture items being assembled, and the goal is to move and reassemble the furniture at the new location.

### Uniformly Reversible Actions

Using the `plasp` tool, uniformly reversible actions were identified. The following actions were found to be uniformly reversible:

- **assemble**
- **pack**
- **unpack**
- **load**
- **unload**
- **move**

## K Implementation

### Domain and Problem Description

The K encoding of the domain and problem is similar to the PDDL implementation and can be found in `k/k_domain.plan` and `k/k_problem.plan`. The K language requires additional specifications, such as the `inertial` property for fluents and the `noConcurrency` option.

### Reverse Plan

Attempts to use the `revplan` software to find the reverse plan of the solution were unsuccessful due to the software not terminating after an extended runtime. Despite this, based on the analysis, the reverse plan for each uniformly reversible action corresponds to the sequence of actions needed to reverse the state to the one before the chosen action.

## Results

The project successfully identified uniformly reversible actions in a STRIPS planning domain. However, challenges were encountered when attempting to compute the reverse plan using the `revplan` tool.

## License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.
