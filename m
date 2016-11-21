Return-Path: <shaun.tancheff@gmail.com>
Return-Path: <shaun.tancheff@gmail.com>
Sender: Shaun Tancheff <shaun.tancheff@gmail.com>
From: Shaun Tancheff <shaun@tancheff.com>
To: Jens Axboe <axboe@kernel.dk>
Cc: Shaun Tancheff <shaun@tancheff.com>,
	linux-block@vger.kernel.org,
	Christoph Hellwig <hch@lst.de>,
	Damien Le Moal <damien.lemoal@hgst.com>,
	Hannes Reinecke <hare@suse.de>,
	Michael T Lombardi <michael.t.lombardi@seagate.com>,
	Shaun Tancheff <shaun.tancheff@seagate.com>
Subject: [PATCH] Apply blk_partition_remap to REQ_OP_ZONE_RESET
Date: Mon, 21 Nov 2016 13:00:11 -0600
Message-Id: <20161121190011.13259-1-shaun@tancheff.com>
List-ID: <linux-block@vger.kernel.org>

When a Reset WP is requested from a partition offset the blk_partition_remap
should be applied.

Signed-off-by: Shaun Tancheff <shaun.tancheff@seagate.com>
---
Based on for-4.10/block
---
 block/blk-core.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/block/blk-core.c b/block/blk-core.c
index 473dd69..3f85320 100644
--- a/block/blk-core.c
+++ b/block/blk-core.c
@@ -1786,8 +1786,9 @@ static blk_qc_t blk_queue_bio(struct request_queue *q, struct bio *bio)
 static inline void blk_partition_remap(struct bio *bio)
 {
 	struct block_device *bdev = bio->bi_bdev;
+	bool remap = bio_sectors(bio) != 0 || bio_op(bio) == REQ_OP_ZONE_RESET;
 
-	if (bio_sectors(bio) && bdev != bdev->bd_contains) {
+	if (remap && bdev != bdev->bd_contains) {
 		struct hd_struct *p = bdev->bd_part;
 
 		bio->bi_iter.bi_sector += p->start_sect;
-- 
2.10.2
