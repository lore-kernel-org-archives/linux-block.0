Return-Path: <SRS0=Byed=OG=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6E3DBC43441
	for <linux-block@archiver.kernel.org>; Tue, 27 Nov 2018 12:38:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2C0092082F
	for <linux-block@archiver.kernel.org>; Tue, 27 Nov 2018 12:38:26 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2C0092082F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-block-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726544AbeK0XgN (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 27 Nov 2018 18:36:13 -0500
Received: from smtpbg65.qq.com ([103.7.28.233]:10126 "EHLO smtpbg65.qq.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726447AbeK0XgN (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Tue, 27 Nov 2018 18:36:13 -0500
X-QQ-mid: bizesmtp20t1543322299tj8zs8w3
Received: from Macbook.pro (unknown [210.22.22.130])
        by esmtp6.qq.com (ESMTP) with 
        id ; Tue, 27 Nov 2018 20:38:18 +0800 (CST)
X-QQ-SSF: 01400000002000F0FL51000C0000000
X-QQ-FEAT: OzlK1zzUgMFw2Yc325Me/Ybd1B/+KqkIddn+qWSxTUn35N7u6pkbVqo3ZmI1V
        fLh5oI6n063vxClEPvR+OWcSV0AzjKO/6QGMr20PQBnBYtUonT6oxXC0f8fUYffRgJXGoGt
        +rgkCQHdTrhHAMwPcJ4Cf320tTuTEsodSws8Yu1FmFSVWfGK6HJZWxHNP4RPK25eY1Dgxzf
        nCqxXPuIiRQLjoXVd/g04ysGAnzaZfah5s71U+f5iMViyd7jlhGxVDzBitdSMdC5fNnPHuI
        W+qJT7Iv4+gxNcJyTScJIVBhL++D8oPj4t8G5hdLnxcoFgCBOyX/4e/qY=
X-QQ-GoodBg: 2
From:   Jackie Liu <liuyun01@kylinos.cn>
To:     ard.biesheuvel@linaro.org
Cc:     linux-arm-kernel@lists.infradead.org, linux-block@vger.kernel.org,
        Jackie Liu <liuyun01@kylinos.cn>
Subject: [PATCH v4 1/1] arm64/neon: add workaround for ambiguous C99 stdint.h types
Date:   Tue, 27 Nov 2018 20:38:13 +0800
Message-Id: <20181127123813.7523-1-liuyun01@kylinos.cn>
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
 arch/arm64/include/asm/neon-intrinsics.h | 35 ++++++++++++++++++++++++++++++++
 1 file changed, 35 insertions(+)
 create mode 100644 arch/arm64/include/asm/neon-intrinsics.h

diff --git a/arch/arm64/include/asm/neon-intrinsics.h b/arch/arm64/include/asm/neon-intrinsics.h
new file mode 100644
index 0000000..145d8ea
--- /dev/null
+++ b/arch/arm64/include/asm/neon-intrinsics.h
@@ -0,0 +1,35 @@
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
+ * don't export anything
+ * it defines anyway, so just disregard when genksyms execute.
+ */
+#ifndef __GENKSYMS__
+#include <arm_neon.h>
+#endif
+
+#endif /* ! _NEON_INTRINSICS_H */
-- 
2.7.4



