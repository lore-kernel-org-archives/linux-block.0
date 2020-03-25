Return-Path: <SRS0=yjA8=5K=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3C8A6C2D0E5
	for <linux-block@archiver.kernel.org>; Wed, 25 Mar 2020 18:55:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 13BD32074D
	for <linux-block@archiver.kernel.org>; Wed, 25 Mar 2020 18:55:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="OaSPysT3"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727328AbgCYSzL (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 25 Mar 2020 14:55:11 -0400
Received: from esa1.hgst.iphmx.com ([68.232.141.245]:50381 "EHLO
        esa1.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727006AbgCYSzL (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 25 Mar 2020 14:55:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1585162511; x=1616698511;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=bkMzVBDta558kT2wvvFlS6P0DKc8Tj3eUft9+9uROT8=;
  b=OaSPysT3HB77iDBZx054Px9GEcIKcit8E9CsnKpCxyRzqXbciWyReBVV
   ayBrjiBh6Rdl3s6a0CRE+1yQb1UfYZPobs6R6I7hObhGhadHicZ4Q3zkn
   D5uFFZ/3qnwQ9mlCDQR6BB/6KTBBIUmZcDk894lvKTKhz7fcZn1A1i3Ns
   j9pJJ81bewSE8PB7HOodqvpMl0bcmn+v/COA33Mni5LKTJ/YZQkAxeGnn
   +EAYTcp7zPj3veptJeBkdxPABMSidPN9ZBenh8R3X577kf2yY5rOrywu3
   OWqnFZ/VZzXIUyfMu7j9B+9eoEmcA0yIeKSOy0DcCWeWVZTr2fawzE0/w
   A==;
IronPort-SDR: H7OVvwFjqwNpD3QH9Xr/CHEwVh/UTYF78gT/Q3jQgUaU8Ql5GKa3xbvJyy0sQLDbhO6CknBtpg
 Rf9o9q0gSvvHA2Q0GgDeKS6xb5RzMvWu2D/zQl2mAbCevQYN0tamh+PIjJkMyV///H1XohWR7D
 wc5Xw1yQ++7h6dSdgiXolEOFc7eVpKjDJVaaGq9NgGupa12Q0f6n+xTXjtOPrEa5n85+nHEu1L
 fDzA/jlih2D6VQB6FzhYVa6Aujy3VX/S/jfzFe2G1USYOj3W+mykvQXU0iHwra49t6Rha8V9zO
 gyM=
X-IronPort-AV: E=Sophos;i="5.72,305,1580745600"; 
   d="scan'208";a="241991776"
Received: from h199-255-45-15.hgst.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 26 Mar 2020 02:55:11 +0800
IronPort-SDR: jJTaAhKD5FUVM2sig1QggdxaO8gqK9BwG6YL+dDb6iHyYpMb/2LZo/FUq3crz1q7zigMrTiGKX
 jjIakjHQj4zSElUp6eGqSHy2SprT5UJbjzcKaVSnri+uZZ3Z+kOoKaxOrMuDxFlMA6wfrC8wYj
 G9B4jql3THZpDoE29/W+z2HAefoOyl6EHMneEh6Ew6IieYGkwEuxati+ErwK3R2KVxnFrhJsA1
 1kdymIqUW0Cbx/C14/P/3tNrOsp77Pq1mrGGE5u/MA0XuifH5h57MWkkI6ufLYDL+n53xUA3QX
 OsAEFAhitrJQfDgsWCmCq7fF
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
  by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Mar 2020 11:46:21 -0700
IronPort-SDR: RJfyZRdBpPzc5tbb/RwaZymtOQuihmeAUyCAGlDDubww2L8qYFdqP5EKPrY/dYg+dw5oPNM3Bk
 BluWRhFdGVnTUa9RTHLCrvKhPAR2xZjNkUQTNJxvE1+5ywfKvuDVeOhymPD5wpXDsVxRF9iAgK
 QhUrgig7oJ7W5C3F3eGgZw9NQ3pv/shqm5UUrCFifHLU+2mVRtFma3ZDBP4ycnt/yCFtwaIeLN
 FuqKCLbkdXHnv6o6nY56KLK4fBZAxSItlaQpl8MexSarqo67rx8XEyaMiEa8CGxQDui/zKmKZ7
 2fY=
WDCIronportException: Internal
Received: from ioprio.labspan.wdc.com (HELO ioprio.sc.wdc.com) ([10.6.139.89])
  by uls-op-cesaip01.wdc.com with ESMTP; 25 Mar 2020 11:55:11 -0700
From:   Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
To:     linux-block@vger.kernel.org
Cc:     axboe@kernel.dk, damien.lemoal@wdc.com,
        Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
Subject: [PATCH V4 1/3] block: add a zone condition debug helper
Date:   Wed, 25 Mar 2020 10:49:54 -0700
Message-Id: <20200325174956.16719-2-chaitanya.kulkarni@wdc.com>
X-Mailer: git-send-email 2.22.0
In-Reply-To: <20200325174956.16719-1-chaitanya.kulkarni@wdc.com>
References: <20200325174956.16719-1-chaitanya.kulkarni@wdc.com>
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
 include/linux/blkdev.h |  4 ++++
 2 files changed, 36 insertions(+)

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
index 53a1325efbc3..8ab1f4526f72 100644
--- a/include/linux/blkdev.h
+++ b/include/linux/blkdev.h
@@ -952,6 +952,10 @@ static inline unsigned int blk_rq_stats_sectors(const struct request *rq)
 }
 
 #ifdef CONFIG_BLK_DEV_ZONED
+
+/* Helper to convert BLK_ZONE_ZONE_XXX to its string format XXX */
+const char *blk_zone_cond_str(enum blk_zone_cond zone_cond);
+
 static inline unsigned int blk_rq_zone_no(struct request *rq)
 {
 	return blk_queue_zone_no(rq->q, blk_rq_pos(rq));
-- 
2.22.0

