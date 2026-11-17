# Orgânicos — Supermercado Virtual

**Idioma / Language:** **🇵🇹 Português** | [🇬🇧 English](README.en.md)

**Aplicação web de comércio eletrónico desenvolvida com PHP, MySQL, JavaScript, HTML e CSS.**

Este projeto simula o funcionamento de um supermercado online: permite consultar e pesquisar produtos, criar uma conta, gerir o carrinho, finalizar encomendas e consultar o histórico de compras. Inclui também um painel de administração para gestão do catálogo, dos utilizadores e das encomendas.

Foi desenvolvido como projeto de aprendizagem e de demonstração de competências de **desenvolvimento web full-stack**, com particular atenção a **PHP, bases de dados relacionais, segurança web, integração com serviços externos e automatização da publicação**.

**[Ver aplicação online](https://abarrosk.rf.gd/homepage.php)** · **[Consultar o código-fonte](https://github.com/Abarrosk/supermercado_virtual_final)**

> **Nota:** trata-se de uma aplicação demonstrativa, não de uma loja comercial. Não processa pagamentos reais.

---

## Índice

1. [Funcionalidades da aplicação](#funcionalidades-da-aplicação)
2. [Tecnologias e bibliotecas](#tecnologias-e-bibliotecas)
3. [Segurança web](#segurança-web)
4. [Programação orientada a objetos e padrões de desenho](#programação-orientada-a-objetos-e-padrões-de-desenho)
5. [Outros conceitos de programação](#outros-conceitos-de-programação)
6. [Base de dados](#base-de-dados)
7. [Integração com serviços externos](#integração-com-serviços-externos)
8. [Arquitetura e organização](#arquitetura-e-organização)
9. [Publicação automatizada](#publicação-automatizada)
10. [Execução local](#execução-local)
11. [Limitações e melhorias futuras](#limitações-e-melhorias-futuras)

## Funcionalidades da aplicação

### Catálogo e pesquisa

- Apresentação dinâmica de produtos obtidos da base de dados MySQL.
- Organização de produtos por categorias.
- Pesquisa por nome, utilizando `LIKE` e consultas parametrizadas.
- Listagens de produtos **mais vendidos**, **em destaque**, **populares**, **recentes** e **aleatórios**, a partir dos respetivos campos da base de dados.
- Filtros por categoria e opção para apresentar todos os resultados.
- Gestão de promoções, com preço promocional, percentagem de desconto e data de validade.
- Cartões de produto gerados através de uma função PHP reutilizável.
- **Carregamento diferido de imagens** com `loading="lazy"` nos cartões de produto.
- Interface adaptável a diferentes dimensões de ecrã e carrosséis de produtos.

**Código principal:** [`inc/products.php`](inc/products.php), [`inc/search.php`](inc/search.php), [`inc/render_card.php`](inc/render_card.php), [`homepage.php`](homepage.php) e [`comprar.php`](comprar.php).

### Autenticação e área de cliente

- Registo de utilizadores com validação de campos e verificação de emails duplicados.
- **Início de sessão automático após o registo** de uma conta.
- Validação de passwords no registo (mínimo de oito caracteres, uma letra e um número) e confirmação da password introduzida.
- Alternância entre mostrar e ocultar passwords, com suporte a interações por rato, toque e teclado.
- Autenticação através de email e password.
- Gestão de sessões PHP e encerramento de sessão.
- Consulta e atualização de informações pessoais.
- Alteração de password mediante confirmação da password atual.
- Consulta do histórico de encomendas do utilizador autenticado.
- Distinção entre contas normais e contas de administração.

**Código principal:** [`inc/auth.php`](inc/auth.php), [`login.php`](login.php), [`registar.php`](registar.php) e [`userProfile.php`](userProfile.php).

### Carrinho, checkout e encomendas

- Adição de produtos e acumulação de quantidades no carrinho.
- Remoção de artigos e esvaziamento do carrinho.
- Persistência do carrinho através de `$_SESSION`.
- Cálculo de subtotais, descontos e total da encomenda.
- Atualização de valores da interface através de pedidos assíncronos JavaScript.
- Verificação de disponibilidade de stock no checkout.
- Validação dos dados de faturação, incluindo email, morada e data de nascimento.
- **Validação de idade mínima de 18 anos** para concluir uma encomenda.
- Atualização dos dados do perfil do cliente a partir dos dados fornecidos no checkout.
- Endpoint de adição ao carrinho com **respostas JSON para pedidos assíncronos** e **redirecionamento para pedidos tradicionais**.
- Cálculo de portes de envio de acordo com a distância estimada.
- Registo de encomendas e dos respetivos artigos na base de dados.
- Utilização de **transações SQL** durante a criação das encomendas, com `commit()` e `rollBack()`.
- Histórico de compras associado à conta autenticada.

**Código principal:** [`inc/cart.php`](inc/cart.php), [`inc/orders.php`](inc/orders.php), [`checkout.php`](checkout.php), [`js/checkout.js`](js/checkout.js) e [`api/`](api/).

### Painel administrativo

Acesso condicionado ao perfil de administrador, com funcionalidades de:

- Listagem, criação, edição e eliminação de produtos, respeitando as restrições existentes.
- **Proteção das relações com encomendas:** impede a eliminação de produtos que já estejam associados a artigos de encomendas.
- Gestão de categorias associadas aos produtos, preços, promoções, datas e stock.
- Associação e envio de imagens de produtos.
- Organização dos ficheiros de imagem em pastas por categoria, criação das pastas quando necessário e normalização dos nomes dos ficheiros.
- Confirmação de ações administrativas sensíveis na interface, como eliminar produtos ou desativar utilizadores.
- Geração de _slugs_ legíveis e verificação de unicidade.
- Listagem e pesquisa de utilizadores por diversos campos.
- Desativação lógica de contas de utilizadores normais (_soft delete_).
- Consulta e pesquisa de encomendas.
- Visualização dos artigos e restantes detalhes de cada encomenda.

**Código principal:** [`admin_dashboard.php`](admin_dashboard.php) e pasta [`admin/`](admin/).

---

## Tecnologias e bibliotecas

| Área                   | Tecnologias                                            | Utilização                                                           |
| ---------------------- | ------------------------------------------------------ | -------------------------------------------------------------------- |
| Servidor               | **PHP**                                                | Lógica da aplicação, autenticação, sessões, formulários e encomendas |
| Base de dados          | **MySQL / MariaDB**                                    | Persistência relacional de produtos, utilizadores e encomendas       |
| Acesso a dados         | **PDO**                                                | Ligação à base de dados e instruções SQL parametrizadas              |
| Interface              | **HTML5, CSS3, JavaScript**                            | Estrutura, apresentação e interatividade                             |
| Interface responsiva   | **Bootstrap 5**                                        | Grelhas, componentes, formulários, janelas modais e _tooltips_       |
| Bibliotecas JavaScript | **jQuery, Swiper.js 9**                                | Manipulação da interface e carrosséis                                |
| Ícones                 | **Font Awesome, Boxicons, Material Design Icons, SVG** | Elementos gráficos da interface                                      |
| Comunicação assíncrona | **Fetch API, JSON**                                    | Comunicação entre o navegador e os endpoints PHP                     |
| Serviços externos      | **PHP cURL, Nominatim / OpenStreetMap**                | Geocodificação de moradas                                            |
| Controlo de versões    | **Git e GitHub**                                       | Histórico e gestão do código                                         |
| Publicação             | **GitHub Actions, FTPS, InfinityFree**                 | Publicação automática dos ficheiros da aplicação                     |

> A aplicação foi desenvolvida em **PHP sem recurso a Laravel ou Symfony**. Bootstrap é o framework de interface utilizado; PDO, jQuery e Swiper são bibliotecas ou interfaces específicas.

## Segurança web

Foram implementadas várias medidas de proteção, ilustrando conceitos importantes de segurança em aplicações web. A existência destas medidas **não equivale a uma auditoria de segurança nem à ausência de vulnerabilidades**.

| Medida                            | Implementação                                                                                                      | Referência                                                                                           |
| --------------------------------- | ------------------------------------------------------------------------------------------------------------------ | ---------------------------------------------------------------------------------------------------- |
| **Mitigação de SQL Injection**    | Consultas parametrizadas com `PDO::prepare()` e `execute()`; emulação de instruções preparadas desativada          | [`inc/db.php`](inc/db.php), [`inc/auth.php`](inc/auth.php), [`inc/search.php`](inc/search.php)       |
| **Mitigação de XSS**              | Codificação de dados apresentados em HTML com `htmlspecialchars()` e função auxiliar `e()`                         | [`config/bootstrap.php`](config/bootstrap.php)                                                       |
| **Proteção CSRF**                 | Tokens gerados com `random_bytes()`, incluídos em formulários e validados com `hash_equals()`                      | [`inc/csrf.php`](inc/csrf.php)                                                                       |
| **Proteção de passwords**         | `password_hash()` e `password_verify()`; Argon2id quando disponível, com alternativa configurada                   | [`inc/auth.php`](inc/auth.php)                                                                       |
| **Validação de passwords**         | Requisitos de comprimento, letras e números no registo; confirmação da password e validação na alteração        | [`registar.php`](registar.php), [`inc/auth.php`](inc/auth.php)                                       |
| **Segurança de sessões**          | `HttpOnly`, `SameSite=Lax`, modo estrito e opção `Secure` em HTTPS; regeneração do identificador após autenticação | [`inc/security.php`](inc/security.php), [`inc/auth.php`](inc/auth.php)                               |
| **Content Security Policy (CSP)** | Política de origens autorizadas e utilização de _nonce_ para determinados scripts                                  | [`inc/security.php`](inc/security.php)                                                               |
| **Cabeçalhos HTTP**               | `X-Content-Type-Options`, `X-Frame-Options` e `Referrer-Policy`                                                    | [`config/bootstrap.php`](config/bootstrap.php)                                                       |
| **Controlo de acesso**            | Verificação de autenticação e do papel de administrador antes de aceder ao painel                                  | [`inc/auth.php`](inc/auth.php), [`admin_dashboard.php`](admin_dashboard.php)                         |
| **Limitação de tentativas**       | Controlo básico, por sessão, de tentativas falhadas de login e de alteração de password                            | [`inc/auth.php`](inc/auth.php)                                                                       |
| **Validação no servidor**         | Verificação de campos obrigatórios, emails, formatos, permissões e dados de checkout                               | [`registar.php`](registar.php), [`userProfile.php`](userProfile.php), [`checkout.php`](checkout.php) |
| **Configuração privada**          | Credenciais da base de dados num ficheiro separado, excluído do Git                                                | [`inc/db.php`](inc/db.php), [`.gitignore`](.gitignore)                                               |

**Exemplos concretos:**

- Os formulários protegidos incluem `csrf_field()`; o servidor usa `csrf_verify()` para rejeitar tokens inválidos, incluindo nas operações de esvaziamento do carrinho e encerramento de sessão.
- Os valores fornecidos pelos utilizadores são enviados como parâmetros das consultas SQL, em vez de serem concatenados diretamente nas instruções.
- O acesso à administração depende de autenticação e da verificação de `is_admin`.
- As palavras-passe são armazenadas sob a forma de _hashes_, não em texto simples.

## Programação orientada a objetos e padrões de desenho

### POO em PHP

A classe [`Auth`](inc/auth.php) centraliza operações relacionadas com a autenticação e demonstra:

- Definição de uma **classe** e respetivos **métodos**.
- Métodos **públicos** e **privados**.
- Métodos **estáticos** e chamadas internas através de `self::`.
- **Encapsulamento** de operações relacionadas, como login, registo, logout e alteração de password.
- **Tipagem de parâmetros e retornos**, incluindo tipos anuláveis (`?array`).
- Utilização de **exceções** (`InvalidArgumentException`, `RuntimeException`) e captura através de `try/catch`.

A aplicação também utiliza objetos disponibilizados pelo PHP, nomeadamente `PDO`, `DateTime` e `DateTimeImmutable`.

> A estrutura demonstra conceitos de POO, mas **não é apresentada como uma arquitetura inteiramente orientada a objetos**. Não foram identificadas implementações próprias de herança, polimorfismo ou interfaces.

### Padrões e organização

- **Abordagem semelhante a Singleton:** a função `db()` utiliza uma variável local `static` para reutilizar uma instância `PDO` durante o pedido, evitando criar várias ligações desnecessárias. É uma aproximação funcional ao padrão, não um Singleton clássico implementado através de uma classe.
- **Post/Redirect/Get (PRG):** várias operações realizadas por POST terminam com um redirecionamento, reduzindo o risco de reenvio acidental de formulários.
- **Separação de responsabilidades:** módulos próprios para autenticação, acesso a dados, carrinho, encomendas, pesquisa, segurança e portes.
- **Reutilização de componentes:** função `render_card_produto()` para apresentação consistente de produtos em diferentes páginas.

## Outros conceitos de programação

### PHP

- Funções definidas pelo programador, reutilização de código e passagem de argumentos.
- Parâmetros opcionais, valores por defeito e tipos de retorno.
- `declare(strict_types=1)` em módulos selecionados.
- Arrays associativos e multidimensionais.
- Iteração com `foreach`, `while` e estruturas condicionais.
- Funções anónimas e _arrow functions_ (`fn`).
- Operações com arrays, como `array_filter()`, `array_column()`, `array_sum()` e `array_fill()`.
- Construção de cláusulas SQL `IN` com número variável de marcadores `?`, recorrendo a `array_fill()` e `implode()`, mantendo os valores parametrizados.
- Expressões regulares com `preg_match()`, `preg_replace()` e `preg_split()`.
- Normalização de nomes próprios com suporte a UTF-8 e tratamento de partículas como «de», «da» e «dos».
- Transliteração de caracteres com `iconv()` e geração de _slugs_ legíveis e únicos.
- Manipulação e comparação de datas com `DateTime` e `DateTimeImmutable`, incluindo cálculo de idade com `diff()`.
- Formatação de valores monetários e datas.
- Validação de dados com `filter_var()` e `FILTER_VALIDATE_EMAIL`, incluindo expressões regulares para o código postal e o telefone.
- Exceções, tratamento de erros e códigos de resposta HTTP (`403`, `405`, `419`, `429`, entre outros).
- Redirecionamentos HTTP, sessões e variáveis superglobais (`$_GET`, `$_POST`, `$_SESSION`, `$_FILES`).
- Inclusão de módulos com `require` e `require_once`.

**Nota sobre recursividade:** nas funções analisadas não foi identificada uma função que se invoque a si própria. A criação de _slugs_ únicos utiliza um ciclo `while` (iteração), **não recursividade**.

### JavaScript

- Manipulação do **DOM** com `querySelector()`, `querySelectorAll()` e atualização de conteúdos.
- Gestão de eventos com `addEventListener()` e `event.preventDefault()`.
- Inicialização de código após `DOMContentLoaded`.
- Validação e interação com formulários.
- Alternância entre visibilidade e ocultação das passwords através de eventos de rato, toque e teclado.
- Confirmação de determinadas operações administrativas através de `confirm()`.
- Pedidos assíncronos com **`fetch()`**, tratamento de _promises_ com `.then()` e `.catch()`.
- Envio de dados e interpretação de respostas **JSON**.
- Atualização de totais e portes sem recarregar toda a página.
- Utilização de funções anónimas, _callbacks_ e `forEach()`.
- Isolamento de código através de uma **IIFE** em [`js/homepage.js`](js/homepage.js).
- Configuração de carrosséis responsivos com **Swiper.js**.

## Base de dados

A aplicação utiliza uma base de dados relacional com as seguintes entidades:

| Tabela             | Responsabilidade                                     |
| ------------------ | ---------------------------------------------------- |
| `utilizadores`     | Contas, dados de contacto, autenticação e permissões |
| `categorias`       | Classificação do catálogo                            |
| `produtos`         | Produtos, preços, promoções e stock                  |
| `encomendas`       | Dados gerais das encomendas                          |
| `encomendas_itens` | Artigos e quantidades de cada encomenda              |

**Conceitos SQL aplicados:**

- Modelação relacional e relações entre entidades.
- Chaves primárias, chaves estrangeiras e integridade referencial.
- Restrições `UNIQUE`, índices e `AUTO_INCREMENT`.
- Operações **CRUD**: `INSERT`, `SELECT`, `UPDATE` e `DELETE`.
- Consultas com `INNER JOIN` / `JOIN` e `LEFT JOIN`.
- Pesquisa com `LIKE`, ordenação com `ORDER BY` e limitação de resultados com `LIMIT`.
- Funções e expressões SQL, incluindo `COUNT()`, `COALESCE()`, `CONCAT()` e `RAND()`.
- Paginação de consultas com `LIMIT` e `OFFSET`.
- Consultas parametrizadas com marcadores posicionais (`?`) e nomeados (`:nome`).
- **Transações** com `beginTransaction()`, `commit()` e `rollBack()`.
- **Soft delete** de utilizadores através do campo `is_deleted`.
- Codificação `utf8mb4` na ligação e nas tabelas.

O ficheiro [`organicos.sql`](organicos.sql) contém o esquema e os dados disponibilizados para demonstração.

## Integração com serviços externos

O cálculo de portes está implementado em [`inc/shipping.php`](inc/shipping.php):

1. A morada é enviada ao serviço de geocodificação **Nominatim**, associado ao OpenStreetMap.
2. O pedido HTTP é realizado através da extensão **cURL** do PHP.
3. A resposta **JSON** é interpretada para obter latitude e longitude.
4. A distância estimada é calculada com a **fórmula de Haversine**.
5. São aplicadas regras de negócio aos portes: **grátis até 30 km** e **2 € por cada bloco adicional de 5 km**.
6. O checkout pode solicitar uma nova estimativa de portes por **Fetch API**, atualizando o valor apresentado.

A geocodificação depende de um serviço externo. A distância calculada é geográfica, **não corresponde necessariamente ao percurso rodoviário**.

## Arquitetura e organização

```text
supermercado_virtual_final/
├── .github/
│   └── workflows/
│       └── deploy.yml        # Publicação automática
├── admin/                    # Secções de administração
│   ├── section_orders.php
│   ├── section_products.php
│   └── section_users.php
├── api/                      # Endpoints PHP para pedidos assíncronos
│   ├── cart_add.php
│   ├── cart_clear.php
│   ├── cart_remove.php
│   └── shipping_quote.php
├── config/
│   └── bootstrap.php        # Inicialização, segurança e funções auxiliares
├── inc/                      # Módulos reutilizáveis de PHP
│   ├── auth.php
│   ├── cart.php
│   ├── csrf.php
│   ├── db.php
│   ├── orders.php
│   ├── products.php
│   ├── render_card.php
│   ├── search.php
│   ├── security.php
│   └── shipping.php
├── css/                      # Folhas de estilos
├── js/                       # Scripts JavaScript
├── images/                   # Imagens e ícones
├── fonts/                    # Tipos de letra
├── admin_dashboard.php
├── checkout.php
├── comprar.php
├── homepage.php
├── login.php
├── logout.php
├── registar.php
├── userProfile.php
├── organicos.sql
├── README.md                  # Versão portuguesa
└── README.en.md               # Versão inglesa
```

A aplicação usa uma **organização modular de PHP procedural com uma classe de autenticação**. Não segue uma arquitetura MVC completa.

## Publicação automatizada

O ficheiro [`.github/workflows/deploy.yml`](.github/workflows/deploy.yml) configura um processo de publicação com **GitHub Actions**:

1. Um `push` para a branch `main` inicia o processo de publicação, que também pode ser executado manualmente.
2. `actions/checkout` obtém os ficheiros do repositório.
3. `SamKirkland/FTP-Deploy-Action` transfere os ficheiros da aplicação por **FTPS** para o InfinityFree.
4. As credenciais de acesso são fornecidas através de **GitHub Secrets**.
5. Ficheiros privados, ficheiros SQL e outros conteúdos excluídos não são enviados pelo processo automatizado.

**Nota:** as imagens estão excluídas do processo FTPS e são atualmente geridas diretamente no alojamento. Este fluxo automatiza a **publicação**, mas não inclui testes automatizados.

## Execução local

### Requisitos

- PHP 8 ou superior, com as extensões necessárias para a aplicação, incluindo `pdo_mysql`, `mbstring` e `curl`.
- MySQL ou MariaDB.
- Um servidor web compatível com PHP, ou o servidor de desenvolvimento integrado do PHP.

### Configuração

1. Clonar o repositório:

   ```bash
   git clone https://github.com/Abarrosk/supermercado_virtual_final.git
   cd supermercado_virtual_final
   ```

2. Criar a base de dados MySQL e importar [`organicos.sql`](organicos.sql), que contém as tabelas e os dados de demonstração.

3. Criar o ficheiro privado `config/db.private.php` com as credenciais do ambiente local:

   ```php
   <?php
   return [
       'host'     => '127.0.0.1',
       'port'     => 3306,
       'database' => 'organicos',
       'username' => 'UTILIZADOR_LOCAL',
       'password' => 'PASSWORD_LOCAL',
   ];
   ```

   Este ficheiro está incluído no `.gitignore` e **não deve ser enviado para o GitHub**.

4. Iniciar o servidor de desenvolvimento na raiz do projeto:

   ```bash
   php -S localhost:8000
   ```

5. Abrir [http://localhost:8000/homepage.php](http://localhost:8000/homepage.php).

> O acesso ao painel de administração requer uma conta com permissões de administrador. Não são disponibilizadas credenciais de acesso à demonstração pública.

## Limitações e melhorias futuras

Este é um projeto demonstrativo; algumas funcionalidades foram intencionalmente simplificadas ou não fazem parte do seu âmbito:

- **Pagamentos:** são apresentados métodos de pagamento na interface, mas não são realizadas transações financeiras reais.
- **Recuperação de passwords:** não está implementado o envio de emails para recuperação de contas.
- **Geocodificação:** depende da disponibilidade do Nominatim; o tratamento de falhas do serviço pode ser melhorado.
- **Inventário e encomendas:** a atualização do stock e a consistência entre os preços atuais e os valores guardados nas encomendas são áreas de melhoria.
- **Segurança dos ficheiros enviados:** está prevista uma validação mais rigorosa dos tipos e conteúdos das imagens carregadas no painel administrativo.
- **Testes automatizados:** ainda não existe uma bateria de testes unitários ou de integração.

---

**Objetivo do projeto:** aplicar e demonstrar conhecimentos de desenvolvimento web, programação em PHP e JavaScript, modelação de bases de dados, segurança e automatização de publicações numa aplicação funcional de comércio eletrónico.
