Return-Path: <SRS0=Byed=OG=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 747CCC43441
	for <linux-block@archiver.kernel.org>; Tue, 27 Nov 2018 05:28:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3420B208E4
	for <linux-block@archiver.kernel.org>; Tue, 27 Nov 2018 05:28:08 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3420B208E4
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-block-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728218AbeK0QYr (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 27 Nov 2018 11:24:47 -0500
Received: from smtpproxy19.qq.com ([184.105.206.84]:38742 "EHLO
        smtpproxy19.qq.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728129AbeK0QYr (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 27 Nov 2018 11:24:47 -0500
X-QQ-mid: bizesmtp10t1543296478t8y753l2
Received: from localhost.localdomain (unknown [210.22.22.130])
        by esmtp10.qq.com (ESMTP) with 
        id ; Tue, 27 Nov 2018 13:27:58 +0800 (CST)
X-QQ-SSF: 01400000002000F0FK51B00A0000000
X-QQ-FEAT: GeavupMxF+G2EryvIcu58sKdO+f6vj5ruvStboIeCPaFsOeSdv7QB1B+Y9Gn3
        VRm5c6++7oJBGx/IyWDeg4fxCIjogKWolKbG3Twfy+wXNm2W1/JXg/vjtEOLDvw8zoL0Pqp
        RhUD7APd9yXJmfJWD3l5P2hLuva37CcAT+1JyPuf59cLkPzir1ZJq1gJJQVm/6YSrzrHwo4
        SOJn4y1vsHpSsA+Dicxe12KGtzzibxXoyrDGVKaom13nIecacdPf6RmeNIdIjGhDN1mRpKh
        1/KJcrjqE66xO9VBLFhzEnBPQQc+IIKDrRG9bJxq73k8MY
X-QQ-GoodBg: 2
From:   Jackie Liu <liuyun01@kylinos.cn>
To:     ard.biesheuvel@linaro.org
Cc:     linux-arm-kernel@lists.infradead.org, linux-block@vger.kernel.org,
        Jackie Liu <liuyun01@kylinos.cn>
Subject: [PATCH v2 1/2] arm64: add workaround for ambiguous C99 stdint.h types
Date:   Tue, 27 Nov 2018 13:27:00 +0800
Message-Id: <20181127052701.4144-1-liuyun01@kylinos.cn>
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

Signed-off-by: Jackie Liu <liuyun01@kylinos.cn>
---
 arch/arm64/include/uapi/asm/types.h | 26 ++++++++++++++++++++++++++
 1 file changed, 26 insertions(+)
 create mode 100644 arch/arm64/include/uapi/asm/types.h

diff --git a/arch/arm64/include/uapi/asm/types.h b/arch/arm64/include/uapi/asm/types.h
new file mode 100644
index 0000000..0016780
--- /dev/null
+++ b/arch/arm64/include/uapi/asm/types.h
@@ -0,0 +1,26 @@
+#ifndef _UAPI_ASM_TYPES_H
+#define _UAPI_ASM_TYPES_H
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
+#endif /* _UAPI_ASM_TYPES_H */
-- 
2.7.4




