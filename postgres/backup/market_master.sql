--
-- PostgreSQL database dump
--

\restrict NfjFgR41OmbswIvhaFPrtafVBFHremMrdxcVD8ihnpkhtSnL5paZRhM2K4Finj4

-- Dumped from database version 18.1 (Debian 18.1-1.pgdg13+2)
-- Dumped by pg_dump version 18.1 (Debian 18.1-1.pgdg13+2)

SET statement_timeout = 0;
SET lock_timeout = 0;
SET idle_in_transaction_session_timeout = 0;
SET transaction_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SELECT pg_catalog.set_config('search_path', '', false);
SET check_function_bodies = false;
SET xmloption = content;
SET client_min_messages = warning;
SET row_security = off;

--
-- Name: uuid-ossp; Type: EXTENSION; Schema: -; Owner: -
--

CREATE EXTENSION IF NOT EXISTS "uuid-ossp" WITH SCHEMA public;


--
-- Name: EXTENSION "uuid-ossp"; Type: COMMENT; Schema: -; Owner: 
--

COMMENT ON EXTENSION "uuid-ossp" IS 'generate universally unique identifiers (UUIDs)';


--
-- Name: update_at_timestamp(); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION public.update_at_timestamp() RETURNS trigger
    LANGUAGE plpgsql
    AS $$ BEGIN NEW.updated_at = NOW();
RETURN NEW;
  END;
  $$;


ALTER FUNCTION public.update_at_timestamp() OWNER TO postgres;

SET default_tablespace = '';

SET default_table_access_method = heap;

--
-- Name: attribute_values; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.attribute_values (
    id uuid DEFAULT public.uuid_generate_v4() NOT NULL,
    attribute_id uuid NOT NULL,
    attribute_value character varying(255) NOT NULL,
    color character varying(50) DEFAULT NULL::character varying
);


ALTER TABLE public.attribute_values OWNER TO postgres;

--
-- Name: attributes; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.attributes (
    id uuid DEFAULT public.uuid_generate_v4() NOT NULL,
    attribute_name character varying(255) NOT NULL,
    created_at timestamp with time zone DEFAULT now() NOT NULL,
    updated_at timestamp with time zone DEFAULT now() NOT NULL,
    created_by uuid,
    updated_by uuid
);


ALTER TABLE public.attributes OWNER TO postgres;

--
-- Name: card_items; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.card_items (
    id uuid DEFAULT public.uuid_generate_v4() NOT NULL,
    card_id uuid,
    product_id uuid,
    quantity integer DEFAULT 1
);


ALTER TABLE public.card_items OWNER TO postgres;

--
-- Name: cards; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.cards (
    id uuid DEFAULT public.uuid_generate_v4() NOT NULL,
    customer_id uuid
);


ALTER TABLE public.cards OWNER TO postgres;

--
-- Name: categories; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.categories (
    id uuid DEFAULT public.uuid_generate_v4() NOT NULL,
    parent_id uuid,
    category_name character varying(255) NOT NULL,
    category_description text,
    icon text,
    image text,
    placeholder text,
    active boolean DEFAULT true,
    created_at timestamp with time zone DEFAULT now() NOT NULL,
    updated_at timestamp with time zone DEFAULT now() NOT NULL,
    created_by uuid,
    updated_by uuid
);


ALTER TABLE public.categories OWNER TO postgres;

--
-- Name: countries_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.countries_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.countries_seq OWNER TO postgres;

--
-- Name: countries; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.countries (
    id integer DEFAULT nextval('public.countries_seq'::regclass) NOT NULL,
    iso character(2) NOT NULL,
    name character varying(80) NOT NULL,
    upper_name character varying(80) NOT NULL,
    iso3 character(3) DEFAULT NULL::bpchar,
    num_code smallint,
    phone_code integer NOT NULL
);


ALTER TABLE public.countries OWNER TO postgres;

--
-- Name: coupons; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.coupons (
    id uuid DEFAULT public.uuid_generate_v4() NOT NULL,
    code character varying(50) NOT NULL,
    discount_value numeric,
    discount_type character varying(50) NOT NULL,
    times_used numeric DEFAULT 0 NOT NULL,
    max_usage numeric,
    order_amount_limit numeric,
    coupon_start_date timestamp with time zone,
    coupon_end_date timestamp with time zone,
    created_at timestamp with time zone DEFAULT now() NOT NULL,
    updated_at timestamp with time zone DEFAULT now() NOT NULL,
    created_by uuid,
    updated_by uuid
);


ALTER TABLE public.coupons OWNER TO postgres;

--
-- Name: customer_addresses; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.customer_addresses (
    id uuid DEFAULT public.uuid_generate_v4() NOT NULL,
    customer_id uuid,
    address_line1 text NOT NULL,
    address_line2 text,
    phone_number character varying(255) NOT NULL,
    dial_code character varying(100) NOT NULL,
    country character varying(255) NOT NULL,
    postal_code character varying(255) NOT NULL,
    city character varying(255) NOT NULL
);


ALTER TABLE public.customer_addresses OWNER TO postgres;

--
-- Name: customers; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.customers (
    id uuid DEFAULT public.uuid_generate_v4() NOT NULL,
    first_name character varying(100) NOT NULL,
    last_name character varying(100) NOT NULL,
    email text NOT NULL,
    password_hash text NOT NULL,
    active boolean DEFAULT true,
    registered_at timestamp with time zone DEFAULT now() NOT NULL,
    updated_at timestamp with time zone DEFAULT now() NOT NULL
);


ALTER TABLE public.customers OWNER TO postgres;

--
-- Name: gallery; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.gallery (
    id uuid DEFAULT public.uuid_generate_v4() NOT NULL,
    product_id uuid,
    image text NOT NULL,
    placeholder text NOT NULL,
    is_thumbnail boolean DEFAULT false,
    created_at timestamp with time zone DEFAULT now() NOT NULL,
    updated_at timestamp with time zone DEFAULT now() NOT NULL
)
PARTITION BY HASH (id);


ALTER TABLE public.gallery OWNER TO postgres;

--
-- Name: gallery_part1; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.gallery_part1 (
    id uuid DEFAULT public.uuid_generate_v4() CONSTRAINT gallery_id_not_null NOT NULL,
    product_id uuid,
    image text CONSTRAINT gallery_image_not_null NOT NULL,
    placeholder text CONSTRAINT gallery_placeholder_not_null NOT NULL,
    is_thumbnail boolean DEFAULT false,
    created_at timestamp with time zone DEFAULT now() CONSTRAINT gallery_created_at_not_null NOT NULL,
    updated_at timestamp with time zone DEFAULT now() CONSTRAINT gallery_updated_at_not_null NOT NULL
);


ALTER TABLE public.gallery_part1 OWNER TO postgres;

--
-- Name: gallery_part2; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.gallery_part2 (
    id uuid DEFAULT public.uuid_generate_v4() CONSTRAINT gallery_id_not_null NOT NULL,
    product_id uuid,
    image text CONSTRAINT gallery_image_not_null NOT NULL,
    placeholder text CONSTRAINT gallery_placeholder_not_null NOT NULL,
    is_thumbnail boolean DEFAULT false,
    created_at timestamp with time zone DEFAULT now() CONSTRAINT gallery_created_at_not_null NOT NULL,
    updated_at timestamp with time zone DEFAULT now() CONSTRAINT gallery_updated_at_not_null NOT NULL
);


ALTER TABLE public.gallery_part2 OWNER TO postgres;

--
-- Name: gallery_part3; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.gallery_part3 (
    id uuid DEFAULT public.uuid_generate_v4() CONSTRAINT gallery_id_not_null NOT NULL,
    product_id uuid,
    image text CONSTRAINT gallery_image_not_null NOT NULL,
    placeholder text CONSTRAINT gallery_placeholder_not_null NOT NULL,
    is_thumbnail boolean DEFAULT false,
    created_at timestamp with time zone DEFAULT now() CONSTRAINT gallery_created_at_not_null NOT NULL,
    updated_at timestamp with time zone DEFAULT now() CONSTRAINT gallery_updated_at_not_null NOT NULL
);


ALTER TABLE public.gallery_part3 OWNER TO postgres;

--
-- Name: notifications; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.notifications (
    id uuid DEFAULT public.uuid_generate_v4() NOT NULL,
    account_id uuid,
    title character varying(100),
    content text,
    seen boolean,
    created_at timestamp with time zone DEFAULT now() NOT NULL,
    receive_time timestamp with time zone,
    notification_expiry_date date
);


ALTER TABLE public.notifications OWNER TO postgres;

--
-- Name: order_items; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.order_items (
    id uuid DEFAULT public.uuid_generate_v4() NOT NULL,
    product_id uuid,
    order_id character varying(50),
    price numeric NOT NULL,
    quantity integer NOT NULL
);


ALTER TABLE public.order_items OWNER TO postgres;

--
-- Name: order_statuses; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.order_statuses (
    id uuid DEFAULT public.uuid_generate_v4() NOT NULL,
    status_name character varying(255) NOT NULL,
    color character varying(50) NOT NULL,
    privacy character varying(10) DEFAULT 'private'::character varying NOT NULL,
    created_at timestamp with time zone DEFAULT now() NOT NULL,
    updated_at timestamp with time zone DEFAULT now() NOT NULL,
    created_by uuid,
    updated_by uuid,
    CONSTRAINT order_statuses_privacy_check CHECK (((privacy)::text = ANY ((ARRAY['public'::character varying, 'private'::character varying])::text[])))
);


ALTER TABLE public.order_statuses OWNER TO postgres;

--
-- Name: orders; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.orders (
    id character varying(50) NOT NULL,
    coupon_id uuid,
    customer_id uuid,
    order_status_id uuid,
    order_approved_at timestamp with time zone,
    order_delivered_carrier_date timestamp with time zone,
    order_delivered_customer_date timestamp with time zone,
    created_at timestamp with time zone DEFAULT now() NOT NULL,
    updated_by uuid
);


ALTER TABLE public.orders OWNER TO postgres;

--
-- Name: product_attribute_values; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.product_attribute_values (
    id uuid DEFAULT public.uuid_generate_v4() NOT NULL,
    product_attribute_id uuid NOT NULL,
    attribute_value_id uuid NOT NULL
);


ALTER TABLE public.product_attribute_values OWNER TO postgres;

--
-- Name: product_attributes; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.product_attributes (
    id uuid DEFAULT public.uuid_generate_v4() NOT NULL,
    product_id uuid NOT NULL,
    attribute_id uuid NOT NULL
);


ALTER TABLE public.product_attributes OWNER TO postgres;

--
-- Name: product_categories; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.product_categories (
    id uuid DEFAULT public.uuid_generate_v4() NOT NULL,
    product_id uuid NOT NULL,
    category_id uuid NOT NULL
);


ALTER TABLE public.product_categories OWNER TO postgres;

--
-- Name: product_coupons; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.product_coupons (
    id uuid DEFAULT public.uuid_generate_v4() NOT NULL,
    product_id uuid NOT NULL,
    coupon_id uuid NOT NULL
);


ALTER TABLE public.product_coupons OWNER TO postgres;

--
-- Name: product_shipping_info; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.product_shipping_info (
    id uuid DEFAULT public.uuid_generate_v4() NOT NULL,
    product_id uuid,
    weight numeric DEFAULT 0 NOT NULL,
    weight_unit character varying(10),
    volume numeric DEFAULT 0 NOT NULL,
    volume_unit character varying(10),
    dimension_width numeric DEFAULT 0 NOT NULL,
    dimension_height numeric DEFAULT 0 NOT NULL,
    dimension_depth numeric DEFAULT 0 NOT NULL,
    dimension_unit character varying(10),
    CONSTRAINT product_shipping_info_dimension_unit_check CHECK (((dimension_unit)::text = ANY ((ARRAY['l'::character varying, 'ml'::character varying])::text[]))),
    CONSTRAINT product_shipping_info_volume_unit_check CHECK (((volume_unit)::text = ANY ((ARRAY['l'::character varying, 'ml'::character varying])::text[]))),
    CONSTRAINT product_shipping_info_weight_unit_check CHECK (((weight_unit)::text = ANY ((ARRAY['g'::character varying, 'kg'::character varying])::text[])))
);


ALTER TABLE public.product_shipping_info OWNER TO postgres;

--
-- Name: product_suppliers; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.product_suppliers (
    product_id uuid NOT NULL,
    supplier_id uuid NOT NULL
);


