Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7EF163FFFA1
	for <linux-block@vger.kernel.org>; Wed, 14 Oct 2026 08:27:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791966435; cv=none; b=WWIxK6T+mG+rjvWzhW1HdVOHK/kMgS6ZP5LnxoggkaK+SVn8klGC+rfpH+TGxpVQca0uv70bT//VqalflLZ2eI1bvSTGXBJGmeKTbm9bjsVIkjXmzhEUFfXylOPsqu5lfx96944xWhmHgxPmBq0UKKdaR0J1OR4JL58knzylLhU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791966435; c=relaxed/simple;
	bh=+uDXX4unUdHNBxn9vOki+p5lSyVwmpx0BeZp0OjHjJk=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=qvMKC4GycPoO1WIjeghC3TadIMURf7iEjVK0OBA/bCCTD3+pe+pDCvKN8dUZnxeLebA69Zx6LmWrmBjlCbmTy9updCDzayDdkZH/9N6zfzk4z7n9+PbnjgEGB08IhZXFvEu+uRvS+6dZLUbsnIceiHNxlsglaebrI3bHVnTIT/8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=X1L0AA++; arc=none smtp.client-ip=209.85.214.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="X1L0AA++"
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-2e8f2c3ad6bso13925605ad.1
        for <linux-block@vger.kernel.org>; Wed, 14 Oct 2026 01:27:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791966433; x=1792571233; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=8xXba+EvG6pZ4myUFR4ygzt+6MpiP4SZCUDpbeJmv3A=;
        b=X1L0AA++NomQXGTxSJQFcdcfEejMwv6DSQGk5T9Zpcguzn1h4h0ra7xoYgo4s3VflA
         rOuJTgWzJ0fxZXI9kBvKb34fYfX+T9CS6k9/A9SI7rvX2kE7fZQgHzicBDzuctB9o6M+
         Qfyr4gK6ReGl0D2OmPfz3R/ymrQd+/v0FC41XqDbJ+aRdj6of4lbs9+tpvXs4zuAGS/p
         MfYd4rBqPTKfUZowx7iZDMMsB/07KeaOLuB77w1LRRR0XZZDcHC9o+LDOKDO/33eKLfJ
         CmYP+lkATfpNarJ6LTa1tArtdKCs8Qs8UA+g1U0jSYx6fMMWy4NgtuY3jV0zspyfgyYK
         dcgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791966433; x=1792571233;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=8xXba+EvG6pZ4myUFR4ygzt+6MpiP4SZCUDpbeJmv3A=;
        b=yR0umsRqFPrkSx7aQ0NaMiGllXFjOuag5aXXMEar2qBDaNS0cr588oNxLQvzBWWt8W
         Tm13/BRG4Z/8+IOrZTYZKecCI1Pj38WKXOxScNuR7vXxLJiBwseMuNmhROBlTWBrFYQ4
         eOGBemR5x9JOJ2OZymUesoaRsQRFBi5tCInd3FABEDIOZJuibVyV8yGkNFV7AAax+gzA
         92vcizrocX/cThI6WkRV/UtVGeVouOfmvRs5F5fOeOP7HNVct8Wr6u6o7xkMP5CN6Y4w
         xG6u7ifTcOm6PiMqL2TbqRaC5fqDyw1F/PAjCJhzspH1zpmSw60gas/tGpilvRrI1cT7
         f1Qg==
X-Forwarded-Encrypted: i=1; AKwUvBya7UFTd2adwsmh/Fj8Ksc2HaTWzdKB5JUXNjFYf9XD+ryaXWQyaVW0WCwK/4KMwPkutFa50G3jmeXFEg==@vger.kernel.org
X-Gm-Message-State: AFq9FYJHxJx5bPIgq4LZ//osfTXZKvMtHv0FWhv0x7AvvvQm2D9Zc8wE
	o0z/0zNJ4d15x3pHrLP9IOXXekXeRDfFk7qDXAoOUev3ttpGb1rW4vWgWcYDreg371SB
