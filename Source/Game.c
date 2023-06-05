#include <stdlib.h>
#include <raylib.h>
#include "Globals.h"
int main(int argc, char **argv)
{
    InitWindow(RESOLUTION_W, RESOLUTION_H, "Sonic The Hedgehog (SMS)");
    SetTargetFPS(FRAMERATE);
    
    while (!WindowShouldClose()) {
        PollInputEvents();
        SwapScreenBuffer();
    }

    CloseWindow();

    exit(EXIT_SUCCESS);
}