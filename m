Return-Path: <SRS0=3eIv=UZ=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C58B0C48BD3
	for <linux-block@archiver.kernel.org>; Wed, 26 Jun 2019 06:54:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9FEC92086D
	for <linux-block@archiver.kernel.org>; Wed, 26 Jun 2019 06:54:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="SM3U5xNO"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726823AbfFZGyo (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 26 Jun 2019 02:54:44 -0400
Received: from esa6.hgst.iphmx.com ([216.71.154.45]:6026 "EHLO
        esa6.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725797AbfFZGyo (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 26 Jun 2019 02:54:44 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1561532084; x=1593068084;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=lg8pbEXqIGRxgTLVtp82Eq91m5uzXzwMVXBnCRVLznI=;
  b=SM3U5xNOZV7tLSs98JA3uEiHfVt/68zCr8lb1VVy9y8EticzcUwltiAR
   dWl8TTQvCxUraLBP7W//LTjXIqS22BSqKDA3ZNlFG7AjNPj095nFPGLpr
   VoQhYw5nnVLrJmXnsa7rB2ykzsd75D6YzkyxtZUPOcZcl9Buoxagyh5oV
   Lcfgltyv0osqKXd7T+pxbl09goOHxSfM5axo+lutVam80xdxtuWnmPRHC
   545vTj4bGAt6AH6C62pqpogW7sTXi8ZbwZ+KS6FBMwEsEjgjL1/Xohg/F
   f4oycu0y7oIBH2y5XmqNEWZgDhHy4sVD/HGM+npE6EdAj5DwfMKfQ7zIr
   w==;
X-IronPort-AV: E=Sophos;i="5.63,418,1557158400"; 
   d="scan'208";a="113191703"
Received: from uls-op-cesaip02.wdc.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 26 Jun 2019 14:54:44 +0800
IronPort-SDR: bmORhHA7aTB2gYCjuZF4T880EfeucvE0q/RmsIuj9HaDHqBSvddiQ85Lm8rc6GZxzi0qO5eMGn
 B5Fp4P5QwMT3AbUMA8QYn3/njU4IpzlmD83+h+NS9oWfjLYC9p3XLUKv14PaxDM1o/FhWYkytV
 OsDDr4XcAkuIcMuqQteH8SdTypno29kgti5jggksoeKhWN8mF1DEdhMJj6zWyzp7jhpYNfyAPy
 kvhucwzgo+QVP4ysyBHOg5O8v833HUIL9zX+TAFoJPPMLI61NlauEUPRyH5IR2aM8fl0mbgdvl
 kIyvn4V9b5OOOkg75ZHFChBF
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep02.wdc.com with ESMTP; 25 Jun 2019 23:53:59 -0700
IronPort-SDR: geqr5wrf7iTpSBlPFWkEbdWJAoVbqZr4G4trWXWPy1eZNlGWv0XAoFJnUULODTJQB6t0D7DWnE
 bu3Wk7/BE2SzyzWE9mD1r4kjkPwz/XDODk7+wxfF1BeCqkbpSUrxzM2v5QkIe8Jmv8HAVbgR9N
 8lWlt+Kn79l57jlVSSlkXfP0qBv3SssKkCYTCIsaMyULvrJwZdIeRJ+udPrK1jjIAPm4h0F6uY
 cVNPbsOX7aFVOw9hHwdv7wl5i0LWBV0d9+17HJ/+0AMJlZ4BPv6pFH9AnL8cYmm53kAn/yZTba
 nQ8=
Received: from washi.fujisawa.hgst.com ([10.149.53.254])
  by uls-op-cesaip02.wdc.com with ESMTP; 25 Jun 2019 23:54:42 -0700
From:   Damien Le Moal <damien.lemoal@wdc.com>
To:     linux-scsi@vger.kernel.org,
        "Martin K . Petersen" <martin.petersen@oracle.com>,
        linux-block@vger.kernel.org, Jens Axboe <axboe@kernel.dk>
Cc:     Christoph Hellwig <hch@lst.de>,
        Bart Van Assche <bvanassche@acm.org>
Subject: [PATCH V3 3/3] block: Limit zone array allocation size
Date:   Wed, 26 Jun 2019 15:54:38 +0900
Message-Id: <20190626065438.19307-4-damien.lemoal@wdc.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190626065438.19307-1-damien.lemoal@wdc.com>
References: <20190626065438.19307-1-damien.lemoal@wdc.com>
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

