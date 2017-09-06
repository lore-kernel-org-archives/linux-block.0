Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mail-wm0-f51.google.com ([74.125.82.51]:37091 "EHLO
        mail-wm0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753373AbdIFKwy (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Wed, 6 Sep 2017 06:52:54 -0400
Received: by mail-wm0-f51.google.com with SMTP id u26so29537394wma.0
        for <linux-block@vger.kernel.org>; Wed, 06 Sep 2017 03:52:53 -0700 (PDT)
From: "=?UTF-8?q?Javier=20Gonz=C3=A1lez?=" <jg@lightnvm.io>
To: mb@lightnvm.io, axboe@fb.com
Cc: linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        =?UTF-8?q?Javier=20Gonz=C3=A1lez?= <javier@cnexlabs.com>,
        =?UTF-8?q?Matias=20Bj=C3=B8rling?= <matias@cnexlabs.com>
Subject: [PATCH 17/18] lightnvm: pblk: guarantee line integrity on reads
Date: Wed,  6 Sep 2017 12:51:10 +0200
Message-Id: <1504695071-25928-18-git-send-email-javier@cnexlabs.com>
In-Reply-To: <1504695071-25928-1-git-send-email-javier@cnexlabs.com>
References: <1504695071-25928-1-git-send-email-javier@cnexlabs.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

When a line is recycled during garbage collection, reads can still be
issued to the line. If the line is freed in the middle of this process,
data corruption might occur.

This patch guarantees that lines are not freed in the middle of reads
that target them (lines). Specifically, we use the existing line
reference to decide when a line is eligible for being freed after the
recycle process.

Signed-off-by: Javier González <javier@cnexlabs.com>
Signed-off-by: Matias Bjørling <matias@cnexlabs.com>
---
 drivers/lightnvm/pblk-core.c | 55 ++++++++++++++++++++++++++++++---
 drivers/lightnvm/pblk-init.c | 14 +++++++--
 drivers/lightnvm/pblk-read.c | 73 ++++++++++++++++++++++++++++++++------------
 drivers/lightnvm/pblk.h      |  2 ++
 4 files changed, 118 insertions(+), 26 deletions(-)

diff --git a/drivers/lightnvm/pblk-core.c b/drivers/lightnvm/pblk-core.c
index 873b66200678..b9f6ff164b46 100644
--- a/drivers/lightnvm/pblk-core.c
+++ b/drivers/lightnvm/pblk-core.c
@@ -1419,10 +1419,8 @@ void pblk_line_free(struct pblk *pblk, struct pblk_line *line)
 	line->emeta = NULL;
 }
 
-void pblk_line_put(struct kref *ref)
+static void __pblk_line_put(struct pblk *pblk, struct pblk_line *line)
 {
-	struct pblk_line *line = container_of(ref, struct pblk_line, ref);
-	struct pblk *pblk = line->pblk;
 	struct pblk_line_mgmt *l_mg = &pblk->l_mg;
 
 	spin_lock(&line->lock);
@@ -1440,6 +1438,42 @@ void pblk_line_put(struct kref *ref)
 	pblk_rl_free_lines_inc(&pblk->rl, line);
 }
 
+static void pblk_line_put_ws(struct work_struct *work)
+{
+	struct pblk_line_ws *line_put_ws = container_of(work,
+						struct pblk_line_ws, ws);
+	struct pblk *pblk = line_put_ws->pblk;
+	struct pblk_line *line = line_put_ws->line;
+
+	__pblk_line_put(pblk, line);
+}
+
+void pblk_line_put(struct kref *ref)
+{
+	struct pblk_line *line = container_of(ref, struct pblk_line, ref);
+	struct pblk *pblk = line->pblk;
+
+	__pblk_line_put(pblk, line);
+}
+
+void pblk_line_put_wq(struct kref *ref)
+{
+	struct pblk_line *line = container_of(ref, struct pblk_line, ref);
+	struct pblk *pblk = line->pblk;
+	struct pblk_line_ws *line_put_ws;
+
+	line_put_ws = mempool_alloc(pblk->line_ws_pool, GFP_ATOMIC);
+	if (!line_put_ws)
+		return;
+
+	line_put_ws->pblk = pblk;
+	line_put_ws->line = line;
+	line_put_ws->priv = NULL;
+
+	INIT_WORK(&line_put_ws->ws, pblk_line_put_ws);
+	queue_work(pblk->r_end_wq, &line_put_ws->ws);
+}
+
 int pblk_blk_erase_async(struct pblk *pblk, struct ppa_addr ppa)
 {
 	struct nvm_rq *rqd;
@@ -1854,8 +1888,19 @@ void pblk_lookup_l2p_seq(struct pblk *pblk, struct ppa_addr *ppas,
 	int i;
 
 	spin_lock(&pblk->trans_lock);
-	for (i = 0; i < nr_secs; i++)
-		ppas[i] = pblk_trans_map_get(pblk, blba + i);
+	for (i = 0; i < nr_secs; i++) {
+		struct ppa_addr ppa;
+
+		ppa = ppas[i] = pblk_trans_map_get(pblk, blba + i);
+
+		/* If the L2P entry maps to a line, the reference is valid */
+		if (!pblk_ppa_empty(ppa) && !pblk_addr_in_cache(ppa)) {
+			int line_id = pblk_dev_ppa_to_line(ppa);
+			struct pblk_line *line = &pblk->lines[line_id];
+
+			kref_get(&line->ref);
+		}
+	}
 	spin_unlock(&pblk->trans_lock);
 }
 
diff --git a/drivers/lightnvm/pblk-init.c b/drivers/lightnvm/pblk-init.c
index 0409839cc8fc..5fe926bbbb2d 100644
--- a/drivers/lightnvm/pblk-init.c
+++ b/drivers/lightnvm/pblk-init.c
@@ -286,15 +286,22 @@ static int pblk_core_init(struct pblk *pblk)
 	if (!pblk->bb_wq)
 		goto free_close_wq;
 
+	pblk->r_end_wq = alloc_workqueue("pblk-read-end-wq",
+			WQ_MEM_RECLAIM | WQ_UNBOUND, 0);
+	if (!pblk->r_end_wq)
+		goto free_bb_wq;
+
 	if (pblk_set_ppaf(pblk))
-		goto free_bb_wq;
+		goto free_r_end_wq;
 
 	if (pblk_rwb_init(pblk))
-		goto free_bb_wq;
+		goto free_r_end_wq;
 
 	INIT_LIST_HEAD(&pblk->compl_list);
 	return 0;
 
+free_r_end_wq:
+	destroy_workqueue(pblk->r_end_wq);
 free_bb_wq:
 	destroy_workqueue(pblk->bb_wq);
 free_close_wq:
@@ -319,6 +326,9 @@ static void pblk_core_free(struct pblk *pblk)
 	if (pblk->close_wq)
 		destroy_workqueue(pblk->close_wq);
 
+	if (pblk->r_end_wq)
+		destroy_workqueue(pblk->r_end_wq);
+
 	if (pblk->bb_wq)
 		destroy_workqueue(pblk->bb_wq);
 
diff --git a/drivers/lightnvm/pblk-read.c b/drivers/lightnvm/pblk-read.c
index 1be972521dcd..f43d78e4ce78 100644
--- a/drivers/lightnvm/pblk-read.c
+++ b/drivers/lightnvm/pblk-read.c
@@ -130,9 +130,34 @@ static void pblk_read_check(struct pblk *pblk, struct nvm_rq *rqd,
 	}
 }
 
-static void pblk_end_io_read(struct nvm_rq *rqd)
+static void pblk_read_put_rqd_kref(struct pblk *pblk, struct nvm_rq *rqd)
+{
+	struct ppa_addr *ppa_list;
+	int i;
+
+	ppa_list = (rqd->nr_ppas > 1) ? rqd->ppa_list : &rqd->ppa_addr;
+
+	for (i = 0; i < rqd->nr_ppas; i++) {
+		struct ppa_addr ppa = ppa_list[i];
+		struct pblk_line *line;
+
+		line = &pblk->lines[pblk_dev_ppa_to_line(ppa)];
+		kref_put(&line->ref, pblk_line_put_wq);
+	}
+}
+
+static void pblk_end_user_read(struct bio *bio)
+{
+#ifdef CONFIG_NVM_DEBUG
+	WARN_ONCE(bio->bi_status, "pblk: corrupted read bio\n");
+#endif
+	bio_endio(bio);
+	bio_put(bio);
+}
+
+static void __pblk_end_io_read(struct pblk *pblk, struct nvm_rq *rqd,
+			       bool put_line)
 {
-	struct pblk *pblk = rqd->private;
 	struct nvm_tgt_dev *dev = pblk->dev;
 	struct pblk_g_ctx *r_ctx = nvm_rq_to_pdu(rqd);
 	struct bio *bio = rqd->bio;
@@ -145,28 +170,31 @@ static void pblk_end_io_read(struct nvm_rq *rqd)
 #endif
 
 	pblk_read_check(pblk, rqd, r_ctx->lba);
-	nvm_dev_dma_free(dev->parent, rqd->meta_list, rqd->dma_meta_list);
 
 	bio_put(bio);
-	if (r_ctx->private) {
-		struct bio *orig_bio = r_ctx->private;
+	if (r_ctx->private)
+		pblk_end_user_read((struct bio *)r_ctx->private);
 
-#ifdef CONFIG_NVM_DEBUG
-		WARN_ONCE(orig_bio->bi_status, "pblk: corrupted read bio\n");
-#endif
-		bio_endio(orig_bio);
-		bio_put(orig_bio);
-	}
+	if (put_line)
+		pblk_read_put_rqd_kref(pblk, rqd);
 
 #ifdef CONFIG_NVM_DEBUG
 	atomic_long_add(rqd->nr_ppas, &pblk->sync_reads);
 	atomic_long_sub(rqd->nr_ppas, &pblk->inflight_reads);
 #endif
 
+	nvm_dev_dma_free(dev->parent, rqd->meta_list, rqd->dma_meta_list);
 	pblk_free_rqd(pblk, rqd, READ);
 	atomic_dec(&pblk->inflight_io);
 }
 
+static void pblk_end_io_read(struct nvm_rq *rqd)
+{
+	struct pblk *pblk = rqd->private;
+
+	__pblk_end_io_read(pblk, rqd, true);
+}
+
 static int pblk_fill_partial_read_bio(struct pblk *pblk, struct nvm_rq *rqd,
 				      unsigned int bio_init_idx,
 				      unsigned long *read_bitmap)
@@ -240,8 +268,12 @@ static int pblk_fill_partial_read_bio(struct pblk *pblk, struct nvm_rq *rqd,
 	}
 
 	if (unlikely(nr_secs > 1 && nr_holes == 1)) {
+		struct ppa_addr ppa;
+
+		ppa = rqd->ppa_addr;
 		rqd->ppa_list = ppa_ptr;
 		rqd->dma_ppa_list = dma_ppa_list;
+		rqd->ppa_list[0] = ppa;
 	}
 
 	for (i = 0; i < nr_secs; i++) {
@@ -253,6 +285,11 @@ static int pblk_fill_partial_read_bio(struct pblk *pblk, struct nvm_rq *rqd,
 	i = 0;
 	hole = find_first_zero_bit(read_bitmap, nr_secs);
 	do {
+		int line_id = pblk_dev_ppa_to_line(rqd->ppa_list[i]);
+		struct pblk_line *line = &pblk->lines[line_id];
+
+		kref_put(&line->ref, pblk_line_put);
+
 		meta_list[hole].lba = lba_list_media[i];
 
 		src_bv = new_bio->bi_io_vec[i++];
@@ -276,19 +313,17 @@ static int pblk_fill_partial_read_bio(struct pblk *pblk, struct nvm_rq *rqd,
 	bio_put(new_bio);
 
 	/* Complete the original bio and associated request */
+	bio_endio(bio);
 	rqd->bio = bio;
 	rqd->nr_ppas = nr_secs;
-	rqd->private = pblk;
 
-	bio_endio(bio);
-	pblk_end_io_read(rqd);
+	__pblk_end_io_read(pblk, rqd, false);
 	return NVM_IO_OK;
 
 err:
 	/* Free allocated pages in new bio */
 	pblk_bio_free_pages(pblk, bio, 0, new_bio->bi_vcnt);
-	rqd->private = pblk;
-	pblk_end_io_read(rqd);
+	__pblk_end_io_read(pblk, rqd, false);
 	return NVM_IO_ERR;
 }
 
@@ -321,11 +356,11 @@ static void pblk_read_rq(struct pblk *pblk, struct nvm_rq *rqd,
 			goto retry;
 		}
 
+		WARN_ON(test_and_set_bit(0, read_bitmap));
 		meta_list[0].lba = cpu_to_le64(lba);
 
-		WARN_ON(test_and_set_bit(0, read_bitmap));
 #ifdef CONFIG_NVM_DEBUG
-			atomic_long_inc(&pblk->cache_reads);
+		atomic_long_inc(&pblk->cache_reads);
 #endif
 	} else {
 		rqd->ppa_addr = ppa;
@@ -393,7 +428,7 @@ int pblk_submit_read(struct pblk *pblk, struct bio *bio)
 	if (bitmap_full(&read_bitmap, nr_secs)) {
 		bio_endio(bio);
 		atomic_inc(&pblk->inflight_io);
-		pblk_end_io_read(rqd);
+		__pblk_end_io_read(pblk, rqd, false);
 		return NVM_IO_OK;
 	}
 
diff --git a/drivers/lightnvm/pblk.h b/drivers/lightnvm/pblk.h
index f6d2e1e72057..db602bd4827f 100644
--- a/drivers/lightnvm/pblk.h
+++ b/drivers/lightnvm/pblk.h
@@ -634,6 +634,7 @@ struct pblk {
 
 	struct workqueue_struct *close_wq;
 	struct workqueue_struct *bb_wq;
+	struct workqueue_struct *r_end_wq;
 
 	struct timer_list wtimer;
 
@@ -739,6 +740,7 @@ int pblk_line_read_emeta(struct pblk *pblk, struct pblk_line *line,
 			 void *emeta_buf);
 int pblk_blk_erase_async(struct pblk *pblk, struct ppa_addr erase_ppa);
 void pblk_line_put(struct kref *ref);
+void pblk_line_put_wq(struct kref *ref);
 struct list_head *pblk_line_gc_list(struct pblk *pblk, struct pblk_line *line);
 u64 pblk_lookup_page(struct pblk *pblk, struct pblk_line *line);
 void pblk_dealloc_page(struct pblk *pblk, struct pblk_line *line, int nr_secs);
-- 
2.7.4
