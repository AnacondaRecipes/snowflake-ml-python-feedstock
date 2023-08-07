rem Build the wheel.
bazel --output_user_root=C:\bazelcrap build --subcommands --verbose_failures --build_python_zip=false --enable_runfiles=true --action_env="USERPROFILE=%USERPROFILE%" --host_action_env="USERPROFILE=%USERPROFILE%" --action_env="CONDA_DLL_SEARCH_MODIFICATION_ENABLE=1" --host_action_env="CONDA_DLL_SEARCH_MODIFICATION_ENABLE=1" //snowflake/ml:wheel

rem Install it.
FOR /F "delims=" %%i IN ('dir C:\bazelcrap /b /ad-h /t:w /od') DO SET a=%%i
%PYTHON% -m pip install -vv --no-deps --no-build-isolation C:\bazelcrap\%a%\execroot\SnowML\bazel-out\x64_windows-fastbuild\bin\snowflake\ml\snowflake_ml_python-1.0.4-py3-none-any.whl

rem Clean up.
bazel shutdown