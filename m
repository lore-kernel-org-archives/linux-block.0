Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mail-lf0-f65.google.com ([209.85.215.65]:43522 "EHLO
        mail-lf0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751837AbeFANEr (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Fri, 1 Jun 2018 09:04:47 -0400
Received: by mail-lf0-f65.google.com with SMTP id n18-v6so14712127lfh.10
        for <linux-block@vger.kernel.org>; Fri, 01 Jun 2018 06:04:46 -0700 (PDT)
From: =?UTF-8?q?Matias=20Bj=C3=B8rling?= <mb@lightnvm.io>
To: axboe@fb.com
Cc: linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        javier@cnexlabs.com, igor.j.konopko@intel.com,
        marcin.dziegielewski@intel.com,
        =?UTF-8?q?Javier=20Gonz=C3=A1lez?= <javier@javigon.com>,
        =?UTF-8?q?Matias=20Bj=C3=B8rling?= <mb@lightnvm.io>
Subject: [GIT PULL 02/18] lightnvm: pblk: recheck for bad lines at runtime
Date: Fri,  1 Jun 2018 15:04:16 +0200
Message-Id: <20180601130432.30866-3-mb@lightnvm.io>
In-Reply-To: <20180601130432.30866-1-mb@lightnvm.io>
References: <20180601130432.30866-1-mb@lightnvm.io>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

From: Javier González <javier@javigon.com>

Bad blocks can grow at runtime. Check that the number of valid blocks in
a line are within the sanity threshold before allocating the line for
new writes.

Signed-off-by: Javier González <javier@cnexlabs.com>
Signed-off-by: Matias Bjørling <mb@lightnvm.io>
---
 drivers/lightnvm/pblk-core.c | 38 ++++++++++++++++++++++++++++----------
 drivers/lightnvm/pblk-init.c | 11 +++++++----
 2 files changed, 35 insertions(+), 14 deletions(-)

diff --git a/drivers/lightnvm/pblk-core.c b/drivers/lightnvm/pblk-core.c
index 94d5d97c9d8a..2cad918434a7 100644
--- a/drivers/lightnvm/pblk-core.c
+++ b/drivers/lightnvm/pblk-core.c
@@ -1174,7 +1174,8 @@ static int pblk_prepare_new_line(struct pblk *pblk, struct pblk_line *line)
 static int pblk_line_prepare(struct pblk *pblk, struct pblk_line *line)
 {
 	struct pblk_line_meta *lm = &pblk->lm;
-	int blk_to_erase;
+	int blk_in_line = atomic_read(&line->blk_in_line);
+	int blk_to_erase, ret;
 
 	line->map_bitmap = kzalloc(lm->sec_bitmap_len, GFP_ATOMIC);
 	if (!line->map_bitmap)
@@ -1183,8 +1184,8 @@ static int pblk_line_prepare(struct pblk *pblk, struct pblk_line *line)
 	/* will be initialized using bb info from map_bitmap */
 	line->invalid_bitmap = kmalloc(lm->sec_bitmap_len, GFP_ATOMIC);
 	if (!line->invalid_bitmap) {
-		kfree(line->map_bitmap);
-		return -ENOMEM;
+		ret = -ENOMEM;
+		goto fail_free_map_bitmap;
 	}
 
 	/* Bad blocks do not need to be erased */
@@ -1199,16 +1200,19 @@ static int pblk_line_prepare(struct pblk *pblk, struct pblk_line *line)
 		blk_to_erase = pblk_prepare_new_line(pblk, line);
 		line->state = PBLK_LINESTATE_FREE;
 	} else {
-		blk_to_erase = atomic_read(&line->blk_in_line);
+		blk_to_erase = blk_in_line;
+	}
+
+	if (blk_in_line < lm->min_blk_line) {
+		ret = -EAGAIN;
+		goto fail_free_invalid_bitmap;
 	}
 
 	if (line->state != PBLK_LINESTATE_FREE) {
-		kfree(line->map_bitmap);
-		kfree(line->invalid_bitmap);
-		spin_unlock(&line->lock);
 		WARN(1, "pblk: corrupted line %d, state %d\n",
 							line->id, line->state);
-		return -EAGAIN;
+		ret = -EINTR;
+		goto fail_free_invalid_bitmap;
 	}
 
 	line->state = PBLK_LINESTATE_OPEN;
@@ -1222,6 +1226,16 @@ static int pblk_line_prepare(struct pblk *pblk, struct pblk_line *line)
 	kref_init(&line->ref);
 
 	return 0;
+
+fail_free_invalid_bitmap:
+	spin_unlock(&line->lock);
+	kfree(line->invalid_bitmap);
+	line->invalid_bitmap = NULL;
+fail_free_map_bitmap:
+	kfree(line->map_bitmap);
+	line->map_bitmap = NULL;
+
+	return ret;
 }
 
 int pblk_line_recov_alloc(struct pblk *pblk, struct pblk_line *line)
@@ -1292,10 +1306,14 @@ struct pblk_line *pblk_line_get(struct pblk *pblk)
 
 	ret = pblk_line_prepare(pblk, line);
 	if (ret) {
-		if (ret == -EAGAIN) {
+		switch (ret) {
+		case -EAGAIN:
+			list_add(&line->list, &l_mg->bad_list);
+			goto retry;
+		case -EINTR:
 			list_add(&line->list, &l_mg->corrupt_list);
 			goto retry;
-		} else {
+		default:
 			pr_err("pblk: failed to prepare line %d\n", line->id);
 			list_add(&line->list, &l_mg->free_list);
 			l_mg->nr_free_lines++;
diff --git a/drivers/lightnvm/pblk-init.c b/drivers/lightnvm/pblk-init.c
index dee64f91227d..8f8c9abd14fc 100644
--- a/drivers/lightnvm/pblk-init.c
+++ b/drivers/lightnvm/pblk-init.c
@@ -127,10 +127,8 @@ static int pblk_l2p_recover(struct pblk *pblk, bool factory_init)
 	if (!line) {
 		/* Configure next line for user data */
 		line = pblk_line_get_first_data(pblk);
-		if (!line) {
-			pr_err("pblk: line list corrupted\n");
+		if (!line)
 			return -EFAULT;
-		}
 	}
 
 	return 0;
@@ -141,6 +139,7 @@ static int pblk_l2p_init(struct pblk *pblk, bool factory_init)
 	sector_t i;
 	struct ppa_addr ppa;
 	size_t map_size;
+	int ret = 0;
 
 	map_size = pblk_trans_map_size(pblk);
 	pblk->trans_map = vmalloc(map_size);
@@ -152,7 +151,11 @@ static int pblk_l2p_init(struct pblk *pblk, bool factory_init)
 	for (i = 0; i < pblk->rl.nr_secs; i++)
 		pblk_trans_map_set(pblk, i, ppa);
 
-	return pblk_l2p_recover(pblk, factory_init);
+	ret = pblk_l2p_recover(pblk, factory_init);
+	if (ret)
+		vfree(pblk->trans_map);
+
+	return ret;
 }
 
 static void pblk_rwb_free(struct pblk *pblk)
-- 
2.11.0
