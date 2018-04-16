Return-Path: <javier@javigon.com>
Return-Path: <javier@javigon.com>
From: "=?UTF-8?q?Javier=20Gonz=C3=A1lez?=" <javier@javigon.com>
To: mb@lightnvm.io
Cc: axboe@kernel.dk,
	linux-block@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	=?UTF-8?q?Javier=20Gonz=C3=A1lez?= <javier@cnexlabs.com>
Subject: [PATCH] lightnvm: pblk: remove unnecessary bio_get/put
Date: Mon, 16 Apr 2018 12:22:37 +0200
Message-Id: <1523874157-5216-1-git-send-email-javier@cnexlabs.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
List-ID: <linux-block@vger.kernel.org>

In the read path, pblk gets a reference to the incoming bio and puts it
after ending the bio. Though this behavior is correct, it is unnecessary
since pblk is the one putting the bio, therefore, it cannot disappear
underneath it.

Removing this reference, allows to clean up rqd->bio and avoid pointer
bouncing for the different read paths. Now, the incoming bio always
resides in the read context and pblk's internal bios (if any) reside in
rqd->bio.

Signed-off-by: Javier González <javier@cnexlabs.com>
---
 drivers/lightnvm/pblk-read.c | 57 +++++++++++++++++++-------------------------
 1 file changed, 24 insertions(+), 33 deletions(-)

