Return-Path: <SRS0=yjA8=5K=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 21CACC54FD2
	for <linux-block@archiver.kernel.org>; Wed, 25 Mar 2020 03:21:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EB36920724
	for <linux-block@archiver.kernel.org>; Wed, 25 Mar 2020 03:21:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="HhBqJv/+"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727301AbgCYDVm (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 24 Mar 2020 23:21:42 -0400
Received: from esa1.hgst.iphmx.com ([68.232.141.245]:59502 "EHLO
        esa1.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727253AbgCYDVm (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 24 Mar 2020 23:21:42 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1585106501; x=1616642501;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=YLRQeJ3ry+HoV2a584kdDIojGSXSDoBKvGB8JssfWbw=;
  b=HhBqJv/+D8AHwEjnQEGWzx1qC+HSi0XH6pR2CiQImgjy3cmKJFO0sxI1
   1yb4/is287zIdsBNiuV4oTlyO+2QRbmbRMcx/VaG27tt0wEe9PByIAkrG
   52dcxY7P/2Olj7Zl7upZRCCjBX+HGCRuuhdNdhu3ky/cDmdX2w9OsEVMG
   VuY8GVfOWoAAXFgo6+eJXtypUq0y9HIqIv2jo3sJmbCa5S78JDdu+y78/
   Ex4eDM6ajSj+Mr8gckJdBefO7wWNTwiDaIG5oYtpAhdPAKlUro8XiEpts
   w6/GgSGzDM8AuSNjg3gAlIlt+8ecRzINtl4th9zXLQIPHiOp8btWFR2d9
   g==;
IronPort-SDR: 29hpSKcXWREL95WzHw4CTgBGT1RTD0PEbXT9eyfLKuF08diq2PMBAzU65bYv6j/kJa6kKH/lAo
 q9mgv4Qnu0yh200a3eaCN74Ufmg6ZD/N5gZnjYpX6a7EYUFQkWuW6B8U1v8IliZtsJpHLcNi0q
 R7MvR5/Lo6uK6a094gUj21IiM7WRMHuUTH+ee6daeIGx+cfJhn2RV7XdmFLhy5lSZEr3H9X6Vu
 Og1mNy9fLsJBlL7TAAX8oqUCwsTIIIo5qD+o+jkIPOsgs5+fc94NNb123Hyxse+M6Z8jUVX+DJ
 DBQ=
X-IronPort-AV: E=Sophos;i="5.72,302,1580745600"; 
   d="scan'208";a="241910424"
Received: from h199-255-45-14.hgst.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 25 Mar 2020 11:21:41 +0800
IronPort-SDR: lL1P9fOXbpWwEQ0dsthmCbETRxrJ00Za/JhVq4YyDrszC2jhfRKyp4oD1HnruqCesKOFW4lDLK
 o+3MAALaCwHXl6/fA11jLz0+TRkQHKbyngb78u2A/t4rNlbU767xLuVE1tjMSBA13jtlIgdh9Z
 ilGy2q8uJxUMOY3fI5F6sFAr+QwY8Os74MW3XasWeAwchZEnjptSkZXKl3uQFoYlmb0JBHKpdS
 2xKNymsLGwqeGpdKpUOPNeGyojjS14OF4+v/6pxtpkCnvgLgXKpfd028EbhjZIq/lekJu/LYm2
 5Gq4wZESVP74iC6fwaCDIwRj
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Mar 2020 20:13:20 -0700
IronPort-SDR: KI5tCn+Ql81jjgqafB84Rg2S4zWljNmKV5JmtqdHHHq9dJwxfKkGXY6gSFXQxrTOS36w9rw+Jo
 48u8hc9eoaGCw7dnZLdt6RjSlWFgneerl383RmSQ0/vTf5ijtA/LTGflaJjJKDte3UI2SYuztn
 oUzqKHqcL70ccQ856EcueFGofqC1R3ggOrdG58e5nmq3c647/8QUfD7bVhROtf6z8/hXiuYP3C
 xCMzskEMLuOK8BVMzuF/RvQYzi2ihNQ9qlP1tUX1T6G5V8LtCAzwYCK0crolz4343OpL+rRcpD
 GYY=
WDCIronportException: Internal
Received: from ioprio.labspan.wdc.com (HELO ioprio.sc.wdc.com) ([10.6.139.89])
  by uls-op-cesaip02.wdc.com with ESMTP; 24 Mar 2020 20:21:41 -0700
From:   Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
To:     linux-block@vger.kernel.org
Cc:     axboe@kernel.dk, damien.lemoal@wdc.com,
        Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
Subject: [PATCH V3 1/3] block: add a zone condition debug helper
Date:   Tue, 24 Mar 2020 19:16:27 -0700
Message-Id: <20200325021629.15103-2-chaitanya.kulkarni@wdc.com>
X-Mailer: git-send-email 2.22.0
In-Reply-To: <20200325021629.15103-1-chaitanya.kulkarni@wdc.com>
References: <20200325021629.15103-1-chaitanya.kulkarni@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Add a helper to stringify the zone conditions. We use this helper in the
next patch to track zone conditions in tracepoints.

Signed-off-by: Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
---
 block/blk-zoned.c      | 32 ++++++++++++++++++++++++++++++++
 include/linux/blkdev.h |  3 +++
 2 files changed, 35 insertions(+)

diff --git a/block/blk-zoned.c b/block/blk-zoned.c
index 6b442ae96499..f87956e0dcaf 100644
--- a/block/blk-zoned.c
+++ b/block/blk-zoned.c
@@ -20,6 +20,38 @@
 
 #include "blk.h"
 
+#define ZONE_COND_NAME(name) [BLK_ZONE_COND_##name] = #name
+static const char *const zone_cond_name[] = {
+	ZONE_COND_NAME(NOT_WP),
+	ZONE_COND_NAME(EMPTY),
+	ZONE_COND_NAME(IMP_OPEN),
+	ZONE_COND_NAME(EXP_OPEN),
+	ZONE_COND_NAME(CLOSED),
+	ZONE_COND_NAME(READONLY),
+	ZONE_COND_NAME(FULL),
+	ZONE_COND_NAME(OFFLINE),
+};
+#undef ZONE_COND_NAME
+
+/**
+ * blk_zone_cond_str - Return string XXX in BLK_ZONE_COND_XXX.
+ * @zone_cond: BLK_ZONE_COND_XXX.
+ *
+ * Description: Centralize block layer function to convert BLK_ZONE_COND_XXX
+ * into string format. Useful in the debugging and tracing zone conditions. For
+ * invalid BLK_ZONE_COND_XXX it returns string "UNKNOWN".
+ */
+const char *blk_zone_cond_str(enum blk_zone_cond zone_cond)
+{
+	static const char *zone_cond_str = "UNKNOWN";
+
+	if (zone_cond < ARRAY_SIZE(zone_cond_name) && zone_cond_name[zone_cond])
+		zone_cond_str = zone_cond_name[zone_cond];
+
+	return zone_cond_str;
+}
+EXPORT_SYMBOL_GPL(blk_zone_cond_str);
+
 static inline sector_t blk_zone_start(struct request_queue *q,
 				      sector_t sector)
 {
diff --git a/include/linux/blkdev.h b/include/linux/blkdev.h
index 53a1325efbc3..0070f26b9579 100644
--- a/include/linux/blkdev.h
+++ b/include/linux/blkdev.h
@@ -887,6 +887,9 @@ extern void blk_execute_rq_nowait(struct request_queue *, struct gendisk *,
 /* Helper to convert REQ_OP_XXX to its string format XXX */
 extern const char *blk_op_str(unsigned int op);
 
+/* Helper to convert BLK_ZONE_ZONE_XXX to its string format XXX */
+extern const char *blk_zone_cond_str(enum blk_zone_cond zone_cond);
+
 int blk_status_to_errno(blk_status_t status);
 blk_status_t errno_to_blk_status(int errno);
 
-- 
2.22.0