ALTER TABLE public.product_suppliers OWNER TO postgres;

--
-- Name: product_tags; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.product_tags (
    tag_id uuid NOT NULL,
    product_id uuid NOT NULL
);


ALTER TABLE public.product_tags OWNER TO postgres;

--
-- Name: products; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.products (
    id uuid DEFAULT public.uuid_generate_v4() NOT NULL,
    slug text NOT NULL,
    product_name character varying(255) NOT NULL,
    sku character varying(255),
    sale_price numeric DEFAULT 0 NOT NULL,
    compare_price numeric DEFAULT 0,
    buying_price numeric,
    quantity integer DEFAULT 0 NOT NULL,
    short_description character varying(165) NOT NULL,
    product_description text NOT NULL,
    product_type character varying(64),
    published boolean DEFAULT false,
    disable_out_of_stock boolean DEFAULT true,
    note text,
    created_at timestamp with time zone DEFAULT now() NOT NULL,
    updated_at timestamp with time zone DEFAULT now() NOT NULL,
    created_by uuid,
    updated_by uuid,
    CONSTRAINT products_check CHECK (((compare_price > sale_price) OR (compare_price = (0)::numeric))),
    CONSTRAINT products_product_type_check CHECK (((product_type)::text = ANY ((ARRAY['simple'::character varying, 'variable'::character varying])::text[])))
);


ALTER TABLE public.products OWNER TO postgres;

--
-- Name: roles; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.roles (
    id integer NOT NULL,
    role_name character varying(255) NOT NULL,
    privileges text[]
);


ALTER TABLE public.roles OWNER TO postgres;

--
-- Name: roles_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.roles_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.roles_id_seq OWNER TO postgres;

--
-- Name: roles_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.roles_id_seq OWNED BY public.roles.id;


--
-- Name: sells; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.sells (
    id integer NOT NULL,
    product_id uuid,
    price numeric NOT NULL,
    quantity integer NOT NULL
);


ALTER TABLE public.sells OWNER TO postgres;

--
-- Name: sells_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.sells_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.sells_id_seq OWNER TO postgres;

--
-- Name: sells_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.sells_id_seq OWNED BY public.sells.id;


--
-- Name: shipping_country_zones; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.shipping_country_zones (
    id uuid DEFAULT public.uuid_generate_v4() NOT NULL,
    shipping_zone_id integer NOT NULL,
    country_id integer NOT NULL
);


ALTER TABLE public.shipping_country_zones OWNER TO postgres;

--
-- Name: shipping_rates; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.shipping_rates (
    id uuid DEFAULT public.uuid_generate_v4() NOT NULL,
    shipping_zone_id integer NOT NULL,
    weight_unit character varying(10),
    min_value numeric DEFAULT 0 NOT NULL,
    max_value numeric,
    no_max boolean DEFAULT true,
    price numeric DEFAULT 0 NOT NULL,
    CONSTRAINT shipping_rates_check CHECK (((max_value > min_value) OR (no_max IS TRUE))),
    CONSTRAINT shipping_rates_weight_unit_check CHECK (((weight_unit)::text = ANY ((ARRAY['g'::character varying, 'kg'::character varying])::text[])))
);


ALTER TABLE public.shipping_rates OWNER TO postgres;

--
-- Name: shipping_zones; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.shipping_zones (
    id integer NOT NULL,
    name character varying(255) NOT NULL,
    display_name character varying(255) NOT NULL,
    active boolean DEFAULT false,
    free_shipping boolean DEFAULT false,
    rate_type character varying(64),
    created_at timestamp with time zone DEFAULT now() NOT NULL,
    updated_at timestamp with time zone DEFAULT now() NOT NULL,
    created_by uuid,
    updated_by uuid,
    CONSTRAINT shipping_zones_rate_type_check CHECK (((rate_type)::text = ANY ((ARRAY['price'::character varying, 'weight'::character varying])::text[])))
);


ALTER TABLE public.shipping_zones OWNER TO postgres;

--
-- Name: shipping_zones_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.shipping_zones_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.shipping_zones_id_seq OWNER TO postgres;

--
-- Name: shipping_zones_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.shipping_zones_id_seq OWNED BY public.shipping_zones.id;


--
-- Name: slideshows; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.slideshows (
    id uuid DEFAULT public.uuid_generate_v4() NOT NULL,
    title character varying(80),
    destination_url text,
    image text NOT NULL,
    placeholder text NOT NULL,
    description character varying(160),
    btn_label character varying(50),
    display_order integer NOT NULL,
    published boolean DEFAULT false,
    clicks integer DEFAULT 0 NOT NULL,
    styles jsonb,
    created_at timestamp with time zone DEFAULT now() NOT NULL,
    updated_at timestamp with time zone DEFAULT now() NOT NULL,
    created_by uuid,
    updated_by uuid
);


ALTER TABLE public.slideshows OWNER TO postgres;

--
-- Name: staff_accounts; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.staff_accounts (
    id uuid DEFAULT public.uuid_generate_v4() NOT NULL,
    role_id integer,
    first_name character varying(100) NOT NULL,
    last_name character varying(100) NOT NULL,
    phone_number character varying(100) DEFAULT NULL::character varying,
    email character varying(255) NOT NULL,
    password_hash text NOT NULL,
    active boolean DEFAULT true,
    image text,
    placeholder text,
    created_at timestamp with time zone DEFAULT now() NOT NULL,
    updated_at timestamp with time zone DEFAULT now() NOT NULL,
    created_by uuid,
    updated_by uuid
);


ALTER TABLE public.staff_accounts OWNER TO postgres;

--
-- Name: suppliers; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.suppliers (
    id uuid DEFAULT public.uuid_generate_v4() NOT NULL,
    supplier_name character varying(255) NOT NULL,
    company character varying(255),
    phone_number character varying(255),
    address_line1 text NOT NULL,
    address_line2 text,
    country_id integer NOT NULL,
    city character varying(255),
    note text,
    created_at timestamp with time zone DEFAULT now() NOT NULL,
    updated_at timestamp with time zone DEFAULT now() NOT NULL,
    created_by uuid,
    updated_by uuid
);


ALTER TABLE public.suppliers OWNER TO postgres;

--
-- Name: tags; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.tags (
    id uuid DEFAULT public.uuid_generate_v4() NOT NULL,
    tag_name character varying(255) NOT NULL,
    icon text,
    created_at timestamp with time zone DEFAULT now() NOT NULL,
    updated_at timestamp with time zone DEFAULT now() NOT NULL,
    created_by uuid,
    updated_by uuid
);


ALTER TABLE public.tags OWNER TO postgres;

--
-- Name: variant_options; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.variant_options (
    id uuid DEFAULT public.uuid_generate_v4() NOT NULL,
    title text NOT NULL,
    image_id uuid,
    product_id uuid NOT NULL,
    sale_price numeric DEFAULT 0 NOT NULL,
    compare_price numeric DEFAULT 0,
    buying_price numeric,
    quantity integer DEFAULT 0 NOT NULL,
    sku character varying(255),
    active boolean DEFAULT true,
    CONSTRAINT variant_options_check CHECK (((compare_price > sale_price) OR (compare_price = (0)::numeric)))
);


ALTER TABLE public.variant_options OWNER TO postgres;

--
-- Name: variant_values; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.variant_values (
    id uuid DEFAULT public.uuid_generate_v4() NOT NULL,
    variant_id uuid NOT NULL,
    product_attribute_value_id uuid NOT NULL
);


ALTER TABLE public.variant_values OWNER TO postgres;

--
-- Name: variants; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.variants (
    id uuid DEFAULT public.uuid_generate_v4() NOT NULL,
    variant_option text NOT NULL,
    product_id uuid NOT NULL,
    variant_option_id uuid NOT NULL
);


ALTER TABLE public.variants OWNER TO postgres;

--
-- Name: gallery_part1; Type: TABLE ATTACH; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.gallery ATTACH PARTITION public.gallery_part1 FOR VALUES WITH (modulus 3, remainder 0);


--
-- Name: gallery_part2; Type: TABLE ATTACH; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.gallery ATTACH PARTITION public.gallery_part2 FOR VALUES WITH (modulus 3, remainder 1);


--
-- Name: gallery_part3; Type: TABLE ATTACH; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.gallery ATTACH PARTITION public.gallery_part3 FOR VALUES WITH (modulus 3, remainder 2);


--
-- Name: roles id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.roles ALTER COLUMN id SET DEFAULT nextval('public.roles_id_seq'::regclass);


--
-- Name: sells id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.sells ALTER COLUMN id SET DEFAULT nextval('public.sells_id_seq'::regclass);


--
-- Name: shipping_zones id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.shipping_zones ALTER COLUMN id SET DEFAULT nextval('public.shipping_zones_id_seq'::regclass);


--
-- Data for Name: attribute_values; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.attribute_values (id, attribute_id, attribute_value, color) FROM stdin;
4d9d09be-1698-4767-bbfe-3da392397a65	5553088b-73e5-40a8-ac43-89f423bc2873	black	#000
d120b732-151f-4acf-be48-74cd3c4a2a3a	5553088b-73e5-40a8-ac43-89f423bc2873	white	#FFF
7d2f4314-b1fa-4ff9-ade3-3ad1e24077be	5553088b-73e5-40a8-ac43-89f423bc2873	red	#FF0000
fe943860-2d0a-446e-bd91-f553b4ca7533	5abb8c24-e8aa-474a-a9f4-ee92f5351704	S	\N
8fcaf770-1a20-49d1-a158-079ef4c766fa	5abb8c24-e8aa-474a-a9f4-ee92f5351704	M	\N
0a983517-d857-4040-9af6-bec3b861f938	5abb8c24-e8aa-474a-a9f4-ee92f5351704	L	\N
5c05e2ac-1f9b-4ebd-aece-4a095bb20b87	5abb8c24-e8aa-474a-a9f4-ee92f5351704	XL	\N
8f14c10d-b034-408c-9ab7-4e1e5a40b0f3	5abb8c24-e8aa-474a-a9f4-ee92f5351704	2XL	\N
570834d6-8e55-4916-a736-b2db209a260d	5abb8c24-e8aa-474a-a9f4-ee92f5351704	3XL	\N
89c769e8-71d2-4b33-aea4-e6104ba94289	5abb8c24-e8aa-474a-a9f4-ee92f5351704	4XL	\N
f16185d0-58ff-4d77-b9ca-18f76711cb3b	5abb8c24-e8aa-474a-a9f4-ee92f5351704	5XL	\N
\.


--
-- Data for Name: attributes; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.attributes (id, attribute_name, created_at, updated_at, created_by, updated_by) FROM stdin;
5553088b-73e5-40a8-ac43-89f423bc2873	Color	2026-01-02 18:32:51.021703+00	2026-01-02 18:32:51.021703+00	\N	\N
5abb8c24-e8aa-474a-a9f4-ee92f5351704	Size	2026-01-02 18:32:51.021703+00	2026-01-02 18:32:51.021703+00	\N	\N
\.


--
-- Data for Name: card_items; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.card_items (id, card_id, product_id, quantity) FROM stdin;
\.


--
-- Data for Name: cards; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.cards (id, customer_id) FROM stdin;
\.


--
-- Data for Name: categories; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.categories (id, parent_id, category_name, category_description, icon, image, placeholder, active, created_at, updated_at, created_by, updated_by) FROM stdin;
\.


