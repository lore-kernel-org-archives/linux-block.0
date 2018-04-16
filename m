Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mail-wr0-f194.google.com ([209.85.128.194]:38553 "EHLO
        mail-wr0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753094AbeDPKZn (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 16 Apr 2018 06:25:43 -0400
Received: by mail-wr0-f194.google.com with SMTP id h3so11815002wrh.5
        for <linux-block@vger.kernel.org>; Mon, 16 Apr 2018 03:25:42 -0700 (PDT)
From: "=?UTF-8?q?Javier=20Gonz=C3=A1lez?=" <javier@javigon.com>
To: mb@lightnvm.io
Cc: linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        =?UTF-8?q?Javier=20Gonz=C3=A1lez?= <javier@cnexlabs.com>
Subject: [PATCH 02/11] lightnvm: pblk: recheck for bad lines at runtime
Date: Mon, 16 Apr 2018 12:25:23 +0200
Message-Id: <1523874332-6272-3-git-send-email-javier@cnexlabs.com>
In-Reply-To: <1523874332-6272-1-git-send-email-javier@cnexlabs.com>
References: <1523874332-6272-1-git-send-email-javier@cnexlabs.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

Bad blocks can grow at runtime. Check that the number of valid blocks in
a line are within the sanity threshold before allocating the line for
new writes.

Signed-off-by: Javier González <javier@cnexlabs.com>
---
 drivers/lightnvm/pblk-core.c | 38 ++++++++++++++++++++++++++++----------
 drivers/lightnvm/pblk-init.c | 11 +++++++----
 2 files changed, 35 insertions(+), 14 deletions(-)

diff --git a/drivers/lightnvm/pblk-core.c b/drivers/lightnvm/pblk-core.c
index ceacd10a043e..128101f9e606 100644
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
2.7.4
