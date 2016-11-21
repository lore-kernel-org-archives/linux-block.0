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
Subject: [PATCH v2] Apply blk_partition_remap to REQ_OP_ZONE_RESET
Date: Mon, 21 Nov 2016 15:52:23 -0600
Message-Id: <20161121215223.31658-1-shaun@tancheff.com>
In-Reply-To: <f32c3115-dabb-d04b-2b77-2b2169e2229a@kernel.dk>
References: <f32c3115-dabb-d04b-2b77-2b2169e2229a@kernel.dk>
List-ID: <linux-block@vger.kernel.org>

If a ZBC device is partitioned and operations are performed on the partition
the zone information is rebased to the partition, however the zone reset
is not mapped from the partition to device as are other operations.

This causes the API (report zones / reset zone) to be unbalanced in this
regard. Checking for the zone reset op code explicitly will balance the
API.

Signed-off-by: Shaun Tancheff <shaun.tancheff@seagate.com>
---
v2: 
 - Moved conditional check
 - Added comments and update commit message

Based on for-4.10/block
---
 block/blk-core.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/block/blk-core.c b/block/blk-core.c
index 473dd69..6c4a425 100644
--- a/block/blk-core.c
+++ b/block/blk-core.c
@@ -1787,7 +1787,12 @@ static inline void blk_partition_remap(struct bio *bio)
 {
 	struct block_device *bdev = bio->bi_bdev;
 
-	if (bio_sectors(bio) && bdev != bdev->bd_contains) {
+	/*
+	 * Zone reset does not include bi_size so bio_sectors() is always 0.
+	 * Include a test for the reset op code and perform the remap if needed.
+	 */
+	if (bdev != bdev->bd_contains &&
+	    (bio_sectors(bio) || bio_op(bio) == REQ_OP_ZONE_RESET)) {
 		struct hd_struct *p = bdev->bd_part;
 
 		bio->bi_iter.bi_sector += p->start_sect;
-- 
2.10.2
