@echo off
setlocal EnableDelayedExpansion

bazel "--output_user_root=C:\broot" "build" "--repository_cache=" "--nobuild_python_zip" "--enable_runfiles" --action_env="USERPROFILE=%USERPROFILE%" --host_action_env="USERPROFILE=%USERPROFILE%" ":wheel"
%PYTHON% -m pip install -vv --no-deps --no-build-isolation  bazel-bin\dist\snowflake_ml_python-%PKG_VERSION%-py3-none-any.whl
bazel "clean" "--expunge"
bazel "shutdown"

@REM Some handles are hold by java.exe/micromamba, and prevent conda-build to
@REM delete/move/rename certain folders and files (e.g. work, and temporary).
@REM Killing java.exe serves to release such handles and allow conda-build
@REM to progress with the next builds for different python versions.
taskkill /IM "java.exe" /F