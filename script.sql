-- ----------------------------------------------------------------
-- 1 Base de dados e criação de tabela
--escreva a sua solução aqui
CREATE table tb_estudantes (
    STUDENTID SERIAL PRIMARY KEY,
    AGE int,
    GENDER int,
    HS_TYPE int,
    SCHOLARSHIP int,
    WORK int,
    ACTIVITY int,
    PARTNER int,
    SALARY int,
    TRANSPORT int,
    LIVING int,
    MOTHER_EDU int,
    FATHER_EDU int,
    _SIBLINGS int,
    KIDS int,
    MOTHER_JOB int,
    FATHER_JOB int,
    STUDY_HRS int,
    READ_FREQ int,
    READ_FREQ_SCI int,
    ATTEND_DEPT int,
    IMPACT int,
    ATTEND int,
    PREP_STUDY int,
    PREP_EXAM int,
    NOTES int,
    LISTENS int,
    LIKES_DISCUSS int,
    CLASSROOM int,
    CUML_GPA int,
    EXP_GPA int,
    COURSE_ID int,
    GRADE int
);

-- ----------------------------------------------------------------
-- 2 Resultado em função da formação dos pais
--escreva a sua solução aqui
-- DO $$
--     DECLARE
--         --1 Declaração do CURSOR
--         cur_aprovados_pais REFCURSOR;
--         v_id int;
--         v_pai int;
--         v_mae int;
--         v_nota int;
--         v_cont int := 0;
--     BEGIN
--         --2 abertura do cursor
--         OPEN cur_aprovados_pais FOR
--             SELECT studentid, father_edu, mother_edu, grade FROM
--             tb_estudantes WHERE father_edu = 6 OR mother_edu = 6 and grade != 0;
--         LOOP
--             --3 Recuperação dos dados de interesse
--             FETCH cur_aprovados_pais INTO v_id,v_pai,v_mae,v_nota;
--             EXIT WHEN NOT FOUND;
--             v_cont = v_cont +1;
--         END LOOP;
--         RAISE NOTICE '%',v_cont ;
--         --4 Finalizar
--         CLOSE cur_aprovados_pais;
--     END;
-- $$

-- ----------------------------------------------------------------
-- 3 Resultado em função dos estudos
--escreva a sua solução aqui
-- DO $$
--     DECLARE
--     --1 declaração
--     cur_alunos_aprovados_sozinhos REFCURSOR;

--     v_nota int := 0;
--     v_preparacao int:= 1;
--     v_cont int := 0;
--     v_nome_tabela VARCHAR(200) := 'tb_estudantes';
--     BEGIN
--         --2 abertura
--         OPEN cur_alunos_aprovados_sozinhos FOR EXECUTE
--         format(
--             '
--             SELECT grade,prep_study FROM %s WHERE grade > %s AND prep_study = %s;
--             ',
--             v_nome_tabela, v_nota,v_preparacao 
--         );
--         LOOP
--             --3 Recuperação dos dados de interesse
--             FETCH cur_alunos_aprovados_sozinhos INTO v_nota, v_preparacao;
--             EXIT WHEN NOT FOUND;
--             v_cont = v_cont +1;
--         END LOOP;

--         IF v_cont = 0 then
--             RAISE NOTICE '-1';
--         Else
--             RAISE NOTICE '%', v_cont;
--         END IF;
        
--         --4 fechamento do cursor
--         Close cur_alunos_aprovados_sozinhos;
-- END;$$
-- ----------------------------------------------------------------
-- 4 Salário versus estudos
--escreva a sua solução aqui
DO $$
DECLARE
    --1 Declaração
    cur_alunos_regularmente Cursor FOR
    SELECT salary,prep_exam FROM
    tb_estudantes WHERE salary = 5 AND prep_exam = 2;
    v_tupla RECORD;
    v_resultado int:= 0;
BEGIN
    --2 abertura do CURSOR
    OPEN cur_alunos_regularmente;
    --3 Recuperação dos dados
    -- faça um while em 2 minutos
    FETCH cur_alunos_regularmente INTO v_tupla;
    While FOUND LOOP
        v_resultado = v_resultado + 1;
    Fetch cur_alunos_regularmente INTO v_tupla;
    END LOOP;
    Close cur_alunos_regularmente;
    RAISE NOTICE '%', v_resultado;
END;$$

-- ----------------------------------------------------------------
-- 5. Limpeza de valores NULL
--escreva a sua solução aqui

DO $$
    DECLARE
        cur_delete REFCURSOR;
        v_tupla RECORD;
    BEGIN
        --2 abertura do CURSOR
        Open cur_delete SCROLL FOR
        SELECT * FROM tb_top_youtubers;
        LOOP
            --3 recuperação dos dados de interesse
            FETCH cur_delete INTO v_tupla
            EXIT when not FOUND;
            IF v_tupla.video_count ISNULL THEN
                Delete FROM tb_top_youtubers where CURRENT OF cur_delete;
            END IF;
        END loop;

        LOOP
            FETCH BACKWARD FROM cur_delete INTO v_tupla;
            exit when not FOUND;
            raise notice '%', v_tupla;
        End LOOP
        -- 4 fechamento cursor
        close cur_delete;
    END;
$$
-- ----------------------------------------------------------------