--
-- Data for Name: countries; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.countries (id, iso, name, upper_name, iso3, num_code, phone_code) FROM stdin;
1	AF	Afghanistan	AFGHANISTAN	AFG	4	93
2	AL	Albania	ALBANIA	ALB	8	355
3	DZ	Algeria	ALGERIA	DZA	12	213
4	AS	American Samoa	AMERICAN SAMOA	ASM	16	1684
5	AD	Andorra	ANDORRA	AND	20	376
6	AO	Angola	ANGOLA	AGO	24	244
7	AI	Anguilla	ANGUILLA	AIA	660	1264
8	AQ	Antarctica	ANTARCTICA	ATA	10	0
9	AG	Antigua and Barbuda	ANTIGUA AND BARBUDA	ATG	28	1268
10	AR	Argentina	ARGENTINA	ARG	32	54
11	AM	Armenia	ARMENIA	ARM	51	374
12	AW	Aruba	ARUBA	ABW	533	297
13	AU	Australia	AUSTRALIA	AUS	36	61
14	AT	Austria	AUSTRIA	AUT	40	43
15	AZ	Azerbaijan	AZERBAIJAN	AZE	31	994
16	BS	Bahamas	BAHAMAS	BHS	44	1242
17	BH	Bahrain	BAHRAIN	BHR	48	973
18	BD	Bangladesh	BANGLADESH	BGD	50	880
19	BB	Barbados	BARBADOS	BRB	52	1246
20	BY	Belarus	BELARUS	BLR	112	375
21	BE	Belgium	BELGIUM	BEL	56	32
22	BZ	Belize	BELIZE	BLZ	84	501
23	BJ	Benin	BENIN	BEN	204	229
24	BM	Bermuda	BERMUDA	BMU	60	1441
25	BT	Bhutan	BHUTAN	BTN	64	975
26	BO	Bolivia	BOLIVIA	BOL	68	591
27	BA	Bosnia and Herzegovina	BOSNIA AND HERZEGOVINA	BIH	70	387
28	BW	Botswana	BOTSWANA	BWA	72	267
29	BV	Bouvet Island	BOUVET ISLAND	BVT	74	0
30	BR	Brazil	BRAZIL	BRA	76	55
31	IO	British Indian Ocean Territory	BRITISH INDIAN OCEAN TERRITORY	IOT	86	246
32	BN	Brunei Darussalam	BRUNEI DARUSSALAM	BRN	96	673
33	BG	Bulgaria	BULGARIA	BGR	100	359
34	BF	Burkina Faso	BURKINA FASO	BFA	854	226
35	BI	Burundi	BURUNDI	BDI	108	257
36	KH	Cambodia	CAMBODIA	KHM	116	855
37	CM	Cameroon	CAMEROON	CMR	120	237
38	CA	Canada	CANADA	CAN	124	1
39	CV	Cape Verde	CAPE VERDE	CPV	132	238
40	KY	Cayman Islands	CAYMAN ISLANDS	CYM	136	1345
41	CF	Central African Republic	CENTRAL AFRICAN REPUBLIC	CAF	140	236
42	TD	Chad	CHAD	TCD	148	235
43	CL	Chile	CHILE	CHL	152	56
44	CN	China	CHINA	CHN	156	86
45	CX	Christmas Island	CHRISTMAS ISLAND	CXR	162	61
46	CC	Cocos (Keeling) Islands	COCOS (KEELING) ISLANDS	\N	\N	672
47	CO	Colombia	COLOMBIA	COL	170	57
48	KM	Comoros	COMOROS	COM	174	269
49	CG	Congo	CONGO	COG	178	242
50	CD	Congo, the Democratic Republic of the	CONGO, THE DEMOCRATIC REPUBLIC OF THE	COD	180	242
51	CK	Cook Islands	COOK ISLANDS	COK	184	682
52	CR	Costa Rica	COSTA RICA	CRI	188	506
53	CI	Cote D'Ivoire	COTE D'IVOIRE	CIV	384	225
54	HR	Croatia	CROATIA	HRV	191	385
55	CU	Cuba	CUBA	CUB	192	53
56	CY	Cyprus	CYPRUS	CYP	196	357
57	CZ	Czech Republic	CZECHIA	CZE	203	420
58	DK	Denmark	DENMARK	DNK	208	45
59	DJ	Djibouti	DJIBOUTI	DJI	262	253
60	DM	Dominica	DOMINICA	DMA	212	1767
61	DO	Dominican Republic	DOMINICAN REPUBLIC	DOM	214	1
62	EC	Ecuador	ECUADOR	ECU	218	593
63	EG	Egypt	EGYPT	EGY	818	20
64	SV	El Salvador	EL SALVADOR	SLV	222	503
65	GQ	Equatorial Guinea	EQUATORIAL GUINEA	GNQ	226	240
66	ER	Eritrea	ERITREA	ERI	232	291
67	EE	Estonia	ESTONIA	EST	233	372
68	ET	Ethiopia	ETHIOPIA	ETH	231	251
69	FK	Falkland Islands (Malvinas)	FALKLAND ISLANDS (MALVINAS)	FLK	238	500
70	FO	Faroe Islands	FAROE ISLANDS	FRO	234	298
71	FJ	Fiji	FIJI	FJI	242	679
72	FI	Finland	FINLAND	FIN	246	358
73	FR	France	FRANCE	FRA	250	33
74	GF	French Guiana	FRENCH GUIANA	GUF	254	594
75	PF	French Polynesia	FRENCH POLYNESIA	PYF	258	689
76	TF	French Southern Territories	FRENCH SOUTHERN TERRITORIES	ATF	260	0
77	GA	Gabon	GABON	GAB	266	241
78	GM	Gambia	GAMBIA	GMB	270	220
79	GE	Georgia	GEORGIA	GEO	268	995
80	DE	Germany	GERMANY	DEU	276	49
81	GH	Ghana	GHANA	GHA	288	233
82	GI	Gibraltar	GIBRALTAR	GIB	292	350
83	GR	Greece	GREECE	GRC	300	30
84	GL	Greenland	GREENLAND	GRL	304	299
85	GD	Grenada	GRENADA	GRD	308	1473
86	GP	Guadeloupe	GUADELOUPE	GLP	312	590
87	GU	Guam	GUAM	GUM	316	1671
88	GT	Guatemala	GUATEMALA	GTM	320	502
89	GN	Guinea	GUINEA	GIN	324	224
90	GW	Guinea-Bissau	GUINEA-BISSAU	GNB	624	245
91	GY	Guyana	GUYANA	GUY	328	592
92	HT	Haiti	HAITI	HTI	332	509
93	HM	Heard Island and Mcdonald Islands	HEARD ISLAND AND MCDONALD ISLANDS	HMD	334	0
94	VA	Holy See (Vatican City State)	HOLY SEE (VATICAN CITY STATE)	VAT	336	39
95	HN	Honduras	HONDURAS	HND	340	504
96	HK	Hong Kong	HONG KONG	HKG	344	852
97	HU	Hungary	HUNGARY	HUN	348	36
98	IS	Iceland	ICELAND	ISL	352	354
99	IN	India	INDIA	IND	356	91
100	ID	Indonesia	INDONESIA	IDN	360	62
101	IR	Iran, Islamic Republic of	IRAN, ISLAMIC REPUBLIC OF	IRN	364	98
102	IQ	Iraq	IRAQ	IRQ	368	964
103	IE	Ireland	IRELAND	IRL	372	353
104	IL	Israel	ISRAEL	ISR	376	972
105	IT	Italy	ITALY	ITA	380	39
106	JM	Jamaica	JAMAICA	JAM	388	1876
107	JP	Japan	JAPAN	JPN	392	81
108	JO	Jordan	JORDAN	JOR	400	962
109	KZ	Kazakhstan	KAZAKHSTAN	KAZ	398	7
110	KE	Kenya	KENYA	KEN	404	254
111	KI	Kiribati	KIRIBATI	KIR	296	686
112	KP	Korea, Democratic People's Republic of	KOREA, DEMOCRATIC PEOPLE'S REPUBLIC OF	PRK	408	850
113	KR	Korea, Republic of	KOREA, REPUBLIC OF	KOR	410	82
114	KW	Kuwait	KUWAIT	KWT	414	965
115	KG	Kyrgyzstan	KYRGYZSTAN	KGZ	417	996
116	LA	Lao People's Democratic Republic	LAO PEOPLE'S DEMOCRATIC REPUBLIC	LAO	418	856
117	LV	Latvia	LATVIA	LVA	428	371
118	LB	Lebanon	LEBANON	LBN	422	961
119	LS	Lesotho	LESOTHO	LSO	426	266
120	LR	Liberia	LIBERIA	LBR	430	231
121	LY	Libyan Arab Jamahiriya	LIBYAN ARAB JAMAHIRIYA	LBY	434	218
122	LI	Liechtenstein	LIECHTENSTEIN	LIE	438	423
123	LT	Lithuania	LITHUANIA	LTU	440	370
124	LU	Luxembourg	LUXEMBOURG	LUX	442	352
125	MO	Macao	MACAO	MAC	446	853
126	MK	North Macedonia	NORTH MACEDONIA	MKD	807	389
127	MG	Madagascar	MADAGASCAR	MDG	450	261
128	MW	Malawi	MALAWI	MWI	454	265
129	MY	Malaysia	MALAYSIA	MYS	458	60
130	MV	Maldives	MALDIVES	MDV	462	960
131	ML	Mali	MALI	MLI	466	223
132	MT	Malta	MALTA	MLT	470	356
133	MH	Marshall Islands	MARSHALL ISLANDS	MHL	584	692
134	MQ	Martinique	MARTINIQUE	MTQ	474	596
135	MR	Mauritania	MAURITANIA	MRT	478	222
136	MU	Mauritius	MAURITIUS	MUS	480	230
137	YT	Mayotte	MAYOTTE	MYT	175	269
138	MX	Mexico	MEXICO	MEX	484	52
139	FM	Micronesia, Federated States of	MICRONESIA, FEDERATED STATES OF	FSM	583	691
140	MD	Moldova, Republic of	MOLDOVA, REPUBLIC OF	MDA	498	373
141	MC	Monaco	MONACO	MCO	492	377
142	MN	Mongolia	MONGOLIA	MNG	496	976
143	MS	Montserrat	MONTSERRAT	MSR	500	1664
144	MA	Morocco	MOROCCO	MAR	504	212
145	MZ	Mozambique	MOZAMBIQUE	MOZ	508	258
146	MM	Myanmar	MYANMAR	MMR	104	95
147	NA	Namibia	NAMIBIA	NAM	516	264
148	NR	Nauru	NAURU	NRU	520	674
149	NP	Nepal	NEPAL	NPL	524	977
150	NL	Netherlands	NETHERLANDS	NLD	528	31
151	AN	Netherlands Antilles	NETHERLANDS ANTILLES	ANT	530	599
152	NC	New Caledonia	NEW CALEDONIA	NCL	540	687
153	NZ	New Zealand	NEW ZEALAND	NZL	554	64
154	NI	Nicaragua	NICARAGUA	NIC	558	505
155	NE	Niger	NIGER	NER	562	227
156	NG	Nigeria	NIGERIA	NGA	566	234
157	NU	Niue	NIUE	NIU	570	683
158	NF	Norfolk Island	NORFOLK ISLAND	NFK	574	672
159	MP	Northern Mariana Islands	NORTHERN MARIANA ISLANDS	MNP	580	1670
160	NO	Norway	NORWAY	NOR	578	47
161	OM	Oman	OMAN	OMN	512	968
162	PK	Pakistan	PAKISTAN	PAK	586	92
163	PW	Palau	PALAU	PLW	585	680
164	PS	Palestinian Territory, Occupied	PALESTINIAN TERRITORY, OCCUPIED	\N	\N	970
165	PA	Panama	PANAMA	PAN	591	507
166	PG	Papua New Guinea	PAPUA NEW GUINEA	PNG	598	675
167	PY	Paraguay	PARAGUAY	PRY	600	595
168	PE	Peru	PERU	PER	604	51
169	PH	Philippines	PHILIPPINES	PHL	608	63
170	PN	Pitcairn	PITCAIRN	PCN	612	0
171	PL	Poland	POLAND	POL	616	48
172	PT	Portugal	PORTUGAL	PRT	620	351
173	PR	Puerto Rico	PUERTO RICO	PRI	630	1787
174	QA	Qatar	QATAR	QAT	634	974
175	RE	Reunion	REUNION	REU	638	262
176	RO	Romania	ROMANIA	ROU	642	40
177	RU	Russian Federation	RUSSIAN FEDERATION	RUS	643	7
178	RW	Rwanda	RWANDA	RWA	646	250
179	SH	Saint Helena	SAINT HELENA	SHN	654	290
180	KN	Saint Kitts and Nevis	SAINT KITTS AND NEVIS	KNA	659	1869
181	LC	Saint Lucia	SAINT LUCIA	LCA	662	1758
182	PM	Saint Pierre and Miquelon	SAINT PIERRE AND MIQUELON	SPM	666	508
183	VC	Saint Vincent and the Grenadines	SAINT VINCENT AND THE GRENADINES	VCT	670	1784
184	WS	Samoa	SAMOA	WSM	882	684
185	SM	San Marino	SAN MARINO	SMR	674	378
186	ST	Sao Tome and Principe	SAO TOME AND PRINCIPE	STP	678	239
187	SA	Saudi Arabia	SAUDI ARABIA	SAU	682	966
188	SN	Senegal	SENEGAL	SEN	686	221
189	RS	Serbia	SERBIA	SRB	688	381
190	SC	Seychelles	SEYCHELLES	SYC	690	248
191	SL	Sierra Leone	SIERRA LEONE	SLE	694	232
192	SG	Singapore	SINGAPORE	SGP	702	65
193	SK	Slovakia	SLOVAKIA	SVK	703	421
194	SI	Slovenia	SLOVENIA	SVN	705	386
195	SB	Solomon Islands	SOLOMON ISLANDS	SLB	90	677
196	SO	Somalia	SOMALIA	SOM	706	252
197	ZA	South Africa	SOUTH AFRICA	ZAF	710	27
198	GS	South Georgia and the South Sandwich Islands	SOUTH GEORGIA AND THE SOUTH SANDWICH ISLANDS	SGS	239	0
199	ES	Spain	SPAIN	ESP	724	34
200	LK	Sri Lanka	SRI LANKA	LKA	144	94
201	SD	Sudan	SUDAN	SDN	736	249
202	SR	Suriname	SURINAME	SUR	740	597
203	SJ	Svalbard and Jan Mayen	SVALBARD AND JAN MAYEN	SJM	744	47
204	SZ	Swaziland	SWAZILAND	SWZ	748	268
205	SE	Sweden	SWEDEN	SWE	752	46
206	CH	Switzerland	SWITZERLAND	CHE	756	41
207	SY	Syrian Arab Republic	SYRIAN ARAB REPUBLIC	SYR	760	963
208	TW	Taiwan, Province of China	TAIWAN, PROVINCE OF CHINA	TWN	158	886
209	TJ	Tajikistan	TAJIKISTAN	TJK	762	992
210	TZ	Tanzania, United Republic of	TANZANIA, UNITED REPUBLIC OF	TZA	834	255
211	TH	Thailand	THAILAND	THA	764	66
212	TL	Timor-Leste	TIMOR-LESTE	TLS	626	670
213	TG	Togo	TOGO	TGO	768	228
214	TK	Tokelau	TOKELAU	TKL	772	690
215	TO	Tonga	TONGA	TON	776	676
216	TT	Trinidad and Tobago	TRINIDAD AND TOBAGO	TTO	780	1868
217	TN	Tunisia	TUNISIA	TUN	788	216
218	TR	Turkey	TURKEY	TUR	792	90
219	TM	Turkmenistan	TURKMENISTAN	TKM	795	993
220	TC	Turks and Caicos Islands	TURKS AND CAICOS ISLANDS	TCA	796	1649
221	TV	Tuvalu	TUVALU	TUV	798	688
222	UG	Uganda	UGANDA	UGA	800	256
223	UA	Ukraine	UKRAINE	UKR	804	380
224	AE	United Arab Emirates	UNITED ARAB EMIRATES	ARE	784	971
225	GB	United Kingdom	UNITED KINGDOM	GBR	826	44
226	US	United States	UNITED STATES	USA	840	1
227	UM	United States Minor Outlying Islands	UNITED STATES MINOR OUTLYING ISLANDS	UMI	581	1
228	UY	Uruguay	URUGUAY	URY	858	598
229	UZ	Uzbekistan	UZBEKISTAN	UZB	860	998
230	VU	Vanuatu	VANUATU	VUT	548	678
231	VE	Venezuela	VENEZUELA	VEN	862	58
232	VN	Viet Nam	VIET NAM	VNM	704	84
233	VG	Virgin Islands, British	VIRGIN ISLANDS, BRITISH	VGB	92	1284
234	VI	Virgin Islands, U.s.	VIRGIN ISLANDS, U.S.	VIR	850	1340
235	WF	Wallis and Futuna	WALLIS AND FUTUNA	WLF	876	681
236	EH	Western Sahara	WESTERN SAHARA	ESH	732	212
237	YE	Yemen	YEMEN	YEM	887	967
238	ZM	Zambia	ZAMBIA	ZMB	894	260
239	ZW	Zimbabwe	ZIMBABWE	ZWE	716	263
240	ME	Montenegro	MONTENEGRO	MNE	499	382
241	XK	Kosovo	KOSOVO	XKX	0	383
242	AX	Aland Islands	ALAND ISLANDS	ALA	248	358
243	BQ	Bonaire, Sint Eustatius and Saba	BONAIRE, SINT EUSTATIUS AND SABA	BES	535	599
244	CW	Curacao	CURACAO	CUW	531	599
245	GG	Guernsey	GUERNSEY	GGY	831	44
246	IM	Isle of Man	ISLE OF MAN	IMN	833	44
247	JE	Jersey	JERSEY	JEY	832	44
248	BL	Saint Barthelemy	SAINT BARTHELEMY	BLM	652	590
249	MF	Saint Martin	SAINT MARTIN	MAF	663	590
250	SX	Sint Maarten	SINT MAARTEN	SXM	534	1
251	SS	South Sudan	SOUTH SUDAN	SSD	728	211
\.


