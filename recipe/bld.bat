@echo off
setlocal EnableDelayedExpansion

@REM max_idle_secs=1 will make the idle server to shutdown after 1 second
@REM that is idle
bazel "--output_user_root=C:\broot" --max_idle_secs=1 "build" "--repository_cache=" "--nobuild_python_zip" "--enable_runfiles" --action_env="USERPROFILE=%USERPROFILE%" --host_action_env="USERPROFILE=%USERPROFILE%" ":wheel"
%PYTHON% -m pip install -vv --no-deps --no-build-isolation  bazel-bin\dist\snowflake_ml_python-%PKG_VERSION%-py3-none-any.whl

@REM removes the entire output base tree which, in addition to the 
@REM build output, contains all temp files created by Bazel. 
@REM NB: It also stops the Bazel server after the clean, equivalent 
@REM to the shutdown command -> do NOT run "bazel shutdown" after
@REM this, or it will create a zombie java.exe holding some handles
@REM that prevent conda-build to delete/move/rename certain folders 
@REM and files (e.g. work, and temporary).
bazel "clean" "--expunge"
