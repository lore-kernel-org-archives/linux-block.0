Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mail-wm0-f54.google.com ([74.125.82.54]:33263 "EHLO
        mail-wm0-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753269AbdIFKwh (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Wed, 6 Sep 2017 06:52:37 -0400
Received: by mail-wm0-f54.google.com with SMTP id f145so15984272wme.0
        for <linux-block@vger.kernel.org>; Wed, 06 Sep 2017 03:52:37 -0700 (PDT)
From: "=?UTF-8?q?Javier=20Gonz=C3=A1lez?=" <jg@lightnvm.io>
To: mb@lightnvm.io, axboe@fb.com
Cc: linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        =?UTF-8?q?Javier=20Gonz=C3=A1lez?= <javier@cnexlabs.com>,
        =?UTF-8?q?Matias=20Bj=C3=B8rling?= <matias@cnexlabs.com>
Subject: [PATCH 01/18] lightnvm: pblk: improve naming for internal req.
Date: Wed,  6 Sep 2017 12:50:54 +0200
Message-Id: <1504695071-25928-2-git-send-email-javier@cnexlabs.com>
In-Reply-To: <1504695071-25928-1-git-send-email-javier@cnexlabs.com>
References: <1504695071-25928-1-git-send-email-javier@cnexlabs.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

Each request type sent to the LightNVM subsystem requires different
metadata. Until now, we have tailored this metadata based on write, read
and erase commands. However, pblk uses different metadata for internal
writes that do not hit the write buffer. Instead of abusing the metadata
for reads, create a new request type - internal write. This improves
code readability.

Signed-off-by: Javier González <javier@cnexlabs.com>
Signed-off-by: Matias Bjørling <matias@cnexlabs.com>
---
 drivers/lightnvm/pblk-recovery.c | 6 +++---
 drivers/lightnvm/pblk-write.c    | 6 +++---
 drivers/lightnvm/pblk.h          | 5 ++++-
 3 files changed, 10 insertions(+), 7 deletions(-)

diff --git a/drivers/lightnvm/pblk-recovery.c b/drivers/lightnvm/pblk-recovery.c
index cb556e06673e..279638309d9a 100644
--- a/drivers/lightnvm/pblk-recovery.c
+++ b/drivers/lightnvm/pblk-recovery.c
@@ -344,7 +344,7 @@ static void pblk_end_io_recov(struct nvm_rq *rqd)
 
 	bio_put(rqd->bio);
 	nvm_dev_dma_free(dev->parent, rqd->meta_list, rqd->dma_meta_list);
-	pblk_free_rqd(pblk, rqd, WRITE);
+	pblk_free_rqd(pblk, rqd, WRITE_INT);
 
 	atomic_dec(&pblk->inflight_io);
 	kref_put(&pad_rq->ref, pblk_recov_complete);
@@ -404,7 +404,7 @@ static int pblk_recov_pad_oob(struct pblk *pblk, struct pblk_line *line,
 	ppa_list = (void *)(meta_list) + pblk_dma_meta_size;
 	dma_ppa_list = dma_meta_list + pblk_dma_meta_size;
 
-	rqd = pblk_alloc_rqd(pblk, WRITE);
+	rqd = pblk_alloc_rqd(pblk, WRITE_INT);
 	if (IS_ERR(rqd)) {
 		ret = PTR_ERR(rqd);
 		goto fail_free_meta;
@@ -491,7 +491,7 @@ static int pblk_recov_pad_oob(struct pblk *pblk, struct pblk_line *line,
 fail_free_bio:
 	bio_put(bio);
 fail_free_rqd:
-	pblk_free_rqd(pblk, rqd, WRITE);
+	pblk_free_rqd(pblk, rqd, WRITE_INT);
 fail_free_meta:
 	nvm_dev_dma_free(dev->parent, meta_list, dma_meta_list);
 fail_free_pad:
diff --git a/drivers/lightnvm/pblk-write.c b/drivers/lightnvm/pblk-write.c
index 3ad9e56d2473..920b93fb15d5 100644
--- a/drivers/lightnvm/pblk-write.c
+++ b/drivers/lightnvm/pblk-write.c
@@ -199,7 +199,7 @@ static void pblk_end_io_write_meta(struct nvm_rq *rqd)
 
 	bio_put(rqd->bio);
 	nvm_dev_dma_free(dev->parent, rqd->meta_list, rqd->dma_meta_list);
-	pblk_free_rqd(pblk, rqd, READ);
+	pblk_free_rqd(pblk, rqd, WRITE_INT);
 
 	atomic_dec(&pblk->inflight_io);
 }
@@ -370,7 +370,7 @@ int pblk_submit_meta_io(struct pblk *pblk, struct pblk_line *meta_line)
 	int i, j;
 	int ret;
 
-	rqd = pblk_alloc_rqd(pblk, READ);
+	rqd = pblk_alloc_rqd(pblk, WRITE_INT);
 	if (IS_ERR(rqd)) {
 		pr_err("pblk: cannot allocate write req.\n");
 		return PTR_ERR(rqd);
@@ -434,7 +434,7 @@ int pblk_submit_meta_io(struct pblk *pblk, struct pblk_line *meta_line)
 	if (likely(l_mg->emeta_alloc_type == PBLK_VMALLOC_META))
 		bio_put(bio);
 fail_free_rqd:
-	pblk_free_rqd(pblk, rqd, READ);
+	pblk_free_rqd(pblk, rqd, WRITE_INT);
 	return ret;
 }
 
diff --git a/drivers/lightnvm/pblk.h b/drivers/lightnvm/pblk.h
index 67e623bd5c2d..08a463fe855f 100644
--- a/drivers/lightnvm/pblk.h
+++ b/drivers/lightnvm/pblk.h
@@ -59,7 +59,10 @@
 		for ((i) = 0, rlun = &(pblk)->luns[0]; \
 			(i) < (pblk)->nr_luns; (i)++, rlun = &(pblk)->luns[(i)])
 
-#define ERASE 2 /* READ = 0, WRITE = 1 */
+/* READ = 0, WRITE (user) = 1 */
+#define ERASE 2
+#define WRITE_INT 3 /* Internal write. Not through write buffer */
+
 
 enum {
 	/* IO Types */
-- 
2.7.4
