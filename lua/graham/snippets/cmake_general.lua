-- ~/.config/nvim/LuaSnip/snippets/cmake_general.lua
-- CMake snippets for LuaSnip
--
-- These snippets provide ready-to-use templates for:
--  - new CMake projects
--  - library projects
--  - minimal executables
--  - modern FetchContent usage
--
-- Trigger them by typing e.g. `cmake_project` or `cmake_library` in a CMakeLists.txt file.

local ls = require "luasnip"
local s = ls.snippet
local t = ls.text_node
local i = ls.insert_node
local fmt = require("luasnip.extras.fmt").fmt
local rep = require("luasnip.extras").rep

-- Defaults for convenience
local defaults = {
  cmake_ver = "3.16",
  proj_ver = "0.1.0",
  cpp_std = "17",
}

ls.add_snippets("cmake", {

  -- Base snippet: new CMake project
  s("cmake_project",
    fmt([[
cmake_minimum_required(VERSION {})
project({} VERSION {} LANGUAGES CXX)

set(CMAKE_CXX_STANDARD {})
set(CMAKE_CXX_STANDARD_REQUIRED ON)
set(CMAKE_EXPORT_COMPILE_COMMANDS ON)

add_executable({} src/main.cpp)

target_include_directories({}
  PRIVATE
    include
)

target_link_libraries({}
  PRIVATE
    {}
)

# install(TARGETS {} DESTINATION bin)
]], {
      i(1, defaults.cmake_ver), -- cmake version
      i(2, "MyProject"),        -- project name
      i(3, defaults.proj_ver),  -- project version
      i(4, defaults.cpp_std),   -- C++ standard
      rep(2),                   -- executable target
      rep(2),                   -- include target
      rep(2),                   -- link target
      i(5, "pthread"),          -- linked libs
      rep(2),
    })
  ),

  -- Library snippet
  s("cmake_library",
    fmt([[
cmake_minimum_required(VERSION {})
project({} VERSION {} LANGUAGES CXX)

set(CMAKE_CXX_STANDARD {})
set(CMAKE_CXX_STANDARD_REQUIRED ON)

add_library({} {}
    src/{}.cpp
)

target_include_directories({}
  PUBLIC
    include
)

target_link_libraries({}
  PUBLIC
    {}
)

# install(TARGETS {} DESTINATION lib)
]], {
      i(1, defaults.cmake_ver),
      i(2, "MyLib"),
      i(3, defaults.proj_ver),
      i(4, defaults.cpp_std),
      rep(2),
      i(5, "STATIC"), -- <–– new insert node for type
      i(6, "MyLib"),
      rep(2),
      rep(2),
      i(7, "otherlib"),
      rep(2),
    })
  ),

  -- Minimal example
  s("cmake_min", fmt([[
cmake_minimum_required(VERSION {})
project({})

add_executable({} src/main.cpp)
]], {
    i(1, defaults.cmake_ver),
    i(2, "ProjectName"),
    i(3, "app"),
  })
  ),

  -- Modern FetchContent example
  s("cmake_fetchcontent",
    fmt([[
cmake_minimum_required(VERSION {})
project({} VERSION {} LANGUAGES CXX)

include(FetchContent)

FetchContent_Declare(
  {}
  GIT_REPOSITORY {}
  GIT_TAG {}
)

FetchContent_MakeAvailable({})

add_executable({} src/main.cpp)
target_link_libraries({}
  PRIVATE
    {}
)
]], {
      i(1, defaults.cmake_ver),
      i(2, "MyProject"),
      i(3, defaults.proj_ver),
      i(4, "external_lib_name"),
      i(5, "https://github.com/org/repo.git"),
      i(6, "main"),
      rep(4),
      i(7, "my_executable"),
      rep(7),
      rep(4),
    })
  ),
})
