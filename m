Return-Path: <SRS0=FxMo=OH=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 11CA8C43441
	for <linux-block@archiver.kernel.org>; Wed, 28 Nov 2018 01:09:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9F1C120851
	for <linux-block@archiver.kernel.org>; Wed, 28 Nov 2018 01:09:22 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9F1C120851
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-block-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726911AbeK1MJG (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 28 Nov 2018 07:09:06 -0500
Received: from smtpbg297.qq.com ([184.105.67.100]:35042 "EHLO
        smtpproxy21.qq.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726847AbeK1MJG (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 28 Nov 2018 07:09:06 -0500
X-Greylist: delayed 45174 seconds by postgrey-1.27 at vger.kernel.org; Wed, 28 Nov 2018 07:09:05 EST
X-QQ-mid: bizesmtp8t1543367355tgvxus88b
Received: from Macbook.pro (unknown [210.22.22.130])
        by esmtp4.qq.com (ESMTP) with 
        id ; Wed, 28 Nov 2018 09:09:13 +0800 (CST)
X-QQ-SSF: 01400000003000F0FL51B00A0000000
X-QQ-FEAT: 3jlOKZxptE4gd32+kEFfbNQ3B+mJfg/5O0Fd1TQWBW0rwEHrxn7IO0P22MH2q
        aYwfx9i6wP3pB/i0/q8oUsSekQNpXcwAalqK0Q1v3qlQ94ymOvS1gb6VV86h88X6Ag/lLE3
        WzLMgN7I3LNnI/Gql5vH6h0tTpExyOfi36RdtGZc2uUM8bZvfnPnOIP5+UtW7H6tTwwWmsS
        uFi4A/i56ez3lja6BmU+USE7flDJgsKxtVa/uOouKEWLlXus4zOFu97Ba/cMA+/cBROvo6R
        8bhv7HgvaWGk+Y/J6iCpf11jUkdQWJgeGDqw==
X-QQ-GoodBg: 2
From:   Jackie Liu <liuyun01@kylinos.cn>
To:     will.deacon@arm.com
Cc:     catalin.marinas@arm.com, ard.biesheuvel@linaro.org,
        linux-arm-kernel@lists.infradead.org, linux-block@vger.kernel.org,
        Jackie Liu <liuyun01@kylinos.cn>
Subject: [PATCH v5 1/2] arm64/neon: add workaround for ambiguous C99 stdint.h types
Date:   Wed, 28 Nov 2018 09:09:00 +0800
Message-Id: <20181128010901.1052-1-liuyun01@kylinos.cn>
X-Mailer: git-send-email 2.19.1
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

Reviewed-by: Ard Biesheuvel <ard.biesheuvel@linaro.org>
Signed-off-by: Jackie Liu <liuyun01@kylinos.cn>
---
 arch/arm64/include/asm/neon-intrinsics.h | 34 ++++++++++++++++++++++++++++++++
 1 file changed, 34 insertions(+)
 create mode 100644 arch/arm64/include/asm/neon-intrinsics.h

diff --git a/arch/arm64/include/asm/neon-intrinsics.h b/arch/arm64/include/asm/neon-intrinsics.h
new file mode 100644
index 0000000..e378766
--- /dev/null
+++ b/arch/arm64/include/asm/neon-intrinsics.h
@@ -0,0 +1,34 @@
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
+/*
+ * genksyms chokes on the ARM NEON instrinsics system header, but we
+ * don't export anything it defines anyway, so just disregard when genksyms execute.
+ */
+#ifndef __GENKSYMS__
+#include <arm_neon.h>
+#endif
+
+#endif /* ! _NEON_INTRINSICS_H */
-- 
2.7.4



