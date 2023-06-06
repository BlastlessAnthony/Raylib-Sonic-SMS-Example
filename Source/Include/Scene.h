#ifndef __SONIC_SMS_SCENE_H__
#define __SONIC_SMS_SCENE_H__
#include <stdio.h>
#include <stdlib.h>

typedef struct {
    void (*_OnReady) (void);
    void (*_OnUpdate) (float);
    void (*_OnRender) (void);
    void (*_OnExit) (void);
} Scene;

Scene *newScene(void (*ready_method)(void), void (*update_method)(float), void (*render_method)(void), void (*exit_method)(void)) {
    Scene *_scene = malloc(sizeof(*_scene));
    if (!_scene) {
        fprintf(stderr, "Heap corruption prevention. Failed to create scene.");
    } else {
        fprintf(stdout, "Created scene at address: <%p>", _scene);
    }

    _scene->_OnReady = ready_method;
    _scene->_OnUpdate = update_method;
    _scene->_OnRender = render_method;
    _scene->_OnExit = exit_method;
    return _scene;
}


#endif //__SONIC_SMS_SCENE_H__
