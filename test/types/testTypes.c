#include "testTypes.h"

bool testTypes(v0)
{
    TEST(sizeof(v0), 1);

    TEST(sizeof(b1), 1);

    TEST(sizeof(u8), 1);
    TEST(sizeof(s8), 1);

    TEST(sizeof(u16), 2);
    TEST(sizeof(s16), 2);

    TEST(sizeof(u32), 4);
    TEST(sizeof(s32), 4);

    TEST(sizeof(f32), 4);
    
    TEST(sizeof(f64), 8);

    return TRUE;
}