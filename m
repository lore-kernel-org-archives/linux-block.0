Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mail-wr0-f195.google.com ([209.85.128.195]:37135 "EHLO
        mail-wr0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932159AbeBUJ1l (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 21 Feb 2018 04:27:41 -0500
Received: by mail-wr0-f195.google.com with SMTP id z12so2450271wrg.4
        for <linux-block@vger.kernel.org>; Wed, 21 Feb 2018 01:27:40 -0800 (PST)
From: "=?UTF-8?q?Javier=20Gonz=C3=A1lez?=" <jg@lightnvm.io>
To: mb@lightnvm.io
Cc: linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-nvme@lists.infradead.org,
        =?UTF-8?q?Javier=20Gonz=C3=A1lez?= <javier@javigon.com>,
        =?UTF-8?q?Javier=20Gonz=C3=A1lez?= <javier@cnexlabs.com>
Subject: [PATCH 18/20] lightnvm: pblk: implement get log report chunk
Date: Wed, 21 Feb 2018 10:26:56 +0100
Message-Id: <1519205218-26994-19-git-send-email-javier@cnexlabs.com>
In-Reply-To: <1519205218-26994-1-git-send-email-javier@cnexlabs.com>
References: <1519205218-26994-1-git-send-email-javier@cnexlabs.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

From: Javier González <javier@javigon.com>

In preparation of pblk supporting 2.0, implement the get log report
chunk in pblk.

This patch only replicates de bad block functionality as the rest of the
metadata requires new pblk functionality (e.g., wear-index to implement
wear-leveling). This functionality will come in future patches.

Signed-off-by: Javier González <javier@cnexlabs.com>
---
 drivers/lightnvm/pblk-core.c  | 121 +++++++++++++++++++++++----
 drivers/lightnvm/pblk-init.c  | 186 +++++++++++++++++++++++++++++++-----------
 drivers/lightnvm/pblk-sysfs.c |  67 +++++++++++++++
 drivers/lightnvm/pblk.h       |  20 +++++
 4 files changed, 330 insertions(+), 64 deletions(-)

diff --git a/drivers/lightnvm/pblk-core.c b/drivers/lightnvm/pblk-core.c
index 7c726003a8d2..90aae45b2842 100644
--- a/drivers/lightnvm/pblk-core.c
+++ b/drivers/lightnvm/pblk-core.c
@@ -44,11 +44,12 @@ static void pblk_line_mark_bb(struct work_struct *work)
 }
 
 static void pblk_mark_bb(struct pblk *pblk, struct pblk_line *line,
-			 struct ppa_addr *ppa)
+			 struct ppa_addr ppa_addr)
 {
 	struct nvm_tgt_dev *dev = pblk->dev;
 	struct nvm_geo *geo = &dev->geo;
-	int pos = pblk_ppa_to_pos(geo, *ppa);
+	struct ppa_addr *ppa;
+	int pos = pblk_ppa_to_pos(geo, ppa_addr);
 
 	pr_debug("pblk: erase failed: line:%d, pos:%d\n", line->id, pos);
 	atomic_long_inc(&pblk->erase_failed);
@@ -58,6 +59,15 @@ static void pblk_mark_bb(struct pblk *pblk, struct pblk_line *line,
 		pr_err("pblk: attempted to erase bb: line:%d, pos:%d\n",
 							line->id, pos);
 
+	/* Not necessary to mark bad blocks on 2.0 spec. */
+	if (geo->c.version == NVM_OCSSD_SPEC_20)
+		return;
+
+	ppa = kmalloc(sizeof(struct ppa_addr), GFP_ATOMIC);
+	if (!ppa)
+		return;
+
+	*ppa = ppa_addr;
 	pblk_gen_run_ws(pblk, NULL, ppa, pblk_line_mark_bb,
 						GFP_ATOMIC, pblk->bb_wq);
 }
@@ -69,16 +79,8 @@ static void __pblk_end_io_erase(struct pblk *pblk, struct nvm_rq *rqd)
 	line = &pblk->lines[pblk_ppa_to_line(rqd->ppa_addr)];
 	atomic_dec(&line->left_seblks);
 
-	if (rqd->error) {
-		struct ppa_addr *ppa;
-
-		ppa = kmalloc(sizeof(struct ppa_addr), GFP_ATOMIC);
-		if (!ppa)
-			return;
-
-		*ppa = rqd->ppa_addr;
-		pblk_mark_bb(pblk, line, ppa);
-	}
+	if (rqd->error)
+		pblk_mark_bb(pblk, line, rqd->ppa_addr);
 
 	atomic_dec(&pblk->inflight_io);
 }
