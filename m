Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mail-lf0-f68.google.com ([209.85.215.68]:33957 "EHLO
        mail-lf0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753788AbeDSQkO (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 19 Apr 2018 12:40:14 -0400
Received: by mail-lf0-f68.google.com with SMTP id r7-v6so1127209lfr.1
        for <linux-block@vger.kernel.org>; Thu, 19 Apr 2018 09:40:13 -0700 (PDT)
From: Hans Holmberg <hans.ml.holmberg@owltronix.com>
To: Matias Bjorling <mb@lightnvm.io>
Cc: linux-block@vger.kernel.org, Javier Gonzales <javier@cnexlabs.com>,
        linux-kernel@vger.kernel.org,
        Hans Holmberg <hans.holmberg@cnexlabs.com>
Subject: [PATCH 2/3] lightnvm: pblk: garbage collect lines with failed writes
Date: Thu, 19 Apr 2018 18:39:23 +0200
Message-Id: <1524155964-3743-3-git-send-email-hans.ml.holmberg@owltronix.com>
In-Reply-To: <1524155964-3743-1-git-send-email-hans.ml.holmberg@owltronix.com>
References: <1524155964-3743-1-git-send-email-hans.ml.holmberg@owltronix.com>
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

From: Hans Holmberg <hans.holmberg@cnexlabs.com>

Write failures should not happen under normal circumstances,
so in order to bring the chunk back into a known state as soon
as possible, evacuate all the valid data out of the line and let the
fw judge if the block can be written to in the next reset cycle.

Do this by introducing a new gc list for lines with failed writes,
and ensure that the rate limiter allocates a small portion of
the write bandwidth to get the job done.

The lba list is saved in memory for use during gc as we
cannot gurantee that the emeta data is readable if a write
error occurred.

Signed-off-by: Hans Holmberg <hans.holmberg@cnexlabs.com>
---
 drivers/lightnvm/pblk-core.c  | 43 +++++++++++++++++++++--
 drivers/lightnvm/pblk-gc.c    | 79 +++++++++++++++++++++++++++----------------
 drivers/lightnvm/pblk-init.c  | 39 ++++++++++++++-------
 drivers/lightnvm/pblk-rl.c    | 29 +++++++++++++---
 drivers/lightnvm/pblk-sysfs.c | 15 ++++++--
 drivers/lightnvm/pblk-write.c |  2 ++
 drivers/lightnvm/pblk.h       | 25 +++++++++++---
 7 files changed, 178 insertions(+), 54 deletions(-)

diff --git a/drivers/lightnvm/pblk-core.c b/drivers/lightnvm/pblk-core.c
index 7762e89..f6135e4 100644
--- a/drivers/lightnvm/pblk-core.c
+++ b/drivers/lightnvm/pblk-core.c
@@ -373,7 +373,13 @@ struct list_head *pblk_line_gc_list(struct pblk *pblk, struct pblk_line *line)
 
 	lockdep_assert_held(&line->lock);
 
-	if (!vsc) {
+	if (line->w_err_gc->has_write_err) {
+		if (line->gc_group != PBLK_LINEGC_WERR) {
+			line->gc_group = PBLK_LINEGC_WERR;
+			move_list = &l_mg->gc_werr_list;
+			pblk_rl_werr_line_in(&pblk->rl);
+		}
+	} else if (!vsc) {
 		if (line->gc_group != PBLK_LINEGC_FULL) {
 			line->gc_group = PBLK_LINEGC_FULL;
 			move_list = &l_mg->gc_full_list;
@@ -1603,8 +1609,13 @@ static void __pblk_line_put(struct pblk *pblk, struct pblk_line *line)
 	line->state = PBLK_LINESTATE_FREE;
 	line->gc_group = PBLK_LINEGC_NONE;
 	pblk_line_free(line);
-	spin_unlock(&line->lock);
 
+	if (line->w_err_gc->has_write_err) {
+		pblk_rl_werr_line_out(&pblk->rl);
+		line->w_err_gc->has_write_err = 0;
+	}
+
+	spin_unlock(&line->lock);
 	atomic_dec(&gc->pipeline_gc);
 
 	spin_lock(&l_mg->free_lock);
@@ -1767,11 +1778,32 @@ void pblk_line_close_meta(struct pblk *pblk, struct pblk_line *line)
 
 	spin_lock(&l_mg->close_lock);
 	spin_lock(&line->lock);
+
+	/* Update the in-memory start address for emeta, in case it has
+	 * shifted due to write errors
+	 */
+	if (line->emeta_ssec != line->cur_sec)
+		line->emeta_ssec = line->cur_sec;
+
 	list_add_tail(&line->list, &l_mg->emeta_list);
 	spin_unlock(&line->lock);
 	spin_unlock(&l_mg->close_lock);
 
 	pblk_line_should_sync_meta(pblk);
+
+
+}
+
+static void pblk_save_lba_list(struct pblk *pblk, struct pblk_line *line)
+{
+	struct pblk_line_meta *lm = &pblk->lm;
+	unsigned int lba_list_size = lm->emeta_len[2];
+	struct pblk_w_err_gc *w_err_gc = line->w_err_gc;
+	struct pblk_emeta *emeta = line->emeta;
+
+	w_err_gc->lba_list = kmalloc(lba_list_size, GFP_KERNEL);
+	memcpy(w_err_gc->lba_list, emeta_to_lbas(pblk, emeta->buf),
+				lba_list_size);
 }
 
 void pblk_line_close_ws(struct work_struct *work)
@@ -1780,6 +1812,13 @@ void pblk_line_close_ws(struct work_struct *work)
 									ws);
 	struct pblk *pblk = line_ws->pblk;
 	struct pblk_line *line = line_ws->line;
+	struct pblk_w_err_gc *w_err_gc = line->w_err_gc;
+
+	/* Write errors makes the emeta start address stored in smeta invalid,
+	 * so keep a copy of the lba list until we've gc'd the line
+	 */
+	if (w_err_gc->has_write_err)
+		pblk_save_lba_list(pblk, line);
 
 	pblk_line_close(pblk, line);
 	mempool_free(line_ws, pblk->gen_ws_pool);
diff --git a/drivers/lightnvm/pblk-gc.c b/drivers/lightnvm/pblk-gc.c
index b0cc277..62f0548 100644
--- a/drivers/lightnvm/pblk-gc.c
+++ b/drivers/lightnvm/pblk-gc.c
@@ -138,10 +138,10 @@ static void pblk_gc_line_prepare_ws(struct work_struct *work)
 	struct pblk_line_mgmt *l_mg = &pblk->l_mg;
 	struct pblk_line_meta *lm = &pblk->lm;
 	struct pblk_gc *gc = &pblk->gc;
-	struct line_emeta *emeta_buf;
+	struct line_emeta *emeta_buf = NULL;
 	struct pblk_line_ws *gc_rq_ws;
 	struct pblk_gc_rq *gc_rq;
-	__le64 *lba_list;
+	__le64 *lba_list = NULL;
 	unsigned long *invalid_bitmap;
 	int sec_left, nr_secs, bit;
 	int ret;
@@ -150,34 +150,42 @@ static void pblk_gc_line_prepare_ws(struct work_struct *work)
 	if (!invalid_bitmap)
 		goto fail_free_ws;
 
-	emeta_buf = pblk_malloc(lm->emeta_len[0], l_mg->emeta_alloc_type,
-								GFP_KERNEL);
-	if (!emeta_buf) {
-		pr_err("pblk: cannot use GC emeta\n");
-		goto fail_free_bitmap;
-	}
-
-	ret = pblk_line_read_emeta(pblk, line, emeta_buf);
-	if (ret) {
-		pr_err("pblk: line %d read emeta failed (%d)\n", line->id, ret);
-		goto fail_free_emeta;
-	}
+	if (line->w_err_gc->has_write_err) {
+		lba_list = line->w_err_gc->lba_list;
+	} else {
+		emeta_buf = pblk_malloc(lm->emeta_len[0],
+				l_mg->emeta_alloc_type, GFP_KERNEL);
+		if (!emeta_buf) {
+			pr_err("pblk: cannot use GC emeta\n");
+			goto fail_free_bitmap;
+		}
 
-	/* If this read fails, it means that emeta is corrupted. For now, leave
-	 * the line untouched. TODO: Implement a recovery routine that scans and
-	 * moves all sectors on the line.
-	 */
+		ret = pblk_line_read_emeta(pblk, line, emeta_buf);
+		if (ret) {
+			pr_err("pblk: line %d read emeta failed (%d)\n",
+					line->id, ret);
+			goto fail_free_emeta;
+		}
 
-	ret = pblk_recov_check_emeta(pblk, emeta_buf);
-	if (ret) {
-		pr_err("pblk: inconsistent emeta (line %d)\n", line->id);
-		goto fail_free_emeta;
-	}
+		/* If this read fails, it means that emeta is corrupted.
+		 * For now, leave the line untouched.
+		 * TODO: Implement a recovery routine that scans and moves
+		 * all sectors on the line.
+		 */
+
+		ret = pblk_recov_check_emeta(pblk, emeta_buf);
+		if (ret) {
+			pr_err("pblk: inconsistent emeta (line %d)\n",
+					line->id);
+			goto fail_free_emeta;
+		}
 
-	lba_list = emeta_to_lbas(pblk, emeta_buf);
-	if (!lba_list) {
-		pr_err("pblk: could not interpret emeta (line %d)\n", line->id);
-		goto fail_free_emeta;
+		lba_list = emeta_to_lbas(pblk, emeta_buf);
+		if (!lba_list) {
+			pr_err("pblk: could not interpret emeta (line %d)\n",
+					line->id);
+			goto fail_free_emeta;
+		}
 	}
 
 	spin_lock(&line->lock);
@@ -240,7 +248,12 @@ static void pblk_gc_line_prepare_ws(struct work_struct *work)
 		goto next_rq;
 
 out:
-	pblk_mfree(emeta_buf, l_mg->emeta_alloc_type);
+	if (line->w_err_gc->has_write_err) {
+		kfree(lba_list);
+		line->w_err_gc->lba_list = NULL;
+	} else
+		pblk_mfree(emeta_buf, l_mg->emeta_alloc_type);
+
 	kfree(line_ws);
 	kfree(invalid_bitmap);
 
@@ -252,7 +265,11 @@ static void pblk_gc_line_prepare_ws(struct work_struct *work)
 fail_free_gc_rq:
 	kfree(gc_rq);
 fail_free_emeta:
-	pblk_mfree(emeta_buf, l_mg->emeta_alloc_type);
+	if (line->w_err_gc->has_write_err) {
+		kfree(lba_list);
+		line->w_err_gc->lba_list = NULL;
+	} else
+		pblk_mfree(emeta_buf, l_mg->emeta_alloc_type);
 fail_free_bitmap:
 	kfree(invalid_bitmap);
 fail_free_ws:
@@ -349,12 +366,14 @@ static struct pblk_line *pblk_gc_get_victim_line(struct pblk *pblk,
 static bool pblk_gc_should_run(struct pblk_gc *gc, struct pblk_rl *rl)
 {
 	unsigned int nr_blocks_free, nr_blocks_need;
+	unsigned int werr_lines = atomic_read(&rl->werr_lines);
 
 	nr_blocks_need = pblk_rl_high_thrs(rl);
 	nr_blocks_free = pblk_rl_nr_free_blks(rl);
 
 	/* This is not critical, no need to take lock here */
-	return ((gc->gc_active) && (nr_blocks_need > nr_blocks_free));
+	return ((werr_lines > 0) ||
+		((gc->gc_active) && (nr_blocks_need > nr_blocks_free)));
 }
 
 void pblk_gc_free_full_lines(struct pblk *pblk)
diff --git a/drivers/lightnvm/pblk-init.c b/drivers/lightnvm/pblk-init.c
index 6f06727..092e361 100644
--- a/drivers/lightnvm/pblk-init.c
+++ b/drivers/lightnvm/pblk-init.c
@@ -495,9 +495,14 @@ static void pblk_line_mg_free(struct pblk *pblk)
 
 static void pblk_line_meta_free(struct pblk_line *line)
 {
+	struct pblk_w_err_gc *w_err_gc = line->w_err_gc;
+
 	kfree(line->blk_bitmap);
 	kfree(line->erase_bitmap);
 	kfree(line->chks);
+
+	kfree(w_err_gc->lba_list);
+	kfree(w_err_gc);
 }
 
 static void pblk_lines_free(struct pblk *pblk)
@@ -813,20 +818,28 @@ static int pblk_alloc_line_meta(struct pblk *pblk, struct pblk_line *line)
 		return -ENOMEM;
 
 	line->erase_bitmap = kzalloc(lm->blk_bitmap_len, GFP_KERNEL);
-	if (!line->erase_bitmap) {
-		kfree(line->blk_bitmap);
-		return -ENOMEM;
-	}
+	if (!line->erase_bitmap)
+		goto free_blk_bitmap;
+
 
 	line->chks = kmalloc(lm->blk_per_line * sizeof(struct nvm_chk_meta),
 								GFP_KERNEL);
-	if (!line->chks) {
-		kfree(line->erase_bitmap);
-		kfree(line->blk_bitmap);
-		return -ENOMEM;
-	}
+	if (!line->chks)
+		goto free_erase_bitmap;
+
+	line->w_err_gc = kzalloc(sizeof(struct pblk_w_err_gc), GFP_KERNEL);
+	if (!line->w_err_gc)
+		goto free_chks;
 
 	return 0;
+
+free_chks:
+	kfree(line->chks);
+free_erase_bitmap:
+	kfree(line->erase_bitmap);
+free_blk_bitmap:
+	kfree(line->blk_bitmap);
+	return -ENOMEM;
 }
 
 static int pblk_line_mg_init(struct pblk *pblk)
@@ -851,12 +864,14 @@ static int pblk_line_mg_init(struct pblk *pblk)
 	INIT_LIST_HEAD(&l_mg->gc_mid_list);
 	INIT_LIST_HEAD(&l_mg->gc_low_list);
 	INIT_LIST_HEAD(&l_mg->gc_empty_list);
+	INIT_LIST_HEAD(&l_mg->gc_werr_list);
 
 	INIT_LIST_HEAD(&l_mg->emeta_list);
 
-	l_mg->gc_lists[0] = &l_mg->gc_high_list;
-	l_mg->gc_lists[1] = &l_mg->gc_mid_list;
-	l_mg->gc_lists[2] = &l_mg->gc_low_list;
+	l_mg->gc_lists[0] = &l_mg->gc_werr_list;
+	l_mg->gc_lists[1] = &l_mg->gc_high_list;
+	l_mg->gc_lists[2] = &l_mg->gc_mid_list;
+	l_mg->gc_lists[3] = &l_mg->gc_low_list;
 
 	spin_lock_init(&l_mg->free_lock);
 	spin_lock_init(&l_mg->close_lock);
diff --git a/drivers/lightnvm/pblk-rl.c b/drivers/lightnvm/pblk-rl.c
index 883a711..6a0616a 100644
--- a/drivers/lightnvm/pblk-rl.c
+++ b/drivers/lightnvm/pblk-rl.c
@@ -73,6 +73,16 @@ void pblk_rl_user_in(struct pblk_rl *rl, int nr_entries)
 	pblk_rl_kick_u_timer(rl);
 }
 
+void pblk_rl_werr_line_in(struct pblk_rl *rl)
+{
+	atomic_inc(&rl->werr_lines);
+}
+
+void pblk_rl_werr_line_out(struct pblk_rl *rl)
+{
+	atomic_dec(&rl->werr_lines);
+}
+
 void pblk_rl_gc_in(struct pblk_rl *rl, int nr_entries)
 {
 	atomic_add(nr_entries, &rl->rb_gc_cnt);
@@ -99,11 +109,21 @@ static void __pblk_rl_update_rates(struct pblk_rl *rl,
 {
 	struct pblk *pblk = container_of(rl, struct pblk, rl);
 	int max = rl->rb_budget;
+	int werr_gc_needed = atomic_read(&rl->werr_lines);
 
 	if (free_blocks >= rl->high) {
-		rl->rb_user_max = max;
-		rl->rb_gc_max = 0;
-		rl->rb_state = PBLK_RL_HIGH;
+		if (werr_gc_needed) {
+			/* Allocate a small budget for recovering
+			 * lines with write errors
+			 */
+			rl->rb_gc_max = 1 << rl->rb_windows_pw;
+			rl->rb_user_max = max - rl->rb_gc_max;
+			rl->rb_state = PBLK_RL_WERR;
+		} else {
+			rl->rb_user_max = max;
+			rl->rb_gc_max = 0;
+			rl->rb_state = PBLK_RL_OFF;
+		}
 	} else if (free_blocks < rl->high) {
 		int shift = rl->high_pw - rl->rb_windows_pw;
 		int user_windows = free_blocks >> shift;
@@ -124,7 +144,7 @@ static void __pblk_rl_update_rates(struct pblk_rl *rl,
 		rl->rb_state = PBLK_RL_LOW;
 	}
 
-	if (rl->rb_state == (PBLK_RL_MID | PBLK_RL_LOW))
+	if (rl->rb_state != PBLK_RL_OFF)
 		pblk_gc_should_start(pblk);
 	else
 		pblk_gc_should_stop(pblk);
@@ -221,6 +241,7 @@ void pblk_rl_init(struct pblk_rl *rl, int budget)
 	atomic_set(&rl->rb_user_cnt, 0);
 	atomic_set(&rl->rb_gc_cnt, 0);
 	atomic_set(&rl->rb_space, -1);
+	atomic_set(&rl->werr_lines, 0);
 
 	timer_setup(&rl->u_timer, pblk_rl_u_timer, 0);
 
diff --git a/drivers/lightnvm/pblk-sysfs.c b/drivers/lightnvm/pblk-sysfs.c
index e61909a..88a0a7c 100644
--- a/drivers/lightnvm/pblk-sysfs.c
+++ b/drivers/lightnvm/pblk-sysfs.c
@@ -173,6 +173,8 @@ static ssize_t pblk_sysfs_lines(struct pblk *pblk, char *page)
 	int free_line_cnt = 0, closed_line_cnt = 0, emeta_line_cnt = 0;
 	int d_line_cnt = 0, l_line_cnt = 0;
 	int gc_full = 0, gc_high = 0, gc_mid = 0, gc_low = 0, gc_empty = 0;
+	int gc_werr = 0;
+
 	int bad = 0, cor = 0;
 	int msecs = 0, cur_sec = 0, vsc = 0, sec_in_line = 0;
 	int map_weight = 0, meta_weight = 0;
@@ -237,6 +239,15 @@ static ssize_t pblk_sysfs_lines(struct pblk *pblk, char *page)
 		gc_empty++;
 	}
 
+	list_for_each_entry(line, &l_mg->gc_werr_list, list) {
+		if (line->type == PBLK_LINETYPE_DATA)
+			d_line_cnt++;
+		else if (line->type == PBLK_LINETYPE_LOG)
+			l_line_cnt++;
+		closed_line_cnt++;
+		gc_werr++;
+	}
+
 	list_for_each_entry(line, &l_mg->bad_list, list)
 		bad++;
 	list_for_each_entry(line, &l_mg->corrupt_list, list)
@@ -275,8 +286,8 @@ static ssize_t pblk_sysfs_lines(struct pblk *pblk, char *page)
 					l_mg->nr_lines);
 
 	sz += snprintf(page + sz, PAGE_SIZE - sz,
-		"GC: full:%d, high:%d, mid:%d, low:%d, empty:%d, queue:%d\n",
-			gc_full, gc_high, gc_mid, gc_low, gc_empty,
+		"GC: full:%d, high:%d, mid:%d, low:%d, empty:%d, werr: %d, queue:%d\n",
+			gc_full, gc_high, gc_mid, gc_low, gc_empty, gc_werr,
 			atomic_read(&pblk->gc.read_inflight_gc));
 
 	sz += snprintf(page + sz, PAGE_SIZE - sz,
diff --git a/drivers/lightnvm/pblk-write.c b/drivers/lightnvm/pblk-write.c
index ab45157..3b6bead 100644
--- a/drivers/lightnvm/pblk-write.c
+++ b/drivers/lightnvm/pblk-write.c
@@ -136,6 +136,7 @@ static void pblk_map_remaining(struct pblk *pblk, struct ppa_addr *ppa)
 		}
 	}
 
+	line->w_err_gc->has_write_err = 1;
 	spin_unlock(&line->lock);
 }
 
@@ -277,6 +278,7 @@ static void pblk_end_io_write_meta(struct nvm_rq *rqd)
 	if (rqd->error) {
 		pblk_log_write_err(pblk, rqd);
 		pr_err("pblk: metadata I/O failed. Line %d\n", line->id);
+		line->w_err_gc->has_write_err = 1;
 	}
 
 	sync = atomic_add_return(rqd->nr_ppas, &emeta->sync);
diff --git a/drivers/lightnvm/pblk.h b/drivers/lightnvm/pblk.h
index cff6aea..a4e55d8 100644
--- a/drivers/lightnvm/pblk.h
+++ b/drivers/lightnvm/pblk.h
@@ -89,12 +89,14 @@ struct pblk_sec_meta {
 /* The number of GC lists and the rate-limiter states go together. This way the
  * rate-limiter can dictate how much GC is needed based on resource utilization.
  */
-#define PBLK_GC_NR_LISTS 3
+#define PBLK_GC_NR_LISTS 4
 
 enum {
-	PBLK_RL_HIGH = 1,
-	PBLK_RL_MID = 2,
-	PBLK_RL_LOW = 3,
+	PBLK_RL_OFF = 0,
+	PBLK_RL_WERR = 1,
+	PBLK_RL_HIGH = 2,
+	PBLK_RL_MID = 3,
+	PBLK_RL_LOW = 4
 };
 
 #define pblk_dma_meta_size (sizeof(struct pblk_sec_meta) * PBLK_MAX_REQ_ADDRS)
@@ -278,6 +280,8 @@ struct pblk_rl {
 	int rb_user_active;
 	int rb_gc_active;
 
+	atomic_t werr_lines;	/* Number of write error lines that needs gc */
+
 	struct timer_list u_timer;
 
 	unsigned long long nr_secs;
@@ -311,6 +315,7 @@ enum {
 	PBLK_LINEGC_MID = 23,
 	PBLK_LINEGC_HIGH = 24,
 	PBLK_LINEGC_FULL = 25,
+	PBLK_LINEGC_WERR = 26
 };
 
 #define PBLK_MAGIC 0x70626c6b /*pblk*/
@@ -412,6 +417,11 @@ struct pblk_smeta {
 	struct line_smeta *buf;		/* smeta buffer in persistent format */
 };
 
+struct pblk_w_err_gc {
+	int has_write_err;
+	__le64 *lba_list;
+};
+
 struct pblk_line {
 	struct pblk *pblk;
 	unsigned int id;		/* Line number corresponds to the
@@ -457,6 +467,8 @@ struct pblk_line {
 
 	struct kref ref;		/* Write buffer L2P references */
 
+	struct pblk_w_err_gc *w_err_gc;	/* Write error gc recovery metadata */
+
 	spinlock_t lock;		/* Necessary for invalid_bitmap only */
 };
 
@@ -488,6 +500,8 @@ struct pblk_line_mgmt {
 	struct list_head gc_mid_list;	/* Full lines ready to GC, mid isc */
 	struct list_head gc_low_list;	/* Full lines ready to GC, low isc */
 
+	struct list_head gc_werr_list;  /* Write err recovery list */
+
 	struct list_head gc_full_list;	/* Full lines ready to GC, no valid */
 	struct list_head gc_empty_list;	/* Full lines close, all valid */
 
@@ -894,6 +908,9 @@ void pblk_rl_free_lines_dec(struct pblk_rl *rl, struct pblk_line *line,
 			    bool used);
 int pblk_rl_is_limit(struct pblk_rl *rl);
 
+void pblk_rl_werr_line_in(struct pblk_rl *rl);
+void pblk_rl_werr_line_out(struct pblk_rl *rl);
+
 /*
  * pblk sysfs
  */
-- 
2.7.4
