FROM ruby:3.1.4

ENV LANG C.UTF-8
ENV TZ Asia/Tokyo

# Node.js, Yarn, PostgreSQL開発に必要なパッケージをインストール
RUN apt-get update -qq && \
    apt-get install -y ca-certificates curl gnupg && \
    mkdir -p /etc/apt/keyrings && \
    curl -fsSL https://deb.nodesource.com/gpgkey/nodesource-repo.gpg.key | gpg --dearmor -o /etc/apt/keyrings/nodesource.gpg && \
    echo "deb [signed-by=/etc/apt/keyrings/nodesource.gpg] https://deb.nodesource.com/node_19.x nodistro main" > /etc/apt/sources.list.d/nodesource.list && \
    curl -fsSL https://dl.yarnpkg.com/debian/pubkey.gpg | gpg --dearmor -o /usr/share/keyrings/yarn-archive-keyring.gpg && \
    echo "deb [signed-by=/usr/share/keyrings/yarn-archive-keyring.gpg] https://dl.yarnpkg.com/debian/ stable main" > /etc/apt/sources.list.d/yarn.list && \
    apt-get update -qq && \
    apt-get install -y build-essential libpq-dev nodejs yarn

# アプリディレクトリ作成・移動
RUN mkdir /v3_apuri
WORKDIR /v3_apuri

# bundlerをインストール
RUN gem install bundler:2.3.17

# Gemfile系を先にコピー（キャッシュ効率のため）
COPY Gemfile /v3_apuri/Gemfile
COPY Gemfile.lock /v3_apuri/Gemfile.lock
COPY yarn.lock /v3_apuri/yarn.lock

# Ruby & JSライブラリをインストール
RUN bundle install
RUN yarn install

# アプリ本体をすべてコピー（←ここ全角スペース直しました）
COPY . /v3_apuri
