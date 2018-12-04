Return-Path: <SRS0=ovnK=ON=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 31115C04EB9
	for <linux-block@archiver.kernel.org>; Tue,  4 Dec 2018 01:43:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BCE052146D
	for <linux-block@archiver.kernel.org>; Tue,  4 Dec 2018 01:43:48 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BCE052146D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-block-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725994AbeLDBns (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 3 Dec 2018 20:43:48 -0500
Received: from smtpproxy19.qq.com ([184.105.206.84]:48143 "EHLO
        smtpproxy19.qq.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725968AbeLDBns (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Mon, 3 Dec 2018 20:43:48 -0500
X-QQ-mid: bizesmtp20t1543887823tk2oxihg
Received: from Macbook.pro (unknown [210.22.22.130])
        by esmtp6.qq.com (ESMTP) with 
        id ; Tue, 04 Dec 2018 09:43:42 +0800 (CST)
X-QQ-SSF: 01400000002000F0FL51B00A0000000
X-QQ-FEAT: MQWYnVJPtOMIb5enrEdkcxRuHu0OK8WLjGi9cNdQVPUHGdSTslmfD789KXpcd
        sdww2lhew9KGk2uEcjhXQiQDKWNu31vJeEi7ayt01kR/Eil7cQKfZrmePOklbtPrnbw9Vb5
        G5dOAbbOCRCczm4JRgPhGiuK3ct2d6tMBwW99mSYsto9bZd2QBwxhGPAS4DuR+YPVE0v4rW
        zZHZowxkheuZ676ouAXacyyvcxSSKlwkz/3qGIfOoP2pzuiShG71n5CxF8hq53khP/ZlNV4
        SXnvGcxXNKVdSyFFq5ZPgglxw68lofkPrnWfL/4cgaljBN
X-QQ-GoodBg: 2
From:   Jackie Liu <liuyun01@kylinos.cn>
To:     will.deacon@arm.com
Cc:     ard.biesheuvel@linaro.org, catalin.marinas@arm.com,
        linux-arm-kernel@lists.infradead.org, linux-block@vger.kernel.org,
        Jackie Liu <liuyun01@kylinos.cn>
Subject: [PATCH v6 1/2] arm64/neon: add workaround for ambiguous C99 stdint.h types
Date:   Tue,  4 Dec 2018 09:43:22 +0800
Message-Id: <20181204014323.1438-2-liuyun01@kylinos.cn>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20181204014323.1438-1-liuyun01@kylinos.cn>
References: <20181204014323.1438-1-liuyun01@kylinos.cn>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: bizesmtp:kylinos.cn:qybgforeign:qybgforeign4
X-QQ-Bgrelay: 1
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

In a way similar to ARM commit 09096f6a0ee2 ("ARM: 7822/1: add workaround
for ambiguous C99 stdint.h types"), this patch redefines the macros that
are used in stdint.h so its definitions of uint64_t and int64_t are
compatible with those of the kernel.

This patch comes from: https://patchwork.kernel.org/patch/3540001/
Wrote by: Ard Biesheuvel <ard.biesheuvel@linaro.org>

We mark this file as a private file and don't have to override asm/types.h

Signed-off-by: Jackie Liu <liuyun01@kylinos.cn>
Reviewed-by: Ard Biesheuvel <ard.biesheuvel@linaro.org>
---
 arch/arm64/include/asm/neon-intrinsics.h | 39 ++++++++++++++++++++++++++++++++
 1 file changed, 39 insertions(+)
 create mode 100644 arch/arm64/include/asm/neon-intrinsics.h

diff --git a/arch/arm64/include/asm/neon-intrinsics.h b/arch/arm64/include/asm/neon-intrinsics.h
new file mode 100644
index 0000000..2ba6c6b
--- /dev/null
+++ b/arch/arm64/include/asm/neon-intrinsics.h
@@ -0,0 +1,39 @@
+/*
+ * Copyright (C) 2018 Linaro, Ltd. <ard.biesheuvel@linaro.org>
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ */
+
+#ifndef __ASM_NEON_INTRINSICS_H
+#define __ASM_NEON_INTRINSICS_H
+
+#include <asm-generic/int-ll64.h>
+
+/*
+ * In the kernel, u64/s64 are [un]signed long long, not [un]signed long.
+ * So by redefining these macros to the former, we can force gcc-stdint.h
+ * to define uint64_t / in64_t in a compatible manner.
+ */
+
+#ifdef __INT64_TYPE__
+#undef __INT64_TYPE__
+#define __INT64_TYPE__		long long
+#endif
+
+#ifdef __UINT64_TYPE__
+#undef __UINT64_TYPE__
+#define __UINT64_TYPE__		unsigned long long
+#endif
+
+/*
+ * genksyms chokes on the ARM NEON instrinsics system header, but we
+ * don't export anything it defines anyway, so just disregard when
+ * genksyms execute.
+ */
+#ifndef __GENKSYMS__
+#include <arm_neon.h>
+#endif
+
+#endif /* __ASM_NEON_INTRINSICS_H */
-- 
2.7.4



