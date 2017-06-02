Return-Path: <gqjiang@suse.com>
From: Guoqing Jiang <gqjiang@suse.com>
To: axboe@kernel.dk
Cc: linux-block@vger.kernel.org,
	Guoqing Jiang <gqjiang@suse.com>
Subject: [PATCH] block: simplify code with bio_io_error
Date: Fri,  2 Jun 2017 16:19:22 +0800
Message-Id: <20170602081922.27490-1-gqjiang@suse.com>
List-ID: <linux-block@vger.kernel.org>

bio_io_error was introduced in the commit 4246a0b
("block: add a bi_error field to struct bio"), so
use it directly.

Signed-off-by: Guoqing Jiang <gqjiang@suse.com>
---
 block/blk-core.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/block/blk-core.c b/block/blk-core.c
index c706852..92bc663 100644
--- a/block/blk-core.c
+++ b/block/blk-core.c
@@ -1662,8 +1662,7 @@ static blk_qc_t blk_queue_bio(struct request_queue *q, struct bio *bio)
 	blk_queue_split(q, &bio, q->bio_split);
 
 	if (bio_integrity_enabled(bio) && bio_integrity_prep(bio)) {
-		bio->bi_error = -EIO;
-		bio_endio(bio);
+		bio_io_error(bio);
 		return BLK_QC_T_NONE;
 	}
 
-- 
2.10.0
