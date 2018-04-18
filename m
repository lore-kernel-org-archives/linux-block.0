Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mail-wr0-f193.google.com ([209.85.128.193]:32771 "EHLO
        mail-wr0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752116AbeDRMG3 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 18 Apr 2018 08:06:29 -0400
Received: by mail-wr0-f193.google.com with SMTP id z73-v6so4162274wrb.0
        for <linux-block@vger.kernel.org>; Wed, 18 Apr 2018 05:06:29 -0700 (PDT)
From: "=?UTF-8?q?Javier=20Gonz=C3=A1lez?=" <javier@javigon.com>
To: mb@lightnvm.io
Cc: linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        =?UTF-8?q?Javier=20Gonz=C3=A1lez?= <javier@cnexlabs.com>
Subject: [PATCH] lightnvm: pblk: take bitmap alloc. out of critical section
Date: Wed, 18 Apr 2018 14:06:08 +0200
Message-Id: <1524053168-30476-2-git-send-email-javier@cnexlabs.com>
In-Reply-To: <1524053168-30476-1-git-send-email-javier@cnexlabs.com>
References: <1524053168-30476-1-git-send-email-javier@cnexlabs.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

pblk allocates line bitmaps within the line lock unnecessarily. In order
to take pressure out of the fast patch, allocate line bitmaps outside
of this lock and refactor accordingly.

Signed-off-by: Javier González <javier@cnexlabs.com>
---
 drivers/lightnvm/pblk-core.c | 97 +++++++++++++++++++++++++-------------------
 1 file changed, 56 insertions(+), 41 deletions(-)

diff --git a/drivers/lightnvm/pblk-core.c b/drivers/lightnvm/pblk-core.c
index 5f960a6609c8..09d89a568cd5 100644
--- a/drivers/lightnvm/pblk-core.c
+++ b/drivers/lightnvm/pblk-core.c
@@ -1058,6 +1058,25 @@ static int pblk_line_init_metadata(struct pblk *pblk, struct pblk_line *line,
 	return 1;
 }
 
+static int pblk_line_alloc_bitmaps(struct pblk *pblk, struct pblk_line *line)
+{
+	struct pblk_line_meta *lm = &pblk->lm;
+
+	line->map_bitmap = kzalloc(lm->sec_bitmap_len, GFP_KERNEL);
+	if (!line->map_bitmap)
+		return -ENOMEM;
+
+	/* will be initialized using bb info from map_bitmap */
+	line->invalid_bitmap = kmalloc(lm->sec_bitmap_len, GFP_KERNEL);
+	if (!line->invalid_bitmap) {
+		kfree(line->map_bitmap);
+		line->map_bitmap = NULL;
+		return -ENOMEM;
+	}
+
+	return 0;
+}
+
 /* For now lines are always assumed full lines. Thus, smeta former and current
  * lun bitmaps are omitted.
  */
@@ -1162,18 +1181,7 @@ static int pblk_line_prepare(struct pblk *pblk, struct pblk_line *line)
 {
 	struct pblk_line_meta *lm = &pblk->lm;
 	int blk_in_line = atomic_read(&line->blk_in_line);
-	int blk_to_erase, ret;
-
-	line->map_bitmap = kzalloc(lm->sec_bitmap_len, GFP_ATOMIC);
-	if (!line->map_bitmap)
-		return -ENOMEM;
-
-	/* will be initialized using bb info from map_bitmap */
-	line->invalid_bitmap = kmalloc(lm->sec_bitmap_len, GFP_ATOMIC);
-	if (!line->invalid_bitmap) {
-		ret = -ENOMEM;
-		goto fail_free_map_bitmap;
-	}
+	int blk_to_erase;
 
 	/* Bad blocks do not need to be erased */
 	bitmap_copy(line->erase_bitmap, line->blk_bitmap, lm->blk_per_line);
@@ -1191,15 +1199,15 @@ static int pblk_line_prepare(struct pblk *pblk, struct pblk_line *line)
 	}
 
 	if (blk_in_line < lm->min_blk_line) {
-		ret = -EAGAIN;
-		goto fail_free_invalid_bitmap;
+		spin_unlock(&line->lock);
+		return -EAGAIN;
 	}
 
 	if (line->state != PBLK_LINESTATE_FREE) {
 		WARN(1, "pblk: corrupted line %d, state %d\n",
 							line->id, line->state);
-		ret = -EINTR;
-		goto fail_free_invalid_bitmap;
+		spin_unlock(&line->lock);
+		return -EINTR;
 	}
 
 	line->state = PBLK_LINESTATE_OPEN;
@@ -1213,16 +1221,6 @@ static int pblk_line_prepare(struct pblk *pblk, struct pblk_line *line)
 	kref_init(&line->ref);
 
 	return 0;
-
-fail_free_invalid_bitmap:
-	spin_unlock(&line->lock);
-	kfree(line->invalid_bitmap);
-	line->invalid_bitmap = NULL;
-fail_free_map_bitmap:
-	kfree(line->map_bitmap);
-	line->map_bitmap = NULL;
-
-	return ret;
 }
 
 int pblk_line_recov_alloc(struct pblk *pblk, struct pblk_line *line)
