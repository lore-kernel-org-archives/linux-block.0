Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mail-it1-f194.google.com ([209.85.166.194]:53991 "EHLO
        mail-it1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729272AbeKEVB2 (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Mon, 5 Nov 2018 16:01:28 -0500
Received: by mail-it1-f194.google.com with SMTP id r12-v6so9396368ita.3
        for <linux-block@vger.kernel.org>; Mon, 05 Nov 2018 03:42:09 -0800 (PST)
From: Hans Holmberg <hans@owltronix.com>
To: Matias Bjorling <mb@lightnvm.io>
Cc: Javier Gonzales <javier@cnexlabs.com>, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Hans Holmberg <hans.ml.holmberg@owltronix.com>,
        Hans Holmberg <hans.holmberg@cnexlabs.com>
Subject: [PATCH 4/7] lightnvm: pblk: set conservative threshold for user writes
Date: Mon,  5 Nov 2018 12:41:10 +0100
Message-Id: <20181105114113.30932-5-hans.ml.holmberg@cnexlabs.com>
In-Reply-To: <20181105114113.30932-1-hans.ml.holmberg@cnexlabs.com>
References: <20181105114113.30932-1-hans.ml.holmberg@cnexlabs.com>
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

From: Hans Holmberg <hans.ml.holmberg@owltronix.com>

From: Hans Holmberg <hans.holmberg@cnexlabs.com>

In a worst-case scenario (random writes), OP% of sectors
in each line will be invalid, and we will then need
to move data out of 100/OP% lines to free a single line.

So, to prevent the possibility of running out of lines,
temporarily block user writes when there is less than
100/OP% free lines.

Also ensure that pblk creation does not produce instances
with insufficient over provisioning.

Insufficient over-provising is not a problem on real hardware,
but often an issue when running QEMU simulations (with few lines).
100 lines is enough to create a sane instance with the standard
(11%) over provisioning.

Signed-off-by: Hans Holmberg <hans.holmberg@cnexlabs.com>
---
 drivers/lightnvm/pblk-init.c | 43 ++++++++++++++++++++++++------------
 drivers/lightnvm/pblk-rl.c   |  5 ++---
 drivers/lightnvm/pblk.h      | 12 +++++++++-
 3 files changed, 42 insertions(+), 18 deletions(-)

diff --git a/drivers/lightnvm/pblk-init.c b/drivers/lightnvm/pblk-init.c
index 13822594647c..8b89bb26b0f1 100644
--- a/drivers/lightnvm/pblk-init.c
+++ b/drivers/lightnvm/pblk-init.c
@@ -635,13 +635,13 @@ static unsigned int calc_emeta_len(struct pblk *pblk)
 	return (lm->emeta_len[1] + lm->emeta_len[2] + lm->emeta_len[3]);
 }
 
-static void pblk_set_provision(struct pblk *pblk, long nr_free_blks)
+static int pblk_set_provision(struct pblk *pblk, long nr_free_chks)
 {
 	struct nvm_tgt_dev *dev = pblk->dev;
 	struct pblk_line_mgmt *l_mg = &pblk->l_mg;
 	struct pblk_line_meta *lm = &pblk->lm;
 	struct nvm_geo *geo = &dev->geo;
-	sector_t provisioned;
+	sector_t provisioned, minimum;
 	int sec_meta, blk_meta;
 
 	if (geo->op == NVM_TARGET_DEFAULT_OP)
@@ -649,17 +649,34 @@ static void pblk_set_provision(struct pblk *pblk, long nr_free_blks)
 	else
 		pblk->op = geo->op;
 
-	provisioned = nr_free_blks;
+	minimum = pblk_get_min_chks(pblk);
+	provisioned = nr_free_chks;
 	provisioned *= (100 - pblk->op);
 	sector_div(provisioned, 100);
 
-	pblk->op_blks = nr_free_blks - provisioned;
+	if ((nr_free_chks - provisioned) < minimum) {
+		if (geo->op != NVM_TARGET_DEFAULT_OP) {
+			pblk_err(pblk, "OP too small to create a sane instance\n");
+			return -EINTR;
+		}
+
+		/* If the user did not specify an OP value, and PBLK_DEFAULT_OP
+		 * is not enough, calculate and set sane value
+		 */
+
+		provisioned = nr_free_chks - minimum;
+		pblk->op =  (100 * minimum) / nr_free_chks;
+		pblk_info(pblk, "Default OP insufficient, adjusting OP to %d\n",
+				pblk->op);
+	}
+
+	pblk->op_blks = nr_free_chks - provisioned;
 
 	/* Internally pblk manages all free blocks, but all calculations based
 	 * on user capacity consider only provisioned blocks
 	 */
-	pblk->rl.total_blocks = nr_free_blks;
-	pblk->rl.nr_secs = nr_free_blks * geo->clba;
+	pblk->rl.total_blocks = nr_free_chks;
+	pblk->rl.nr_secs = nr_free_chks * geo->clba;
 
 	/* Consider sectors used for metadata */
 	sec_meta = (lm->smeta_sec + lm->emeta_sec[0]) * l_mg->nr_free_lines;
@@ -667,8 +684,10 @@ static void pblk_set_provision(struct pblk *pblk, long nr_free_blks)
 
 	pblk->capacity = (provisioned - blk_meta) * geo->clba;
 
-	atomic_set(&pblk->rl.free_blocks, nr_free_blks);
-	atomic_set(&pblk->rl.free_user_blocks, nr_free_blks);
+	atomic_set(&pblk->rl.free_blocks, nr_free_chks);
+	atomic_set(&pblk->rl.free_user_blocks, nr_free_chks);
+
+	return 0;
 }
 
 static int pblk_setup_line_meta_chk(struct pblk *pblk, struct pblk_line *line,
@@ -1025,13 +1044,9 @@ static int pblk_lines_init(struct pblk *pblk)
 								line->state);
 	}
 
