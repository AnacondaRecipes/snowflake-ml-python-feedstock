# This hack is necessary because bazel produces a Python script with
# "#! /usr/bin/python3" at the top. On CI systems this is a problem,
# but only on Linux.
if [ "$(uname)" == "Linux" ]; then
    if [ ! -f /usr/bin/python3 ] || [ -L /usr/bin/python3 ]; then
        rm /usr/bin/python3 || true
        ln -s ${PYTHON} /usr/bin/python3
    fi
fi

# Build the wheel.
bazel --max_idle_secs=1 build --subcommands //:wheel

# Install it.
${PYTHON} -m pip install -vv --no-deps --no-build-isolation bazel-bin/dist/snowflake_ml_python-$PKG_VERSION-py3-none-any.whl

# Clean up.
bazel clean --expunge
bazel shutdown