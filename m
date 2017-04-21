Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mail-wm0-f52.google.com ([74.125.82.52]:38747 "EHLO
        mail-wm0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1426675AbdDUXdG (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 21 Apr 2017 19:33:06 -0400
Received: by mail-wm0-f52.google.com with SMTP id r190so27943167wme.1
        for <linux-block@vger.kernel.org>; Fri, 21 Apr 2017 16:33:05 -0700 (PDT)
From: "=?UTF-8?q?Javier=20Gonz=C3=A1lez?=" <jg@lightnvm.io>
To: mb@lightnvm.io
Cc: linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        =?UTF-8?q?Javier=20Gonz=C3=A1lez?= <javier@cnexlabs.com>
Subject: [PATCH 5/5] lightnvm: pblk: fix erase counters on error fail
Date: Sat, 22 Apr 2017 01:32:49 +0200
Message-Id: <1492817569-13532-6-git-send-email-javier@cnexlabs.com>
In-Reply-To: <1492817569-13532-1-git-send-email-javier@cnexlabs.com>
References: <1492817569-13532-1-git-send-email-javier@cnexlabs.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

When block erases fail, these blocks are marked bad. The number of valid
blocks in the line was not updated, which could cause an infinite loop
on the erase path.

Fix this atomic counter and, in order to avoid taking an irq lock on the
interrupt context, make the erase counters atomic too.

Also, in the case that a significant number of blocks become bad in a
line, the result is the double shared metadata buffer (emeta) to stop
the pipeline until all metadata is flushed to the media. Increase the
number of metadata lines from 2 to 4 to avoid this case.

Fixes: a4bd217b4326 "lightnvm: physical block device (pblk) target"

Signed-off-by: Javier González <javier@cnexlabs.com>
---
 drivers/lightnvm/pblk-core.c  | 28 +++++++++++++++++++---------
 drivers/lightnvm/pblk-gc.c    |  2 +-
 drivers/lightnvm/pblk-init.c  |  9 ++++++---
 drivers/lightnvm/pblk-map.c   |  4 ++--
 drivers/lightnvm/pblk-rl.c    |  6 ++++--
 drivers/lightnvm/pblk-write.c |  4 ++--
 drivers/lightnvm/pblk.h       |  6 +++---
 7 files changed, 37 insertions(+), 22 deletions(-)

diff --git a/drivers/lightnvm/pblk-core.c b/drivers/lightnvm/pblk-core.c
index ac3742b..5e44768 100644
--- a/drivers/lightnvm/pblk-core.c
+++ b/drivers/lightnvm/pblk-core.c
@@ -29,6 +29,7 @@ static void pblk_mark_bb(struct pblk *pblk, struct pblk_line *line,
 	pr_debug("pblk: erase failed: line:%d, pos:%d\n", line->id, pos);
 	atomic_long_inc(&pblk->erase_failed);
 
+	atomic_dec(&line->blk_in_line);
 	if (test_and_set_bit(pos, line->blk_bitmap))
 		pr_err("pblk: attempted to erase bb: line:%d, pos:%d\n",
 							line->id, pos);
@@ -832,21 +833,28 @@ int pblk_line_erase(struct pblk *pblk, struct pblk_line *line)
 	struct ppa_addr ppa;
 	int bit = -1;
 
-	/* Erase one block at the time and only erase good blocks */
-	while ((bit = find_next_zero_bit(line->erase_bitmap, lm->blk_per_line,
-						bit + 1)) < lm->blk_per_line) {
+	/* Erase only good blocks, one at a time */
+	do {
+		spin_lock(&line->lock);
+		bit = find_next_zero_bit(line->erase_bitmap, lm->blk_per_line,
+								bit + 1);
+		if (bit >= lm->blk_per_line) {
+			spin_unlock(&line->lock);
+			break;
+		}
+
 		ppa = pblk->luns[bit].bppa; /* set ch and lun */
 		ppa.g.blk = line->id;
 
-		/* If the erase fails, the block is bad and should be marked */
-		line->left_eblks--;
+		atomic_dec(&line->left_eblks);
 		WARN_ON(test_and_set_bit(bit, line->erase_bitmap));
+		spin_unlock(&line->lock);
 
 		if (pblk_blk_erase_sync(pblk, ppa)) {
 			pr_err("pblk: failed to erase line %d\n", line->id);
 			return -ENOMEM;
 		}
-	}
+	} while (1);
 
 	return 0;
 }
@@ -1007,6 +1015,7 @@ static int pblk_line_init_bb(struct pblk *pblk, struct pblk_line *line,
 static int pblk_line_prepare(struct pblk *pblk, struct pblk_line *line)
 {
 	struct pblk_line_meta *lm = &pblk->lm;
+	int blk_in_line = atomic_read(&line->blk_in_line);
 
 	line->map_bitmap = mempool_alloc(pblk->line_meta_pool, GFP_ATOMIC);
 	if (!line->map_bitmap)
@@ -1030,12 +1039,13 @@ static int pblk_line_prepare(struct pblk *pblk, struct pblk_line *line)
 		return -EINTR;
 	}
 	line->state = PBLK_LINESTATE_OPEN;
+
+	atomic_set(&line->left_eblks, blk_in_line);
+	atomic_set(&line->left_seblks, blk_in_line);
 	spin_unlock(&line->lock);
 
 	/* Bad blocks do not need to be erased */
 	bitmap_copy(line->erase_bitmap, line->blk_bitmap, lm->blk_per_line);
-	line->left_eblks = line->blk_in_line;
-	atomic_set(&line->left_seblks, line->left_eblks);
 
 	kref_init(&line->ref);
 
@@ -1231,7 +1241,7 @@ struct pblk_line *pblk_line_replace_data(struct pblk *pblk)
 	left_seblks = atomic_read(&new->left_seblks);
 	if (left_seblks) {
 		/* If line is not fully erased, erase it */
-		if (new->left_eblks) {
+		if (atomic_read(&new->left_eblks)) {
 			if (pblk_line_erase(pblk, new))
 				return NULL;
 		} else {
diff --git a/drivers/lightnvm/pblk-gc.c b/drivers/lightnvm/pblk-gc.c
index f173fd4..eaf479c 100644
--- a/drivers/lightnvm/pblk-gc.c
+++ b/drivers/lightnvm/pblk-gc.c
@@ -332,7 +332,7 @@ static void pblk_gc_run(struct pblk *pblk)
 		}
 
 		line = list_first_entry(group_list, struct pblk_line, list);
-		nr_blocks_free += line->blk_in_line;
+		nr_blocks_free += atomic_read(&line->blk_in_line);
 
 		spin_lock(&line->lock);
 		WARN_ON(line->state != PBLK_LINESTATE_CLOSED);
diff --git a/drivers/lightnvm/pblk-init.c b/drivers/lightnvm/pblk-init.c
index 3996e4b..15b2787 100644
--- a/drivers/lightnvm/pblk-init.c
+++ b/drivers/lightnvm/pblk-init.c
@@ -678,6 +678,8 @@ static int pblk_lines_init(struct pblk *pblk)
 
 	nr_free_blks = 0;
 	for (i = 0; i < l_mg->nr_lines; i++) {
+		int blk_in_line;
+
 		line = &pblk->lines[i];
 
 		line->pblk = pblk;
@@ -693,14 +695,15 @@ static int pblk_lines_init(struct pblk *pblk)
 			goto fail_free_lines;
 		}
 
-		line->blk_in_line = lm->blk_per_line - nr_bad_blks;
-		if (line->blk_in_line < lm->min_blk_line) {
+		blk_in_line = lm->blk_per_line - nr_bad_blks;
+		if (blk_in_line < lm->min_blk_line) {
 			line->state = PBLK_LINESTATE_BAD;
 			list_add_tail(&line->list, &l_mg->bad_list);
 			continue;
 		}
 
-		nr_free_blks += line->blk_in_line;
+		nr_free_blks += blk_in_line;
+		atomic_set(&line->blk_in_line, blk_in_line);
 
 		l_mg->nr_free_lines++;
 		list_add_tail(&line->list, &l_mg->free_list);
diff --git a/drivers/lightnvm/pblk-map.c b/drivers/lightnvm/pblk-map.c
index 3f8bab4..17c1695 100644
--- a/drivers/lightnvm/pblk-map.c
+++ b/drivers/lightnvm/pblk-map.c
@@ -110,7 +110,7 @@ void pblk_map_erase_rq(struct pblk *pblk, struct nvm_rq *rqd,
 				continue;
 
 			set_bit(erase_lun, e_line->erase_bitmap);
-			e_line->left_eblks--;
+			atomic_dec(&e_line->left_eblks);
 			*erase_ppa = rqd->ppa_list[i];
 			erase_ppa->g.blk = e_line->id;
 
@@ -129,7 +129,7 @@ void pblk_map_erase_rq(struct pblk *pblk, struct nvm_rq *rqd,
 			return;
 
 		set_bit(i, e_line->erase_bitmap);
-		e_line->left_eblks--;
+		atomic_dec(&e_line->left_eblks);
 		*erase_ppa = pblk->luns[i].bppa; /* set ch and lun */
 		erase_ppa->g.blk = e_line->id;
 	}
diff --git a/drivers/lightnvm/pblk-rl.c b/drivers/lightnvm/pblk-rl.c
index 4042162..ab7cbb1 100644
--- a/drivers/lightnvm/pblk-rl.c
+++ b/drivers/lightnvm/pblk-rl.c
@@ -107,9 +107,10 @@ void pblk_rl_set_gc_rsc(struct pblk_rl *rl, int rsv)
 void pblk_rl_free_lines_inc(struct pblk_rl *rl, struct pblk_line *line)
 {
 	struct pblk *pblk = container_of(rl, struct pblk, rl);
+	int blk_in_line = atomic_read(&line->blk_in_line);
 	int ret;
 
-	atomic_add(line->blk_in_line, &rl->free_blocks);
+	atomic_add(blk_in_line, &rl->free_blocks);
 	/* Rates will not change that often - no need to lock update */
 	ret = pblk_rl_update_rates(rl, rl->rb_budget);
 
@@ -122,9 +123,10 @@ void pblk_rl_free_lines_inc(struct pblk_rl *rl, struct pblk_line *line)
 void pblk_rl_free_lines_dec(struct pblk_rl *rl, struct pblk_line *line)
 {
 	struct pblk *pblk = container_of(rl, struct pblk, rl);
+	int blk_in_line = atomic_read(&line->blk_in_line);
 	int ret;
 
-	atomic_sub(line->blk_in_line, &rl->free_blocks);
+	atomic_sub(blk_in_line, &rl->free_blocks);
 
 	/* Rates will not change that often - no need to lock update */
 	ret = pblk_rl_update_rates(rl, rl->rb_budget);
diff --git a/drivers/lightnvm/pblk-write.c b/drivers/lightnvm/pblk-write.c
index a896190..aef6fd7 100644
--- a/drivers/lightnvm/pblk-write.c
+++ b/drivers/lightnvm/pblk-write.c
@@ -244,7 +244,7 @@ static int pblk_setup_w_rq(struct pblk *pblk, struct nvm_rq *rqd,
 	}
 
 	ppa_set_empty(&erase_ppa);
-	if (likely(!e_line || !e_line->left_eblks))
+	if (likely(!e_line || !atomic_read(&e_line->left_eblks)))
 		pblk_map_rq(pblk, rqd, c_ctx->sentry, lun_bitmap, valid, 0);
 	else
 		pblk_map_erase_rq(pblk, rqd, c_ctx->sentry, lun_bitmap,
@@ -257,7 +257,7 @@ static int pblk_setup_w_rq(struct pblk *pblk, struct nvm_rq *rqd,
 			struct nvm_geo *geo = &dev->geo;
 			int bit;
 
-			e_line->left_eblks++;
+			atomic_inc(&e_line->left_eblks);
 			bit = erase_ppa.g.lun * geo->nr_chnls + erase_ppa.g.ch;
 			WARN_ON(!test_and_clear_bit(bit, e_line->erase_bitmap));
 			up(&pblk->erase_sem);
diff --git a/drivers/lightnvm/pblk.h b/drivers/lightnvm/pblk.h
index c82120c..02dd18f 100644
--- a/drivers/lightnvm/pblk.h
+++ b/drivers/lightnvm/pblk.h
@@ -363,14 +363,14 @@ struct pblk_line {
 
 	unsigned int sec_in_line;	/* Number of usable secs in line */
 
-	unsigned int blk_in_line;	/* Number of good blocks in line */
+	atomic_t blk_in_line;		/* Number of good blocks in line */
 	unsigned long *blk_bitmap;	/* Bitmap for valid/invalid blocks */
 	unsigned long *erase_bitmap;	/* Bitmap for erased blocks */
 
 	unsigned long *map_bitmap;	/* Bitmap for mapped sectors in line */
 	unsigned long *invalid_bitmap;	/* Bitmap for invalid sectors in line */
 
-	int left_eblks;			/* Blocks left for erasing */
+	atomic_t left_eblks;		/* Blocks left for erasing */
 	atomic_t left_seblks;		/* Blocks left for sync erasing */
 
 	int left_msecs;			/* Sectors left for mapping */
@@ -383,7 +383,7 @@ struct pblk_line {
 	spinlock_t lock;		/* Necessary for invalid_bitmap only */
 };
 
-#define PBLK_DATA_LINES 2
+#define PBLK_DATA_LINES 4
 
 enum{
 	PBLK_KMALLOC_META = 1,
-- 
2.7.4
