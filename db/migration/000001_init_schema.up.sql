-- tabela de usuários
CREATE TABLE users (
  id BIGSERIAL PRIMARY KEY,
  username VARCHAR UNIQUE NOT NULL,
  created_at TIMESTAMPTZ DEFAULT now()
);

-- informações financeiras de cada usuário
CREATE TABLE cash_infos (
  id BIGSERIAL PRIMARY KEY,
  user_id BIGINT NOT NULL,
  balance NUMERIC(18,2),
  CONSTRAINT fk_cash_user FOREIGN KEY (user_id) REFERENCES users (id)
);

-- países
CREATE TABLE countries (
  id BIGSERIAL PRIMARY KEY,
  name VARCHAR,
  coin VARCHAR,
  coin_symbol VARCHAR
);

-- salários
CREATE TABLE wages (
  id BIGSERIAL PRIMARY KEY,
  user_id BIGINT NOT NULL,
  amount NUMERIC(18,2),
  created_at TIMESTAMPTZ DEFAULT now(),
  country_id BIGINT NOT NULL,
  CONSTRAINT fk_wage_user FOREIGN KEY (user_id) REFERENCES users (id),
  CONSTRAINT fk_wage_country FOREIGN KEY (country_id) REFERENCES countries (id)
);

-- despesas
CREATE TABLE expenses (
  id BIGSERIAL PRIMARY KEY,
  user_id BIGINT NOT NULL,
  amount NUMERIC(18,2),
  category VARCHAR NOT NULL,
  created_at TIMESTAMPTZ DEFAULT now(),
  country_id BIGINT NOT NULL,
  CONSTRAINT fk_expense_user FOREIGN KEY (user_id) REFERENCES users (id),
  CONSTRAINT fk_expense_country FOREIGN KEY (country_id) REFERENCES countries (id)
);

-- despesas mensais agregadas
CREATE TABLE month_expenses (
  id BIGSERIAL PRIMARY KEY,
  user_id BIGINT NOT NULL,
  currently NUMERIC(18,2),
  created_at TIMESTAMPTZ DEFAULT now(),
  CONSTRAINT fk_month_expense_user FOREIGN KEY (user_id) REFERENCES users (id)
);
