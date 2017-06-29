Return-Path: <BATV+a3f5f3e6054314e6ea5e+5058+infradead.org+hch@bombadil.srs.infradead.org>
From: Christoph Hellwig <hch@lst.de>
To: Jens Axboe <axboe@kernel.dk>
Cc: Dmitry Monakhov <dmonakhov@openvz.org>,
	"Martin K. Petersen" <martin.petersen@oracle.com>,
	Shaohua Li <shli@kernel.org>,
	linux-fsdevel@vger.kernel.org,
	linux-block@vger.kernel.org
Subject: [PATCH 9/9] bio-integrity: stop abusing bi_end_io
Date: Thu, 29 Jun 2017 11:31:16 -0700
Message-Id: <20170629183116.28685-10-hch@lst.de>
In-Reply-To: <20170629183116.28685-1-hch@lst.de>
References: <20170629183116.28685-1-hch@lst.de>
List-ID: <linux-block@vger.kernel.org>

And instead call directly into the integrity code from bio_end_io.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 block/bio-integrity.c | 39 ++++++++++++---------------------------
 block/bio.c           |  5 ++---
 block/blk.h           | 11 +++++++++++
 include/linux/bio.h   |  9 ---------
 4 files changed, 25 insertions(+), 39 deletions(-)

diff --git a/block/bio-integrity.c b/block/bio-integrity.c
index 8df4eb103ba9..f733beab6ca2 100644
--- a/block/bio-integrity.c
+++ b/block/bio-integrity.c
@@ -102,7 +102,7 @@ EXPORT_SYMBOL(bio_integrity_alloc);
  * Description: Used to free the integrity portion of a bio. Usually
  * called from bio_free().
  */
-void bio_integrity_free(struct bio *bio)
+static void bio_integrity_free(struct bio *bio)
 {
 	struct bio_integrity_payload *bip = bio_integrity(bio);
 	struct bio_set *bs = bio->bi_pool;
@@ -120,8 +120,8 @@ void bio_integrity_free(struct bio *bio)
 	}
 
 	bio->bi_integrity = NULL;
+	bio->bi_opf &= ~REQ_INTEGRITY;
 }
-EXPORT_SYMBOL(bio_integrity_free);
 
 /**
  * bio_integrity_add_page - Attach integrity metadata
@@ -326,12 +326,6 @@ bool bio_integrity_prep(struct bio *bio)
 		offset = 0;
 	}
 
-	/* Install custom I/O completion handler if read verify is enabled */
-	if (bio_data_dir(bio) == READ) {
-		bip->bip_end_io = bio->bi_end_io;
-		bio->bi_end_io = bio_integrity_endio;
-	}
-
 	/* Auto-generate integrity metadata if this is a write */
 	if (bio_data_dir(bio) == WRITE) {
 		bio_integrity_process(bio, &bio->bi_iter,
@@ -375,13 +369,12 @@ static void bio_integrity_verify_fn(struct work_struct *work)
 		bio->bi_status = BLK_STS_IOERR;
 	}
 
-	/* Restore original bio completion handler */
-	bio->bi_end_io = bip->bip_end_io;
+	bio_integrity_free(bio);
 	bio_endio(bio);
 }
 
 /**
- * bio_integrity_endio - Integrity I/O completion function
+ * __bio_integrity_endio - Integrity I/O completion function
  * @bio:	Protected bio
  * @error:	Pointer to errno
  *
@@ -392,27 +385,19 @@ static void bio_integrity_verify_fn(struct work_struct *work)
  * in process context.	This function postpones completion
  * accordingly.
  */
