Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mail-wm0-f65.google.com ([74.125.82.65]:49751 "EHLO
        mail-wm0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1758271AbdJMMrh (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 13 Oct 2017 08:47:37 -0400
Received: by mail-wm0-f65.google.com with SMTP id b189so21115405wmd.4
        for <linux-block@vger.kernel.org>; Fri, 13 Oct 2017 05:47:36 -0700 (PDT)
From: =?UTF-8?q?Matias=20Bj=C3=B8rling?= <m@bjorling.me>
To: axboe@fb.com
Cc: linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        =?UTF-8?q?Javier=20Gonz=C3=A1lez?= <javier@cnexlabs.com>,
        =?UTF-8?q?Matias=20Bj=C3=B8rling?= <m@bjorling.me>
Subject: [GIT PULL 31/58] lightnvm: pblk: refactor rqd alloc/free
Date: Fri, 13 Oct 2017 14:46:20 +0200
Message-Id: <20171013124647.32668-32-m@bjorling.me>
In-Reply-To: <20171013124647.32668-1-m@bjorling.me>
References: <20171013124647.32668-1-m@bjorling.me>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

From: Javier González <javier@cnexlabs.com>

Refactor the rqd allocation and free functions so that all I/O types can
use these helper functions.

Signed-off-by: Javier González <javier@cnexlabs.com>
Signed-off-by: Matias Bjørling <m@bjorling.me>
---
 drivers/lightnvm/pblk-core.c     | 40 ++++++++++++++++++++++++++++++----------
 drivers/lightnvm/pblk-read.c     |  2 --
 drivers/lightnvm/pblk-recovery.c |  2 --
 drivers/lightnvm/pblk-write.c    |  7 -------
 drivers/lightnvm/pblk.h          |  4 ++--
 5 files changed, 32 insertions(+), 23 deletions(-)

diff --git a/drivers/lightnvm/pblk-core.c b/drivers/lightnvm/pblk-core.c
index a492964..0de3875 100644
--- a/drivers/lightnvm/pblk-core.c
+++ b/drivers/lightnvm/pblk-core.c
@@ -146,18 +146,26 @@ static void pblk_invalidate_range(struct pblk *pblk, sector_t slba,
 	spin_unlock(&pblk->trans_lock);
 }
 
-struct nvm_rq *pblk_alloc_rqd(struct pblk *pblk, int rw)
+/* Caller must guarantee that the request is a valid type */
+struct nvm_rq *pblk_alloc_rqd(struct pblk *pblk, int type)
 {
 	mempool_t *pool;
 	struct nvm_rq *rqd;
 	int rq_size;
 
-	if (rw == PBLK_WRITE) {
+	switch (type) {
+	case PBLK_WRITE:
+	case PBLK_WRITE_INT:
 		pool = pblk->w_rq_pool;
 		rq_size = pblk_w_rq_size;
-	} else {
+		break;
+	case PBLK_READ:
 		pool = pblk->r_rq_pool;
 		rq_size = pblk_g_rq_size;
+		break;
+	default:
+		pool = pblk->e_rq_pool;
+		rq_size = pblk_g_rq_size;
 	}
 
 	rqd = mempool_alloc(pool, GFP_KERNEL);
@@ -166,15 +174,30 @@ struct nvm_rq *pblk_alloc_rqd(struct pblk *pblk, int rw)
 	return rqd;
 }
 
-void pblk_free_rqd(struct pblk *pblk, struct nvm_rq *rqd, int rw)
+/* Typically used on completion path. Cannot guarantee request consistency */
+void pblk_free_rqd(struct pblk *pblk, struct nvm_rq *rqd, int type)
 {
+	struct nvm_tgt_dev *dev = pblk->dev;
 	mempool_t *pool;
 
-	if (rw == PBLK_WRITE)
+	switch (type) {
+	case PBLK_WRITE:
+		kfree(((struct pblk_c_ctx *)nvm_rq_to_pdu(rqd))->lun_bitmap);
+	case PBLK_WRITE_INT:
 		pool = pblk->w_rq_pool;
-	else
+		break;
+	case PBLK_READ:
 		pool = pblk->r_rq_pool;
+		break;
+	case PBLK_ERASE:
+		pool = pblk->e_rq_pool;
+		break;
+	default:
+		pr_err("pblk: trying to free unknown rqd type\n");
+		return;
+	}
 
+	nvm_dev_dma_free(dev->parent, rqd->meta_list, rqd->dma_meta_list);
 	mempool_free(rqd, pool);
 }
 
@@ -1470,8 +1493,7 @@ int pblk_blk_erase_async(struct pblk *pblk, struct ppa_addr ppa)
 	struct nvm_rq *rqd;
 	int err;
 
-	rqd = mempool_alloc(pblk->e_rq_pool, GFP_KERNEL);
-	memset(rqd, 0, pblk_g_rq_size);
+	rqd = pblk_alloc_rqd(pblk, PBLK_ERASE);
 
 	pblk_setup_e_rq(pblk, rqd, ppa);
 
@@ -1739,8 +1761,6 @@ void pblk_up_rq(struct pblk *pblk, struct ppa_addr *ppa_list, int nr_ppas,
 		rlun = &pblk->luns[bit];
 		up(&rlun->wr_sem);
 	}
-
-	kfree(lun_bitmap);
 }
 
 void pblk_update_map(struct pblk *pblk, sector_t lba, struct ppa_addr ppa)
diff --git a/drivers/lightnvm/pblk-read.c b/drivers/lightnvm/pblk-read.c
index 4b1722f..d7c90c3 100644
--- a/drivers/lightnvm/pblk-read.c
+++ b/drivers/lightnvm/pblk-read.c
@@ -124,8 +124,6 @@ static void pblk_end_io_read(struct nvm_rq *rqd)
 		WARN_ONCE(bio->bi_status, "pblk: corrupted read error\n");
 #endif
 
-	nvm_dev_dma_free(dev->parent, rqd->meta_list, rqd->dma_meta_list);
-
 	bio_put(bio);
 	if (r_ctx->private) {
 		struct bio *orig_bio = r_ctx->private;
diff --git a/drivers/lightnvm/pblk-recovery.c b/drivers/lightnvm/pblk-recovery.c
index 19f2fb1..686bc17 100644
--- a/drivers/lightnvm/pblk-recovery.c
+++ b/drivers/lightnvm/pblk-recovery.c
@@ -329,11 +329,9 @@ static void pblk_end_io_recov(struct nvm_rq *rqd)
 {
 	struct pblk_pad_rq *pad_rq = rqd->private;
 	struct pblk *pblk = pad_rq->pblk;
-	struct nvm_tgt_dev *dev = pblk->dev;
 
 	pblk_up_page(pblk, rqd->ppa_list, rqd->nr_ppas);
 
-	nvm_dev_dma_free(dev->parent, rqd->meta_list, rqd->dma_meta_list);
 	pblk_free_rqd(pblk, rqd, PBLK_WRITE_INT);
 
 	atomic_dec(&pblk->inflight_io);
diff --git a/drivers/lightnvm/pblk-write.c b/drivers/lightnvm/pblk-write.c
index c1b8b83..f2e846f 100644
--- a/drivers/lightnvm/pblk-write.c
+++ b/drivers/lightnvm/pblk-write.c
@@ -20,7 +20,6 @@
 static unsigned long pblk_end_w_bio(struct pblk *pblk, struct nvm_rq *rqd,
 				    struct pblk_c_ctx *c_ctx)
 {
-	struct nvm_tgt_dev *dev = pblk->dev;
 	struct bio *original_bio;
 	unsigned long ret;
 	int i;
@@ -43,8 +42,6 @@ static unsigned long pblk_end_w_bio(struct pblk *pblk, struct nvm_rq *rqd,
 
 	ret = pblk_rb_sync_advance(&pblk->rwb, c_ctx->nr_valid);
 
-	nvm_dev_dma_free(dev->parent, rqd->meta_list, rqd->dma_meta_list);
-
 	bio_put(rqd->bio);
 	pblk_free_rqd(pblk, rqd, PBLK_WRITE);
 
@@ -176,7 +173,6 @@ static void pblk_end_io_write(struct nvm_rq *rqd)
 static void pblk_end_io_write_meta(struct nvm_rq *rqd)
 {
 	struct pblk *pblk = rqd->private;
-	struct nvm_tgt_dev *dev = pblk->dev;
 	struct pblk_g_ctx *m_ctx = nvm_rq_to_pdu(rqd);
 	struct pblk_line *line = m_ctx->private;
 	struct pblk_emeta *emeta = line->emeta;
@@ -194,7 +190,6 @@ static void pblk_end_io_write_meta(struct nvm_rq *rqd)
 		pblk_gen_run_ws(pblk, line, NULL, pblk_line_close_ws,
 						GFP_ATOMIC, pblk->close_wq);
 
-	nvm_dev_dma_free(dev->parent, rqd->meta_list, rqd->dma_meta_list);
 	pblk_free_rqd(pblk, rqd, PBLK_WRITE_INT);
 
 	atomic_dec(&pblk->inflight_io);
@@ -419,8 +414,6 @@ int pblk_submit_meta_io(struct pblk *pblk, struct pblk_line *meta_line)
 	pblk_dealloc_page(pblk, meta_line, rq_ppas);
 	list_add(&meta_line->list, &meta_line->list);
 	spin_unlock(&l_mg->close_lock);
-
-	nvm_dev_dma_free(dev->parent, rqd->meta_list, rqd->dma_meta_list);
 fail_free_bio:
 	bio_put(bio);
 fail_free_rqd:
diff --git a/drivers/lightnvm/pblk.h b/drivers/lightnvm/pblk.h
index d01e003..12a20f8 100644
--- a/drivers/lightnvm/pblk.h
+++ b/drivers/lightnvm/pblk.h
@@ -699,11 +699,11 @@ ssize_t pblk_rb_sysfs(struct pblk_rb *rb, char *buf);
 /*
  * pblk core
  */
-struct nvm_rq *pblk_alloc_rqd(struct pblk *pblk, int rw);
+struct nvm_rq *pblk_alloc_rqd(struct pblk *pblk, int type);
+void pblk_free_rqd(struct pblk *pblk, struct nvm_rq *rqd, int type);
 void pblk_set_sec_per_write(struct pblk *pblk, int sec_per_write);
 int pblk_setup_w_rec_rq(struct pblk *pblk, struct nvm_rq *rqd,
 			struct pblk_c_ctx *c_ctx);
-void pblk_free_rqd(struct pblk *pblk, struct nvm_rq *rqd, int rw);
 void pblk_wait_for_meta(struct pblk *pblk);
 struct ppa_addr pblk_get_lba_map(struct pblk *pblk, sector_t lba);
 void pblk_discard(struct pblk *pblk, struct bio *bio);
-- 
2.9.3