@@ -92,6 +94,50 @@ static void pblk_end_io_erase(struct nvm_rq *rqd)
 	mempool_free(rqd, pblk->e_rq_pool);
 }
 
+/*
+ * Get information for all chunks from the device.
+ *
+ * The caller is responsible for freeing the returned structure
+ */
+struct nvm_chk_meta *pblk_chunk_get_info(struct pblk *pblk)
+{
+	struct nvm_tgt_dev *dev = pblk->dev;
+	struct nvm_geo *geo = &dev->geo;
+	struct nvm_chk_meta *meta;
+	struct ppa_addr ppa;
+	unsigned long len;
+	int ret;
+
+	ppa.ppa = 0;
+
+	len = geo->all_chunks * sizeof(*meta);
+	meta = kzalloc(len, GFP_KERNEL);
+	if (!meta)
+		return ERR_PTR(-ENOMEM);
+
+	ret = nvm_get_chunk_meta(dev, meta, ppa, geo->all_chunks);
+	if (ret) {
+		pr_err("pblk: could not get chunk metadata (%d)\n", ret);
+		kfree(meta);
+		return ERR_PTR(-EIO);
+	}
+
+	return meta;
+}
+
+struct nvm_chk_meta *pblk_chunk_get_off(struct pblk *pblk,
+					      struct nvm_chk_meta *meta,
+					      struct ppa_addr ppa)
+{
+	struct nvm_tgt_dev *dev = pblk->dev;
+	struct nvm_geo *geo = &dev->geo;
+	int ch_off = ppa.m.ch * geo->c.num_chk * geo->num_lun;
+	int lun_off = ppa.m.lun * geo->c.num_chk;
+	int chk_off = ppa.m.chk;
+
+	return meta + ch_off + lun_off + chk_off;
+}
+
 void __pblk_map_invalidate(struct pblk *pblk, struct pblk_line *line,
 			   u64 paddr)
 {
@@ -1094,10 +1140,38 @@ static int pblk_line_init_bb(struct pblk *pblk, struct pblk_line *line,
 	return 1;
 }
 
+static int pblk_prepare_new_line(struct pblk *pblk, struct pblk_line *line)
+{
+	struct pblk_line_meta *lm = &pblk->lm;
+	struct nvm_tgt_dev *dev = pblk->dev;
+	struct nvm_geo *geo = &dev->geo;
+	int blk_to_erase = atomic_read(&line->blk_in_line);
+	int i;
+
+	for (i = 0; i < lm->blk_per_line; i++) {
+		int state = line->chks[i].state;
+		struct pblk_lun *rlun = &pblk->luns[i];
+
+		/* Free chunks should not be erased */
+		if (state & NVM_CHK_ST_FREE) {
+			set_bit(pblk_ppa_to_pos(geo, rlun->chunk_bppa),
+					line->erase_bitmap);
+			blk_to_erase--;
+			line->chks[i].state = NVM_CHK_ST_HOST_USE;
+		}
+
+		WARN_ONCE(state & NVM_CHK_ST_OPEN,
+				"pblk: open chunk in new line: %d\n",
+				line->id);
+	}
+
+	return blk_to_erase;
+}
+
 static int pblk_line_prepare(struct pblk *pblk, struct pblk_line *line)
 {
 	struct pblk_line_meta *lm = &pblk->lm;
-	int blk_in_line = atomic_read(&line->blk_in_line);
+	int blk_to_erase;
 
 	line->map_bitmap = kzalloc(lm->sec_bitmap_len, GFP_ATOMIC);
 	if (!line->map_bitmap)
@@ -1110,7 +1184,21 @@ static int pblk_line_prepare(struct pblk *pblk, struct pblk_line *line)
 		return -ENOMEM;
 	}
 
+	/* Bad blocks do not need to be erased */
+	bitmap_copy(line->erase_bitmap, line->blk_bitmap, lm->blk_per_line);
+
 	spin_lock(&line->lock);
+
+	/* If we have not written to this line, we need to mark up free chunks
+	 * as already erased
+	 */
+	if (line->state == PBLK_LINESTATE_NEW) {
+		blk_to_erase = pblk_prepare_new_line(pblk, line);
+		line->state = PBLK_LINESTATE_FREE;
+	} else {
+		blk_to_erase = atomic_read(&line->blk_in_line);
+	}
+
 	if (line->state != PBLK_LINESTATE_FREE) {
 		kfree(line->map_bitmap);
 		kfree(line->invalid_bitmap);
@@ -1122,15 +1210,12 @@ static int pblk_line_prepare(struct pblk *pblk, struct pblk_line *line)
 
 	line->state = PBLK_LINESTATE_OPEN;
 
-	atomic_set(&line->left_eblks, blk_in_line);
-	atomic_set(&line->left_seblks, blk_in_line);
+	atomic_set(&line->left_eblks, blk_to_erase);
+	atomic_set(&line->left_seblks, blk_to_erase);
 
 	line->meta_distance = lm->meta_distance;
 	spin_unlock(&line->lock);
 
-	/* Bad blocks do not need to be erased */
-	bitmap_copy(line->erase_bitmap, line->blk_bitmap, lm->blk_per_line);
-
 	kref_init(&line->ref);
 
 	return 0;
diff --git a/drivers/lightnvm/pblk-init.c b/drivers/lightnvm/pblk-init.c
index ec39800eea42..1618e923ef5f 100644
--- a/drivers/lightnvm/pblk-init.c
+++ b/drivers/lightnvm/pblk-init.c
@@ -401,6 +401,7 @@ static void pblk_line_meta_free(struct pblk_line *line)
 {
 	kfree(line->blk_bitmap);
 	kfree(line->erase_bitmap);
+	kfree(line->chks);
 }
 
 static void pblk_lines_free(struct pblk *pblk)
@@ -469,25 +470,15 @@ static void *pblk_bb_get_log(struct pblk *pblk)
 	return log;
 }
 
-static int pblk_bb_line(struct pblk *pblk, struct pblk_line *line,
-			u8 *bb_log, int blk_per_line)
+static void *pblk_chunk_get_log(struct pblk *pblk)
 {
 	struct nvm_tgt_dev *dev = pblk->dev;
 	struct nvm_geo *geo = &dev->geo;
-	int i, bb_cnt = 0;
 
-	for (i = 0; i < blk_per_line; i++) {
-		struct pblk_lun *rlun = &pblk->luns[i];
-		u8 *lun_bb_log = bb_log + i * blk_per_line;
-
-		if (lun_bb_log[line->id] == NVM_BLK_T_FREE)
-			continue;
-
-		set_bit(pblk_ppa_to_pos(geo, rlun->bppa), line->blk_bitmap);
-		bb_cnt++;
-	}
-
-	return bb_cnt;
+	if (geo->c.version == NVM_OCSSD_SPEC_12)
+		return pblk_bb_get_log(pblk);
+	else
+		return pblk_chunk_get_info(pblk);
 }
 
 static int pblk_luns_init(struct pblk *pblk, struct ppa_addr *luns)
@@ -516,6 +507,7 @@ static int pblk_luns_init(struct pblk *pblk, struct ppa_addr *luns)
 
 		rlun = &pblk->luns[i];
 		rlun->bppa = luns[lunid];
+		rlun->chunk_bppa = luns[i];
 
 		sema_init(&rlun->wr_sem, 1);
 	}
