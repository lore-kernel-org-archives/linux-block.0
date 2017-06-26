Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mail-wm0-f54.google.com ([74.125.82.54]:37962 "EHLO
        mail-wm0-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751920AbdFZJ62 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 26 Jun 2017 05:58:28 -0400
Received: by mail-wm0-f54.google.com with SMTP id b184so3028568wme.1
        for <linux-block@vger.kernel.org>; Mon, 26 Jun 2017 02:58:27 -0700 (PDT)
From: "=?UTF-8?q?Javier=20Gonz=C3=A1lez?=" <jg@lightnvm.io>
To: mb@lightnvm.io, axboe@fb.com
Cc: linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        =?UTF-8?q?Javier=20Gonz=C3=A1lez?= <javier@cnexlabs.com>,
        =?UTF-8?q?Matias=20Bj=C3=B8rling?= <matias@cnexlabs.com>
Subject: [PATCH 13/20] lightnvm: pblk: decouple bad block from line alloc
Date: Mon, 26 Jun 2017 11:57:22 +0200
Message-Id: <1498471049-25505-14-git-send-email-javier@cnexlabs.com>
In-Reply-To: <1498471049-25505-1-git-send-email-javier@cnexlabs.com>
References: <1498471049-25505-1-git-send-email-javier@cnexlabs.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

Decouple bad block discovery from line allocation logic. This allows to
return meaningful error codes in case of bad block discovery failure.

Signed-off-by: Javier González <javier@cnexlabs.com>
Signed-off-by: Matias Bjørling <matias@cnexlabs.com>
---
 drivers/lightnvm/pblk-init.c | 55 ++++++++++++++++++++++++++++++--------------
 1 file changed, 38 insertions(+), 17 deletions(-)

diff --git a/drivers/lightnvm/pblk-init.c b/drivers/lightnvm/pblk-init.c
index c49115d74e85..41db12deaa49 100644
--- a/drivers/lightnvm/pblk-init.c
+++ b/drivers/lightnvm/pblk-init.c
@@ -327,6 +327,12 @@ static void pblk_luns_free(struct pblk *pblk)
 	kfree(pblk->luns);
 }
 
+static void pblk_free_line_bitmaps(struct pblk_line *line)
+{
+	kfree(line->blk_bitmap);
+	kfree(line->erase_bitmap);
+}
+
 static void pblk_lines_free(struct pblk *pblk)
 {
 	struct pblk_line_mgmt *l_mg = &pblk->l_mg;
@@ -338,8 +344,7 @@ static void pblk_lines_free(struct pblk *pblk)
 		line = &pblk->lines[i];
 
 		pblk_line_free(pblk, line);
-		kfree(line->blk_bitmap);
-		kfree(line->erase_bitmap);
+		pblk_free_line_bitmaps(line);
 	}
 	spin_unlock(&l_mg->free_lock);
 }
@@ -396,25 +401,16 @@ static int pblk_bb_discovery(struct nvm_tgt_dev *dev, struct pblk_lun *rlun)
 	return ret;
 }
 
-static int pblk_bb_line(struct pblk *pblk, struct nvm_geo *geo,
-			struct pblk_line *line)
+static int pblk_bb_line(struct pblk *pblk, struct pblk_line *line,
+			int blk_per_line)
 {
-	struct pblk_line_meta *lm = &pblk->lm;
+	struct nvm_tgt_dev *dev = pblk->dev;
+	struct nvm_geo *geo = &dev->geo;
 	struct pblk_lun *rlun;
 	int bb_cnt = 0;
 	int i;
 
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
-	for (i = 0; i < lm->blk_per_line; i++) {
+	for (i = 0; i < blk_per_line; i++) {
 		rlun = &pblk->luns[i];
 		if (rlun->bb_list[line->id] == NVM_BLK_T_FREE)
 			continue;
@@ -426,6 +422,23 @@ static int pblk_bb_line(struct pblk *pblk, struct nvm_geo *geo,
 	return bb_cnt;
 }
 
+static int pblk_alloc_line_bitmaps(struct pblk *pblk, struct pblk_line *line)
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
+	return 0;
+}
+
 static int pblk_luns_init(struct pblk *pblk, struct ppa_addr *luns)
 {
 	struct nvm_tgt_dev *dev = pblk->dev;
@@ -748,8 +761,13 @@ static int pblk_lines_init(struct pblk *pblk)
 		line->vsc = &l_mg->vsc_list[i];
 		spin_lock_init(&line->lock);
 
-		nr_bad_blks = pblk_bb_line(pblk, geo, line);
+		ret = pblk_alloc_line_bitmaps(pblk, line);
+		if (ret)
+			goto fail_free_lines;
+
+		nr_bad_blks = pblk_bb_line(pblk, line, lm->blk_per_line);
 		if (nr_bad_blks < 0 || nr_bad_blks > lm->blk_per_line) {
+			pblk_free_line_bitmaps(line);
 			ret = -EINVAL;
 			goto fail_free_lines;
 		}
@@ -776,6 +794,9 @@ static int pblk_lines_init(struct pblk *pblk)
 
 	return 0;
 fail_free_lines:
+	while (--i >= 0)
+		pblk_free_line_bitmaps(&pblk->lines[i]);
+
 	kfree(pblk->lines);
 fail_free_bb_aux:
 	kfree(l_mg->bb_aux);
-- 
2.7.4
