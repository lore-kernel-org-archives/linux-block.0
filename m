Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mail-wm0-f66.google.com ([74.125.82.66]:35554 "EHLO
        mail-wm0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753296AbeBZNRu (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 26 Feb 2018 08:17:50 -0500
Received: by mail-wm0-f66.google.com with SMTP id x7so14834267wmc.0
        for <linux-block@vger.kernel.org>; Mon, 26 Feb 2018 05:17:50 -0800 (PST)
From: "=?UTF-8?q?Javier=20Gonz=C3=A1lez?=" <jg@lightnvm.io>
To: mb@lightnvm.io
Cc: linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-nvme@lists.infradead.org,
        =?UTF-8?q?Javier=20Gonz=C3=A1lez?= <javier@cnexlabs.com>
Subject: [PATCH 18/19] lightnvm: pblk: refactor init/exit sequences
Date: Mon, 26 Feb 2018 14:17:17 +0100
Message-Id: <1519651038-16845-19-git-send-email-javier@cnexlabs.com>
In-Reply-To: <1519651038-16845-1-git-send-email-javier@cnexlabs.com>
References: <1519651038-16845-1-git-send-email-javier@cnexlabs.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

Refactor init and exit sequences to improve readability. In the way, fix
bad free ordering on the init error path.

Signed-off-by: Javier González <javier@cnexlabs.com>
---
 drivers/lightnvm/pblk-init.c | 535 +++++++++++++++++++++----------------------
 1 file changed, 267 insertions(+), 268 deletions(-)

diff --git a/drivers/lightnvm/pblk-init.c b/drivers/lightnvm/pblk-init.c
index cf4f49d48aed..7f88fb937440 100644
--- a/drivers/lightnvm/pblk-init.c
+++ b/drivers/lightnvm/pblk-init.c
@@ -103,7 +103,40 @@ static void pblk_l2p_free(struct pblk *pblk)
 	vfree(pblk->trans_map);
 }
 
-static int pblk_l2p_init(struct pblk *pblk)
+static int pblk_l2p_recover(struct pblk *pblk, bool factory_init)
+{
+	struct pblk_line *line = NULL;
+
+	if (factory_init) {
+		pblk_setup_uuid(pblk);
+	} else {
+		line = pblk_recov_l2p(pblk);
+		if (IS_ERR(line)) {
+			pr_err("pblk: could not recover l2p table\n");
+			return -EFAULT;
+		}
+	}
+
+#ifdef CONFIG_NVM_DEBUG
+	pr_info("pblk init: L2P CRC: %x\n", pblk_l2p_crc(pblk));
+#endif
+
+	/* Free full lines directly as GC has not been started yet */
+	pblk_gc_free_full_lines(pblk);
+
+	if (!line) {
+		/* Configure next line for user data */
+		line = pblk_line_get_first_data(pblk);
+		if (!line) {
+			pr_err("pblk: line list corrupted\n");
+			return -EFAULT;
+		}
+	}
+
+	return 0;
+}
+
+static int pblk_l2p_init(struct pblk *pblk, bool factory_init)
 {
 	sector_t i;
 	struct ppa_addr ppa;
@@ -119,7 +152,7 @@ static int pblk_l2p_init(struct pblk *pblk)
 	for (i = 0; i < pblk->rl.nr_secs; i++)
 		pblk_trans_map_set(pblk, i, ppa);
 
-	return 0;
+	return pblk_l2p_recover(pblk, factory_init);
 }
 
 static void pblk_rwb_free(struct pblk *pblk)
@@ -268,86 +301,113 @@ static int pblk_core_init(struct pblk *pblk)
 {
 	struct nvm_tgt_dev *dev = pblk->dev;
 	struct nvm_geo *geo = &dev->geo;
+	int max_write_ppas;
+
+	atomic64_set(&pblk->user_wa, 0);
+	atomic64_set(&pblk->pad_wa, 0);
+	atomic64_set(&pblk->gc_wa, 0);
+	pblk->user_rst_wa = 0;
+	pblk->pad_rst_wa = 0;
+	pblk->gc_rst_wa = 0;
+
+	atomic_long_set(&pblk->nr_flush, 0);
+	pblk->nr_flush_rst = 0;
 
 	pblk->pgs_in_buffer = geo->c.mw_cunits * geo->c.ws_opt * geo->all_luns;
 
+	pblk->min_write_pgs = geo->c.ws_opt * (geo->c.csecs / PAGE_SIZE);
+	max_write_ppas = pblk->min_write_pgs * geo->all_luns;
+	pblk->max_write_pgs = (max_write_ppas < NVM_MAX_VLBA) ?
+				max_write_ppas : NVM_MAX_VLBA;
+	pblk_set_sec_per_write(pblk, pblk->min_write_pgs);
+
+	if (pblk->max_write_pgs > PBLK_MAX_REQ_ADDRS) {
+		pr_err("pblk: cannot support device max_phys_sect\n");
+		return -EINVAL;
+	}
+
+	pblk->pad_dist = kzalloc((pblk->min_write_pgs - 1) * sizeof(atomic64_t),
+								GFP_KERNEL);
+	if (!pblk->pad_dist)
+		return -ENOMEM;
+
 	if (pblk_init_global_caches(pblk))
-		return -ENOMEM;
+		goto fail_free_pad_dist;
 
 	/* Internal bios can be at most the sectors signaled by the device. */
 	pblk->page_bio_pool = mempool_create_page_pool(NVM_MAX_VLBA, 0);
 	if (!pblk->page_bio_pool)
-		goto free_global_caches;
+		goto fail_free_global_caches;
 
 	pblk->gen_ws_pool = mempool_create_slab_pool(PBLK_GEN_WS_POOL_SIZE,
 							pblk_ws_cache);
 	if (!pblk->gen_ws_pool)
-		goto free_page_bio_pool;
+		goto fail_free_page_bio_pool;
 
 	pblk->rec_pool = mempool_create_slab_pool(geo->all_luns,
 							pblk_rec_cache);
 	if (!pblk->rec_pool)
-		goto free_gen_ws_pool;
+		goto fail_free_gen_ws_pool;
 
 	pblk->r_rq_pool = mempool_create_slab_pool(geo->all_luns,
 							pblk_g_rq_cache);
 	if (!pblk->r_rq_pool)
-		goto free_rec_pool;
+		goto fail_free_rec_pool;
 
 	pblk->e_rq_pool = mempool_create_slab_pool(geo->all_luns,
 							pblk_g_rq_cache);
 	if (!pblk->e_rq_pool)
-		goto free_r_rq_pool;
+		goto fail_free_r_rq_pool;
 
 	pblk->w_rq_pool = mempool_create_slab_pool(geo->all_luns,
 							pblk_w_rq_cache);
 	if (!pblk->w_rq_pool)
-		goto free_e_rq_pool;
+		goto fail_free_e_rq_pool;
 
 	pblk->close_wq = alloc_workqueue("pblk-close-wq",
 			WQ_MEM_RECLAIM | WQ_UNBOUND, PBLK_NR_CLOSE_JOBS);
 	if (!pblk->close_wq)
-		goto free_w_rq_pool;
+		goto fail_free_w_rq_pool;
 
 	pblk->bb_wq = alloc_workqueue("pblk-bb-wq",
 			WQ_MEM_RECLAIM | WQ_UNBOUND, 0);
 	if (!pblk->bb_wq)
-		goto free_close_wq;
+		goto fail_free_close_wq;
 
 	pblk->r_end_wq = alloc_workqueue("pblk-read-end-wq",
 			WQ_MEM_RECLAIM | WQ_UNBOUND, 0);
 	if (!pblk->r_end_wq)
-		goto free_bb_wq;
+		goto fail_free_bb_wq;
 
 	if (pblk_set_addrf(pblk))
-		goto free_r_end_wq;
-
-	if (pblk_rwb_init(pblk))
-		goto free_r_end_wq;
+		goto fail_free_r_end_wq;
 
 	INIT_LIST_HEAD(&pblk->compl_list);
+
 	return 0;
 
-free_r_end_wq:
+fail_free_r_end_wq:
 	destroy_workqueue(pblk->r_end_wq);
-free_bb_wq:
+fail_free_bb_wq:
 	destroy_workqueue(pblk->bb_wq);
-free_close_wq:
+fail_free_close_wq:
 	destroy_workqueue(pblk->close_wq);
-free_w_rq_pool:
+fail_free_w_rq_pool:
 	mempool_destroy(pblk->w_rq_pool);
-free_e_rq_pool:
+fail_free_e_rq_pool:
 	mempool_destroy(pblk->e_rq_pool);
-free_r_rq_pool:
+fail_free_r_rq_pool:
 	mempool_destroy(pblk->r_rq_pool);
-free_rec_pool:
+fail_free_rec_pool:
 	mempool_destroy(pblk->rec_pool);
-free_gen_ws_pool:
+fail_free_gen_ws_pool:
 	mempool_destroy(pblk->gen_ws_pool);
-free_page_bio_pool:
+fail_free_page_bio_pool:
 	mempool_destroy(pblk->page_bio_pool);
-free_global_caches:
+fail_free_global_caches:
 	pblk_free_global_caches(pblk);
+fail_free_pad_dist:
+	kfree(pblk->pad_dist);
 	return -ENOMEM;
 }
 
@@ -369,14 +429,8 @@ static void pblk_core_free(struct pblk *pblk)
 	mempool_destroy(pblk->e_rq_pool);
 	mempool_destroy(pblk->w_rq_pool);
 
-	pblk_rwb_free(pblk);
-
 	pblk_free_global_caches(pblk);
-}
-
-static void pblk_luns_free(struct pblk *pblk)
-{
-	kfree(pblk->luns);
+	kfree(pblk->pad_dist);
 }
 
 static void pblk_line_mg_free(struct pblk *pblk)