-	if (!nr_free_chks) {
-		pblk_err(pblk, "too many bad blocks prevent for sane instance\n");
-		ret = -EINTR;
+	ret = pblk_set_provision(pblk, nr_free_chks);
+	if (ret)
 		goto fail_free_lines;
-	}
-
-	pblk_set_provision(pblk, nr_free_chks);
 
 	vfree(chunk_meta);
 	return 0;
diff --git a/drivers/lightnvm/pblk-rl.c b/drivers/lightnvm/pblk-rl.c
index db55a1c89997..76116d5f78e4 100644
--- a/drivers/lightnvm/pblk-rl.c
+++ b/drivers/lightnvm/pblk-rl.c
@@ -214,11 +214,10 @@ void pblk_rl_init(struct pblk_rl *rl, int budget)
 	struct nvm_geo *geo = &dev->geo;
 	struct pblk_line_mgmt *l_mg = &pblk->l_mg;
 	struct pblk_line_meta *lm = &pblk->lm;
-	int min_blocks = lm->blk_per_line * PBLK_GC_RSV_LINE;
 	int sec_meta, blk_meta;
-
 	unsigned int rb_windows;
 
+
 	/* Consider sectors used for metadata */
 	sec_meta = (lm->smeta_sec + lm->emeta_sec[0]) * l_mg->nr_free_lines;
 	blk_meta = DIV_ROUND_UP(sec_meta, geo->clba);
@@ -226,7 +225,7 @@ void pblk_rl_init(struct pblk_rl *rl, int budget)
 	rl->high = pblk->op_blks - blk_meta - lm->blk_per_line;
 	rl->high_pw = get_count_order(rl->high);
 
-	rl->rsv_blocks = min_blocks;
+	rl->rsv_blocks = pblk_get_min_chks(pblk);
 
 	/* This will always be a power-of-2 */
 	rb_windows = budget / NVM_MAX_VLBA;
diff --git a/drivers/lightnvm/pblk.h b/drivers/lightnvm/pblk.h
index f415aae600c8..e5b88a25d4d6 100644
--- a/drivers/lightnvm/pblk.h
+++ b/drivers/lightnvm/pblk.h
@@ -905,7 +905,6 @@ int pblk_recov_check_emeta(struct pblk *pblk, struct line_emeta *emeta);
 #define PBLK_GC_MAX_READERS 8	/* Max number of outstanding GC reader jobs */
 #define PBLK_GC_RQ_QD 128	/* Queue depth for inflight GC requests */
 #define PBLK_GC_L_QD 4		/* Queue depth for inflight GC lines */
-#define PBLK_GC_RSV_LINE 1	/* Reserved lines for GC */
 
 int pblk_gc_init(struct pblk *pblk);
 void pblk_gc_exit(struct pblk *pblk, bool graceful);
@@ -1370,4 +1369,15 @@ static inline char *pblk_disk_name(struct pblk *pblk)
 
 	return disk->disk_name;
 }
+
+static inline unsigned int pblk_get_min_chks(struct pblk *pblk)
+{
+	struct pblk_line_meta *lm = &pblk->lm;
+	/* In a worst-case scenario every line will have OP invalid sectors.
+	 * We will then need a minimum of 1/OP lines to free up a single line
+	 */
+
+	return DIV_ROUND_UP(100, pblk->op) * lm->blk_per_line;
+
+}
 #endif /* PBLK_H_ */
-- 
2.17.1
