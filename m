Return-Path: <javier@javigon.com>
Return-Path: <javier@javigon.com>
From: "=?UTF-8?q?Javier=20Gonz=C3=A1lez?=" <javier@javigon.com>
To: mb@lightnvm.io
Cc: axboe@kernel.dk,
	linux-block@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	=?UTF-8?q?Javier=20Gonz=C3=A1lez?= <javier@cnexlabs.com>
Subject: [PATCH 1/3] lightnvm: encapsule rqd dma allocations
Date: Tue, 11 Sep 2018 13:24:49 +0200
Message-Id: <1536665091-12641-2-git-send-email-javier@cnexlabs.com>
In-Reply-To: <1536665091-12641-1-git-send-email-javier@cnexlabs.com>
References: <1536665091-12641-1-git-send-email-javier@cnexlabs.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
List-ID: <linux-block@vger.kernel.org>

dma allocations for ppa_list and meta_list in rqd are replicated in
several places across the pblk codebase. Make helpers to encapsulate
creation and deletion to simplify the code.

Signed-off-by: Javier González <javier@cnexlabs.com>
---
 drivers/lightnvm/pblk-core.c     | 51 +++++++++++++++++++++++++++-------------
 drivers/lightnvm/pblk-read.c     | 31 ++++++++----------------
 drivers/lightnvm/pblk-recovery.c | 30 ++++++++---------------
 drivers/lightnvm/pblk-write.c    | 15 ++----------
 drivers/lightnvm/pblk.h          |  2 ++
 5 files changed, 59 insertions(+), 70 deletions(-)

diff --git a/drivers/lightnvm/pblk-core.c b/drivers/lightnvm/pblk-core.c
index 875f3cf615ac..8ae40855d4c9 100644
--- a/drivers/lightnvm/pblk-core.c
+++ b/drivers/lightnvm/pblk-core.c
@@ -237,6 +237,33 @@ static void pblk_invalidate_range(struct pblk *pblk, sector_t slba,
 	spin_unlock(&pblk->trans_lock);
 }
 
