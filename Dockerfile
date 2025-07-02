# ベースイメージ
ARG RUBY_VERSION=3.2.4
FROM ruby:$RUBY_VERSION

# 環境変数
ENV LANG C.UTF-8
ENV TZ Asia/Tokyo
ENV RAILS_ENV=production \
    BUNDLE_DEPLOYMENT=1 \
    BUNDLE_PATH=/usr/local/bundle \
    BUNDLE_WITHOUT="development:test"

# 必要パッケージのインストール
RUN apt-get update -qq && \
    apt-get install -y --no-install-recommends \
    build-essential \
    libpq-dev \
    libmariadb-dev-compat \
    libmariadb-dev \
    curl \
    gnupg \
    && curl -fsSL https://deb.nodesource.com/setup_18.x | bash - \
    && apt-get install -y nodejs \
    && npm install -g yarn \
    && rm -rf /var/lib/apt/lists/* /var/cache/apt/archives

# Bundler を Ruby 3.2.4 に対応する最新安定版（2.4.22）に上書きインストール
RUN gem install bundler -v 2.4.22

# 作業ディレクトリ作成
WORKDIR /app

# Gemfile と lock を先にコピーしてインストール
COPY Gemfile Gemfile.lock ./
RUN bundle config set frozen false && \
    bundle install

# yarn install
COPY yarn.lock ./
RUN yarn install

# アプリケーション本体をコピー
COPY . .

# アセットプリコンパイル
RUN bundle exec rake assets:precompile

# ポート公開（Render 用）
EXPOSE 3000

# サーバー起動コマンド
CMD ["bundle", "exec", "puma", "-C", "config/puma.rb"]
