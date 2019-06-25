Return-Path: <SRS0=31JE=UY=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D2DC0C4646B
	for <linux-block@archiver.kernel.org>; Tue, 25 Jun 2019 02:46:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AC354206DD
	for <linux-block@archiver.kernel.org>; Tue, 25 Jun 2019 02:46:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="WX8bu1eB"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730599AbfFYCqc (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 24 Jun 2019 22:46:32 -0400
Received: from esa5.hgst.iphmx.com ([216.71.153.144]:51039 "EHLO
        esa5.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730587AbfFYCqc (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 24 Jun 2019 22:46:32 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1561430792; x=1592966792;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=7ACOvz/I4Pkq6BKjCanVA2jilXHheAcb+PFhiYQaSC8=;
  b=WX8bu1eB4fjZ9ZcEE+VRY3hyspmG5Xov6PtgTYACWM1IelyE/3i6uQDW
   R3ewCCrUGwHcNxnyqWQGc9imwiA6inCq7nMsu1qShR8Lugzs+ylNdG4Tp
   Z7E5nL0z/XJFBZ/pFdGPeUh9ayzbKROM3pzaBmoDvE8b4A9jNP8n+n/23
   pdWQ93z6xk2jP43/d7TnW9leXQ2u1Oe3k5N8DwmqLoFkK3MgheQf3uq1r
   Ig15A1Uaea+3zQQDyTOUHLTeFyTbl4583HVexOBTD7hlfzPR4cDyZ8RYK
   6BoGfWwAKlMTEJM9MeTjDSrIhac1JJxAaLfcZO7DDZ0WOLHDgUB6FXcKa
   w==;
X-IronPort-AV: E=Sophos;i="5.63,413,1557158400"; 
   d="scan'208";a="112654048"
Received: from uls-op-cesaip02.wdc.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 25 Jun 2019 10:46:32 +0800
IronPort-SDR: QwUXBA4LjWp0KQYK6qSFGLByVxg/2xIW6BP5kkB/POoem+tkxEvtGzewCOOWdrGkZl8s8OjXq1
 E2VAoAOLCiQCReB24Uhkwk7vYKzqDWyg7p6BcYUFY5UTWtdIV7WDdxNJ9h1APSrQ0sJ3EeIL28
 OjItY6KzNrc6NyjO1s/diWPKRqAAzcnc4TwxPBwjyH4J0fN2qdjL8wbxGQnZTk/DEZOMRMCc/O
 aXbbrNzYwSKfZBv/LjWCDtCLZzzUqLtP2RYJ2xVikZhGXzdmdbqvqT9etW9K5nVkpOScLSBNbl
 JzehsRjARTIOydYofq2cag55
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
  by uls-op-cesaep02.wdc.com with ESMTP; 24 Jun 2019 19:45:48 -0700
IronPort-SDR: kcVlWk6MzJiPz8TBlagyFjbw7Sv+dPkY8/JUvcay9NZs47zuKAhniFHdVJzDhftUcYVx5pRIc/
 5Yv3Y7iOOs1oWcEFPTM6k4JzpFamLnEnCcne5skz7Mr6sT4GNuuwjJVmwS0vKIwvDjRH05X8SP
 YEj35ujyFcxJx5YAmv5FH2SSjk/cdYeYj/Gu8x36lGt6yEEabkMU0c0tYStLZ/4pDosl4SHlc1
 tiCdu+YgeIv6dEZjHDNR5fd2RupQdumY7rOI01rjSib3BbVK09xHH+9LL1bNAryBbWG97FvKEw
 Xrw=
Received: from washi.fujisawa.hgst.com ([10.149.53.254])
  by uls-op-cesaip01.wdc.com with ESMTP; 24 Jun 2019 19:46:30 -0700
From:   Damien Le Moal <damien.lemoal@wdc.com>
To:     linux-scsi@vger.kernel.org,
        "Martin K . Petersen" <martin.petersen@oracle.com>,
        linux-block@vger.kernel.org, Jens Axboe <axboe@kernel.dk>
Cc:     Christoph Hellwig <hch@lst.de>,
        Bart Van Assche <bvanassche@acm.org>
Subject: [PATCH 3/3] block: Limit zone array allocation size
Date:   Tue, 25 Jun 2019 11:46:25 +0900
Message-Id: <20190625024625.23976-4-damien.lemoal@wdc.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190625024625.23976-1-damien.lemoal@wdc.com>
References: <20190625024625.23976-1-damien.lemoal@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Limit the size of the struct blk_zone array used in
blk_revalidate_disk_zones() to avoid memory allocation failures leading
to disk revalidation failure. Further reduce the likelyhood of these
failures by using kvmalloc() instead of directly allocating contiguous
pages.

Fixes: 515ce6061312 ("scsi: sd_zbc: Fix sd_zbc_report_zones() buffer allocation")
Fixes: e76239a3748c ("block: add a report_zones method")
Cc: stable@vger.kernel.org
Signed-off-by: Damien Le Moal <damien.lemoal@wdc.com>
---
 block/blk-zoned.c      | 29 +++++++++++++----------------
 include/linux/blkdev.h |  5 +++++
 2 files changed, 18 insertions(+), 16 deletions(-)

diff --git a/block/blk-zoned.c b/block/blk-zoned.c
index ae7e91bd0618..26f878b9b5f5 100644
--- a/block/blk-zoned.c
+++ b/block/blk-zoned.c
@@ -373,22 +373,20 @@ static inline unsigned long *blk_alloc_zone_bitmap(int node,
  * Allocate an array of struct blk_zone to get nr_zones zone information.
  * The allocated array may be smaller than nr_zones.
  */
-static struct blk_zone *blk_alloc_zones(int node, unsigned int *nr_zones)
+static struct blk_zone *blk_alloc_zones(unsigned int *nr_zones)
 {
-	size_t size = *nr_zones * sizeof(struct blk_zone);
-	struct page *page;
-	int order;
-
-	for (order = get_order(size); order >= 0; order--) {
-		page = alloc_pages_node(node, GFP_NOIO | __GFP_ZERO, order);
-		if (page) {
-			*nr_zones = min_t(unsigned int, *nr_zones,
-				(PAGE_SIZE << order) / sizeof(struct blk_zone));
-			return page_address(page);
-		}
+	struct blk_zone *zones;
+	size_t nrz = min(*nr_zones, BLK_ZONED_REPORT_MAX_ZONES);
+
+	zones = kvcalloc(nrz, sizeof(struct blk_zone), GFP_NOIO);
+	if (!zones) {
+		*nr_zones = 0;
+		return NULL;
 	}
 
-	return NULL;
+	*nr_zones = nrz;
+
+	return zones;
 }
 
 void blk_queue_free_zone_bitmaps(struct request_queue *q)
@@ -443,7 +441,7 @@ int blk_revalidate_disk_zones(struct gendisk *disk)
 
 	/* Get zone information and initialize seq_zones_bitmap */
 	rep_nr_zones = nr_zones;
-	zones = blk_alloc_zones(q->node, &rep_nr_zones);
+	zones = blk_alloc_zones(&rep_nr_zones);
 	if (!zones)
 		goto out;
 
@@ -480,8 +478,7 @@ int blk_revalidate_disk_zones(struct gendisk *disk)
 	blk_mq_unfreeze_queue(q);
 
 out:
-	free_pages((unsigned long)zones,
-		   get_order(rep_nr_zones * sizeof(struct blk_zone)));
+	kvfree(zones);
 	kfree(seq_zones_wlock);
 	kfree(seq_zones_bitmap);
 
diff --git a/include/linux/blkdev.h b/include/linux/blkdev.h
index 592669bcc536..f7faac856017 100644
--- a/include/linux/blkdev.h
+++ b/include/linux/blkdev.h
@@ -344,6 +344,11 @@ struct queue_limits {
 
 #ifdef CONFIG_BLK_DEV_ZONED
 
+/*
+ * Maximum number of zones to report with a single report zones command.
+ */
+#define BLK_ZONED_REPORT_MAX_ZONES	8192U
+
 extern unsigned int blkdev_nr_zones(struct block_device *bdev);
 extern int blkdev_report_zones(struct block_device *bdev,
 			       sector_t sector, struct blk_zone *zones,
-- 
2.21.0

