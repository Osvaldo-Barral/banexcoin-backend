PGDMP                       }         	   banexcoin    16.1    16.1 '    �           0    0    ENCODING    ENCODING        SET client_encoding = 'UTF8';
                      false            �           0    0 
   STDSTRINGS 
   STDSTRINGS     (   SET standard_conforming_strings = 'on';
                      false            �           0    0 
   SEARCHPATH 
   SEARCHPATH     8   SELECT pg_catalog.set_config('search_path', '', false);
                      false            �           1262    557586 	   banexcoin    DATABASE     |   CREATE DATABASE banexcoin WITH TEMPLATE = template0 ENCODING = 'UTF8' LOCALE_PROVIDER = libc LOCALE = 'Spanish_Spain.1252';
    DROP DATABASE banexcoin;
                postgres    false            �            1259    566018 
   comisiones    TABLE     �   CREATE TABLE public.comisiones (
    id integer NOT NULL,
    id_transaccion integer NOT NULL,
    cuenta_beneficiaria integer NOT NULL,
    monto numeric NOT NULL,
    fecha timestamp without time zone DEFAULT now() NOT NULL
);
    DROP TABLE public.comisiones;
       public         heap    postgres    false            �            1259    566017    comisiones_id_seq    SEQUENCE     �   CREATE SEQUENCE public.comisiones_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 (   DROP SEQUENCE public.comisiones_id_seq;
       public          postgres    false    222            �           0    0    comisiones_id_seq    SEQUENCE OWNED BY     G   ALTER SEQUENCE public.comisiones_id_seq OWNED BY public.comisiones.id;
          public          postgres    false    221            �            1259    565978    cuentas    TABLE     �   CREATE TABLE public.cuentas (
    id integer NOT NULL,
    id_usuario integer NOT NULL,
    saldo numeric DEFAULT 0 NOT NULL,
    id_referido integer
);
    DROP TABLE public.cuentas;
       public         heap    postgres    false            �            1259    565977    cuentas_id_seq    SEQUENCE     �   CREATE SEQUENCE public.cuentas_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 %   DROP SEQUENCE public.cuentas_id_seq;
       public          postgres    false    218            �           0    0    cuentas_id_seq    SEQUENCE OWNED BY     A   ALTER SEQUENCE public.cuentas_id_seq OWNED BY public.cuentas.id;
          public          postgres    false    217            �            1259    565998    transacciones    TABLE       CREATE TABLE public.transacciones (
    id integer NOT NULL,
    cuenta_origen integer NOT NULL,
    cuenta_destino integer NOT NULL,
    monto numeric NOT NULL,
    comision numeric NOT NULL,
    fecha timestamp without time zone DEFAULT now() NOT NULL
);
 !   DROP TABLE public.transacciones;
       public         heap    postgres    false            �            1259    565997    transacciones_id_seq    SEQUENCE     �   CREATE SEQUENCE public.transacciones_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 +   DROP SEQUENCE public.transacciones_id_seq;
       public          postgres    false    220            �           0    0    transacciones_id_seq    SEQUENCE OWNED BY     M   ALTER SEQUENCE public.transacciones_id_seq OWNED BY public.transacciones.id;
          public          postgres    false    219            �            1259    565967    usuarios    TABLE     n   CREATE TABLE public.usuarios (
    id integer NOT NULL,
    nombre text NOT NULL,
    correo text NOT NULL
);
    DROP TABLE public.usuarios;
       public         heap    postgres    false            �            1259    565966    usuarios_id_seq    SEQUENCE     �   CREATE SEQUENCE public.usuarios_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 &   DROP SEQUENCE public.usuarios_id_seq;
       public          postgres    false    216            �           0    0    usuarios_id_seq    SEQUENCE OWNED BY     C   ALTER SEQUENCE public.usuarios_id_seq OWNED BY public.usuarios.id;
          public          postgres    false    215            .           2604    566021    comisiones id    DEFAULT     n   ALTER TABLE ONLY public.comisiones ALTER COLUMN id SET DEFAULT nextval('public.comisiones_id_seq'::regclass);
 <   ALTER TABLE public.comisiones ALTER COLUMN id DROP DEFAULT;
       public          postgres    false    222    221    222            *           2604    565981 
   cuentas id    DEFAULT     h   ALTER TABLE ONLY public.cuentas ALTER COLUMN id SET DEFAULT nextval('public.cuentas_id_seq'::regclass);
 9   ALTER TABLE public.cuentas ALTER COLUMN id DROP DEFAULT;
       public          postgres    false    218    217    218            ,           2604    566001    transacciones id    DEFAULT     t   ALTER TABLE ONLY public.transacciones ALTER COLUMN id SET DEFAULT nextval('public.transacciones_id_seq'::regclass);
 ?   ALTER TABLE public.transacciones ALTER COLUMN id DROP DEFAULT;
       public          postgres    false    219    220    220            )           2604    565970    usuarios id    DEFAULT     j   ALTER TABLE ONLY public.usuarios ALTER COLUMN id SET DEFAULT nextval('public.usuarios_id_seq'::regclass);
 :   ALTER TABLE public.usuarios ALTER COLUMN id DROP DEFAULT;
       public          postgres    false    215    216    216            �          0    566018 
   comisiones 
   TABLE DATA           [   COPY public.comisiones (id, id_transaccion, cuenta_beneficiaria, monto, fecha) FROM stdin;
    public          postgres    false    222   W-       �          0    565978    cuentas 
   TABLE DATA           E   COPY public.cuentas (id, id_usuario, saldo, id_referido) FROM stdin;
    public          postgres    false    218   �/       �          0    565998    transacciones 
   TABLE DATA           b   COPY public.transacciones (id, cuenta_origen, cuenta_destino, monto, comision, fecha) FROM stdin;
    public          postgres    false    220   �/       �          0    565967    usuarios 
   TABLE DATA           6   COPY public.usuarios (id, nombre, correo) FROM stdin;
    public          postgres    false    216   ;4       �           0    0    comisiones_id_seq    SEQUENCE SET     @   SELECT pg_catalog.setval('public.comisiones_id_seq', 39, true);
          public          postgres    false    221            �           0    0    cuentas_id_seq    SEQUENCE SET     =   SELECT pg_catalog.setval('public.cuentas_id_seq', 10, true);
          public          postgres    false    217            �           0    0    transacciones_id_seq    SEQUENCE SET     C   SELECT pg_catalog.setval('public.transacciones_id_seq', 68, true);
          public          postgres    false    219            �           0    0    usuarios_id_seq    SEQUENCE SET     >   SELECT pg_catalog.setval('public.usuarios_id_seq', 10, true);
          public          postgres    false    215            9           2606    566026    comisiones comisiones_pkey 
   CONSTRAINT     X   ALTER TABLE ONLY public.comisiones
    ADD CONSTRAINT comisiones_pkey PRIMARY KEY (id);
 D   ALTER TABLE ONLY public.comisiones DROP CONSTRAINT comisiones_pkey;
       public            postgres    false    222            5           2606    565986    cuentas cuentas_pkey 
   CONSTRAINT     R   ALTER TABLE ONLY public.cuentas
    ADD CONSTRAINT cuentas_pkey PRIMARY KEY (id);
 >   ALTER TABLE ONLY public.cuentas DROP CONSTRAINT cuentas_pkey;
       public            postgres    false    218            7           2606    566006     transacciones transacciones_pkey 
   CONSTRAINT     ^   ALTER TABLE ONLY public.transacciones
    ADD CONSTRAINT transacciones_pkey PRIMARY KEY (id);
 J   ALTER TABLE ONLY public.transacciones DROP CONSTRAINT transacciones_pkey;
       public            postgres    false    220            1           2606    565976    usuarios usuarios_correo_key 
   CONSTRAINT     Y   ALTER TABLE ONLY public.usuarios
    ADD CONSTRAINT usuarios_correo_key UNIQUE (correo);
 F   ALTER TABLE ONLY public.usuarios DROP CONSTRAINT usuarios_correo_key;
       public            postgres    false    216            3           2606    565974    usuarios usuarios_pkey 
   CONSTRAINT     T   ALTER TABLE ONLY public.usuarios
    ADD CONSTRAINT usuarios_pkey PRIMARY KEY (id);
 @   ALTER TABLE ONLY public.usuarios DROP CONSTRAINT usuarios_pkey;
       public            postgres    false    216            >           2606    566032 .   comisiones comisiones_cuenta_beneficiaria_fkey    FK CONSTRAINT     �   ALTER TABLE ONLY public.comisiones
    ADD CONSTRAINT comisiones_cuenta_beneficiaria_fkey FOREIGN KEY (cuenta_beneficiaria) REFERENCES public.cuentas(id);
 X   ALTER TABLE ONLY public.comisiones DROP CONSTRAINT comisiones_cuenta_beneficiaria_fkey;
       public          postgres    false    222    4661    218            ?           2606    566027 )   comisiones comisiones_id_transaccion_fkey    FK CONSTRAINT     �   ALTER TABLE ONLY public.comisiones
    ADD CONSTRAINT comisiones_id_transaccion_fkey FOREIGN KEY (id_transaccion) REFERENCES public.transacciones(id);
 S   ALTER TABLE ONLY public.comisiones DROP CONSTRAINT comisiones_id_transaccion_fkey;
       public          postgres    false    222    4663    220            :           2606    565992     cuentas cuentas_id_referido_fkey    FK CONSTRAINT     �   ALTER TABLE ONLY public.cuentas
    ADD CONSTRAINT cuentas_id_referido_fkey FOREIGN KEY (id_referido) REFERENCES public.cuentas(id);
 J   ALTER TABLE ONLY public.cuentas DROP CONSTRAINT cuentas_id_referido_fkey;
       public          postgres    false    218    218    4661            ;           2606    565987    cuentas cuentas_id_usuario_fkey    FK CONSTRAINT     �   ALTER TABLE ONLY public.cuentas
    ADD CONSTRAINT cuentas_id_usuario_fkey FOREIGN KEY (id_usuario) REFERENCES public.usuarios(id);
 I   ALTER TABLE ONLY public.cuentas DROP CONSTRAINT cuentas_id_usuario_fkey;
       public          postgres    false    4659    218    216            <           2606    566012 /   transacciones transacciones_cuenta_destino_fkey    FK CONSTRAINT     �   ALTER TABLE ONLY public.transacciones
    ADD CONSTRAINT transacciones_cuenta_destino_fkey FOREIGN KEY (cuenta_destino) REFERENCES public.cuentas(id);
 Y   ALTER TABLE ONLY public.transacciones DROP CONSTRAINT transacciones_cuenta_destino_fkey;
       public          postgres    false    4661    218    220            =           2606    566007 .   transacciones transacciones_cuenta_origen_fkey    FK CONSTRAINT     �   ALTER TABLE ONLY public.transacciones
    ADD CONSTRAINT transacciones_cuenta_origen_fkey FOREIGN KEY (cuenta_origen) REFERENCES public.cuentas(id);
 X   ALTER TABLE ONLY public.transacciones DROP CONSTRAINT transacciones_cuenta_origen_fkey;
       public          postgres    false    4661    220    218            �     x�]T�u%!<C����" �ǔ��oz��Sm�F�F�Û����ź�7�.-
