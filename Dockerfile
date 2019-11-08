ARG TEST_IMAGE=pycontribs/centos:7

FROM $TEST_IMAGE
# pycontribs just contains pre-installed python
ADD . /app
WORKDIR /app

RUN PY=`command -v python3 python 2>/dev/null | head -1` && \
$PY --version && \
$PY -m pip install . && \
$PY -m pre_commit run --color=always -v -a || \
{ cat /root/.cache/pre-commit/pre-commit.log; exit 1; }
