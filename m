Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mail-lf0-f66.google.com ([209.85.215.66]:37737 "EHLO
        mail-lf0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754027AbeDSQkM (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 19 Apr 2018 12:40:12 -0400
Received: by mail-lf0-f66.google.com with SMTP id b23-v6so1116822lfg.4
        for <linux-block@vger.kernel.org>; Thu, 19 Apr 2018 09:40:11 -0700 (PDT)
From: Hans Holmberg <hans.ml.holmberg@owltronix.com>
To: Matias Bjorling <mb@lightnvm.io>
Cc: linux-block@vger.kernel.org, Javier Gonzales <javier@cnexlabs.com>,
        linux-kernel@vger.kernel.org,
        Hans Holmberg <hans.holmberg@cnexlabs.com>
Subject: [PATCH 1/3] lightnvm: pblk: rework write error recovery path
Date: Thu, 19 Apr 2018 18:39:22 +0200
Message-Id: <1524155964-3743-2-git-send-email-hans.ml.holmberg@owltronix.com>
In-Reply-To: <1524155964-3743-1-git-send-email-hans.ml.holmberg@owltronix.com>
References: <1524155964-3743-1-git-send-email-hans.ml.holmberg@owltronix.com>
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

From: Hans Holmberg <hans.holmberg@cnexlabs.com>

The write error recovery path is incomplete, so rework
the write error recovery handling to do resubmits directly
from the write buffer.

When a write error occurs, the remaining sectors in the chunk are
mapped out and invalidated and the request inserted in a resubmit list.

The writer thread checks if there are any requests to resubmit,
scans and invalidates any lbas that have been overwritten by later
writes and resubmits the failed entries.

Signed-off-by: Hans Holmberg <hans.holmberg@cnexlabs.com>
---
 drivers/lightnvm/pblk-init.c     |   2 +
 drivers/lightnvm/pblk-recovery.c |  91 ---------------
 drivers/lightnvm/pblk-write.c    | 241 ++++++++++++++++++++++++++++-----------
 drivers/lightnvm/pblk.h          |   8 +-
 4 files changed, 180 insertions(+), 162 deletions(-)

diff --git a/drivers/lightnvm/pblk-init.c b/drivers/lightnvm/pblk-init.c
index bfc488d..6f06727 100644
--- a/drivers/lightnvm/pblk-init.c
+++ b/drivers/lightnvm/pblk-init.c
@@ -426,6 +426,7 @@ static int pblk_core_init(struct pblk *pblk)
 		goto free_r_end_wq;
 
 	INIT_LIST_HEAD(&pblk->compl_list);
+	INIT_LIST_HEAD(&pblk->resubmit_list);
 
 	return 0;
 
@@ -1185,6 +1186,7 @@ static void *pblk_init(struct nvm_tgt_dev *dev, struct gendisk *tdisk,
 	pblk->state = PBLK_STATE_RUNNING;
 	pblk->gc.gc_enabled = 0;
 
+	spin_lock_init(&pblk->resubmit_lock);
 	spin_lock_init(&pblk->trans_lock);
 	spin_lock_init(&pblk->lock);
 
diff --git a/drivers/lightnvm/pblk-recovery.c b/drivers/lightnvm/pblk-recovery.c
index 9cb6d5d..5983428 100644
--- a/drivers/lightnvm/pblk-recovery.c
+++ b/drivers/lightnvm/pblk-recovery.c
@@ -16,97 +16,6 @@
 
 #include "pblk.h"
 
-void pblk_submit_rec(struct work_struct *work)
-{
-	struct pblk_rec_ctx *recovery =
-			container_of(work, struct pblk_rec_ctx, ws_rec);
-	struct pblk *pblk = recovery->pblk;
-	struct nvm_rq *rqd = recovery->rqd;
-	struct pblk_c_ctx *c_ctx = nvm_rq_to_pdu(rqd);
-	struct bio *bio;
-	unsigned int nr_rec_secs;
-	unsigned int pgs_read;
-	int ret;
-
-	nr_rec_secs = bitmap_weight((unsigned long int *)&rqd->ppa_status,
-								NVM_MAX_VLBA);
-
-	bio = bio_alloc(GFP_KERNEL, nr_rec_secs);
-
-	bio->bi_iter.bi_sector = 0;
-	bio_set_op_attrs(bio, REQ_OP_WRITE, 0);
-	rqd->bio = bio;
-	rqd->nr_ppas = nr_rec_secs;
-
-	pgs_read = pblk_rb_read_to_bio_list(&pblk->rwb, bio, &recovery->failed,
-								nr_rec_secs);
-	if (pgs_read != nr_rec_secs) {
-		pr_err("pblk: could not read recovery entries\n");
-		goto err;
-	}
-
-	if (pblk_setup_w_rec_rq(pblk, rqd, c_ctx)) {
-		pr_err("pblk: could not setup recovery request\n");
-		goto err;
-	}
-
-#ifdef CONFIG_NVM_DEBUG
-	atomic_long_add(nr_rec_secs, &pblk->recov_writes);
-#endif
-
-	ret = pblk_submit_io(pblk, rqd);
-	if (ret) {
-		pr_err("pblk: I/O submission failed: %d\n", ret);
-		goto err;
-	}
-
-	mempool_free(recovery, pblk->rec_pool);
-	return;
-
-err:
-	bio_put(bio);
-	pblk_free_rqd(pblk, rqd, PBLK_WRITE);
-}
-
-int pblk_recov_setup_rq(struct pblk *pblk, struct pblk_c_ctx *c_ctx,
-			struct pblk_rec_ctx *recovery, u64 *comp_bits,
-			unsigned int comp)
-{
-	struct nvm_rq *rec_rqd;
-	struct pblk_c_ctx *rec_ctx;
-	int nr_entries = c_ctx->nr_valid + c_ctx->nr_padded;
-
-	rec_rqd = pblk_alloc_rqd(pblk, PBLK_WRITE);
-	rec_ctx = nvm_rq_to_pdu(rec_rqd);
-
-	/* Copy completion bitmap, but exclude the first X completed entries */
-	bitmap_shift_right((unsigned long int *)&rec_rqd->ppa_status,
-				(unsigned long int *)comp_bits,
-				comp, NVM_MAX_VLBA);
-
-	/* Save the context for the entries that need to be re-written and
-	 * update current context with the completed entries.
-	 */
-	rec_ctx->sentry = pblk_rb_wrap_pos(&pblk->rwb, c_ctx->sentry + comp);
-	if (comp >= c_ctx->nr_valid) {
-		rec_ctx->nr_valid = 0;
-		rec_ctx->nr_padded = nr_entries - comp;
-
-		c_ctx->nr_padded = comp - c_ctx->nr_valid;
-	} else {
-		rec_ctx->nr_valid = c_ctx->nr_valid - comp;
-		rec_ctx->nr_padded = c_ctx->nr_padded;
-
-		c_ctx->nr_valid = comp;
-		c_ctx->nr_padded = 0;
-	}
-
-	recovery->rqd = rec_rqd;
-	recovery->pblk = pblk;
-
-	return 0;
-}
-
 int pblk_recov_check_emeta(struct pblk *pblk, struct line_emeta *emeta_buf)
 {
 	u32 crc;
diff --git a/drivers/lightnvm/pblk-write.c b/drivers/lightnvm/pblk-write.c
index 3e6f1eb..ab45157 100644
--- a/drivers/lightnvm/pblk-write.c
+++ b/drivers/lightnvm/pblk-write.c
@@ -103,68 +103,147 @@ static void pblk_complete_write(struct pblk *pblk, struct nvm_rq *rqd,
 	pblk_rb_sync_end(&pblk->rwb, &flags);
 }
 
-/* When a write fails, we are not sure whether the block has grown bad or a page
- * range is more susceptible to write errors. If a high number of pages fail, we
- * assume that the block is bad and we mark it accordingly. In all cases, we
- * remap and resubmit the failed entries as fast as possible; if a flush is
- * waiting on a completion, the whole stack would stall otherwise.
- */
-static void pblk_end_w_fail(struct pblk *pblk, struct nvm_rq *rqd)
+/* Map remaining sectors in chunk, starting from ppa */
+static void pblk_map_remaining(struct pblk *pblk, struct ppa_addr *ppa)
 {
-	void *comp_bits = &rqd->ppa_status;
-	struct pblk_c_ctx *c_ctx = nvm_rq_to_pdu(rqd);
-	struct pblk_rec_ctx *recovery;
-	struct ppa_addr *ppa_list = rqd->ppa_list;
-	int nr_ppas = rqd->nr_ppas;
-	unsigned int c_entries;
-	int bit, ret;
+	struct nvm_tgt_dev *dev = pblk->dev;
+	struct nvm_geo *geo = &dev->geo;
+	struct pblk_line *line;
+	struct ppa_addr map_ppa = *ppa;
+	u64 paddr;
+	int done = 0;
 
-	if (unlikely(nr_ppas == 1))
-		ppa_list = &rqd->ppa_addr;
+	line = &pblk->lines[pblk_ppa_to_line(*ppa)];
+	spin_lock(&line->lock);
 
-	recovery = mempool_alloc(pblk->rec_pool, GFP_ATOMIC);
+	while (!done)  {
+		paddr = pblk_dev_ppa_to_line_addr(pblk, map_ppa);
 
-	INIT_LIST_HEAD(&recovery->failed);
+		if (!test_and_set_bit(paddr, line->map_bitmap))
+			line->left_msecs--;
 
-	bit = -1;
-	while ((bit = find_next_bit(comp_bits, nr_ppas, bit + 1)) < nr_ppas) {
-		struct pblk_rb_entry *entry;
-		struct ppa_addr ppa;
+		if (!test_and_set_bit(paddr, line->invalid_bitmap))
+			le32_add_cpu(line->vsc, -1);
 
-		/* Logic error */
-		if (bit > c_ctx->nr_valid) {
-			WARN_ONCE(1, "pblk: corrupted write request\n");
-			mempool_free(recovery, pblk->rec_pool);
-			goto out;
+		if (geo->version == NVM_OCSSD_SPEC_12) {
+			map_ppa.ppa++;
+			if (map_ppa.g.pg == geo->num_pg)
+				done = 1;
+		} else {
+			map_ppa.m.sec++;
+			if (map_ppa.m.sec == geo->clba)
+				done = 1;
 		}
+	}
 
-		ppa = ppa_list[bit];
-		entry = pblk_rb_sync_scan_entry(&pblk->rwb, &ppa);
-		if (!entry) {
-			pr_err("pblk: could not scan entry on write failure\n");
-			mempool_free(recovery, pblk->rec_pool);
-			goto out;
-		}
+	spin_unlock(&line->lock);
+}
+
+static void pblk_prepare_resubmit(struct pblk *pblk, unsigned int sentry,
+		unsigned int nr_entries)
+{
+	struct pblk_rb *rb = &pblk->rwb;
+	struct pblk_rb_entry *entry;
+	struct pblk_line *line;
+	struct pblk_w_ctx *w_ctx;
+	struct ppa_addr ppa_l2p;
+	int flags;
+	unsigned int pos, i;
+
+	spin_lock(&pblk->trans_lock);
+	pos = sentry;
+	for (i = 0; i < nr_entries; i++) {
+		entry = &rb->entries[pos];
+		w_ctx = &entry->w_ctx;
+
+		/* Check if the lba has been overwritten */
+		ppa_l2p = pblk_trans_map_get(pblk, w_ctx->lba);
+		if (!pblk_ppa_comp(ppa_l2p, entry->cacheline))
+			w_ctx->lba = ADDR_EMPTY;
+
+		/* Mark up the entry as submittable again */
+		flags = READ_ONCE(w_ctx->flags);
+		flags |= PBLK_WRITTEN_DATA;
+		/* Release flags on write context. Protect from writes */
+		smp_store_release(&w_ctx->flags, flags);
 
-		/* The list is filled first and emptied afterwards. No need for
-		 * protecting it with a lock
+		/* Decrese the reference count to the line as we will
+		 * re-map these entries
 		 */
-		list_add_tail(&entry->index, &recovery->failed);
+		line = &pblk->lines[pblk_ppa_to_line(w_ctx->ppa)];
+		kref_put(&line->ref, pblk_line_put);
+
+		pos = (pos + 1) & (rb->nr_entries - 1);
 	}
+	spin_unlock(&pblk->trans_lock);
+}
 
-	c_entries = find_first_bit(comp_bits, nr_ppas);
-	ret = pblk_recov_setup_rq(pblk, c_ctx, recovery, comp_bits, c_entries);
-	if (ret) {
-		pr_err("pblk: could not recover from write failure\n");
-		mempool_free(recovery, pblk->rec_pool);
-		goto out;
+static void pblk_queue_resubmit(struct pblk *pblk, struct pblk_c_ctx *c_ctx)
+{
+	struct pblk_c_ctx *r_ctx;
+
+	r_ctx = kzalloc(sizeof(struct pblk_c_ctx), GFP_KERNEL);
+	if (!r_ctx) {
+		pr_err("pblk: failed to allocate resubmit context");
+		return;
 	}
 
+	r_ctx->lun_bitmap = NULL;
+	r_ctx->sentry = c_ctx->sentry;
+	r_ctx->nr_valid = c_ctx->nr_valid;
+	r_ctx->nr_padded = c_ctx->nr_padded;
+
+	spin_lock(&pblk->resubmit_lock);
+	list_add_tail(&r_ctx->list, &pblk->resubmit_list);
+	spin_unlock(&pblk->resubmit_lock);
+}
+
+static void pblk_submit_rec(struct work_struct *work)
+{
+	struct pblk_rec_ctx *recovery =
+			container_of(work, struct pblk_rec_ctx, ws_rec);
+	struct pblk *pblk = recovery->pblk;
+	struct nvm_rq *rqd = recovery->rqd;
+	struct pblk_c_ctx *c_ctx = nvm_rq_to_pdu(rqd);
+	struct ppa_addr *ppa_list;
+
+	pblk_log_write_err(pblk, rqd);
+
+	if (rqd->nr_ppas == 1)
+		ppa_list = &rqd->ppa_addr;
+	else
+		ppa_list = rqd->ppa_list;
+
+	pblk_map_remaining(pblk, ppa_list);
+	pblk_queue_resubmit(pblk, c_ctx);
+
+	pblk_up_rq(pblk, rqd->ppa_list, rqd->nr_ppas, c_ctx->lun_bitmap);
+	if (c_ctx->nr_padded)
+		pblk_bio_free_pages(pblk, rqd->bio, c_ctx->nr_valid,
+							c_ctx->nr_padded);
+	bio_put(rqd->bio);
+	pblk_free_rqd(pblk, rqd, PBLK_WRITE);
+	mempool_free(recovery, pblk->rec_pool);
+
+	atomic_dec(&pblk->inflight_io);
+}
+
+
+static void pblk_end_w_fail(struct pblk *pblk, struct nvm_rq *rqd)
+{
+	struct pblk_rec_ctx *recovery;
+
+	recovery = mempool_alloc(pblk->rec_pool, GFP_ATOMIC);
+	if (!recovery) {
+		pr_err("pblk: could not allocate recovery work\n");
+		return;
+	}
+
+	recovery->pblk = pblk;
+	recovery->rqd = rqd;
+
 	INIT_WORK(&recovery->ws_rec, pblk_submit_rec);
 	queue_work(pblk->close_wq, &recovery->ws_rec);
-
-out:
-	pblk_complete_write(pblk, rqd, c_ctx);
 }
 
 static void pblk_end_io_write(struct nvm_rq *rqd)
@@ -173,8 +252,8 @@ static void pblk_end_io_write(struct nvm_rq *rqd)
 	struct pblk_c_ctx *c_ctx = nvm_rq_to_pdu(rqd);
 
 	if (rqd->error) {
-		pblk_log_write_err(pblk, rqd);
-		return pblk_end_w_fail(pblk, rqd);
+		pblk_end_w_fail(pblk, rqd);
+		return;
 	}
 #ifdef CONFIG_NVM_DEBUG
 	else
@@ -339,6 +418,7 @@ int pblk_submit_meta_io(struct pblk *pblk, struct pblk_line *meta_line)
 	bio = pblk_bio_map_addr(pblk, data, rq_ppas, rq_len,
 					l_mg->emeta_alloc_type, GFP_KERNEL);
 	if (IS_ERR(bio)) {
+		pr_err("pblk: failed to map emeta io");
 		ret = PTR_ERR(bio);
 		goto fail_free_rqd;
 	}
@@ -515,26 +595,54 @@ static int pblk_submit_write(struct pblk *pblk)
 	unsigned int secs_avail, secs_to_sync, secs_to_com;
 	unsigned int secs_to_flush;
 	unsigned long pos;
+	unsigned int resubmit;
 
-	/* If there are no sectors in the cache, flushes (bios without data)
-	 * will be cleared on the cache threads
-	 */
-	secs_avail = pblk_rb_read_count(&pblk->rwb);
-	if (!secs_avail)
-		return 1;
-
-	secs_to_flush = pblk_rb_flush_point_count(&pblk->rwb);
-	if (!secs_to_flush && secs_avail < pblk->min_write_pgs)
-		return 1;
-
-	secs_to_sync = pblk_calc_secs_to_sync(pblk, secs_avail, secs_to_flush);
-	if (secs_to_sync > pblk->max_write_pgs) {
-		pr_err("pblk: bad buffer sync calculation\n");
-		return 1;
-	}
+	spin_lock(&pblk->resubmit_lock);
+	resubmit = !list_empty(&pblk->resubmit_list);
+	spin_unlock(&pblk->resubmit_lock);
+
+	/* Resubmit failed writes first */
+	if (resubmit) {
+		struct pblk_c_ctx *r_ctx;
+
+		spin_lock(&pblk->resubmit_lock);
+		r_ctx = list_first_entry(&pblk->resubmit_list,
+					struct pblk_c_ctx, list);
+		list_del(&r_ctx->list);
+		spin_unlock(&pblk->resubmit_lock);
 
-	secs_to_com = (secs_to_sync > secs_avail) ? secs_avail : secs_to_sync;
-	pos = pblk_rb_read_commit(&pblk->rwb, secs_to_com);
+		secs_avail = r_ctx->nr_valid;
+		pos = r_ctx->sentry;
+
+		pblk_prepare_resubmit(pblk, pos, secs_avail);
+		secs_to_sync = pblk_calc_secs_to_sync(pblk, secs_avail,
+				secs_avail);
+
+		kfree(r_ctx);
+	} else {
+		/* If there are no sectors in the cache,
+		 * flushes (bios without data) will be cleared on
+		 * the cache threads
+		 */
+		secs_avail = pblk_rb_read_count(&pblk->rwb);
+		if (!secs_avail)
+			return 1;
+
+		secs_to_flush = pblk_rb_flush_point_count(&pblk->rwb);
+		if (!secs_to_flush && secs_avail < pblk->min_write_pgs)
+			return 1;
+
+		secs_to_sync = pblk_calc_secs_to_sync(pblk, secs_avail,
+					secs_to_flush);
+		if (secs_to_sync > pblk->max_write_pgs) {
+			pr_err("pblk: bad buffer sync calculation\n");
+			return 1;
+		}
+
+		secs_to_com = (secs_to_sync > secs_avail) ?
+			secs_avail : secs_to_sync;
+		pos = pblk_rb_read_commit(&pblk->rwb, secs_to_com);
+	}
 
 	bio = bio_alloc(GFP_KERNEL, secs_to_sync);
 
@@ -553,6 +661,7 @@ static int pblk_submit_write(struct pblk *pblk)
 	if (pblk_submit_io_set(pblk, rqd))
 		goto fail_free_bio;
 
+
 #ifdef CONFIG_NVM_DEBUG
 	atomic_long_add(secs_to_sync, &pblk->sub_writes);
 #endif
diff --git a/drivers/lightnvm/pblk.h b/drivers/lightnvm/pblk.h
index 9838d03..cff6aea 100644
--- a/drivers/lightnvm/pblk.h
+++ b/drivers/lightnvm/pblk.h
@@ -128,7 +128,6 @@ struct pblk_pad_rq {
 struct pblk_rec_ctx {
 	struct pblk *pblk;
 	struct nvm_rq *rqd;
-	struct list_head failed;
 	struct work_struct ws_rec;
 };
 
@@ -664,6 +663,9 @@ struct pblk {
 
 	struct list_head compl_list;
 
+	spinlock_t resubmit_lock;	 /* Resubmit list lock */
+	struct list_head resubmit_list; /* Resubmit list for failed writes*/
+
 	mempool_t *page_bio_pool;
 	mempool_t *gen_ws_pool;
 	mempool_t *rec_pool;
@@ -849,13 +851,9 @@ int pblk_submit_read_gc(struct pblk *pblk, struct pblk_gc_rq *gc_rq);
 /*
  * pblk recovery
  */
-void pblk_submit_rec(struct work_struct *work);
 struct pblk_line *pblk_recov_l2p(struct pblk *pblk);
 int pblk_recov_pad(struct pblk *pblk);
 int pblk_recov_check_emeta(struct pblk *pblk, struct line_emeta *emeta);
-int pblk_recov_setup_rq(struct pblk *pblk, struct pblk_c_ctx *c_ctx,
-			struct pblk_rec_ctx *recovery, u64 *comp_bits,
-			unsigned int comp);
 
 /*
  * pblk gc
-- 
2.7.4