--
-- Data for Name: coupons; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.coupons (id, code, discount_value, discount_type, times_used, max_usage, order_amount_limit, coupon_start_date, coupon_end_date, created_at, updated_at, created_by, updated_by) FROM stdin;
\.


--
-- Data for Name: customer_addresses; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.customer_addresses (id, customer_id, address_line1, address_line2, phone_number, dial_code, country, postal_code, city) FROM stdin;
\.


--
-- Data for Name: customers; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.customers (id, first_name, last_name, email, password_hash, active, registered_at, updated_at) FROM stdin;
\.


--
-- Data for Name: gallery_part1; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.gallery_part1 (id, product_id, image, placeholder, is_thumbnail, created_at, updated_at) FROM stdin;
\.


--
-- Data for Name: gallery_part2; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.gallery_part2 (id, product_id, image, placeholder, is_thumbnail, created_at, updated_at) FROM stdin;
\.


--
-- Data for Name: gallery_part3; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.gallery_part3 (id, product_id, image, placeholder, is_thumbnail, created_at, updated_at) FROM stdin;
\.


--
-- Data for Name: notifications; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.notifications (id, account_id, title, content, seen, created_at, receive_time, notification_expiry_date) FROM stdin;
\.


--
-- Data for Name: order_items; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.order_items (id, product_id, order_id, price, quantity) FROM stdin;
\.


--
-- Data for Name: order_statuses; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.order_statuses (id, status_name, color, privacy, created_at, updated_at, created_by, updated_by) FROM stdin;
a8da6597-5a70-435b-889d-4aaae58f65d7	Delivered	#5ae510	public	2026-01-02 18:32:51.024218+00	2026-01-02 18:32:51.024218+00	\N	\N
5fa2794b-6e47-4693-a7e5-1d12f809d1d1	Unreached	#ff03d3	public	2026-01-02 18:32:51.024218+00	2026-01-02 18:32:51.024218+00	\N	\N
53455244-4003-4afc-ad12-83d2687d6ad4	Paid	#4caf50	public	2026-01-02 18:32:51.024218+00	2026-01-02 18:32:51.024218+00	\N	\N
dcd9c401-b184-4ee4-a8fa-37bcc3e54138	Confirmed	#00d4cb	public	2026-01-02 18:32:51.024218+00	2026-01-02 18:32:51.024218+00	\N	\N
bc8092e6-bcde-458d-b75a-ed0da7adce11	Processing	#ab5ae9	public	2026-01-02 18:32:51.024218+00	2026-01-02 18:32:51.024218+00	\N	\N
c2bca22a-88d8-4cc0-b90d-08e9d4c129d9	Pending	#ffe224	public	2026-01-02 18:32:51.024218+00	2026-01-02 18:32:51.024218+00	\N	\N
d7bb1f18-3483-4106-858d-5d6aab0e1b0b	On Hold	#d6d6d6	public	2026-01-02 18:32:51.024218+00	2026-01-02 18:32:51.024218+00	\N	\N
fab5e076-2427-4293-acca-dfc75a9eb020	Shipped	#71f9f7	public	2026-01-02 18:32:51.024218+00	2026-01-02 18:32:51.024218+00	\N	\N
59c1aa4d-53ff-408b-9308-38f1ad591478	Cancelled	#FD9F3D	public	2026-01-02 18:32:51.024218+00	2026-01-02 18:32:51.024218+00	\N	\N
08a3ff77-0182-44b5-90f2-536566564075	Refused	#FF532F	private	2026-01-02 18:32:51.024218+00	2026-01-02 18:32:51.024218+00	\N	\N
5d52e342-34ea-47b9-9612-c53704769c3d	Awaiting Return	#000	private	2026-01-02 18:32:51.024218+00	2026-01-02 18:32:51.024218+00	\N	\N
c2a26489-afc7-4921-b979-5c1ed53d0ddc	Returned	#000	private	2026-01-02 18:32:51.024218+00	2026-01-02 18:32:51.024218+00	\N	\N
\.


--
-- Data for Name: orders; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.orders (id, coupon_id, customer_id, order_status_id, order_approved_at, order_delivered_carrier_date, order_delivered_customer_date, created_at, updated_by) FROM stdin;
\.


--
-- Data for Name: product_attribute_values; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.product_attribute_values (id, product_attribute_id, attribute_value_id) FROM stdin;
\.


--
-- Data for Name: product_attributes; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.product_attributes (id, product_id, attribute_id) FROM stdin;
\.


--
-- Data for Name: product_categories; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.product_categories (id, product_id, category_id) FROM stdin;
\.


--
-- Data for Name: product_coupons; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.product_coupons (id, product_id, coupon_id) FROM stdin;
\.


--
-- Data for Name: product_shipping_info; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.product_shipping_info (id, product_id, weight, weight_unit, volume, volume_unit, dimension_width, dimension_height, dimension_depth, dimension_unit) FROM stdin;
\.


--
-- Data for Name: product_suppliers; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.product_suppliers (product_id, supplier_id) FROM stdin;
\.


--
-- Data for Name: product_tags; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.product_tags (tag_id, product_id) FROM stdin;
\.


--
-- Data for Name: products; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.products (id, slug, product_name, sku, sale_price, compare_price, buying_price, quantity, short_description, product_description, product_type, published, disable_out_of_stock, note, created_at, updated_at, created_by, updated_by) FROM stdin;
\.


--
-- Data for Name: roles; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.roles (id, role_name, privileges) FROM stdin;
1	Store Administrator	{super_admin_privilege,admin_read_privilege,admin_create_privilege,admin_update_privilege,admin_delete_privilege,staff_read_privilege,staff_create_privilege,staff_update_privilege,staff_delete_privilege}
2	Sales Manager	{admin_read_privilege,admin_create_privilege,admin_update_privilege,admin_delete_privilege,staff_read_privilege,staff_create_privilege,staff_update_privilege,staff_delete_privilege}
3	Sales Staff	{staff_read_privilege,staff_create_privilege,staff_update_privilege,staff_delete_privilege}
4	Guest	{staff_read_privilege}
5	Investor	{admin_read_privilege,staff_read_privilege}
\.


--
-- Data for Name: sells; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.sells (id, product_id, price, quantity) FROM stdin;
\.


--
-- Data for Name: shipping_country_zones; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.shipping_country_zones (id, shipping_zone_id, country_id) FROM stdin;
\.


--
-- Data for Name: shipping_rates; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.shipping_rates (id, shipping_zone_id, weight_unit, min_value, max_value, no_max, price) FROM stdin;
\.


--
-- Data for Name: shipping_zones; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.shipping_zones (id, name, display_name, active, free_shipping, rate_type, created_at, updated_at, created_by, updated_by) FROM stdin;
\.


--
-- Data for Name: slideshows; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.slideshows (id, title, destination_url, image, placeholder, description, btn_label, display_order, published, clicks, styles, created_at, updated_at, created_by, updated_by) FROM stdin;
\.


--
-- Data for Name: staff_accounts; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.staff_accounts (id, role_id, first_name, last_name, phone_number, email, password_hash, active, image, placeholder, created_at, updated_at, created_by, updated_by) FROM stdin;
\.


--
-- Data for Name: suppliers; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.suppliers (id, supplier_name, company, phone_number, address_line1, address_line2, country_id, city, note, created_at, updated_at, created_by, updated_by) FROM stdin;
\.


