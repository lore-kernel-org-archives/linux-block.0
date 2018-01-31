Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mail-wm0-f68.google.com ([74.125.82.68]:33244 "EHLO
        mail-wm0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751786AbeAaCHG (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 30 Jan 2018 21:07:06 -0500
Received: by mail-wm0-f68.google.com with SMTP id x4so6194790wmc.0
        for <linux-block@vger.kernel.org>; Tue, 30 Jan 2018 18:07:05 -0800 (PST)
From: "=?UTF-8?q?Javier=20Gonz=C3=A1lez?=" <jg@lightnvm.io>
To: mb@lightnvm.io
Cc: linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        =?UTF-8?q?Javier=20Gonz=C3=A1lez?= <javier@cnexlabs.com>
Subject: [PATCH 5/5] lightnvm: pblk: refactor bad block identification
Date: Wed, 31 Jan 2018 03:06:51 +0100
Message-Id: <1517364411-22386-5-git-send-email-javier@cnexlabs.com>
In-Reply-To: <1517364411-22386-1-git-send-email-javier@cnexlabs.com>
References: <1517364411-22386-1-git-send-email-javier@cnexlabs.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

In preparation for the OCSSD 2.0 spec. bad block identification,
refactor the current code to generalize bad block get/set functions and
structures.

Signed-off-by: Javier González <javier@cnexlabs.com>
---
 drivers/lightnvm/pblk-init.c | 213 +++++++++++++++++++++++--------------------
 drivers/lightnvm/pblk.h      |   6 --
 2 files changed, 112 insertions(+), 107 deletions(-)

diff --git a/drivers/lightnvm/pblk-init.c b/drivers/lightnvm/pblk-init.c
index a5e3510c0f38..86a94a7faa96 100644
--- a/drivers/lightnvm/pblk-init.c
+++ b/drivers/lightnvm/pblk-init.c
@@ -365,7 +365,25 @@ static void pblk_luns_free(struct pblk *pblk)
 	kfree(pblk->luns);
 }
 
-static void pblk_free_line_bitmaps(struct pblk_line *line)
+static void pblk_line_mg_free(struct pblk *pblk)
+{
+	struct pblk_line_mgmt *l_mg = &pblk->l_mg;
+	int i;
+
+	kfree(l_mg->bb_template);
+	kfree(l_mg->bb_aux);
+	kfree(l_mg->vsc_list);
+
+	for (i = 0; i < PBLK_DATA_LINES; i++) {
+		kfree(l_mg->sline_meta[i]);
+		pblk_mfree(l_mg->eline_meta[i]->buf, l_mg->emeta_alloc_type);
+		kfree(l_mg->eline_meta[i]);
+	}
+
+	kfree(pblk->lines);
+}
+
+static void pblk_line_meta_free(struct pblk_line *line)
 {
 	kfree(line->blk_bitmap);
 	kfree(line->erase_bitmap);
@@ -382,40 +400,16 @@ static void pblk_lines_free(struct pblk *pblk)
 		line = &pblk->lines[i];
 
 		pblk_line_free(pblk, line);
-		pblk_free_line_bitmaps(line);
+		pblk_line_meta_free(line);
 	}
 	spin_unlock(&l_mg->free_lock);
 }
 
