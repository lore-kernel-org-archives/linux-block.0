Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mail-wm0-f48.google.com ([74.125.82.48]:35715 "EHLO
        mail-wm0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751806AbdFZJ6W (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 26 Jun 2017 05:58:22 -0400
Received: by mail-wm0-f48.google.com with SMTP id w126so2846557wme.0
        for <linux-block@vger.kernel.org>; Mon, 26 Jun 2017 02:58:21 -0700 (PDT)
From: "=?UTF-8?q?Javier=20Gonz=C3=A1lez?=" <jg@lightnvm.io>
To: mb@lightnvm.io, axboe@fb.com
Cc: linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        =?UTF-8?q?Javier=20Gonz=C3=A1lez?= <javier@cnexlabs.com>,
        =?UTF-8?q?Matias=20Bj=C3=B8rling?= <matias@cnexlabs.com>
Subject: [PATCH 12/20] lightnvm: pblk: simplify meta. memory allocation
Date: Mon, 26 Jun 2017 11:57:21 +0200
Message-Id: <1498471049-25505-13-git-send-email-javier@cnexlabs.com>
In-Reply-To: <1498471049-25505-1-git-send-email-javier@cnexlabs.com>
References: <1498471049-25505-1-git-send-email-javier@cnexlabs.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

smeta size will always be suitable for a kmalloc allocation. Simplify
the code and leave the vmalloc fallback only for emeta, where the pblk
configuration has an impact.

Signed-off-by: Javier González <javier@cnexlabs.com>
Signed-off-by: Matias Bjørling <matias@cnexlabs.com>
---
 drivers/lightnvm/pblk-core.c  | 3 ++-
 drivers/lightnvm/pblk-init.c  | 9 ++++-----
 drivers/lightnvm/pblk-write.c | 3 ++-
 drivers/lightnvm/pblk.h       | 1 -
 4 files changed, 8 insertions(+), 8 deletions(-)

diff --git a/drivers/lightnvm/pblk-core.c b/drivers/lightnvm/pblk-core.c
index 29565f89a85e..b5f7f3f19105 100644
--- a/drivers/lightnvm/pblk-core.c
+++ b/drivers/lightnvm/pblk-core.c
@@ -665,7 +665,8 @@ static int pblk_line_submit_emeta_io(struct pblk *pblk, struct pblk_line *line,
 	}
 	reinit_completion(&wait);
 
-	bio_put(bio);
+	if (likely(pblk->l_mg.emeta_alloc_type == PBLK_VMALLOC_META))
+		bio_put(bio);
 
 	if (rqd.error) {
 		if (dir == WRITE)
diff --git a/drivers/lightnvm/pblk-init.c b/drivers/lightnvm/pblk-init.c
index 968c2e390cef..c49115d74e85 100644
--- a/drivers/lightnvm/pblk-init.c
+++ b/drivers/lightnvm/pblk-init.c
@@ -354,9 +354,9 @@ static void pblk_line_meta_free(struct pblk *pblk)
 	kfree(l_mg->vsc_list);
 
 	for (i = 0; i < PBLK_DATA_LINES; i++) {
-		pblk_mfree(&l_mg->sline_meta[i], l_mg->smeta_alloc_type);
+		kfree(l_mg->sline_meta[i]);
 		pblk_mfree(l_mg->eline_meta[i]->buf, l_mg->emeta_alloc_type);
-		kfree(&l_mg->eline_meta[i]);
+		kfree(l_mg->eline_meta[i]);
 	}
 
 	kfree(pblk->lines);
@@ -549,7 +549,6 @@ static int pblk_lines_alloc_metadata(struct pblk *pblk)
 	/* smeta is always small enough to fit on a kmalloc memory allocation,
 	 * emeta depends on the number of LUNs allocated to the pblk instance
 	 */
-	l_mg->smeta_alloc_type = PBLK_KMALLOC_META;
 	for (i = 0; i < PBLK_DATA_LINES; i++) {
 		l_mg->sline_meta[i] = kmalloc(lm->smeta_len, GFP_KERNEL);
 		if (!l_mg->sline_meta[i])
@@ -603,12 +602,12 @@ static int pblk_lines_alloc_metadata(struct pblk *pblk)
 fail_free_emeta:
 	while (--i >= 0) {
 		vfree(l_mg->eline_meta[i]->buf);
-		kfree(&l_mg->eline_meta[i]);
+		kfree(l_mg->eline_meta[i]);
 	}
 
 fail_free_smeta:
 	for (i = 0; i < PBLK_DATA_LINES; i++)
-		pblk_mfree(&l_mg->sline_meta[i], l_mg->smeta_alloc_type);
+		kfree(l_mg->sline_meta[i]);
 
 	return -ENOMEM;
 }
diff --git a/drivers/lightnvm/pblk-write.c b/drivers/lightnvm/pblk-write.c
index a29a34786ac5..3db2cbe5b788 100644
--- a/drivers/lightnvm/pblk-write.c
+++ b/drivers/lightnvm/pblk-write.c
@@ -442,7 +442,8 @@ int pblk_submit_meta_io(struct pblk *pblk, struct pblk_line *meta_line)
 	list_add(&meta_line->list, &meta_line->list);
 	spin_unlock(&l_mg->close_lock);
 fail_free_bio:
-	bio_put(bio);
+	if (likely(l_mg->emeta_alloc_type == PBLK_VMALLOC_META))
+		bio_put(bio);
 fail_free_rqd:
 	pblk_free_rqd(pblk, rqd, READ);
 	return ret;
diff --git a/drivers/lightnvm/pblk.h b/drivers/lightnvm/pblk.h
index eb8515fd9044..6c8d01198e8b 100644
--- a/drivers/lightnvm/pblk.h
+++ b/drivers/lightnvm/pblk.h
@@ -446,7 +446,6 @@ struct pblk_line_mgmt {
 	__le32 *vsc_list;		/* Valid sector counts for all lines */
 
 	/* Metadata allocation type: VMALLOC | KMALLOC */
-	int smeta_alloc_type;
 	int emeta_alloc_type;
 
 	/* Pre-allocated metadata for data lines */
-- 
2.7.4