+int pblk_alloc_rqd_meta(struct pblk *pblk, struct nvm_rq *rqd)
+{
+	struct nvm_tgt_dev *dev = pblk->dev;
+
+	rqd->meta_list = nvm_dev_dma_alloc(dev->parent, GFP_KERNEL,
+							&rqd->dma_meta_list);
+	if (!rqd->meta_list)
+		return -ENOMEM;
+
+	if (rqd->nr_ppas == 1)
+		return 0;
+
+	rqd->ppa_list = rqd->meta_list + pblk_dma_meta_size;
+	rqd->dma_ppa_list = rqd->dma_meta_list + pblk_dma_meta_size;
+
+	return 0;
+}
+
+void pblk_free_rqd_meta(struct pblk *pblk, struct nvm_rq *rqd)
+{
+	struct nvm_tgt_dev *dev = pblk->dev;
+
+	if (rqd->meta_list)
+		nvm_dev_dma_free(dev->parent, rqd->meta_list,
+				rqd->dma_meta_list);
+}
+
 /* Caller must guarantee that the request is a valid type */
 struct nvm_rq *pblk_alloc_rqd(struct pblk *pblk, int type)
 {
@@ -268,7 +295,6 @@ struct nvm_rq *pblk_alloc_rqd(struct pblk *pblk, int type)
 /* Typically used on completion path. Cannot guarantee request consistency */
 void pblk_free_rqd(struct pblk *pblk, struct nvm_rq *rqd, int type)
 {
-	struct nvm_tgt_dev *dev = pblk->dev;
 	mempool_t *pool;
 
 	switch (type) {
@@ -289,9 +315,7 @@ void pblk_free_rqd(struct pblk *pblk, struct nvm_rq *rqd, int type)
 		return;
 	}
 
-	if (rqd->meta_list)
-		nvm_dev_dma_free(dev->parent, rqd->meta_list,
-				rqd->dma_meta_list);
+	pblk_free_rqd_meta(pblk, rqd);
 	mempool_free(rqd, pool);
 }
 
@@ -838,18 +862,14 @@ static int pblk_line_submit_smeta_io(struct pblk *pblk, struct pblk_line *line,
 
 	memset(&rqd, 0, sizeof(struct nvm_rq));
 
-	rqd.meta_list = nvm_dev_dma_alloc(dev->parent, GFP_KERNEL,
-							&rqd.dma_meta_list);
-	if (!rqd.meta_list)
-		return -ENOMEM;
-
-	rqd.ppa_list = rqd.meta_list + pblk_dma_meta_size;
-	rqd.dma_ppa_list = rqd.dma_meta_list + pblk_dma_meta_size;
+	ret = pblk_alloc_rqd_meta(pblk, &rqd);
+	if (ret)
+		return ret;
 
 	bio = bio_map_kern(dev->q, line->smeta, lm->smeta_len, GFP_KERNEL);
 	if (IS_ERR(bio)) {
 		ret = PTR_ERR(bio);
-		goto free_ppa_list;
+		goto clear_rqd;
 	}
 
 	bio->bi_iter.bi_sector = 0; /* internal bio */
@@ -881,7 +901,7 @@ static int pblk_line_submit_smeta_io(struct pblk *pblk, struct pblk_line *line,
 	if (ret) {
 		pblk_err(pblk, "smeta I/O submission failed: %d\n", ret);
 		bio_put(bio);
-		goto free_ppa_list;
+		goto clear_rqd;
 	}
 
 	atomic_dec(&pblk->inflight_io);
@@ -894,9 +914,8 @@ static int pblk_line_submit_smeta_io(struct pblk *pblk, struct pblk_line *line,
 			pblk_log_read_err(pblk, &rqd);
 	}
 
-free_ppa_list:
-	nvm_dev_dma_free(dev->parent, rqd.meta_list, rqd.dma_meta_list);
-
+clear_rqd:
+	pblk_free_rqd_meta(pblk, &rqd);
 	return ret;
 }
 
diff --git a/drivers/lightnvm/pblk-read.c b/drivers/lightnvm/pblk-read.c
index 6d13763f2f6a..e86d66def562 100644
--- a/drivers/lightnvm/pblk-read.c
+++ b/drivers/lightnvm/pblk-read.c
@@ -452,21 +452,13 @@ int pblk_submit_read(struct pblk *pblk, struct bio *bio)
 	 */
 	bio_init_idx = pblk_get_bi_idx(bio);
 
-	rqd->meta_list = nvm_dev_dma_alloc(dev->parent, GFP_KERNEL,
-							&rqd->dma_meta_list);
-	if (!rqd->meta_list) {
-		pblk_err(pblk, "not able to allocate ppa list\n");
+	if (pblk_alloc_rqd_meta(pblk, rqd))
 		goto fail_rqd_free;
-	}
-
-	if (nr_secs > 1) {
-		rqd->ppa_list = rqd->meta_list + pblk_dma_meta_size;
-		rqd->dma_ppa_list = rqd->dma_meta_list + pblk_dma_meta_size;
 
+	if (nr_secs > 1)
 		pblk_read_ppalist_rq(pblk, rqd, bio, blba, read_bitmap);
-	} else {
+	else
 		pblk_read_rq(pblk, rqd, bio, blba, read_bitmap);
-	}
 
 	if (bitmap_full(read_bitmap, nr_secs)) {
 		atomic_inc(&pblk->inflight_io);
@@ -593,15 +585,11 @@ int pblk_submit_read_gc(struct pblk *pblk, struct pblk_gc_rq *gc_rq)
 
 	memset(&rqd, 0, sizeof(struct nvm_rq));
 
-	rqd.meta_list = nvm_dev_dma_alloc(dev->parent, GFP_KERNEL,
-							&rqd.dma_meta_list);
-	if (!rqd.meta_list)
-		return -ENOMEM;
+	ret = pblk_alloc_rqd_meta(pblk, &rqd);
+	if (ret)
+		return ret;
 
 	if (gc_rq->nr_secs > 1) {
-		rqd.ppa_list = rqd.meta_list + pblk_dma_meta_size;
-		rqd.dma_ppa_list = rqd.dma_meta_list + pblk_dma_meta_size;
-
 		gc_rq->secs_to_gc = read_ppalist_rq_gc(pblk, &rqd, gc_rq->line,
 							gc_rq->lba_list,
 							gc_rq->paddr_list,
@@ -622,7 +610,8 @@ int pblk_submit_read_gc(struct pblk *pblk, struct pblk_gc_rq *gc_rq)
 						PBLK_VMALLOC_META, GFP_KERNEL);
 	if (IS_ERR(bio)) {
 		pblk_err(pblk, "could not allocate GC bio (%lu)\n",
-				PTR_ERR(bio));
+								PTR_ERR(bio));
+		ret = PTR_ERR(bio);
 		goto err_free_dma;
 	}
 
@@ -657,12 +646,12 @@ int pblk_submit_read_gc(struct pblk *pblk, struct pblk_gc_rq *gc_rq)
 #endif
 
 out:
-	nvm_dev_dma_free(dev->parent, rqd.meta_list, rqd.dma_meta_list);
+	pblk_free_rqd_meta(pblk, &rqd);
 	return ret;
 
 err_free_bio:
 	bio_put(bio);
 err_free_dma:
-	nvm_dev_dma_free(dev->parent, rqd.meta_list, rqd.dma_meta_list);
+	pblk_free_rqd_meta(pblk, &rqd);
 	return ret;
 }
diff --git a/drivers/lightnvm/pblk-recovery.c b/drivers/lightnvm/pblk-recovery.c
index 2526722304bb..218292979953 100644
--- a/drivers/lightnvm/pblk-recovery.c
+++ b/drivers/lightnvm/pblk-recovery.c
@@ -241,13 +241,11 @@ static int pblk_recov_pad_oob(struct pblk *pblk, struct pblk_line *line,
 {
 	struct nvm_tgt_dev *dev = pblk->dev;
 	struct nvm_geo *geo = &dev->geo;
-	struct ppa_addr *ppa_list;
 	struct pblk_sec_meta *meta_list;
 	struct pblk_pad_rq *pad_rq;
 	struct nvm_rq *rqd;
 	struct bio *bio;
 	void *data;
-	dma_addr_t dma_ppa_list, dma_meta_list;
 	__le64 *lba_list = emeta_to_lbas(pblk, line->emeta->buf);
 	u64 w_ptr = line->cur_sec;
 	int left_line_ppas, rq_ppas, rq_len;
@@ -281,20 +279,11 @@ static int pblk_recov_pad_oob(struct pblk *pblk, struct pblk_line *line,
 
 	rq_len = rq_ppas * geo->csecs;
 
-	meta_list = nvm_dev_dma_alloc(dev->parent, GFP_KERNEL, &dma_meta_list);
-	if (!meta_list) {
-		ret = -ENOMEM;
-		goto fail_free_pad;
-	}
-
-	ppa_list = (void *)(meta_list) + pblk_dma_meta_size;
-	dma_ppa_list = dma_meta_list + pblk_dma_meta_size;
-
 	bio = pblk_bio_map_addr(pblk, data, rq_ppas, rq_len,
 						PBLK_VMALLOC_META, GFP_KERNEL);
 	if (IS_ERR(bio)) {
 		ret = PTR_ERR(bio);
-		goto fail_free_meta;
+		goto fail_free_pad;
 	}
 
 	bio->bi_iter.bi_sector = 0; /* internal bio */
@@ -302,17 +291,19 @@ static int pblk_recov_pad_oob(struct pblk *pblk, struct pblk_line *line,
 
 	rqd = pblk_alloc_rqd(pblk, PBLK_WRITE_INT);
 
+	ret = pblk_alloc_rqd_meta(pblk, rqd);
+	if (ret)
+		goto fail_free_rqd;
+
 	rqd->bio = bio;
 	rqd->opcode = NVM_OP_PWRITE;
 	rqd->is_seq = 1;
-	rqd->meta_list = meta_list;
 	rqd->nr_ppas = rq_ppas;
-	rqd->ppa_list = ppa_list;
-	rqd->dma_ppa_list = dma_ppa_list;
-	rqd->dma_meta_list = dma_meta_list;
 	rqd->end_io = pblk_end_io_recov;
 	rqd->private = pad_rq;
 
+	meta_list = rqd->meta_list;
+
 	for (i = 0; i < rqd->nr_ppas; ) {
 		struct ppa_addr ppa;
 		int pos;
@@ -346,7 +337,7 @@ static int pblk_recov_pad_oob(struct pblk *pblk, struct pblk_line *line,
 	if (ret) {
 		pblk_err(pblk, "I/O submission failed: %d\n", ret);
 		pblk_up_chunk(pblk, rqd->ppa_list[0]);
-		goto fail_free_bio;
+		goto fail_free_rqd;
 	}
 
 	left_line_ppas -= rq_ppas;
@@ -370,10 +361,9 @@ static int pblk_recov_pad_oob(struct pblk *pblk, struct pblk_line *line,
 	kfree(pad_rq);
 	return ret;
 
-fail_free_bio:
+fail_free_rqd:
+	pblk_free_rqd(pblk, rqd, PBLK_WRITE_INT);
 	bio_put(bio);
-fail_free_meta:
-	nvm_dev_dma_free(dev->parent, meta_list, dma_meta_list);
 fail_free_pad:
 	kfree(pad_rq);
 	vfree(data);
diff --git a/drivers/lightnvm/pblk-write.c b/drivers/lightnvm/pblk-write.c
index 9554febee480..a276f25d3931 100644
--- a/drivers/lightnvm/pblk-write.c
+++ b/drivers/lightnvm/pblk-write.c
@@ -285,11 +285,8 @@ static void pblk_end_io_write_meta(struct nvm_rq *rqd)
 }
 
 static int pblk_alloc_w_rq(struct pblk *pblk, struct nvm_rq *rqd,
-			   unsigned int nr_secs,
-			   nvm_end_io_fn(*end_io))
+			   unsigned int nr_secs, nvm_end_io_fn(*end_io))
 {
-	struct nvm_tgt_dev *dev = pblk->dev;
-
 	/* Setup write request */
 	rqd->opcode = NVM_OP_PWRITE;
 	rqd->nr_ppas = nr_secs;
@@ -297,15 +294,7 @@ static int pblk_alloc_w_rq(struct pblk *pblk, struct nvm_rq *rqd,
 	rqd->private = pblk;
 	rqd->end_io = end_io;
 
-	rqd->meta_list = nvm_dev_dma_alloc(dev->parent, GFP_KERNEL,
-							&rqd->dma_meta_list);
-	if (!rqd->meta_list)
-		return -ENOMEM;
-
-	rqd->ppa_list = rqd->meta_list + pblk_dma_meta_size;
-	rqd->dma_ppa_list = rqd->dma_meta_list + pblk_dma_meta_size;
-
-	return 0;
+	return pblk_alloc_rqd_meta(pblk, rqd);
 }
 
 static int pblk_setup_w_rq(struct pblk *pblk, struct nvm_rq *rqd,
diff --git a/drivers/lightnvm/pblk.h b/drivers/lightnvm/pblk.h
index d123cff82589..b06ab0edab69 100644
--- a/drivers/lightnvm/pblk.h
+++ b/drivers/lightnvm/pblk.h
@@ -778,6 +778,8 @@ ssize_t pblk_rb_sysfs(struct pblk_rb *rb, char *buf);
  */
 struct nvm_rq *pblk_alloc_rqd(struct pblk *pblk, int type);
 void pblk_free_rqd(struct pblk *pblk, struct nvm_rq *rqd, int type);
+int pblk_alloc_rqd_meta(struct pblk *pblk, struct nvm_rq *rqd);
+void pblk_free_rqd_meta(struct pblk *pblk, struct nvm_rq *rqd);
 void pblk_set_sec_per_write(struct pblk *pblk, int sec_per_write);
 int pblk_setup_w_rec_rq(struct pblk *pblk, struct nvm_rq *rqd,
 			struct pblk_c_ctx *c_ctx);
-- 
2.7.4
