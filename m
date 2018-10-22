Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mga04.intel.com ([192.55.52.120]:63986 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728101AbeJVTE2 (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Mon, 22 Oct 2018 15:04:28 -0400
From: Igor Konopko <igor.j.konopko@intel.com>
To: mb@lightnvm.io, javier@cnexlabs.com, hans.ml.holmberg@owltronix.com
Cc: linux-block@vger.kernel.org, igor.j.konopko@intel.com
Subject: [PATCH v2 5/5] lightnvm: pblk: Support for packed metadata
Date: Mon, 22 Oct 2018 12:36:11 +0200
Message-Id: <20181022103611.39271-6-igor.j.konopko@intel.com>
In-Reply-To: <20181022103611.39271-1-igor.j.konopko@intel.com>
References: <20181022103611.39271-1-igor.j.konopko@intel.com>
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

In current pblk implementation, l2p mapping for not closed lines
is always stored only in OOB metadata and recovered from it.

Such a solution does not provide data integrity when drives does
not have such a OOB metadata space.

The goal of this patch is to add support for so called packed
metadata, which store l2p mapping for open lines in last sector
of every write unit.

Signed-off-by: Igor Konopko <igor.j.konopko@intel.com>
---
 drivers/lightnvm/pblk-core.c     | 53 +++++++++++++++++++++++++++++++++++++---
 drivers/lightnvm/pblk-init.c     | 37 ++++++++++++++++++++++++++--
 drivers/lightnvm/pblk-rb.c       |  3 +++
 drivers/lightnvm/pblk-read.c     |  6 +++++
 drivers/lightnvm/pblk-recovery.c |  5 ++--
 drivers/lightnvm/pblk-sysfs.c    |  7 ++++++
 drivers/lightnvm/pblk-write.c    | 14 ++++++++---
 drivers/lightnvm/pblk.h          | 13 +++++++++-
 8 files changed, 125 insertions(+), 13 deletions(-)

diff --git a/drivers/lightnvm/pblk-core.c b/drivers/lightnvm/pblk-core.c
index b1e104765868..245abf29620f 100644
--- a/drivers/lightnvm/pblk-core.c
+++ b/drivers/lightnvm/pblk-core.c
@@ -376,7 +376,7 @@ void pblk_write_should_kick(struct pblk *pblk)
 {
 	unsigned int secs_avail = pblk_rb_read_count(&pblk->rwb);
 
-	if (secs_avail >= pblk->min_write_pgs)
+	if (secs_avail >= pblk->min_write_pgs_data)
 		pblk_write_kick(pblk);
 }
 
@@ -407,7 +407,9 @@ struct list_head *pblk_line_gc_list(struct pblk *pblk, struct pblk_line *line)
 	struct pblk_line_meta *lm = &pblk->lm;
 	struct pblk_line_mgmt *l_mg = &pblk->l_mg;
 	struct list_head *move_list = NULL;
-	int vsc = le32_to_cpu(*line->vsc);
+	int packed_meta = (le32_to_cpu(*line->vsc) / pblk->min_write_pgs_data)
+			* (pblk->min_write_pgs - pblk->min_write_pgs_data);
+	int vsc = le32_to_cpu(*line->vsc) + packed_meta;
 
 	lockdep_assert_held(&line->lock);
 
@@ -620,12 +622,15 @@ struct bio *pblk_bio_map_addr(struct pblk *pblk, void *data,
 }
 
 int pblk_calc_secs(struct pblk *pblk, unsigned long secs_avail,
-		   unsigned long secs_to_flush)
+		   unsigned long secs_to_flush, bool skip_meta)
 {
 	int max = pblk->sec_per_write;
 	int min = pblk->min_write_pgs;
 	int secs_to_sync = 0;
 
+	if (skip_meta && pblk->min_write_pgs_data != pblk->min_write_pgs)
+		min = max = pblk->min_write_pgs_data;
+
 	if (secs_avail >= max)
 		secs_to_sync = max;
 	else if (secs_avail >= min)
@@ -852,7 +857,7 @@ int pblk_line_emeta_read(struct pblk *pblk, struct pblk_line *line,
 next_rq:
 	memset(&rqd, 0, sizeof(struct nvm_rq));
 
-	rq_ppas = pblk_calc_secs(pblk, left_ppas, 0);
+	rq_ppas = pblk_calc_secs(pblk, left_ppas, 0, false);
 	rq_len = rq_ppas * geo->csecs;
 
 	bio = pblk_bio_map_addr(pblk, emeta_buf, rq_ppas, rq_len,
@@ -2161,3 +2166,43 @@ void pblk_lookup_l2p_rand(struct pblk *pblk, struct ppa_addr *ppas,
 	}
 	spin_unlock(&pblk->trans_lock);
 }
+
+void pblk_set_packed_meta(struct pblk *pblk, struct nvm_rq *rqd)
+{
+	void *meta_list = rqd->meta_list;
+	void *page;
+	int i = 0;
+
+	if (pblk_is_oob_meta_supported(pblk))
+		return;
+
+	/* We need to zero out metadata corresponding to packed meta page */
+	pblk_set_meta_lba(pblk, meta_list, rqd->nr_ppas - 1,
+			  cpu_to_le64(ADDR_EMPTY));
+
+	page = page_to_virt(rqd->bio->bi_io_vec[rqd->bio->bi_vcnt - 1].bv_page);
+	/* We need to fill last page of request (packed metadata)
+	 * with data from oob meta buffer.
+	 */
+	for (; i < rqd->nr_ppas; i++)
+		memcpy(page + (i * sizeof(struct pblk_sec_meta)),
+			pblk_get_meta(pblk, meta_list, i),
+			sizeof(struct pblk_sec_meta));
+}
+
+void pblk_get_packed_meta(struct pblk *pblk, struct nvm_rq *rqd)
+{
+	void *meta_list = rqd->meta_list;
+	void *page;
+	int i = 0;
+
+	if (pblk_is_oob_meta_supported(pblk))
+		return;
+
+	page = page_to_virt(rqd->bio->bi_io_vec[rqd->bio->bi_vcnt - 1].bv_page);
+	/* We need to fill oob meta buffer with data from packe metadata */
+	for (; i < rqd->nr_ppas; i++)
+		memcpy(pblk_get_meta(pblk, meta_list, i),
+			page + (i * sizeof(struct pblk_sec_meta)),
+			sizeof(struct pblk_sec_meta));
+}
diff --git a/drivers/lightnvm/pblk-init.c b/drivers/lightnvm/pblk-init.c
index ded0618f6cda..7e09717a93d4 100644
--- a/drivers/lightnvm/pblk-init.c
+++ b/drivers/lightnvm/pblk-init.c
@@ -406,12 +406,44 @@ static int pblk_core_init(struct pblk *pblk)
 	pblk->nr_flush_rst = 0;
 
 	pblk->min_write_pgs = geo->ws_opt;
+	pblk->min_write_pgs_data = pblk->min_write_pgs;
 	max_write_ppas = pblk->min_write_pgs * geo->all_luns;
 	pblk->max_write_pgs = min_t(int, max_write_ppas, NVM_MAX_VLBA);
 	pblk->max_write_pgs = min_t(int, pblk->max_write_pgs,
 		queue_max_hw_sectors(dev->q) / (geo->csecs >> SECTOR_SHIFT));
 	pblk_set_sec_per_write(pblk, pblk->min_write_pgs);
 
+	if (!pblk_is_oob_meta_supported(pblk)) {
+		/* For drives which does not have OOB metadata feature
+		 * in order to support recovery feature we need to use
+		 * so called packed metadata. Packed metada will store
+		 * the same information as OOB metadata (l2p table mapping,
+		 * but in the form of the single page at the end of
+		 * every write request.
+		 */
+		if (pblk->min_write_pgs
+			* sizeof(struct pblk_sec_meta) > PAGE_SIZE) {
+			/* We want to keep all the packed metadata on single
+			 * page per write requests. So we need to ensure that
+			 * it will fit.
+			 *
+			 * This is more like sanity check, since there is
+			 * no device with such a big minimal write size
+			 * (above 1 metabytes).
+			 */
+			pblk_err(pblk, "Not supported min write size\n");
+			return -EINVAL;
+		}
+		/* For packed meta approach we do some simplification.
+		 * On read path we always issue requests which size
+		 * equal to max_write_pgs, with all pages filled with
+		 * user payload except of last one page which will be
+		 * filled with packed metadata.
+		 */
+		pblk->max_write_pgs = pblk->min_write_pgs;
+		pblk->min_write_pgs_data = pblk->min_write_pgs - 1;
+	}
+
 	pblk->pad_dist = kcalloc(pblk->min_write_pgs - 1, sizeof(atomic64_t),
 								GFP_KERNEL);
 	if (!pblk->pad_dist)
@@ -642,7 +674,7 @@ static void pblk_set_provision(struct pblk *pblk, long nr_free_blks)
 	struct pblk_line_meta *lm = &pblk->lm;
 	struct nvm_geo *geo = &dev->geo;
 	sector_t provisioned;
-	int sec_meta, blk_meta;
+	int sec_meta, blk_meta, clba;
 
 	if (geo->op == NVM_TARGET_DEFAULT_OP)
 		pblk->op = PBLK_DEFAULT_OP;
@@ -665,7 +697,8 @@ static void pblk_set_provision(struct pblk *pblk, long nr_free_blks)
 	sec_meta = (lm->smeta_sec + lm->emeta_sec[0]) * l_mg->nr_free_lines;
 	blk_meta = DIV_ROUND_UP(sec_meta, geo->clba);
 
-	pblk->capacity = (provisioned - blk_meta) * geo->clba;
+	clba = (geo->clba / pblk->min_write_pgs) * pblk->min_write_pgs_data;
+	pblk->capacity = (provisioned - blk_meta) * clba;
 
 	atomic_set(&pblk->rl.free_blocks, nr_free_blks);
 	atomic_set(&pblk->rl.free_user_blocks, nr_free_blks);
diff --git a/drivers/lightnvm/pblk-rb.c b/drivers/lightnvm/pblk-rb.c
index b1f4b51783f4..82eb398bbbbe 100644
--- a/drivers/lightnvm/pblk-rb.c
+++ b/drivers/lightnvm/pblk-rb.c
@@ -552,6 +552,9 @@ unsigned int pblk_rb_read_to_bio(struct pblk_rb *rb, struct nvm_rq *rqd,
 		to_read = count;
 	}
 
+	/* Add space for packed metadata if in use*/
+	pad += (pblk->min_write_pgs - pblk->min_write_pgs_data);
+
 	c_ctx->sentry = pos;
 	c_ctx->nr_valid = to_read;
 	c_ctx->nr_padded = pad;
diff --git a/drivers/lightnvm/pblk-read.c b/drivers/lightnvm/pblk-read.c
index cc73a1594180..1d9c9b0a114b 100644
--- a/drivers/lightnvm/pblk-read.c
+++ b/drivers/lightnvm/pblk-read.c
@@ -112,6 +112,9 @@ static void pblk_read_check_seq(struct pblk *pblk, struct nvm_rq *rqd,
 	int nr_lbas = rqd->nr_ppas;
 	int i;
 
+	if (!pblk_is_oob_meta_supported(pblk))
+		return;
+
 	for (i = 0; i < nr_lbas; i++) {
 		u64 lba = le64_to_cpu(pblk_get_meta_lba(pblk, meta_list, i));
 
@@ -140,6 +143,9 @@ static void pblk_read_check_rand(struct pblk *pblk, struct nvm_rq *rqd,
 	void *meta_lba_list = rqd->meta_list;
 	int i, j;
 
+	if (!pblk_is_oob_meta_supported(pblk))
+		return;
+
 	for (i = 0, j = 0; i < nr_lbas; i++) {
 		u64 lba = lba_list[i];
 		u64 meta_lba;
diff --git a/drivers/lightnvm/pblk-recovery.c b/drivers/lightnvm/pblk-recovery.c
index b5c8a0ed9bb1..ccb4984b231e 100644
--- a/drivers/lightnvm/pblk-recovery.c
+++ b/drivers/lightnvm/pblk-recovery.c
@@ -188,7 +188,7 @@ static int pblk_recov_pad_line(struct pblk *pblk, struct pblk_line *line,
 	kref_init(&pad_rq->ref);
 
 next_pad_rq:
-	rq_ppas = pblk_calc_secs(pblk, left_ppas, 0);
+	rq_ppas = pblk_calc_secs(pblk, left_ppas, 0, false);
 	if (rq_ppas < pblk->min_write_pgs) {
 		pblk_err(pblk, "corrupted pad line %d\n", line->id);
 		goto fail_free_pad;
@@ -365,7 +365,7 @@ static int pblk_recov_scan_oob(struct pblk *pblk, struct pblk_line *line,
 next_rq:
 	memset(rqd, 0, pblk_g_rq_size);
 
-	rq_ppas = pblk_calc_secs(pblk, left_ppas, 0);
+	rq_ppas = pblk_calc_secs(pblk, left_ppas, 0, false);
 	if (!rq_ppas)
 		rq_ppas = pblk->min_write_pgs;
 	rq_len = rq_ppas * geo->csecs;
@@ -434,6 +434,7 @@ static int pblk_recov_scan_oob(struct pblk *pblk, struct pblk_line *line,
 		goto retry_rq;
 	}
 
+	pblk_get_packed_meta(pblk, rqd);
 	for (i = 0; i < rqd->nr_ppas; i++) {
 		u64 lba = le64_to_cpu(pblk_get_meta_lba(pblk, meta_list, i));
 
diff --git a/drivers/lightnvm/pblk-sysfs.c b/drivers/lightnvm/pblk-sysfs.c
index 2d2818155aa8..7d8958df9472 100644
--- a/drivers/lightnvm/pblk-sysfs.c
+++ b/drivers/lightnvm/pblk-sysfs.c
@@ -479,6 +479,13 @@ static ssize_t pblk_sysfs_set_sec_per_write(struct pblk *pblk,
 	if (kstrtouint(page, 0, &sec_per_write))
 		return -EINVAL;
 
+	if (!pblk_is_oob_meta_supported(pblk)) {
+		/* For packed metadata case it is
+		 * not allowed to change sec_per_write.
+		 */
+		return -EINVAL;
+	}
+
 	if (sec_per_write < pblk->min_write_pgs
 				|| sec_per_write > pblk->max_write_pgs
 				|| sec_per_write % pblk->min_write_pgs != 0)
diff --git a/drivers/lightnvm/pblk-write.c b/drivers/lightnvm/pblk-write.c
index fa8726493b39..c78dfb996bcb 100644
--- a/drivers/lightnvm/pblk-write.c
+++ b/drivers/lightnvm/pblk-write.c
@@ -332,7 +332,7 @@ static int pblk_calc_secs_to_sync(struct pblk *pblk, unsigned int secs_avail,
 {
 	int secs_to_sync;
 
-	secs_to_sync = pblk_calc_secs(pblk, secs_avail, secs_to_flush);
+	secs_to_sync = pblk_calc_secs(pblk, secs_avail, secs_to_flush, true);
 
 #ifdef CONFIG_NVM_PBLK_DEBUG
 	if ((!secs_to_sync && secs_to_flush)
@@ -502,6 +502,11 @@ static int pblk_submit_io_set(struct pblk *pblk, struct nvm_rq *rqd)
 		return NVM_IO_ERR;
 	}
 
+	/* This is the first place when we have write requests mapped
+	 * and we can fill packed metadata with l2p mappings.
+	 */
+	pblk_set_packed_meta(pblk, rqd);
+
 	meta_line = pblk_should_submit_meta_io(pblk, rqd);
 
 	/* Submit data write for current data line */
@@ -553,7 +558,7 @@ static int pblk_submit_write(struct pblk *pblk)
 	struct bio *bio;
 	struct nvm_rq *rqd;
 	unsigned int secs_avail, secs_to_sync, secs_to_com;
-	unsigned int secs_to_flush;
+	unsigned int secs_to_flush, packed_meta_pgs;
 	unsigned long pos;
 	unsigned int resubmit;
 
@@ -589,7 +594,7 @@ static int pblk_submit_write(struct pblk *pblk)
 			return 1;
 
 		secs_to_flush = pblk_rb_flush_point_count(&pblk->rwb);
-		if (!secs_to_flush && secs_avail < pblk->min_write_pgs)
+		if (!secs_to_flush && secs_avail < pblk->min_write_pgs_data)
 			return 1;
 
 		secs_to_sync = pblk_calc_secs_to_sync(pblk, secs_avail,
@@ -604,7 +609,8 @@ static int pblk_submit_write(struct pblk *pblk)
 		pos = pblk_rb_read_commit(&pblk->rwb, secs_to_com);
 	}
 
-	bio = bio_alloc(GFP_KERNEL, secs_to_sync);
+	packed_meta_pgs = (pblk->min_write_pgs - pblk->min_write_pgs_data);
+	bio = bio_alloc(GFP_KERNEL, secs_to_sync + packed_meta_pgs);
 
 	bio->bi_iter.bi_sector = 0; /* internal bio */
 	bio_set_op_attrs(bio, REQ_OP_WRITE, 0);
diff --git a/drivers/lightnvm/pblk.h b/drivers/lightnvm/pblk.h
index c03fa037d037..4d22b724400b 100644
--- a/drivers/lightnvm/pblk.h
+++ b/drivers/lightnvm/pblk.h
@@ -632,6 +632,7 @@ struct pblk {
 	int state;			/* pblk line state */
 
 	int min_write_pgs; /* Minimum amount of pages required by controller */
+	int min_write_pgs_data; /* Minimum amount of payload pages */
 	int max_write_pgs; /* Maximum amount of pages supported by controller */
 
 	sector_t capacity; /* Device capacity when bad blocks are subtracted */
@@ -837,7 +838,7 @@ void pblk_dealloc_page(struct pblk *pblk, struct pblk_line *line, int nr_secs);
 u64 pblk_alloc_page(struct pblk *pblk, struct pblk_line *line, int nr_secs);
 u64 __pblk_alloc_page(struct pblk *pblk, struct pblk_line *line, int nr_secs);
 int pblk_calc_secs(struct pblk *pblk, unsigned long secs_avail,
-		   unsigned long secs_to_flush);
+		   unsigned long secs_to_flush, bool skip_meta);
 void pblk_down_rq(struct pblk *pblk, struct ppa_addr ppa,
 		  unsigned long *lun_bitmap);
 void pblk_down_chunk(struct pblk *pblk, struct ppa_addr ppa);
@@ -861,6 +862,8 @@ void pblk_lookup_l2p_rand(struct pblk *pblk, struct ppa_addr *ppas,
 			  u64 *lba_list, int nr_secs);
 void pblk_lookup_l2p_seq(struct pblk *pblk, struct ppa_addr *ppas,
 			 sector_t blba, int nr_secs);
+void pblk_set_packed_meta(struct pblk *pblk, struct nvm_rq *rqd);
+void pblk_get_packed_meta(struct pblk *pblk, struct nvm_rq *rqd);
 
 /*
  * pblk user I/O write path
@@ -1402,4 +1405,12 @@ static inline int pblk_dma_meta_size(struct pblk *pblk)
 	return max_t(int, sizeof(struct pblk_sec_meta), geo->sos)
 				* NVM_MAX_VLBA;
 }
+
+static inline int pblk_is_oob_meta_supported(struct pblk *pblk)
+{
+	struct nvm_tgt_dev *dev = pblk->dev;
+	struct nvm_geo *geo = &dev->geo;
+
+	return (geo->sos >= sizeof(struct pblk_sec_meta));
+}
 #endif /* PBLK_H_ */
-- 
2.14.4
