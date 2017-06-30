Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mail-wm0-f50.google.com ([74.125.82.50]:35875 "EHLO
        mail-wm0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752536AbdF3P5I (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 30 Jun 2017 11:57:08 -0400
Received: by mail-wm0-f50.google.com with SMTP id 62so114235910wmw.1
        for <linux-block@vger.kernel.org>; Fri, 30 Jun 2017 08:56:57 -0700 (PDT)
From: "=?UTF-8?q?Javier=20Gonz=C3=A1lez?=" <jg@lightnvm.io>
To: mb@lightnvm.io, axboe@fb.com
Cc: linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        =?UTF-8?q?Javier=20Gonz=C3=A1lez?= <javier@cnexlabs.com>,
        =?UTF-8?q?Matias=20Bj=C3=B8rling?= <matias@cnexlabs.com>
Subject: [PATCH 06/10] lightnvm: pblk: use vmalloc for GC data buffer
Date: Fri, 30 Jun 2017 17:56:39 +0200
Message-Id: <1498838203-21539-7-git-send-email-javier@cnexlabs.com>
In-Reply-To: <1498838203-21539-1-git-send-email-javier@cnexlabs.com>
References: <1498838203-21539-1-git-send-email-javier@cnexlabs.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

For now, we allocate a per I/O buffer for GC data. Since the potential
size of the buffer is 256KB and GC is not in the fast path, do this
allocation with vmalloc. This puts lets pressure on the memory
allocator at no performance cost.

Signed-off-by: Javier González <javier@cnexlabs.com>
Signed-off-by: Matias Bjørling <matias@cnexlabs.com>
---
 drivers/lightnvm/pblk-core.c  | 9 +++++----
 drivers/lightnvm/pblk-gc.c    | 6 +++---
 drivers/lightnvm/pblk-read.c  | 4 ++--
 drivers/lightnvm/pblk-write.c | 3 ++-
 drivers/lightnvm/pblk.h       | 4 ++--
 5 files changed, 14 insertions(+), 12 deletions(-)

diff --git a/drivers/lightnvm/pblk-core.c b/drivers/lightnvm/pblk-core.c
index a654b34f6f86..74b8d9db05e1 100644
--- a/drivers/lightnvm/pblk-core.c
+++ b/drivers/lightnvm/pblk-core.c
@@ -425,16 +425,15 @@ int pblk_submit_io(struct pblk *pblk, struct nvm_rq *rqd)
 
 struct bio *pblk_bio_map_addr(struct pblk *pblk, void *data,
 			      unsigned int nr_secs, unsigned int len,
-			      gfp_t gfp_mask)
+			      int alloc_type, gfp_t gfp_mask)
 {
 	struct nvm_tgt_dev *dev = pblk->dev;
-	struct pblk_line_mgmt *l_mg = &pblk->l_mg;
 	void *kaddr = data;
 	struct page *page;
 	struct bio *bio;
 	int i, ret;
 
-	if (l_mg->emeta_alloc_type == PBLK_KMALLOC_META)
+	if (alloc_type == PBLK_KMALLOC_META)
 		return bio_map_kern(dev->q, kaddr, len, gfp_mask);
 
 	bio = bio_kmalloc(gfp_mask, nr_secs);
@@ -552,6 +551,7 @@ static int pblk_line_submit_emeta_io(struct pblk *pblk, struct pblk_line *line,
 {
 	struct nvm_tgt_dev *dev = pblk->dev;
 	struct nvm_geo *geo = &dev->geo;
+	struct pblk_line_mgmt *l_mg = &pblk->l_mg;
 	struct pblk_line_meta *lm = &pblk->lm;
 	void *ppa_list, *meta_list;
 	struct bio *bio;
@@ -589,7 +589,8 @@ static int pblk_line_submit_emeta_io(struct pblk *pblk, struct pblk_line *line,
 	rq_ppas = pblk_calc_secs(pblk, left_ppas, 0);
 	rq_len = rq_ppas * geo->sec_size;
 
-	bio = pblk_bio_map_addr(pblk, emeta_buf, rq_ppas, rq_len, GFP_KERNEL);
+	bio = pblk_bio_map_addr(pblk, emeta_buf, rq_ppas, rq_len,
+					l_mg->emeta_alloc_type, GFP_KERNEL);
 	if (IS_ERR(bio)) {
 		ret = PTR_ERR(bio);
 		goto free_rqd_dma;
diff --git a/drivers/lightnvm/pblk-gc.c b/drivers/lightnvm/pblk-gc.c
index 9b4059b93855..6090d28f7995 100644
--- a/drivers/lightnvm/pblk-gc.c
+++ b/drivers/lightnvm/pblk-gc.c
@@ -20,7 +20,7 @@
 
 static void pblk_gc_free_gc_rq(struct pblk_gc_rq *gc_rq)
 {
-	kfree(gc_rq->data);
+	vfree(gc_rq->data);
 	kfree(gc_rq);
 }
 
@@ -72,7 +72,7 @@ static int pblk_gc_move_valid_secs(struct pblk *pblk, struct pblk_gc_rq *gc_rq)
 	unsigned int secs_to_gc;
 	int ret = 0;
 
-	data = kmalloc(gc_rq->nr_secs * geo->sec_size, GFP_KERNEL);
+	data = vmalloc(gc_rq->nr_secs * geo->sec_size);
 	if (!data) {
 		ret = -ENOMEM;
 		goto out;
@@ -110,7 +110,7 @@ static int pblk_gc_move_valid_secs(struct pblk *pblk, struct pblk_gc_rq *gc_rq)
 free_rq:
 	kfree(gc_rq);
 free_data:
-	kfree(data);
+	vfree(data);
 out:
 	kref_put(&line->ref, pblk_line_put);
 	return ret;
diff --git a/drivers/lightnvm/pblk-read.c b/drivers/lightnvm/pblk-read.c
index ed2ea01a0a38..31d4869b0500 100644
--- a/drivers/lightnvm/pblk-read.c
+++ b/drivers/lightnvm/pblk-read.c
@@ -462,7 +462,6 @@ int pblk_submit_read_gc(struct pblk *pblk, u64 *lba_list, void *data,
 {
 	struct nvm_tgt_dev *dev = pblk->dev;
 	struct nvm_geo *geo = &dev->geo;
-	struct request_queue *q = dev->q;
 	struct bio *bio;
 	struct nvm_rq rqd;
 	int ret, data_len;
@@ -491,7 +490,8 @@ int pblk_submit_read_gc(struct pblk *pblk, u64 *lba_list, void *data,
 		goto out;
 
 	data_len = (*secs_to_gc) * geo->sec_size;
-	bio = bio_map_kern(q, data, data_len, GFP_KERNEL);
+	bio = pblk_bio_map_addr(pblk, data, *secs_to_gc, data_len,
+						PBLK_KMALLOC_META, GFP_KERNEL);
 	if (IS_ERR(bio)) {
 		pr_err("pblk: could not allocate GC bio (%lu)\n", PTR_ERR(bio));
 		goto err_free_dma;
diff --git a/drivers/lightnvm/pblk-write.c b/drivers/lightnvm/pblk-write.c
index 3e0b84937b90..8151bf4bb945 100644
--- a/drivers/lightnvm/pblk-write.c
+++ b/drivers/lightnvm/pblk-write.c
@@ -389,7 +389,8 @@ int pblk_submit_meta_io(struct pblk *pblk, struct pblk_line *meta_line)
 	rq_len = rq_ppas * geo->sec_size;
 	data = ((void *)emeta->buf) + emeta->mem;
 
-	bio = pblk_bio_map_addr(pblk, data, rq_ppas, rq_len, GFP_KERNEL);
+	bio = pblk_bio_map_addr(pblk, data, rq_ppas, rq_len,
+					l_mg->emeta_alloc_type, GFP_KERNEL);
 	if (IS_ERR(bio)) {
 		ret = PTR_ERR(bio);
 		goto fail_free_rqd;
diff --git a/drivers/lightnvm/pblk.h b/drivers/lightnvm/pblk.h
index 36c5f5999324..cdad2c9edbdf 100644
--- a/drivers/lightnvm/pblk.h
+++ b/drivers/lightnvm/pblk.h
@@ -698,7 +698,7 @@ int pblk_submit_io(struct pblk *pblk, struct nvm_rq *rqd);
 int pblk_submit_meta_io(struct pblk *pblk, struct pblk_line *meta_line);
 struct bio *pblk_bio_map_addr(struct pblk *pblk, void *data,
 			      unsigned int nr_secs, unsigned int len,
-			      gfp_t gfp_mask);
+			      int alloc_type, gfp_t gfp_mask);
 struct pblk_line *pblk_line_get(struct pblk *pblk);
 struct pblk_line *pblk_line_get_first_data(struct pblk *pblk);
 void pblk_line_replace_data(struct pblk *pblk);
@@ -805,7 +805,7 @@ int pblk_recov_setup_rq(struct pblk *pblk, struct pblk_c_ctx *c_ctx,
  * pblk gc
  */
 #define PBLK_GC_MAX_READERS 8	/* Max number of outstanding GC reader jobs */
-#define PBLK_GC_W_QD 1024	/* Queue depth for inflight GC write I/Os */
+#define PBLK_GC_W_QD 128	/* Queue depth for inflight GC write I/Os */
 #define PBLK_GC_L_QD 4		/* Queue depth for inflight GC lines */
 #define PBLK_GC_RSV_LINE 1	/* Reserved lines for GC */
 
-- 
2.7.4