-void bio_integrity_endio(struct bio *bio)
+bool __bio_integrity_endio(struct bio *bio)
 {
-	struct bio_integrity_payload *bip = bio_integrity(bio);
+	if (bio_op(bio) == REQ_OP_READ && !bio->bi_status) {
+		struct bio_integrity_payload *bip = bio_integrity(bio);
 
-	BUG_ON(bip->bip_bio != bio);
-
-	/* In case of an I/O error there is no point in verifying the
-	 * integrity metadata.  Restore original bio end_io handler
-	 * and run it.
-	 */
-	if (bio->bi_status) {
-		bio->bi_end_io = bip->bip_end_io;
-		bio_endio(bio);
-
-		return;
+		INIT_WORK(&bip->bip_work, bio_integrity_verify_fn);
+		queue_work(kintegrityd_wq, &bip->bip_work);
+		return false;
 	}
 
-	INIT_WORK(&bip->bip_work, bio_integrity_verify_fn);
-	queue_work(kintegrityd_wq, &bip->bip_work);
+	bio_integrity_free(bio);
+	return true;
 }
-EXPORT_SYMBOL(bio_integrity_endio);
 
 /**
  * bio_integrity_advance - Advance integrity vector
diff --git a/block/bio.c b/block/bio.c
index 7a288d344638..48075f671c49 100644
--- a/block/bio.c
+++ b/block/bio.c
@@ -243,9 +243,6 @@ struct bio_vec *bvec_alloc(gfp_t gfp_mask, int nr, unsigned long *idx,
 static void __bio_free(struct bio *bio)
 {
 	bio_disassociate_task(bio);
-
-	if (bio_integrity(bio))
-		bio_integrity_free(bio);
 }
 
 static void bio_free(struct bio *bio)
@@ -1807,6 +1804,8 @@ void bio_endio(struct bio *bio)
 again:
 	if (!bio_remaining_done(bio))
 		return;
+	if (!bio_integrity_endio(bio))
+		return;
 
 	/*
 	 * Need to have a real endio function for chained bios, otherwise
diff --git a/block/blk.h b/block/blk.h
index 01ebb8185f6b..921106babba8 100644
--- a/block/blk.h
+++ b/block/blk.h
@@ -81,10 +81,21 @@ static inline void blk_queue_enter_live(struct request_queue *q)
 
 #ifdef CONFIG_BLK_DEV_INTEGRITY
 void blk_flush_integrity(void);
+bool __bio_integrity_endio(struct bio *);
+static inline bool bio_integrity_endio(struct bio *bio)
+{
+	if (bio_integrity(bio))
+		return __bio_integrity_endio(bio);
+	return true;
+}
 #else
 static inline void blk_flush_integrity(void)
 {
 }
+static inline bool bio_integrity_endio(struct bio *)
+{
+	return true;
+}
 #endif
 
 void blk_timeout_work(struct work_struct *work);
diff --git a/include/linux/bio.h b/include/linux/bio.h
index 7b989233e8d0..8a56a5057089 100644
--- a/include/linux/bio.h
+++ b/include/linux/bio.h
@@ -320,8 +320,6 @@ struct bio_integrity_payload {
 
 	struct bvec_iter	bip_iter;
 
-	bio_end_io_t		*bip_end_io;	/* saved I/O completion fn */
-
 	unsigned short		bip_slab;	/* slab the bip came from */
 	unsigned short		bip_vcnt;	/* # of integrity bio_vecs */
 	unsigned short		bip_max_vcnt;	/* integrity bio_vec slots */
@@ -738,10 +736,8 @@ struct biovec_slab {
 		bip_for_each_vec(_bvl, _bio->bi_integrity, _iter)
 
 extern struct bio_integrity_payload *bio_integrity_alloc(struct bio *, gfp_t, unsigned int);
-extern void bio_integrity_free(struct bio *);
 extern int bio_integrity_add_page(struct bio *, struct page *, unsigned int, unsigned int);
 extern bool bio_integrity_prep(struct bio *);
-extern void bio_integrity_endio(struct bio *);
 extern void bio_integrity_advance(struct bio *, unsigned int);
 extern void bio_integrity_trim(struct bio *);
 extern int bio_integrity_clone(struct bio *, struct bio *, gfp_t);
@@ -771,11 +767,6 @@ static inline bool bio_integrity_prep(struct bio *bio)
 	return true;
 }
 
-static inline void bio_integrity_free(struct bio *bio)
-{
-	return;
-}
-
 static inline int bio_integrity_clone(struct bio *bio, struct bio *bio_src,
 				      gfp_t gfp_mask)
 {
-- 
2.11.0
