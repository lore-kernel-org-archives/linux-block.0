Received: from sphereful.davidgow.net (sphereful.davidgow.net [203.29.242.92])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 20328439F75;
	Thu, 15 Oct 2026 14:12:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.29.242.92
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792073542; cv=none; b=q2Jf9CgwfrfnM+hZ2QB8NNE9FLcRVyJugSkYZLbq/UNuXAxxnL9Mse6nL30VGgtpv+MpkQhuEAA/2DqwpFqvt7iRpUWpYFtrzaTn9+lB1IszWdESKvKa4a7WyoF8PpFQI0qPwkIqS/f7xULmibX95LKnyO8tXl6H970AQejuAY0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792073542; c=relaxed/simple;
	bh=zQjClWTlRSrEDvf3v/4znzjDecAtN82hnrlhsDrNbkw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Fifkz3ZFe+s29sSOBdXIQvQVudTpezBtxIB09Xg+R6q6hrOeDpUsfMWSpYnB/bR3QalMke0kecQRpi9psLPZeLQeb9elHSoRhH32x4rW5/9xrc45SZe3rrVzyLzSjIoRsRW8Lj9fMVqGQ8J0ecwxOmItQEhLLF4rSD0uVIW4sqI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=davidgow.net; spf=pass smtp.mailfrom=davidgow.net; arc=none smtp.client-ip=203.29.242.92
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=davidgow.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=davidgow.net
Received: by sphereful.davidgow.net (Postfix, from userid 119)
	id DBDE9200617; Thu, 15 Oct 2026 22:05:05 +0800 (AWST)
X-Spam-Level: 
Received: from [192.168.11.49] (ip-178-027-179-026.vkd86.pools.vodafone-ip.de [178.27.179.26])
	by sphereful.davidgow.net (Postfix) with ESMTPSA id 4D784200611;
	Thu, 15 Oct 2026 22:04:57 +0800 (AWST)
Message-ID: <d6ea208a-0b53-4da8-998f-817a0e0b7c61@davidgow.net>
Date: Thu, 15 Oct 2026 22:04:51 +0800
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] lib/sbitmap: add KUnit test suite
To: Wang Yibo <szwyb123@gmail.com>, Jens Axboe <axboe@kernel.dk>
Cc: Andrew Morton <akpm@linux-foundation.org>, linux-block@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
 kunit-dev@googlegroups.com
References: <20261014082704.33667-1-szwyb123@gmail.com>
Content-Language: en-US
From: David Gow <david@davidgow.net>
In-Reply-To: <20261014082704.33667-1-szwyb123@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Le 14/10/2026 à 16:27, Wang Yibo a écrit :
> sbitmap is the tag allocator used by blk-mq and the I/O schedulers
> built on top of it, but the plain, synchronous part of its API has no
> test coverage at all.
> 
> Add a KUnit suite covering initialisation, allocation and exhaustion,
> deferred clears, round-robin ordering, resize, the bitmap helpers and
> sbitmap_for_each_set(), so that the behaviour is checked on every boot.
> 
> The new file is added to the BLOCK LAYER entry in MAINTAINERS, next to
> lib/sbitmap.c, so that it does not end up without a maintainer.
> 
> Signed-off-by: Wang Yibo <szwyb123@gmail.com>
> ---

Thanks for the test. I'll give it a closer look when I'm back from my 
post-plumbers travel, but it seems that this is failing on a number of 
architectures.

In partciular, sb.alloc_hint is annotated __percpu, which alas doesn't 
work with KUNIT_EXPECT_NOT_NULL on, e.g., x86 where it uses a different 
address space (__seg_fs or __seg_gs). This is probably something we 
should work out how to address in KUnit, but for now you may be better 
off with a different assertion.

Equally, sbitmap_test_iterate_set is failing here on 32-bit UML (but 
only when built with gcc, not clang):