diff --git a/drivers/lightnvm/pblk-read.c b/drivers/lightnvm/pblk-read.c
index 2f8224354c62..5464e4177c87 100644
--- a/drivers/lightnvm/pblk-read.c
+++ b/drivers/lightnvm/pblk-read.c
@@ -39,10 +39,10 @@ static int pblk_read_from_cache(struct pblk *pblk, struct bio *bio,
 }
 
 static void pblk_read_ppalist_rq(struct pblk *pblk, struct nvm_rq *rqd,
-				 sector_t blba, unsigned long *read_bitmap)
+				 struct bio *bio, sector_t blba,
+				 unsigned long *read_bitmap)
 {
 	struct pblk_sec_meta *meta_list = rqd->meta_list;
-	struct bio *bio = rqd->bio;
 	struct ppa_addr ppas[PBLK_MAX_REQ_ADDRS];
 	int nr_secs = rqd->nr_ppas;
 	bool advanced_bio = false;
@@ -189,7 +189,6 @@ static void pblk_end_user_read(struct bio *bio)
 	WARN_ONCE(bio->bi_status, "pblk: corrupted read bio\n");
 #endif
 	bio_endio(bio);
-	bio_put(bio);
 }
 
 static void __pblk_end_io_read(struct pblk *pblk, struct nvm_rq *rqd,
@@ -197,23 +196,18 @@ static void __pblk_end_io_read(struct pblk *pblk, struct nvm_rq *rqd,
 {
 	struct nvm_tgt_dev *dev = pblk->dev;
 	struct pblk_g_ctx *r_ctx = nvm_rq_to_pdu(rqd);
-	struct bio *bio = rqd->bio;
+	struct bio *int_bio = rqd->bio;
 	unsigned long start_time = r_ctx->start_time;
 
 	generic_end_io_acct(dev->q, READ, &pblk->disk->part0, start_time);
 
 	if (rqd->error)
 		pblk_log_read_err(pblk, rqd);
-#ifdef CONFIG_NVM_DEBUG
-	else
-		WARN_ONCE(bio->bi_status, "pblk: corrupted read error\n");
-#endif
 
 	pblk_read_check_seq(pblk, rqd, r_ctx->lba);
 
-	bio_put(bio);
-	if (r_ctx->private)
-		pblk_end_user_read((struct bio *)r_ctx->private);
+	if (int_bio)
+		bio_put(int_bio);
 
 	if (put_line)
 		pblk_read_put_rqd_kref(pblk, rqd);
@@ -230,16 +224,19 @@ static void __pblk_end_io_read(struct pblk *pblk, struct nvm_rq *rqd,
 static void pblk_end_io_read(struct nvm_rq *rqd)
 {
 	struct pblk *pblk = rqd->private;
+	struct pblk_g_ctx *r_ctx = nvm_rq_to_pdu(rqd);
+	struct bio *bio = (struct bio *)r_ctx->private;
 
+	pblk_end_user_read(bio);
 	__pblk_end_io_read(pblk, rqd, true);
 }
 
-static int pblk_partial_read_bio(struct pblk *pblk, struct nvm_rq *rqd,
-				 unsigned int bio_init_idx,
-				 unsigned long *read_bitmap)
+static int pblk_partial_read(struct pblk *pblk, struct nvm_rq *rqd,
+			     struct bio *orig_bio, unsigned int bio_init_idx,
+			     unsigned long *read_bitmap)
 {
-	struct bio *new_bio, *bio = rqd->bio;
 	struct pblk_sec_meta *meta_list = rqd->meta_list;
+	struct bio *new_bio;
 	struct bio_vec src_bv, dst_bv;
 	void *ppa_ptr = NULL;
 	void *src_p, *dst_p;
@@ -319,7 +316,7 @@ static int pblk_partial_read_bio(struct pblk *pblk, struct nvm_rq *rqd,
 		meta_list[hole].lba = lba_list_media[i];
 
 		src_bv = new_bio->bi_io_vec[i++];
-		dst_bv = bio->bi_io_vec[bio_init_idx + hole];
+		dst_bv = orig_bio->bi_io_vec[bio_init_idx + hole];
 
 		src_p = kmap_atomic(src_bv.bv_page);
 		dst_p = kmap_atomic(dst_bv.bv_page);
@@ -338,28 +335,26 @@ static int pblk_partial_read_bio(struct pblk *pblk, struct nvm_rq *rqd,
 
 	bio_put(new_bio);
 
-	/* Complete the original bio and associated request */
-	bio_endio(bio);
-	rqd->bio = bio;
+	/* restore original request */
+	rqd->bio = NULL;
 	rqd->nr_ppas = nr_secs;
 
 	__pblk_end_io_read(pblk, rqd, false);
-	return NVM_IO_OK;
+	return NVM_IO_DONE;
 
 err:
 	pr_err("pblk: failed to perform partial read\n");
 
 	/* Free allocated pages in new bio */
-	pblk_bio_free_pages(pblk, bio, 0, new_bio->bi_vcnt);
+	pblk_bio_free_pages(pblk, orig_bio, 0, new_bio->bi_vcnt);
 	__pblk_end_io_read(pblk, rqd, false);
 	return NVM_IO_ERR;
 }
 
-static void pblk_read_rq(struct pblk *pblk, struct nvm_rq *rqd,
+static void pblk_read_rq(struct pblk *pblk, struct nvm_rq *rqd, struct bio *bio,
 			 sector_t lba, unsigned long *read_bitmap)
 {
 	struct pblk_sec_meta *meta_list = rqd->meta_list;
-	struct bio *bio = rqd->bio;
 	struct ppa_addr ppa;
 
 	pblk_lookup_l2p_seq(pblk, &ppa, lba, 1);
@@ -423,14 +418,15 @@ int pblk_submit_read(struct pblk *pblk, struct bio *bio)
 	rqd = pblk_alloc_rqd(pblk, PBLK_READ);
 
 	rqd->opcode = NVM_OP_PREAD;
-	rqd->bio = bio;
 	rqd->nr_ppas = nr_secs;
+	rqd->bio = NULL; /* cloned bio if needed */
 	rqd->private = pblk;
 	rqd->end_io = pblk_end_io_read;
 
 	r_ctx = nvm_rq_to_pdu(rqd);
 	r_ctx->start_time = jiffies;
 	r_ctx->lba = blba;
+	r_ctx->private = bio; /* original bio */
 
 	/* Save the index for this bio's start. This is needed in case
 	 * we need to fill a partial read.
@@ -448,17 +444,15 @@ int pblk_submit_read(struct pblk *pblk, struct bio *bio)
 		rqd->ppa_list = rqd->meta_list + pblk_dma_meta_size;
 		rqd->dma_ppa_list = rqd->dma_meta_list + pblk_dma_meta_size;
 
-		pblk_read_ppalist_rq(pblk, rqd, blba, &read_bitmap);
+		pblk_read_ppalist_rq(pblk, rqd, bio, blba, &read_bitmap);
 	} else {
-		pblk_read_rq(pblk, rqd, blba, &read_bitmap);
+		pblk_read_rq(pblk, rqd, bio, blba, &read_bitmap);
 	}
 
-	bio_get(bio);
 	if (bitmap_full(&read_bitmap, nr_secs)) {
-		bio_endio(bio);
 		atomic_inc(&pblk->inflight_io);
 		__pblk_end_io_read(pblk, rqd, false);
-		return NVM_IO_OK;
+		return NVM_IO_DONE;
 	}
 
 	/* All sectors are to be read from the device */
@@ -473,13 +467,10 @@ int pblk_submit_read(struct pblk *pblk, struct bio *bio)
 		}
 
 		rqd->bio = int_bio;
-		r_ctx->private = bio;
 
 		ret = pblk_submit_io(pblk, rqd);
 		if (ret) {
 			pr_err("pblk: read IO submission failed\n");
-			if (int_bio)
-				bio_put(int_bio);
 			goto fail_end_io;
 		}
 
@@ -489,7 +480,7 @@ int pblk_submit_read(struct pblk *pblk, struct bio *bio)
 	/* The read bio request could be partially filled by the write buffer,
 	 * but there are some holes that need to be read from the drive.
 	 */
-	return pblk_partial_read_bio(pblk, rqd, bio_init_idx, &read_bitmap);
+	return pblk_partial_read(pblk, rqd, bio, bio_init_idx, &read_bitmap);
 
 fail_rqd_free:
 	pblk_free_rqd(pblk, rqd, PBLK_READ);
-- 
2.7.4
