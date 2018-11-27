Return-Path: <SRS0=Byed=OG=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9A6D8C43610
	for <linux-block@archiver.kernel.org>; Tue, 27 Nov 2018 10:10:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 62D552086B
	for <linux-block@archiver.kernel.org>; Tue, 27 Nov 2018 10:10:56 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 62D552086B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-block-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726825AbeK0VIT (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 27 Nov 2018 16:08:19 -0500
Received: from smtpbgsg2.qq.com ([54.254.200.128]:35540 "EHLO smtpbgsg2.qq.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730295AbeK0VIT (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Tue, 27 Nov 2018 16:08:19 -0500
X-QQ-mid: bizesmtp17t1543313448twlolvpn
Received: from Macbook.pro (unknown [210.22.22.130])
        by esmtp6.qq.com (ESMTP) with 
        id ; Tue, 27 Nov 2018 18:10:47 +0800 (CST)
X-QQ-SSF: 01400000002000F0FK51000C0000000
X-QQ-FEAT: zHL+Ilok97829/pMjgODj9GV1mmFSTVJN1XOaAfrCoRCgzWrJxFCt20rBcAh4
        jJl3No2Nsz/4c/8pFhmL6BNbkFNNxR4MC5BgArRx+J7oeLcMPbu0cruHwutfu2QmRza5+iB
        baHxtHiUXVC8MJy9Vu05yzWhiLjqHWpZpKRZg89nkoF5K+3/LcQRyQE/JHFNuK2+XQeFzOy
        tZ7JcMYCCMwqxPqiSG8mxUxcS4pmGugvYsKPcTyMgxlTrhHlvlo4c8t0JCut74cuKe88GHF
        wNRdjet2cUm0TkSrFh1/fqT9Zy7LuVXj8ze2FFYizRjb/XyI/7MnjoUq0=
X-QQ-GoodBg: 2
From:   Jackie Liu <liuyun01@kylinos.cn>
To:     ard.biesheuvel@linaro.org
Cc:     linux-arm-kernel@lists.infradead.org, linux-block@vger.kernel.org,
        Jackie Liu <liuyun01@kylinos.cn>
Subject: [PATCH v3 1/2] arm64/neon: add workaround for ambiguous C99 stdint.h types
Date:   Tue, 27 Nov 2018 18:08:57 +0800
Message-Id: <20181127100858.6995-1-liuyun01@kylinos.cn>
X-Mailer: git-send-email 2.19.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: bizesmtp:kylinos.cn:qybgforeign:qybgforeign2
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
---
 arch/arm64/include/asm/neon-intrinsics.h | 28 ++++++++++++++++++++++++++++
 1 file changed, 28 insertions(+)
 create mode 100644 arch/arm64/include/asm/neon-intrinsics.h

diff --git a/arch/arm64/include/asm/neon-intrinsics.h b/arch/arm64/include/asm/neon-intrinsics.h
new file mode 100644
index 0000000..96a3fda
--- /dev/null
+++ b/arch/arm64/include/asm/neon-intrinsics.h
@@ -0,0 +1,28 @@
+#ifndef _NEON_INTRINSICS_H
+#define _NEON_INTRINSICS_H
+
+#include <asm-generic/int-ll64.h>
+
+/*
+ * For Aarch64, there is some ambiguity in the definition of the types below
+ * between the kernel and GCC itself. This is usually not a big deal, but it
+ * causes trouble when including GCC's version of 'stdint.h' (this is the file
+ * that gets included when you #include <stdint.h> on a -ffreestanding build).
+ * As this file also gets included implicitly when including 'arm_neon.h' (the
+ * NEON intrinsics support header), we need the following to work around the
+ * issue if we want to use NEON intrinsics in the kernel.
+ */
+
+#ifdef __INT64_TYPE__
+#undef __INT64_TYPE__
+#define __INT64_TYPE__		__signed__ long long
+#endif
+
+#ifdef __UINT64_TYPE__
+#undef __UINT64_TYPE__
+#define __UINT64_TYPE__		unsigned long long
+#endif
+
+#include <arm_neon.h>
+
+#endif /* ! _NEON_INTRINSICS_H */
-- 
2.7.4