# sbitmap_test_iterate_set: EXPECTATION FAILED at 
lib/tests/sbitmap_kunit.c:273
  Expected ctx.nr_visited == (unsigned int)(sizeof(bits) / 
sizeof((bits)[0]) + ((int)sizeof(struct 
{_Static_assert(!(!(!__builtin_types_compatible_p(typeof((bits)), 
typeof(&(bits)[0])))), "must be array");}))), but
      ctx.nr_visited == 5 (0x5)
      (unsigned int)(sizeof(bits) / sizeof((bits)[0]) + 
((int)sizeof(struct 
{_Static_assert(!(!(!__builtin_types_compatible_p(typeof((bits)), 
typeof(&(bits)[0])))), "must be array");}))) == 6 (0x6)
  [FAILED] sbitmap_test_iterate_set
      # module: sbitmap_kunit
  # sbitmap: pass:7 fail:1 skip:0 total:8
# Totals: pass:7 fail:1 skip:0 total:8
===================== [FAILED] sbitmap =====================

Not sure what's causing that yet: it may not be an issue with the test 
itself.

Cheers,
-- David
>   MAINTAINERS               |   1 +
>   lib/Kconfig.debug         |  13 ++
>   lib/tests/Makefile        |   1 +
>   lib/tests/sbitmap_kunit.c | 300 ++++++++++++++++++++++++++++++++++++++
>   4 files changed, 315 insertions(+)
>   create mode 100644 lib/tests/sbitmap_kunit.c
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index f53047aa8d3c..c8510e6f1817 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -4726,6 +4726,7 @@ F:	include/uapi/linux/blk*
>   F:	include/uapi/linux/ioprio.h
>   F:	kernel/trace/blktrace.c
>   F:	lib/sbitmap.c
> +F:	lib/tests/sbitmap_kunit.c
>   
>   BLOCK LAYER DEVICE DRIVER API [RUST]
>   M:	Andreas Hindborg <a.hindborg@kernel.org>
> diff --git a/lib/Kconfig.debug b/lib/Kconfig.debug
> index 6b24a2c89b84..f5fe7f5a0a4d 100644
> --- a/lib/Kconfig.debug
> +++ b/lib/Kconfig.debug
> @@ -2456,6 +2456,19 @@ config PRINTF_KUNIT_TEST
>   
>   	  If unsure, say N.
>   
> +config SBITMAP_KUNIT_TEST
> +	tristate "KUnit test for sbitmap" if !KUNIT_ALL_TESTS
> +	depends on KUNIT
> +	depends on SBITMAP
> +	default KUNIT_ALL_TESTS
> +	help
> +	  Enable to turn on sbitmap tests, running at boot or module load time.
> +
> +	  For more information on KUnit and unit tests in general, please refer
> +	  to the KUnit documentation in Documentation/dev-tools/kunit/.
> +
> +	  If unsure, say N.
> +
>   config SCANF_KUNIT_TEST
>   	tristate "KUnit test scanf() family of functions at runtime" if !KUNIT_ALL_TESTS
>   	depends on KUNIT
> diff --git a/lib/tests/Makefile b/lib/tests/Makefile
> index 3cac3b63a752..1f49555f94c3 100644
> --- a/lib/tests/Makefile
> +++ b/lib/tests/Makefile
> @@ -44,6 +44,7 @@ obj-$(CONFIG_OVERFLOW_KUNIT_TEST) += overflow_kunit.o
>   obj-$(CONFIG_PRANDOM_KUNIT_TEST) += random32_kunit.o
>   obj-$(CONFIG_PRINTF_KUNIT_TEST) += printf_kunit.o
>   obj-$(CONFIG_RANDSTRUCT_KUNIT_TEST) += randstruct_kunit.o
> +obj-$(CONFIG_SBITMAP_KUNIT_TEST) += sbitmap_kunit.o
>   obj-$(CONFIG_SCANF_KUNIT_TEST) += scanf_kunit.o
>   obj-$(CONFIG_SEQ_BUF_KUNIT_TEST) += seq_buf_kunit.o
>   obj-$(CONFIG_SIPHASH_KUNIT_TEST) += siphash_kunit.o
> diff --git a/lib/tests/sbitmap_kunit.c b/lib/tests/sbitmap_kunit.c
> new file mode 100644
> index 000000000000..4f3a588d15df
> --- /dev/null
> +++ b/lib/tests/sbitmap_kunit.c
> @@ -0,0 +1,300 @@
> +// SPDX-License-Identifier: GPL-2.0-only
> +/*
> + * KUnit tests for the scalable bitmap (sbitmap) implementation.
> + *
> + * sbitmap is the tag allocator used by blk-mq and the I/O schedulers built on
> + * top of it, but it has no tests.  These tests pin down the observable
> + * behaviour of the plain, synchronous parts of the API.
> + *
> + * Copyright (C) 2026 Wang Yibo <szwyb123@gmail.com>
> + */
> +
> +#include <linux/bitmap.h>
> +#include <linux/gfp.h>
> +#include <linux/sbitmap.h>
> +
> +#include <kunit/test.h>
> +
> +/*
> + * Big enough to span several words for any plausible BITS_PER_LONG, and not a
> + * power of two so that the last word is partially used.
> + */
> +#define SBITMAP_TEST_DEPTH	(3 * BITS_PER_LONG + 5)
> +
> +static void sbitmap_test_init(struct kunit *test)
> +{
> +	const unsigned int depth = 97;
> +	struct sbitmap sb;
> +	int ret;
> +
> +	ret = sbitmap_init_node(&sb, depth, -1, GFP_KERNEL, NUMA_NO_NODE,
> +				false, true);
> +	KUNIT_ASSERT_EQ(test, ret, 0);
> +	KUNIT_EXPECT_EQ(test, sb.depth, depth);
> +	KUNIT_EXPECT_EQ(test, sb.shift,
> +			(unsigned int)sbitmap_calculate_shift(depth));
> +	KUNIT_EXPECT_EQ(test, sb.map_nr, DIV_ROUND_UP(depth, 1U << sb.shift));
> +	KUNIT_EXPECT_FALSE(test, sb.round_robin);
> +	KUNIT_EXPECT_NOT_NULL(test, sb.alloc_hint);

alloc_hint is declared __percpu, which is incompatible with 
KUNIT_EXPECT_NOT_NULL() on x86.

> +	KUNIT_EXPECT_FALSE(test, sbitmap_any_bit_set(&sb));
> +	KUNIT_EXPECT_EQ(test, sbitmap_weight(&sb), 0U);
> +	sbitmap_free(&sb);
> +
> +	/* An explicitly requested shift is honoured. */
> +	ret = sbitmap_init_node(&sb, depth, 3, GFP_KERNEL, NUMA_NO_NODE,
> +				false, true);
> +	KUNIT_ASSERT_EQ(test, ret, 0);
> +	KUNIT_EXPECT_EQ(test, sb.shift, 3U);
> +	KUNIT_EXPECT_EQ(test, sb.map_nr, DIV_ROUND_UP(depth, 1U << 3));
> +	sbitmap_free(&sb);
> +
> +	/* BITS_PER_LONG bits per word is the largest representable granularity. */
> +	ret = sbitmap_init_node(&sb, depth, ilog2(BITS_PER_LONG), GFP_KERNEL,
> +				NUMA_NO_NODE, false, true);
> +	KUNIT_ASSERT_EQ(test, ret, 0);
> +	KUNIT_EXPECT_EQ(test, sb.shift, (unsigned int)ilog2(BITS_PER_LONG));
> +	KUNIT_EXPECT_EQ(test, sb.map_nr, DIV_ROUND_UP(depth, BITS_PER_LONG));
> +	sbitmap_free(&sb);
> +
> +	/* Anything above that cannot be represented and must be rejected. */
> +	ret = sbitmap_init_node(&sb, depth, ilog2(BITS_PER_LONG) + 1,
> +				GFP_KERNEL, NUMA_NO_NODE, false, true);
> +	KUNIT_EXPECT_EQ(test, ret, -EINVAL);
> +}
> +
> +static void sbitmap_test_calculate_shift(struct kunit *test)
> +{
> +	/* Maps too small to spread over several words keep the default. */
> +	KUNIT_EXPECT_EQ(test, sbitmap_calculate_shift(0), ilog2(BITS_PER_LONG));
> +	KUNIT_EXPECT_EQ(test, sbitmap_calculate_shift(1), ilog2(BITS_PER_LONG));
> +	KUNIT_EXPECT_EQ(test, sbitmap_calculate_shift(3), ilog2(BITS_PER_LONG));
> +
> +	/* Four bits map to one bit per word. */
> +	KUNIT_EXPECT_EQ(test, sbitmap_calculate_shift(4), 0);
> +
> +	/* The shift grows back as the depth increases. */
> +	KUNIT_EXPECT_EQ(test, sbitmap_calculate_shift(4 * BITS_PER_LONG - 1),
> +			ilog2(BITS_PER_LONG) - 1);
> +	KUNIT_EXPECT_EQ(test, sbitmap_calculate_shift(4 * BITS_PER_LONG),
> +			ilog2(BITS_PER_LONG));
> +}
> +
> +static void sbitmap_test_get_exhaust(struct kunit *test)
> +{
> +	DECLARE_BITMAP(seen, SBITMAP_TEST_DEPTH) = { 0 };
> +	struct sbitmap sb;
> +	unsigned int i;
> +	int bit;
> +
> +	KUNIT_ASSERT_EQ(test, sbitmap_init_node(&sb, SBITMAP_TEST_DEPTH, -1,
> +						GFP_KERNEL, NUMA_NO_NODE,
> +						false, true), 0);
> +
> +	/* Every bit is handed out exactly once, then the map is empty. */
> +	for (i = 0; i < SBITMAP_TEST_DEPTH; i++) {
> +		bit = sbitmap_get(&sb);
> +		KUNIT_ASSERT_GE(test, bit, 0);
> +		KUNIT_ASSERT_LT(test, bit, (int)SBITMAP_TEST_DEPTH);
> +		KUNIT_ASSERT_FALSE(test, test_bit(bit, seen));
> +		__set_bit(bit, seen);
> +	}
> +
> +	KUNIT_EXPECT_TRUE(test, sbitmap_any_bit_set(&sb));
> +	KUNIT_EXPECT_EQ(test, sbitmap_weight(&sb),
> +			(unsigned int)SBITMAP_TEST_DEPTH);
> +	KUNIT_EXPECT_EQ(test, sbitmap_get(&sb), -1);
> +
> +	sbitmap_free(&sb);
> +}
> +
> +static void sbitmap_test_put_reuse(struct kunit *test)
> +{
> +	struct sbitmap sb;
> +	unsigned int i;
> +	int bit;
> +
> +	KUNIT_ASSERT_EQ(test, sbitmap_init_node(&sb, BITS_PER_LONG, -1,
> +						GFP_KERNEL, NUMA_NO_NODE,
> +						true, true), 0);
> +
> +	for (i = 0; i < BITS_PER_LONG; i++)
> +		KUNIT_ASSERT_GE(test, sbitmap_get(&sb), 0);
> +
> +	KUNIT_EXPECT_EQ(test, sbitmap_weight(&sb), (unsigned int)BITS_PER_LONG);
> +	KUNIT_EXPECT_EQ(test, sbitmap_get(&sb), -1);
> +
> +	/*
> +	 * Freeing a single bit must make exactly that bit available again, no
> +	 * matter which bit it was.
> +	 */
> +	for (i = 0; i < BITS_PER_LONG; i++) {
> +		sbitmap_put(&sb, i);
> +		KUNIT_EXPECT_EQ(test, sbitmap_weight(&sb),
> +				(unsigned int)BITS_PER_LONG - 1);
> +		bit = sbitmap_get(&sb);
> +		KUNIT_EXPECT_EQ(test, bit, (int)i);
> +		KUNIT_EXPECT_EQ(test, sbitmap_weight(&sb),
> +				(unsigned int)BITS_PER_LONG);
> +		KUNIT_EXPECT_EQ(test, sbitmap_get(&sb), -1);
> +	}
> +
> +	sbitmap_free(&sb);
> +}
> +
> +static void sbitmap_test_round_robin(struct kunit *test)
> +{
> +	struct sbitmap sb;
> +	unsigned int i;
> +	int bit, prev = -1;
> +
> +	KUNIT_ASSERT_EQ(test, sbitmap_init_node(&sb, SBITMAP_TEST_DEPTH, -1,
> +						GFP_KERNEL, NUMA_NO_NODE,
> +						true, true), 0);
> +
> +	/*
> +	 * round_robin must hand out strictly increasing bit numbers while the
> +	 * map fills up from empty.
> +	 */
> +	for (i = 0; i < SBITMAP_TEST_DEPTH; i++) {
> +		bit = sbitmap_get(&sb);
> +		KUNIT_ASSERT_GE(test, bit, 0);
> +		KUNIT_ASSERT_LT(test, bit, (int)SBITMAP_TEST_DEPTH);
> +		if (prev != -1)
> +			KUNIT_ASSERT_GT(test, bit, prev);
> +		prev = bit;
> +	}
> +
> +	KUNIT_EXPECT_EQ(test, sbitmap_weight(&sb),
> +			(unsigned int)SBITMAP_TEST_DEPTH);
> +	KUNIT_EXPECT_EQ(test, sbitmap_get(&sb), -1);
> +
> +	sbitmap_free(&sb);
> +}
> +
> +static void sbitmap_test_resize(struct kunit *test)
> +{
> +	const unsigned int depth = 4 * BITS_PER_LONG;
> +	struct sbitmap sb;
> +	unsigned int i;
> +
> +	KUNIT_ASSERT_EQ(test, sbitmap_init_node(&sb, depth, -1, GFP_KERNEL,
> +						NUMA_NO_NODE, true, true), 0);
> +
> +	for (i = 0; i < depth; i++)
> +		KUNIT_ASSERT_GE(test, sbitmap_get(&sb), 0);
> +	KUNIT_EXPECT_EQ(test, sbitmap_weight(&sb), depth);
> +
> +	/* Shrinking hides the bits past the new depth. */
> +	sbitmap_resize(&sb, depth / 2);
> +	KUNIT_EXPECT_EQ(test, sb.depth, depth / 2);
> +	KUNIT_EXPECT_EQ(test, sb.map_nr,
> +			DIV_ROUND_UP(depth / 2, 1U << sb.shift));
> +	KUNIT_EXPECT_EQ(test, sbitmap_weight(&sb), depth / 2);
> +	KUNIT_EXPECT_EQ(test, sbitmap_get(&sb), -1);
> +
> +	/* Growing makes them visible again; they are still allocated. */
> +	sbitmap_resize(&sb, depth);
> +	KUNIT_EXPECT_EQ(test, sb.depth, depth);
> +	KUNIT_EXPECT_EQ(test, sbitmap_weight(&sb), depth);
> +	KUNIT_EXPECT_EQ(test, sbitmap_get(&sb), -1);
> +
> +	sbitmap_free(&sb);
> +}
> +
> +static void sbitmap_test_set_clear_bit(struct kunit *test)
> +{
> +	static const unsigned int bits[] = {
> +		0, 1, BITS_PER_LONG - 1, BITS_PER_LONG,
> +		2 * BITS_PER_LONG + 3, SBITMAP_TEST_DEPTH - 1
> +	};
> +	struct sbitmap sb;
> +	unsigned int i;
> +
> +	KUNIT_ASSERT_EQ(test, sbitmap_init_node(&sb, SBITMAP_TEST_DEPTH, -1,
> +						GFP_KERNEL, NUMA_NO_NODE,
> +						false, true), 0);
> +
> +	KUNIT_EXPECT_FALSE(test, sbitmap_any_bit_set(&sb));
> +
> +	for (i = 0; i < ARRAY_SIZE(bits); i++) {
> +		sbitmap_set_bit(&sb, bits[i]);
> +		KUNIT_EXPECT_TRUE(test, sbitmap_test_bit(&sb, bits[i]));
> +	}
> +	KUNIT_EXPECT_TRUE(test, sbitmap_any_bit_set(&sb));
> +	KUNIT_EXPECT_EQ(test, sbitmap_weight(&sb), (unsigned int)ARRAY_SIZE(bits));
> +
> +	for (i = 0; i < ARRAY_SIZE(bits); i++) {
> +		sbitmap_clear_bit(&sb, bits[i]);
> +		KUNIT_EXPECT_FALSE(test, sbitmap_test_bit(&sb, bits[i]));
> +	}
> +	KUNIT_EXPECT_FALSE(test, sbitmap_any_bit_set(&sb));
> +	KUNIT_EXPECT_EQ(test, sbitmap_weight(&sb), 0U);
> +
> +	sbitmap_free(&sb);
> +}
> +
> +struct sbitmap_iter_ctx {
> +	struct kunit *test;
> +	DECLARE_BITMAP(visited, SBITMAP_TEST_DEPTH);
> +	unsigned int nr_visited;
> +};
> +
> +static bool sbitmap_iter_collect(struct sbitmap *sb, unsigned int bitnr,
> +				 void *data)
> +{
> +	struct sbitmap_iter_ctx *ctx = data;
> +
> +	KUNIT_ASSERT_LT(ctx->test, bitnr, SBITMAP_TEST_DEPTH);
> +	__set_bit(bitnr, ctx->visited);
> +	ctx->nr_visited++;
> +
> +	return true;
> +}
> +
> +static void sbitmap_test_iterate_set(struct kunit *test)
> +{
> +	static const unsigned int bits[] = {
> +		0, 5, BITS_PER_LONG - 1, BITS_PER_LONG, 130,
> +		SBITMAP_TEST_DEPTH - 1
> +	};
> +	struct sbitmap_iter_ctx ctx = { .test = test };
> +	struct sbitmap sb;
> +	unsigned int i;
> +
> +	KUNIT_ASSERT_EQ(test, sbitmap_init_node(&sb, SBITMAP_TEST_DEPTH, -1,
> +						GFP_KERNEL, NUMA_NO_NODE,
> +						false, true), 0);
> +
> +	for (i = 0; i < ARRAY_SIZE(bits); i++)
> +		sbitmap_set_bit(&sb, bits[i]);
> +
> +	sbitmap_for_each_set(&sb, sbitmap_iter_collect, &ctx);
> +
> +	KUNIT_EXPECT_EQ(test, ctx.nr_visited, (unsigned int)ARRAY_SIZE(bits));

This fails on 32-bit UML w/ gcc 16.2.1 (SUSE): nr_visited == 5, 
ARRAY_SIZE(bits) == 7.

Seems to be passing with clang 23.1.2, though.

> +	for (i = 0; i < ARRAY_SIZE(bits); i++)
> +		KUNIT_EXPECT_TRUE(test, test_bit(bits[i], ctx.visited));
> +
> +	sbitmap_free(&sb);
> +}
> +
> +static struct kunit_case sbitmap_test_cases[] = {
> +	KUNIT_CASE(sbitmap_test_init),
> +	KUNIT_CASE(sbitmap_test_calculate_shift),
> +	KUNIT_CASE(sbitmap_test_get_exhaust),
> +	KUNIT_CASE(sbitmap_test_put_reuse),
> +	KUNIT_CASE(sbitmap_test_round_robin),
> +	KUNIT_CASE(sbitmap_test_resize),
> +	KUNIT_CASE(sbitmap_test_set_clear_bit),
> +	KUNIT_CASE(sbitmap_test_iterate_set),
> +	{}
> +};
> +
> +static struct kunit_suite sbitmap_test_suite = {
> +	.name = "sbitmap",
> +	.test_cases = sbitmap_test_cases,
> +};
> +
> +kunit_test_suite(sbitmap_test_suite);
> +
> +MODULE_DESCRIPTION("KUnit test for sbitmap");
> +MODULE_LICENSE("GPL");
> 
> base-commit: 4056b3c9d3c92ea45955641dbafeb9b960e146ef

