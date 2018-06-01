Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mail-lf0-f65.google.com ([209.85.215.65]:38048 "EHLO
        mail-lf0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752522AbeFAOoI (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Fri, 1 Jun 2018 10:44:08 -0400
Received: by mail-lf0-f65.google.com with SMTP id i83-v6so3035781lfh.5
        for <linux-block@vger.kernel.org>; Fri, 01 Jun 2018 07:44:06 -0700 (PDT)
From: =?UTF-8?q?Matias=20Bj=C3=B8rling?= <mb@lightnvm.io>
To: axboe@fb.com
Cc: linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        javier@cnexlabs.com, igor.j.konopko@intel.com,
        marcin.dziegielewski@intel.com,
        =?UTF-8?q?Javier=20Gonz=C3=A1lez?= <javier@javigon.com>,
        =?UTF-8?q?Matias=20Bj=C3=B8rling?= <mb@lightnvm.io>
Subject: [GIT PULL 10/10] lightnvm: pblk: take bitmap alloc. out of critical section
Date: Fri,  1 Jun 2018 16:41:14 +0200
Message-Id: <20180601144114.17490-11-mb@lightnvm.io>
In-Reply-To: <20180601144114.17490-1-mb@lightnvm.io>
References: <20180601144114.17490-1-mb@lightnvm.io>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

From: Javier González <javier@javigon.com>

pblk allocates line bitmaps within the line lock unnecessarily. In order
to take pressure out of the fast patch, allocate line bitmaps outside
of this lock and refactor accordingly.

Signed-off-by: Javier González <javier@cnexlabs.com>
Signed-off-by: Matias Bjørling <mb@lightnvm.io>
---
 drivers/lightnvm/pblk-core.c | 97 +++++++++++++++++++++++++-------------------
 1 file changed, 56 insertions(+), 41 deletions(-)

diff --git a/drivers/lightnvm/pblk-core.c b/drivers/lightnvm/pblk-core.c
index a5750534efed..ed9cc977c8b3 100644
--- a/drivers/lightnvm/pblk-core.c
+++ b/drivers/lightnvm/pblk-core.c
@@ -1067,6 +1067,25 @@ static int pblk_line_init_metadata(struct pblk *pblk, struct pblk_line *line,
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
@@ -1171,18 +1190,7 @@ static int pblk_line_prepare(struct pblk *pblk, struct pblk_line *line)
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
@@ -1200,15 +1208,15 @@ static int pblk_line_prepare(struct pblk *pblk, struct pblk_line *line)
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
@@ -1222,16 +1230,6 @@ static int pblk_line_prepare(struct pblk *pblk, struct pblk_line *line)
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
@@ -1251,13 +1249,16 @@ int pblk_line_recov_alloc(struct pblk *pblk, struct pblk_line *line)
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
 
@@ -1269,6 +1270,24 @@ void pblk_line_recov_close(struct pblk *pblk, struct pblk_line *line)
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
@@ -1335,11 +1354,14 @@ static struct pblk_line *pblk_line_retry(struct pblk *pblk,
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
 
@@ -1392,6 +1414,9 @@ struct pblk_line *pblk_line_get_first_data(struct pblk *pblk)
 	}
 	spin_unlock(&l_mg->free_lock);
 
+	if (pblk_line_alloc_bitmaps(pblk, line))
+		return NULL;
+
 	if (pblk_line_erase(pblk, line)) {
 		line = pblk_line_retry(pblk, line);
 		if (!line)
@@ -1536,6 +1561,9 @@ struct pblk_line *pblk_line_replace_data(struct pblk *pblk)
 		goto retry_erase;
 	}
 
+	if (pblk_line_alloc_bitmaps(pblk, new))
+		return NULL;
+
 retry_setup:
 	if (!pblk_line_init_metadata(pblk, new, cur)) {
 		new = pblk_line_retry(pblk, new);
@@ -1575,19 +1603,6 @@ struct pblk_line *pblk_line_replace_data(struct pblk *pblk)
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
2.11.0
