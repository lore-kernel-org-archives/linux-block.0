Return-Path: <SRS0=TUEB=U2=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B79BCC48BD9
	for <linux-block@archiver.kernel.org>; Thu, 27 Jun 2019 09:29:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8F7B220815
	for <linux-block@archiver.kernel.org>; Thu, 27 Jun 2019 09:29:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="iF+58YTU"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726571AbfF0J3v (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 27 Jun 2019 05:29:51 -0400
Received: from esa3.hgst.iphmx.com ([216.71.153.141]:13128 "EHLO
        esa3.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726315AbfF0J3v (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 27 Jun 2019 05:29:51 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1561627790; x=1593163790;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=lg8pbEXqIGRxgTLVtp82Eq91m5uzXzwMVXBnCRVLznI=;
  b=iF+58YTU2/K65VaCHJlBG7s8GYhaAd/IDqcPiwhceXwO6zzTaDdET4P/
   9Ca/sw380iIiWZ1P/TS9RFGNfAUvuSS1/6y9RMunSjLrWQk9GIZQ6g7ak
   KCfZR7iGVW0DOnrLMKAyv1gVerCGO7iF3Fr1Ol4AmyknA0+xjsUlARuJP
   pyJZ02lfQjJHoggQE/JtxOXqNf1Qdur53W6e8m1DAIRfTUPe8+63/JyR6
   lq+j6q0dFtMHaLmyS0wwphKBZ+OOpzh7t7k7YpHsFKu8KCGCM4J4JWXWh
   qcH1j7kEAs4ijNUMdwiAgU1mxyjoXtTAsySewE2mOXFYzei1PtLVEvDB6
   g==;
X-IronPort-AV: E=Sophos;i="5.63,423,1557158400"; 
   d="scan'208";a="116545303"
Received: from h199-255-45-14.hgst.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 27 Jun 2019 17:29:50 +0800
IronPort-SDR: iZusZ02A8UkSuxvH1GadwzOQv/llBC2Ldxq8a5AxDnt3+N9b8tKkTJMltzjVyVQzu5YG5gAZPD
 /ASSFBg/uPpPSKzn+TEK2nvWB56kWxIXNXjltfT2tcBi2TyDbrt+FegbdfcAZryNlB3fUltky2
 bhRGZc1LekBak2LLdoifRXGszRZL7MZugsa4V0/qeCheLTISy3TROeeSSgteS81+Xv8yV7Tp/2
 pB6Un86jj6goCiDjvGvfpst6mZ7pP2nnzowXjG3NdrANPpiwX7xka0Y3AwU3oVqH4FvnK25ay5
 iDi7AAoIaMgIb/9lBnqoo7e4
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
  by uls-op-cesaep01.wdc.com with ESMTP; 27 Jun 2019 02:28:57 -0700
IronPort-SDR: wsae8wdZTTa0rBCsei6OLNZQm3/A5jc2Zr9CHeDq/8aO47EselAF4cGWzBcfTCeQgFHM9j4peJ
 wsuBOq4gu/yBprpj6/YCS1zckwLYw0RQ2R+EoSIlcKbet22v4hMvf1EX3DIOIp4hi9uNp4R8OL
 OxUqJnFPZH8dql6fcffJ7dC+zOisTxEdbyZ0VikEN1WFcvK+PxmhUPMQMUzE8lYntCx83KE9uL
 dTRK/MQL/CTgYuXBK6h5sYjTPphGdhOVQ43euXqvyTRhEBxQ318hXOwIGqQO7dBo+u8D0I7g0S
 Uds=
Received: from washi.fujisawa.hgst.com ([10.149.53.254])
  by uls-op-cesaip01.wdc.com with ESMTP; 27 Jun 2019 02:29:49 -0700
From:   Damien Le Moal <damien.lemoal@wdc.com>
To:     linux-scsi@vger.kernel.org,
        "Martin K . Petersen" <martin.petersen@oracle.com>,
        linux-block@vger.kernel.org, Jens Axboe <axboe@kernel.dk>
Cc:     Christoph Hellwig <hch@lst.de>,
        Bart Van Assche <bvanassche@acm.org>
Subject: [PATCH V5 3/3] block: Limit zone array allocation size
Date:   Thu, 27 Jun 2019 18:29:44 +0900
Message-Id: <20190627092944.20957-4-damien.lemoal@wdc.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190627092944.20957-1-damien.lemoal@wdc.com>
References: <20190627092944.20957-1-damien.lemoal@wdc.com>
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
Reviewed-by: Bart Van Assche <bvanassche@acm.org>
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

