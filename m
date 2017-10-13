Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mail-wm0-f65.google.com ([74.125.82.65]:44613 "EHLO
        mail-wm0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1758247AbdJMMre (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 13 Oct 2017 08:47:34 -0400
Received: by mail-wm0-f65.google.com with SMTP id 196so27939628wma.1
        for <linux-block@vger.kernel.org>; Fri, 13 Oct 2017 05:47:33 -0700 (PDT)
From: =?UTF-8?q?Matias=20Bj=C3=B8rling?= <m@bjorling.me>
To: axboe@fb.com
Cc: linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        =?UTF-8?q?Javier=20Gonz=C3=A1lez?= <javier@cnexlabs.com>,
        =?UTF-8?q?Matias=20Bj=C3=B8rling?= <m@bjorling.me>
Subject: [GIT PULL 27/58] lightnvm: pblk: put bio on bio completion
Date: Fri, 13 Oct 2017 14:46:16 +0200
Message-Id: <20171013124647.32668-28-m@bjorling.me>
In-Reply-To: <20171013124647.32668-1-m@bjorling.me>
References: <20171013124647.32668-1-m@bjorling.me>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

From: Javier González <javier@cnexlabs.com>

Simplify put bio by doing it on bio end_io instead of manually putting
it on the completion path.

Signed-off-by: Javier González <javier@cnexlabs.com>
Signed-off-by: Matias Bjørling <m@bjorling.me>
---
 drivers/lightnvm/pblk-core.c     | 10 +++++++---
 drivers/lightnvm/pblk-read.c     |  1 -
 drivers/lightnvm/pblk-recovery.c |  1 -
 drivers/lightnvm/pblk-write.c    |  8 +-------
 4 files changed, 8 insertions(+), 12 deletions(-)

diff --git a/drivers/lightnvm/pblk-core.c b/drivers/lightnvm/pblk-core.c
index 6dd4866..3d27d24 100644
--- a/drivers/lightnvm/pblk-core.c
+++ b/drivers/lightnvm/pblk-core.c
@@ -417,6 +417,11 @@ int pblk_submit_io(struct pblk *pblk, struct nvm_rq *rqd)
 	return nvm_submit_io(dev, rqd);
 }
 
+static void pblk_bio_map_addr_endio(struct bio *bio)
+{
+	bio_put(bio);
+}
+
 struct bio *pblk_bio_map_addr(struct pblk *pblk, void *data,
 			      unsigned int nr_secs, unsigned int len,
 			      int alloc_type, gfp_t gfp_mask)
@@ -453,6 +458,8 @@ struct bio *pblk_bio_map_addr(struct pblk *pblk, void *data,
 
 		kaddr += PAGE_SIZE;
 	}
+
+	bio->bi_end_io = pblk_bio_map_addr_endio;
 out:
 	return bio;
 }
@@ -671,9 +678,6 @@ static int pblk_line_submit_emeta_io(struct pblk *pblk, struct pblk_line *line,
 	atomic_dec(&pblk->inflight_io);
 	reinit_completion(&wait);
 
-	if (likely(pblk->l_mg.emeta_alloc_type == PBLK_VMALLOC_META))
-		bio_put(bio);
-
 	if (rqd.error) {
 		if (dir == WRITE)
 			pblk_log_write_err(pblk, &rqd);
diff --git a/drivers/lightnvm/pblk-read.c b/drivers/lightnvm/pblk-read.c
index c28d650..e7141b1 100644
--- a/drivers/lightnvm/pblk-read.c
+++ b/drivers/lightnvm/pblk-read.c
@@ -531,7 +531,6 @@ int pblk_submit_read_gc(struct pblk *pblk, struct pblk_gc_rq *gc_rq)
 	atomic_long_sub(gc_rq->secs_to_gc, &pblk->inflight_reads);
 #endif
 
-	bio_put(bio);
 out:
 	nvm_dev_dma_free(dev->parent, rqd.meta_list, rqd.dma_meta_list);
 	return ret;
diff --git a/drivers/lightnvm/pblk-recovery.c b/drivers/lightnvm/pblk-recovery.c
index 6b6b418..e59270e 100644
--- a/drivers/lightnvm/pblk-recovery.c
+++ b/drivers/lightnvm/pblk-recovery.c
@@ -333,7 +333,6 @@ static void pblk_end_io_recov(struct nvm_rq *rqd)
 
 	pblk_up_page(pblk, rqd->ppa_list, rqd->nr_ppas);
 
-	bio_put(rqd->bio);
 	nvm_dev_dma_free(dev->parent, rqd->meta_list, rqd->dma_meta_list);
 	pblk_free_rqd(pblk, rqd, WRITE);
 
diff --git a/drivers/lightnvm/pblk-write.c b/drivers/lightnvm/pblk-write.c
index 0fb8f26..0c0481c 100644
--- a/drivers/lightnvm/pblk-write.c
+++ b/drivers/lightnvm/pblk-write.c
@@ -188,17 +188,12 @@ static void pblk_end_io_write_meta(struct nvm_rq *rqd)
 		pblk_log_write_err(pblk, rqd);
 		pr_err("pblk: metadata I/O failed. Line %d\n", line->id);
 	}
-#ifdef CONFIG_NVM_DEBUG
-	else
-		WARN_ONCE(rqd->bio->bi_status, "pblk: corrupted write error\n");
-#endif
 
 	sync = atomic_add_return(rqd->nr_ppas, &emeta->sync);
 	if (sync == emeta->nr_entries)
 		pblk_gen_run_ws(pblk, line, NULL, pblk_line_close_ws,
 						GFP_ATOMIC, pblk->close_wq);
 
-	bio_put(rqd->bio);
 	nvm_dev_dma_free(dev->parent, rqd->meta_list, rqd->dma_meta_list);
 	pblk_free_rqd(pblk, rqd, READ);
 
@@ -427,8 +422,7 @@ int pblk_submit_meta_io(struct pblk *pblk, struct pblk_line *meta_line)
 
 	nvm_dev_dma_free(dev->parent, rqd->meta_list, rqd->dma_meta_list);
 fail_free_bio:
-	if (likely(l_mg->emeta_alloc_type == PBLK_VMALLOC_META))
-		bio_put(bio);
+	bio_put(bio);
 fail_free_rqd:
 	pblk_free_rqd(pblk, rqd, READ);
 	return ret;
-- 
2.9.3
