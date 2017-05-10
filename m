Return-Path: <linux-fsdevel-owner@vger.kernel.org>
From: Dmitry Monakhov <dmonakhov@openvz.org>
To: fstests@vger.kernel.org
Cc: linux-fsdevel@vger.kernel.org, linux-block@vger.kernel.org,
        Dmitry Monakhov <dmonakhov@openvz.org>
Subject: [PATCH 9/9] bio-integrity: Restore original iterator on verify stage
Date: Wed, 10 May 2017 19:20:52 +0400
Message-Id: <1494429652-9488-10-git-send-email-dmonakhov@openvz.org>
In-Reply-To: <1494429652-9488-1-git-send-email-dmonakhov@openvz.org>
References: <1494429652-9488-1-git-send-email-dmonakhov@openvz.org>
Sender: linux-fsdevel-owner@vger.kernel.org
List-ID: <linux-block@vger.kernel.org>

Currently ->verify_fn not woks at all because at the moment it is called
bio->bi_iter.bi_size == 0, so we do not iterate integrity bvecs at all.

In order to perform verification we need to know original data vector,
with new bvec rewind API this is trivial.

testcase: https://github.com/dmonakhov/xfstests/commit/3c6509eaa83b9c17cd0bc95d73fcdd76e1c54a85

Reviewed-by: Hannes Reinecke <hare@suse.com>
Reviewed-by: Christoph Hellwig <hch@lst.de>
Signed-off-by: Dmitry Monakhov <dmonakhov@openvz.org>
---
 block/bio-integrity.c | 22 +++++++++++++++-------
 1 file changed, 15 insertions(+), 7 deletions(-)

diff --git a/block/bio-integrity.c b/block/bio-integrity.c
index 9b9ace3..4b03128 100644
--- a/block/bio-integrity.c
+++ b/block/bio-integrity.c
@@ -184,9 +184,10 @@ static inline unsigned int bio_integrity_bytes(struct blk_integrity *bi,
 /**
  * bio_integrity_process - Process integrity metadata for a bio
  * @bio:	bio to generate/verify integrity metadata for
+ * @proc_iter:  iterator to process
  * @proc_fn:	Pointer to the relevant processing function
  */
-static int bio_integrity_process(struct bio *bio,
+static int bio_integrity_process(struct bio *bio, struct bvec_iter *proc_iter,
 				 integrity_processing_fn *proc_fn)
 {
 	struct blk_integrity *bi = bdev_get_integrity(bio->bi_bdev);
@@ -200,10 +201,10 @@ static int bio_integrity_process(struct bio *bio,
 
 	iter.disk_name = bio->bi_bdev->bd_disk->disk_name;
 	iter.interval = 1 << bi->interval_exp;
-	iter.seed = bip_get_seed(bip);
+	iter.seed = proc_iter->bi_sector;
 	iter.prot_buf = prot_buf;
 
-	bio_for_each_segment(bv, bio, bviter) {
+	__bio_for_each_segment(bv, bio, bviter, *proc_iter) {
 		void *kaddr = kmap_atomic(bv.bv_page);
 
 		iter.data_buf = kaddr + bv.bv_offset;
@@ -333,7 +334,8 @@ int bio_integrity_prep(struct bio *bio)
 
 	/* Auto-generate integrity metadata if this is a write */
 	if (bio_data_dir(bio) == WRITE)
-		bio_integrity_process(bio, bi->profile->generate_fn);
+		bio_integrity_process(bio, &bio->bi_iter,
+				      bi->profile->generate_fn);
 	return 0;
 err_end_io:
 	bio->bi_error = err;
@@ -357,9 +359,15 @@ static void bio_integrity_verify_fn(struct work_struct *work)
 		container_of(work, struct bio_integrity_payload, bip_work);
 	struct bio *bio = bip->bip_bio;
 	struct blk_integrity *bi = bdev_get_integrity(bio->bi_bdev);
-
-	bio->bi_error = bio_integrity_process(bio, bi->profile->verify_fn);
-
+	struct bvec_iter iter = bio->bi_iter;
+
+	/* At the moment verify is called bio's iterator was advanced
+	 * during split and completion, we need to rewind iterator to
+	 * it's original position */
+	bio->bi_error = bio_rewind_iter(bio, &iter, iter.bi_done);
+	if (!bio->bi_error)
+		bio->bi_error = bio_integrity_process(bio, &iter,
+						      bi->profile->verify_fn);
 	/* Restore original bio completion handler */
 	bio->bi_end_io = bip->bip_end_io;
 	bio_endio(bio);
-- 
2.9.3
