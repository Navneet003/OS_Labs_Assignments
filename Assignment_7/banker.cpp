#include <iostream>
using namespace std;

const int NUM_PROCESSES = 4; // Changed from 5 to 4
const int NUM_RESOURCES = 3; // Kept 3

int availableResources[NUM_RESOURCES] = {5, 3, 2}; // Changed values

int maxDemand[NUM_PROCESSES][NUM_RESOURCES] = { 
    {6, 4, 3},
    {2, 2, 2},
    {7, 0, 3},
    {3, 3, 2}
};

int allocatedResources[NUM_PROCESSES][NUM_RESOURCES] = {
    {1, 1, 0},
    {2, 0, 1},
    {3, 0, 2},
    {1, 2, 1}
};

int remainingNeed[NUM_PROCESSES][NUM_RESOURCES];

void computeRemainingNeed() {
    for (int process = 0; process < NUM_PROCESSES; process++) {
        for (int resource = 0; resource < NUM_RESOURCES; resource++) {
            remainingNeed[process][resource] = maxDemand[process][resource] - allocatedResources[process][resource];
        }
    }
}

bool checkSystemSafety() {
    bool processCompleted[NUM_PROCESSES] = {false}; 
    int workResources[NUM_RESOURCES];

    for (int r = 0; r < NUM_RESOURCES; r++)
        workResources[r] = availableResources[r];

    int safeOrder[NUM_PROCESSES], finishedCount = 0;

    while (finishedCount < NUM_PROCESSES) {
        bool allocationPossible = false;

        for (int proc = 0; proc < NUM_PROCESSES; proc++) {
            if (!processCompleted[proc]) {
                bool canBeAllocated = true;
                for (int res = 0; res < NUM_RESOURCES; res++) {
                    if (remainingNeed[proc][res] > workResources[res]) {
                        canBeAllocated = false;
                        break;
                    }
                }

                if (canBeAllocated) {
                    for (int res = 0; res < NUM_RESOURCES; res++)
                        workResources[res] += allocatedResources[proc][res];

                    safeOrder[finishedCount++] = proc;
                    processCompleted[proc] = true;
                    allocationPossible = true;
                }
            }
        }

        if (!allocationPossible) {
            cout << "System is in an unsafe state.\n";
            return false;
        }
    }

    cout << "System is in a safe state.\nSafe Execution Order: ";
    for (int i = 0; i < NUM_PROCESSES; i++)
        cout << "P" << safeOrder[i] << " ";
    cout << endl;
    return true;
}

int main() {
    computeRemainingNeed();
    checkSystemSafety();
    return 0;
}
