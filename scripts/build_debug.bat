@echo off

set "VSCMD_START_DIR=%cd%"
call "C:\Program Files\Microsoft Visual Studio\2022\Community\VC\Auxiliary\Build\vcvarsall.bat" x64
call "%PLAYDATE_SDK_PATH%\bin\kill-playdate.bat"

pushd ..
if not exist build_sim mkdir build_sim
pushd build_sim

cmake .. -G "NMake Makefiles"
nmake

popd
popd

pushd ..
if not exist build_dev mkdir build_dev
pushd build_dev

cmake .. -G "NMake Makefiles" --toolchain=%PLAYDATE_SDK_PATH%/C_API/buildsupport/arm.cmake
nmake

popd
popd

call "%PLAYDATE_SDK_PATH%\bin\PlaydateSimulator.exe"
