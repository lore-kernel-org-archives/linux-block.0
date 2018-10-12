Return-Path: <linux-block-owner@vger.kernel.org>
Received: from esa2.hgst.iphmx.com ([68.232.143.124]:6549 "EHLO
        esa2.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726183AbeJLKA1 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 12 Oct 2018 06:00:27 -0400
From: Damien Le Moal <damien.lemoal@wdc.com>
To: linux-block@vger.kernel.org, Jens Axboe <axboe@kernel.dk>,
        linux-scsi@vger.kernel.org,
        "Martin K . Petersen" <martin.petersen@oracle.com>,
        dm-devel@redhat.com, Mike Snitzer <snitzer@redhat.com>
Cc: Christoph Hellwig <hch@lst.de>,
        Matias Bjorling <matias.bjorling@wdc.com>
Subject: [PATCH v3 05/11] block: Limit allocation of zone descriptors for report zones
Date: Fri, 12 Oct 2018 11:30:06 +0900
Message-Id: <20181012023012.29923-6-damien.lemoal@wdc.com>
In-Reply-To: <20181012023012.29923-1-damien.lemoal@wdc.com>
References: <20181012023012.29923-1-damien.lemoal@wdc.com>
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

There is no point in allocating more zone descriptors than the number of
zones a block device has for doing a zone report. Avoid doing that in
blkdev_report_zones_ioctl() by limiting the number of zone decriptors
allocated internally to process the user request.

Signed-off-by: Damien Le Moal <damien.lemoal@wdc.com>
Reviewed-by: Christoph Hellwig <hch@lst.de>
---
 block/blk-zoned.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/block/blk-zoned.c b/block/blk-zoned.c
index 32e377f755d8..bb4ed69f917f 100644
--- a/block/blk-zoned.c
+++ b/block/blk-zoned.c
@@ -355,8 +355,7 @@ int blkdev_report_zones_ioctl(struct block_device *bdev, fmode_t mode,
 	if (!rep.nr_zones)
 		return -EINVAL;
 
-	if (rep.nr_zones > INT_MAX / sizeof(struct blk_zone))
-		return -ERANGE;
+	rep.nr_zones = min(blkdev_nr_zones(bdev), rep.nr_zones);
 
 	zones = kvmalloc_array(rep.nr_zones, sizeof(struct blk_zone),
 			       GFP_KERNEL | __GFP_ZERO);
-- 
2.17.1