@@ -393,8 +447,6 @@ static void pblk_line_mg_free(struct pblk *pblk)
 		pblk_mfree(l_mg->eline_meta[i]->buf, l_mg->emeta_alloc_type);
 		kfree(l_mg->eline_meta[i]);
 	}
-
-	kfree(pblk->lines);
 }
 
 static void pblk_line_meta_free(struct pblk_line *line)
@@ -418,6 +470,11 @@ static void pblk_lines_free(struct pblk *pblk)
 		pblk_line_meta_free(line);
 	}
 	spin_unlock(&l_mg->free_lock);
+
+	pblk_line_mg_free(pblk);
+
+	kfree(pblk->luns);
+	kfree(pblk->lines);
 }
 
 static int pblk_bb_get_tbl(struct nvm_tgt_dev *dev, struct pblk_lun *rlun,
@@ -481,7 +538,7 @@ static void *pblk_chunk_get_meta(struct pblk *pblk)
 		return pblk_chunk_get_info(pblk);
 }
 
-static int pblk_luns_init(struct pblk *pblk, struct ppa_addr *luns)
+static int pblk_luns_init(struct pblk *pblk)
 {
 	struct nvm_tgt_dev *dev = pblk->dev;
 	struct nvm_geo *geo = &dev->geo;
@@ -494,11 +551,6 @@ static int pblk_luns_init(struct pblk *pblk, struct ppa_addr *luns)
 		return -EINVAL;
 	}
 
