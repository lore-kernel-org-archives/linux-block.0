Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mail-lf0-f67.google.com ([209.85.215.67]:33239 "EHLO
        mail-lf0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755478AbdDDS47 (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Tue, 4 Apr 2017 14:56:59 -0400
From: Dmitry Monakhov <dmonakhov@openvz.org>
To: linux-kernel@vger.kernel.org, linux-block@vger.kernel.org,
        martin.petersen@oracle.com
Cc: Dmitry Monakhov <dmonakhov@openvz.org>
Subject: [PATCH 9/9] bio-integrity: Restore original iterator on verify stage
Date: Tue,  4 Apr 2017 22:56:41 +0400
Message-Id: <1491332201-26926-10-git-send-email-dmonakhov@openvz.org>
In-Reply-To: <1491332201-26926-1-git-send-email-dmonakhov@openvz.org>
References: <1491332201-26926-1-git-send-email-dmonakhov@openvz.org>
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

Currently ->verify_fn not woks at all because at the moment it is called
bio->bi_iter.bi_size == 0, so we do not iterate integrity bvecs at all.

In order to perform verification we need to know original data vector,
with new bvec rewind API this is trivial.

testcase: https://github.com/dmonakhov/xfstests/commit/3c6509eaa83b9c17cd0bc95d73fcdd76e1c54a85
Signed-off-by: Dmitry Monakhov <dmonakhov@openvz.org>
---
 block/bio-integrity.c | 22 +++++++++++++++-------
 1 file changed, 15 insertions(+), 7 deletions(-)

diff --git a/block/bio-integrity.c b/block/bio-integrity.c
index f2b9f09..f08096d 100644
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
@@ -310,7 +311,8 @@ static int bio_integrity_setup(struct bio *bio)
 
 	/* Auto-generate integrity metadata if this is a write */
 	if (bio_data_dir(bio) == WRITE)
-		bio_integrity_process(bio, bi->profile->generate_fn);
+		bio_integrity_process(bio, &bio->bi_iter,
+				      bi->profile->generate_fn);
 
 	return 0;
 }
@@ -376,9 +378,15 @@ static void bio_integrity_verify_fn(struct work_struct *work)
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
+	bio_rewind_iter(bio, &iter, iter.bi_done);
+	if (!bio->bi_error)
+		bio->bi_error = bio_integrity_process(bio, &iter,
+						      bi->profile->verify_fn);
 	/* Restore original bio completion handler */
 	bio->bi_end_io = bip->bip_end_io;
 	bio_endio(bio);
-- 
2.9.3