X-Gm-Gg: AYBFou0mNFavAM/0ZYo87mg9gWpJEbRkEA5ntHU1dvebhUTEi40QrWYt5aGrktr3ndn
	5MI4fBBf1pawhdByoCGh/o/zksUM4u0U9M/njvoL6T0170baYDqrfTp+6ZGZxQIk3vGn5B8lIDw
	aX8zEjLmKH7b52GOrKTbr3o0e15FiBY1B+KpRPYZY4Pue02n+HM1wdyysq7b95Lhpi5H4JIED+q
	Ybdo+F0QW00EEwcREic1Liz8PtKFNJrqPA1nhFAn8wHsewJ5cQLXOQKTwJ+JR5igGl6nab5i41u
	KCTgYEp0TG6NFo1ddCWC6Jq1bSQMLWbV9NXL5hjlIlmcuVnsU0UczXcuH1TPsLyhfXnsDpL/u0A
	KBOoFN5HltMkWeJnj8RyqlG974XX4Ev/m6ckTQypeutAUZ75aaWS7n122dRLHv2XRGcPv9TEMDI
	/AGj5wJXuCGe7nLIYSuWJa5JefUX8qoJn6IO1err8j+1Ez6FW6ZhIxybhnotc8kMEXjAZPzB+Ss
	ZA8KIcg
X-Received: by 2002:a17:90a:d44b:b0:3ab:365f:ebdd with SMTP id 98e67ed59e1d1-3ab3ad2029bmr12131166a91.37.1791966432061;
        Wed, 14 Oct 2026 01:27:12 -0700 (PDT)
Received: from localhost.localdomain ([185.220.238.36])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-cd3d9e1ee81sm6591992a12.12.2026.10.14.01.27.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Oct 2026 01:27:10 -0700 (PDT)
From: Wang Yibo <szwyb123@gmail.com>
To: Jens Axboe <axboe@kernel.dk>
Cc: Andrew Morton <akpm@linux-foundation.org>,
	linux-block@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	kunit-dev@googlegroups.com
Subject: [PATCH] lib/sbitmap: add KUnit test suite
Date: Wed, 14 Oct 2026 16:27:04 +0800
Message-Id: <20261014082704.33667-1-szwyb123@gmail.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

sbitmap is the tag allocator used by blk-mq and the I/O schedulers
built on top of it, but the plain, synchronous part of its API has no
test coverage at all.

Add a KUnit suite covering initialisation, allocation and exhaustion,
deferred clears, round-robin ordering, resize, the bitmap helpers and
sbitmap_for_each_set(), so that the behaviour is checked on every boot.

The new file is added to the BLOCK LAYER entry in MAINTAINERS, next to
lib/sbitmap.c, so that it does not end up without a maintainer.

Signed-off-by: Wang Yibo <szwyb123@gmail.com>
---
 MAINTAINERS               |   1 +
 lib/Kconfig.debug         |  13 ++
 lib/tests/Makefile        |   1 +
 lib/tests/sbitmap_kunit.c | 300 ++++++++++++++++++++++++++++++++++++++
 4 files changed, 315 insertions(+)
 create mode 100644 lib/tests/sbitmap_kunit.c

diff --git a/MAINTAINERS b/MAINTAINERS
index f53047aa8d3c..c8510e6f1817 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -4726,6 +4726,7 @@ F:	include/uapi/linux/blk*
 F:	include/uapi/linux/ioprio.h
 F:	kernel/trace/blktrace.c
 F:	lib/sbitmap.c
+F:	lib/tests/sbitmap_kunit.c
 
 BLOCK LAYER DEVICE DRIVER API [RUST]
 M:	Andreas Hindborg <a.hindborg@kernel.org>
diff --git a/lib/Kconfig.debug b/lib/Kconfig.debug
index 6b24a2c89b84..f5fe7f5a0a4d 100644
--- a/lib/Kconfig.debug
+++ b/lib/Kconfig.debug
@@ -2456,6 +2456,19 @@ config PRINTF_KUNIT_TEST
 
 	  If unsure, say N.
 