-	pblk->luns = kcalloc(geo->all_luns, sizeof(struct pblk_lun),
-								GFP_KERNEL);
-	if (!pblk->luns)
-		return -ENOMEM;
-
 	for (i = 0; i < geo->all_luns; i++) {
 		/* Stripe across channels */
 		int ch = i % geo->num_ch;
@@ -506,8 +558,8 @@ static int pblk_luns_init(struct pblk *pblk, struct ppa_addr *luns)
 		int lunid = lun_raw + ch * geo->num_lun;
 
 		rlun = &pblk->luns[i];
-		rlun->bppa = luns[lunid];
-		rlun->chunk_bppa = luns[i];
+		rlun->bppa = dev->luns[lunid];
+		rlun->chunk_bppa = dev->luns[i];
 
 		sema_init(&rlun->wr_sem, 1);
 	}
@@ -515,38 +567,6 @@ static int pblk_luns_init(struct pblk *pblk, struct ppa_addr *luns)
 	return 0;
 }
 
-static int pblk_lines_configure(struct pblk *pblk, int flags)
-{
-	struct pblk_line *line = NULL;
-	int ret = 0;
-
-	if (!(flags & NVM_TARGET_FACTORY)) {
-		line = pblk_recov_l2p(pblk);
-		if (IS_ERR(line)) {
-			pr_err("pblk: could not recover l2p table\n");
-			ret = -EFAULT;
-		}
-	}
-
-#ifdef CONFIG_NVM_DEBUG
-	pr_info("pblk init: L2P CRC: %x\n", pblk_l2p_crc(pblk));
-#endif
-
-	/* Free full lines directly as GC has not been started yet */
-	pblk_gc_free_full_lines(pblk);
-
-	if (!line) {
-		/* Configure next line for user data */
-		line = pblk_line_get_first_data(pblk);
-		if (!line) {
-			pr_err("pblk: line list corrupted\n");
-			ret = -EFAULT;
-		}
-	}
-
-	return ret;
-}
-
 /* See comment over struct line_emeta definition */
 static unsigned int calc_emeta_len(struct pblk *pblk)
 {
@@ -612,81 +632,6 @@ static void pblk_set_provision(struct pblk *pblk, long nr_free_blks)
 	atomic_set(&pblk->rl.free_user_blocks, nr_free_blks);
 }
 