@@ -695,8 +687,125 @@ static int pblk_lines_alloc_metadata(struct pblk *pblk)
 	return -ENOMEM;
 }
 
-static int pblk_setup_line_meta(struct pblk *pblk, struct pblk_line *line,
-				void *chunk_log, long *nr_bad_blks)
+static int pblk_setup_line_meta_12(struct pblk *pblk, struct pblk_line *line,
+				   void *chunk_log)
+{
+	struct nvm_tgt_dev *dev = pblk->dev;
+	struct nvm_geo *geo = &dev->geo;
+	struct pblk_line_meta *lm = &pblk->lm;
+	int i, chk_per_lun, nr_bad_chks = 0;
+
+	chk_per_lun = geo->c.num_chk * geo->c.pln_mode;
+
+	for (i = 0; i < lm->blk_per_line; i++) {
+		struct pblk_chunk *chunk = &line->chks[i];
+		struct pblk_lun *rlun = &pblk->luns[i];
+		u8 *lun_bb_log = chunk_log + i * chk_per_lun;
+
+		/*
+		 * In 1.2 spec. chunk state is not persisted by the device. Thus
+		 * some of the values are reset each time pblk is instantiated.
+		 */
+		if (lun_bb_log[line->id] == NVM_BLK_T_FREE)
+			chunk->state =  NVM_CHK_ST_HOST_USE;
+		else
+			chunk->state = NVM_CHK_ST_OFFLINE;
+
+		chunk->type = NVM_CHK_TP_W_SEQ;
+		chunk->wi = 0;
+		chunk->slba = -1;
+		chunk->cnlb = geo->c.clba;
+		chunk->wp = 0;
+
+		if (!(chunk->state & NVM_CHK_ST_OFFLINE))
+			continue;
+
+		set_bit(pblk_ppa_to_pos(geo, rlun->bppa), line->blk_bitmap);
+		nr_bad_chks++;
+	}
+
+	return nr_bad_chks;
+}
+
+static int pblk_setup_line_meta_20(struct pblk *pblk, struct pblk_line *line,
+				   struct nvm_chk_meta *meta)
+{
+	struct nvm_tgt_dev *dev = pblk->dev;
+	struct nvm_geo *geo = &dev->geo;
+	struct pblk_line_meta *lm = &pblk->lm;
+	int i, nr_bad_chks = 0;
+
+	for (i = 0; i < lm->blk_per_line; i++) {
+		struct pblk_chunk *chunk = &line->chks[i];
+		struct pblk_lun *rlun = &pblk->luns[i];
+		struct nvm_chk_meta *chunk_meta;
+		struct ppa_addr ppa;
+
+		ppa = rlun->chunk_bppa;
+		ppa.m.chk = line->id;
+		chunk_meta = pblk_chunk_get_off(pblk, meta, ppa);
+
+		chunk->state = chunk_meta->state;
+		chunk->type = chunk_meta->type;
+		chunk->wi = chunk_meta->wi;
+		chunk->slba = chunk_meta->slba;
+		chunk->cnlb = chunk_meta->cnlb;
+		chunk->wp = chunk_meta->wp;
+
+		if (!(chunk->state & NVM_CHK_ST_OFFLINE))
+			continue;
+
+		if (chunk->type & NVM_CHK_TP_SZ_SPEC) {
+			WARN_ONCE(1, "pblk: custom-sized chunks unsupported\n");
+			continue;
+		}
+
+		set_bit(pblk_ppa_to_pos(geo, rlun->chunk_bppa),
+							line->blk_bitmap);
+		nr_bad_chks++;
+	}
+
+	return nr_bad_chks;
+}
+
+static long pblk_setup_line_meta(struct pblk *pblk, struct pblk_line *line,
+				 void *chunk_log, int line_id)
+{
+	struct nvm_tgt_dev *dev = pblk->dev;
+	struct nvm_geo *geo = &dev->geo;
+	struct pblk_line_mgmt *l_mg = &pblk->l_mg;
+	struct pblk_line_meta *lm = &pblk->lm;
+	long nr_bad_chks, chk_in_line;
+
+	line->pblk = pblk;
+	line->id = line_id;
+	line->type = PBLK_LINETYPE_FREE;
+	line->state = PBLK_LINESTATE_NEW;
+	line->gc_group = PBLK_LINEGC_NONE;
+	line->vsc = &l_mg->vsc_list[line_id];
+	spin_lock_init(&line->lock);
+
+	if (geo->c.version == NVM_OCSSD_SPEC_12)
+		nr_bad_chks = pblk_setup_line_meta_12(pblk, line, chunk_log);
+	else
+		nr_bad_chks = pblk_setup_line_meta_20(pblk, line, chunk_log);
+
+	chk_in_line = lm->blk_per_line - nr_bad_chks;
+	if (nr_bad_chks < 0 || nr_bad_chks > lm->blk_per_line ||
+					chk_in_line < lm->min_blk_line) {
+		line->state = PBLK_LINESTATE_BAD;
+		list_add_tail(&line->list, &l_mg->bad_list);
+		return 0;
+	}
+
+	atomic_set(&line->blk_in_line, chk_in_line);
+	list_add_tail(&line->list, &l_mg->free_list);
+	l_mg->nr_free_lines++;
+
+	return chk_in_line;
+}
+
+static int pblk_alloc_line_meta(struct pblk *pblk, struct pblk_line *line)
 {
 	struct pblk_line_meta *lm = &pblk->lm;
 
@@ -710,7 +819,13 @@ static int pblk_setup_line_meta(struct pblk *pblk, struct pblk_line *line,
 		return -ENOMEM;
 	}
 
-	*nr_bad_blks = pblk_bb_line(pblk, line, chunk_log, lm->blk_per_line);
+	line->chks = kmalloc(lm->blk_per_line * sizeof(struct pblk_chunk),
+								GFP_KERNEL);
+	if (!line->chks) {
+		kfree(line->erase_bitmap);
+		kfree(line->blk_bitmap);
+		return -ENOMEM;
+	}
 
 	return 0;
 }
