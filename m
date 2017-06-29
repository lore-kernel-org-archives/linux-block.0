Return-Path: <linux-block-owner@vger.kernel.org>
Received: from verein.lst.de ([213.95.11.211]:55926 "EHLO newverein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752822AbdF2RPy (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Thu, 29 Jun 2017 13:15:54 -0400
Date: Thu, 29 Jun 2017 19:15:52 +0200
From: Christoph Hellwig <hch@lst.de>
To: Shaohua Li <shli@kernel.org>
Cc: Christoph Hellwig <hch@lst.de>, linux-kernel@vger.kernel.org,
        linux-block@vger.kernel.org, tj@kernel.org,
        gregkh@linuxfoundation.org, axboe@fb.com, rostedt@goodmis.org,
        lizefan@huawei.com, Kernel-team@fb.com, Shaohua Li <shli@fb.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>
Subject: Re: [PATCH V4 10/12] block: call __bio_free in bio_endio
Message-ID: <20170629171552.GA28502@lst.de>
References: <cover.1498666964.git.shli@fb.com> <f1e84225656d403485ac5f1bd8b9f5db42bc74ca.1498666964.git.shli@fb.com> <20170628212908.GA19350@lst.de> <20170628214249.z42lypwtgzgdzh62@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20170628214249.z42lypwtgzgdzh62@kernel.org>
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

On Wed, Jun 28, 2017 at 02:42:49PM -0700, Shaohua Li wrote:
> > bio_integrity_endio -> bio_integrity_verify_fn -> bio_integrity_process
> > access the integrity data, so I don't think this works as-is.
> 
> oh, I probably missed the integrity endio. could we let bio_integrity_verify_fn
> free integrity info and and bio_endio free cgroup info?

something like this (will need the cgroup fixes from you still) should
do the trick, although it's completely untested:

diff --git a/block/bio-integrity.c b/block/bio-integrity.c
index b8a3a65f7364..b66eb92b5a00 100644
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
@@ -340,12 +340,6 @@ int bio_integrity_prep(struct bio *bio)
 		offset = 0;
 	}
 
-	/* Install custom I/O completion handler if read verify is enabled */
-	if (bio_data_dir(bio) == READ) {
-		bip->bip_end_io = bio->bi_end_io;
-		bio->bi_end_io = bio_integrity_endio;
-	}
-
 	/* Auto-generate integrity metadata if this is a write */
 	if (bio_data_dir(bio) == WRITE)
 		bio_integrity_process(bio, bi->profile->generate_fn);
@@ -370,14 +364,12 @@ static void bio_integrity_verify_fn(struct work_struct *work)
 	struct blk_integrity *bi = bdev_get_integrity(bio->bi_bdev);
 
 	bio->bi_status = bio_integrity_process(bio, bi->profile->verify_fn);
-
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
@@ -388,27 +380,19 @@ static void bio_integrity_verify_fn(struct work_struct *work)
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
index 9cf98b29588a..1ac81de06e74 100644
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
index 4907bea03908..b3a05cd49c06 100644
--- a/include/linux/bio.h
+++ b/include/linux/bio.h
@@ -303,8 +303,6 @@ struct bio_integrity_payload {
 
 	struct bvec_iter	bip_iter;
 
-	bio_end_io_t		*bip_end_io;	/* saved I/O completion fn */
-
 	unsigned short		bip_slab;	/* slab the bip came from */
 	unsigned short		bip_vcnt;	/* # of integrity bio_vecs */
 	unsigned short		bip_max_vcnt;	/* integrity bio_vec slots */
@@ -721,11 +719,9 @@ struct biovec_slab {
 		bip_for_each_vec(_bvl, _bio->bi_integrity, _iter)
 
 extern struct bio_integrity_payload *bio_integrity_alloc(struct bio *, gfp_t, unsigned int);
-extern void bio_integrity_free(struct bio *);
 extern int bio_integrity_add_page(struct bio *, struct page *, unsigned int, unsigned int);
 extern bool bio_integrity_enabled(struct bio *bio);
 extern int bio_integrity_prep(struct bio *);
-extern void bio_integrity_endio(struct bio *);
 extern void bio_integrity_advance(struct bio *, unsigned int);
 extern void bio_integrity_trim(struct bio *, unsigned int, unsigned int);
 extern int bio_integrity_clone(struct bio *, struct bio *, gfp_t);
@@ -760,11 +756,6 @@ static inline int bio_integrity_prep(struct bio *bio)
 	return 0;
 }
 
-static inline void bio_integrity_free(struct bio *bio)
-{
-	return;
-}
-
 static inline int bio_integrity_clone(struct bio *bio, struct bio *bio_src,
 				      gfp_t gfp_mask)
 {
