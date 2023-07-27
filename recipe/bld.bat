rem Build the wheel.
bazel --output_user_root=C:\bazelcrap build --subcommands --verbose_failures --build_python_zip=false --enable_runfiles=true --action_env="USERPROFILE=%USERPROFILE%" --host_action_env="USERPROFILE=%USERPROFILE%" //snowflake/ml:wheel

rem Install it.
FOR /F "delims=" %%i IN ('dir C:\bazelcrap /b /ad-h /t:w /od') DO SET a=%%i
%PYTHON% -m pip install -vv --no-deps --no-build-isolation C:\bazelcrap\%a%\execroot\SnowML\bazel-out\x64_windows-fastbuild\bin\snowflake\ml\*.whl

rem Clean up.
bazel shutdown
