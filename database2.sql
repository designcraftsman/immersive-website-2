PGDMP                      |        	   immersive    16.3    16.3 �    �           0    0    ENCODING    ENCODING        SET client_encoding = 'UTF8';
                      false            �           0    0 
   STDSTRINGS 
   STDSTRINGS     (   SET standard_conforming_strings = 'on';
                      false            �           0    0 
   SEARCHPATH 
   SEARCHPATH     8   SELECT pg_catalog.set_config('search_path', '', false);
                      false            �           1262    24897 	   immersive    DATABASE     �   CREATE DATABASE immersive WITH TEMPLATE = template0 ENCODING = 'UTF8' LOCALE_PROVIDER = libc LOCALE = 'English_United States.1252';
    DROP DATABASE immersive;
                postgres    false            �            1255    25272    update_course_rating()    FUNCTION     2  CREATE FUNCTION public.update_course_rating() RETURNS trigger
    LANGUAGE plpgsql
    AS $$
BEGIN
    UPDATE course
    SET rating = (
        SELECT AVG(rate)
        FROM "courseRating"
        WHERE "idCourse" = NEW."idCourse"
    )
    WHERE "idCourse" = NEW."idCourse";
    
    RETURN NEW;
END;
$$;
 -   DROP FUNCTION public.update_course_rating();
       public          postgres    false            �            1255    25274     update_total_enrolled_students()    FUNCTION     M  CREATE FUNCTION public.update_total_enrolled_students() RETURNS trigger
    LANGUAGE plpgsql
    AS $$
BEGIN
    UPDATE course
    SET "totalStudentsEnrolled" = (
        SELECT COUNT(*)
        FROM enrolledcourses
        WHERE "idCourse" = NEW."idCourse"
    )
    WHERE "idCourse" = NEW."idCourse";
    
    RETURN NEW;
END;
$$;
 7   DROP FUNCTION public.update_total_enrolled_students();
       public          postgres    false            �            1259    25244    admin    TABLE     �   CREATE TABLE public.admin (
    "idAdmin" integer NOT NULL,
    email character varying(64),
    password character varying(256),
    "firstName" character varying(128),
    "lastName" character varying(128)
);
    DROP TABLE public.admin;
       public         heap    postgres    false            �            1259    25243    admin_idAdmin_seq    SEQUENCE     �   CREATE SEQUENCE public."admin_idAdmin_seq"
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 *   DROP SEQUENCE public."admin_idAdmin_seq";
       public          postgres    false    248            �           0    0    admin_idAdmin_seq    SEQUENCE OWNED BY     K   ALTER SEQUENCE public."admin_idAdmin_seq" OWNED BY public.admin."idAdmin";
          public          postgres    false    247            �            1259    24980 	   anotation    TABLE     �   CREATE TABLE public.anotation (
    "idAnotation" integer NOT NULL,
    "idModel" integer,
    name character varying(255) NOT NULL,
    description text,
    "position" jsonb
);
    DROP TABLE public.anotation;
       public         heap    postgres    false            �            1259    24979    anotation_idanotation_seq    SEQUENCE     �   CREATE SEQUENCE public.anotation_idanotation_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 0   DROP SEQUENCE public.anotation_idanotation_seq;
       public          postgres    false    228            �           0    0    anotation_idanotation_seq    SEQUENCE OWNED BY     Y   ALTER SEQUENCE public.anotation_idanotation_seq OWNED BY public.anotation."idAnotation";
          public          postgres    false    227            �            1259    24949    asset    TABLE       CREATE TABLE public.asset (
    "idAsset" integer NOT NULL,
    "idCourse" integer,
    name character varying(255) NOT NULL,
    type character varying(50) NOT NULL,
    url character varying(255) NOT NULL,
    description text,
    size jsonb,
    properties jsonb
);
    DROP TABLE public.asset;
       public         heap    postgres    false            �            1259    24948    asset_idasset_seq    SEQUENCE     �   CREATE SEQUENCE public.asset_idasset_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 (   DROP SEQUENCE public.asset_idasset_seq;
       public          postgres    false    224            �           0    0    asset_idasset_seq    SEQUENCE OWNED BY     I   ALTER SEQUENCE public.asset_idasset_seq OWNED BY public.asset."idAsset";
          public          postgres    false    223            �            1259    25184    bookmarkedcourses    TABLE     m   CREATE TABLE public.bookmarkedcourses (
    "idStudent" integer NOT NULL,
    "idCourse" integer NOT NULL
);
 %   DROP TABLE public.bookmarkedcourses;
       public         heap    postgres    false            �            1259    25109    chat    TABLE     �   CREATE TABLE public.chat (
    "idChat" integer NOT NULL,
    "idUser" integer,
    "idGroupe" integer,
    message text NOT NULL,
    date date DEFAULT CURRENT_TIMESTAMP,
    "time" time without time zone DEFAULT CURRENT_TIMESTAMP
);
    DROP TABLE public.chat;
       public         heap    postgres    false            �            1259    25108    chat_idchat_seq    SEQUENCE     �   CREATE SEQUENCE public.chat_idchat_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 &   DROP SEQUENCE public.chat_idchat_seq;
       public          postgres    false    240            �           0    0    chat_idchat_seq    SEQUENCE OWNED BY     E   ALTER SEQUENCE public.chat_idchat_seq OWNED BY public.chat."idChat";
          public          postgres    false    239            �            1259    24930    course    TABLE     �  CREATE TABLE public.course (
    "idCourse" integer NOT NULL,
    "idTeacher" integer,
    name character varying(255) NOT NULL,
    "creationDate" date NOT NULL,
    "creationTime" time without time zone NOT NULL,
    description text,
    "maxVisitors" integer,
    "totalStudentsEnrolled" integer,
    rating numeric(3,2),
    previewimage character varying(256) DEFAULT NULL::character varying,
    category character varying(32),
    coursepdf character varying(256),
    privacy character varying(32),
    video character varying(512),
    "gainedSkills" jsonb,
    "skillLevel" character varying(32),
    prerequisites jsonb,
    environment character varying(128)
);
    DROP TABLE public.course;
       public         heap    postgres    false            �            1259    25254    courseRating    TABLE     �   CREATE TABLE public."courseRating" (
    "idRate" integer NOT NULL,
    "idStudent" integer,
    "idCourse" integer,
    rate double precision,
    text text
);
 "   DROP TABLE public."courseRating";
       public         heap    postgres    false            �            1259    25253    courseRating_idRate_seq    SEQUENCE     �   CREATE SEQUENCE public."courseRating_idRate_seq"
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 0   DROP SEQUENCE public."courseRating_idRate_seq";
       public          postgres    false    250            �           0    0    courseRating_idRate_seq    SEQUENCE OWNED BY     Y   ALTER SEQUENCE public."courseRating_idRate_seq" OWNED BY public."courseRating"."idRate";
          public          postgres    false    249            �            1259    24929    course_idcourse_seq    SEQUENCE     �   CREATE SEQUENCE public.course_idcourse_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 *   DROP SEQUENCE public.course_idcourse_seq;
       public          postgres    false    222            �           0    0    course_idcourse_seq    SEQUENCE OWNED BY     M   ALTER SEQUENCE public.course_idcourse_seq OWNED BY public.course."idCourse";
          public          postgres    false    221            �            1259    25168    enrolledcourses    TABLE       CREATE TABLE public.enrolledcourses (
    "idStudent" integer NOT NULL,
    "idCourse" integer NOT NULL,
    "enrollmentDate" timestamp without time zone DEFAULT CURRENT_TIMESTAMP,
    status character varying(64) DEFAULT 'uncommitted'::character varying
);
 #   DROP TABLE public.enrolledcourses;
       public         heap    postgres    false            �            1259    24921    environnement    TABLE     �   CREATE TABLE public.environnement (
    "idEnvironnement" integer NOT NULL,
    url character varying(255) NOT NULL,
    name character varying(255) NOT NULL
);
 !   DROP TABLE public.environnement;
       public         heap    postgres    false            �            1259    24920 !   environnement_idenvironnement_seq    SEQUENCE     �   CREATE SEQUENCE public.environnement_idenvironnement_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 8   DROP SEQUENCE public.environnement_idenvironnement_seq;
       public          postgres    false    220            �           0    0 !   environnement_idenvironnement_seq    SEQUENCE OWNED BY     i   ALTER SEQUENCE public.environnement_idenvironnement_seq OWNED BY public.environnement."idEnvironnement";
          public          postgres    false    219            �            1259    25078    groupe    TABLE     �   CREATE TABLE public.groupe (
    "idGroupe" integer NOT NULL,
    "idTeacher" integer,
    name character varying(255) NOT NULL,
    description text,
    members jsonb,
    image character varying(256)
);
    DROP TABLE public.groupe;
       public         heap    postgres    false            �            1259    25077    groupe_idgroupe_seq    SEQUENCE     �   CREATE SEQUENCE public.groupe_idgroupe_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 *   DROP SEQUENCE public.groupe_idgroupe_seq;
       public          postgres    false    238            �           0    0    groupe_idgroupe_seq    SEQUENCE OWNED BY     M   ALTER SEQUENCE public.groupe_idgroupe_seq OWNED BY public.groupe."idGroupe";
          public          postgres    false    237            �            1259    24963    model    TABLE     m   CREATE TABLE public.model (
    "idModel" integer NOT NULL,
    "idAsset" integer,
    "idCourse" integer
);
    DROP TABLE public.model;
       public         heap    postgres    false            �            1259    24962    model_idmodel_seq    SEQUENCE     �   CREATE SEQUENCE public.model_idmodel_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 (   DROP SEQUENCE public.model_idmodel_seq;
       public          postgres    false    226            �           0    0    model_idmodel_seq    SEQUENCE OWNED BY     I   ALTER SEQUENCE public.model_idmodel_seq OWNED BY public.model."idModel";
          public          postgres    false    225            �            1259    25219    notification    TABLE     f  CREATE TABLE public.notification (
    idnotification integer NOT NULL,
    type character varying(32),
    date date DEFAULT CURRENT_TIMESTAMP,
    "time" time without time zone DEFAULT CURRENT_TIMESTAMP,
    message text,
    "userRole" character varying(32),
    "userId" integer,
    state character varying(32) DEFAULT 'Delivered'::character varying
);
     DROP TABLE public.notification;
       public         heap    postgres    false            �            1259    25218    notification_idnotification_seq    SEQUENCE     �   CREATE SEQUENCE public.notification_idnotification_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 6   DROP SEQUENCE public.notification_idnotification_seq;
       public          postgres    false    244            �           0    0    notification_idnotification_seq    SEQUENCE OWNED BY     c   ALTER SEQUENCE public.notification_idnotification_seq OWNED BY public.notification.idnotification;
          public          postgres    false    243            �            1259    25013    quiz    TABLE     �   CREATE TABLE public.quiz (
    "idQuiz" integer NOT NULL,
    "idCourse" integer,
    "idTeacher" integer,
    title character varying(64),
    description text,
    duration integer,
    attempts integer
);
    DROP TABLE public.quiz;
       public         heap    postgres    false            �            1259    25030    quizElement    TABLE     �   CREATE TABLE public."quizElement" (
    "idQuizElement" integer NOT NULL,
    "idQuiz" integer,
    question text NOT NULL,
    "helperText" character varying(256)
);
 !   DROP TABLE public."quizElement";
       public         heap    postgres    false            �            1259    25235    quizElementOptions    TABLE     �   CREATE TABLE public."quizElementOptions" (
    "idQuizElementOption" integer NOT NULL,
    "idQuizElement" integer,
    "optionText" text,
    "isCorrect" boolean,
    "idQuiz" integer
);
 (   DROP TABLE public."quizElementOptions";
       public         heap    postgres    false            �            1259    25234 *   quizElementOptions_idQuizElementOption_seq    SEQUENCE     �   CREATE SEQUENCE public."quizElementOptions_idQuizElementOption_seq"
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 C   DROP SEQUENCE public."quizElementOptions_idQuizElementOption_seq";
       public          postgres    false    246            �           0    0 *   quizElementOptions_idQuizElementOption_seq    SEQUENCE OWNED BY        ALTER SEQUENCE public."quizElementOptions_idQuizElementOption_seq" OWNED BY public."quizElementOptions"."idQuizElementOption";
          public          postgres    false    245            �            1259    25044 
   quizResult    TABLE     �   CREATE TABLE public."quizResult" (
    "idQuizResult" integer NOT NULL,
    "idUser" integer,
    "idQuiz" integer,
    result numeric(5,2)
);
     DROP TABLE public."quizResult";
       public         heap    postgres    false            �            1259    25012    quiz_idquiz_seq    SEQUENCE     �   CREATE SEQUENCE public.quiz_idquiz_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 &   DROP SEQUENCE public.quiz_idquiz_seq;
       public          postgres    false    232            �           0    0    quiz_idquiz_seq    SEQUENCE OWNED BY     E   ALTER SEQUENCE public.quiz_idquiz_seq OWNED BY public.quiz."idQuiz";
          public          postgres    false    231            �            1259    25029    quizelement_idquizelement_seq    SEQUENCE     �   CREATE SEQUENCE public.quizelement_idquizelement_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 4   DROP SEQUENCE public.quizelement_idquizelement_seq;
       public          postgres    false    234            �           0    0    quizelement_idquizelement_seq    SEQUENCE OWNED BY     c   ALTER SEQUENCE public.quizelement_idquizelement_seq OWNED BY public."quizElement"."idQuizElement";
          public          postgres    false    233            �            1259    25043    quizresult_idquizresult_seq    SEQUENCE     �   CREATE SEQUENCE public.quizresult_idquizresult_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 2   DROP SEQUENCE public.quizresult_idquizresult_seq;
       public          postgres    false    236            �           0    0    quizresult_idquizresult_seq    SEQUENCE OWNED BY     _   ALTER SEQUENCE public.quizresult_idquizresult_seq OWNED BY public."quizResult"."idQuizResult";
          public          postgres    false    235            �            1259    24994    session    TABLE     �   CREATE TABLE public.session (
    "idSession" integer NOT NULL,
    "idCourse" integer,
    code text,
    description text,
    name character varying(64),
    "idGroupe" integer,
    "idTeacher" integer
);
    DROP TABLE public.session;
       public         heap    postgres    false            �            1259    24993    session_idsession_seq    SEQUENCE     �   CREATE SEQUENCE public.session_idsession_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 ,   DROP SEQUENCE public.session_idsession_seq;
       public          postgres    false    230            �           0    0    session_idsession_seq    SEQUENCE OWNED BY     Q   ALTER SEQUENCE public.session_idsession_seq OWNED BY public.session."idSession";
          public          postgres    false    229            �            1259    24899    student    TABLE     M  CREATE TABLE public.student (
    "idStudent" integer NOT NULL,
    "firstName" character varying(255) NOT NULL,
    "lastName" character varying(255) NOT NULL,
    "birthDate" date NOT NULL,
    email character varying(255) NOT NULL,
    password character varying(255) NOT NULL,
    "emailConfirmation" boolean NOT NULL,
    image character varying(255),
    gender character varying(50),
    username character varying(64),
    country character varying(64),
    continent character varying(64),
    is_suspended boolean DEFAULT false,
    suspension_end timestamp without time zone
);
    DROP TABLE public.student;
       public         heap    postgres    false            �            1259    24898    student_idstudent_seq    SEQUENCE     �   CREATE SEQUENCE public.student_idstudent_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 ,   DROP SEQUENCE public.student_idstudent_seq;
       public          postgres    false    216            �           0    0    student_idstudent_seq    SEQUENCE OWNED BY     Q   ALTER SEQUENCE public.student_idstudent_seq OWNED BY public.student."idStudent";
          public          postgres    false    215            �            1259    24910    teacher    TABLE     G  CREATE TABLE public.teacher (
    "idTeacher" integer NOT NULL,
    "firstName" character varying(255) NOT NULL,
    "lastName" character varying(255) NOT NULL,
    "birthDate" date NOT NULL,
    email character varying(255) NOT NULL,
    password character varying(255) NOT NULL,
    "emailConfirmation" boolean DEFAULT false NOT NULL,
    image character varying(255),
    gender character varying(50),
    specialization character varying(255),
    rating numeric(3,2),
    username character varying(64),
    country character varying(64),
    continent character varying(64)
);
    DROP TABLE public.teacher;
       public         heap    postgres    false            �            1259    24909    teacher_idteacher_seq    SEQUENCE     �   CREATE SEQUENCE public.teacher_idteacher_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 ,   DROP SEQUENCE public.teacher_idteacher_seq;
       public          postgres    false    218            �           0    0    teacher_idteacher_seq    SEQUENCE OWNED BY     Q   ALTER SEQUENCE public.teacher_idteacher_seq OWNED BY public.teacher."idTeacher";
          public          postgres    false    217            �           2604    25247    admin idAdmin    DEFAULT     r   ALTER TABLE ONLY public.admin ALTER COLUMN "idAdmin" SET DEFAULT nextval('public."admin_idAdmin_seq"'::regclass);
 >   ALTER TABLE public.admin ALTER COLUMN "idAdmin" DROP DEFAULT;
       public          postgres    false    248    247    248            �           2604    24983    anotation idAnotation    DEFAULT     �   ALTER TABLE ONLY public.anotation ALTER COLUMN "idAnotation" SET DEFAULT nextval('public.anotation_idanotation_seq'::regclass);
 F   ALTER TABLE public.anotation ALTER COLUMN "idAnotation" DROP DEFAULT;
       public          postgres    false    227    228    228            �           2604    24952    asset idAsset    DEFAULT     p   ALTER TABLE ONLY public.asset ALTER COLUMN "idAsset" SET DEFAULT nextval('public.asset_idasset_seq'::regclass);
 >   ALTER TABLE public.asset ALTER COLUMN "idAsset" DROP DEFAULT;
       public          postgres    false    224    223    224            �           2604    25112    chat idChat    DEFAULT     l   ALTER TABLE ONLY public.chat ALTER COLUMN "idChat" SET DEFAULT nextval('public.chat_idchat_seq'::regclass);
 <   ALTER TABLE public.chat ALTER COLUMN "idChat" DROP DEFAULT;
       public          postgres    false    240    239    240            �           2604    24933    course idCourse    DEFAULT     t   ALTER TABLE ONLY public.course ALTER COLUMN "idCourse" SET DEFAULT nextval('public.course_idcourse_seq'::regclass);
 @   ALTER TABLE public.course ALTER COLUMN "idCourse" DROP DEFAULT;
       public          postgres    false    221    222    222            �           2604    25257    courseRating idRate    DEFAULT     �   ALTER TABLE ONLY public."courseRating" ALTER COLUMN "idRate" SET DEFAULT nextval('public."courseRating_idRate_seq"'::regclass);
 F   ALTER TABLE public."courseRating" ALTER COLUMN "idRate" DROP DEFAULT;
       public          postgres    false    249    250    250            �           2604    24924    environnement idEnvironnement    DEFAULT     �   ALTER TABLE ONLY public.environnement ALTER COLUMN "idEnvironnement" SET DEFAULT nextval('public.environnement_idenvironnement_seq'::regclass);
 N   ALTER TABLE public.environnement ALTER COLUMN "idEnvironnement" DROP DEFAULT;
       public          postgres    false    220    219    220            �           2604    25081    groupe idGroupe    DEFAULT     t   ALTER TABLE ONLY public.groupe ALTER COLUMN "idGroupe" SET DEFAULT nextval('public.groupe_idgroupe_seq'::regclass);
 @   ALTER TABLE public.groupe ALTER COLUMN "idGroupe" DROP DEFAULT;
       public          postgres    false    238    237    238            �           2604    24966    model idModel    DEFAULT     p   ALTER TABLE ONLY public.model ALTER COLUMN "idModel" SET DEFAULT nextval('public.model_idmodel_seq'::regclass);
 >   ALTER TABLE public.model ALTER COLUMN "idModel" DROP DEFAULT;
       public          postgres    false    226    225    226            �           2604    25222    notification idnotification    DEFAULT     �   ALTER TABLE ONLY public.notification ALTER COLUMN idnotification SET DEFAULT nextval('public.notification_idnotification_seq'::regclass);
 J   ALTER TABLE public.notification ALTER COLUMN idnotification DROP DEFAULT;
       public          postgres    false    244    243    244            �           2604    25016    quiz idQuiz    DEFAULT     l   ALTER TABLE ONLY public.quiz ALTER COLUMN "idQuiz" SET DEFAULT nextval('public.quiz_idquiz_seq'::regclass);
 <   ALTER TABLE public.quiz ALTER COLUMN "idQuiz" DROP DEFAULT;
       public          postgres    false    232    231    232            �           2604    25033    quizElement idQuizElement    DEFAULT     �   ALTER TABLE ONLY public."quizElement" ALTER COLUMN "idQuizElement" SET DEFAULT nextval('public.quizelement_idquizelement_seq'::regclass);
 L   ALTER TABLE public."quizElement" ALTER COLUMN "idQuizElement" DROP DEFAULT;
       public          postgres    false    234    233    234            �           2604    25238 &   quizElementOptions idQuizElementOption    DEFAULT     �   ALTER TABLE ONLY public."quizElementOptions" ALTER COLUMN "idQuizElementOption" SET DEFAULT nextval('public."quizElementOptions_idQuizElementOption_seq"'::regclass);
 Y   ALTER TABLE public."quizElementOptions" ALTER COLUMN "idQuizElementOption" DROP DEFAULT;
       public          postgres    false    245    246    246            �           2604    25047    quizResult idQuizResult    DEFAULT     �   ALTER TABLE ONLY public."quizResult" ALTER COLUMN "idQuizResult" SET DEFAULT nextval('public.quizresult_idquizresult_seq'::regclass);
 J   ALTER TABLE public."quizResult" ALTER COLUMN "idQuizResult" DROP DEFAULT;
       public          postgres    false    235    236    236            �           2604    24997    session idSession    DEFAULT     x   ALTER TABLE ONLY public.session ALTER COLUMN "idSession" SET DEFAULT nextval('public.session_idsession_seq'::regclass);
 B   ALTER TABLE public.session ALTER COLUMN "idSession" DROP DEFAULT;
       public          postgres    false    229    230    230            �           2604    24902    student idStudent    DEFAULT     x   ALTER TABLE ONLY public.student ALTER COLUMN "idStudent" SET DEFAULT nextval('public.student_idstudent_seq'::regclass);
 B   ALTER TABLE public.student ALTER COLUMN "idStudent" DROP DEFAULT;
       public          postgres    false    215    216    216            �           2604    24913    teacher idTeacher    DEFAULT     x   ALTER TABLE ONLY public.teacher ALTER COLUMN "idTeacher" SET DEFAULT nextval('public.teacher_idteacher_seq'::regclass);
 B   ALTER TABLE public.teacher ALTER COLUMN "idTeacher" DROP DEFAULT;
       public          postgres    false    218    217    218            �          0    25244    admin 
   TABLE DATA           T   COPY public.admin ("idAdmin", email, password, "firstName", "lastName") FROM stdin;
    public          postgres    false    248   ��       �          0    24980 	   anotation 
   TABLE DATA           \   COPY public.anotation ("idAnotation", "idModel", name, description, "position") FROM stdin;
    public          postgres    false    228   E�       �          0    24949    asset 
   TABLE DATA           f   COPY public.asset ("idAsset", "idCourse", name, type, url, description, size, properties) FROM stdin;
    public          postgres    false    224   b�       �          0    25184    bookmarkedcourses 
   TABLE DATA           D   COPY public.bookmarkedcourses ("idStudent", "idCourse") FROM stdin;
    public          postgres    false    242   �       �          0    25109    chat 
   TABLE DATA           U   COPY public.chat ("idChat", "idUser", "idGroupe", message, date, "time") FROM stdin;
    public          postgres    false    240   A�       �          0    24930    course 
   TABLE DATA           	  COPY public.course ("idCourse", "idTeacher", name, "creationDate", "creationTime", description, "maxVisitors", "totalStudentsEnrolled", rating, previewimage, category, coursepdf, privacy, video, "gainedSkills", "skillLevel", prerequisites, environment) FROM stdin;
    public          postgres    false    222   ^�       �          0    25254    courseRating 
   TABLE DATA           W   COPY public."courseRating" ("idRate", "idStudent", "idCourse", rate, text) FROM stdin;
    public          postgres    false    250   ��       �          0    25168    enrolledcourses 
   TABLE DATA           \   COPY public.enrolledcourses ("idStudent", "idCourse", "enrollmentDate", status) FROM stdin;
    public          postgres    false    241   �       �          0    24921    environnement 
   TABLE DATA           E   COPY public.environnement ("idEnvironnement", url, name) FROM stdin;
    public          postgres    false    220   a�       �          0    25078    groupe 
   TABLE DATA           \   COPY public.groupe ("idGroupe", "idTeacher", name, description, members, image) FROM stdin;
    public          postgres    false    238   ��       �          0    24963    model 
   TABLE DATA           A   COPY public.model ("idModel", "idAsset", "idCourse") FROM stdin;
    public          postgres    false    226   Q�       �          0    25219    notification 
   TABLE DATA           p   COPY public.notification (idnotification, type, date, "time", message, "userRole", "userId", state) FROM stdin;
    public          postgres    false    244   n�       �          0    25013    quiz 
   TABLE DATA           i   COPY public.quiz ("idQuiz", "idCourse", "idTeacher", title, description, duration, attempts) FROM stdin;
    public          postgres    false    232   	�       �          0    25030    quizElement 
   TABLE DATA           Z   COPY public."quizElement" ("idQuizElement", "idQuiz", question, "helperText") FROM stdin;
    public          postgres    false    234   �       �          0    25235    quizElementOptions 
   TABLE DATA           {   COPY public."quizElementOptions" ("idQuizElementOption", "idQuizElement", "optionText", "isCorrect", "idQuiz") FROM stdin;
    public          postgres    false    246   	�       �          0    25044 
   quizResult 
   TABLE DATA           R   COPY public."quizResult" ("idQuizResult", "idUser", "idQuiz", result) FROM stdin;
    public          postgres    false    236   w�       �          0    24994    session 
   TABLE DATA           l   COPY public.session ("idSession", "idCourse", code, description, name, "idGroupe", "idTeacher") FROM stdin;
    public          postgres    false    230   ��       �          0    24899    student 
   TABLE DATA           �   COPY public.student ("idStudent", "firstName", "lastName", "birthDate", email, password, "emailConfirmation", image, gender, username, country, continent, is_suspended, suspension_end) FROM stdin;
    public          postgres    false    216   �       �          0    24910    teacher 
   TABLE DATA           �   COPY public.teacher ("idTeacher", "firstName", "lastName", "birthDate", email, password, "emailConfirmation", image, gender, specialization, rating, username, country, continent) FROM stdin;
    public          postgres    false    218   {�       �           0    0    admin_idAdmin_seq    SEQUENCE SET     A   SELECT pg_catalog.setval('public."admin_idAdmin_seq"', 1, true);
          public          postgres    false    247            �           0    0    anotation_idanotation_seq    SEQUENCE SET     H   SELECT pg_catalog.setval('public.anotation_idanotation_seq', 1, false);
          public          postgres    false    227            �           0    0    asset_idasset_seq    SEQUENCE SET     @   SELECT pg_catalog.setval('public.asset_idasset_seq', 69, true);
          public          postgres    false    223            �           0    0    chat_idchat_seq    SEQUENCE SET     >   SELECT pg_catalog.setval('public.chat_idchat_seq', 1, false);
          public          postgres    false    239            �           0    0    courseRating_idRate_seq    SEQUENCE SET     H   SELECT pg_catalog.setval('public."courseRating_idRate_seq"', 11, true);
          public          postgres    false    249            �           0    0    course_idcourse_seq    SEQUENCE SET     B   SELECT pg_catalog.setval('public.course_idcourse_seq', 78, true);
          public          postgres    false    221            �           0    0 !   environnement_idenvironnement_seq    SEQUENCE SET     O   SELECT pg_catalog.setval('public.environnement_idenvironnement_seq', 2, true);
          public          postgres    false    219            �           0    0    groupe_idgroupe_seq    SEQUENCE SET     B   SELECT pg_catalog.setval('public.groupe_idgroupe_seq', 32, true);
          public          postgres    false    237            �           0    0    model_idmodel_seq    SEQUENCE SET     @   SELECT pg_catalog.setval('public.model_idmodel_seq', 1, false);
          public          postgres    false    225            �           0    0    notification_idnotification_seq    SEQUENCE SET     N   SELECT pg_catalog.setval('public.notification_idnotification_seq', 77, true);
          public          postgres    false    243            �           0    0 *   quizElementOptions_idQuizElementOption_seq    SEQUENCE SET     \   SELECT pg_catalog.setval('public."quizElementOptions_idQuizElementOption_seq"', 206, true);
          public          postgres    false    245            �           0    0    quiz_idquiz_seq    SEQUENCE SET     =   SELECT pg_catalog.setval('public.quiz_idquiz_seq', 6, true);
          public          postgres    false    231            �           0    0    quizelement_idquizelement_seq    SEQUENCE SET     L   SELECT pg_catalog.setval('public.quizelement_idquizelement_seq', 75, true);
          public          postgres    false    233            �           0    0    quizresult_idquizresult_seq    SEQUENCE SET     I   SELECT pg_catalog.setval('public.quizresult_idquizresult_seq', 9, true);
          public          postgres    false    235            �           0    0    session_idsession_seq    SEQUENCE SET     C   SELECT pg_catalog.setval('public.session_idsession_seq', 9, true);
          public          postgres    false    229            �           0    0    student_idstudent_seq    SEQUENCE SET     D   SELECT pg_catalog.setval('public.student_idstudent_seq', 24, true);
          public          postgres    false    215            �           0    0    teacher_idteacher_seq    SEQUENCE SET     D   SELECT pg_catalog.setval('public.teacher_idteacher_seq', 15, true);
          public          postgres    false    217            �           2606    25251    admin admin_pkey 
   CONSTRAINT     U   ALTER TABLE ONLY public.admin
    ADD CONSTRAINT admin_pkey PRIMARY KEY ("idAdmin");
 :   ALTER TABLE ONLY public.admin DROP CONSTRAINT admin_pkey;
       public            postgres    false    248            �           2606    24987    anotation anotation_pkey 
   CONSTRAINT     a   ALTER TABLE ONLY public.anotation
    ADD CONSTRAINT anotation_pkey PRIMARY KEY ("idAnotation");
 B   ALTER TABLE ONLY public.anotation DROP CONSTRAINT anotation_pkey;
       public            postgres    false    228            �           2606    24956    asset asset_pkey 
   CONSTRAINT     U   ALTER TABLE ONLY public.asset
    ADD CONSTRAINT asset_pkey PRIMARY KEY ("idAsset");
 :   ALTER TABLE ONLY public.asset DROP CONSTRAINT asset_pkey;
       public            postgres    false    224            �           2606    25188 (   bookmarkedcourses bookmarkedcourses_pkey 
   CONSTRAINT     {   ALTER TABLE ONLY public.bookmarkedcourses
    ADD CONSTRAINT bookmarkedcourses_pkey PRIMARY KEY ("idStudent", "idCourse");
 R   ALTER TABLE ONLY public.bookmarkedcourses DROP CONSTRAINT bookmarkedcourses_pkey;
       public            postgres    false    242    242            �           2606    25116    chat chat_pkey 
   CONSTRAINT     R   ALTER TABLE ONLY public.chat
    ADD CONSTRAINT chat_pkey PRIMARY KEY ("idChat");
 8   ALTER TABLE ONLY public.chat DROP CONSTRAINT chat_pkey;
       public            postgres    false    240            �           2606    25261    courseRating courseRating_pkey 
   CONSTRAINT     f   ALTER TABLE ONLY public."courseRating"
    ADD CONSTRAINT "courseRating_pkey" PRIMARY KEY ("idRate");
 L   ALTER TABLE ONLY public."courseRating" DROP CONSTRAINT "courseRating_pkey";
       public            postgres    false    250            �           2606    24937    course course_pkey 
   CONSTRAINT     X   ALTER TABLE ONLY public.course
    ADD CONSTRAINT course_pkey PRIMARY KEY ("idCourse");
 <   ALTER TABLE ONLY public.course DROP CONSTRAINT course_pkey;
       public            postgres    false    222            �           2606    25172 $   enrolledcourses enrolledcourses_pkey 
   CONSTRAINT     w   ALTER TABLE ONLY public.enrolledcourses
    ADD CONSTRAINT enrolledcourses_pkey PRIMARY KEY ("idStudent", "idCourse");
 N   ALTER TABLE ONLY public.enrolledcourses DROP CONSTRAINT enrolledcourses_pkey;
       public            postgres    false    241    241            �           2606    24928     environnement environnement_pkey 
   CONSTRAINT     m   ALTER TABLE ONLY public.environnement
    ADD CONSTRAINT environnement_pkey PRIMARY KEY ("idEnvironnement");
 J   ALTER TABLE ONLY public.environnement DROP CONSTRAINT environnement_pkey;
       public            postgres    false    220            �           2606    25085    groupe groupe_pkey 
   CONSTRAINT     X   ALTER TABLE ONLY public.groupe
    ADD CONSTRAINT groupe_pkey PRIMARY KEY ("idGroupe");
 <   ALTER TABLE ONLY public.groupe DROP CONSTRAINT groupe_pkey;
       public            postgres    false    238            �           2606    24968    model model_pkey 
   CONSTRAINT     U   ALTER TABLE ONLY public.model
    ADD CONSTRAINT model_pkey PRIMARY KEY ("idModel");
 :   ALTER TABLE ONLY public.model DROP CONSTRAINT model_pkey;
       public            postgres    false    226            �           2606    25228    notification notification_pkey 
   CONSTRAINT     h   ALTER TABLE ONLY public.notification
    ADD CONSTRAINT notification_pkey PRIMARY KEY (idnotification);
 H   ALTER TABLE ONLY public.notification DROP CONSTRAINT notification_pkey;
       public            postgres    false    244            �           2606    25242 *   quizElementOptions quizElementOptions_pkey 
   CONSTRAINT        ALTER TABLE ONLY public."quizElementOptions"
    ADD CONSTRAINT "quizElementOptions_pkey" PRIMARY KEY ("idQuizElementOption");
 X   ALTER TABLE ONLY public."quizElementOptions" DROP CONSTRAINT "quizElementOptions_pkey";
       public            postgres    false    246            �           2606    25018    quiz quiz_pkey 
   CONSTRAINT     R   ALTER TABLE ONLY public.quiz
    ADD CONSTRAINT quiz_pkey PRIMARY KEY ("idQuiz");
 8   ALTER TABLE ONLY public.quiz DROP CONSTRAINT quiz_pkey;
       public            postgres    false    232            �           2606    25037    quizElement quizelement_pkey 
   CONSTRAINT     i   ALTER TABLE ONLY public."quizElement"
    ADD CONSTRAINT quizelement_pkey PRIMARY KEY ("idQuizElement");
 H   ALTER TABLE ONLY public."quizElement" DROP CONSTRAINT quizelement_pkey;
       public            postgres    false    234            �           2606    25049    quizResult quizresult_pkey 
   CONSTRAINT     f   ALTER TABLE ONLY public."quizResult"
    ADD CONSTRAINT quizresult_pkey PRIMARY KEY ("idQuizResult");
 F   ALTER TABLE ONLY public."quizResult" DROP CONSTRAINT quizresult_pkey;
       public            postgres    false    236            �           2606    25001    session session_pkey 
   CONSTRAINT     [   ALTER TABLE ONLY public.session
    ADD CONSTRAINT session_pkey PRIMARY KEY ("idSession");
 >   ALTER TABLE ONLY public.session DROP CONSTRAINT session_pkey;
       public            postgres    false    230            �           2606    24908    student student_email_key 
   CONSTRAINT     U   ALTER TABLE ONLY public.student
    ADD CONSTRAINT student_email_key UNIQUE (email);
 C   ALTER TABLE ONLY public.student DROP CONSTRAINT student_email_key;
       public            postgres    false    216            �           2606    24906    student student_pkey 
   CONSTRAINT     [   ALTER TABLE ONLY public.student
    ADD CONSTRAINT student_pkey PRIMARY KEY ("idStudent");
 >   ALTER TABLE ONLY public.student DROP CONSTRAINT student_pkey;
       public            postgres    false    216            �           2606    25166    student student_username_key 
   CONSTRAINT     [   ALTER TABLE ONLY public.student
    ADD CONSTRAINT student_username_key UNIQUE (username);
 F   ALTER TABLE ONLY public.student DROP CONSTRAINT student_username_key;
       public            postgres    false    216            �           2606    24919    teacher teacher_email_key 
   CONSTRAINT     U   ALTER TABLE ONLY public.teacher
    ADD CONSTRAINT teacher_email_key UNIQUE (email);
 C   ALTER TABLE ONLY public.teacher DROP CONSTRAINT teacher_email_key;
       public            postgres    false    218            �           2606    24917    teacher teacher_pkey 
   CONSTRAINT     [   ALTER TABLE ONLY public.teacher
    ADD CONSTRAINT teacher_pkey PRIMARY KEY ("idTeacher");
 >   ALTER TABLE ONLY public.teacher DROP CONSTRAINT teacher_pkey;
       public            postgres    false    218                       2620    25273 %   courseRating trg_update_course_rating    TRIGGER     �   CREATE TRIGGER trg_update_course_rating AFTER INSERT OR UPDATE ON public."courseRating" FOR EACH ROW EXECUTE FUNCTION public.update_course_rating();
 @   DROP TRIGGER trg_update_course_rating ON public."courseRating";
       public          postgres    false    251    250                       2620    25275 2   enrolledcourses trg_update_total_enrolled_students    TRIGGER     �   CREATE TRIGGER trg_update_total_enrolled_students AFTER INSERT OR DELETE ON public.enrolledcourses FOR EACH ROW EXECUTE FUNCTION public.update_total_enrolled_students();
 K   DROP TRIGGER trg_update_total_enrolled_students ON public.enrolledcourses;
       public          postgres    false    241    252            �           2606    24988     anotation anotation_idmodel_fkey    FK CONSTRAINT     �   ALTER TABLE ONLY public.anotation
    ADD CONSTRAINT anotation_idmodel_fkey FOREIGN KEY ("idModel") REFERENCES public.model("idModel");
 J   ALTER TABLE ONLY public.anotation DROP CONSTRAINT anotation_idmodel_fkey;
       public          postgres    false    4822    226    228            �           2606    24957    asset asset_idcourse_fkey    FK CONSTRAINT     �   ALTER TABLE ONLY public.asset
    ADD CONSTRAINT asset_idcourse_fkey FOREIGN KEY ("idCourse") REFERENCES public.course("idCourse");
 C   ALTER TABLE ONLY public.asset DROP CONSTRAINT asset_idcourse_fkey;
       public          postgres    false    4818    224    222                       2606    25194 1   bookmarkedcourses bookmarkedcourses_idCourse_fkey    FK CONSTRAINT     �   ALTER TABLE ONLY public.bookmarkedcourses
    ADD CONSTRAINT "bookmarkedcourses_idCourse_fkey" FOREIGN KEY ("idCourse") REFERENCES public.course("idCourse");
 ]   ALTER TABLE ONLY public.bookmarkedcourses DROP CONSTRAINT "bookmarkedcourses_idCourse_fkey";
       public          postgres    false    4818    242    222                       2606    25189 2   bookmarkedcourses bookmarkedcourses_idStudent_fkey    FK CONSTRAINT     �   ALTER TABLE ONLY public.bookmarkedcourses
    ADD CONSTRAINT "bookmarkedcourses_idStudent_fkey" FOREIGN KEY ("idStudent") REFERENCES public.student("idStudent");
 ^   ALTER TABLE ONLY public.bookmarkedcourses DROP CONSTRAINT "bookmarkedcourses_idStudent_fkey";
       public          postgres    false    4808    242    216            �           2606    25122    chat chat_idgroupe_fkey    FK CONSTRAINT     �   ALTER TABLE ONLY public.chat
    ADD CONSTRAINT chat_idgroupe_fkey FOREIGN KEY ("idGroupe") REFERENCES public.groupe("idGroupe");
 A   ALTER TABLE ONLY public.chat DROP CONSTRAINT chat_idgroupe_fkey;
       public          postgres    false    240    4834    238            �           2606    25117    chat chat_iduser_fkey    FK CONSTRAINT     �   ALTER TABLE ONLY public.chat
    ADD CONSTRAINT chat_iduser_fkey FOREIGN KEY ("idUser") REFERENCES public.student("idStudent");
 ?   ALTER TABLE ONLY public.chat DROP CONSTRAINT chat_iduser_fkey;
       public          postgres    false    4808    216    240                       2606    25267 '   courseRating courseRating_idCourse_fkey    FK CONSTRAINT     �   ALTER TABLE ONLY public."courseRating"
    ADD CONSTRAINT "courseRating_idCourse_fkey" FOREIGN KEY ("idCourse") REFERENCES public.course("idCourse");
 U   ALTER TABLE ONLY public."courseRating" DROP CONSTRAINT "courseRating_idCourse_fkey";
       public          postgres    false    222    4818    250                       2606    25262 (   courseRating courseRating_idStudent_fkey    FK CONSTRAINT     �   ALTER TABLE ONLY public."courseRating"
    ADD CONSTRAINT "courseRating_idStudent_fkey" FOREIGN KEY ("idStudent") REFERENCES public.student("idStudent");
 V   ALTER TABLE ONLY public."courseRating" DROP CONSTRAINT "courseRating_idStudent_fkey";
       public          postgres    false    216    250    4808            �           2606    24943    course course_idteacher_fkey    FK CONSTRAINT     �   ALTER TABLE ONLY public.course
    ADD CONSTRAINT course_idteacher_fkey FOREIGN KEY ("idTeacher") REFERENCES public.teacher("idTeacher");
 F   ALTER TABLE ONLY public.course DROP CONSTRAINT course_idteacher_fkey;
       public          postgres    false    222    218    4814                        2606    25178 -   enrolledcourses enrolledcourses_idCourse_fkey    FK CONSTRAINT     �   ALTER TABLE ONLY public.enrolledcourses
    ADD CONSTRAINT "enrolledcourses_idCourse_fkey" FOREIGN KEY ("idCourse") REFERENCES public.course("idCourse");
 Y   ALTER TABLE ONLY public.enrolledcourses DROP CONSTRAINT "enrolledcourses_idCourse_fkey";
       public          postgres    false    241    222    4818                       2606    25173 .   enrolledcourses enrolledcourses_idStudent_fkey    FK CONSTRAINT     �   ALTER TABLE ONLY public.enrolledcourses
    ADD CONSTRAINT "enrolledcourses_idStudent_fkey" FOREIGN KEY ("idStudent") REFERENCES public.student("idStudent");
 Z   ALTER TABLE ONLY public.enrolledcourses DROP CONSTRAINT "enrolledcourses_idStudent_fkey";
       public          postgres    false    216    4808    241            �           2606    33423    session fk_teacher    FK CONSTRAINT     �   ALTER TABLE ONLY public.session
    ADD CONSTRAINT fk_teacher FOREIGN KEY ("idTeacher") REFERENCES public.teacher("idTeacher");
 <   ALTER TABLE ONLY public.session DROP CONSTRAINT fk_teacher;
       public          postgres    false    218    4814    230            �           2606    25086    groupe groupe_idteacher_fkey    FK CONSTRAINT     �   ALTER TABLE ONLY public.groupe
    ADD CONSTRAINT groupe_idteacher_fkey FOREIGN KEY ("idTeacher") REFERENCES public.teacher("idTeacher");
 F   ALTER TABLE ONLY public.groupe DROP CONSTRAINT groupe_idteacher_fkey;
       public          postgres    false    238    4814    218            �           2606    24969    model model_idasset_fkey    FK CONSTRAINT     �   ALTER TABLE ONLY public.model
    ADD CONSTRAINT model_idasset_fkey FOREIGN KEY ("idAsset") REFERENCES public.asset("idAsset");
 B   ALTER TABLE ONLY public.model DROP CONSTRAINT model_idasset_fkey;
       public          postgres    false    226    4820    224            �           2606    24974    model model_idcourse_fkey    FK CONSTRAINT     �   ALTER TABLE ONLY public.model
    ADD CONSTRAINT model_idcourse_fkey FOREIGN KEY ("idCourse") REFERENCES public.course("idCourse");
 C   ALTER TABLE ONLY public.model DROP CONSTRAINT model_idcourse_fkey;
       public          postgres    false    226    4818    222            �           2606    25019    quiz quiz_idcourse_fkey    FK CONSTRAINT     �   ALTER TABLE ONLY public.quiz
    ADD CONSTRAINT quiz_idcourse_fkey FOREIGN KEY ("idCourse") REFERENCES public.course("idCourse");
 A   ALTER TABLE ONLY public.quiz DROP CONSTRAINT quiz_idcourse_fkey;
       public          postgres    false    232    222    4818            �           2606    25024    quiz quiz_idteacher_fkey    FK CONSTRAINT     �   ALTER TABLE ONLY public.quiz
    ADD CONSTRAINT quiz_idteacher_fkey FOREIGN KEY ("idTeacher") REFERENCES public.teacher("idTeacher");
 B   ALTER TABLE ONLY public.quiz DROP CONSTRAINT quiz_idteacher_fkey;
       public          postgres    false    4814    232    218            �           2606    25038 #   quizElement quizelement_idquiz_fkey    FK CONSTRAINT     �   ALTER TABLE ONLY public."quizElement"
    ADD CONSTRAINT quizelement_idquiz_fkey FOREIGN KEY ("idQuiz") REFERENCES public.quiz("idQuiz");
 O   ALTER TABLE ONLY public."quizElement" DROP CONSTRAINT quizelement_idquiz_fkey;
       public          postgres    false    4828    234    232            �           2606    25055 !   quizResult quizresult_idquiz_fkey    FK CONSTRAINT     �   ALTER TABLE ONLY public."quizResult"
    ADD CONSTRAINT quizresult_idquiz_fkey FOREIGN KEY ("idQuiz") REFERENCES public.quiz("idQuiz");
 M   ALTER TABLE ONLY public."quizResult" DROP CONSTRAINT quizresult_idquiz_fkey;
       public          postgres    false    236    4828    232            �           2606    25050 !   quizResult quizresult_iduser_fkey    FK CONSTRAINT     �   ALTER TABLE ONLY public."quizResult"
    ADD CONSTRAINT quizresult_iduser_fkey FOREIGN KEY ("idUser") REFERENCES public.student("idStudent");
 M   ALTER TABLE ONLY public."quizResult" DROP CONSTRAINT quizresult_iduser_fkey;
       public          postgres    false    216    4808    236            �           2606    25007    session session_idcourse_fkey    FK CONSTRAINT     �   ALTER TABLE ONLY public.session
    ADD CONSTRAINT session_idcourse_fkey FOREIGN KEY ("idCourse") REFERENCES public.course("idCourse");
 G   ALTER TABLE ONLY public.session DROP CONSTRAINT session_idcourse_fkey;
       public          postgres    false    222    230    4818            �   l   x�3�L��/-.N+rH�M���K���T1JT14P��s4/HO��4
�4*)u�,,u57Ktw��7
�,Jѷ,I.�7�tJ�61)4p�������阒������� ���      �      x������ � �      �   �  x����o�6ǟ�_��z�?�6}��6i����iw�\p�̴r��}&��nV�!5D��'�O����∱ȨS�:i�N�^5��"RN�PuT�����:�u�{s�`od�+����?Tn�Ei0��c��@S�f3B)8���'ݨ�=�//�G�?�(��fG��_ײ;�w����1#9�R`*K&�G�%��̥�R��zJ|J��$;��ɇ�*������!|��D����6�V�JVF`���&��BMi֪���Ƭ.��*���_�����������d�E����Ue+OVju_�J7��dй�#s�-�|�{H �u�H/�"���vi�$jM����u����J�v���өj����q����$!����i"@��Ȑ.���1(\A�\b8��&`�QX��F(Y%�q���Ç��r���9�<�`v�\H�JAs(�"<G�0����*�b)�rgt�l���j���Vm)#�F��cI����+&��
cP�D)��2t	�`��0ٺ��+ ���F��^�[��y��=�lC�B��S`g�<^Ơ��(p}˒E��9[hd�S����슡j����y���34n��le�z	��4u���K��1(�����1�f�]��Z����51[��-6���s���T�h��a������4��Z�N���cҷUod����=Se��&�D�6�ٲ��o��m�+��x_ �g�d!�y{i��Iq�Tr�)U����Fw�GݘN��S;e��?���x��P��\a}FD<X%D��������6���tB���?��Lm�-Gg����% y�2�,�R��cYw�;oQz>+Ճ2Z�2~>l��}<�t{��T�/�^���izMS�Ơp.	������r�r9[w^,�m�|:^����j��)K�ϝ��n���(�      �      x�32�47����� 
��      �      x������ � �      �   �  x��V�n�F>�O���	HJ��(��86Z u�i/�9�^�w���S�>E�=���I����d)��Ek�Er����of���x�Q�%Q���4�3/���Jc������{��Z5�,)����,��!5���.�OĒ	 �Ĳ��*�e�Z��(�^�/�8O�i�O�8�ǃ+K��������AT����
J[|/V�����Զ��Fqj�(����8�d2���j眕_��bH3<�R�ʕ�%&�4�D�p6�y�gR���
�zz����A>q�%�l����|<K�Y2�h��z��@�-v�E�$Q<�S�N'�
�j��=�U˄O��՘���d9�f�s錣�����V�'w��ڏ�O{n)��z��T%�Ŏ�#�צ����h��^U��<j�7aô�KMU:��d�M��O�,�Gy��9�\.�O�{ga<߀�s������P��?�v���#���jKj�>X���/�6��(��oZ�s��������
��
���nZ�K�!Z_�%r��2���d�l�8��m1)�8��d9ٴE��cʙ������l�A6� ���k|�y���ͨQ���5�958A�\�re6P-��+��=����!x_���PA��Z"�N be���s:-�\1H���C���Qm�s�9�i���3a��O�gQ����{K�j:3n7x?
�Ë���m�>J:�}RTk�6�K���4�H�*j)1V�$������j��4&��+jJ͔ݟ�Ge	�8Y�+���v�˝�~��vL�����S�W���ZQ,�ڟ���t���;��\w�+i� }�ڃ�n�u�����"	��3����W����ߐ�k@XMֲ�V���|St�v��X���Ƨ�����&o�|�Ky��)\؍]tw.5�UM�@�}x�a��B���"p���u�R���d�l��2R!�e8��m�Z�t��i��׮NTD\��	]��[I�� �t�r�e��lyx+5GH�8�'$�f5�\R?��燏XUt�8���y���u��(O�Y�DE۠O���G{�8}n�mp&
���1rX�ȓHE����@Bl;����Ҭo���,� ';�o���&Xp�%f�UCZ��	����	���������� ��~�      �      x������ � �      �   :   x�34�47�4202�5��54Q0��20�26�32�005�,�K����,)IM����� �p      �   (   x�3�L�H�-�I�K���L�I,.�2B�IL����� 9F;      �   �   x�5˱�0@ѹ���(��9�hBjy�%���5~�&�r�{���3��-�:�qz�I�.֑�V��$��"F�aQx���?�2܈�������smO�)�^J�F{�����*�� �t���d�'x*f$K�B ����<���M��Z�v]9G���䜿�D      �      x������ � �      �   �  x����N�@�ϓ� ����?s�����݁H�������.�!�H<��WSU�H�s]�8
�h�:n�R�6aPƁ�A��I��<�,끫���j7�틼W����v��7g���+!]#N��U�ô(�V�V㢌��*t�Y/���ҙ�j����ٙ��	ɀr�%�+��U��u�|�F������#wM���IZ6��x#�in���H���� �U��(���˩�w�/A��J5�9��:$��&e����O��z���1��y��DLp��g�~�o�c>6kͭ#h5�� x�6��D���g�B:a��&x��l!��S�����������]�1��8�UFH�y�>��v��(3�˺��	���䐮�����j�����Q      �   f   x�3�47�44�t��-(-I-RN�L�KNUp��%�
���U�!��%
���E
�y��9�)�
�I��%
�0��P��f��\���f�0׌�ܜ���qqq p(Y1      �   z  x���Ak�0��ɯzj�]�ڒ�S�B�,{��^����V��$7��c�)Ki��L�y3���l1�g��<�Եu*4���{c�'����ݮ�������\]��Α'ýQ#���4�Ua�jd�\_����%����	}�Gs���s����\"���#O�e�m!8�kh�Z4[(�+GJ���l�؊��7J��!�j��w�X���5J�K[e��Z9ڠ��J����� X�2>���دx7o]P����mJk�⳩k-�A�*����:��j����l�-Y�����ްײ �Q;l[r��sɔ��^cP֤�����~�����h���C���Ӭ����v6�X���op��k4u��8���������Mo���;O����GM5���gqҧ�~�����v3m��5���s��#�����gE����mk]�(�##�&9����Ӊ̗��׈�W,t"�mt�qD�E���D�����D��%�@�ȧ�N#R�}[#R�i�1D�4�)�q�$RY;�H'�P"�b&?'R���N'Rf��׈�9��H)�ӏ#R�ď�����N"�%�@�\M��Fdq�o�aD�i�1Di4?&���Hd1d�d"�8a����|>��:��      �   ^  x���Mo�6�����'Z}�Ton����H��W�vY�cCR��_�w����{w�p쀚��;|0��dɊ�k��]��K��w�+L�;ë�q��w��pM���4W,�O_�V���yv�w�p���:�F�zc<�jW���&��%1����m/�fW�
�[��M�l�.�����w�0�������<^�$a���7�wL'7A��M�}����p��v����3[g,�؇��w�Tٻ��.�-�]lm;�,9��p3���޾����=���0Vokl�.%@��oo]�R7h#e����"Ï������]�{2ּ5(��^�9%�]���5$�7�s�$�������6Q�O[��a;k\��|�(H�%w�so�8u=肊�ֆ��5�-��͖D����	�x�$^������w�ڶ��A�����nk��%���Y����h��?�v��bd7N7|fm 3l�A2���!2�F$�fy��T�-�iI:L^�w;�	�U�����;]/�u�H�-ܰS��Ia&�8���z�\��%KW�����9���k�M����.gi��Mp}��z7�w�����X$ �K���>b�	�@G?�йD���ƍ�j�\t�D����1>K�\����7_���O64�g�|O�Ҕ�1�a�Q��L��/s'��S�O ,~����~zA���0��׶ޣ��UeJ������fF�f��f?���%1��������D�<垆���K~Y�K�T���M1/��f���:u3��zD�,��C�f�?F�,=8=�n��,:��� ����I�*��n���h�f9C/�B]чg�+�N�<ꊘ�{#uE� ���)�|���g߅�B�#�@]��c�
EGO�+��<��2"���+��:��2&�#�+!M~ueJ~'QWfC��+��Mԕ���w]���T�ʜ��v]��SW��x�몘N��&��*=8=������J��Y�U��]W)2<��
}�ꮛG��us��g�yL����9�}m��S��&u�����b����'�n���	u��#v�8�����ъ��v�8���8��Q���n��w
u���]7���-��tuqq�?X4,�      �      x������ � �      �   n   x�m�1�0�W�P�A�?Dy�aY�gd�B��I�
1�j�az_$Ӟ:<~��(�>,�Iw+5X.,s��!�[�Xx)j���wh{1�h�� ��I���M}��*�      �   Y  x���Ao�0�s�;x����4�t˜3l8���X@B[�#����Ò]v~��}�|$D�|��ƨN#�1q1��\��R�C��J�� ���ղ��>�'�;��Ҫ��w����ٱM��蓾7�դ�vq-�%*Pem��~�r�T��$�t��n����o��7ƵLT�����)�@�0��� �ny��ב34SZ�B�Brviۼ8@Ѽ3�	����\�ߺ⬮!����/��N���y1Z�����8*V��e���|��L�8Mu�Nk.��\s.M��`�8v1��-� ��Q�-���k���0*����G�Ӫ��[t9؅��Hԣ������ۓ+      �   �   x�-��J�@@���S��6���`WF�P!�%V\d:�IF'sCfJħW��Y|~5�2 4z�փ`Ld�gL���I[�� 申�W��~ڭ{�	]�&��]����ͧ9��n���K+>�n�kr�a�q��#��H!n�/V�0��Nz�P���.d�H�2.SL��Rl��j��R�W��z�������&����i��U��Ǜj�����$I~ �J�     