-static int pblk_lines_alloc_metadata(struct pblk *pblk)
-{
-	struct pblk_line_mgmt *l_mg = &pblk->l_mg;
-	struct pblk_line_meta *lm = &pblk->lm;
-	int i;
-
-	/* smeta is always small enough to fit on a kmalloc memory allocation,
-	 * emeta depends on the number of LUNs allocated to the pblk instance
-	 */
-	for (i = 0; i < PBLK_DATA_LINES; i++) {
-		l_mg->sline_meta[i] = kmalloc(lm->smeta_len, GFP_KERNEL);
-		if (!l_mg->sline_meta[i])
-			goto fail_free_smeta;
-	}
-
-	/* emeta allocates three different buffers for managing metadata with
-	 * in-memory and in-media layouts
-	 */
-	for (i = 0; i < PBLK_DATA_LINES; i++) {
-		struct pblk_emeta *emeta;
-
-		emeta = kmalloc(sizeof(struct pblk_emeta), GFP_KERNEL);
-		if (!emeta)
-			goto fail_free_emeta;
-
-		if (lm->emeta_len[0] > KMALLOC_MAX_CACHE_SIZE) {
-			l_mg->emeta_alloc_type = PBLK_VMALLOC_META;
-
-			emeta->buf = vmalloc(lm->emeta_len[0]);
-			if (!emeta->buf) {
-				kfree(emeta);
-				goto fail_free_emeta;
-			}
-
-			emeta->nr_entries = lm->emeta_sec[0];
-			l_mg->eline_meta[i] = emeta;
-		} else {
-			l_mg->emeta_alloc_type = PBLK_KMALLOC_META;
-
-			emeta->buf = kmalloc(lm->emeta_len[0], GFP_KERNEL);
-			if (!emeta->buf) {
-				kfree(emeta);
-				goto fail_free_emeta;
-			}
-
-			emeta->nr_entries = lm->emeta_sec[0];
-			l_mg->eline_meta[i] = emeta;
-		}
-	}
-
-	l_mg->vsc_list = kcalloc(l_mg->nr_lines, sizeof(__le32), GFP_KERNEL);
-	if (!l_mg->vsc_list)
-		goto fail_free_emeta;
-
-	for (i = 0; i < l_mg->nr_lines; i++)
-		l_mg->vsc_list[i] = cpu_to_le32(EMPTY_ENTRY);
-
-	return 0;
-
-fail_free_emeta:
-	while (--i >= 0) {
-		if (l_mg->emeta_alloc_type == PBLK_VMALLOC_META)
-			vfree(l_mg->eline_meta[i]->buf);
-		else
-			kfree(l_mg->eline_meta[i]->buf);
-		kfree(l_mg->eline_meta[i]);
-	}
-
-fail_free_smeta:
-	for (i = 0; i < PBLK_DATA_LINES; i++)
-		kfree(l_mg->sline_meta[i]);
-
-	return -ENOMEM;
-}
-
 static int pblk_setup_line_meta_12(struct pblk *pblk, struct pblk_line *line,
 				   void *chunk_meta)
 {
@@ -830,29 +775,13 @@ static int pblk_alloc_line_meta(struct pblk *pblk, struct pblk_line *line)
 	return 0;
 }
 