--
-- Data for Name: tags; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.tags (id, tag_name, icon, created_at, updated_at, created_by, updated_by) FROM stdin;
79bdc9d9-2297-493f-8f14-2bfa9c744ed6	Tools	Tools	2026-01-02 18:32:51.026132+00	2026-01-02 18:32:51.026132+00	\N	\N
45bb7e08-5070-458e-8e08-56fc76e9d75a	Beauty Health	BeautyHealth	2026-01-02 18:32:51.026132+00	2026-01-02 18:32:51.026132+00	\N	\N
9c7b959d-669c-470e-992a-6e885d91f216	Shirts	Shirts	2026-01-02 18:32:51.026132+00	2026-01-02 18:32:51.026132+00	\N	\N
147da66c-e5df-4eb2-908c-06a33479d138	Accessories	Accessories	2026-01-02 18:32:51.026132+00	2026-01-02 18:32:51.026132+00	\N	\N
\.


--
-- Data for Name: variant_options; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.variant_options (id, title, image_id, product_id, sale_price, compare_price, buying_price, quantity, sku, active) FROM stdin;
\.


--
-- Data for Name: variant_values; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.variant_values (id, variant_id, product_attribute_value_id) FROM stdin;
\.


--
-- Data for Name: variants; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.variants (id, variant_option, product_id, variant_option_id) FROM stdin;
\.


--
-- Name: countries_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.countries_seq', 1, false);


--
-- Name: roles_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.roles_id_seq', 1, false);


--
-- Name: sells_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.sells_id_seq', 1, false);


--
-- Name: shipping_zones_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.shipping_zones_id_seq', 1, false);


--
-- Name: attribute_values attribute_values_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.attribute_values
    ADD CONSTRAINT attribute_values_pkey PRIMARY KEY (id);


--
-- Name: attributes attributes_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.attributes
    ADD CONSTRAINT attributes_pkey PRIMARY KEY (id);


--
-- Name: card_items card_items_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.card_items
    ADD CONSTRAINT card_items_pkey PRIMARY KEY (id);


--
-- Name: cards cards_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.cards
    ADD CONSTRAINT cards_pkey PRIMARY KEY (id);


--
-- Name: categories categories_category_name_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.categories
    ADD CONSTRAINT categories_category_name_key UNIQUE (category_name);


--
-- Name: categories categories_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.categories
    ADD CONSTRAINT categories_pkey PRIMARY KEY (id);


--
-- Name: countries countries_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.countries
    ADD CONSTRAINT countries_pkey PRIMARY KEY (id);


--
-- Name: coupons coupons_code_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.coupons
    ADD CONSTRAINT coupons_code_key UNIQUE (code);


--
-- Name: coupons coupons_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.coupons
    ADD CONSTRAINT coupons_pkey PRIMARY KEY (id);


--
-- Name: customer_addresses customer_addresses_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.customer_addresses
    ADD CONSTRAINT customer_addresses_pkey PRIMARY KEY (id);


--
-- Name: customers customers_email_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.customers
    ADD CONSTRAINT customers_email_key UNIQUE (email);


--
-- Name: customers customers_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.customers
    ADD CONSTRAINT customers_pkey PRIMARY KEY (id);


--
-- Name: gallery gallery_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.gallery
    ADD CONSTRAINT gallery_pkey PRIMARY KEY (id);


--
-- Name: gallery_part1 gallery_part1_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.gallery_part1
    ADD CONSTRAINT gallery_part1_pkey PRIMARY KEY (id);


--
-- Name: gallery_part2 gallery_part2_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.gallery_part2
    ADD CONSTRAINT gallery_part2_pkey PRIMARY KEY (id);


--
-- Name: gallery_part3 gallery_part3_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.gallery_part3
    ADD CONSTRAINT gallery_part3_pkey PRIMARY KEY (id);


--
-- Name: notifications notifications_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.notifications
    ADD CONSTRAINT notifications_pkey PRIMARY KEY (id);


--
-- Name: order_items order_items_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.order_items
    ADD CONSTRAINT order_items_pkey PRIMARY KEY (id);


--
-- Name: order_statuses order_statuses_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.order_statuses
    ADD CONSTRAINT order_statuses_pkey PRIMARY KEY (id);


--
-- Name: orders orders_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.orders
    ADD CONSTRAINT orders_pkey PRIMARY KEY (id);


--
-- Name: product_attribute_values product_attribute_values_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.product_attribute_values
    ADD CONSTRAINT product_attribute_values_pkey PRIMARY KEY (id);


--
-- Name: product_attributes product_attributes_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.product_attributes
    ADD CONSTRAINT product_attributes_pkey PRIMARY KEY (id);


--
-- Name: product_categories product_categories_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.product_categories
    ADD CONSTRAINT product_categories_pkey PRIMARY KEY (id);


--
-- Name: product_coupons product_coupons_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.product_coupons
    ADD CONSTRAINT product_coupons_pkey PRIMARY KEY (id);


--
-- Name: product_shipping_info product_shipping_info_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.product_shipping_info
    ADD CONSTRAINT product_shipping_info_pkey PRIMARY KEY (id);


--
-- Name: product_suppliers product_suppliers_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.product_suppliers
    ADD CONSTRAINT product_suppliers_pkey PRIMARY KEY (product_id, supplier_id);


--
-- Name: product_tags product_tags_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.product_tags
    ADD CONSTRAINT product_tags_pkey PRIMARY KEY (tag_id, product_id);


--
-- Name: products products_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.products
    ADD CONSTRAINT products_pkey PRIMARY KEY (id);


--
-- Name: products products_slug_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.products
    ADD CONSTRAINT products_slug_key UNIQUE (slug);


--
-- Name: roles roles_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.roles
    ADD CONSTRAINT roles_pkey PRIMARY KEY (id);


--
-- Name: sells sells_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.sells
    ADD CONSTRAINT sells_pkey PRIMARY KEY (id);


--
-- Name: sells sells_product_id_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.sells
    ADD CONSTRAINT sells_product_id_key UNIQUE (product_id);


--
-- Name: shipping_country_zones shipping_country_zones_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.shipping_country_zones
    ADD CONSTRAINT shipping_country_zones_pkey PRIMARY KEY (id);


--
-- Name: shipping_rates shipping_rates_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.shipping_rates
    ADD CONSTRAINT shipping_rates_pkey PRIMARY KEY (id);


--
-- Name: shipping_zones shipping_zones_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.shipping_zones
    ADD CONSTRAINT shipping_zones_pkey PRIMARY KEY (id);


--
-- Name: slideshows slideshows_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.slideshows
    ADD CONSTRAINT slideshows_pkey PRIMARY KEY (id);


--
-- Name: staff_accounts staff_accounts_email_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.staff_accounts
    ADD CONSTRAINT staff_accounts_email_key UNIQUE (email);


--
-- Name: staff_accounts staff_accounts_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.staff_accounts
    ADD CONSTRAINT staff_accounts_pkey PRIMARY KEY (id);


--
-- Name: suppliers suppliers_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.suppliers
    ADD CONSTRAINT suppliers_pkey PRIMARY KEY (id);


--
-- Name: tags tags_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.tags
    ADD CONSTRAINT tags_pkey PRIMARY KEY (id);


--
-- Name: variant_options variant_options_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.variant_options
    ADD CONSTRAINT variant_options_pkey PRIMARY KEY (id);


--
-- Name: variant_values variant_values_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.variant_values
    ADD CONSTRAINT variant_values_pkey PRIMARY KEY (id);


--
-- Name: variants variants_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.variants
    ADD CONSTRAINT variants_pkey PRIMARY KEY (id);


--
-- Name: idx_image_gallery; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_image_gallery ON ONLY public.gallery USING btree (product_id, is_thumbnail);


--
-- Name: gallery_part1_product_id_is_thumbnail_idx; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX gallery_part1_product_id_is_thumbnail_idx ON public.gallery_part1 USING btree (product_id, is_thumbnail);


--
-- Name: gallery_part2_product_id_is_thumbnail_idx; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX gallery_part2_product_id_is_thumbnail_idx ON public.gallery_part2 USING btree (product_id, is_thumbnail);


--
-- Name: gallery_part3_product_id_is_thumbnail_idx; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX gallery_part3_product_id_is_thumbnail_idx ON public.gallery_part3 USING btree (product_id, is_thumbnail);


--
-- Name: idx_attribute_values; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_attribute_values ON public.attribute_values USING btree (attribute_id);


--
-- Name: idx_code_coupons; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_code_coupons ON public.coupons USING btree (code);


--
-- Name: idx_country_id_shipping_country_zones; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_country_id_shipping_country_zones ON public.shipping_country_zones USING btree (country_id);


--
-- Name: idx_customer_email; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_customer_email ON public.customers USING btree (email);


--
-- Name: idx_customer_id_card; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_customer_id_card ON public.cards USING btree (customer_id);


--
-- Name: idx_order_customer_id; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_order_customer_id ON public.orders USING btree (customer_id);


--
-- Name: idx_order_id_order_item; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_order_id_order_item ON public.order_items USING btree (order_id);


--
-- Name: idx_product_attribute_fk; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_product_attribute_fk ON public.product_attributes USING btree (product_id, attribute_id);


--
-- Name: idx_product_attribute_value_id_variant_values; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_product_attribute_value_id_variant_values ON public.variant_values USING btree (product_attribute_value_id);


--
-- Name: idx_product_attribute_values_attribute_value_id; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_product_attribute_values_attribute_value_id ON public.product_attribute_values USING btree (attribute_value_id);


--
-- Name: idx_product_attribute_values_product_attribute_id; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_product_attribute_values_product_attribute_id ON public.product_attribute_values USING btree (product_attribute_id);


--
-- Name: idx_product_category; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_product_category ON public.product_categories USING btree (product_id, category_id);


--
-- Name: idx_product_id_coupon_id_product_coupons; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_product_id_coupon_id_product_coupons ON public.product_coupons USING btree (product_id, coupon_id);


--
-- Name: idx_product_id_order_item; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_product_id_order_item ON public.order_items USING btree (product_id);


--
-- Name: idx_product_id_variants; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_product_id_variants ON public.variants USING btree (product_id);


--
-- Name: idx_product_publish; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_product_publish ON public.products USING btree (published);


--
-- Name: idx_product_shipping_info_product_id; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_product_shipping_info_product_id ON public.product_shipping_info USING btree (product_id);


--
-- Name: idx_product_supplier; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_product_supplier ON public.product_suppliers USING btree (product_id, supplier_id);


--
-- Name: idx_shipping_zone_id_shipping_country_zones; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_shipping_zone_id_shipping_country_zones ON public.shipping_country_zones USING btree (shipping_zone_id);


--
-- Name: idx_slideshows_publish; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_slideshows_publish ON public.slideshows USING btree (published);


--
-- Name: idx_variant_id_variant_values; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_variant_id_variant_values ON public.variant_values USING btree (variant_id);


--
-- Name: idx_variant_option_id_variants; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_variant_option_id_variants ON public.variants USING btree (variant_option_id);


--
-- Name: idx_variant_options_product_id; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_variant_options_product_id ON public.variant_options USING btree (product_id);


--
-- Name: gallery_part1_pkey; Type: INDEX ATTACH; Schema: public; Owner: postgres
--

ALTER INDEX public.gallery_pkey ATTACH PARTITION public.gallery_part1_pkey;


--
-- Name: gallery_part1_product_id_is_thumbnail_idx; Type: INDEX ATTACH; Schema: public; Owner: postgres
--

ALTER INDEX public.idx_image_gallery ATTACH PARTITION public.gallery_part1_product_id_is_thumbnail_idx;


--
-- Name: gallery_part2_pkey; Type: INDEX ATTACH; Schema: public; Owner: postgres
--

ALTER INDEX public.gallery_pkey ATTACH PARTITION public.gallery_part2_pkey;


--
-- Name: gallery_part2_product_id_is_thumbnail_idx; Type: INDEX ATTACH; Schema: public; Owner: postgres
--

ALTER INDEX public.idx_image_gallery ATTACH PARTITION public.gallery_part2_product_id_is_thumbnail_idx;


--
-- Name: gallery_part3_pkey; Type: INDEX ATTACH; Schema: public; Owner: postgres
--

ALTER INDEX public.gallery_pkey ATTACH PARTITION public.gallery_part3_pkey;


--
-- Name: gallery_part3_product_id_is_thumbnail_idx; Type: INDEX ATTACH; Schema: public; Owner: postgres
--

ALTER INDEX public.idx_image_gallery ATTACH PARTITION public.gallery_part3_product_id_is_thumbnail_idx;


--
-- Name: attributes attribute_set_update; Type: TRIGGER; Schema: public; Owner: postgres
--

CREATE TRIGGER attribute_set_update BEFORE UPDATE ON public.attributes FOR EACH ROW EXECUTE FUNCTION public.update_at_timestamp();