+config SBITMAP_KUNIT_TEST
+	tristate "KUnit test for sbitmap" if !KUNIT_ALL_TESTS
+	depends on KUNIT
+	depends on SBITMAP
+	default KUNIT_ALL_TESTS
+	help
+	  Enable to turn on sbitmap tests, running at boot or module load time.
+
+	  For more information on KUnit and unit tests in general, please refer
+	  to the KUnit documentation in Documentation/dev-tools/kunit/.
+
+	  If unsure, say N.
+
 config SCANF_KUNIT_TEST
 	tristate "KUnit test scanf() family of functions at runtime" if !KUNIT_ALL_TESTS
 	depends on KUNIT
diff --git a/lib/tests/Makefile b/lib/tests/Makefile
index 3cac3b63a752..1f49555f94c3 100644
--- a/lib/tests/Makefile
+++ b/lib/tests/Makefile
@@ -44,6 +44,7 @@ obj-$(CONFIG_OVERFLOW_KUNIT_TEST) += overflow_kunit.o
 obj-$(CONFIG_PRANDOM_KUNIT_TEST) += random32_kunit.o
 obj-$(CONFIG_PRINTF_KUNIT_TEST) += printf_kunit.o
 obj-$(CONFIG_RANDSTRUCT_KUNIT_TEST) += randstruct_kunit.o
+obj-$(CONFIG_SBITMAP_KUNIT_TEST) += sbitmap_kunit.o
 obj-$(CONFIG_SCANF_KUNIT_TEST) += scanf_kunit.o
 obj-$(CONFIG_SEQ_BUF_KUNIT_TEST) += seq_buf_kunit.o
 obj-$(CONFIG_SIPHASH_KUNIT_TEST) += siphash_kunit.o
