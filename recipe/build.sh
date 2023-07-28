# This hack is necessary because bazel produces a Python script with
# "#! /usr/bin/python" at the top. On CI systems this is a problem,
# but only on Linux.
if [ "$(uname)" == "Linux" ]; then
    if [! -f /usr/bin/python ] || [ -L /usr/bin/python ]; then
        rm /usr/bin/python || true
        ln -s %PYTHON% python
    fi
fi

# Build the wheel.
bazel build --subcommands //snowflake/ml:wheel

# Install it.
${PYTHON} -m pip install -vv --no-deps --no-build-isolation bazel-bin/snowflake/ml/*.whl

# Clean up.
bazel clean --expunge
bazel shutdown