--
-- Name: categories category_set_update; Type: TRIGGER; Schema: public; Owner: postgres
--

CREATE TRIGGER category_set_update BEFORE UPDATE ON public.categories FOR EACH ROW EXECUTE FUNCTION public.update_at_timestamp();


--
-- Name: coupons coupon_set_update; Type: TRIGGER; Schema: public; Owner: postgres
--

CREATE TRIGGER coupon_set_update BEFORE UPDATE ON public.coupons FOR EACH ROW EXECUTE FUNCTION public.update_at_timestamp();


--
-- Name: customers customer_set_update; Type: TRIGGER; Schema: public; Owner: postgres
--

CREATE TRIGGER customer_set_update BEFORE UPDATE ON public.customers FOR EACH ROW EXECUTE FUNCTION public.update_at_timestamp();


--
-- Name: gallery gallery_set_update; Type: TRIGGER; Schema: public; Owner: postgres
--

CREATE TRIGGER gallery_set_update BEFORE UPDATE ON public.gallery FOR EACH ROW EXECUTE FUNCTION public.update_at_timestamp();


--
-- Name: notifications notification_set_update; Type: TRIGGER; Schema: public; Owner: postgres
--

CREATE TRIGGER notification_set_update BEFORE UPDATE ON public.notifications FOR EACH ROW EXECUTE FUNCTION public.update_at_timestamp();


--
-- Name: orders order_set_update; Type: TRIGGER; Schema: public; Owner: postgres
--

CREATE TRIGGER order_set_update BEFORE UPDATE ON public.orders FOR EACH ROW EXECUTE FUNCTION public.update_at_timestamp();


--
-- Name: order_statuses order_statuse_set_update; Type: TRIGGER; Schema: public; Owner: postgres
--

CREATE TRIGGER order_statuse_set_update BEFORE UPDATE ON public.order_statuses FOR EACH ROW EXECUTE FUNCTION public.update_at_timestamp();


--
-- Name: products product_set_update; Type: TRIGGER; Schema: public; Owner: postgres
--

CREATE TRIGGER product_set_update BEFORE UPDATE ON public.products FOR EACH ROW EXECUTE FUNCTION public.update_at_timestamp();


--
-- Name: slideshows slideshow_set_update; Type: TRIGGER; Schema: public; Owner: postgres
--

CREATE TRIGGER slideshow_set_update BEFORE UPDATE ON public.slideshows FOR EACH ROW EXECUTE FUNCTION public.update_at_timestamp();


--
-- Name: staff_accounts staff_set_update; Type: TRIGGER; Schema: public; Owner: postgres
--

CREATE TRIGGER staff_set_update BEFORE UPDATE ON public.staff_accounts FOR EACH ROW EXECUTE FUNCTION public.update_at_timestamp();


--
-- Name: suppliers suppliers_set_update; Type: TRIGGER; Schema: public; Owner: postgres
--

CREATE TRIGGER suppliers_set_update BEFORE UPDATE ON public.suppliers FOR EACH ROW EXECUTE FUNCTION public.update_at_timestamp();


--
-- Name: tags tag_set_update; Type: TRIGGER; Schema: public; Owner: postgres
--

CREATE TRIGGER tag_set_update BEFORE UPDATE ON public.tags FOR EACH ROW EXECUTE FUNCTION public.update_at_timestamp();


--
-- Name: attribute_values attribute_values_attribute_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.attribute_values
    ADD CONSTRAINT attribute_values_attribute_id_fkey FOREIGN KEY (attribute_id) REFERENCES public.attributes(id);


--
-- Name: attributes attributes_created_by_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.attributes
    ADD CONSTRAINT attributes_created_by_fkey FOREIGN KEY (created_by) REFERENCES public.staff_accounts(id);


--
-- Name: attributes attributes_updated_by_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.attributes
    ADD CONSTRAINT attributes_updated_by_fkey FOREIGN KEY (updated_by) REFERENCES public.staff_accounts(id);


--
-- Name: card_items card_items_card_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.card_items
    ADD CONSTRAINT card_items_card_id_fkey FOREIGN KEY (card_id) REFERENCES public.cards(id);


--
-- Name: card_items card_items_product_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.card_items
    ADD CONSTRAINT card_items_product_id_fkey FOREIGN KEY (product_id) REFERENCES public.products(id);


--
-- Name: cards cards_customer_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.cards
    ADD CONSTRAINT cards_customer_id_fkey FOREIGN KEY (customer_id) REFERENCES public.customers(id);


--
-- Name: categories categories_created_by_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.categories
    ADD CONSTRAINT categories_created_by_fkey FOREIGN KEY (created_by) REFERENCES public.staff_accounts(id);


--
-- Name: categories categories_parent_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.categories
    ADD CONSTRAINT categories_parent_id_fkey FOREIGN KEY (parent_id) REFERENCES public.categories(id) ON DELETE SET NULL;


--
-- Name: categories categories_updated_by_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.categories
    ADD CONSTRAINT categories_updated_by_fkey FOREIGN KEY (updated_by) REFERENCES public.staff_accounts(id);


--
-- Name: coupons coupons_created_by_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.coupons
    ADD CONSTRAINT coupons_created_by_fkey FOREIGN KEY (created_by) REFERENCES public.staff_accounts(id);


--
-- Name: coupons coupons_updated_by_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.coupons
    ADD CONSTRAINT coupons_updated_by_fkey FOREIGN KEY (updated_by) REFERENCES public.staff_accounts(id);


--
-- Name: customer_addresses customer_addresses_customer_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.customer_addresses
    ADD CONSTRAINT customer_addresses_customer_id_fkey FOREIGN KEY (customer_id) REFERENCES public.customers(id);


--
-- Name: gallery gallery_product_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE public.gallery
    ADD CONSTRAINT gallery_product_id_fkey FOREIGN KEY (product_id) REFERENCES public.products(id);


--
-- Name: notifications notifications_account_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.notifications
    ADD CONSTRAINT notifications_account_id_fkey FOREIGN KEY (account_id) REFERENCES public.staff_accounts(id);


--
-- Name: order_items order_items_order_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.order_items
    ADD CONSTRAINT order_items_order_id_fkey FOREIGN KEY (order_id) REFERENCES public.orders(id);


--
-- Name: order_items order_items_product_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.order_items
    ADD CONSTRAINT order_items_product_id_fkey FOREIGN KEY (product_id) REFERENCES public.products(id);


--
-- Name: order_statuses order_statuses_created_by_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.order_statuses
    ADD CONSTRAINT order_statuses_created_by_fkey FOREIGN KEY (created_by) REFERENCES public.staff_accounts(id);


--
-- Name: order_statuses order_statuses_updated_by_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.order_statuses
    ADD CONSTRAINT order_statuses_updated_by_fkey FOREIGN KEY (updated_by) REFERENCES public.staff_accounts(id);


--
-- Name: orders orders_coupon_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.orders
    ADD CONSTRAINT orders_coupon_id_fkey FOREIGN KEY (coupon_id) REFERENCES public.coupons(id) ON DELETE SET NULL;


--
-- Name: orders orders_customer_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.orders
    ADD CONSTRAINT orders_customer_id_fkey FOREIGN KEY (customer_id) REFERENCES public.customers(id);


--
-- Name: orders orders_order_status_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.orders
    ADD CONSTRAINT orders_order_status_id_fkey FOREIGN KEY (order_status_id) REFERENCES public.order_statuses(id) ON DELETE SET NULL;


--
-- Name: orders orders_updated_by_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.orders
    ADD CONSTRAINT orders_updated_by_fkey FOREIGN KEY (updated_by) REFERENCES public.staff_accounts(id);


--
-- Name: product_attribute_values product_attribute_values_attribute_value_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.product_attribute_values
    ADD CONSTRAINT product_attribute_values_attribute_value_id_fkey FOREIGN KEY (attribute_value_id) REFERENCES public.attribute_values(id);


--
-- Name: product_attribute_values product_attribute_values_product_attribute_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.product_attribute_values
    ADD CONSTRAINT product_attribute_values_product_attribute_id_fkey FOREIGN KEY (product_attribute_id) REFERENCES public.product_attributes(id);


--
-- Name: product_attributes product_attributes_attribute_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.product_attributes
    ADD CONSTRAINT product_attributes_attribute_id_fkey FOREIGN KEY (attribute_id) REFERENCES public.attributes(id);


--
-- Name: product_attributes product_attributes_product_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.product_attributes
    ADD CONSTRAINT product_attributes_product_id_fkey FOREIGN KEY (product_id) REFERENCES public.products(id);


--
-- Name: product_categories product_categories_category_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.product_categories
    ADD CONSTRAINT product_categories_category_id_fkey FOREIGN KEY (category_id) REFERENCES public.categories(id);


--
-- Name: product_categories product_categories_product_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.product_categories
    ADD CONSTRAINT product_categories_product_id_fkey FOREIGN KEY (product_id) REFERENCES public.products(id);


--
-- Name: product_coupons product_coupons_coupon_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.product_coupons
    ADD CONSTRAINT product_coupons_coupon_id_fkey FOREIGN KEY (coupon_id) REFERENCES public.coupons(id);


--
-- Name: product_coupons product_coupons_product_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.product_coupons
    ADD CONSTRAINT product_coupons_product_id_fkey FOREIGN KEY (product_id) REFERENCES public.products(id);


--
-- Name: product_shipping_info product_shipping_info_product_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.product_shipping_info
    ADD CONSTRAINT product_shipping_info_product_id_fkey FOREIGN KEY (product_id) REFERENCES public.products(id) ON DELETE SET NULL;


--
-- Name: product_suppliers product_suppliers_product_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.product_suppliers
    ADD CONSTRAINT product_suppliers_product_id_fkey FOREIGN KEY (product_id) REFERENCES public.products(id);


--
-- Name: product_suppliers product_suppliers_supplier_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.product_suppliers
    ADD CONSTRAINT product_suppliers_supplier_id_fkey FOREIGN KEY (supplier_id) REFERENCES public.suppliers(id);


--
-- Name: product_tags product_tags_product_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.product_tags
    ADD CONSTRAINT product_tags_product_id_fkey FOREIGN KEY (product_id) REFERENCES public.products(id);


--
-- Name: product_tags product_tags_tag_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.product_tags
    ADD CONSTRAINT product_tags_tag_id_fkey FOREIGN KEY (tag_id) REFERENCES public.tags(id);


--
-- Name: products products_created_by_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.products
    ADD CONSTRAINT products_created_by_fkey FOREIGN KEY (created_by) REFERENCES public.staff_accounts(id);


--
-- Name: products products_updated_by_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.products
    ADD CONSTRAINT products_updated_by_fkey FOREIGN KEY (updated_by) REFERENCES public.staff_accounts(id);


--
-- Name: sells sells_product_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.sells
    ADD CONSTRAINT sells_product_id_fkey FOREIGN KEY (product_id) REFERENCES public.products(id);


--
-- Name: shipping_country_zones shipping_country_zones_country_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.shipping_country_zones
    ADD CONSTRAINT shipping_country_zones_country_id_fkey FOREIGN KEY (country_id) REFERENCES public.countries(id);


--
-- Name: shipping_country_zones shipping_country_zones_shipping_zone_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.shipping_country_zones
    ADD CONSTRAINT shipping_country_zones_shipping_zone_id_fkey FOREIGN KEY (shipping_zone_id) REFERENCES public.shipping_zones(id);


--
-- Name: shipping_rates shipping_rates_shipping_zone_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.shipping_rates
    ADD CONSTRAINT shipping_rates_shipping_zone_id_fkey FOREIGN KEY (shipping_zone_id) REFERENCES public.shipping_zones(id);


--
-- Name: shipping_zones shipping_zones_created_by_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.shipping_zones
    ADD CONSTRAINT shipping_zones_created_by_fkey FOREIGN KEY (created_by) REFERENCES public.staff_accounts(id);


--
-- Name: shipping_zones shipping_zones_updated_by_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.shipping_zones
    ADD CONSTRAINT shipping_zones_updated_by_fkey FOREIGN KEY (updated_by) REFERENCES public.staff_accounts(id);


--
-- Name: slideshows slideshows_created_by_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.slideshows
    ADD CONSTRAINT slideshows_created_by_fkey FOREIGN KEY (created_by) REFERENCES public.staff_accounts(id);


