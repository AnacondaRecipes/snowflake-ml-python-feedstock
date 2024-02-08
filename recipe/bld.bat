@echo off
setlocal EnableDelayedExpansion

bazel "--output_user_root=C:\broot" "build" "--repository_cache=" "--nobuild_python_zip" "--enable_runfiles" --action_env="USERPROFILE=%USERPROFILE%" --host_action_env="USERPROFILE=%USERPROFILE%" ":wheel"
%PYTHON% -m pip install -vv --no-deps --no-build-isolation  bazel-bin\dist\snowflake_ml_python-%PKG_VERSION%-py3-none-any.whl
bazel "clean" "--expunge"
bazel "shutdown"
