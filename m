Return-Path: <prvs=697b38d23=bart.vanassche@wdc.com>
From: Bart Van Assche <bart.vanassche@wdc.com>
To: Jens Axboe <axboe@kernel.dk>
Cc: linux-block@vger.kernel.org,
	Christoph Hellwig <hch@lst.de>,
	Bart Van Assche <bart.vanassche@wdc.com>,
	Matias Bjorling <mb@lightnvm.io>
Subject: [PATCH 1/5] block: Remove a superfluous cast from blkdev_report_zones()
Date: Fri, 15 Jun 2018 14:55:17 -0700
Message-Id: <20180615215521.27435-2-bart.vanassche@wdc.com>
In-Reply-To: <20180615215521.27435-1-bart.vanassche@wdc.com>
References: <20180615215521.27435-1-bart.vanassche@wdc.com>
List-ID: <linux-block@vger.kernel.org>

No cast is necessary when assigning a non-void pointer to a void
pointer.

Signed-off-by: Bart Van Assche <bart.vanassche@wdc.com>
Reviewed-by: Damien Le Moal <damien.lemoal@wdc.com>
Cc: Matias Bjorling <mb@lightnvm.io>
Cc: Christoph Hellwig <hch@lst.de>
---
 block/blk-zoned.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/block/blk-zoned.c b/block/blk-zoned.c
index 3d08dc84db16..92e6108487c4 100644
--- a/block/blk-zoned.c
+++ b/block/blk-zoned.c
@@ -200,7 +200,7 @@ int blkdev_report_zones(struct block_device *bdev,
 		/* Get header in the first page */
 		ofst = 0;
 		if (!nr_rep) {
-			hdr = (struct blk_zone_report_hdr *) addr;
+			hdr = addr;
 			nr_rep = hdr->nr_zones;
 			ofst = sizeof(struct blk_zone_report_hdr);
 		}
-- 
2.17.0