@@ -1242,13 +1240,16 @@ int pblk_line_recov_alloc(struct pblk *pblk, struct pblk_line *line)
 	}
 	spin_unlock(&l_mg->free_lock);
 
-	pblk_rl_free_lines_dec(&pblk->rl, line, true);
+	ret = pblk_line_alloc_bitmaps(pblk, line);
+	if (ret)
+		return ret;
 
 	if (!pblk_line_init_bb(pblk, line, 0)) {
 		list_add(&line->list, &l_mg->free_list);
 		return -EINTR;
 	}
 
+	pblk_rl_free_lines_dec(&pblk->rl, line, true);
 	return 0;
 }
 
@@ -1260,6 +1261,24 @@ void pblk_line_recov_close(struct pblk *pblk, struct pblk_line *line)
 	line->emeta = NULL;
 }
 
+static void pblk_line_reinit(struct pblk_line *line)
+{
+	*line->vsc = cpu_to_le32(EMPTY_ENTRY);
+
+	line->map_bitmap = NULL;
+	line->invalid_bitmap = NULL;
+	line->smeta = NULL;
+	line->emeta = NULL;
+}
+
+void pblk_line_free(struct pblk_line *line)
+{
+	kfree(line->map_bitmap);
+	kfree(line->invalid_bitmap);
+
+	pblk_line_reinit(line);
+}
+
 struct pblk_line *pblk_line_get(struct pblk *pblk)
 {
 	struct pblk_line_mgmt *l_mg = &pblk->l_mg;
@@ -1326,11 +1345,14 @@ static struct pblk_line *pblk_line_retry(struct pblk *pblk,
 		return NULL;
 	}
 
+	retry_line->map_bitmap = line->map_bitmap;
+	retry_line->invalid_bitmap = line->invalid_bitmap;
 	retry_line->smeta = line->smeta;
 	retry_line->emeta = line->emeta;
 	retry_line->meta_line = line->meta_line;
 
-	pblk_line_free(line);
+	pblk_line_reinit(line);
+
 	l_mg->data_line = retry_line;
 	spin_unlock(&l_mg->free_lock);
 
@@ -1383,6 +1405,9 @@ struct pblk_line *pblk_line_get_first_data(struct pblk *pblk)
 	}
 	spin_unlock(&l_mg->free_lock);
 
+	if (pblk_line_alloc_bitmaps(pblk, line))
+		return NULL;
+
 	if (pblk_line_erase(pblk, line)) {
 		line = pblk_line_retry(pblk, line);
 		if (!line)
@@ -1527,6 +1552,9 @@ struct pblk_line *pblk_line_replace_data(struct pblk *pblk)
 		goto retry_erase;
 	}
 
+	if (pblk_line_alloc_bitmaps(pblk, new))
+		return NULL;
+
 retry_setup:
 	if (!pblk_line_init_metadata(pblk, new, cur)) {
 		new = pblk_line_retry(pblk, new);
@@ -1566,19 +1594,6 @@ struct pblk_line *pblk_line_replace_data(struct pblk *pblk)
 	return new;
 }
 
-void pblk_line_free(struct pblk_line *line)
-{
-	kfree(line->map_bitmap);
-	kfree(line->invalid_bitmap);
-
-	*line->vsc = cpu_to_le32(EMPTY_ENTRY);
-
-	line->map_bitmap = NULL;
-	line->invalid_bitmap = NULL;
-	line->smeta = NULL;
-	line->emeta = NULL;
-}
-
 static void __pblk_line_put(struct pblk *pblk, struct pblk_line *line)
 {
 	struct pblk_line_mgmt *l_mg = &pblk->l_mg;
-- 
2.7.4
