Return-Path: <SRS0=/l1b=OF=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 06961C43441
	for <linux-block@archiver.kernel.org>; Mon, 26 Nov 2018 08:56:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 04F5A20855
	for <linux-block@archiver.kernel.org>; Mon, 26 Nov 2018 08:55:59 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 04F5A20855
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-block-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726184AbeKZTtZ (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 26 Nov 2018 14:49:25 -0500
Received: from smtpbguseast2.qq.com ([54.204.34.130]:38447 "EHLO
        smtpbguseast2.qq.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726157AbeKZTtY (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 26 Nov 2018 14:49:24 -0500
X-QQ-mid: bizesmtp2t1543222551tnhuacsk1
Received: from localhost.localdomain (unknown [210.22.22.130])
        by esmtp4.qq.com (ESMTP) with 
        id ; Mon, 26 Nov 2018 16:55:49 +0800 (CST)
X-QQ-SSF: 01400000000000F0FK50060A0000000
X-QQ-FEAT: 6dXuswn9i1UwEh4/Q6IDvFB3Z7jMpW8y2PsHBnlxBnIzuvXfqHjsBGlYTXfKz
        9yO7OIStgMhgfdQ5o1NnUgTeNKdj4ipBz8lurUSyjiWKFsgcvRp/qd161xtgOrCTY+wmEjh
        Lo+9IoveE/uxgvO1+MIFY5c2c4BcCzOt7nrjmnyz+UcSbBkMhPO24x5Gn/z5BEpCeCjQz/6
        rQTWoqsOTKpxb0TQvOrPDSg/rE53tOTqS+kymPgUWfbJpLcIxBcjFSgsFhtPyvzc+rtipVQ
        MvVQdv1aNkry3ePosmg44hV/mu6eGMWgKEGG/znvcrDLkE
X-QQ-GoodBg: 2
From:   Jackie Liu <liuyun01@kylinos.cn>
To:     ard.biesheuvel@linaro.org
Cc:     linux-arm-kernel@lists.infradead.org, linux-block@vger.kernel.org,
        Jackie Liu <liuyun01@kylinos.cn>
Subject: [PATCH] arm64: crypto: add NEON accelerated XOR implementation
Date:   Mon, 26 Nov 2018 16:55:30 +0800
Message-Id: <20181126085530.2699-1-liuyun01@kylinos.cn>
X-Mailer: git-send-email 2.19.1
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

Signed-off-by: Jackie Liu <liuyun01@kylinos.cn>
---
 arch/arm64/include/asm/xor.h   |  73 ++++++++++++++++++++
 arch/arm64/lib/Makefile        |   7 ++
 arch/arm64/lib/xor-neon-core.c | 152 +++++++++++++++++++++++++++++++++++++++++
 arch/arm64/lib/xor-neon-glue.c |  36 ++++++++++
 4 files changed, 268 insertions(+)
 create mode 100644 arch/arm64/include/asm/xor.h
 create mode 100644 arch/arm64/lib/xor-neon-core.c
 create mode 100644 arch/arm64/lib/xor-neon-glue.c

diff --git a/arch/arm64/include/asm/xor.h b/arch/arm64/include/asm/xor.h
new file mode 100644
index 0000000..31e8aaf
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
+	     unsigned long *p3)
+{
+	kernel_neon_begin();
+	xor_block_inner_neon.do_3(bytes, p1, p2, p3);
+	kernel_neon_end();
+}
+
+static void
+xor_neon_4(unsigned long bytes, unsigned long *p1, unsigned long *p2,
+	     unsigned long *p3, unsigned long *p4)
+{
+	kernel_neon_begin();
+	xor_block_inner_neon.do_4(bytes, p1, p2, p3, p4);
+	kernel_neon_end();
+}
+
+static void
+xor_neon_5(unsigned long bytes, unsigned long *p1, unsigned long *p2,
+	     unsigned long *p3, unsigned long *p4, unsigned long *p5)
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
+#endif // CONFIG_KERNEL_MODE_NEON
diff --git a/arch/arm64/lib/Makefile b/arch/arm64/lib/Makefile
index 69ff988..272cc42 100644
--- a/arch/arm64/lib/Makefile
+++ b/arch/arm64/lib/Makefile
@@ -5,6 +5,13 @@ lib-y		:= clear_user.o delay.o copy_from_user.o		\
 		   memcmp.o strcmp.o strncmp.o strlen.o strnlen.o	\
 		   strchr.o strrchr.o tishift.o
 
+ifeq ($(CONFIG_KERNEL_MODE_NEON), y)
+obj-$(CONFIG_XOR_BLOCKS)	+= xor-neon.o
+xor-neon-y			+= xor-neon-glue.o xor-neon-core.o
+CFLAGS_REMOVE_xor-neon-core.o	+= -mgeneral-regs-only
+CFLAGS_xor-neon-core.o		+= -ffreestanding
+endif
+
 # Tell the compiler to treat all general purpose registers (with the
 # exception of the IP registers, which are already handled by the caller
 # in case of a PLT) as callee-saved, which allows for efficient runtime
diff --git a/arch/arm64/lib/xor-neon-core.c b/arch/arm64/lib/xor-neon-core.c
new file mode 100644
index 0000000..b2880a2
--- /dev/null
+++ b/arch/arm64/lib/xor-neon-core.c
@@ -0,0 +1,152 @@
+/*
+ * arch/arm64/lib/xor-neon-core.c
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
+#include <arm_neon.h>
+
+void xor_arm64_neon_2(unsigned long bytes, unsigned long *p1,
+	unsigned long *p2)
+{
+	register uint64x2_t v0, v1, v2, v3;
+	long lines = bytes / (sizeof(uint64x2_t) * 4);
+
+	do {
+		/* p1 ^= p2 */
+		v0 = veorq_u64(vld1q_u64(p1 +  0), vld1q_u64(p2 +  0));
+		v1 = veorq_u64(vld1q_u64(p1 +  2), vld1q_u64(p2 +  2));
+		v2 = veorq_u64(vld1q_u64(p1 +  4), vld1q_u64(p2 +  4));
+		v3 = veorq_u64(vld1q_u64(p1 +  6), vld1q_u64(p2 +  6));
+
+		/* store */
+		vst1q_u64(p1 +  0, v0);
+		vst1q_u64(p1 +  2, v1);
+		vst1q_u64(p1 +  4, v2);
+		vst1q_u64(p1 +  6, v3);
+
+		p1 += 8;
+		p2 += 8;
+	} while (--lines > 0);
+}
+
+void xor_arm64_neon_3(unsigned long bytes, unsigned long *p1,
+	unsigned long *p2, unsigned long *p3)
+{
+	register uint64x2_t v0, v1, v2, v3;
+	long lines = bytes / (sizeof(uint64x2_t) * 4);
+
+	do {
+		/* p1 ^= p2 */
+		v0 = veorq_u64(vld1q_u64(p1 +  0), vld1q_u64(p2 +  0));
+		v1 = veorq_u64(vld1q_u64(p1 +  2), vld1q_u64(p2 +  2));
+		v2 = veorq_u64(vld1q_u64(p1 +  4), vld1q_u64(p2 +  4));
+		v3 = veorq_u64(vld1q_u64(p1 +  6), vld1q_u64(p2 +  6));
+
+		/* p1 ^= p3 */
+		v0 = veorq_u64(v0, vld1q_u64(p3 +  0));
+		v1 = veorq_u64(v1, vld1q_u64(p3 +  2));
+		v2 = veorq_u64(v2, vld1q_u64(p3 +  4));
+		v3 = veorq_u64(v3, vld1q_u64(p3 +  6));
+
+		/* store */
+		vst1q_u64(p1 +  0, v0);
+		vst1q_u64(p1 +  2, v1);
+		vst1q_u64(p1 +  4, v2);
+		vst1q_u64(p1 +  6, v3);
+
+		p1 += 8;
+		p2 += 8;
+		p3 += 8;
+	} while (--lines > 0);
+}
+
+void xor_arm64_neon_4(unsigned long bytes, unsigned long *p1,
+	unsigned long *p2, unsigned long *p3, unsigned long *p4)
+{
+	register uint64x2_t v0, v1, v2, v3;
+	long lines = bytes / (sizeof(uint64x2_t) * 4);
+
+	do {
+		/* p1 ^= p2 */
+		v0 = veorq_u64(vld1q_u64(p1 +  0), vld1q_u64(p2 +  0));
+		v1 = veorq_u64(vld1q_u64(p1 +  2), vld1q_u64(p2 +  2));
+		v2 = veorq_u64(vld1q_u64(p1 +  4), vld1q_u64(p2 +  4));
+		v3 = veorq_u64(vld1q_u64(p1 +  6), vld1q_u64(p2 +  6));
+
+		/* p1 ^= p3 */
+		v0 = veorq_u64(v0, vld1q_u64(p3 +  0));
+		v1 = veorq_u64(v1, vld1q_u64(p3 +  2));
+		v2 = veorq_u64(v2, vld1q_u64(p3 +  4));
+		v3 = veorq_u64(v3, vld1q_u64(p3 +  6));
+
+		/* p1 ^= p4 */
+		v0 = veorq_u64(v0, vld1q_u64(p4 +  0));
+		v1 = veorq_u64(v1, vld1q_u64(p4 +  2));
+		v2 = veorq_u64(v2, vld1q_u64(p4 +  4));
+		v3 = veorq_u64(v3, vld1q_u64(p4 +  6));
+
+		/* store */
+		vst1q_u64(p1 +  0, v0);
+		vst1q_u64(p1 +  2, v1);
+		vst1q_u64(p1 +  4, v2);
+		vst1q_u64(p1 +  6, v3);
+
+		p1 += 8;
+		p2 += 8;
+		p3 += 8;
+		p4 += 8;
+	} while (--lines > 0);
+}
+
+void xor_arm64_neon_5(unsigned long bytes, unsigned long *p1,
+	unsigned long *p2, unsigned long *p3,
+	unsigned long *p4, unsigned long *p5)
+{
+	register uint64x2_t v0, v1, v2, v3;
+	long lines = bytes / (sizeof(uint64x2_t) * 4);
+
+	do {
+		/* p1 ^= p2 */
+		v0 = veorq_u64(vld1q_u64(p1 +  0), vld1q_u64(p2 +  0));
+		v1 = veorq_u64(vld1q_u64(p1 +  2), vld1q_u64(p2 +  2));
+		v2 = veorq_u64(vld1q_u64(p1 +  4), vld1q_u64(p2 +  4));
+		v3 = veorq_u64(vld1q_u64(p1 +  6), vld1q_u64(p2 +  6));
+
+		/* p1 ^= p3 */
+		v0 = veorq_u64(v0, vld1q_u64(p3 +  0));
+		v1 = veorq_u64(v1, vld1q_u64(p3 +  2));
+		v2 = veorq_u64(v2, vld1q_u64(p3 +  4));
+		v3 = veorq_u64(v3, vld1q_u64(p3 +  6));
+
+		/* p1 ^= p4 */
+		v0 = veorq_u64(v0, vld1q_u64(p4 +  0));
+		v1 = veorq_u64(v1, vld1q_u64(p4 +  2));
+		v2 = veorq_u64(v2, vld1q_u64(p4 +  4));
+		v3 = veorq_u64(v3, vld1q_u64(p4 +  6));
+
+		/* p1 ^= p5 */
+		v0 = veorq_u64(v0, vld1q_u64(p5 +  0));
+		v1 = veorq_u64(v1, vld1q_u64(p5 +  2));
+		v2 = veorq_u64(v2, vld1q_u64(p5 +  4));
+		v3 = veorq_u64(v3, vld1q_u64(p5 +  6));
+
+		/* store */
+		vst1q_u64(p1 +  0, v0);
+		vst1q_u64(p1 +  2, v1);
+		vst1q_u64(p1 +  4, v2);
+		vst1q_u64(p1 +  6, v3);
+
+		p1 += 8;
+		p2 += 8;
+		p3 += 8;
+		p4 += 8;
+		p5 += 8;
+	} while (--lines > 0);
+}
diff --git a/arch/arm64/lib/xor-neon-glue.c b/arch/arm64/lib/xor-neon-glue.c
new file mode 100644
index 0000000..fdaac8b
--- /dev/null
+++ b/arch/arm64/lib/xor-neon-glue.c
@@ -0,0 +1,36 @@
+/*
+ * arch/arm64/lib/xor-neon-glue.c
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
+
+void xor_arm64_neon_2(unsigned long bytes, unsigned long *p1,
+			     unsigned long *p2);
+void xor_arm64_neon_3(unsigned long bytes, unsigned long *p1,
+			     unsigned long *p2, unsigned long *p3);
+void xor_arm64_neon_4(unsigned long bytes, unsigned long *p1,
+			     unsigned long *p2, unsigned long *p3,
+			     unsigned long *p4);
+void xor_arm64_neon_5(unsigned long bytes, unsigned long *p1,
+			     unsigned long *p2, unsigned long *p3,
+			     unsigned long *p4, unsigned long *p5);
+
+struct xor_block_template const xor_block_inner_neon = {
+	.name	= "__inner_neon__",
+	.do_2	= xor_arm64_neon_2,
+	.do_3	= xor_arm64_neon_3,
+	.do_4	= xor_arm64_neon_4,
+	.do_5	= xor_arm64_neon_5,
+};
+EXPORT_SYMBOL_GPL(xor_block_inner_neon);
+
+MODULE_LICENSE("GPL");
+MODULE_AUTHOR("Jackie Liu <liuyun01@kylinos.cn>");
-- 
2.7.4



