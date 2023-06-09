if (APPLE)
set(BUNDLE_PLIST_PATH "${PROJECT_RESOURCES_DIR}/Darwin/Info.plist.in")

    set_target_properties(${PROJECT_NAME} PROPERTIES
        MACOSX_BUNDLE TRUE
        MACOSX_RPATH TRUE
        INSTALL_RPATH "@executable_path/../Frameworks"
        MACOSX_BUNDLE_EXECUTABLE_NAME "${PROJECT_TARGET}"
        MACOSX_BUNDLE_BUNDLE_NAME "${BUNDLE_DISPLAY_NAME}"
        MACOSX_BUNDLE_BUNDLE_VERSION "${CMAKE_PROJECT_VERSION}"
        MACOSX_BUNDLE_GUI_IDENTIFIER "com.anthonyj.superhangongl"
        MACOSX_BUNDLE_INFO_PLIST "${BUNDLE_PLIST_PATH}" 
        MACOSX_BUNDLE_ICON_FILE ""
        RESOURCE "${PROJECT_RESOURCES}"
        XCODE_ATTRIBUTE_CODE_SIGN_IDENTITY             ""
        XCODE_ATTRIBUTE_CODE_SIGNING_REQUIRED          NO
        XCODE_ATTRIBUTE_DEBUG_INFORMATION_FORMAT       dwarf
        XCODE_ATTRIBUTE_GCC_INLINES_ARE_PRIVATE_EXTERN YES
        XCODE_ATTRIBUTE_CLANG_LINK_OBJC_RUNTIME        NO
    )

    add_custom_command(TARGET ${PROJECT_NAME} PRE_BUILD
        COMMAND ${CMAKE_COMMAND} -E make_directory "${CMAKE_CURRENT_BINARY_DIR}/${PROJECT_NAME}.app/Contents/Frameworks"
    )

    add_custom_command(TARGET ${PROJECT_NAME} POST_BUILD
        COMMAND ${CMAKE_COMMAND} -E copy ${RAYLIB_LIBS} "${CMAKE_CURRENT_BINARY_DIR}/${PROJECT_NAME}.app/Contents/Frameworks"
    )



elseif (LINUX)

    set(LINUX_APPDIR_PATH "${CMAKE_BINARY_DIR}/${PROJECT_NAME}.AppDir")
    set(LINUX_APPDIR_PREFIX "usr")
    
    set(LINUX_APPDIR_BIN_DIR "${LINUX_APPDIR_PATH}/${LINUX_APPDIR_PREFIX}/bin")
    set(LINUX_APPDIR_LIB_DIR "${LINUX_APPDIR_PATH}/${LINUX_APPDIR_PREFIX}/lib")
    set(LINUX_APPDIR_SHARE_DIR "${LINUX_APPDIR_PATH}/${LINUX_APPDIR_PREFIX}/share")

    add_custom_command(TARGET ${PROJECT_NAME} PRE_BUILD 
        COMMAND ${CMAKE_COMMAND} -E make_directory "${LINUX_APPDIR_PATH}"
        COMMAND ${CMAKE_COMMAND} -E make_directory "${LINUX_APPDIR_PATH}/${LINUX_APPDIR_PREFIX}"
        COMMAND ${CMAKE_COMMAND} -E make_directory "${LINUX_APPDIR_BIN_DIR}"
        COMMAND ${CMAKE_COMMAND} -E make_directory "${LINUX_APPDIR_LIB_DIR}"
        COMMAND ${CMAKE_COMMAND} -E make_directory "${LINUX_APPDIR_SHARE_DIR}"
    )

    set(APPIMAGE_DESKTOP_PATH "${PROJECT_RESOURCES_DIR}/Linux/Sonic The Hedgehog SMS.desktop")
    set(APPIMAGE_APPRUN_PATH "${PROJECT_RESOURCES_DIR}/Linux/AppRun")
    set(APPIMAGE_ICON_PATH "${PROJECT_RESOURCES_DIR}/icon.png")

    add_custom_command(TARGET ${PROJECT_NAME} POST_BUILD 
        COMMAND ${CMAKE_COMMAND} -E copy "${APPIMAGE_DESKTOP_PATH}" "${APPIMAGE_APPRUN_PATH}" "${APPIMAGE_ICON_PATH}" "${LINUX_APPDIR_PATH}"
        COMMAND ${CMAKE_COMMAND} -E copy $<TARGET_FILE:${PROJECT_NAME}> "${LINUX_APPDIR_BIN_DIR}"
        COMMAND ${CMAKE_COMMAND} -E copy ${RAYLIB_LIBS} "${LINUX_APPDIR_LIB_DIR}"
        COMMAND ${CMAKE_COMMAND} -E copy ${PROJECT_RESOURCES} "${LINUX_APPDIR_SHARE_DIR}"
    )

    if (${CMAKE_HOST_SYSTEM_PROCESSOR} MATCHES "x86_64")
        add_custom_command(
            TARGET ${PROJECT_NAME}
            POST_BUILD
            COMMAND ${PARENT_LIST_PATH}/Tools/Linux/appimagetool-x86_64.AppImage
            ARGS "${LINUX_APPDIR_PATH}"
        )
    elseif (${CMAKE_HOST_SYSTEM_PROCESSOR} MATCHES "i686" OR ${CMAKE_HOST_SYSTEM_PROCESSOR} MATCHES "i386")

    endif()


endif()