@@ -724,7 +839,7 @@ static int pblk_lines_init(struct pblk *pblk)
 	struct pblk_line *line;
 	void *chunk_log;
 	unsigned int smeta_len, emeta_len;
-	long nr_bad_blks = 0, nr_free_blks = 0;
+	long nr_free_chks = 0;
 	int bb_distance, max_write_ppas;
 	int i, ret;
 
@@ -743,6 +858,7 @@ static int pblk_lines_init(struct pblk *pblk)
 	l_mg->log_line = l_mg->data_line = NULL;
 	l_mg->l_seq_nr = l_mg->d_seq_nr = 0;
 	l_mg->nr_free_lines = 0;
+	atomic_set(&l_mg->sysfs_line_state, -1);
 	bitmap_zero(&l_mg->meta_bitmap, PBLK_DATA_LINES);
 
 	lm->sec_per_line = geo->c.clba * geo->all_luns;
@@ -841,47 +957,25 @@ static int pblk_lines_init(struct pblk *pblk)
 		goto fail_free_bb_aux;
 	}
 
-	chunk_log = pblk_bb_get_log(pblk);
+	chunk_log = pblk_chunk_get_log(pblk);
 	if (IS_ERR(chunk_log)) {
-		pr_err("pblk: could not get bad block log (%lu)\n",
+		pr_err("pblk: could not get chunk log (%lu)\n",
 							PTR_ERR(chunk_log));
 		ret = PTR_ERR(chunk_log);
 		goto fail_free_lines;
 	}
 
 	for (i = 0; i < l_mg->nr_lines; i++) {
-		int chk_in_line;
-
 		line = &pblk->lines[i];
 
-		line->pblk = pblk;
-		line->id = i;
-		line->type = PBLK_LINETYPE_FREE;
-		line->state = PBLK_LINESTATE_FREE;
-		line->gc_group = PBLK_LINEGC_NONE;
-		line->vsc = &l_mg->vsc_list[i];
-		spin_lock_init(&line->lock);
-
-		ret = pblk_setup_line_meta(pblk, line, chunk_log, &nr_bad_blks);
+		ret = pblk_alloc_line_meta(pblk, line);
 		if (ret)
 			goto fail_free_chunk_log;
 
-		chk_in_line = lm->blk_per_line - nr_bad_blks;
-		if (nr_bad_blks < 0 || nr_bad_blks > lm->blk_per_line ||
-					chk_in_line < lm->min_blk_line) {
-			line->state = PBLK_LINESTATE_BAD;
-			list_add_tail(&line->list, &l_mg->bad_list);
-			continue;
-		}
-
-		nr_free_blks += chk_in_line;
-		atomic_set(&line->blk_in_line, chk_in_line);
-
-		l_mg->nr_free_lines++;
-		list_add_tail(&line->list, &l_mg->free_list);
+		nr_free_chks += pblk_setup_line_meta(pblk, line, chunk_log, i);
 	}
 
-	pblk_set_provision(pblk, nr_free_blks);
+	pblk_set_provision(pblk, nr_free_chks);
 
 	kfree(chunk_log);
 	return 0;
diff --git a/drivers/lightnvm/pblk-sysfs.c b/drivers/lightnvm/pblk-sysfs.c
index d3b50741b691..191af0c6591e 100644
--- a/drivers/lightnvm/pblk-sysfs.c
+++ b/drivers/lightnvm/pblk-sysfs.c
@@ -142,6 +142,40 @@ static ssize_t pblk_sysfs_ppaf(struct pblk *pblk, char *page)
 	return sz;
 }
 
