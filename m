Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mail-ed1-f67.google.com ([209.85.208.67]:33720 "EHLO
        mail-ed1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727877AbeH2QUg (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 29 Aug 2018 12:20:36 -0400
Received: by mail-ed1-f67.google.com with SMTP id h9-v6so3783916edr.0
        for <linux-block@vger.kernel.org>; Wed, 29 Aug 2018 05:23:55 -0700 (PDT)
From: Hans Holmberg <hans.ml.holmberg@owltronix.com>
To: Matias Bjorling <mb@lightnvm.io>
Cc: linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        Javier Gonzales <javier@cnexlabs.com>,
        Hans Holmberg <hans.holmberg@cnexlabs.com>
Subject: [PATCH 3/7] lightnvm: pblk: allocate line map bitmaps using a mempool
Date: Wed, 29 Aug 2018 14:23:30 +0200
Message-Id: <1535545414-550-4-git-send-email-hans.ml.holmberg@owltronix.com>
In-Reply-To: <1535545414-550-1-git-send-email-hans.ml.holmberg@owltronix.com>
References: <1535545414-550-1-git-send-email-hans.ml.holmberg@owltronix.com>
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

From: Hans Holmberg <hans.holmberg@cnexlabs.com>

Line map bitmap allocations are fairly large and can fail. Allocation
failures are fatal to pblk, stoping the write pipeline. To avoid this,
allocate the bitmaps using a mempool instead.

Mempool allocations never fail if called from a process context,
and pblk *should* only allocate map bitmaps in process context,
but keep the failure handling for robustness sake.

Signed-off-by: Hans Holmberg <hans.holmberg@cnexlabs.com>
---
 drivers/lightnvm/pblk-core.c     | 22 +++++++++++++++-------
 drivers/lightnvm/pblk-init.c     | 18 ++++++++++++++++++
 drivers/lightnvm/pblk-recovery.c |  2 +-
 drivers/lightnvm/pblk.h          |  4 ++++
 4 files changed, 38 insertions(+), 8 deletions(-)

diff --git a/drivers/lightnvm/pblk-core.c b/drivers/lightnvm/pblk-core.c
index 36ac9eff8ebd..a1033d82b9cc 100644
--- a/drivers/lightnvm/pblk-core.c
+++ b/drivers/lightnvm/pblk-core.c
@@ -1049,15 +1049,18 @@ static int pblk_line_init_metadata(struct pblk *pblk, struct pblk_line *line,
 static int pblk_line_alloc_bitmaps(struct pblk *pblk, struct pblk_line *line)
 {
 	struct pblk_line_meta *lm = &pblk->lm;
+	struct pblk_line_mgmt *l_mg = &pblk->l_mg;
 
-	line->map_bitmap = kzalloc(lm->sec_bitmap_len, GFP_KERNEL);
+	line->map_bitmap = mempool_alloc(l_mg->bitmap_pool, GFP_KERNEL);
 	if (!line->map_bitmap)
 		return -ENOMEM;
 
+	memset(line->map_bitmap, 0, lm->sec_bitmap_len);
+
 	/* will be initialized using bb info from map_bitmap */
-	line->invalid_bitmap = kmalloc(lm->sec_bitmap_len, GFP_KERNEL);
+	line->invalid_bitmap = mempool_alloc(l_mg->bitmap_pool, GFP_KERNEL);
 	if (!line->invalid_bitmap) {
-		kfree(line->map_bitmap);
+		mempool_free(line->map_bitmap, l_mg->bitmap_pool);
 		line->map_bitmap = NULL;
 		return -ENOMEM;
 	}
@@ -1243,7 +1246,9 @@ int pblk_line_recov_alloc(struct pblk *pblk, struct pblk_line *line)
 
 void pblk_line_recov_close(struct pblk *pblk, struct pblk_line *line)
 {
-	kfree(line->map_bitmap);
+	struct pblk_line_mgmt *l_mg = &pblk->l_mg;
+
+	mempool_free(line->map_bitmap, l_mg->bitmap_pool);
 	line->map_bitmap = NULL;
 	line->smeta = NULL;
 	line->emeta = NULL;
@@ -1261,8 +1266,11 @@ static void pblk_line_reinit(struct pblk_line *line)
 
 void pblk_line_free(struct pblk_line *line)
 {
-	kfree(line->map_bitmap);
-	kfree(line->invalid_bitmap);
+	struct pblk *pblk = line->pblk;
+	struct pblk_line_mgmt *l_mg = &pblk->l_mg;
+
+	mempool_free(line->map_bitmap, l_mg->bitmap_pool);
+	mempool_free(line->invalid_bitmap, l_mg->bitmap_pool);
 
 	pblk_line_reinit(line);
 }
@@ -1741,7 +1749,7 @@ void pblk_line_close(struct pblk *pblk, struct pblk_line *line)
 
 	list_add_tail(&line->list, move_list);
 
-	kfree(line->map_bitmap);
+	mempool_free(line->map_bitmap, l_mg->bitmap_pool);
 	line->map_bitmap = NULL;
 	line->smeta = NULL;
 	line->emeta = NULL;
diff --git a/drivers/lightnvm/pblk-init.c b/drivers/lightnvm/pblk-init.c
index 8adc8ac8b03c..76a4a271b9cf 100644
--- a/drivers/lightnvm/pblk-init.c
+++ b/drivers/lightnvm/pblk-init.c
@@ -498,6 +498,9 @@ static void pblk_line_mg_free(struct pblk *pblk)
 		pblk_mfree(l_mg->eline_meta[i]->buf, l_mg->emeta_alloc_type);
 		kfree(l_mg->eline_meta[i]);
 	}
+
+	mempool_destroy(l_mg->bitmap_pool);
+	kmem_cache_destroy(l_mg->bitmap_cache);
 }
 
 static void pblk_line_meta_free(struct pblk_line_mgmt *l_mg,
@@ -797,6 +800,17 @@ static int pblk_line_mg_init(struct pblk *pblk)
 			goto fail_free_smeta;
 	}
 
+	l_mg->bitmap_cache = kmem_cache_create("pblk_lm_bitmap",
+			lm->sec_bitmap_len, 0, 0, NULL);
+	if (!l_mg->bitmap_cache)
+		goto fail_free_smeta;
+
+	/* the bitmap pool is used for both valid and map bitmaps */
+	l_mg->bitmap_pool = mempool_create_slab_pool(PBLK_DATA_LINES * 2,
+				l_mg->bitmap_cache);
+	if (!l_mg->bitmap_pool)
+		goto fail_destroy_bitmap_cache;
+
 	/* emeta allocates three different buffers for managing metadata with
 	 * in-memory and in-media layouts
 	 */
@@ -849,6 +863,10 @@ static int pblk_line_mg_init(struct pblk *pblk)
 			kfree(l_mg->eline_meta[i]->buf);
 		kfree(l_mg->eline_meta[i]);
 	}
+
+	mempool_destroy(l_mg->bitmap_pool);
+fail_destroy_bitmap_cache:
+	kmem_cache_destroy(l_mg->bitmap_cache);
 fail_free_smeta:
 	for (i = 0; i < PBLK_DATA_LINES; i++)
 		kfree(l_mg->sline_meta[i]);
diff --git a/drivers/lightnvm/pblk-recovery.c b/drivers/lightnvm/pblk-recovery.c
index 3bd2b6b0a359..eea901d7cebc 100644
--- a/drivers/lightnvm/pblk-recovery.c
+++ b/drivers/lightnvm/pblk-recovery.c
@@ -939,7 +939,7 @@ struct pblk_line *pblk_recov_l2p(struct pblk *pblk)
 			list_move_tail(&line->list, move_list);
 			spin_unlock(&l_mg->gc_lock);
 
-			kfree(line->map_bitmap);
+			mempool_free(line->map_bitmap, l_mg->bitmap_pool);
 			line->map_bitmap = NULL;
 			line->smeta = NULL;
 			line->emeta = NULL;
diff --git a/drivers/lightnvm/pblk.h b/drivers/lightnvm/pblk.h
index fd274985aa82..1a31fda3a9f2 100644
--- a/drivers/lightnvm/pblk.h
+++ b/drivers/lightnvm/pblk.h
@@ -530,6 +530,10 @@ struct pblk_line_mgmt {
 	struct pblk_emeta *eline_meta[PBLK_DATA_LINES];
 	unsigned long meta_bitmap;
 
+	/* Cache and mempool for map/invalid bitmaps */
+	struct kmem_cache *bitmap_cache;
+	mempool_t *bitmap_pool;
+
 	/* Helpers for fast bitmap calculations */
 	unsigned long *bb_template;
 	unsigned long *bb_aux;
-- 
2.7.4
