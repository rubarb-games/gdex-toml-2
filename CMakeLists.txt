cmake_minimum_required(VERSION 4.0)

project(gdex-toml-2)
set(CMAKE_CXX_STANDARD 20)
# Turn on link time optimization for everything
set( CMAKE_INTERPROCEDURAL_OPTIMIZATION_RELEASE ON )

#if (NOT TARGET godot-cpp)
include(FetchContent)
FetchContent_Declare(
    godot-cpp
    GIT_REPOSITORY https://github.com/godotengine/godot-cpp
    GIT_TAG 4.5
)
FetchContent_MakeAvailable(godot-cpp)
#endif()
set( GODOT_CPP_SYSTEM_HEADERS ON CACHE BOOL "" FORCE )

add_library(${PROJECT_NAME} SHARED)
add_subdirectory(src)

#target_compile_features(${PROJECT_NAME} PRIVATE cxx_std_20)

target_link_libraries(${PROJECT_NAME}
    PUBLIC
        godot::cpp
)
set_target_properties( godot-cpp
    PROPERTIES
    CXX_VISIBILITY_PRESET hidden    # visibility needs to be the same as the main library
)

target_include_directories(${PROJECT_NAME}
    PRIVATE
        include
)
#set_target_properties( ${PROJECT_NAME}
#    PROPERTIES
#    CXX_VISIBILITY_PRESET hidden
#    VISIBILITY_INLINES_HIDDEN true
#    RUNTIME_OUTPUT_DIRECTORY "${BUILD_OUTPUT_DIR}/${LIB_DIR}"
#    LIBRARY_OUTPUT_DIRECTORY "${BUILD_OUTPUT_DIR}/${LIB_DIR}"
#)