-static int pblk_lines_init(struct pblk *pblk)
+static int pblk_line_mg_init(struct pblk *pblk)
 {
 	struct nvm_tgt_dev *dev = pblk->dev;
 	struct nvm_geo *geo = &dev->geo;
 	struct pblk_line_mgmt *l_mg = &pblk->l_mg;
 	struct pblk_line_meta *lm = &pblk->lm;
-	struct pblk_line *line;
-	void *chunk_meta;
-	unsigned int smeta_len, emeta_len;
-	long nr_free_chks = 0;
-	int bb_distance, max_write_ppas;
-	int i, ret;
-
-	pblk->min_write_pgs = geo->c.ws_opt * (geo->c.csecs / PAGE_SIZE);
-	max_write_ppas = pblk->min_write_pgs * geo->all_luns;
-	pblk->max_write_pgs = min_t(int, max_write_ppas, NVM_MAX_VLBA);
-	pblk_set_sec_per_write(pblk, pblk->min_write_pgs);
-
-	if (pblk->max_write_pgs > PBLK_MAX_REQ_ADDRS) {
-		pr_err("pblk: vector list too big(%u > %u)\n",
-				pblk->max_write_pgs, PBLK_MAX_REQ_ADDRS);
-		return -EINVAL;
-	}
+	int i, bb_distance;
 
 	l_mg->nr_lines = geo->c.num_chk;
 	l_mg->log_line = l_mg->data_line = NULL;
@@ -861,6 +790,119 @@ static int pblk_lines_init(struct pblk *pblk)
 	atomic_set(&l_mg->sysfs_line_state, -1);
 	bitmap_zero(&l_mg->meta_bitmap, PBLK_DATA_LINES);
 
+	INIT_LIST_HEAD(&l_mg->free_list);
+	INIT_LIST_HEAD(&l_mg->corrupt_list);
+	INIT_LIST_HEAD(&l_mg->bad_list);
+	INIT_LIST_HEAD(&l_mg->gc_full_list);
+	INIT_LIST_HEAD(&l_mg->gc_high_list);
+	INIT_LIST_HEAD(&l_mg->gc_mid_list);
+	INIT_LIST_HEAD(&l_mg->gc_low_list);
+	INIT_LIST_HEAD(&l_mg->gc_empty_list);
+
+	INIT_LIST_HEAD(&l_mg->emeta_list);
+
+	l_mg->gc_lists[0] = &l_mg->gc_high_list;
+	l_mg->gc_lists[1] = &l_mg->gc_mid_list;
+	l_mg->gc_lists[2] = &l_mg->gc_low_list;
+
+	spin_lock_init(&l_mg->free_lock);
+	spin_lock_init(&l_mg->close_lock);
+	spin_lock_init(&l_mg->gc_lock);
+
+	l_mg->vsc_list = kcalloc(l_mg->nr_lines, sizeof(__le32), GFP_KERNEL);
+	if (!l_mg->vsc_list)
+		goto fail;
+
+	l_mg->bb_template = kzalloc(lm->sec_bitmap_len, GFP_KERNEL);
+	if (!l_mg->bb_template)
+		goto fail_free_vsc_list;
+
+	l_mg->bb_aux = kzalloc(lm->sec_bitmap_len, GFP_KERNEL);
+	if (!l_mg->bb_aux)
+		goto fail_free_bb_template;
+
+	/* smeta is always small enough to fit on a kmalloc memory allocation,
+	 * emeta depends on the number of LUNs allocated to the pblk instance
+	 */
+	for (i = 0; i < PBLK_DATA_LINES; i++) {
+		l_mg->sline_meta[i] = kmalloc(lm->smeta_len, GFP_KERNEL);
+		if (!l_mg->sline_meta[i])
+			goto fail_free_smeta;
+	}
+
+	/* emeta allocates three different buffers for managing metadata with
+	 * in-memory and in-media layouts
+	 */
+	for (i = 0; i < PBLK_DATA_LINES; i++) {
+		struct pblk_emeta *emeta;
+
+		emeta = kmalloc(sizeof(struct pblk_emeta), GFP_KERNEL);
+		if (!emeta)
+			goto fail_free_emeta;
+
+		if (lm->emeta_len[0] > KMALLOC_MAX_CACHE_SIZE) {
+			l_mg->emeta_alloc_type = PBLK_VMALLOC_META;
+
+			emeta->buf = vmalloc(lm->emeta_len[0]);
+			if (!emeta->buf) {
+				kfree(emeta);
+				goto fail_free_emeta;
+			}
+
+			emeta->nr_entries = lm->emeta_sec[0];
+			l_mg->eline_meta[i] = emeta;
+		} else {
+			l_mg->emeta_alloc_type = PBLK_KMALLOC_META;
+
+			emeta->buf = kmalloc(lm->emeta_len[0], GFP_KERNEL);
+			if (!emeta->buf) {
+				kfree(emeta);
+				goto fail_free_emeta;
+			}
+
+			emeta->nr_entries = lm->emeta_sec[0];
+			l_mg->eline_meta[i] = emeta;
+		}
+	}
+
+	for (i = 0; i < l_mg->nr_lines; i++)
+		l_mg->vsc_list[i] = cpu_to_le32(EMPTY_ENTRY);
+
+	bb_distance = (geo->all_luns) * geo->c.ws_opt;
+	for (i = 0; i < lm->sec_per_line; i += bb_distance)
+		bitmap_set(l_mg->bb_template, i, geo->c.ws_opt);
+
+	return 0;
+
+fail_free_emeta:
+	while (--i >= 0) {
+		if (l_mg->emeta_alloc_type == PBLK_VMALLOC_META)
+			vfree(l_mg->eline_meta[i]->buf);
+		else
+			kfree(l_mg->eline_meta[i]->buf);
+		kfree(l_mg->eline_meta[i]);
+	}
+fail_free_smeta:
+	kfree(l_mg->bb_aux);
+
+	for (i = 0; i < PBLK_DATA_LINES; i++)
+		kfree(l_mg->sline_meta[i]);
+fail_free_bb_template:
+	kfree(l_mg->bb_template);
+fail_free_vsc_list:
+	kfree(l_mg->vsc_list);
+fail:
+	return -ENOMEM;
+}
+
+static int pblk_line_meta_init(struct pblk *pblk)
+{
+	struct nvm_tgt_dev *dev = pblk->dev;
+	struct nvm_geo *geo = &dev->geo;
+	struct pblk_line_meta *lm = &pblk->lm;
+	unsigned int smeta_len, emeta_len;
+	int i;
+
 	lm->sec_per_line = geo->c.clba * geo->all_luns;
 	lm->blk_per_line = geo->all_luns;
 	lm->blk_bitmap_len = BITS_TO_LONGS(geo->all_luns) * sizeof(long);
@@ -911,58 +953,49 @@ static int pblk_lines_init(struct pblk *pblk)
 		return -EINVAL;
 	}
 