--
-- Name: slideshows slideshows_updated_by_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.slideshows
    ADD CONSTRAINT slideshows_updated_by_fkey FOREIGN KEY (updated_by) REFERENCES public.staff_accounts(id);


--
-- Name: staff_accounts staff_accounts_created_by_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.staff_accounts
    ADD CONSTRAINT staff_accounts_created_by_fkey FOREIGN KEY (created_by) REFERENCES public.staff_accounts(id);


--
-- Name: staff_accounts staff_accounts_role_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.staff_accounts
    ADD CONSTRAINT staff_accounts_role_id_fkey FOREIGN KEY (role_id) REFERENCES public.roles(id) ON DELETE SET NULL;


--
-- Name: staff_accounts staff_accounts_updated_by_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.staff_accounts
    ADD CONSTRAINT staff_accounts_updated_by_fkey FOREIGN KEY (updated_by) REFERENCES public.staff_accounts(id);


--
-- Name: suppliers suppliers_country_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.suppliers
    ADD CONSTRAINT suppliers_country_id_fkey FOREIGN KEY (country_id) REFERENCES public.countries(id);


--
-- Name: suppliers suppliers_created_by_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.suppliers
    ADD CONSTRAINT suppliers_created_by_fkey FOREIGN KEY (created_by) REFERENCES public.staff_accounts(id);


--
-- Name: suppliers suppliers_updated_by_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.suppliers
    ADD CONSTRAINT suppliers_updated_by_fkey FOREIGN KEY (updated_by) REFERENCES public.staff_accounts(id);


--
-- Name: tags tags_created_by_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.tags
    ADD CONSTRAINT tags_created_by_fkey FOREIGN KEY (created_by) REFERENCES public.staff_accounts(id);


--
-- Name: tags tags_updated_by_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.tags
    ADD CONSTRAINT tags_updated_by_fkey FOREIGN KEY (updated_by) REFERENCES public.staff_accounts(id);


--
-- Name: variant_options variant_options_image_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.variant_options
    ADD CONSTRAINT variant_options_image_id_fkey FOREIGN KEY (image_id) REFERENCES public.gallery(id) ON DELETE SET NULL;


--
-- Name: variant_options variant_options_product_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.variant_options
    ADD CONSTRAINT variant_options_product_id_fkey FOREIGN KEY (product_id) REFERENCES public.products(id);


--
-- Name: variant_values variant_values_product_attribute_value_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.variant_values
    ADD CONSTRAINT variant_values_product_attribute_value_id_fkey FOREIGN KEY (product_attribute_value_id) REFERENCES public.product_attribute_values(id);


--
-- Name: variant_values variant_values_variant_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.variant_values
    ADD CONSTRAINT variant_values_variant_id_fkey FOREIGN KEY (variant_id) REFERENCES public.variants(id);


--
-- Name: variants variants_product_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.variants
    ADD CONSTRAINT variants_product_id_fkey FOREIGN KEY (product_id) REFERENCES public.products(id);


--
-- Name: variants variants_variant_option_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.variants
    ADD CONSTRAINT variants_variant_option_id_fkey FOREIGN KEY (variant_option_id) REFERENCES public.variant_options(id);


--
-- Name: SCHEMA public; Type: ACL; Schema: -; Owner: pg_database_owner
--

GRANT USAGE ON SCHEMA public TO read_user;
GRANT USAGE ON SCHEMA public TO create_user;
GRANT USAGE ON SCHEMA public TO update_user;
GRANT USAGE ON SCHEMA public TO delete_user;
GRANT USAGE ON SCHEMA public TO crud_user;


--
-- Name: TABLE attribute_values; Type: ACL; Schema: public; Owner: postgres
--

GRANT SELECT ON TABLE public.attribute_values TO read_user;
GRANT SELECT,INSERT ON TABLE public.attribute_values TO create_user;
GRANT SELECT,UPDATE ON TABLE public.attribute_values TO update_user;
GRANT SELECT,DELETE ON TABLE public.attribute_values TO delete_user;
GRANT SELECT,INSERT,DELETE,UPDATE ON TABLE public.attribute_values TO crud_user;


--
-- Name: TABLE attributes; Type: ACL; Schema: public; Owner: postgres
--

GRANT SELECT ON TABLE public.attributes TO read_user;
GRANT SELECT,INSERT ON TABLE public.attributes TO create_user;
GRANT SELECT,UPDATE ON TABLE public.attributes TO update_user;
GRANT SELECT,DELETE ON TABLE public.attributes TO delete_user;
GRANT SELECT,INSERT,DELETE,UPDATE ON TABLE public.attributes TO crud_user;


--
-- Name: TABLE card_items; Type: ACL; Schema: public; Owner: postgres
--

GRANT SELECT ON TABLE public.card_items TO read_user;
GRANT SELECT,INSERT ON TABLE public.card_items TO create_user;
GRANT SELECT,UPDATE ON TABLE public.card_items TO update_user;
GRANT SELECT,DELETE ON TABLE public.card_items TO delete_user;
GRANT SELECT,INSERT,DELETE,UPDATE ON TABLE public.card_items TO crud_user;


--
-- Name: TABLE cards; Type: ACL; Schema: public; Owner: postgres
--

GRANT SELECT ON TABLE public.cards TO read_user;
GRANT SELECT,INSERT ON TABLE public.cards TO create_user;
GRANT SELECT,UPDATE ON TABLE public.cards TO update_user;
GRANT SELECT,DELETE ON TABLE public.cards TO delete_user;
GRANT SELECT,INSERT,DELETE,UPDATE ON TABLE public.cards TO crud_user;


--
-- Name: TABLE categories; Type: ACL; Schema: public; Owner: postgres
--

GRANT SELECT ON TABLE public.categories TO read_user;
GRANT SELECT,INSERT ON TABLE public.categories TO create_user;
GRANT SELECT,UPDATE ON TABLE public.categories TO update_user;
GRANT SELECT,DELETE ON TABLE public.categories TO delete_user;
GRANT SELECT,INSERT,DELETE,UPDATE ON TABLE public.categories TO crud_user;


--
-- Name: SEQUENCE countries_seq; Type: ACL; Schema: public; Owner: postgres
--

GRANT SELECT,USAGE ON SEQUENCE public.countries_seq TO read_user;
GRANT SELECT,USAGE ON SEQUENCE public.countries_seq TO create_user;
GRANT ALL ON SEQUENCE public.countries_seq TO update_user;
GRANT SELECT,USAGE ON SEQUENCE public.countries_seq TO delete_user;
GRANT ALL ON SEQUENCE public.countries_seq TO crud_user;


--
-- Name: TABLE countries; Type: ACL; Schema: public; Owner: postgres
--

GRANT SELECT ON TABLE public.countries TO read_user;
GRANT SELECT,INSERT ON TABLE public.countries TO create_user;
GRANT SELECT,UPDATE ON TABLE public.countries TO update_user;
GRANT SELECT,DELETE ON TABLE public.countries TO delete_user;
GRANT SELECT,INSERT,DELETE,UPDATE ON TABLE public.countries TO crud_user;


--
-- Name: TABLE coupons; Type: ACL; Schema: public; Owner: postgres
--

GRANT SELECT ON TABLE public.coupons TO read_user;
GRANT SELECT,INSERT ON TABLE public.coupons TO create_user;
GRANT SELECT,UPDATE ON TABLE public.coupons TO update_user;
GRANT SELECT,DELETE ON TABLE public.coupons TO delete_user;
GRANT SELECT,INSERT,DELETE,UPDATE ON TABLE public.coupons TO crud_user;


--
-- Name: TABLE customer_addresses; Type: ACL; Schema: public; Owner: postgres
--

GRANT SELECT ON TABLE public.customer_addresses TO read_user;
GRANT SELECT,INSERT ON TABLE public.customer_addresses TO create_user;
GRANT SELECT,UPDATE ON TABLE public.customer_addresses TO update_user;
GRANT SELECT,DELETE ON TABLE public.customer_addresses TO delete_user;
GRANT SELECT,INSERT,DELETE,UPDATE ON TABLE public.customer_addresses TO crud_user;


--
-- Name: TABLE customers; Type: ACL; Schema: public; Owner: postgres
--

GRANT SELECT ON TABLE public.customers TO read_user;
GRANT SELECT,INSERT ON TABLE public.customers TO create_user;
GRANT SELECT,UPDATE ON TABLE public.customers TO update_user;
GRANT SELECT,DELETE ON TABLE public.customers TO delete_user;
GRANT SELECT,INSERT,DELETE,UPDATE ON TABLE public.customers TO crud_user;


--
-- Name: TABLE gallery; Type: ACL; Schema: public; Owner: postgres
--

GRANT SELECT ON TABLE public.gallery TO read_user;
GRANT SELECT,INSERT ON TABLE public.gallery TO create_user;
GRANT SELECT,UPDATE ON TABLE public.gallery TO update_user;
GRANT SELECT,DELETE ON TABLE public.gallery TO delete_user;
GRANT SELECT,INSERT,DELETE,UPDATE ON TABLE public.gallery TO crud_user;


--
-- Name: TABLE gallery_part1; Type: ACL; Schema: public; Owner: postgres
--

GRANT SELECT ON TABLE public.gallery_part1 TO read_user;
GRANT SELECT,INSERT ON TABLE public.gallery_part1 TO create_user;
GRANT SELECT,UPDATE ON TABLE public.gallery_part1 TO update_user;
GRANT SELECT,DELETE ON TABLE public.gallery_part1 TO delete_user;
GRANT SELECT,INSERT,DELETE,UPDATE ON TABLE public.gallery_part1 TO crud_user;


--
-- Name: TABLE gallery_part2; Type: ACL; Schema: public; Owner: postgres
--

GRANT SELECT ON TABLE public.gallery_part2 TO read_user;
GRANT SELECT,INSERT ON TABLE public.gallery_part2 TO create_user;
GRANT SELECT,UPDATE ON TABLE public.gallery_part2 TO update_user;
GRANT SELECT,DELETE ON TABLE public.gallery_part2 TO delete_user;
GRANT SELECT,INSERT,DELETE,UPDATE ON TABLE public.gallery_part2 TO crud_user;


--
-- Name: TABLE gallery_part3; Type: ACL; Schema: public; Owner: postgres
--

GRANT SELECT ON TABLE public.gallery_part3 TO read_user;
GRANT SELECT,INSERT ON TABLE public.gallery_part3 TO create_user;
GRANT SELECT,UPDATE ON TABLE public.gallery_part3 TO update_user;
GRANT SELECT,DELETE ON TABLE public.gallery_part3 TO delete_user;
GRANT SELECT,INSERT,DELETE,UPDATE ON TABLE public.gallery_part3 TO crud_user;


--
-- Name: TABLE notifications; Type: ACL; Schema: public; Owner: postgres
--

GRANT SELECT ON TABLE public.notifications TO read_user;
GRANT SELECT,INSERT ON TABLE public.notifications TO create_user;
GRANT SELECT,UPDATE ON TABLE public.notifications TO update_user;
GRANT SELECT,DELETE ON TABLE public.notifications TO delete_user;
GRANT SELECT,INSERT,DELETE,UPDATE ON TABLE public.notifications TO crud_user;


--
-- Name: TABLE order_items; Type: ACL; Schema: public; Owner: postgres
--

GRANT SELECT ON TABLE public.order_items TO read_user;
GRANT SELECT,INSERT ON TABLE public.order_items TO create_user;
GRANT SELECT,UPDATE ON TABLE public.order_items TO update_user;
GRANT SELECT,DELETE ON TABLE public.order_items TO delete_user;
GRANT SELECT,INSERT,DELETE,UPDATE ON TABLE public.order_items TO crud_user;


--
-- Name: TABLE order_statuses; Type: ACL; Schema: public; Owner: postgres
--

GRANT SELECT ON TABLE public.order_statuses TO read_user;
GRANT SELECT,INSERT ON TABLE public.order_statuses TO create_user;
GRANT SELECT,UPDATE ON TABLE public.order_statuses TO update_user;
GRANT SELECT,DELETE ON TABLE public.order_statuses TO delete_user;
GRANT SELECT,INSERT,DELETE,UPDATE ON TABLE public.order_statuses TO crud_user;


--
-- Name: TABLE orders; Type: ACL; Schema: public; Owner: postgres
--

GRANT SELECT ON TABLE public.orders TO read_user;
GRANT SELECT,INSERT ON TABLE public.orders TO create_user;
GRANT SELECT,UPDATE ON TABLE public.orders TO update_user;
GRANT SELECT,DELETE ON TABLE public.orders TO delete_user;
GRANT SELECT,INSERT,DELETE,UPDATE ON TABLE public.orders TO crud_user;


