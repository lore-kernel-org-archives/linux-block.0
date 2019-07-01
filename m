Return-Path: <SRS0=9MH5=U6=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 66499C5B578
	for <linux-block@archiver.kernel.org>; Mon,  1 Jul 2019 05:09:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3A5162089F
	for <linux-block@archiver.kernel.org>; Mon,  1 Jul 2019 05:09:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="j5JRF6/1"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727490AbfGAFJ3 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 1 Jul 2019 01:09:29 -0400
Received: from esa3.hgst.iphmx.com ([216.71.153.141]:62457 "EHLO
        esa3.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725777AbfGAFJ2 (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Mon, 1 Jul 2019 01:09:28 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1561957769; x=1593493769;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=fiT0Q2RZAIaTc+o8PPq09fvwdcfYZE72CFvMQOosU9c=;
  b=j5JRF6/1H1q4mgAsT/X4Z3ciFSqaNcqk/94KPaC8tN6W1XZLu05FTyFW
   z0UUfSVOFDHorxABkkLb+ds1nOtV6F/VpBiDkdRts5Lbm+3DJp3cXrdQV
   Wq6lh7gyjqlNpYIxEXbhj6Rv8yHMCgRkMVTrOMk00enNFro3qgH2JirGr
   C9qAzydLQaLtIJp86aHXkJLs9+swWk4f2IpGgeA2RmqA+pxoZbHp7asJF
   4IFT7kVmXYvcBHy7fGvPKMMsEtOlDuUDWEEvg5TkyzqMuB1FFYeLGxteQ
   rTB85ebeeIbIEW2GnRr2HBv8LUkmvSGfkhZP6pE9epchbmnb/qjBEPV3m
   g==;
X-IronPort-AV: E=Sophos;i="5.63,437,1557158400"; 
   d="scan'208";a="116777223"
Received: from h199-255-45-15.hgst.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 01 Jul 2019 13:09:29 +0800
IronPort-SDR: Y3e9+G0lgozqotyOUy+JVhflmgNGuzfIfANWs6P/xjso48h5+fLYPPFaIylMKwRnDb+UNxjeZy
 pU8qiqI7kak8q42Cb67DOQAxcDmQBvqtevG3hf3omCwP4kSqN1PDx/8h8j9xPXOSx3YxjXQG2u
 t/MDoCDcEaxmZtkOs0/dplikYcnGCHNuyOb7HITjYUnBS3NJzSElbafCK7i7qkCvhY7J1Yqc7A
 CE1YxRndFIn7tcgvMDhk7YcNtUHdwn0udckMJZL7fjGmWc/bAB50jIQNeW4+X56W+28wWbeZ/c
 qnVbjQUdxBNcGqu9WsmYUNeX
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep02.wdc.com with ESMTP; 30 Jun 2019 22:08:32 -0700
IronPort-SDR: nW2I57e363zZy8ypwNj+v+eT0Z8Wy9I3uEUEDqVyL2t8v0jXQ7XAx1XyWcfk1eFd9+9RFQB592
 QiA4zT7SbZeEzOcFj0coze4NDQZYsLK8U0dcJw/arh2P8QvIV05+/CsXSgN5psbs8ptf6Hom4w
 gHpgdM3tby0LsTxJqHtCvVG29jknMcWCH2j6Li8+n7TlrHApYGDYrbSG9WzBR4OqWV3AQRHUYq
 LoKfVoevMDObQmmSzKKWOeAgSb/r69E0xBFJjQdSIWlshpY0ySpNrz7BT7Vr35a4TskJUcsc0Z
 1Ww=
Received: from washi.fujisawa.hgst.com ([10.149.53.254])
  by uls-op-cesaip02.wdc.com with ESMTP; 30 Jun 2019 22:09:26 -0700
From:   Damien Le Moal <damien.lemoal@wdc.com>
To:     linux-scsi@vger.kernel.org,
        "Martin K . Petersen" <martin.petersen@oracle.com>,
        linux-block@vger.kernel.org, Jens Axboe <axboe@kernel.dk>,
        dm-devel@redhat.com, Mike Snitzer <snitzer@redhat.com>,
        linux-f2fs-devel@lists.sourceforge.net,
        Jaegeuk Kim <jaegeuk@kernel.org>
Cc:     Christoph Hellwig <hch@lst.de>,
        Bart Van Assche <bvanassche@acm.org>
Subject: [PATCH V6 4/4] block: Limit zone array allocation size
Date:   Mon,  1 Jul 2019 14:09:18 +0900
Message-Id: <20190701050918.27511-5-damien.lemoal@wdc.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190701050918.27511-1-damien.lemoal@wdc.com>
References: <20190701050918.27511-1-damien.lemoal@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Limit the size of the struct blk_zone array used in
blk_revalidate_disk_zones() to avoid memory allocation failures leading
to disk revalidation failure. Also further reduce the likelyhood of
such failures by using kvcalloc() (that is vmalloc()) instead of
allocating contiguous pages with alloc_pages().

Fixes: 515ce6061312 ("scsi: sd_zbc: Fix sd_zbc_report_zones() buffer allocation")
Fixes: e76239a3748c ("block: add a report_zones method")
Cc: stable@vger.kernel.org
Signed-off-by: Damien Le Moal <damien.lemoal@wdc.com>
---
 block/blk-zoned.c      | 36 ++++++++++++++++++++----------------
 include/linux/blkdev.h |  5 +++++
 2 files changed, 25 insertions(+), 16 deletions(-)

diff --git a/block/blk-zoned.c b/block/blk-zoned.c
index 60dfc3f22350..79ad269b545d 100644
--- a/block/blk-zoned.c
+++ b/block/blk-zoned.c
@@ -14,6 +14,8 @@
 #include <linux/rbtree.h>
 #include <linux/blkdev.h>
 #include <linux/blk-mq.h>
+#include <linux/mm.h>
+#include <linux/vmalloc.h>
 #include <linux/sched/mm.h>
 
 #include "blk.h"
@@ -371,22 +373,25 @@ static inline unsigned long *blk_alloc_zone_bitmap(int node,
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
+	/*
+	 * GFP_KERNEL here is meaningless as the caller task context has
+	 * the PF_MEMALLOC_NOIO flag set in blk_revalidate_disk_zones()
+	 * with memalloc_noio_save().
+	 */
+	zones = kvcalloc(nrz, sizeof(struct blk_zone), GFP_KERNEL);
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
@@ -448,7 +453,7 @@ int blk_revalidate_disk_zones(struct gendisk *disk)
 
 	/* Get zone information and initialize seq_zones_bitmap */
 	rep_nr_zones = nr_zones;
-	zones = blk_alloc_zones(q->node, &rep_nr_zones);
+	zones = blk_alloc_zones(&rep_nr_zones);
 	if (!zones)
 		goto out;
 
@@ -487,8 +492,7 @@ int blk_revalidate_disk_zones(struct gendisk *disk)
 out:
 	memalloc_noio_restore(noio_flag);
 
-	free_pages((unsigned long)zones,
-		   get_order(rep_nr_zones * sizeof(struct blk_zone)));
+	kvfree(zones);
 	kfree(seq_zones_wlock);
 	kfree(seq_zones_bitmap);
 
diff --git a/include/linux/blkdev.h b/include/linux/blkdev.h
index 472ba74ca968..5ace0bb77213 100644
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