+static ssize_t pblk_sysfs_line_state_show(struct pblk *pblk, char *page)
+{
+	struct pblk_line_meta *lm = &pblk->lm;
+	struct pblk_line_mgmt *l_mg = &pblk->l_mg;
+	struct pblk_line *line;
+	int line_id = atomic_read(&l_mg->sysfs_line_state);
+	ssize_t sz = 0;
+	int i;
+
+	if (line_id < 0 || line_id >= l_mg->nr_lines)
+		return 0;
+
+	sz = snprintf(page, PAGE_SIZE,
+		"line\tchunk\tstate\ttype\twear-index\tslba\t\tcnlb\twp\n");
+
+	line = &pblk->lines[line_id];
+
+	for (i = 0; i < lm->blk_per_line; i++) {
+		struct pblk_chunk *chunk = &line->chks[i];
+
+		sz += snprintf(page + sz, PAGE_SIZE - sz,
+				"%d\t%d\t%d\t%d\t%d\t\t%llu\t\t%llu\t%llu\n",
+				line->id, i,
+				chunk->state,
+				chunk->type,
+				chunk->wi,
+				chunk->slba,
+				chunk->cnlb,
+				chunk->wp);
+	}
+
+	return sz;
+}
+
 static ssize_t pblk_sysfs_lines(struct pblk *pblk, char *page)
 {
 	struct nvm_tgt_dev *dev = pblk->dev;
@@ -398,6 +432,29 @@ static ssize_t pblk_sysfs_stats_debug(struct pblk *pblk, char *page)
 }
 #endif
 
