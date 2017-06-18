Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mx2.suse.de ([195.135.220.15]:44909 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1753165AbdFREkk (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Sun, 18 Jun 2017 00:40:40 -0400
From: NeilBrown <neilb@suse.com>
To: Jens Axboe <axboe@fb.com>
Date: Sun, 18 Jun 2017 14:38:59 +1000
Subject: [PATCH 10/13] xen-blkfront: remove bio splitting.
Cc: linux-block@vger.kernel.org, linux-kernel@vger.kernel.org
Message-ID: <149776073893.23258.10276463631717782734.stgit@noble>
In-Reply-To: <149776047907.23258.8058071140236879834.stgit@noble>
References: <149776047907.23258.8058071140236879834.stgit@noble>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

bios that are re-submitted will pass through blk_queue_split() when
blk_queue_bio() is called, and this will split the bio if necessary.
There is no longer any need to do this splitting in xen-blkfront.

Acked-by: Roger Pau Monné <roger.pau@citrix.com>
Reviewed-by: Christoph Hellwig <hch@lst.de>
Signed-off-by: NeilBrown <neilb@suse.com>
---
 drivers/block/xen-blkfront.c |   54 ++----------------------------------------
 1 file changed, 3 insertions(+), 51 deletions(-)

diff --git a/drivers/block/xen-blkfront.c b/drivers/block/xen-blkfront.c
index e3be666c2776..ac90093fcb25 100644
--- a/drivers/block/xen-blkfront.c
+++ b/drivers/block/xen-blkfront.c
@@ -110,11 +110,6 @@ struct blk_shadow {
 	unsigned long associated_id;
 };
 
-struct split_bio {
-	struct bio *bio;
-	atomic_t pending;
-};
-
 struct blkif_req {
 	int	error;
 };
@@ -2000,28 +1995,13 @@ static int blkfront_probe(struct xenbus_device *dev,
 	return 0;
 }
 
-static void split_bio_end(struct bio *bio)
-{
-	struct split_bio *split_bio = bio->bi_private;
-
-	if (atomic_dec_and_test(&split_bio->pending)) {
-		split_bio->bio->bi_phys_segments = 0;
-		split_bio->bio->bi_status = bio->bi_status;
-		bio_endio(split_bio->bio);
-		kfree(split_bio);
-	}
-	bio_put(bio);
-}
-
 static int blkif_recover(struct blkfront_info *info)
 {
-	unsigned int i, r_index;
+	unsigned int r_index;
 	struct request *req, *n;
 	int rc;
-	struct bio *bio, *cloned_bio;
-	unsigned int segs, offset;
-	int pending, size;
-	struct split_bio *split_bio;
+	struct bio *bio;
+	unsigned int segs;
 
 	blkfront_gather_backend_features(info);
 	/* Reset limits changed by blk_mq_update_nr_hw_queues(). */
@@ -2060,34 +2040,6 @@ static int blkif_recover(struct blkfront_info *info)
 
 	while ((bio = bio_list_pop(&info->bio_list)) != NULL) {
 		/* Traverse the list of pending bios and re-queue them */
-		if (bio_segments(bio) > segs) {
-			/*
-			 * This bio has more segments than what we can
-			 * handle, we have to split it.
-			 */
-			pending = (bio_segments(bio) + segs - 1) / segs;
-			split_bio = kzalloc(sizeof(*split_bio), GFP_NOIO);
-			BUG_ON(split_bio == NULL);
-			atomic_set(&split_bio->pending, pending);
-			split_bio->bio = bio;
-			for (i = 0; i < pending; i++) {
-				offset = (i * segs * XEN_PAGE_SIZE) >> 9;
-				size = min((unsigned int)(segs * XEN_PAGE_SIZE) >> 9,
-					   (unsigned int)bio_sectors(bio) - offset);
-				cloned_bio = bio_clone(bio, GFP_NOIO);
-				BUG_ON(cloned_bio == NULL);
-				bio_trim(cloned_bio, offset, size);
-				cloned_bio->bi_private = split_bio;
-				cloned_bio->bi_end_io = split_bio_end;
-				submit_bio(cloned_bio);
-			}
-			/*
-			 * Now we have to wait for all those smaller bios to
-			 * end, so we can also end the "parent" bio.
-			 */
-			continue;
-		}
-		/* We don't need to split this bio */
 		submit_bio(bio);
 	}
 
