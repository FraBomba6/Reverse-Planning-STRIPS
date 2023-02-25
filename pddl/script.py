import subprocess
import os

# Run a command and read the output
def run_command(command):
    process = subprocess.Popen(command, shell=True, executable='/bin/bash', stdout=subprocess.PIPE, stderr=subprocess.PIPE)
    stdout, stderr = process.communicate()
    return stdout.decode("utf-8") , stderr.decode("utf-8") 

if __name__ == "__main__":
    horizon = 1
    command = 'plasp/plasp translate domain.pddl problem.pddl | cat - <(echo "#show chosen/1.") | clingo - --const horizon=1 reversibility-asp-elp-aspq/sequential-horizon.uurev.lp'
    # Run the command and check if it is UNSATISFIABLE
    while horizon < 100:
        print("\nHorizon: " + str(horizon))
        command = 'plasp/plasp translate domain.pddl problem.pddl | cat - <(echo "#show chosen/1.") | clingo - --const horizon=' + str(horizon) + ' reversibility-asp-elp-aspq/sequential-horizon.uurev.lp'
        stdout, stderr = run_command(command)
        print(stdout)
        horizon += 1