+
+static ssize_t pblk_sysfs_line_state_store(struct pblk *pblk, const char *page,
+					   size_t len)
+{
+	struct pblk_line_mgmt *l_mg = &pblk->l_mg;
+	size_t c_len;
+	int line_id;
+
+	c_len = strcspn(page, "\n");
+	if (c_len >= len)
+		return -EINVAL;
+
+	if (kstrtouint(page, 0, &line_id))
+		return -EINVAL;
+
+	if (line_id < 0 || line_id >= l_mg->nr_lines)
+		return -EINVAL;
+
+	atomic_set(&l_mg->sysfs_line_state, line_id);
+
+	return len;
+}
+
 static ssize_t pblk_sysfs_gc_force(struct pblk *pblk, const char *page,
 				   size_t len)
 {
@@ -529,6 +586,11 @@ static struct attribute sys_lines_info_attr = {
 	.mode = 0444,
 };
 
+static struct attribute sys_line_state_attr = {
+	.name = "line_state",
+	.mode = 0644,
+};
+
 static struct attribute sys_gc_force = {
 	.name = "gc_force",
 	.mode = 0200,
@@ -572,6 +634,7 @@ static struct attribute *pblk_attrs[] = {
 	&sys_stats_ppaf_attr,
 	&sys_lines_attr,
 	&sys_lines_info_attr,
+	&sys_line_state_attr,
 	&sys_write_amp_mileage,
 	&sys_write_amp_trip,
 	&sys_padding_dist,
@@ -602,6 +665,8 @@ static ssize_t pblk_sysfs_show(struct kobject *kobj, struct attribute *attr,
 		return pblk_sysfs_lines(pblk, buf);
 	else if (strcmp(attr->name, "lines_info") == 0)
 		return pblk_sysfs_lines_info(pblk, buf);
+	else if (strcmp(attr->name, "line_state") == 0)
+		return pblk_sysfs_line_state_show(pblk, buf);
 	else if (strcmp(attr->name, "max_sec_per_write") == 0)
 		return pblk_sysfs_get_sec_per_write(pblk, buf);
 	else if (strcmp(attr->name, "write_amp_mileage") == 0)
@@ -628,6 +693,8 @@ static ssize_t pblk_sysfs_store(struct kobject *kobj, struct attribute *attr,
 		return pblk_sysfs_set_sec_per_write(pblk, buf, len);
 	else if (strcmp(attr->name, "write_amp_trip") == 0)
 		return pblk_sysfs_set_write_amp_trip(pblk, buf, len);
+	else if (strcmp(attr->name, "line_state") == 0)
+		return pblk_sysfs_line_state_store(pblk, buf, len);
 	else if (strcmp(attr->name, "padding_dist") == 0)
 		return pblk_sysfs_set_padding_dist(pblk, buf, len);
 	return 0;
diff --git a/drivers/lightnvm/pblk.h b/drivers/lightnvm/pblk.h
index 46b29a492f74..c66fa0c28adf 100644
--- a/drivers/lightnvm/pblk.h
+++ b/drivers/lightnvm/pblk.h
@@ -201,6 +201,8 @@ struct pblk_rb {
 
 struct pblk_lun {
 	struct ppa_addr bppa;
+	struct ppa_addr chunk_bppa;
+
 	struct semaphore wr_sem;
 };
 
@@ -297,6 +299,7 @@ enum {
 	PBLK_LINETYPE_DATA = 2,
 
 	/* Line state */
+	PBLK_LINESTATE_NEW = 9,
 	PBLK_LINESTATE_FREE = 10,
 	PBLK_LINESTATE_OPEN = 11,
 	PBLK_LINESTATE_CLOSED = 12,
@@ -412,6 +415,15 @@ struct pblk_smeta {
 	struct line_smeta *buf;		/* smeta buffer in persistent format */
 };
 
+struct pblk_chunk {
+	int state;
+	int type;
+	int wi;
+	u64 slba;
+	u64 cnlb;
+	u64 wp;
+};
+
 struct pblk_line {
 	struct pblk *pblk;
 	unsigned int id;		/* Line number corresponds to the
@@ -426,6 +438,8 @@ struct pblk_line {
 
 	unsigned long *lun_bitmap;	/* Bitmap for LUNs mapped in line */
 
+	struct pblk_chunk *chks;	/* Chunks forming line */
+
 	struct pblk_smeta *smeta;	/* Start metadata */
 	struct pblk_emeta *emeta;	/* End medatada */
 
@@ -513,6 +527,8 @@ struct pblk_line_mgmt {
 	unsigned long d_seq_nr;		/* Data line unique sequence number */
 	unsigned long l_seq_nr;		/* Log line unique sequence number */
 
+	atomic_t sysfs_line_state;	/* Line being monitored in sysfs */
+
 	spinlock_t free_lock;
 	spinlock_t close_lock;
 	spinlock_t gc_lock;
@@ -729,6 +745,10 @@ void pblk_set_sec_per_write(struct pblk *pblk, int sec_per_write);
 int pblk_setup_w_rec_rq(struct pblk *pblk, struct nvm_rq *rqd,
 			struct pblk_c_ctx *c_ctx);
 void pblk_discard(struct pblk *pblk, struct bio *bio);
+struct nvm_chk_meta *pblk_chunk_get_info(struct pblk *pblk);
+struct nvm_chk_meta *pblk_chunk_get_off(struct pblk *pblk,
+					      struct nvm_chk_meta *lp,
+					      struct ppa_addr ppa);
 void pblk_log_write_err(struct pblk *pblk, struct nvm_rq *rqd);
 void pblk_log_read_err(struct pblk *pblk, struct nvm_rq *rqd);
 int pblk_submit_io(struct pblk *pblk, struct nvm_rq *rqd);
-- 
2.7.4
