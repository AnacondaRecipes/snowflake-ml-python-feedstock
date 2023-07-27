# Build the wheel.
bazel build --subcommands //snowflake/ml:wheel

# Install it.
${PYTHON} -m pip install -vv --no-deps --no-build-isolation bazel-bin/snowflake/ml/*.whl

# Clean up.
bazel clean --expunge
bazel shutdown