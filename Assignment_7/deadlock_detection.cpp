#include <iostream>
using namespace std;

const int NUM_PROCESSES = 5; // Increased from 4 to 5
const int NUM_RESOURCES = 3;

int allocated[NUM_PROCESSES][NUM_RESOURCES] = {
    {1, 0, 1},
    {2, 1, 0},
    {3, 0, 2},
    {1, 2, 1},
    {0, 1, 3}
};

int requested[NUM_PROCESSES][NUM_RESOURCES] = {
    {0, 0, 0},
    {1, 0, 2},
    {2, 1, 0},
    {0, 0, 1},
    {1, 0, 0}
};

int availableResources[NUM_RESOURCES] = {2, 1, 1}; // Changed values

bool checkDeadlock() {
    bool processCompleted[NUM_PROCESSES] = {false};
    int workResources[NUM_RESOURCES];

    for (int r = 0; r < NUM_RESOURCES; r++)
        workResources[r] = availableResources[r];

    while (true) {
        bool allocationHappened = false;

        for (int proc = 0; proc < NUM_PROCESSES; proc++) {
            if (!processCompleted[proc]) {
                bool canComplete = true;
                for (int res = 0; res < NUM_RESOURCES; res++) {
                    if (requested[proc][res] > workResources[res]) {
                        canComplete = false;
                        break;
                    }
                }

                if (canComplete) {
                    for (int res = 0; res < NUM_RESOURCES; res++)
                        workResources[res] += allocated[proc][res];

                    processCompleted[proc] = true;
                    allocationHappened = true;
                }
            }
        }

        if (!allocationHappened) break;
    }

    bool deadlockDetected = false;
    for (int proc = 0; proc < NUM_PROCESSES; proc++) {
        if (!processCompleted[proc]) {
            cout << "⚠ Process P" << proc << " is in deadlock.\n";
            deadlockDetected = true;
        }
    }

    if (!deadlockDetected)
        cout << "✅ No deadlock detected.\n";

    return deadlockDetected;
}

int main() {
    checkDeadlock();
    return 0;
}
