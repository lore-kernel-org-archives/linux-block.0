Return-Path: <SRS0=Byed=OG=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E9399C43441
	for <linux-block@archiver.kernel.org>; Tue, 27 Nov 2018 10:10:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9BFB62086B
	for <linux-block@archiver.kernel.org>; Tue, 27 Nov 2018 10:10:54 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9BFB62086B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-block-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730376AbeK0VIR (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 27 Nov 2018 16:08:17 -0500
Received: from smtpbg202.qq.com ([184.105.206.29]:34492 "EHLO smtpbg202.qq.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726600AbeK0VIQ (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Tue, 27 Nov 2018 16:08:16 -0500
X-QQ-mid: bizesmtp17t1543313450tjca36zx
Received: from Macbook.pro (unknown [210.22.22.130])
        by esmtp6.qq.com (ESMTP) with 
        id ; Tue, 27 Nov 2018 18:10:50 +0800 (CST)
X-QQ-SSF: 01400000002000F0FK51000C0000000
X-QQ-FEAT: 6dXuswn9i1WW8qmZsE6/xNlOIRRi2ME1hoDWU0H5LoUgssiQ/TbxQWzFajLj0
        32V8CSn/Oj9tj+Mnhue3AUaC4FsnHM4w3g/31GwAyWxi9VlZxJYXd/iqqzXza4So9NhIWa7
        VGI70iaJS2bQEbPchIbiTqUesja5FAXx4p1v3oEL6qx/c7d5Xv/XGTLw54AWIlyph7eTsfj
        Wy3B9Gf/nZJArZ0+H5NM0UtVOqI1yXcZGU4cswWOjAF+91QiFCEcG20nQizCdVDwyTtbwWE
        s6hK3PS502viKtwcU5Yrnmo1YYT410rGAEOWWBQ7AjfxJH
X-QQ-GoodBg: 2
From:   Jackie Liu <liuyun01@kylinos.cn>
To:     ard.biesheuvel@linaro.org
Cc:     linux-arm-kernel@lists.infradead.org, linux-block@vger.kernel.org,
        Jackie Liu <liuyun01@kylinos.cn>
Subject: [PATCH v3 2/2] arm64: crypto: add NEON accelerated XOR implementation
Date:   Tue, 27 Nov 2018 18:08:58 +0800
Message-Id: <20181127100858.6995-2-liuyun01@kylinos.cn>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20181127100858.6995-1-liuyun01@kylinos.cn>
References: <20181127100858.6995-1-liuyun01@kylinos.cn>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: bizesmtp:kylinos.cn:qybgforeign:qybgforeign1
X-QQ-Bgrelay: 1
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

This is a NEON acceleration method that can improve
performance by approximately 20%. I got the following
data from the centos 7.5 on Huawei's HISI1616 chip:

[ 93.837726] xor: measuring software checksum speed
[ 93.874039]   8regs  : 7123.200 MB/sec
[ 93.914038]   32regs : 7180.300 MB/sec
[ 93.954043]   arm64_neon: 9856.000 MB/sec
[ 93.954047] xor: using function: arm64_neon (9856.000 MB/sec)

I believe this code can bring some optimization for
all arm64 platform.

That is patch version 3. Thanks for Ard Biesheuvel's
suggestions.

Signed-off-by: Jackie Liu <liuyun01@kylinos.cn>
---
 arch/arm64/include/asm/Kbuild |   1 -
 arch/arm64/include/asm/xor.h  |  73 +++++++++++++++++
 arch/arm64/lib/Makefile       |   6 ++
 arch/arm64/lib/xor-neon.c     | 184 ++++++++++++++++++++++++++++++++++++++++++
 4 files changed, 263 insertions(+), 1 deletion(-)
 create mode 100644 arch/arm64/include/asm/xor.h
 create mode 100644 arch/arm64/lib/xor-neon.c

diff --git a/arch/arm64/include/asm/Kbuild b/arch/arm64/include/asm/Kbuild
index 6cd5d77..1877f29 100644
--- a/arch/arm64/include/asm/Kbuild
+++ b/arch/arm64/include/asm/Kbuild
@@ -27,4 +27,3 @@ generic-y += trace_clock.h
 generic-y += unaligned.h
 generic-y += user.h
 generic-y += vga.h
-generic-y += xor.h
diff --git a/arch/arm64/include/asm/xor.h b/arch/arm64/include/asm/xor.h
new file mode 100644
index 0000000..856386a
--- /dev/null
+++ b/arch/arm64/include/asm/xor.h
@@ -0,0 +1,73 @@
+/*
+ * arch/arm64/include/asm/xor.h
+ *
+ * Authors: Jackie Liu <liuyun01@kylinos.cn>
+ * Copyright (C) 2018,Tianjin KYLIN Information Technology Co., Ltd.
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ */
+
+#include <linux/hardirq.h>
+#include <asm-generic/xor.h>
+#include <asm/hwcap.h>
+#include <asm/neon.h>
+
+#ifdef CONFIG_KERNEL_MODE_NEON
+
+extern struct xor_block_template const xor_block_inner_neon;
+
+static void
+xor_neon_2(unsigned long bytes, unsigned long *p1, unsigned long *p2)
+{
+	kernel_neon_begin();
+	xor_block_inner_neon.do_2(bytes, p1, p2);
+	kernel_neon_end();
+}
+
+static void
+xor_neon_3(unsigned long bytes, unsigned long *p1, unsigned long *p2,
+		unsigned long *p3)
+{
+	kernel_neon_begin();
+	xor_block_inner_neon.do_3(bytes, p1, p2, p3);
+	kernel_neon_end();
+}
+
+static void
+xor_neon_4(unsigned long bytes, unsigned long *p1, unsigned long *p2,
+		unsigned long *p3, unsigned long *p4)
+{
+	kernel_neon_begin();
+	xor_block_inner_neon.do_4(bytes, p1, p2, p3, p4);
+	kernel_neon_end();
+}
+
+static void
+xor_neon_5(unsigned long bytes, unsigned long *p1, unsigned long *p2,
+		unsigned long *p3, unsigned long *p4, unsigned long *p5)
+{
+	kernel_neon_begin();
+	xor_block_inner_neon.do_5(bytes, p1, p2, p3, p4, p5);
+	kernel_neon_end();
+}
+
+static struct xor_block_template xor_block_arm64 = {
+	.name   = "arm64_neon",
+	.do_2   = xor_neon_2,
+	.do_3   = xor_neon_3,
+	.do_4   = xor_neon_4,
+	.do_5	= xor_neon_5
+};
+#undef XOR_TRY_TEMPLATES
+#define XOR_TRY_TEMPLATES           \
+	do {        \
+		xor_speed(&xor_block_8regs);    \
+		xor_speed(&xor_block_32regs);    \
+		if (cpu_has_neon()) { \
+			xor_speed(&xor_block_arm64);\
+		} \
+	} while (0)
+
+#endif /* ! CONFIG_KERNEL_MODE_NEON */
diff --git a/arch/arm64/lib/Makefile b/arch/arm64/lib/Makefile
index 69ff988..5540a16 100644
--- a/arch/arm64/lib/Makefile
+++ b/arch/arm64/lib/Makefile
@@ -5,6 +5,12 @@ lib-y		:= clear_user.o delay.o copy_from_user.o		\
 		   memcmp.o strcmp.o strncmp.o strlen.o strnlen.o	\
 		   strchr.o strrchr.o tishift.o
 
+ifeq ($(CONFIG_KERNEL_MODE_NEON), y)
+obj-$(CONFIG_XOR_BLOCKS)	+= xor-neon.o
+CFLAGS_REMOVE_xor-neon.o	+= -mgeneral-regs-only
+CFLAGS_xor-neon.o		+= -ffreestanding
+endif
+
 # Tell the compiler to treat all general purpose registers (with the
 # exception of the IP registers, which are already handled by the caller
 # in case of a PLT) as callee-saved, which allows for efficient runtime
diff --git a/arch/arm64/lib/xor-neon.c b/arch/arm64/lib/xor-neon.c
new file mode 100644
index 0000000..131c60c2
--- /dev/null
+++ b/arch/arm64/lib/xor-neon.c
@@ -0,0 +1,184 @@
+/*
+ * arch/arm64/lib/xor-neon.c
+ *
+ * Authors: Jackie Liu <liuyun01@kylinos.cn>
+ * Copyright (C) 2018,Tianjin KYLIN Information Technology Co., Ltd.
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ */
+
+#include <linux/raid/xor.h>
+#include <linux/module.h>
+#include <asm/neon-intrinsics.h>
+
+void xor_arm64_neon_2(unsigned long bytes, unsigned long *p1,
+	unsigned long *p2)
+{
+	uint64_t *dp1 = (uint64_t *)p1;
+	uint64_t *dp2 = (uint64_t *)p2;
+
+	register uint64x2_t v0, v1, v2, v3;
+	long lines = bytes / (sizeof(uint64x2_t) * 4);
+
+	do {
+		/* p1 ^= p2 */
+		v0 = veorq_u64(vld1q_u64(dp1 +  0), vld1q_u64(dp2 +  0));
+		v1 = veorq_u64(vld1q_u64(dp1 +  2), vld1q_u64(dp2 +  2));
+		v2 = veorq_u64(vld1q_u64(dp1 +  4), vld1q_u64(dp2 +  4));
+		v3 = veorq_u64(vld1q_u64(dp1 +  6), vld1q_u64(dp2 +  6));
+
+		/* store */
+		vst1q_u64(dp1 +  0, v0);
+		vst1q_u64(dp1 +  2, v1);
+		vst1q_u64(dp1 +  4, v2);
+		vst1q_u64(dp1 +  6, v3);
+
+		dp1 += 8;
+		dp2 += 8;
+	} while (--lines > 0);
+}
+
+void xor_arm64_neon_3(unsigned long bytes, unsigned long *p1,
+	unsigned long *p2, unsigned long *p3)
+{
+	uint64_t *dp1 = (uint64_t *)p1;
+	uint64_t *dp2 = (uint64_t *)p2;
+	uint64_t *dp3 = (uint64_t *)p3;
+
+	register uint64x2_t v0, v1, v2, v3;
+	long lines = bytes / (sizeof(uint64x2_t) * 4);
+
+	do {
+		/* p1 ^= p2 */
+		v0 = veorq_u64(vld1q_u64(dp1 +  0), vld1q_u64(dp2 +  0));
+		v1 = veorq_u64(vld1q_u64(dp1 +  2), vld1q_u64(dp2 +  2));
+		v2 = veorq_u64(vld1q_u64(dp1 +  4), vld1q_u64(dp2 +  4));
+		v3 = veorq_u64(vld1q_u64(dp1 +  6), vld1q_u64(dp2 +  6));
+
+		/* p1 ^= p3 */
+		v0 = veorq_u64(v0, vld1q_u64(dp3 +  0));
+		v1 = veorq_u64(v1, vld1q_u64(dp3 +  2));
+		v2 = veorq_u64(v2, vld1q_u64(dp3 +  4));
+		v3 = veorq_u64(v3, vld1q_u64(dp3 +  6));
+
+		/* store */
+		vst1q_u64(dp1 +  0, v0);
+		vst1q_u64(dp1 +  2, v1);
+		vst1q_u64(dp1 +  4, v2);
+		vst1q_u64(dp1 +  6, v3);
+
+		dp1 += 8;
+		dp2 += 8;
+		dp3 += 8;
+	} while (--lines > 0);
+}
+
+void xor_arm64_neon_4(unsigned long bytes, unsigned long *p1,
+	unsigned long *p2, unsigned long *p3, unsigned long *p4)
+{
+	uint64_t *dp1 = (uint64_t *)p1;
+	uint64_t *dp2 = (uint64_t *)p2;
+	uint64_t *dp3 = (uint64_t *)p3;
+	uint64_t *dp4 = (uint64_t *)p4;
+
+	register uint64x2_t v0, v1, v2, v3;
+	long lines = bytes / (sizeof(uint64x2_t) * 4);
+
+	do {
+		/* p1 ^= p2 */
+		v0 = veorq_u64(vld1q_u64(dp1 +  0), vld1q_u64(dp2 +  0));
+		v1 = veorq_u64(vld1q_u64(dp1 +  2), vld1q_u64(dp2 +  2));
+		v2 = veorq_u64(vld1q_u64(dp1 +  4), vld1q_u64(dp2 +  4));
+		v3 = veorq_u64(vld1q_u64(dp1 +  6), vld1q_u64(dp2 +  6));
+
+		/* p1 ^= p3 */
+		v0 = veorq_u64(v0, vld1q_u64(dp3 +  0));
+		v1 = veorq_u64(v1, vld1q_u64(dp3 +  2));
+		v2 = veorq_u64(v2, vld1q_u64(dp3 +  4));
+		v3 = veorq_u64(v3, vld1q_u64(dp3 +  6));
+
+		/* p1 ^= p4 */
+		v0 = veorq_u64(v0, vld1q_u64(dp4 +  0));
+		v1 = veorq_u64(v1, vld1q_u64(dp4 +  2));
+		v2 = veorq_u64(v2, vld1q_u64(dp4 +  4));
+		v3 = veorq_u64(v3, vld1q_u64(dp4 +  6));
+
+		/* store */
+		vst1q_u64(dp1 +  0, v0);
+		vst1q_u64(dp1 +  2, v1);
+		vst1q_u64(dp1 +  4, v2);
+		vst1q_u64(dp1 +  6, v3);
+
+		dp1 += 8;
+		dp2 += 8;
+		dp3 += 8;
+		dp4 += 8;
+	} while (--lines > 0);
+}
+
+void xor_arm64_neon_5(unsigned long bytes, unsigned long *p1,
+	unsigned long *p2, unsigned long *p3,
+	unsigned long *p4, unsigned long *p5)
+{
+	uint64_t *dp1 = (uint64_t *)p1;
+	uint64_t *dp2 = (uint64_t *)p2;
+	uint64_t *dp3 = (uint64_t *)p3;
+	uint64_t *dp4 = (uint64_t *)p4;
+	uint64_t *dp5 = (uint64_t *)p5;
+
+	register uint64x2_t v0, v1, v2, v3;
+	long lines = bytes / (sizeof(uint64x2_t) * 4);
+
+	do {
+		/* p1 ^= p2 */
+		v0 = veorq_u64(vld1q_u64(dp1 +  0), vld1q_u64(dp2 +  0));
+		v1 = veorq_u64(vld1q_u64(dp1 +  2), vld1q_u64(dp2 +  2));
+		v2 = veorq_u64(vld1q_u64(dp1 +  4), vld1q_u64(dp2 +  4));
+		v3 = veorq_u64(vld1q_u64(dp1 +  6), vld1q_u64(dp2 +  6));
+
+		/* p1 ^= p3 */
+		v0 = veorq_u64(v0, vld1q_u64(dp3 +  0));
+		v1 = veorq_u64(v1, vld1q_u64(dp3 +  2));
+		v2 = veorq_u64(v2, vld1q_u64(dp3 +  4));
+		v3 = veorq_u64(v3, vld1q_u64(dp3 +  6));
+
+		/* p1 ^= p4 */
+		v0 = veorq_u64(v0, vld1q_u64(dp4 +  0));
+		v1 = veorq_u64(v1, vld1q_u64(dp4 +  2));
+		v2 = veorq_u64(v2, vld1q_u64(dp4 +  4));
+		v3 = veorq_u64(v3, vld1q_u64(dp4 +  6));
+
+		/* p1 ^= p5 */
+		v0 = veorq_u64(v0, vld1q_u64(dp5 +  0));
+		v1 = veorq_u64(v1, vld1q_u64(dp5 +  2));
+		v2 = veorq_u64(v2, vld1q_u64(dp5 +  4));
+		v3 = veorq_u64(v3, vld1q_u64(dp5 +  6));
+
+		/* store */
+		vst1q_u64(dp1 +  0, v0);
+		vst1q_u64(dp1 +  2, v1);
+		vst1q_u64(dp1 +  4, v2);
+		vst1q_u64(dp1 +  6, v3);
+
+		dp1 += 8;
+		dp2 += 8;
+		dp3 += 8;
+		dp4 += 8;
+		dp5 += 8;
+	} while (--lines > 0);
+}
+
+struct xor_block_template const xor_block_inner_neon = {
+	.name	= "__inner_neon__",
+	.do_2	= xor_arm64_neon_2,
+	.do_3	= xor_arm64_neon_3,
+	.do_4	= xor_arm64_neon_4,
+	.do_5	= xor_arm64_neon_5,
+};
+EXPORT_SYMBOL(xor_block_inner_neon);
+
+MODULE_AUTHOR("Jackie Liu <liuyun01@kylinos.cn>");
+MODULE_DESCRIPTION("ARMv8 XOR Extensions");
+MODULE_LICENSE("GPL");
-- 
2.7.4



