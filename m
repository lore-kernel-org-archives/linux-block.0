Return-Path: <SRS0=aWxv=TB=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 21743C43219
	for <linux-block@archiver.kernel.org>; Wed,  1 May 2019 04:33:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E20AE20866
	for <linux-block@archiver.kernel.org>; Wed,  1 May 2019 04:33:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="RJ45b2dz"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725958AbfEAEdZ (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 1 May 2019 00:33:25 -0400
Received: from esa4.hgst.iphmx.com ([216.71.154.42]:63464 "EHLO
        esa4.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725776AbfEAEdZ (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Wed, 1 May 2019 00:33:25 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1556685205; x=1588221205;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=IDDSLBv6TR1FH1Ce2TESaIyNIg27l32mUNWK8SkXujk=;
  b=RJ45b2dzzxMhhOeTGw1B3lPkvM94Sbh/1DUYgB9MRfh3vGS3lfwTlSoL
   xN/GVrYPtnwNy5YyjDt+Nv7sYUd73KYe5ohQf0tKtLThufFzneut6mMkl
   jNwJtGffT4zzLnAPZTFnamORxv7kZi78tzPmjW12S0LhdKOjPI52uPjqo
   208cZ9WuMLBOTHSbux04/TvR+lQA5K9rrWC5lO8UYxdVsSjcxR9aqULN1
   lTjI4mbHPWBZJdHS8gJG4e3bPVKZ8F5GDqWauaV8pLbayY2EGzcKbF/NZ
   FcrC0qoBoqLXQ6p3we77zp97ovQwg9pDsT5DJTqybFo+5p/2NLqDyDC7R
   Q==;
X-IronPort-AV: E=Sophos;i="5.60,416,1549900800"; 
   d="scan'208";a="107229717"
Received: from uls-op-cesaip02.wdc.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 01 May 2019 12:33:25 +0800
IronPort-SDR: hx/z4hkXNqkETU3oAsnhqUPKjRo4nSbL9QWEc12s2UUit0toMQbgC85WZ1R7ushKFHaVD0Cjgx
 uHG4u3L9PFEKiY+I0IX6Lm+VvJ8ti/xb4mE1Jsn8D2fWUITHdY+FLYRPKPoYOms+SywOsbCYL7
 utLXNz0Xtay9PY5cXdfcjHFRhvOgvDSeHqL6Z5DVprnNGqn08Nm7CoHFJJyquUT8E7DkiVLE1O
 7J3Zxvd884Osl3F6DeYC4sTeH/6Iopn0fSih+lotQxFFbtvDjCaKm0rNxgkeHiGC26TK9qd8BZ
 TbgRQBpf5qVCkCZmL6qZFgL1
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
  by uls-op-cesaep02.wdc.com with ESMTP; 30 Apr 2019 21:11:53 -0700
IronPort-SDR: ilEDFoC/WxOrdrUmeB16rnZlfrydHyoG6GnjDk8rwH3OwLUKPbdQmMEp9+o4tJLglo78S2SQPK
 lJ2LcgEo9LhhBbqqRF2C4+893o/DQiLemhPmqaSMx1xhpdXcYJXt5jhufXBQ4ccIRIQk+gwe/N
 yUYs6IQZAZJhq+kxxDtwq/ciNkN3Y1wQkCNfvGQYeth/+4DPi4s7sNpcpcNKJYZPl0DXAxOM+R
 eetwlnZ3BP7P1AzH+LHJoQKUjzBkmBJpWDD1hmmyJcdzPWXdpC48Wp+VndXtQ0lAWbu8+5GpKj
 KCs=
Received: from cmercuryqemu.hgst.com ([10.202.65.32])
  by uls-op-cesaip01.wdc.com with ESMTP; 30 Apr 2019 21:33:25 -0700
From:   Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
To:     linux-block@vger.kernel.org
Cc:     Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
Subject: [RFC PATCH blktrace-tools 01/10] blktrace.h: add blktrace extension to the header
Date:   Tue, 30 Apr 2019 21:33:08 -0700
Message-Id: <20190501043317.5507-2-chaitanya.kulkarni@wdc.com>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20190501043317.5507-1-chaitanya.kulkarni@wdc.com>
References: <20190501043317.5507-1-chaitanya.kulkarni@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

This patch adds blktrace extension definitions to the central header
file blktrace.h. Here we also add priority related constants which are
used in the next few patches.

Signed-off-by: Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
---
 blktrace.h | 39 ++++++++++++++++++++++++++++++++++++++-
 1 file changed, 38 insertions(+), 1 deletion(-)

diff --git a/blktrace.h b/blktrace.h
index 944fc08..17f9f8d 100644
--- a/blktrace.h
+++ b/blktrace.h
@@ -6,6 +6,7 @@
 #include <byteswap.h>
 #include <endian.h>
 #include <sys/types.h>
+#include <stdbool.h>
 
 #include "blktrace_api.h"
 #include "rbtree.h"
@@ -26,6 +27,38 @@
 #define t_kb(t)		((t)->bytes >> 10)
 #define t_b(t)		((t)->bytes & 1023)
 
+#ifdef CONFIG_BLKTRACE_EXT
+/*
+ * Gives us 8 prio classes with 13-bits of data for each class
+ */
+#define IOPRIO_CLASS_SHIFT      (13)
+#define IOPRIO_PRIO_MASK        ((1UL << IOPRIO_CLASS_SHIFT) - 1)
+
+#define IOPRIO_PRIO_CLASS(mask) ((mask) >> IOPRIO_CLASS_SHIFT)
+#define IOPRIO_PRIO_DATA(mask)  ((mask) & IOPRIO_PRIO_MASK)
+#define IOPRIO_PRIO_VALUE(class, data)  (((class) << IOPRIO_CLASS_SHIFT) | data)
+
+#define ioprio_valid(mask)      (IOPRIO_PRIO_CLASS((mask)) != IOPRIO_CLASS_NONE)
+
+/*
+ * These are the io priority groups as implemented by CFQ. RT is the realtime
+ * class, it always gets premium service. BE is the best-effort scheduling
+ * class, the default for any process. IDLE is the idle scheduling class, it
+ * is only served when no one else is using the disk.
+ */
+enum {
+	IOPRIO_CLASS_NONE,
+	IOPRIO_CLASS_RT,
+	IOPRIO_CLASS_BE,
+	IOPRIO_CLASS_IDLE,
+	IOPRIO_CLASS_LAST,
+};
+
+#define TRACE_ALL_IOPRIO ((1 << IOPRIO_CLASS_NONE) | (1 << IOPRIO_CLASS_RT) | \
+		(1 << IOPRIO_CLASS_BE) | (1 << IOPRIO_CLASS_IDLE))
+
+#endif /* CONFIG_BLKTRACE_EXT */
+
 typedef __u32 u32;
 typedef __u8 u8;
 
@@ -68,7 +101,11 @@ extern int data_is_native;
 extern struct timespec abs_start_time;
 
 #define CHECK_MAGIC(t)		(((t)->magic & 0xffffff00) == BLK_IO_TRACE_MAGIC)
+#ifdef CONFIG_BLKTRACE_EXT
+#define SUPPORTED_VERSION	(0x08)
+#else
 #define SUPPORTED_VERSION	(0x07)
+#endif
 
 #if __BYTE_ORDER == __LITTLE_ENDIAN
 #define be16_to_cpu(x)		__bswap_16(x)
@@ -95,7 +132,7 @@ static inline int verify_trace(struct blk_io_trace *t)
 		return 1;
 	}
 	if ((t->magic & 0xff) != SUPPORTED_VERSION) {
-		fprintf(stderr, "unsupported trace version %x\n", 
+		fprintf(stderr, "unsupported trace version %x\n",
 			t->magic & 0xff);
 		return 1;
 	}
-- 
2.19.1

