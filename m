Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mail-wm0-f49.google.com ([74.125.82.49]:37979 "EHLO
        mail-wm0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751887AbdFZJ6Z (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 26 Jun 2017 05:58:25 -0400
Received: by mail-wm0-f49.google.com with SMTP id b184so3029236wme.1
        for <linux-block@vger.kernel.org>; Mon, 26 Jun 2017 02:58:24 -0700 (PDT)
From: "=?UTF-8?q?Javier=20Gonz=C3=A1lez?=" <jg@lightnvm.io>
To: mb@lightnvm.io, axboe@fb.com
Cc: linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        =?UTF-8?q?Javier=20Gonz=C3=A1lez?= <javier@cnexlabs.com>,
        =?UTF-8?q?Matias=20Bj=C3=B8rling?= <matias@cnexlabs.com>
Subject: [PATCH 15/20] lightnvm: pblk: set metadata list for all I/Os
Date: Mon, 26 Jun 2017 11:57:24 +0200
Message-Id: <1498471049-25505-16-git-send-email-javier@cnexlabs.com>
In-Reply-To: <1498471049-25505-1-git-send-email-javier@cnexlabs.com>
References: <1498471049-25505-1-git-send-email-javier@cnexlabs.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

Set a dma area for all I/Os in order to read/write from/to the metadata
stored on the per-sector out-of-bound area.

Signed-off-by: Javier González <javier@cnexlabs.com>
Signed-off-by: Matias Bjørling <matias@cnexlabs.com>
---
 drivers/lightnvm/pblk-core.c | 47 +++++++++++++++++++++++++++++++-------------
 drivers/lightnvm/pblk-read.c | 45 ++++++++++++++++++++----------------------
 2 files changed, 54 insertions(+), 38 deletions(-)

diff --git a/drivers/lightnvm/pblk-core.c b/drivers/lightnvm/pblk-core.c
index b5f7f3f19105..cba7cd78e4a6 100644
--- a/drivers/lightnvm/pblk-core.c
+++ b/drivers/lightnvm/pblk-core.c
@@ -555,10 +555,10 @@ static int pblk_line_submit_emeta_io(struct pblk *pblk, struct pblk_line *line,
 	struct nvm_tgt_dev *dev = pblk->dev;
 	struct nvm_geo *geo = &dev->geo;
 	struct pblk_line_meta *lm = &pblk->lm;
+	void *ppa_list, *meta_list;
 	struct bio *bio;
 	struct nvm_rq rqd;
-	struct ppa_addr *ppa_list;
-	dma_addr_t dma_ppa_list;
+	dma_addr_t dma_ppa_list, dma_meta_list;
 	int min = pblk->min_write_pgs;
 	int left_ppas = lm->emeta_sec[0];
 	int id = line->id;
@@ -577,10 +577,14 @@ static int pblk_line_submit_emeta_io(struct pblk *pblk, struct pblk_line *line,
 	} else
 		return -EINVAL;
 
-	ppa_list = nvm_dev_dma_alloc(dev->parent, GFP_KERNEL, &dma_ppa_list);
-	if (!ppa_list)
+	meta_list = nvm_dev_dma_alloc(dev->parent, GFP_KERNEL,
+							&dma_meta_list);
+	if (!meta_list)
 		return -ENOMEM;
 
+	ppa_list = meta_list + pblk_dma_meta_size;
+	dma_ppa_list = dma_meta_list + pblk_dma_meta_size;
+
 next_rq:
 	memset(&rqd, 0, sizeof(struct nvm_rq));
 
@@ -597,22 +601,28 @@ static int pblk_line_submit_emeta_io(struct pblk *pblk, struct pblk_line *line,
 	bio_set_op_attrs(bio, bio_op, 0);
 
 	rqd.bio = bio;
-	rqd.opcode = cmd_op;
-	rqd.nr_ppas = rq_ppas;
+	rqd.meta_list = meta_list;
 	rqd.ppa_list = ppa_list;
+	rqd.dma_meta_list = dma_meta_list;
 	rqd.dma_ppa_list = dma_ppa_list;
+	rqd.opcode = cmd_op;
+	rqd.nr_ppas = rq_ppas;
 	rqd.end_io = pblk_end_io_sync;
 	rqd.private = &wait;
 
 	if (dir == WRITE) {
+		struct pblk_sec_meta *meta_list = rqd.meta_list;
+
 		rqd.flags = pblk_set_progr_mode(pblk, WRITE);
 		for (i = 0; i < rqd.nr_ppas; ) {
 			spin_lock(&line->lock);
 			paddr = __pblk_alloc_page(pblk, line, min);
 			spin_unlock(&line->lock);
-			for (j = 0; j < min; j++, i++, paddr++)
+			for (j = 0; j < min; j++, i++, paddr++) {
+				meta_list[i].lba = cpu_to_le64(ADDR_EMPTY);
 				rqd.ppa_list[i] =
 					addr_to_gen_ppa(pblk, paddr, id);
+			}
 		}
 	} else {
 		for (i = 0; i < rqd.nr_ppas; ) {
@@ -680,7 +690,7 @@ static int pblk_line_submit_emeta_io(struct pblk *pblk, struct pblk_line *line,
 	if (left_ppas)
 		goto next_rq;
 free_rqd_dma:
-	nvm_dev_dma_free(dev->parent, ppa_list, dma_ppa_list);
+	nvm_dev_dma_free(dev->parent, rqd.meta_list, rqd.dma_meta_list);
 	return ret;
 }
 
@@ -726,11 +736,14 @@ static int pblk_line_submit_smeta_io(struct pblk *pblk, struct pblk_line *line,
 
 	memset(&rqd, 0, sizeof(struct nvm_rq));
 
-	rqd.ppa_list = nvm_dev_dma_alloc(dev->parent, GFP_KERNEL,
-							&rqd.dma_ppa_list);
-	if (!rqd.ppa_list)
+	rqd.meta_list = nvm_dev_dma_alloc(dev->parent, GFP_KERNEL,
+							&rqd.dma_meta_list);
+	if (!rqd.meta_list)
 		return -ENOMEM;
 
+	rqd.ppa_list = rqd.meta_list + pblk_dma_meta_size;
+	rqd.dma_ppa_list = rqd.dma_meta_list + pblk_dma_meta_size;
+
 	bio = bio_map_kern(dev->q, line->smeta, lm->smeta_len, GFP_KERNEL);
 	if (IS_ERR(bio)) {
 		ret = PTR_ERR(bio);
@@ -748,9 +761,15 @@ static int pblk_line_submit_smeta_io(struct pblk *pblk, struct pblk_line *line,
 	rqd.private = &wait;
 
 	for (i = 0; i < lm->smeta_sec; i++, paddr++) {
+		struct pblk_sec_meta *meta_list = rqd.meta_list;
+
 		rqd.ppa_list[i] = addr_to_gen_ppa(pblk, paddr, line->id);
-		if (dir == WRITE)
-			lba_list[paddr] = cpu_to_le64(ADDR_EMPTY);
+
+		if (dir == WRITE) {
+			u64 addr_empty = cpu_to_le64(ADDR_EMPTY);
+
+			meta_list[i].lba = lba_list[paddr] = addr_empty;
+		}
 	}
 
 	/*
@@ -778,7 +797,7 @@ static int pblk_line_submit_smeta_io(struct pblk *pblk, struct pblk_line *line,
 	}
 
 free_ppa_list:
-	nvm_dev_dma_free(dev->parent, rqd.ppa_list, rqd.dma_ppa_list);
+	nvm_dev_dma_free(dev->parent, rqd.meta_list, rqd.dma_meta_list);
 
 	return ret;
 }
diff --git a/drivers/lightnvm/pblk-read.c b/drivers/lightnvm/pblk-read.c
index d6499cdb7d33..292cbd290eea 100644
--- a/drivers/lightnvm/pblk-read.c
+++ b/drivers/lightnvm/pblk-read.c
@@ -123,8 +123,7 @@ static void pblk_end_io_read(struct nvm_rq *rqd)
 		WARN_ONCE(bio->bi_status, "pblk: corrupted read error\n");
 #endif
 
-	if (rqd->nr_ppas > 1)
-		nvm_dev_dma_free(dev->parent, rqd->ppa_list, rqd->dma_ppa_list);
+	nvm_dev_dma_free(dev->parent, rqd->meta_list, rqd->dma_meta_list);
 
 	bio_put(bio);
 	if (r_ctx->private) {
@@ -329,13 +328,16 @@ int pblk_submit_read(struct pblk *pblk, struct bio *bio)
 	 */
 	bio_init_idx = pblk_get_bi_idx(bio);
 
+	rqd->meta_list = nvm_dev_dma_alloc(dev->parent, GFP_KERNEL,
+							&rqd->dma_meta_list);
+	if (!rqd->meta_list) {
+		pr_err("pblk: not able to allocate ppa list\n");
+		goto fail_rqd_free;
+	}
+
 	if (nr_secs > 1) {
-		rqd->ppa_list = nvm_dev_dma_alloc(dev->parent, GFP_KERNEL,
-						&rqd->dma_ppa_list);
-		if (!rqd->ppa_list) {
-			pr_err("pblk: not able to allocate ppa list\n");
-			goto fail_rqd_free;
-		}
+		rqd->ppa_list = rqd->meta_list + pblk_dma_meta_size;
+		rqd->dma_ppa_list = rqd->dma_meta_list + pblk_dma_meta_size;
 
 		pblk_read_ppalist_rq(pblk, rqd, &read_bitmap);
 	} else {
@@ -466,22 +468,19 @@ int pblk_submit_read_gc(struct pblk *pblk, u64 *lba_list, void *data,
 
 	memset(&rqd, 0, sizeof(struct nvm_rq));
 
+	rqd.meta_list = nvm_dev_dma_alloc(dev->parent, GFP_KERNEL,
+							&rqd.dma_meta_list);
+	if (!rqd.meta_list)
+		return NVM_IO_ERR;
+
 	if (nr_secs > 1) {
-		rqd.ppa_list = nvm_dev_dma_alloc(dev->parent, GFP_KERNEL,
-							&rqd.dma_ppa_list);
-		if (!rqd.ppa_list)
-			return NVM_IO_ERR;
+		rqd.ppa_list = rqd.meta_list + pblk_dma_meta_size;
+		rqd.dma_ppa_list = rqd.dma_meta_list + pblk_dma_meta_size;
 
 		*secs_to_gc = read_ppalist_rq_gc(pblk, &rqd, line, lba_list,
 								nr_secs);
-		if (*secs_to_gc == 1) {
-			struct ppa_addr ppa;
-
-			ppa = rqd.ppa_list[0];
-			nvm_dev_dma_free(dev->parent, rqd.ppa_list,
-							rqd.dma_ppa_list);
-			rqd.ppa_addr = ppa;
-		}
+		if (*secs_to_gc == 1)
+			rqd.ppa_addr = rqd.ppa_list[0];
 	} else {
 		*secs_to_gc = read_rq_gc(pblk, &rqd, line, lba_list[0]);
 	}
@@ -532,12 +531,10 @@ int pblk_submit_read_gc(struct pblk *pblk, u64 *lba_list, void *data,
 #endif
 
 out:
-	if (rqd.nr_ppas > 1)
-		nvm_dev_dma_free(dev->parent, rqd.ppa_list, rqd.dma_ppa_list);
+	nvm_dev_dma_free(dev->parent, rqd.meta_list, rqd.dma_meta_list);
 	return NVM_IO_OK;
 
 err_free_dma:
-	if (rqd.nr_ppas > 1)
-		nvm_dev_dma_free(dev->parent, rqd.ppa_list, rqd.dma_ppa_list);
+	nvm_dev_dma_free(dev->parent, rqd.meta_list, rqd.dma_meta_list);
 	return NVM_IO_ERR;
 }
-- 
2.7.4
