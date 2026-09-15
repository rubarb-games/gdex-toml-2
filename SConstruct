#!/usr/bin/env python
import os
import sys

AddOption(
    '--mode',
    dest='mode',
    type='string',
    nargs=1,
    action='store',
    default='release',
    help='Specify build mode: debug or release',
)

build_mode = GetOption('mode')

env = SConscript("godot-cpp/SConstruct")

# For the reference:
# - CCFLAGS are compilation flags shared between C and C++
# - CFLAGS are for C-specific compilation flags
# - CXXFLAGS are for C++-specific compilation flags
# - CPPFLAGS are for pre-processor flags
# - CPPDEFINES are for pre-processor defines
# - LINKFLAGS are for linking flags

def add_sources(sources, dir, extension):
    for f in os.listdir(dir):
        if f.endswith("." + extension):
            sources.append(dir + "/" + f)

sources = []
add_sources(sources, "src", "cpp")

# tweak this if you want to use different folders, or more folders, to store your source code in.
env.Append(CPPPATH=["src/", "include/"])

env['SHLIBPREFIX'] = ''

# -g: Generates native OS debugging information needed to use tools like gdb.
# -O0: Default mode. No optimization is performed; maximizes compilation speed and debugging clarity.
# -O1: Basic optimization. Reduces code size and execution time without major compilation cost.
# -O2: Recommended optimization. Turns on nearly all supported optimizations that do not involve a speed-space tradeoff.
# -O3: Maximum standard optimization. Turns on aggressive vectorization and loop transformations (can increase binary size).
# -Os: Optimizes for size. Enables all -O2 optimizations that do not typically increase code size.
# -Ofast: Aggressive optimization. Disregards strict standards compliance (e.g., enables -ffast-math for faster but potentially less precise math)

ccflags = []
cxxflags = []

if build_mode == 'debug':
    ccflags.append('-g')
    # env.Append(CCFLAGS=['-g'])
    target_name = 'gdex_toml_2.{}.debug{}'.format(env["platform"], env["SHLIBSUFFIX"])
else:
    ccflags.append('-O3')
    # env.Append(CCFLAGS=['-O3'])
    target_name = 'gdex_toml_2.{}.release{}'.format(env["platform"], env["SHLIBSUFFIX"])

# Detect compiler and apply the correct C++20 flag
if 'gcc' in env['CXX'] or 'g++' in env['CXX']:
    cxxflags.append('-std=c++20')
    # env.Append(CXXFLAGS=['-std=c++20'])
elif 'clang' in env['CXX']:
    cxxflags.append('-std=c++20')
    # env.Append(CXXFLAGS=['-std=c++20'])
elif 'cl' in env['CXX']:  # MSVC (Windows)
    cxxflags.append('/std:c++20')
    # env.Append(CXXFLAGS=['/std:c++20'])

env.Append(CCFLAGS=ccflags)
env.Append(CXXFLAGS=cxxflags)

if env["platform"] == "macos":
    library = env.SharedLibrary(
        "output/{}".format(target_name),
        source=sources,
    )
else:
    library = env.SharedLibrary(
        "output/{}".format(target_name),
        source=sources,
    )

Default(library)