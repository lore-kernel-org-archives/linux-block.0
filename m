Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mail-wm0-f48.google.com ([74.125.82.48]:45111 "EHLO
        mail-wm0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751924AbdINKeV (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 14 Sep 2017 06:34:21 -0400
Received: by mail-wm0-f48.google.com with SMTP id g206so10182036wme.0
        for <linux-block@vger.kernel.org>; Thu, 14 Sep 2017 03:34:20 -0700 (PDT)
From: "=?UTF-8?q?Javier=20Gonz=C3=A1lez?=" <jg@lightnvm.io>
To: axboe@fb.com
Cc: linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        =?UTF-8?q?Javier=20Gonz=C3=A1lez?= <javier@cnexlabs.com>
Subject: [PATCH 5/5] lightnvm: pblk: remove checks on mempool alloc.
Date: Thu, 14 Sep 2017 12:33:47 +0200
Message-Id: <1505385227-28706-6-git-send-email-javier@cnexlabs.com>
In-Reply-To: <1505385227-28706-1-git-send-email-javier@cnexlabs.com>
References: <1505385227-28706-1-git-send-email-javier@cnexlabs.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

As part of the mempool audit on pblk, remove unnecessary mempool
allocation checks on mempools.

Reported-by: Jens Axboe <axboe@kernel.dk>
Signed-off-by: Javier González <javier@cnexlabs.com>
---
 drivers/lightnvm/pblk-core.c     |  4 ----
 drivers/lightnvm/pblk-read.c     |  8 --------
 drivers/lightnvm/pblk-recovery.c | 35 +++++++----------------------------
 drivers/lightnvm/pblk-write.c    | 24 +++++-------------------
 4 files changed, 12 insertions(+), 59 deletions(-)

diff --git a/drivers/lightnvm/pblk-core.c b/drivers/lightnvm/pblk-core.c
index bb53fe416d4e..3004e9252a11 100644
--- a/drivers/lightnvm/pblk-core.c
+++ b/drivers/lightnvm/pblk-core.c
@@ -206,8 +206,6 @@ int pblk_bio_add_pages(struct pblk *pblk, struct bio *bio, gfp_t flags,
 
 	for (i = 0; i < nr_pages; i++) {
 		page = mempool_alloc(pblk->page_bio_pool, flags);
-		if (!page)
-			goto err;
 
 		ret = bio_add_pc_page(q, bio, page, PBLK_EXPOSED_PAGE_SIZE, 0);
 		if (ret != PBLK_EXPOSED_PAGE_SIZE) {
@@ -1653,8 +1651,6 @@ void pblk_gen_run_ws(struct pblk *pblk, struct pblk_line *line, void *priv,
 	struct pblk_line_ws *line_ws;
 
 	line_ws = mempool_alloc(pblk->gen_ws_pool, gfp_mask);
-	if (!line_ws)
-		return;
 
 	line_ws->pblk = pblk;
 	line_ws->line = line;
diff --git a/drivers/lightnvm/pblk-read.c b/drivers/lightnvm/pblk-read.c
index 402c732f0970..d2b6e2a7d7d5 100644
--- a/drivers/lightnvm/pblk-read.c
+++ b/drivers/lightnvm/pblk-read.c
@@ -168,10 +168,6 @@ static int pblk_fill_partial_read_bio(struct pblk *pblk, struct nvm_rq *rqd,
 	DECLARE_COMPLETION_ONSTACK(wait);
 
 	new_bio = bio_alloc(GFP_KERNEL, nr_holes);
-	if (!new_bio) {
-		pr_err("pblk: could not alloc read bio\n");
-		return NVM_IO_ERR;
-	}
 
 	if (pblk_bio_add_pages(pblk, new_bio, GFP_KERNEL, nr_holes))
 		goto err;
@@ -321,10 +317,6 @@ int pblk_submit_read(struct pblk *pblk, struct bio *bio)
 	bitmap_zero(&read_bitmap, nr_secs);
 
 	rqd = pblk_alloc_rqd(pblk, READ);
-	if (IS_ERR(rqd)) {
-		pr_err_ratelimited("pblk: not able to alloc rqd");
-		return NVM_IO_ERR;
-	}
 
 	rqd->opcode = NVM_OP_PREAD;
 	rqd->bio = bio;
diff --git a/drivers/lightnvm/pblk-recovery.c b/drivers/lightnvm/pblk-recovery.c
index 10eef9281a27..573085bdb7e5 100644
--- a/drivers/lightnvm/pblk-recovery.c
+++ b/drivers/lightnvm/pblk-recovery.c
@@ -34,10 +34,6 @@ void pblk_submit_rec(struct work_struct *work)
 								max_secs);
 
 	bio = bio_alloc(GFP_KERNEL, nr_rec_secs);
-	if (!bio) {
-		pr_err("pblk: not able to create recovery bio\n");
-		return;
-	}
 
 	bio->bi_iter.bi_sector = 0;
 	bio_set_op_attrs(bio, REQ_OP_WRITE, 0);
@@ -85,11 +81,6 @@ int pblk_recov_setup_rq(struct pblk *pblk, struct pblk_c_ctx *c_ctx,
 	int nr_entries = c_ctx->nr_valid + c_ctx->nr_padded;
 
 	rec_rqd = pblk_alloc_rqd(pblk, WRITE);
-	if (IS_ERR(rec_rqd)) {
-		pr_err("pblk: could not create recovery req.\n");
-		return -ENOMEM;
-	}
-
 	rec_ctx = nvm_rq_to_pdu(rec_rqd);
 
 	/* Copy completion bitmap, but exclude the first X completed entries */
@@ -404,22 +395,18 @@ static int pblk_recov_pad_oob(struct pblk *pblk, struct pblk_line *line,
 	ppa_list = (void *)(meta_list) + pblk_dma_meta_size;
 	dma_ppa_list = dma_meta_list + pblk_dma_meta_size;
 
-	rqd = pblk_alloc_rqd(pblk, WRITE);
-	if (IS_ERR(rqd)) {
-		ret = PTR_ERR(rqd);
-		goto fail_free_meta;
-	}
-
 	bio = pblk_bio_map_addr(pblk, data, rq_ppas, rq_len,
 						PBLK_VMALLOC_META, GFP_KERNEL);
 	if (IS_ERR(bio)) {
 		ret = PTR_ERR(bio);
-		goto fail_free_rqd;
+		goto fail_free_meta;
 	}
 
 	bio->bi_iter.bi_sector = 0; /* internal bio */
 	bio_set_op_attrs(bio, REQ_OP_WRITE, 0);
 
+	rqd = pblk_alloc_rqd(pblk, WRITE);
+
 	rqd->bio = bio;
 	rqd->opcode = NVM_OP_PWRITE;
 	rqd->flags = pblk_set_progr_mode(pblk, WRITE);
@@ -490,8 +477,6 @@ static int pblk_recov_pad_oob(struct pblk *pblk, struct pblk_line *line,
 
 fail_free_bio:
 	bio_put(bio);
-fail_free_rqd:
-	pblk_free_rqd(pblk, rqd, WRITE);
 fail_free_meta:
 	nvm_dev_dma_free(dev->parent, meta_list, dma_meta_list);
 fail_free_pad:
@@ -785,15 +770,9 @@ static int pblk_recov_l2p_from_oob(struct pblk *pblk, struct pblk_line *line)
 	dma_addr_t dma_ppa_list, dma_meta_list;
 	int done, ret = 0;
 
-	rqd = pblk_alloc_rqd(pblk, READ);
-	if (IS_ERR(rqd))
-		return PTR_ERR(rqd);
-
 	meta_list = nvm_dev_dma_alloc(dev->parent, GFP_KERNEL, &dma_meta_list);
-	if (!meta_list) {
-		ret = -ENOMEM;
-		goto free_rqd;
-	}
+	if (!meta_list)
+		return -ENOMEM;
 
 	ppa_list = (void *)(meta_list) + pblk_dma_meta_size;
 	dma_ppa_list = dma_meta_list + pblk_dma_meta_size;
@@ -804,6 +783,8 @@ static int pblk_recov_l2p_from_oob(struct pblk *pblk, struct pblk_line *line)
 		goto free_meta_list;
 	}
 
+	rqd = pblk_alloc_rqd(pblk, READ);
+
 	p.ppa_list = ppa_list;
 	p.meta_list = meta_list;
 	p.rqd = rqd;
@@ -832,8 +813,6 @@ static int pblk_recov_l2p_from_oob(struct pblk *pblk, struct pblk_line *line)
 	kfree(data);
 free_meta_list:
 	nvm_dev_dma_free(dev->parent, meta_list, dma_meta_list);
-free_rqd:
-	pblk_free_rqd(pblk, rqd, READ);
 
 	return ret;
 }
diff --git a/drivers/lightnvm/pblk-write.c b/drivers/lightnvm/pblk-write.c
index 3277cee36784..939eb6df2265 100644
--- a/drivers/lightnvm/pblk-write.c
+++ b/drivers/lightnvm/pblk-write.c
@@ -114,10 +114,7 @@ static void pblk_end_w_fail(struct pblk *pblk, struct nvm_rq *rqd)
 		ppa_list = &rqd->ppa_addr;
 
 	recovery = mempool_alloc(pblk->rec_pool, GFP_ATOMIC);
-	if (!recovery) {
-		pr_err("pblk: could not allocate recovery context\n");
-		return;
-	}
+
 	INIT_LIST_HEAD(&recovery->failed);
 
 	bit = -1;
@@ -378,10 +375,7 @@ int pblk_submit_meta_io(struct pblk *pblk, struct pblk_line *meta_line)
 	int ret;
 
 	rqd = pblk_alloc_rqd(pblk, READ);
-	if (IS_ERR(rqd)) {
-		pr_err("pblk: cannot allocate write req.\n");
-		return PTR_ERR(rqd);
-	}
+
 	m_ctx = nvm_rq_to_pdu(rqd);
 	m_ctx->private = meta_line;
 
@@ -549,19 +543,12 @@ static int pblk_submit_write(struct pblk *pblk)
 	if (!secs_to_flush && secs_avail < pblk->min_write_pgs)
 		return 1;
 
-	rqd = pblk_alloc_rqd(pblk, WRITE);
-	if (IS_ERR(rqd)) {
-		pr_err("pblk: cannot allocate write req.\n");
-		return 1;
-	}
-
 	bio = bio_alloc(GFP_KERNEL, pblk->max_write_pgs);
-	if (!bio) {
-		pr_err("pblk: cannot allocate write bio\n");
-		goto fail_free_rqd;
-	}
+
 	bio->bi_iter.bi_sector = 0; /* internal bio */
 	bio_set_op_attrs(bio, REQ_OP_WRITE, 0);
+
+	rqd = pblk_alloc_rqd(pblk, WRITE);
 	rqd->bio = bio;
 
 	secs_to_sync = pblk_calc_secs_to_sync(pblk, secs_avail, secs_to_flush);
@@ -592,7 +579,6 @@ static int pblk_submit_write(struct pblk *pblk)
 	pblk_free_write_rqd(pblk, rqd);
 fail_put_bio:
 	bio_put(bio);
-fail_free_rqd:
 	pblk_free_rqd(pblk, rqd, WRITE);
 
 	return 1;
-- 
2.7.4