--
-- Name: TABLE product_attribute_values; Type: ACL; Schema: public; Owner: postgres
--

GRANT SELECT ON TABLE public.product_attribute_values TO read_user;
GRANT SELECT,INSERT ON TABLE public.product_attribute_values TO create_user;
GRANT SELECT,UPDATE ON TABLE public.product_attribute_values TO update_user;
GRANT SELECT,DELETE ON TABLE public.product_attribute_values TO delete_user;
GRANT SELECT,INSERT,DELETE,UPDATE ON TABLE public.product_attribute_values TO crud_user;


--
-- Name: TABLE product_attributes; Type: ACL; Schema: public; Owner: postgres
--

GRANT SELECT ON TABLE public.product_attributes TO read_user;
GRANT SELECT,INSERT ON TABLE public.product_attributes TO create_user;
GRANT SELECT,UPDATE ON TABLE public.product_attributes TO update_user;
GRANT SELECT,DELETE ON TABLE public.product_attributes TO delete_user;
GRANT SELECT,INSERT,DELETE,UPDATE ON TABLE public.product_attributes TO crud_user;


--
-- Name: TABLE product_categories; Type: ACL; Schema: public; Owner: postgres
--

GRANT SELECT ON TABLE public.product_categories TO read_user;
GRANT SELECT,INSERT ON TABLE public.product_categories TO create_user;
GRANT SELECT,UPDATE ON TABLE public.product_categories TO update_user;
GRANT SELECT,DELETE ON TABLE public.product_categories TO delete_user;
GRANT SELECT,INSERT,DELETE,UPDATE ON TABLE public.product_categories TO crud_user;


--
-- Name: TABLE product_coupons; Type: ACL; Schema: public; Owner: postgres
--

GRANT SELECT ON TABLE public.product_coupons TO read_user;
GRANT SELECT,INSERT ON TABLE public.product_coupons TO create_user;
GRANT SELECT,UPDATE ON TABLE public.product_coupons TO update_user;
GRANT SELECT,DELETE ON TABLE public.product_coupons TO delete_user;
GRANT SELECT,INSERT,DELETE,UPDATE ON TABLE public.product_coupons TO crud_user;


--
-- Name: TABLE product_shipping_info; Type: ACL; Schema: public; Owner: postgres
--

GRANT SELECT ON TABLE public.product_shipping_info TO read_user;
GRANT SELECT,INSERT ON TABLE public.product_shipping_info TO create_user;
GRANT SELECT,UPDATE ON TABLE public.product_shipping_info TO update_user;
GRANT SELECT,DELETE ON TABLE public.product_shipping_info TO delete_user;
GRANT SELECT,INSERT,DELETE,UPDATE ON TABLE public.product_shipping_info TO crud_user;


--
-- Name: TABLE product_suppliers; Type: ACL; Schema: public; Owner: postgres
--

GRANT SELECT ON TABLE public.product_suppliers TO read_user;
GRANT SELECT,INSERT ON TABLE public.product_suppliers TO create_user;
GRANT SELECT,UPDATE ON TABLE public.product_suppliers TO update_user;
GRANT SELECT,DELETE ON TABLE public.product_suppliers TO delete_user;
GRANT SELECT,INSERT,DELETE,UPDATE ON TABLE public.product_suppliers TO crud_user;


--
-- Name: TABLE product_tags; Type: ACL; Schema: public; Owner: postgres
--

GRANT SELECT ON TABLE public.product_tags TO read_user;
GRANT SELECT,INSERT ON TABLE public.product_tags TO create_user;
GRANT SELECT,UPDATE ON TABLE public.product_tags TO update_user;
GRANT SELECT,DELETE ON TABLE public.product_tags TO delete_user;
GRANT SELECT,INSERT,DELETE,UPDATE ON TABLE public.product_tags TO crud_user;


--
-- Name: TABLE products; Type: ACL; Schema: public; Owner: postgres
--

GRANT SELECT ON TABLE public.products TO read_user;
GRANT SELECT,INSERT ON TABLE public.products TO create_user;
GRANT SELECT,UPDATE ON TABLE public.products TO update_user;
GRANT SELECT,DELETE ON TABLE public.products TO delete_user;
GRANT SELECT,INSERT,DELETE,UPDATE ON TABLE public.products TO crud_user;


--
-- Name: TABLE roles; Type: ACL; Schema: public; Owner: postgres
--

GRANT SELECT ON TABLE public.roles TO read_user;
GRANT SELECT,INSERT ON TABLE public.roles TO create_user;
GRANT SELECT,UPDATE ON TABLE public.roles TO update_user;
GRANT SELECT,DELETE ON TABLE public.roles TO delete_user;
GRANT SELECT,INSERT,DELETE,UPDATE ON TABLE public.roles TO crud_user;


--
-- Name: SEQUENCE roles_id_seq; Type: ACL; Schema: public; Owner: postgres
--

GRANT SELECT,USAGE ON SEQUENCE public.roles_id_seq TO read_user;
GRANT SELECT,USAGE ON SEQUENCE public.roles_id_seq TO create_user;
GRANT ALL ON SEQUENCE public.roles_id_seq TO update_user;
GRANT SELECT,USAGE ON SEQUENCE public.roles_id_seq TO delete_user;
GRANT ALL ON SEQUENCE public.roles_id_seq TO crud_user;


--
-- Name: TABLE sells; Type: ACL; Schema: public; Owner: postgres
--

GRANT SELECT ON TABLE public.sells TO read_user;
GRANT SELECT,INSERT ON TABLE public.sells TO create_user;
GRANT SELECT,UPDATE ON TABLE public.sells TO update_user;
GRANT SELECT,DELETE ON TABLE public.sells TO delete_user;
GRANT SELECT,INSERT,DELETE,UPDATE ON TABLE public.sells TO crud_user;


--
-- Name: SEQUENCE sells_id_seq; Type: ACL; Schema: public; Owner: postgres
--

GRANT SELECT,USAGE ON SEQUENCE public.sells_id_seq TO read_user;
GRANT SELECT,USAGE ON SEQUENCE public.sells_id_seq TO create_user;
GRANT ALL ON SEQUENCE public.sells_id_seq TO update_user;
GRANT SELECT,USAGE ON SEQUENCE public.sells_id_seq TO delete_user;
GRANT ALL ON SEQUENCE public.sells_id_seq TO crud_user;


--
-- Name: TABLE shipping_country_zones; Type: ACL; Schema: public; Owner: postgres
--

GRANT SELECT ON TABLE public.shipping_country_zones TO read_user;
GRANT SELECT,INSERT ON TABLE public.shipping_country_zones TO create_user;
GRANT SELECT,UPDATE ON TABLE public.shipping_country_zones TO update_user;
GRANT SELECT,DELETE ON TABLE public.shipping_country_zones TO delete_user;
GRANT SELECT,INSERT,DELETE,UPDATE ON TABLE public.shipping_country_zones TO crud_user;


--
-- Name: TABLE shipping_rates; Type: ACL; Schema: public; Owner: postgres
--

GRANT SELECT ON TABLE public.shipping_rates TO read_user;
GRANT SELECT,INSERT ON TABLE public.shipping_rates TO create_user;
GRANT SELECT,UPDATE ON TABLE public.shipping_rates TO update_user;
GRANT SELECT,DELETE ON TABLE public.shipping_rates TO delete_user;
GRANT SELECT,INSERT,DELETE,UPDATE ON TABLE public.shipping_rates TO crud_user;


--
-- Name: TABLE shipping_zones; Type: ACL; Schema: public; Owner: postgres
--

GRANT SELECT ON TABLE public.shipping_zones TO read_user;
GRANT SELECT,INSERT ON TABLE public.shipping_zones TO create_user;
GRANT SELECT,UPDATE ON TABLE public.shipping_zones TO update_user;
GRANT SELECT,DELETE ON TABLE public.shipping_zones TO delete_user;
GRANT SELECT,INSERT,DELETE,UPDATE ON TABLE public.shipping_zones TO crud_user;


--
-- Name: SEQUENCE shipping_zones_id_seq; Type: ACL; Schema: public; Owner: postgres
--

GRANT SELECT,USAGE ON SEQUENCE public.shipping_zones_id_seq TO read_user;
GRANT SELECT,USAGE ON SEQUENCE public.shipping_zones_id_seq TO create_user;
GRANT ALL ON SEQUENCE public.shipping_zones_id_seq TO update_user;
GRANT SELECT,USAGE ON SEQUENCE public.shipping_zones_id_seq TO delete_user;
GRANT ALL ON SEQUENCE public.shipping_zones_id_seq TO crud_user;


--
-- Name: TABLE slideshows; Type: ACL; Schema: public; Owner: postgres
--

GRANT SELECT ON TABLE public.slideshows TO read_user;
GRANT SELECT,INSERT ON TABLE public.slideshows TO create_user;
GRANT SELECT,UPDATE ON TABLE public.slideshows TO update_user;
GRANT SELECT,DELETE ON TABLE public.slideshows TO delete_user;
GRANT SELECT,INSERT,DELETE,UPDATE ON TABLE public.slideshows TO crud_user;


--
-- Name: TABLE staff_accounts; Type: ACL; Schema: public; Owner: postgres
--

GRANT SELECT ON TABLE public.staff_accounts TO read_user;
GRANT SELECT,INSERT ON TABLE public.staff_accounts TO create_user;
GRANT SELECT,UPDATE ON TABLE public.staff_accounts TO update_user;
GRANT SELECT,DELETE ON TABLE public.staff_accounts TO delete_user;
GRANT SELECT,INSERT,DELETE,UPDATE ON TABLE public.staff_accounts TO crud_user;


--
-- Name: TABLE suppliers; Type: ACL; Schema: public; Owner: postgres
--

GRANT SELECT ON TABLE public.suppliers TO read_user;
GRANT SELECT,INSERT ON TABLE public.suppliers TO create_user;
GRANT SELECT,UPDATE ON TABLE public.suppliers TO update_user;
GRANT SELECT,DELETE ON TABLE public.suppliers TO delete_user;
GRANT SELECT,INSERT,DELETE,UPDATE ON TABLE public.suppliers TO crud_user;


--
-- Name: TABLE tags; Type: ACL; Schema: public; Owner: postgres
--

GRANT SELECT ON TABLE public.tags TO read_user;
GRANT SELECT,INSERT ON TABLE public.tags TO create_user;
GRANT SELECT,UPDATE ON TABLE public.tags TO update_user;
GRANT SELECT,DELETE ON TABLE public.tags TO delete_user;
GRANT SELECT,INSERT,DELETE,UPDATE ON TABLE public.tags TO crud_user;


--
-- Name: TABLE variant_options; Type: ACL; Schema: public; Owner: postgres
--

GRANT SELECT ON TABLE public.variant_options TO read_user;
GRANT SELECT,INSERT ON TABLE public.variant_options TO create_user;
GRANT SELECT,UPDATE ON TABLE public.variant_options TO update_user;
GRANT SELECT,DELETE ON TABLE public.variant_options TO delete_user;
GRANT SELECT,INSERT,DELETE,UPDATE ON TABLE public.variant_options TO crud_user;


--
-- Name: TABLE variant_values; Type: ACL; Schema: public; Owner: postgres
--

GRANT SELECT ON TABLE public.variant_values TO read_user;
GRANT SELECT,INSERT ON TABLE public.variant_values TO create_user;
GRANT SELECT,UPDATE ON TABLE public.variant_values TO update_user;
GRANT SELECT,DELETE ON TABLE public.variant_values TO delete_user;
GRANT SELECT,INSERT,DELETE,UPDATE ON TABLE public.variant_values TO crud_user;


--
-- Name: TABLE variants; Type: ACL; Schema: public; Owner: postgres
--

GRANT SELECT ON TABLE public.variants TO read_user;
GRANT SELECT,INSERT ON TABLE public.variants TO create_user;
GRANT SELECT,UPDATE ON TABLE public.variants TO update_user;
GRANT SELECT,DELETE ON TABLE public.variants TO delete_user;
GRANT SELECT,INSERT,DELETE,UPDATE ON TABLE public.variants TO crud_user;


--
-- PostgreSQL database dump complete
--

\unrestrict NfjFgR41OmbswIvhaFPrtafVBFHremMrdxcVD8ihnpkhtSnL5paZRhM2K4Finj4

