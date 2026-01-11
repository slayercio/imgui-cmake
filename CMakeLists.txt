cmake_minimum_required(VERSION 4.0)
project(imgui VERSION 1.0.0 LANGUAGES CXX)

set(CMAKE_CXX_STANDARD 20)
set(CMAKE_CXX_STANDARD_REQUIRED ON)
set(CMAKE_CXX_EXTENSIONS OFF)

include(cmake/backends.cmake)
set(IMGUI_SOURCES
    ${IMGUI_BACKEND_SOURCES}
    ${CMAKE_CURRENT_SOURCE_DIR}/imgui_draw.cpp
    ${CMAKE_CURRENT_SOURCE_DIR}/imgui_tables.cpp
    ${CMAKE_CURRENT_SOURCE_DIR}/imgui_widgets.cpp
    ${CMAKE_CURRENT_SOURCE_DIR}/imgui.cpp
    ${IMGUI_BACKEND_HEADERS}
)

option(IMGUI_DEMO "Build ImGui demo source file" OFF)
if(IMGUI_DEMO)
    list(APPEND IMGUI_SOURCES ${CMAKE_CURRENT_SOURCE_DIR}/imgui_demo.cpp)
endif()

add_library(imgui STATIC ${IMGUI_SOURCES})
target_include_directories(imgui PUBLIC ${CMAKE_CURRENT_SOURCE_DIR})