-static void pblk_line_meta_free(struct pblk *pblk)
+static int pblk_bb_get_tbl(struct nvm_tgt_dev *dev, struct pblk_lun *rlun,
+			   u8 *blks, int nr_blks)
 {
-	struct pblk_line_mgmt *l_mg = &pblk->l_mg;
-	int i;
-
-	kfree(l_mg->bb_template);
-	kfree(l_mg->bb_aux);
-	kfree(l_mg->vsc_list);
-
-	for (i = 0; i < PBLK_DATA_LINES; i++) {
-		kfree(l_mg->sline_meta[i]);
-		pblk_mfree(l_mg->eline_meta[i]->buf, l_mg->emeta_alloc_type);
-		kfree(l_mg->eline_meta[i]);
-	}
-
-	kfree(pblk->lines);
-}
-
-static int pblk_bb_discovery(struct nvm_tgt_dev *dev, struct pblk_lun *rlun)
-{
-	struct nvm_geo *geo = &dev->geo;
 	struct ppa_addr ppa;
-	u8 *blks;
-	int nr_blks, ret;
-
-	nr_blks = geo->nr_chks * geo->plane_mode;
-	blks = kmalloc(nr_blks, GFP_KERNEL);
-	if (!blks)
-		return -ENOMEM;
+	int ret;
 
 	ppa.ppa = 0;
 	ppa.g.ch = rlun->bppa.g.ch;
@@ -423,34 +417,56 @@ static int pblk_bb_discovery(struct nvm_tgt_dev *dev, struct pblk_lun *rlun)
 
 	ret = nvm_get_tgt_bb_tbl(dev, ppa, blks);
 	if (ret)
-		goto out;
+		return ret;
 
 	nr_blks = nvm_bb_tbl_fold(dev->parent, blks, nr_blks);
-	if (nr_blks < 0) {
-		ret = nr_blks;
-		goto out;
-	}
-
-	rlun->bb_list = blks;
+	if (nr_blks < 0)
+		return -EIO;
 
 	return 0;
-out:
-	kfree(blks);
-	return ret;
+}
+
+static void *pblk_bb_get_log(struct pblk *pblk)
+{
+	struct nvm_tgt_dev *dev = pblk->dev;
+	struct nvm_geo *geo = &dev->geo;
+	u8 *log;
+	int i, nr_blks, blk_per_lun;
+	int ret;
+
+	blk_per_lun = geo->nr_chks * geo->plane_mode;
+	nr_blks = blk_per_lun * geo->all_luns;
+
+	log = kmalloc(nr_blks, GFP_KERNEL);
+	if (!log)
+		return ERR_PTR(-ENOMEM);
+
+	for (i = 0; i < geo->all_luns; i++) {
+		struct pblk_lun *rlun = &pblk->luns[i];
+		u8 *log_pos = log + i * blk_per_lun;
+
+		ret = pblk_bb_get_tbl(dev, rlun, log_pos, blk_per_lun);
+		if (ret) {
+			kfree(log);
+			return ERR_PTR(-EIO);
+		}
+	}
+
+	return log;
 }
 
 static int pblk_bb_line(struct pblk *pblk, struct pblk_line *line,
-			int blk_per_line)
+			u8 *bb_log, int blk_per_line)
 {
 	struct nvm_tgt_dev *dev = pblk->dev;
 	struct nvm_geo *geo = &dev->geo;
-	struct pblk_lun *rlun;
-	int bb_cnt = 0;
-	int i;
+	int i, bb_cnt = 0;
 
 	for (i = 0; i < blk_per_line; i++) {
-		rlun = &pblk->luns[i];
-		if (rlun->bb_list[line->id] == NVM_BLK_T_FREE)
+		struct pblk_lun *rlun = &pblk->luns[i];
+		u8 *lun_bb_log = bb_log + i * blk_per_line;
+
+		if (lun_bb_log[line->id] == NVM_BLK_T_FREE)
 			continue;
 
 		set_bit(pblk_ppa_to_pos(geo, rlun->bppa), line->blk_bitmap);
@@ -460,29 +476,12 @@ static int pblk_bb_line(struct pblk *pblk, struct pblk_line *line,
 	return bb_cnt;
 }
 
-static int pblk_alloc_line_bitmaps(struct pblk *pblk, struct pblk_line *line)
-{
-	struct pblk_line_meta *lm = &pblk->lm;
-
-	line->blk_bitmap = kzalloc(lm->blk_bitmap_len, GFP_KERNEL);
-	if (!line->blk_bitmap)
-		return -ENOMEM;
-
-	line->erase_bitmap = kzalloc(lm->blk_bitmap_len, GFP_KERNEL);
-	if (!line->erase_bitmap) {
-		kfree(line->blk_bitmap);
-		return -ENOMEM;
-	}
-
-	return 0;
-}
-
 static int pblk_luns_init(struct pblk *pblk, struct ppa_addr *luns)
 {
 	struct nvm_tgt_dev *dev = pblk->dev;
 	struct nvm_geo *geo = &dev->geo;
 	struct pblk_lun *rlun;
-	int i, ret;
+	int i;
 
 	/* TODO: Implement unbalanced LUN support */
 	if (geo->nr_luns < 0) {
@@ -505,13 +504,6 @@ static int pblk_luns_init(struct pblk *pblk, struct ppa_addr *luns)
 		rlun->bppa = luns[lunid];
 
 		sema_init(&rlun->wr_sem, 1);
-
-		ret = pblk_bb_discovery(dev, rlun);
-		if (ret) {
-			while (--i >= 0)
-				kfree(pblk->luns[i].bb_list);
-			return ret;
-		}
 	}
 
 	return 0;
@@ -689,6 +681,26 @@ static int pblk_lines_alloc_metadata(struct pblk *pblk)
 	return -ENOMEM;
 }
 
+static int pblk_setup_line_meta(struct pblk *pblk, struct pblk_line *line,
+				void *chunk_log, long *nr_bad_blks)
+{
+	struct pblk_line_meta *lm = &pblk->lm;
+
+	line->blk_bitmap = kzalloc(lm->blk_bitmap_len, GFP_KERNEL);
+	if (!line->blk_bitmap)
+		return -ENOMEM;
+
+	line->erase_bitmap = kzalloc(lm->blk_bitmap_len, GFP_KERNEL);
+	if (!line->erase_bitmap) {
+		kfree(line->blk_bitmap);
+		return -ENOMEM;
+	}
+
+	*nr_bad_blks = pblk_bb_line(pblk, line, chunk_log, lm->blk_per_line);
+
+	return 0;
+}
+
 static int pblk_lines_init(struct pblk *pblk)
 {
 	struct nvm_tgt_dev *dev = pblk->dev;
@@ -696,8 +708,9 @@ static int pblk_lines_init(struct pblk *pblk)
 	struct pblk_line_mgmt *l_mg = &pblk->l_mg;
 	struct pblk_line_meta *lm = &pblk->lm;
 	struct pblk_line *line;
+	void *chunk_log;
 	unsigned int smeta_len, emeta_len;
-	long nr_bad_blks, nr_free_blks;
+	long nr_bad_blks = 0, nr_free_blks = 0;
 	int bb_distance, max_write_ppas, mod;
 	int i, ret;
 
@@ -771,13 +784,12 @@ static int pblk_lines_init(struct pblk *pblk)
 	if (lm->min_blk_line > lm->blk_per_line) {
 		pr_err("pblk: config. not supported. Min. LUN in line:%d\n",
 							lm->blk_per_line);
-		ret = -EINVAL;
-		goto fail;
+		return -EINVAL;
 	}
 
 	ret = pblk_lines_alloc_metadata(pblk);
 	if (ret)
-		goto fail;
+		return ret;
 
 	l_mg->bb_template = kzalloc(lm->sec_bitmap_len, GFP_KERNEL);
 	if (!l_mg->bb_template) {
@@ -821,9 +833,16 @@ static int pblk_lines_init(struct pblk *pblk)
 		goto fail_free_bb_aux;
 	}
 
-	nr_free_blks = 0;
+	chunk_log = pblk_bb_get_log(pblk);
+	if (IS_ERR(chunk_log)) {
+		pr_err("pblk: could not get bad block log (%lu)\n",
+							PTR_ERR(chunk_log));
+		ret = PTR_ERR(chunk_log);
+		goto fail_free_lines;
+	}
+
 	for (i = 0; i < l_mg->nr_lines; i++) {
-		int blk_in_line;
+		int chk_in_line;
 
 		line = &pblk->lines[i];
 
@@ -835,26 +854,20 @@ static int pblk_lines_init(struct pblk *pblk)
 		line->vsc = &l_mg->vsc_list[i];
 		spin_lock_init(&line->lock);
 
-		ret = pblk_alloc_line_bitmaps(pblk, line);
+		ret = pblk_setup_line_meta(pblk, line, chunk_log, &nr_bad_blks);
 		if (ret)
-			goto fail_free_lines;
+			goto fail_free_chunk_log;
 
-		nr_bad_blks = pblk_bb_line(pblk, line, lm->blk_per_line);
-		if (nr_bad_blks < 0 || nr_bad_blks > lm->blk_per_line) {
-			pblk_free_line_bitmaps(line);
-			ret = -EINVAL;
-			goto fail_free_lines;
-		}
-
-		blk_in_line = lm->blk_per_line - nr_bad_blks;
-		if (blk_in_line < lm->min_blk_line) {
+		chk_in_line = lm->blk_per_line - nr_bad_blks;
+		if (nr_bad_blks < 0 || nr_bad_blks > lm->blk_per_line ||
+					chk_in_line < lm->min_blk_line) {
 			line->state = PBLK_LINESTATE_BAD;
 			list_add_tail(&line->list, &l_mg->bad_list);
 			continue;
 		}
 
-		nr_free_blks += blk_in_line;
-		atomic_set(&line->blk_in_line, blk_in_line);
+		nr_free_blks += chk_in_line;
+		atomic_set(&line->blk_in_line, chk_in_line);
 
 		l_mg->nr_free_lines++;
 		list_add_tail(&line->list, &l_mg->free_list);
@@ -862,23 +875,21 @@ static int pblk_lines_init(struct pblk *pblk)
 
 	pblk_set_provision(pblk, nr_free_blks);
 
-	/* Cleanup per-LUN bad block lists - managed within lines on run-time */
-	for (i = 0; i < geo->all_luns; i++)
-		kfree(pblk->luns[i].bb_list);
-
+	kfree(chunk_log);
 	return 0;
-fail_free_lines:
+
+fail_free_chunk_log:
+	kfree(chunk_log);
 	while (--i >= 0)
-		pblk_free_line_bitmaps(&pblk->lines[i]);
+		pblk_line_meta_free(&pblk->lines[i]);
+fail_free_lines:
+	kfree(pblk->lines);
 fail_free_bb_aux:
 	kfree(l_mg->bb_aux);
 fail_free_bb_template:
 	kfree(l_mg->bb_template);
 fail_free_meta:
-	pblk_line_meta_free(pblk);
-fail:
-	for (i = 0; i < geo->all_luns; i++)
-		kfree(pblk->luns[i].bb_list);
+	pblk_line_mg_free(pblk);
 
 	return ret;
 }
@@ -922,7 +933,7 @@ static void pblk_free(struct pblk *pblk)
 	pblk_luns_free(pblk);
 	pblk_lines_free(pblk);
 	kfree(pblk->pad_dist);
-	pblk_line_meta_free(pblk);
+	pblk_line_mg_free(pblk);
 	pblk_core_free(pblk);
 	pblk_l2p_free(pblk);
 
@@ -1110,7 +1121,7 @@ static void *pblk_init(struct nvm_tgt_dev *dev, struct gendisk *tdisk,
 fail_free_pad_dist:
 	kfree(pblk->pad_dist);
 fail_free_line_meta:
-	pblk_line_meta_free(pblk);
+	pblk_line_mg_free(pblk);
 fail_free_luns:
 	pblk_luns_free(pblk);
 fail:
diff --git a/drivers/lightnvm/pblk.h b/drivers/lightnvm/pblk.h
index 88720e2441c0..282dfc8780e8 100644
--- a/drivers/lightnvm/pblk.h
+++ b/drivers/lightnvm/pblk.h
@@ -201,12 +201,6 @@ struct pblk_rb {
 
 struct pblk_lun {
 	struct ppa_addr bppa;
-
-	u8 *bb_list;			/* Bad block list for LUN. Only used on
-					 * bring up. Bad blocks are managed
-					 * within lines on run-time.
-					 */
-
 	struct semaphore wr_sem;
 };
 
-- 
2.7.4