diff --git a/lib/tests/sbitmap_kunit.c b/lib/tests/sbitmap_kunit.c
new file mode 100644
index 000000000000..4f3a588d15df
--- /dev/null
+++ b/lib/tests/sbitmap_kunit.c
@@ -0,0 +1,300 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * KUnit tests for the scalable bitmap (sbitmap) implementation.
+ *
+ * sbitmap is the tag allocator used by blk-mq and the I/O schedulers built on
+ * top of it, but it has no tests.  These tests pin down the observable
+ * behaviour of the plain, synchronous parts of the API.
+ *
+ * Copyright (C) 2026 Wang Yibo <szwyb123@gmail.com>
+ */
+
+#include <linux/bitmap.h>
+#include <linux/gfp.h>
+#include <linux/sbitmap.h>
+
+#include <kunit/test.h>
+
+/*
+ * Big enough to span several words for any plausible BITS_PER_LONG, and not a
+ * power of two so that the last word is partially used.
+ */
+#define SBITMAP_TEST_DEPTH	(3 * BITS_PER_LONG + 5)
+
+static void sbitmap_test_init(struct kunit *test)
+{
+	const unsigned int depth = 97;
+	struct sbitmap sb;
+	int ret;
+
+	ret = sbitmap_init_node(&sb, depth, -1, GFP_KERNEL, NUMA_NO_NODE,
+				false, true);
+	KUNIT_ASSERT_EQ(test, ret, 0);
+	KUNIT_EXPECT_EQ(test, sb.depth, depth);
+	KUNIT_EXPECT_EQ(test, sb.shift,
+			(unsigned int)sbitmap_calculate_shift(depth));
+	KUNIT_EXPECT_EQ(test, sb.map_nr, DIV_ROUND_UP(depth, 1U << sb.shift));
+	KUNIT_EXPECT_FALSE(test, sb.round_robin);
+	KUNIT_EXPECT_NOT_NULL(test, sb.alloc_hint);
+	KUNIT_EXPECT_FALSE(test, sbitmap_any_bit_set(&sb));
+	KUNIT_EXPECT_EQ(test, sbitmap_weight(&sb), 0U);
+	sbitmap_free(&sb);
+
+	/* An explicitly requested shift is honoured. */
+	ret = sbitmap_init_node(&sb, depth, 3, GFP_KERNEL, NUMA_NO_NODE,
+				false, true);
+	KUNIT_ASSERT_EQ(test, ret, 0);
+	KUNIT_EXPECT_EQ(test, sb.shift, 3U);
+	KUNIT_EXPECT_EQ(test, sb.map_nr, DIV_ROUND_UP(depth, 1U << 3));
+	sbitmap_free(&sb);
+
+	/* BITS_PER_LONG bits per word is the largest representable granularity. */
+	ret = sbitmap_init_node(&sb, depth, ilog2(BITS_PER_LONG), GFP_KERNEL,
+				NUMA_NO_NODE, false, true);
+	KUNIT_ASSERT_EQ(test, ret, 0);
+	KUNIT_EXPECT_EQ(test, sb.shift, (unsigned int)ilog2(BITS_PER_LONG));
+	KUNIT_EXPECT_EQ(test, sb.map_nr, DIV_ROUND_UP(depth, BITS_PER_LONG));
+	sbitmap_free(&sb);
+
+	/* Anything above that cannot be represented and must be rejected. */
+	ret = sbitmap_init_node(&sb, depth, ilog2(BITS_PER_LONG) + 1,
+				GFP_KERNEL, NUMA_NO_NODE, false, true);
+	KUNIT_EXPECT_EQ(test, ret, -EINVAL);
+}
+
+static void sbitmap_test_calculate_shift(struct kunit *test)
+{
+	/* Maps too small to spread over several words keep the default. */
+	KUNIT_EXPECT_EQ(test, sbitmap_calculate_shift(0), ilog2(BITS_PER_LONG));
+	KUNIT_EXPECT_EQ(test, sbitmap_calculate_shift(1), ilog2(BITS_PER_LONG));
+	KUNIT_EXPECT_EQ(test, sbitmap_calculate_shift(3), ilog2(BITS_PER_LONG));
+
+	/* Four bits map to one bit per word. */
+	KUNIT_EXPECT_EQ(test, sbitmap_calculate_shift(4), 0);
+
+	/* The shift grows back as the depth increases. */
+	KUNIT_EXPECT_EQ(test, sbitmap_calculate_shift(4 * BITS_PER_LONG - 1),
+			ilog2(BITS_PER_LONG) - 1);
+	KUNIT_EXPECT_EQ(test, sbitmap_calculate_shift(4 * BITS_PER_LONG),
+			ilog2(BITS_PER_LONG));
+}
+
+static void sbitmap_test_get_exhaust(struct kunit *test)
+{
+	DECLARE_BITMAP(seen, SBITMAP_TEST_DEPTH) = { 0 };
+	struct sbitmap sb;
+	unsigned int i;
+	int bit;
+
+	KUNIT_ASSERT_EQ(test, sbitmap_init_node(&sb, SBITMAP_TEST_DEPTH, -1,
+						GFP_KERNEL, NUMA_NO_NODE,
+						false, true), 0);
+
+	/* Every bit is handed out exactly once, then the map is empty. */
+	for (i = 0; i < SBITMAP_TEST_DEPTH; i++) {
+		bit = sbitmap_get(&sb);
+		KUNIT_ASSERT_GE(test, bit, 0);
+		KUNIT_ASSERT_LT(test, bit, (int)SBITMAP_TEST_DEPTH);
+		KUNIT_ASSERT_FALSE(test, test_bit(bit, seen));
+		__set_bit(bit, seen);
+	}
+
+	KUNIT_EXPECT_TRUE(test, sbitmap_any_bit_set(&sb));
+	KUNIT_EXPECT_EQ(test, sbitmap_weight(&sb),
+			(unsigned int)SBITMAP_TEST_DEPTH);
+	KUNIT_EXPECT_EQ(test, sbitmap_get(&sb), -1);
+
+	sbitmap_free(&sb);
+}
+
+static void sbitmap_test_put_reuse(struct kunit *test)
+{
+	struct sbitmap sb;
+	unsigned int i;
+	int bit;
+
+	KUNIT_ASSERT_EQ(test, sbitmap_init_node(&sb, BITS_PER_LONG, -1,
+						GFP_KERNEL, NUMA_NO_NODE,
+						true, true), 0);
+
+	for (i = 0; i < BITS_PER_LONG; i++)
+		KUNIT_ASSERT_GE(test, sbitmap_get(&sb), 0);
+
+	KUNIT_EXPECT_EQ(test, sbitmap_weight(&sb), (unsigned int)BITS_PER_LONG);
+	KUNIT_EXPECT_EQ(test, sbitmap_get(&sb), -1);
+
+	/*
+	 * Freeing a single bit must make exactly that bit available again, no
+	 * matter which bit it was.
+	 */
+	for (i = 0; i < BITS_PER_LONG; i++) {
+		sbitmap_put(&sb, i);
+		KUNIT_EXPECT_EQ(test, sbitmap_weight(&sb),
+				(unsigned int)BITS_PER_LONG - 1);
+		bit = sbitmap_get(&sb);
+		KUNIT_EXPECT_EQ(test, bit, (int)i);
+		KUNIT_EXPECT_EQ(test, sbitmap_weight(&sb),
+				(unsigned int)BITS_PER_LONG);
+		KUNIT_EXPECT_EQ(test, sbitmap_get(&sb), -1);
+	}
+
+	sbitmap_free(&sb);
+}
+
+static void sbitmap_test_round_robin(struct kunit *test)
+{
+	struct sbitmap sb;
+	unsigned int i;
+	int bit, prev = -1;
+
+	KUNIT_ASSERT_EQ(test, sbitmap_init_node(&sb, SBITMAP_TEST_DEPTH, -1,
+						GFP_KERNEL, NUMA_NO_NODE,
+						true, true), 0);
+
+	/*
+	 * round_robin must hand out strictly increasing bit numbers while the
+	 * map fills up from empty.
+	 */
+	for (i = 0; i < SBITMAP_TEST_DEPTH; i++) {
+		bit = sbitmap_get(&sb);
+		KUNIT_ASSERT_GE(test, bit, 0);
+		KUNIT_ASSERT_LT(test, bit, (int)SBITMAP_TEST_DEPTH);
+		if (prev != -1)
+			KUNIT_ASSERT_GT(test, bit, prev);
+		prev = bit;
+	}
+
+	KUNIT_EXPECT_EQ(test, sbitmap_weight(&sb),
+			(unsigned int)SBITMAP_TEST_DEPTH);
+	KUNIT_EXPECT_EQ(test, sbitmap_get(&sb), -1);
+
+	sbitmap_free(&sb);
+}
+
+static void sbitmap_test_resize(struct kunit *test)
+{
+	const unsigned int depth = 4 * BITS_PER_LONG;
+	struct sbitmap sb;
+	unsigned int i;
+
+	KUNIT_ASSERT_EQ(test, sbitmap_init_node(&sb, depth, -1, GFP_KERNEL,
+						NUMA_NO_NODE, true, true), 0);
+
+	for (i = 0; i < depth; i++)
+		KUNIT_ASSERT_GE(test, sbitmap_get(&sb), 0);
+	KUNIT_EXPECT_EQ(test, sbitmap_weight(&sb), depth);
+
+	/* Shrinking hides the bits past the new depth. */
+	sbitmap_resize(&sb, depth / 2);
+	KUNIT_EXPECT_EQ(test, sb.depth, depth / 2);
+	KUNIT_EXPECT_EQ(test, sb.map_nr,
+			DIV_ROUND_UP(depth / 2, 1U << sb.shift));
+	KUNIT_EXPECT_EQ(test, sbitmap_weight(&sb), depth / 2);
+	KUNIT_EXPECT_EQ(test, sbitmap_get(&sb), -1);
+
+	/* Growing makes them visible again; they are still allocated. */
+	sbitmap_resize(&sb, depth);
+	KUNIT_EXPECT_EQ(test, sb.depth, depth);
+	KUNIT_EXPECT_EQ(test, sbitmap_weight(&sb), depth);
+	KUNIT_EXPECT_EQ(test, sbitmap_get(&sb), -1);
+
+	sbitmap_free(&sb);
+}
+
+static void sbitmap_test_set_clear_bit(struct kunit *test)
+{
+	static const unsigned int bits[] = {
+		0, 1, BITS_PER_LONG - 1, BITS_PER_LONG,
+		2 * BITS_PER_LONG + 3, SBITMAP_TEST_DEPTH - 1
+	};
+	struct sbitmap sb;
+	unsigned int i;
+
+	KUNIT_ASSERT_EQ(test, sbitmap_init_node(&sb, SBITMAP_TEST_DEPTH, -1,
+						GFP_KERNEL, NUMA_NO_NODE,
+						false, true), 0);
+
+	KUNIT_EXPECT_FALSE(test, sbitmap_any_bit_set(&sb));
+
+	for (i = 0; i < ARRAY_SIZE(bits); i++) {
+		sbitmap_set_bit(&sb, bits[i]);
+		KUNIT_EXPECT_TRUE(test, sbitmap_test_bit(&sb, bits[i]));
+	}
+	KUNIT_EXPECT_TRUE(test, sbitmap_any_bit_set(&sb));
+	KUNIT_EXPECT_EQ(test, sbitmap_weight(&sb), (unsigned int)ARRAY_SIZE(bits));
+
+	for (i = 0; i < ARRAY_SIZE(bits); i++) {
+		sbitmap_clear_bit(&sb, bits[i]);
+		KUNIT_EXPECT_FALSE(test, sbitmap_test_bit(&sb, bits[i]));
+	}
+	KUNIT_EXPECT_FALSE(test, sbitmap_any_bit_set(&sb));
+	KUNIT_EXPECT_EQ(test, sbitmap_weight(&sb), 0U);
+
+	sbitmap_free(&sb);
+}
+
+struct sbitmap_iter_ctx {
+	struct kunit *test;
+	DECLARE_BITMAP(visited, SBITMAP_TEST_DEPTH);
+	unsigned int nr_visited;
+};
+
+static bool sbitmap_iter_collect(struct sbitmap *sb, unsigned int bitnr,
+				 void *data)
+{
+	struct sbitmap_iter_ctx *ctx = data;
+
+	KUNIT_ASSERT_LT(ctx->test, bitnr, SBITMAP_TEST_DEPTH);
+	__set_bit(bitnr, ctx->visited);
+	ctx->nr_visited++;
+
+	return true;
+}
+
+static void sbitmap_test_iterate_set(struct kunit *test)
+{
+	static const unsigned int bits[] = {
+		0, 5, BITS_PER_LONG - 1, BITS_PER_LONG, 130,
+		SBITMAP_TEST_DEPTH - 1
+	};
+	struct sbitmap_iter_ctx ctx = { .test = test };
+	struct sbitmap sb;
+	unsigned int i;
+
+	KUNIT_ASSERT_EQ(test, sbitmap_init_node(&sb, SBITMAP_TEST_DEPTH, -1,
+						GFP_KERNEL, NUMA_NO_NODE,
+						false, true), 0);
+
+	for (i = 0; i < ARRAY_SIZE(bits); i++)
+		sbitmap_set_bit(&sb, bits[i]);
+
+	sbitmap_for_each_set(&sb, sbitmap_iter_collect, &ctx);
+
+	KUNIT_EXPECT_EQ(test, ctx.nr_visited, (unsigned int)ARRAY_SIZE(bits));
+	for (i = 0; i < ARRAY_SIZE(bits); i++)
+		KUNIT_EXPECT_TRUE(test, test_bit(bits[i], ctx.visited));
+
+	sbitmap_free(&sb);
+}
+
+static struct kunit_case sbitmap_test_cases[] = {
+	KUNIT_CASE(sbitmap_test_init),
+	KUNIT_CASE(sbitmap_test_calculate_shift),
+	KUNIT_CASE(sbitmap_test_get_exhaust),
+	KUNIT_CASE(sbitmap_test_put_reuse),
+	KUNIT_CASE(sbitmap_test_round_robin),
+	KUNIT_CASE(sbitmap_test_resize),
+	KUNIT_CASE(sbitmap_test_set_clear_bit),
+	KUNIT_CASE(sbitmap_test_iterate_set),
+	{}
+};
+
+static struct kunit_suite sbitmap_test_suite = {
+	.name = "sbitmap",
+	.test_cases = sbitmap_test_cases,
+};
+
+kunit_test_suite(sbitmap_test_suite);
+
+MODULE_DESCRIPTION("KUnit test for sbitmap");
+MODULE_LICENSE("GPL");

base-commit: 4056b3c9d3c92ea45955641dbafeb9b960e146ef
-- 
2.25.1

