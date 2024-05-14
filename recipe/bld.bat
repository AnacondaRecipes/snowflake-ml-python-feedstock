@echo off
setlocal EnableDelayedExpansion

@REM max_idle_secs=1 will make the idle server to shutdown after 1 second
@REM that is idle, after the command "bazel shutdown".
@REM 
@REM Please do NOT remove it, see comment below about "bazel shutdown"

bazel "--output_user_root=C:\broot" --max_idle_secs=1 "build" "--repository_cache=" "--nobuild_python_zip" "--enable_runfiles" --action_env="USERPROFILE=%USERPROFILE%" --host_action_env="USERPROFILE=%USERPROFILE%" ":wheel"

@REM build

%PYTHON% -m pip install -vv --no-deps --no-build-isolation  bazel-bin\dist\snowflake_ml_python-%PKG_VERSION%-py3-none-any.whl

@REM removes the entire output base tree which, in addition to the 
@REM build output, contains all temp files created by Bazel. 
@REM NB: It also stops the Bazel server after the clean, equivalent 
@REM to the shutdown command. Nevertheless, if we do not run also
@REM the "bazel shutdown", the next build will fail for some reason.
@REM 
@REM See: https://bazel.build/docs/user-manual#clean

bazel clean --expunge

@REM The command "bazel shutdown" will create a zombie java.exe holding
@REM some handles that prevent conda-build to delete/move/rename certain
@REM folders and files (e.g. work, and temporary).
@REM For this reason, the parameter max_idle_secs=1 in the bazel build
@REM is essential and it should NOT be removed.

bazel shutdown
