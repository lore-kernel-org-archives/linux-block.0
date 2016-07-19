Return-Path: <BATV+a6fbff1bfc78a84bb09b+4713+infradead.org+hch@bombadil.srs.infradead.org>
From: Christoph Hellwig <hch@lst.de>
To: axboe@kernel.dk
Cc: shli@fb.com,
	martin.petersen@oracle.com,
	snitzer@redhat.com,
	sitsofe@yahoo.com,
	linux-block@vger.kernel.org
Subject: [PATCH 1/2] block: introduce BLKDEV_DISCARD_ZERO to fix zeroout
Date: Tue, 19 Jul 2016 11:23:33 +0200
Message-Id: <1468920214-32400-2-git-send-email-hch@lst.de>
In-Reply-To: <1468920214-32400-1-git-send-email-hch@lst.de>
References: <1468920214-32400-1-git-send-email-hch@lst.de>
List-ID: <linux-block@vger.kernel.org>

Currently blkdev_issue_zeroout cascades down from discards (if the driver
guarantees that discards zero data), to WRITE SAME and then to a loop
writing zeroes.  Unfortunately we ignore run-time EOPNOTSUPP errors in the
block layer blkdev_issue_discard helper to work around DM volumes that
may have mixed discard support underneath.

This patch intoroduces a new BLKDEV_DISCARD_ZERO flag to
blkdev_issue_discard that indicates we are called for zeroing operation.
This allows both to ignore the EOPNOTSUPP hack and actually consolidating
the discard_zeroes_data check into the function.

Signed-off-by: Christoph Hellwig <hch@lst.de>
Reviewed-by: Martin K. Petersen <martin.petersen@oracle.com>
---
 block/blk-lib.c        | 17 +++++++++++------
 include/linux/blkdev.h |  4 +++-
 2 files changed, 14 insertions(+), 7 deletions(-)

diff --git a/block/blk-lib.c b/block/blk-lib.c
index 78626c2..45b35b1 100644
--- a/block/blk-lib.c
+++ b/block/blk-lib.c
@@ -36,12 +36,17 @@ int __blkdev_issue_discard(struct block_device *bdev, sector_t sector,
 		return -ENXIO;
 
 	if (flags & BLKDEV_DISCARD_SECURE) {
+		if (flags & BLKDEV_DISCARD_ZERO)
+			return -EOPNOTSUPP;
 		if (!blk_queue_secure_erase(q))
 			return -EOPNOTSUPP;
 		op = REQ_OP_SECURE_ERASE;
 	} else {
 		if (!blk_queue_discard(q))
 			return -EOPNOTSUPP;
+		if ((flags & BLKDEV_DISCARD_ZERO) &&
+		    !q->limits.discard_zeroes_data)
+			return -EOPNOTSUPP;
 		op = REQ_OP_DISCARD;
 	}
 
@@ -116,7 +121,7 @@ int blkdev_issue_discard(struct block_device *bdev, sector_t sector,
 			&bio);
 	if (!ret && bio) {
 		ret = submit_bio_wait(bio);
-		if (ret == -EOPNOTSUPP)
+		if (ret == -EOPNOTSUPP && !(flags & BLKDEV_DISCARD_ZERO))
 			ret = 0;
 	}
 	blk_finish_plug(&plug);
@@ -241,11 +246,11 @@ static int __blkdev_issue_zeroout(struct block_device *bdev, sector_t sector,
 int blkdev_issue_zeroout(struct block_device *bdev, sector_t sector,
 			 sector_t nr_sects, gfp_t gfp_mask, bool discard)
 {
-	struct request_queue *q = bdev_get_queue(bdev);
-
-	if (discard && blk_queue_discard(q) && q->limits.discard_zeroes_data &&
-	    blkdev_issue_discard(bdev, sector, nr_sects, gfp_mask, 0) == 0)
-		return 0;
+	if (discard) {
+		if (!blkdev_issue_discard(bdev, sector, nr_sects, gfp_mask,
+				BLKDEV_DISCARD_ZERO))
+			return 0;
+	}
 
 	if (bdev_write_same(bdev) &&
 	    blkdev_issue_write_same(bdev, sector, nr_sects, gfp_mask,
diff --git a/include/linux/blkdev.h b/include/linux/blkdev.h
index 9ae49cc..03fa3d1 100644
--- a/include/linux/blkdev.h
+++ b/include/linux/blkdev.h
@@ -1136,7 +1136,9 @@ static inline struct request *blk_map_queue_find_tag(struct blk_queue_tag *bqt,
 	return bqt->tag_index[tag];
 }
 
-#define BLKDEV_DISCARD_SECURE  0x01    /* secure discard */
+
+#define BLKDEV_DISCARD_SECURE	(1 << 0)	/* issue a secure erase */
+#define BLKDEV_DISCARD_ZERO	(1 << 1)	/* must reliably zero data */
 
 extern int blkdev_issue_flush(struct block_device *, gfp_t, sector_t *);
 extern int blkdev_issue_discard(struct block_device *bdev, sector_t sector,
-- 
2.1.4
