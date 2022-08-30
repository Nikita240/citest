FROM ubuntu:20.04

ARG DEBIAN_FRONTEND=noninteractive

# http://bugs.python.org/issue19846
# > At the moment, setting "LANG=C" on a Linux system *fundamentally breaks Python 3*, and that's not OK.
ENV LANG C.UTF-8

RUN apt-get update && apt-get install --no-install-recommends --yes \
    make \
    build-essential \
    libssl-dev \
    zlib1g-dev \
    libbz2-dev \
    libreadline-dev \
    libsqlite3-dev \
    wget \
    curl \
    llvm \
    libncursesw5-dev \
    xz-utils \
    tk-dev \
    libxml2-dev \
    libxmlsec1-dev \
    libffi-dev \
    liblzma-dev \
    ca-certificates \
    git \
    ssh \
    vim \
    && rm -rf /var/lib/apt/lists/*

ENV HOME="/root"

ENV PYENV_ROOT="${HOME}/.pyenv"
ENV PATH="${PYENV_ROOT}/shims:${PYENV_ROOT}/bin:${HOME}/.local/bin:$PATH"

RUN curl https://pyenv.run | bash
RUN pyenv init - && pyenv virtualenv-init - && \
    pyenv install 3.8.13 && \
    pyenv global 3.8.13

RUN curl -sSL https://install.python-poetry.org | python - --preview
RUN poetry config virtualenvs.prefer-active-python true

RUN pip install --upgrade nox pre-commit
