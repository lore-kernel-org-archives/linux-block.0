Return-Path: <SRS0=aWxv=TB=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 101EAC04AA8
	for <linux-block@archiver.kernel.org>; Wed,  1 May 2019 04:28:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D3FFB20866
	for <linux-block@archiver.kernel.org>; Wed,  1 May 2019 04:28:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="a60HlSYo"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726004AbfEAE2k (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 1 May 2019 00:28:40 -0400
Received: from esa5.hgst.iphmx.com ([216.71.153.144]:9392 "EHLO
        esa5.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725799AbfEAE2k (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Wed, 1 May 2019 00:28:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1556684921; x=1588220921;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=FdDIH4fTEMAseAHR3/dTJaLhkwE1aqA9bo9sHy5eI8A=;
  b=a60HlSYoywtGAa43BOfbjfJKbgN/aCCV/tihPGWOuq/EX5MxyVMEoo31
   uIys6hgtLyUilqun/uyb+DlEr4c0b77yswNDJwFflLvb3mnAtd0oX5PFv
   foCtdvOT4XtD9rWPwxavJStIEFuyWMdRpMJtAdimyg04FlVskbVHEVOr+
   Po+NscPGqIrgOjN9E/haf7/OUVa9K0/VqBMiGwwKF81macvGhIgQ9Br2E
   OVUjgdm4aud1ctQuYxEOfLUUGn3cD7kTA/XZCr942rQhpR4koZHFedjsy
   cQI2cepQz0AYWKTHeRRhl4lg1KG697CCoHCBEk5NUiIZD89kusuRkBbZD
   A==;
X-IronPort-AV: E=Sophos;i="5.60,416,1549900800"; 
   d="scan'208";a="108436742"
Received: from h199-255-45-15.hgst.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 01 May 2019 12:28:40 +0800
IronPort-SDR: sK7AtQoNacRgD76UDI6pquqaj5nFfjRt2pRJuYQ4Alw0KOnY9Y8xm8QF5Lc3Gkzfatv/MHtVmu
 a1n1LHghPOxmxhzJJ+/uMhKo9tn727IBG/RvwhxToYdob1IfWnv5RZZVBgFxcsGgVxLMXmmwuN
 G86p0Hwk1LRcxr/9BhW5N5386J0mSL7XcPqL2w0VXy/fNo3SFioIHw4OZNxJ1rrDj+jMu9oolI
 5htv8+xaTa1amNaa7rl9IxRjnJ1fnpqVxI6tioZjON1/jc7xvjxWHqlIZdId3dwcFHnsjAnTyD
 UId89PSZC68kHOakzQbPLwKL
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
  by uls-op-cesaep02.wdc.com with ESMTP; 30 Apr 2019 21:07:09 -0700
IronPort-SDR: ESfibwEGRwTTQMwRFTC5d4AglCI6dYw6UTobzIJWDqBVOTIV5DIX39PEDwYEE96nU9HGcGTUWt
 tL+70Yg984E9IZFodskUhH4BXFH8O46J8i5TminRB+0xXxGuMK5Uwc+svkP6nYUOgHm1A95cNr
 1UZJ9NP0QSL4E9x6frLckgeD9y0WS/3DuCLOWEGIwMA3q2glVzzb35n2+MDbhhkq2jU2Wap8dc
 Nq8vvDWkTdMR43JCdY/tz8w8Nbu2Ianq3RRjt/K0isiQwPaOgE7aWL3sBRLK0oIop4H/yDwj3b
 Vxo=
Received: from cmercuryqemu.hgst.com ([10.202.65.32])
  by uls-op-cesaip01.wdc.com with ESMTP; 30 Apr 2019 21:28:40 -0700
From:   Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
To:     linux-block@vger.kernel.org
Cc:     Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
Subject: [RFC PATCH 01/18] blktrace: increase the size of action mask
Date:   Tue, 30 Apr 2019 21:28:14 -0700
Message-Id: <20190501042831.5313-2-chaitanya.kulkarni@wdc.com>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20190501042831.5313-1-chaitanya.kulkarni@wdc.com>
References: <20190501042831.5313-1-chaitanya.kulkarni@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

This patch adds the blktrace extension support where we increase the
size of action mask so that it can store more actions.

Signed-off-by: Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
---
 include/linux/blktrace_api.h | 12 +++++++++++-
 1 file changed, 11 insertions(+), 1 deletion(-)

diff --git a/include/linux/blktrace_api.h b/include/linux/blktrace_api.h
index 7bb2d8de9f30..403d4cfc6a52 100644
--- a/include/linux/blktrace_api.h
+++ b/include/linux/blktrace_api.h
@@ -17,7 +17,11 @@ struct blk_trace {
 	struct rchan *rchan;
 	unsigned long __percpu *sequence;
 	unsigned char __percpu *msg_data;
+#ifdef CONFIG_BLKTRACE_EXT
+	u64 act_mask;
+#else
 	u16 act_mask;
+#endif /* CONFIG_BLKTRACE_EXT */
 	u64 start_lba;
 	u64 end_lba;
 	u32 pid;
@@ -101,14 +105,20 @@ static inline int blk_trace_init_sysfs(struct device *dev)
 
 struct compat_blk_user_trace_setup {
 	char name[BLKTRACE_BDEV_SIZE];
+#ifdef CONFIG_BLKTRACE_EXT
+	u64 act_mask;
+#else
 	u16 act_mask;
+#endif /* CONFIG_BLKTRACE_EXT */
 	u32 buf_size;
 	u32 buf_nr;
 	compat_u64 start_lba;
 	compat_u64 end_lba;
 	u32 pid;
 };
-#define BLKTRACESETUP32 _IOWR(0x12, 115, struct compat_blk_user_trace_setup)
+
+/* XXX: temp work around for RFC */
+#define BLKTRACESETUP32 _IOWR(0x13, 115, struct compat_blk_user_trace_setup)
 
 #endif
 
-- 
2.19.1

