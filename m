Return-Path: <keith.busch@intel.com>
From: Keith Busch <keith.busch@intel.com>
To: Jens Axboe <axboe@kernel.dk>,
	linux-block <linux-block@vger.kernel.org>
Cc: Keith Busch <keith.busch@intel.com>,
	Christoph Hellwig <hch@lst.de>
Subject: [PATCH for-next] block: Fix left-over bi_bdev usage
Date: Wed, 23 Aug 2017 19:45:55 -0400
Message-Id: <1503531955-2626-1-git-send-email-keith.busch@intel.com>
List-ID: <linux-block@vger.kernel.org>

The bi_bdev field was replaced with the gendisk. This patch just fixes
an omission.

Cc: Christoph Hellwig <hch@lst.de>
Signed-off-by: Keith Busch <keith.busch@intel.com>
---
 block/bio-integrity.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/block/bio-integrity.c b/block/bio-integrity.c
index b4737af..5df3290 100644
--- a/block/bio-integrity.c
+++ b/block/bio-integrity.c
@@ -385,7 +385,7 @@ static void bio_integrity_verify_fn(struct work_struct *work)
  */
 bool __bio_integrity_endio(struct bio *bio)
 {
-	struct blk_integrity *bi = bdev_get_integrity(bio->bi_bdev);
+	struct blk_integrity *bi = blk_get_integrity(bio->bi_disk);
 	struct bio_integrity_payload *bip = bio_integrity(bio);
 
 	if (bio_op(bio) == REQ_OP_READ && !bio->bi_status &&
-- 
2.5.5