0$�A�]��h�tm�F� �/���ͻ� ��>/�����=���!_�B��C$�]�0_�@�euȔ&i��q�.���ޡR`qX�$g��V��zx�_!�z*����D��Q~���q3�:����22�T����4��<rE�P˳0��䥂K�Ѵ���r�l�^�)vd�zs�mB� ��U�� "A�s�V�B8���f-�uhU.����~����8Ms�yZ]����k�uB�&]�b��1Zb��{��-��0��[���w2Gx�L9ŚEA4�^��^�o6d�:`�WN���BX�3�H�X<���n&�#���GG���י�Y�q�)�`�1w�q�`������B�Q�[!ήazd�Z�Z�ʚ��p�k��}�^]�EJ��k��Q���<�*	���ዪ�z䬝��Ѱ��b�xd��r��Q9ӥ��A���(���}�q�]m��p�� �N(��w��d�O      �   d   x�=��A�M0S�9�p���p�j�R;��4v�|,���nI�)���$�I�U�~��8"m����|w6��W�]M1�r��Wz�D���f�.h      �   3  x�mVۍk!��*��F��<N-��:�!�V�V��2x^F�&K&�vI�q�c�G�G�%�Q̲��$uywO��~��^Z�"O���TSA;�T�ή��R}L�RrE�N���Se�҆V�ZFEj�p���\�.3|^*O|2JP��]$���_ZC��;�p=�w����Z}a�*g`�!��nC湚���A�m���-��)ÜF�0�����<���P��P�JFR� ��~TI ��5�HMޕ�kRϰ���z�Y�,M{��~�x?�YA�ՂsID�~�(�~ǂM���u�_2FXzֆ���o�|�q�_rҎ�2�]�)׸������#�SШ��3[0O�|v�U�Kn=�G����X���[��q��B�Ik�B��	�c\؂Rq�����7���e#���9p�k	����lu�R���'<�g��R.�Mmzp1�����P7���_;�+q?�F�N7���h;"�8T �5�-��!�Q����L!�;H�����5�0��˭z��#�[saZ4��j��T�Z��BO���,Ʌ_��e�B1�T�r�0v૤M����Ee��\�ʪ�^��G��$�N���K��/�;��w�++D;S���b�2�b�8ڍ�v��y�/�N��0C+�¼�����p��AJ�U�0�G-W�r'�����e�T_5FA�k+�/��V�[���I6����{��V�CB������j�f��-���nn����)4�.���K-��V8�1����O�\�*��#��c����+pی}�s'�*e0��.�scż�f\����TL΅UB.-��w�-�_K�;�F
�챊�s]���l���e���]�5��L �Ӽ�� �wZ��ع��vBlq�3�N�T�++K/Uq���t��-�w���k�DH�Ireo6�7�g�CT�M�r_�����$mmJ`1�l��b�o��ɕ��榄8H[�ӯEά��jn��4X+ke�S7���[Ia�x�i�Y��b�.Տ��#>�(]+�ERY<�\��.��[�-��E�џ�7��F�������xD��cdf���.�.�^��w��?���u      �   "  x�U�MN�0�דS���@QՊ*A�،�i�ʱ�I�En�%��8�/Ƹ pW��yo��M`>�S���4�E�ji�� ݒ�{j�X]�&;�%r8��!��-�ޕ�7�u-�`b��)���z!v���Yч�Sy���0��%<8�͢rl�A� :�ַ'�+XQ����y7��}'Z��Ɲ��a��z�#F��lĺ2��o`�&�fTo��:�F�YH"��¯c/��5vjI��#B�������F:���b����S��?T�G�&g�dI�)�ݡ�}C�"�]D��CgY�rg��     