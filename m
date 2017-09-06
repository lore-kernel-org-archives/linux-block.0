Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mail-wm0-f49.google.com ([74.125.82.49]:37032 "EHLO
        mail-wm0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753328AbdIFKwr (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Wed, 6 Sep 2017 06:52:47 -0400
Received: by mail-wm0-f49.google.com with SMTP id u26so29536229wma.0
        for <linux-block@vger.kernel.org>; Wed, 06 Sep 2017 03:52:46 -0700 (PDT)
From: "=?UTF-8?q?Javier=20Gonz=C3=A1lez?=" <jg@lightnvm.io>
To: mb@lightnvm.io, axboe@fb.com
Cc: linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        =?UTF-8?q?Javier=20Gonz=C3=A1lez?= <javier@cnexlabs.com>,
        =?UTF-8?q?Matias=20Bj=C3=B8rling?= <matias@cnexlabs.com>
Subject: [PATCH 10/18] lightnvm: pblk: use bio_copy_kern when possible
Date: Wed,  6 Sep 2017 12:51:03 +0200
Message-Id: <1504695071-25928-11-git-send-email-javier@cnexlabs.com>
In-Reply-To: <1504695071-25928-1-git-send-email-javier@cnexlabs.com>
References: <1504695071-25928-1-git-send-email-javier@cnexlabs.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

In pblk, buffers forming bios can be allocated on physically contiguous
or virtually contiguous memory. For physically contiguous memory, we
already use the bio_map_kern helper funciton, however, for virtually
contiguous memory, we from the bio manually. This makes the code more
complex, specially on the completion path, where mapped pages need to be
freed.

Instead, use bio_copy_kern, which does the same and at the same time
simplifies the completion path.

Signed-off-by: Javier González <javier@cnexlabs.com>
Signed-off-by: Matias Bjørling <matias@cnexlabs.com>
---
 drivers/lightnvm/pblk-core.c     | 39 ++++-----------------------------------
 drivers/lightnvm/pblk-read.c     |  3 +--
 drivers/lightnvm/pblk-recovery.c |  3 +--
 drivers/lightnvm/pblk-write.c    |  7 +------
 drivers/lightnvm/pblk.h          |  2 +-
 5 files changed, 8 insertions(+), 46 deletions(-)

diff --git a/drivers/lightnvm/pblk-core.c b/drivers/lightnvm/pblk-core.c
index f6b9afbe8589..e69e8829b093 100644
--- a/drivers/lightnvm/pblk-core.c
+++ b/drivers/lightnvm/pblk-core.c
@@ -423,42 +423,14 @@ int pblk_submit_io(struct pblk *pblk, struct nvm_rq *rqd)
 
 struct bio *pblk_bio_map_addr(struct pblk *pblk, void *data,
 			      unsigned int nr_secs, unsigned int len,
-			      int alloc_type, gfp_t gfp_mask)
+			      int alloc_type, gfp_t gfp_mask, int reading)
 {
 	struct nvm_tgt_dev *dev = pblk->dev;
-	void *kaddr = data;
-	struct page *page;
-	struct bio *bio;
-	int i, ret;
 
 	if (alloc_type == PBLK_KMALLOC_META)
-		return bio_map_kern(dev->q, kaddr, len, gfp_mask);
+		return bio_map_kern(dev->q, data, len, gfp_mask);
 
-	bio = bio_kmalloc(gfp_mask, nr_secs);
-	if (!bio)
-		return ERR_PTR(-ENOMEM);
-
-	for (i = 0; i < nr_secs; i++) {
-		page = vmalloc_to_page(kaddr);
-		if (!page) {
-			pr_err("pblk: could not map vmalloc bio\n");
-			bio_put(bio);
-			bio = ERR_PTR(-ENOMEM);
-			goto out;
-		}
-
-		ret = bio_add_pc_page(dev->q, bio, page, PAGE_SIZE, 0);
-		if (ret != PAGE_SIZE) {
-			pr_err("pblk: could not add page to bio\n");
-			bio_put(bio);
-			bio = ERR_PTR(-ENOMEM);
-			goto out;
-		}
-
-		kaddr += PAGE_SIZE;
-	}
-out:
-	return bio;
+	return bio_copy_kern(dev->q, data, len, GFP_KERNEL, reading);
 }
 
 int pblk_calc_secs(struct pblk *pblk, unsigned long secs_avail,
@@ -588,7 +560,7 @@ static int pblk_line_submit_emeta_io(struct pblk *pblk, struct pblk_line *line,
 	rq_len = rq_ppas * geo->sec_size;
 
 	bio = pblk_bio_map_addr(pblk, emeta_buf, rq_ppas, rq_len,
-					l_mg->emeta_alloc_type, GFP_KERNEL);
+			l_mg->emeta_alloc_type, GFP_KERNEL, dir == READ);
 	if (IS_ERR(bio)) {
 		ret = PTR_ERR(bio);
 		goto free_rqd_dma;
@@ -673,9 +645,6 @@ static int pblk_line_submit_emeta_io(struct pblk *pblk, struct pblk_line *line,
 	atomic_dec(&pblk->inflight_io);
 	reinit_completion(&wait);
 
-	if (likely(pblk->l_mg.emeta_alloc_type == PBLK_VMALLOC_META))
-		bio_put(bio);
-
 	if (rqd.error) {
 		if (dir == WRITE)
 			pblk_log_write_err(pblk, &rqd);
diff --git a/drivers/lightnvm/pblk-read.c b/drivers/lightnvm/pblk-read.c
index f32091503547..1be972521dcd 100644
--- a/drivers/lightnvm/pblk-read.c
+++ b/drivers/lightnvm/pblk-read.c
@@ -542,7 +542,7 @@ int pblk_submit_read_gc(struct pblk *pblk, struct pblk_gc_rq *gc_rq)
 
 	data_len = (gc_rq->secs_to_gc) * geo->sec_size;
 	bio = pblk_bio_map_addr(pblk, gc_rq->data, gc_rq->secs_to_gc, data_len,
-						PBLK_VMALLOC_META, GFP_KERNEL);
+					PBLK_VMALLOC_META, GFP_KERNEL, 1);
 	if (IS_ERR(bio)) {
 		pr_err("pblk: could not allocate GC bio (%lu)\n", PTR_ERR(bio));
 		goto err_free_dma;
@@ -583,7 +583,6 @@ int pblk_submit_read_gc(struct pblk *pblk, struct pblk_gc_rq *gc_rq)
 	atomic_long_sub(gc_rq->secs_to_gc, &pblk->inflight_reads);
 #endif
 
-	bio_put(bio);
 out:
 	nvm_dev_dma_free(dev->parent, rqd.meta_list, rqd.dma_meta_list);
 	return ret;
diff --git a/drivers/lightnvm/pblk-recovery.c b/drivers/lightnvm/pblk-recovery.c
index 279638309d9a..b033d4f2b446 100644
--- a/drivers/lightnvm/pblk-recovery.c
+++ b/drivers/lightnvm/pblk-recovery.c
@@ -342,7 +342,6 @@ static void pblk_end_io_recov(struct nvm_rq *rqd)
 
 	pblk_up_page(pblk, rqd->ppa_list, rqd->nr_ppas);
 
-	bio_put(rqd->bio);
 	nvm_dev_dma_free(dev->parent, rqd->meta_list, rqd->dma_meta_list);
 	pblk_free_rqd(pblk, rqd, WRITE_INT);
 
@@ -411,7 +410,7 @@ static int pblk_recov_pad_oob(struct pblk *pblk, struct pblk_line *line,
 	}
 
 	bio = pblk_bio_map_addr(pblk, data, rq_ppas, rq_len,
-						PBLK_VMALLOC_META, GFP_KERNEL);
+					PBLK_VMALLOC_META, GFP_KERNEL, 0);
 	if (IS_ERR(bio)) {
 		ret = PTR_ERR(bio);
 		goto fail_free_rqd;
diff --git a/drivers/lightnvm/pblk-write.c b/drivers/lightnvm/pblk-write.c
index 920b93fb15d5..e5d77af1aad1 100644
--- a/drivers/lightnvm/pblk-write.c
+++ b/drivers/lightnvm/pblk-write.c
@@ -187,17 +187,12 @@ static void pblk_end_io_write_meta(struct nvm_rq *rqd)
 		pblk_log_write_err(pblk, rqd);
 		pr_err("pblk: metadata I/O failed. Line %d\n", line->id);
 	}
-#ifdef CONFIG_NVM_DEBUG
-	else
-		WARN_ONCE(rqd->bio->bi_status, "pblk: corrupted write error\n");
-#endif
 
 	sync = atomic_add_return(rqd->nr_ppas, &emeta->sync);
 	if (sync == emeta->nr_entries)
 		pblk_line_run_ws(pblk, line, NULL, pblk_line_close_ws,
 								pblk->close_wq);
 
-	bio_put(rqd->bio);
 	nvm_dev_dma_free(dev->parent, rqd->meta_list, rqd->dma_meta_list);
 	pblk_free_rqd(pblk, rqd, WRITE_INT);
 
@@ -382,7 +377,7 @@ int pblk_submit_meta_io(struct pblk *pblk, struct pblk_line *meta_line)
 	data = ((void *)emeta->buf) + emeta->mem;
 
 	bio = pblk_bio_map_addr(pblk, data, rq_ppas, rq_len,
-					l_mg->emeta_alloc_type, GFP_KERNEL);
+				l_mg->emeta_alloc_type, GFP_KERNEL, 0);
 	if (IS_ERR(bio)) {
 		ret = PTR_ERR(bio);
 		goto fail_free_rqd;
diff --git a/drivers/lightnvm/pblk.h b/drivers/lightnvm/pblk.h
index 3771f876ce80..2304a4891f20 100644
--- a/drivers/lightnvm/pblk.h
+++ b/drivers/lightnvm/pblk.h
@@ -712,7 +712,7 @@ int pblk_submit_io(struct pblk *pblk, struct nvm_rq *rqd);
 int pblk_submit_meta_io(struct pblk *pblk, struct pblk_line *meta_line);
 struct bio *pblk_bio_map_addr(struct pblk *pblk, void *data,
 			      unsigned int nr_secs, unsigned int len,
-			      int alloc_type, gfp_t gfp_mask);
+			      int alloc_type, gfp_t gfp_mask, int reading);
 struct pblk_line *pblk_line_get(struct pblk *pblk);
 struct pblk_line *pblk_line_get_first_data(struct pblk *pblk);
 void pblk_line_replace_data(struct pblk *pblk);
-- 
2.7.4
