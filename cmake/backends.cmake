set(IMGUI_SYSTEM_BACKENDS
    win32
)

set(IMGUI_GRAPHICS_BACKENDS
    dx11
    dx12
)

foreach(b IN LISTS IMGUI_SYSTEM_BACKENDS)
    string(TOUPPER "${b}" B)
    option(IMGUI_BACKEND_${B} "Enable ImGui ${b} backend" OFF)
endforeach()

foreach(b IN LISTS IMGUI_GRAPHICS_BACKENDS)
    string(TOUPPER "${b}" B)
    option(IMGUI_BACKEND_${B} "Enable ImGui ${b} backend" OFF)
endforeach()

function(count_enabled prefix backends out_var)
    set(count 0)
    set(last "")
    foreach(b IN LISTS backends)
        string(TOUPPER "${b}" B)
        if(${prefix}_${B})
            math(EXPR count "${count} + 1")
            set(last "${B}")
        endif()
    endforeach()
    set(${out_var}_COUNT "${count}" PARENT_SCOPE)
    set(${out_var}_LAST  "${last}"  PARENT_SCOPE)
endfunction()

count_enabled(IMGUI_BACKEND ${IMGUI_SYSTEM_BACKENDS} SYSTEM)
count_enabled(IMGUI_BACKEND ${IMGUI_GRAPHICS_BACKENDS} GFX)

# Exactly one system backend
if(SYSTEM_COUNT GREATER 1)
    message(FATAL_ERROR
        "Multiple ImGui system backends enabled. Choose exactly one.")
elseif(SYSTEM_COUNT EQUAL 0)
    message(FATAL_ERROR
        "No ImGui system backend enabled. Choose exactly one.")
endif()

# Exactly one graphics backend
if(GFX_COUNT GREATER 1)
    message(FATAL_ERROR
        "Multiple ImGui graphics backends enabled. Choose exactly one.")
elseif(GFX_COUNT EQUAL 0)
    message(FATAL_ERROR
        "No ImGui graphics backend enabled. Choose exactly one.")
endif()

set(IMGUI_BACKEND_SOURCES "")
set(IMGUI_BACKEND_HEADERS "")

if (IMGUI_BACKEND_WIN32)
    list(APPEND IMGUI_BACKEND_SOURCES
        "${CMAKE_CURRENT_SOURCE_DIR}/src/imgui_impl_win32.cpp"
    )

    list(APPEND IMGUI_BACKEND_HEADERS
        "${CMAKE_CURRENT_SOURCE_DIR}/include/imgui/backends/imgui_impl_win32.h"
    )
endif()

if (IMGUI_BACKEND_DX11)
    list(APPEND IMGUI_BACKEND_SOURCES
        "${CMAKE_CURRENT_SOURCE_DIR}/src/imgui_impl_dx11.cpp"
    )

    list(APPEND IMGUI_BACKEND_HEADERS
        "${CMAKE_CURRENT_SOURCE_DIR}/include/imgui/backends/imgui_impl_dx11.h"
    )
endif()

if (IMGUI_BACKEND_DX12)
    list(APPEND IMGUI_BACKEND_SOURCES
        "${CMAKE_CURRENT_SOURCE_DIR}/src/imgui_impl_dx12.cpp"
    )

    list(APPEND IMGUI_BACKEND_HEADERS
        "${CMAKE_CURRENT_SOURCE_DIR}/include/imgui/backends/imgui_impl_dx12.h"
    )
endif()

message(STATUS "ImGui system backend: ${SYSTEM_LAST}")
message(STATUS "ImGui graphics backend: ${GFX_LAST}")