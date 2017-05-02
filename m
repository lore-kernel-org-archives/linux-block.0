Return-Path: <neilb@suse.de>
From: NeilBrown <neilb@suse.com>
To: Jens Axboe <axboe@kernel.dk>
Date: Tue, 02 May 2017 13:42:25 +1000
Subject: [PATCH 10/13] xen-blkfront: remove bio splitting.
Cc: linux-block@vger.kernel.org, Ming Lei <tom.leiming@gmail.com>,
 linux-kernel@vger.kernel.org
Message-ID: <149369654578.5146.16549743448824620743.stgit@noble>
In-Reply-To: <149369628671.5146.4865312503373040039.stgit@noble>
References: <149369628671.5146.4865312503373040039.stgit@noble>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
List-ID: <linux-block@vger.kernel.org>

bios that are re-submitted will pass through blk_queue_split() when
blk_queue_bio() is called, and this will split the bio if necessary.
There is no longer any need to do this splitting in xen-blkfront.

Acked-by: Roger Pau Monné <roger.pau@citrix.com>
Signed-off-by: NeilBrown <neilb@suse.com>
---
 drivers/block/xen-blkfront.c |   54 ++----------------------------------------
 1 file changed, 3 insertions(+), 51 deletions(-)

diff --git a/drivers/block/xen-blkfront.c b/drivers/block/xen-blkfront.c
index 39459631667c..fb963a010d4d 100644
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
@@ -1996,28 +1991,13 @@ static int blkfront_probe(struct xenbus_device *dev,
 	return 0;
 }
 
-static void split_bio_end(struct bio *bio)
-{
-	struct split_bio *split_bio = bio->bi_private;
-
-	if (atomic_dec_and_test(&split_bio->pending)) {
-		split_bio->bio->bi_phys_segments = 0;
-		split_bio->bio->bi_error = bio->bi_error;
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
@@ -2056,34 +2036,6 @@ static int blkif_recover(struct blkfront_info *info)
 
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
 
