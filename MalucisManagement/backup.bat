PGDMP     6    &    	            x            malucidb    10.12    10.12                0    0    ENCODING    ENCODING        SET client_encoding = 'UTF8';
                       false                       0    0 
   STDSTRINGS 
   STDSTRINGS     (   SET standard_conforming_strings = 'on';
                       false                       0    0 
   SEARCHPATH 
   SEARCHPATH     8   SELECT pg_catalog.set_config('search_path', '', false);
                       false                       1262    16393    malucidb    DATABASE     �   CREATE DATABASE malucidb WITH TEMPLATE = template0 ENCODING = 'UTF8' LC_COLLATE = 'Portuguese_Brazil.1252' LC_CTYPE = 'Portuguese_Brazil.1252';
    DROP DATABASE malucidb;
             postgres    false                        2615    2200    public    SCHEMA        CREATE SCHEMA public;
    DROP SCHEMA public;
             postgres    false                       0    0    SCHEMA public    COMMENT     6   COMMENT ON SCHEMA public IS 'standard public schema';
                  postgres    false    3                        3079    12924    plpgsql 	   EXTENSION     ?   CREATE EXTENSION IF NOT EXISTS plpgsql WITH SCHEMA pg_catalog;
    DROP EXTENSION plpgsql;
                  false                       0    0    EXTENSION plpgsql    COMMENT     @   COMMENT ON EXTENSION plpgsql IS 'PL/pgSQL procedural language';
                       false    1            �            1259    16420    CategoriaProduto    TABLE     m   CREATE TABLE public."CategoriaProduto" (
    cat_cod integer NOT NULL,
    cat_nome character varying(25)
);
 &   DROP TABLE public."CategoriaProduto";
       public         postgres    false    3            �            1259    16492    CategoriaProduto_cat_cod_seq    SEQUENCE     �   ALTER TABLE public."CategoriaProduto" ALTER COLUMN cat_cod ADD GENERATED ALWAYS AS IDENTITY (
    SEQUENCE NAME public."CategoriaProduto_cat_cod_seq"
    START WITH 0
    INCREMENT BY 1
    MINVALUE 0
    NO MAXVALUE
    CACHE 1
);
            public       postgres    false    199    3            �            1259    16405    Cliente    TABLE     �  CREATE TABLE public."Cliente" (
    cli_id character varying(15) NOT NULL,
    cli_nome character varying(30),
    cli_sexo character(1),
    cli_datanasc date,
    cli_email character varying(50),
    cli_fone character varying(10),
    cli_cep character varying(10),
    cli_rua character varying(60),
    cli_numero integer,
    cli_bairro character varying(40),
    cli_cidade character varying(30),
    cli_uf character varying(2)
);
    DROP TABLE public."Cliente";
       public         postgres    false    3            �            1259    16435    Fornecedores    TABLE     �   CREATE TABLE public."Fornecedores" (
    for_cnpj character varying(19) NOT NULL,
    for_nome character varying(50),
    for_inscestadual character varying(13),
    for_email character varying
);
 "   DROP TABLE public."Fornecedores";
       public         postgres    false    3            �            1259    16410    Login    TABLE     �   CREATE TABLE public."Login" (
    log_usuario character varying(30) NOT NULL,
    cli_id character varying(19) NOT NULL,
    log_nivel integer,
    log_senha character varying(15),
    log_ativo "char" NOT NULL
);
    DROP TABLE public."Login";
       public         postgres    false    3            �            1259    16394    Parametrizacao    TABLE     �  CREATE TABLE public."Parametrizacao" (
    par_cprimaria character varying(7),
    par_csecundaria character varying(7),
    par_fonte character varying(20),
    par_cfonte character varying(7),
    par_logo bytea,
    par_fone character varying(15),
    par_cep character varying(10),
    par_rua character varying(50),
    par_cidade character varying(20),
    par_uf character varying(2)
);
 $   DROP TABLE public."Parametrizacao";
       public         postgres    false    3            �            1259    16425    Produto    TABLE     �   CREATE TABLE public."Produto" (
    pro_cod integer NOT NULL,
    pro_nome character varying(50),
    pro_preco numeric(6,2),
    pro_quantidade integer,
    cat_cod integer
);
    DROP TABLE public."Produto";
       public         postgres    false    3            �            1259    16494    Produto_pro_cod_seq    SEQUENCE     �   ALTER TABLE public."Produto" ALTER COLUMN pro_cod ADD GENERATED ALWAYS AS IDENTITY (
    SEQUENCE NAME public."Produto_pro_cod_seq"
    START WITH 0
    INCREMENT BY 1
    MINVALUE 0
    NO MAXVALUE
    CACHE 1
);
            public       postgres    false    3    200                      0    16420    CategoriaProduto 
   TABLE DATA               ?   COPY public."CategoriaProduto" (cat_cod, cat_nome) FROM stdin;
    public       postgres    false    199   v#                 0    16405    Cliente 
   TABLE DATA               �   COPY public."Cliente" (cli_id, cli_nome, cli_sexo, cli_datanasc, cli_email, cli_fone, cli_cep, cli_rua, cli_numero, cli_bairro, cli_cidade, cli_uf) FROM stdin;
    public       postgres    false    197   �#                 0    16435    Fornecedores 
   TABLE DATA               Y   COPY public."Fornecedores" (for_cnpj, for_nome, for_inscestadual, for_email) FROM stdin;
    public       postgres    false    201   �#                 0    16410    Login 
   TABLE DATA               W   COPY public."Login" (log_usuario, cli_id, log_nivel, log_senha, log_ativo) FROM stdin;
    public       postgres    false    198   �#                 0    16394    Parametrizacao 
   TABLE DATA               �   COPY public."Parametrizacao" (par_cprimaria, par_csecundaria, par_fonte, par_cfonte, par_logo, par_fone, par_cep, par_rua, par_cidade, par_uf) FROM stdin;
    public       postgres    false    196   �#                 0    16425    Produto 
   TABLE DATA               Z   COPY public."Produto" (pro_cod, pro_nome, pro_preco, pro_quantidade, cat_cod) FROM stdin;
    public       postgres    false    200   $                  0    0    CategoriaProduto_cat_cod_seq    SEQUENCE SET     M   SELECT pg_catalog.setval('public."CategoriaProduto_cat_cod_seq"', 0, false);
            public       postgres    false    202                       0    0    Produto_pro_cod_seq    SEQUENCE SET     D   SELECT pg_catalog.setval('public."Produto_pro_cod_seq"', 0, false);
            public       postgres    false    203            �
           2606    16424 &   CategoriaProduto CategoriaProduto_pkey 
   CONSTRAINT     m   ALTER TABLE ONLY public."CategoriaProduto"
    ADD CONSTRAINT "CategoriaProduto_pkey" PRIMARY KEY (cat_cod);
 T   ALTER TABLE ONLY public."CategoriaProduto" DROP CONSTRAINT "CategoriaProduto_pkey";
       public         postgres    false    199            �
           2606    16442    Fornecedores Fornecedores_pkey 
   CONSTRAINT     f   ALTER TABLE ONLY public."Fornecedores"
    ADD CONSTRAINT "Fornecedores_pkey" PRIMARY KEY (for_cnpj);
 L   ALTER TABLE ONLY public."Fornecedores" DROP CONSTRAINT "Fornecedores_pkey";
       public         postgres    false    201            �
           2606    16414    Login Login_pkey 
   CONSTRAINT     c   ALTER TABLE ONLY public."Login"
    ADD CONSTRAINT "Login_pkey" PRIMARY KEY (log_usuario, cli_id);
 >   ALTER TABLE ONLY public."Login" DROP CONSTRAINT "Login_pkey";
       public         postgres    false    198    198            �
           2606    16429    Produto Produto_pkey 
   CONSTRAINT     [   ALTER TABLE ONLY public."Produto"
    ADD CONSTRAINT "Produto_pkey" PRIMARY KEY (pro_cod);
 B   ALTER TABLE ONLY public."Produto" DROP CONSTRAINT "Produto_pkey";
       public         postgres    false    200            �
           2606    16409    Cliente pk_cliente 
   CONSTRAINT     V   ALTER TABLE ONLY public."Cliente"
    ADD CONSTRAINT pk_cliente PRIMARY KEY (cli_id);
 >   ALTER TABLE ONLY public."Cliente" DROP CONSTRAINT pk_cliente;
       public         postgres    false    197            �
           2606    16415    Login FK_login    FK CONSTRAINT     x   ALTER TABLE ONLY public."Login"
    ADD CONSTRAINT "FK_login" FOREIGN KEY (cli_id) REFERENCES public."Cliente"(cli_id);
 <   ALTER TABLE ONLY public."Login" DROP CONSTRAINT "FK_login";
       public       postgres    false    198    197    2695            �
           2606    16430    Produto FK_produto    FK CONSTRAINT     �   ALTER TABLE ONLY public."Produto"
    ADD CONSTRAINT "FK_produto" FOREIGN KEY (cat_cod) REFERENCES public."CategoriaProduto"(cat_cod);
 @   ALTER TABLE ONLY public."Produto" DROP CONSTRAINT "FK_produto";
       public       postgres    false    200    199    2699                  x������ � �            x������ � �            x������ � �            x������ � �            x������ � �            x������ � �     