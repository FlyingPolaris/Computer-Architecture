# 实验5 IntelSIMD指令实验

余北辰 519030910245



## Exercise 1: 熟悉SIMD intrinsics函数

找出能完成以下操作的128-位intrinsics函数：(one for each):



* Four floating point divisions in single precision (i.e.float)（4个并行的单精度浮点数除法）

\__m128 _mm_div_ps (\_\_m128 a, __m128 b)



* Sixteen max operations over unsigned 8-bit integers (i.e.char)（16个并行求8位无符号整数的最大值）

\__m128i _mm_max_epu8 (\_\_m128i a, __m128i b)



* Arithmetic shift right of eight signed 16-bit integers (i.e.short)（8个并行的16位带符号短整数的算术右移）

\__m128i _mm_srai_epi16 (__m128 a, int imm)



