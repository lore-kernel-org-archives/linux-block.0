Return-Path: <SRS0=AW5R=4G=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3E6C5C34047
	for <linux-block@archiver.kernel.org>; Tue, 18 Feb 2020 17:28:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 192EF2465D
	for <linux-block@archiver.kernel.org>; Tue, 18 Feb 2020 17:28:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="rytp4UNd"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726411AbgBRR2v (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 18 Feb 2020 12:28:51 -0500
Received: from esa4.hgst.iphmx.com ([216.71.154.42]:60228 "EHLO
        esa4.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727193AbgBRR2v (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 18 Feb 2020 12:28:51 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1582046930; x=1613582930;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=tqoiBrV7Cmx5DfjSGP2AG0toN/Mx6sj7qyTFUXab1Jk=;
  b=rytp4UNdJ5toNR5u7zQ0cYNMfAy++/CKroquuQLlbKw0UlwaNcuDAvNg
   UocLPEQDYBr0Lvk4dXlY/0pVxn8aZIc+GvcO2xffhqsbLbTWK+lNtRd/i
   24m+hQTVQ7ysavLowyWC8dBe4JlIbS5U82qLmwMsltsTJioWmNHy3lTjY
   deLZOl2ywUWNrlsr8s6hodRdZrDSroxMVLagj88KemsqS2sg5WBQlyHWs
   T5yyZ+GlKwFDjhWwL0r1EQuSnIKyrlf5mJ5Q8VCxUwKxbuCk5/TNvC8cj
   cz8sWs/PrWr+5pxViCLa+dK6F1SAyEImQjrW8DEzSeY5jU6wyjQaI8TUm
   w==;
IronPort-SDR: zP96VV2N9JbUE+MzSjH6ifMldNFh0jv9ZzcE7X7TFgdIDRVDwBtP1DRjIINLnexSX5q7tWa9h3
 Eim1zEWI54lUUG0pQYYb/SGm8DtqcvOO5ADndWOLD4yjCj/+Uh1/ovJLPPk0eVA9vJdVYnQ71d
 vdC0PX1SKqe3ti6qsZq8DSIUa0sEOzPbk7/eqoTGSjVfpmkNg1DFJ/4am/qOEm9wfAvLq2AwSW
 xaetHiXRJ32ZRhByeSekBs0SIIv/HtKEafTE6SnWl2EHE4/3jHEVSGQkUpDFrdAgol2yMQlVl9
 jKg=
X-IronPort-AV: E=Sophos;i="5.70,456,1574092800"; 
   d="scan'208";a="130104887"
Received: from h199-255-45-14.hgst.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 19 Feb 2020 01:28:50 +0800
IronPort-SDR: +ywhj71ESWQhwoEKZh/kcAxUZORA61SxwzZwAiHWDFgSeJyemqZS7bNtWTfrL5N71aMyPDdzLR
 7gpK+XQTLkL7Oo5PVjFjwW7jgqmDHbnBcNCE32ny3GJBKsXYj9/Yt/S2Vzd5/WdgQoBJNJDGA9
 wwCgzybbWNB+1Yin1IhHoirn+hoBN8IeqLYedanuZ6b9zFRgncZwB+Ukz9GuRxQgKsyW8omxm/
 V1cS9w3OdTlupJ1FpEKkwrk1y5M9fH0odA+CAKcH0dQWkdviDoB3pjyjcw6nyXOBOvD/D5Sull
 xfRAI3c9mdn7X417qzaYi7Lo
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Feb 2020 09:21:29 -0800
IronPort-SDR: jok2S76wxRTJsJSvD/I4fpL8wpaiGP6uhPvgEgRSWVHH4H3SDx+n7lR684p8r08M3BBCyLCB+T
 rWn+8FR5CHWAKExPbZKxxcV7WFDQuSlRmMVDUurciy2jHIFYvicvMeGEVOAJShcwN20noDzJpA
 MtbX9qUDb/J5H2mcFJrJ0FPGtnBkM/09Zqh6Bg/TxLSpzzhL1MieHq96pvhu+5/e+PdPG100XE
 Ci/brkyHA5Hhh50Nj2d366iPt3ThcEoEHloUlZj72YAB5slzayGYCXeWNQ6p1ttJgKx3L8YCpQ
 gPw=
WDCIronportException: Internal
Received: from iouring.labspan.wdc.com (HELO iouring.sc.wdc.com) ([10.6.138.107])
  by uls-op-cesaip01.wdc.com with ESMTP; 18 Feb 2020 09:28:50 -0800
From:   Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
To:     damien.lemoal@wdc.com, axboe@kernel.dk
Cc:     linux-block@vger.kernel.org,
        Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
Subject: [PATCH V2 1/3] block: add a zone condition debug helper
Date:   Tue, 18 Feb 2020 09:28:38 -0800
Message-Id: <20200218172840.4097-2-chaitanya.kulkarni@wdc.com>
X-Mailer: git-send-email 2.24.0
In-Reply-To: <20200218172840.4097-1-chaitanya.kulkarni@wdc.com>
References: <20200218172840.4097-1-chaitanya.kulkarni@wdc.com>
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
Changes from V1 : -

1. Move blk_zone_cond_str() to blk-zoned.c.
2. Mark zone_cond_namd array static.
3. Remove BLK_ZONE_COND_LAST.
4. Get rid of inline prefix for blk_zone_cond_str().
---
 block/blk-zoned.c      | 32 ++++++++++++++++++++++++++++++++
 include/linux/blkdev.h | 10 ++++++++++
 2 files changed, 42 insertions(+)

diff --git a/block/blk-zoned.c b/block/blk-zoned.c
index 05741c6f618b..f18f1ee9d71f 100644
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
index 053ea4b51988..a40a3a27bfbc 100644
--- a/include/linux/blkdev.h
+++ b/include/linux/blkdev.h
@@ -887,6 +887,16 @@ extern void blk_execute_rq_nowait(struct request_queue *, struct gendisk *,
 /* Helper to convert REQ_OP_XXX to its string format XXX */
 extern const char *blk_op_str(unsigned int op);
 
+#ifdef CONFIG_BLK_DEV_ZONED
+/* Helper to convert BLK_ZONE_ZONE_XXX to its string format XXX */
+extern const char *blk_zone_cond_str(enum blk_zone_cond zone_cond);
+#else
+static const char *blk_zone_cond_str(unsigned int zone_cond)
+{
+	return "NOT SUPPORTED";
+}
+#endif /* CONFIG_BLK_DEV_ZONED */
+
 int blk_status_to_errno(blk_status_t status);
 blk_status_t errno_to_blk_status(int errno);
 
-- 
2.22.1

