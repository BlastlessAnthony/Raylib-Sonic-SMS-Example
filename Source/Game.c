#include <stdlib.h>
#include <raylib.h>
#include "Globals.h"
#include "Scene.h"
#include "raymath.h"        // Required for: Vector2Clamp()

#define MAX(a, b) ((a)>(b)? (a) : (b))
#define MIN(a, b) ((a)<(b)? (a) : (b))


int main(int argc, char **argv)
{
    SetConfigFlags(FLAG_MSAA_4X_HINT | FLAG_WINDOW_HIGHDPI | FLAG_VSYNC_HINT);
    InitWindow(RESOLUTION_W*4, RESOLUTION_H*4, "Sonic The Hedgehog (SMS)");
    SetWindowState(FLAG_WINDOW_RESIZABLE | FLAG_WINDOW_TOPMOST);
    SetTargetFPS(FRAMERATE);


    RenderTexture2D frame_buffer = LoadRenderTexture(RESOLUTION_W, RESOLUTION_H);
    SetTextureFilter(frame_buffer.texture, TEXTURE_FILTER_POINT);

    float frame_buffer_scale = 0.f;

    Scene *current_scene = NULL;

    
    while (!WindowShouldClose()) {

        frame_buffer_scale = MIN((float)GetScreenWidth()/RESOLUTION_W, (float)GetScreenHeight()/RESOLUTION_H);

        if (current_scene) {
            current_scene->_OnUpdate(GetFrameTime());
        }

        BeginTextureMode(frame_buffer);
            ClearBackground(BLACK);

            if (current_scene) {
                current_scene->_OnRender();
            }

        EndTextureMode();

        BeginDrawing();
            ClearBackground(RED);
            DrawTexturePro(
                frame_buffer.texture,

                (Rectangle) {
                    0.f, 
                    0.f, 
                    (float)frame_buffer.texture.width, 
                    (float)-frame_buffer.texture.height
                },

                (Rectangle) {
                    ((float)GetScreenWidth() - ((float)RESOLUTION_W * frame_buffer_scale)) * .5f,
                    ((float)GetScreenHeight() - ((float)RESOLUTION_H * frame_buffer_scale)) * .5f,
                    (float)RESOLUTION_W * frame_buffer_scale,
                    (float)RESOLUTION_H * frame_buffer_scale
                },

                (Vector2) {
                    0.f,
                    0.f
                },

                0.f,
                WHITE
            );
        EndDrawing();
    }

    UnloadRenderTexture(frame_buffer);
    CloseWindow();

    exit(EXIT_SUCCESS);
}