-	ret = pblk_lines_alloc_metadata(pblk);
+	return 0;
+}
+
+static int pblk_lines_init(struct pblk *pblk)
+{
+	struct nvm_tgt_dev *dev = pblk->dev;
+	struct nvm_geo *geo = &dev->geo;
+	struct pblk_line_mgmt *l_mg = &pblk->l_mg;
+	struct pblk_line *line;
+	void *chunk_meta;
+	long nr_free_chks = 0;
+	int i, ret;
+
+	ret = pblk_line_meta_init(pblk);
 	if (ret)
 		return ret;
 
-	l_mg->bb_template = kzalloc(lm->sec_bitmap_len, GFP_KERNEL);
-	if (!l_mg->bb_template) {
-		ret = -ENOMEM;
-		goto fail_free_meta;
-	}
-
-	l_mg->bb_aux = kzalloc(lm->sec_bitmap_len, GFP_KERNEL);
-	if (!l_mg->bb_aux) {
-		ret = -ENOMEM;
-		goto fail_free_bb_template;
-	}
-
-	bb_distance = (geo->all_luns) * geo->c.ws_opt;
-	for (i = 0; i < lm->sec_per_line; i += bb_distance)
-		bitmap_set(l_mg->bb_template, i, geo->c.ws_opt);
-
-	INIT_LIST_HEAD(&l_mg->free_list);
-	INIT_LIST_HEAD(&l_mg->corrupt_list);
-	INIT_LIST_HEAD(&l_mg->bad_list);
-	INIT_LIST_HEAD(&l_mg->gc_full_list);
-	INIT_LIST_HEAD(&l_mg->gc_high_list);
-	INIT_LIST_HEAD(&l_mg->gc_mid_list);
-	INIT_LIST_HEAD(&l_mg->gc_low_list);
-	INIT_LIST_HEAD(&l_mg->gc_empty_list);
-
-	INIT_LIST_HEAD(&l_mg->emeta_list);
-
-	l_mg->gc_lists[0] = &l_mg->gc_high_list;
-	l_mg->gc_lists[1] = &l_mg->gc_mid_list;
-	l_mg->gc_lists[2] = &l_mg->gc_low_list;
-
-	spin_lock_init(&l_mg->free_lock);
-	spin_lock_init(&l_mg->close_lock);
-	spin_lock_init(&l_mg->gc_lock);
+	ret = pblk_line_mg_init(pblk);
+	if (ret)
+		return ret;
 
-	pblk->lines = kcalloc(l_mg->nr_lines, sizeof(struct pblk_line),
+	pblk->luns = kcalloc(geo->all_luns, sizeof(struct pblk_lun),
 								GFP_KERNEL);
-	if (!pblk->lines) {
-		ret = -ENOMEM;
-		goto fail_free_bb_aux;
-	}
+	if (!pblk->luns)
+		return -ENOMEM;
+
+	ret = pblk_luns_init(pblk);
+	if (ret)
+		goto fail_free_luns;
 
 	chunk_meta = pblk_chunk_get_meta(pblk);
 	if (IS_ERR(chunk_meta)) {
 		pr_err("pblk: could not get chunk log (%lu)\n",
 							PTR_ERR(chunk_meta));
 		ret = PTR_ERR(chunk_meta);
-		goto fail_free_lines;
+		goto fail_free_meta;
+	}
+
+	pblk->lines = kcalloc(l_mg->nr_lines, sizeof(struct pblk_line),
+								GFP_KERNEL);
+	if (!pblk->lines) {
+		ret = -ENOMEM;
+		goto fail_free_chunk_meta;
 	}
 
 	for (i = 0; i < l_mg->nr_lines; i++) {
@@ -970,7 +1003,7 @@ static int pblk_lines_init(struct pblk *pblk)
 
 		ret = pblk_alloc_line_meta(pblk, line);
 		if (ret)
-			goto fail_free_chunk_meta;
+			goto fail_free_lines;
 
 		nr_free_chks += pblk_setup_line_meta(pblk, line, chunk_meta, i);
 	}
@@ -980,18 +1013,16 @@ static int pblk_lines_init(struct pblk *pblk)
 	kfree(chunk_meta);
 	return 0;
 
-fail_free_chunk_meta:
-	kfree(chunk_meta);
+fail_free_lines:
 	while (--i >= 0)
 		pblk_line_meta_free(&pblk->lines[i]);
-fail_free_lines:
 	kfree(pblk->lines);
-fail_free_bb_aux:
-	kfree(l_mg->bb_aux);
-fail_free_bb_template:
-	kfree(l_mg->bb_template);
+fail_free_chunk_meta:
+	kfree(chunk_meta);
 fail_free_meta:
 	pblk_line_mg_free(pblk);
+fail_free_luns:
+	kfree(pblk->luns);
 
 	return ret;
 }
@@ -1032,12 +1063,10 @@ static void pblk_writer_stop(struct pblk *pblk)
 
 static void pblk_free(struct pblk *pblk)
 {
-	pblk_luns_free(pblk);
 	pblk_lines_free(pblk);
-	kfree(pblk->pad_dist);
-	pblk_line_mg_free(pblk);
-	pblk_core_free(pblk);
 	pblk_l2p_free(pblk);
+	pblk_rwb_free(pblk);
+	pblk_core_free(pblk);
 
 	kfree(pblk);
 }
@@ -1108,19 +1137,6 @@ static void *pblk_init(struct nvm_tgt_dev *dev, struct gendisk *tdisk,
 	spin_lock_init(&pblk->trans_lock);
 	spin_lock_init(&pblk->lock);
 
-	if (flags & NVM_TARGET_FACTORY)
-		pblk_setup_uuid(pblk);
-
-	atomic64_set(&pblk->user_wa, 0);
-	atomic64_set(&pblk->pad_wa, 0);
-	atomic64_set(&pblk->gc_wa, 0);
-	pblk->user_rst_wa = 0;
-	pblk->pad_rst_wa = 0;
-	pblk->gc_rst_wa = 0;
-
-	atomic_long_set(&pblk->nr_flush, 0);
-	pblk->nr_flush_rst = 0;
-
 #ifdef CONFIG_NVM_DEBUG
 	atomic_long_set(&pblk->inflight_writes, 0);
 	atomic_long_set(&pblk->padded_writes, 0);
@@ -1144,48 +1160,35 @@ static void *pblk_init(struct nvm_tgt_dev *dev, struct gendisk *tdisk,
 	atomic_long_set(&pblk->write_failed, 0);
 	atomic_long_set(&pblk->erase_failed, 0);
 
-	ret = pblk_luns_init(pblk, dev->luns);
-	if (ret) {
-		pr_err("pblk: could not initialize luns\n");
-		goto fail;
-	}
-
-	ret = pblk_lines_init(pblk);
-	if (ret) {
-		pr_err("pblk: could not initialize lines\n");
-		goto fail_free_luns;
-	}
-
-	pblk->pad_dist = kzalloc((pblk->min_write_pgs - 1) * sizeof(atomic64_t),
-				 GFP_KERNEL);
-	if (!pblk->pad_dist) {
-		ret = -ENOMEM;
-		goto fail_free_line_meta;
-	}
-
 	ret = pblk_core_init(pblk);
 	if (ret) {
 		pr_err("pblk: could not initialize core\n");
-		goto fail_free_pad_dist;
+		goto fail;
 	}
 
-	ret = pblk_l2p_init(pblk);
+	ret = pblk_lines_init(pblk);
 	if (ret) {
-		pr_err("pblk: could not initialize maps\n");
+		pr_err("pblk: could not initialize lines\n");
 		goto fail_free_core;
 	}
 
-	ret = pblk_lines_configure(pblk, flags);
+	ret = pblk_rwb_init(pblk);
 	if (ret) {
-		pr_err("pblk: could not configure lines\n");
-		goto fail_free_l2p;
+		pr_err("pblk: could not initialize write buffer\n");
+		goto fail_free_lines;
+	}
+
+	ret = pblk_l2p_init(pblk, flags & NVM_TARGET_FACTORY);
+	if (ret) {
+		pr_err("pblk: could not initialize maps\n");
+		goto fail_free_rwb;
 	}
 
 	ret = pblk_writer_init(pblk);
 	if (ret) {
 		if (ret != -EINTR)
 			pr_err("pblk: could not initialize write thread\n");
-		goto fail_free_lines;
+		goto fail_free_l2p;
 	}
 
 	ret = pblk_gc_init(pblk);
@@ -1220,18 +1223,14 @@ static void *pblk_init(struct nvm_tgt_dev *dev, struct gendisk *tdisk,
 
 fail_stop_writer:
 	pblk_writer_stop(pblk);
-fail_free_lines:
-	pblk_lines_free(pblk);
 fail_free_l2p:
 	pblk_l2p_free(pblk);
+fail_free_rwb:
+	pblk_rwb_free(pblk);
+fail_free_lines:
+	pblk_lines_free(pblk);
 fail_free_core:
 	pblk_core_free(pblk);
-fail_free_pad_dist:
-	kfree(pblk->pad_dist);
-fail_free_line_meta:
-	pblk_line_mg_free(pblk);
-fail_free_luns:
-	pblk_luns_free(pblk);
 fail:
 	kfree(pblk);
 	return ERR_PTR(ret);
-- 
2.7.4
