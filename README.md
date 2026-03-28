# 1. Basic Multi-Server Service Unit
A fundamental Discrete Event Simulation (DES) of a queueing system.
### Scenario:
* **Arrivals:** Constant interval (every 5 minutes).
* **Service:** Constant time (8 minutes).
* **Capacity:** 2 parallel servers.
**Key concept:** Implementation of the Future Event Calendar (FEC) and time-advance mechanism.

# 2. Coffee Shop Simulation
This model introduces stochastic (random) service times based on customer orders.
### Scenario:
* **Arrivals:** Constant interval (every 4 minutes).
* **Service Types:** * 60% Espresso (3 minutes)
  * 40% Cappuccino (6 minutes)
* **Capacity:** 2 baristas (servers).
**Key concept:** Using `rand()` to decide between different service durations.

# 3. Post Office with Lunch Peak
A simulation focusing on non-stationary arrival rates where the intensity changes over time.
### Scenario:
* **Arrivals:** * 0-20 min: Slow (every 8 minutes).
  * 20-40 min: Peak hour (every 2 minutes).
* **Service:** Constant (5 minutes).
* **Capacity:** 2 servers.
**Key concept:** Dynamic adjustment of the arrival rate based on the simulation clock (`t`).

# 4. Pharmacy - Full Stochastic Model
### Scenario:
* **Time Windows:** * 0-240 min: Normal Distribution ($\mu=5, \sigma=1$).
  * 240-480 min: Triangular Distribution ($6, 8, 10$).
  * 480-720 min: Uniform Distribution ($8$ to $16$).
* **Service:** Constant (7 minutes).
* **Capacity:** 2 servers.
**Key concept:** Using MATLAB's `makedist` and `random` functions to simulate real-world arrival patterns.
