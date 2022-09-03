cmake_minimum_required(VERSION 3.8)
project (app)

set(CMAKE_CXX_STANDARD 17)
set(CMAKE_CXX_STANDARD_REQUIRED ON)
set(CMAKE_EXPORT_COMPILE_COMMANDS ON)
set(CMAKE_RUNTIME_OUTPUT_DIRECTORY_RELEASE "${CMAKE_CURRENT_SOURCE_DIR}/bin")

add_executable(main Source/BasicApp.cpp)

target_include_directories(main PRIVATE
  Source/
  lib/Cinder/include
  )

target_link_directories(main PRIVATE
  lib/Cinder/lib/msw/x64
  lib/Cinder/lib/msw/x64/Release/v142
  )

target_link_libraries(main
  cinder.lib
  OpenGL32.lib
  kernel32.lib
  user32.lib
  gdi32.lib
  winspool.lib
  comdlg32.lib
  advapi32.lib
  shell32.lib
  ole32.lib
  oleaut32.lib
  uuid.lib
  odbc32.lib
  odbccp32.lib
  )

target_compile_definitions(main PRIVATE WIN32 NDEBUG _WINDOWS NOMINMAX _WIN32_WINNT=0x0502 _UNICODE UNICODE)
target_compile_options(main PRIVATE /MT /MP /Gm- /EHsc /nologo /W3 /Od)
target_link_options(main PRIVATE /INCREMENTAL:NO /NOLOGO /SUBSYSTEM:WINDOWS /OPT:NOREF /MACHINE:X64 /DYNAMICBASE:NO)
