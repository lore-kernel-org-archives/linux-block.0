Return-Path: <linux-scsi-owner@vger.kernel.org>
From: Damien Le Moal <damien.lemoal@wdc.com>
To: linux-block@vger.kernel.org, Jens Axboe <axboe@kernel.dk>,
        linux-scsi@vger.kernel.org,
        "Martin K . Petersen" <martin.petersen@oracle.com>,
        dm-devel@redhat.com, Mike Snitzer <snitzer@redhat.com>
Cc: Christoph Hellwig <hch@lst.de>,
        Matias Bjorling <matias.bjorling@wdc.com>
Subject: [PATCH 05/11] block: Limit allocation of zone descriptors for report zones
Date: Wed, 10 Oct 2018 10:52:33 +0900
Message-Id: <20181010015239.24930-6-damien.lemoal@wdc.com>
In-Reply-To: <20181010015239.24930-1-damien.lemoal@wdc.com>
References: <20181010015239.24930-1-damien.lemoal@wdc.com>
Sender: linux-scsi-owner@vger.kernel.org
List-ID: <linux-block@vger.kernel.org>

There is no point in allocating more zone descriptors than the number of
zones a block device has for doing a zone report. Avoid doing that in
blkdev_report_zones_ioctl() by limiting the number of zone decriptors
allocated internally to process the user request.

Signed-off-by: Damien Le Moal <damien.lemoal@wdc.com>
---
 block/blk-zoned.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/block/blk-zoned.c b/block/blk-zoned.c
index 32e377f755d8..f2c8b859fc18 100644
--- a/block/blk-zoned.c
+++ b/block/blk-zoned.c
@@ -334,6 +334,7 @@ int blkdev_report_zones_ioctl(struct block_device *bdev, fmode_t mode,
 	struct request_queue *q;
 	struct blk_zone_report rep;
 	struct blk_zone *zones;
+	unsigned int nr_zones;
 	int ret;
 
 	if (!argp)
@@ -355,8 +356,9 @@ int blkdev_report_zones_ioctl(struct block_device *bdev, fmode_t mode,
 	if (!rep.nr_zones)
 		return -EINVAL;
 
-	if (rep.nr_zones > INT_MAX / sizeof(struct blk_zone))
-		return -ERANGE;
+	nr_zones = blkdev_nr_zones(bdev);
+	if (rep.nr_zones > nr_zones)
+		rep.nr_zones = nr_zones;
 
 	zones = kvmalloc_array(rep.nr_zones, sizeof(struct blk_zone),
 			       GFP_KERNEL | __GFP_ZERO);
-- 
2.17.1
