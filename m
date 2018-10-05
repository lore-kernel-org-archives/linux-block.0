Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mga04.intel.com ([192.55.52.120]:4640 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728708AbeJEUhA (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Fri, 5 Oct 2018 16:37:00 -0400
From: Igor Konopko <igor.j.konopko@intel.com>
To: mb@lightnvm.io, javier@cnexlabs.com
Cc: linux-block@vger.kernel.org, marcin.dziegielewski@intel.com,
        igor.j.konopko@intel.com
Subject: [PATCH 1/5] lightnvm: pblk: Do not reuse DMA memory on partial read
Date: Fri,  5 Oct 2018 15:34:33 +0200
Message-Id: <20181005133437.25255-2-igor.j.konopko@intel.com>
In-Reply-To: <20181005133437.25255-1-igor.j.konopko@intel.com>
References: <20181005133437.25255-1-igor.j.konopko@intel.com>
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

Currently DMA allocated memory is reused on partial read
path for some internal pblk structs. In preparation for
dynamic DMA pool sizes we need to change it to kmalloc
allocated memory.

Signed-off-by: Igor Konopko <igor.j.konopko@intel.com>
---
 drivers/lightnvm/pblk-read.c | 20 +++++---------------
 drivers/lightnvm/pblk.h      |  2 ++
 2 files changed, 7 insertions(+), 15 deletions(-)

diff --git a/drivers/lightnvm/pblk-read.c b/drivers/lightnvm/pblk-read.c
index d340dece1d00..08f6ebd4bc48 100644
--- a/drivers/lightnvm/pblk-read.c
+++ b/drivers/lightnvm/pblk-read.c
@@ -224,7 +224,6 @@ static void pblk_end_partial_read(struct nvm_rq *rqd)
 	unsigned long *read_bitmap = pr_ctx->bitmap;
 	int nr_secs = pr_ctx->orig_nr_secs;
 	int nr_holes = nr_secs - bitmap_weight(read_bitmap, nr_secs);
-	__le64 *lba_list_mem, *lba_list_media;
 	void *src_p, *dst_p;
 	int hole, i;
 
@@ -237,13 +236,9 @@ static void pblk_end_partial_read(struct nvm_rq *rqd)
 		rqd->ppa_list[0] = ppa;
 	}
 
-	/* Re-use allocated memory for intermediate lbas */
-	lba_list_mem = (((void *)rqd->ppa_list) + pblk_dma_ppa_size);
-	lba_list_media = (((void *)rqd->ppa_list) + 2 * pblk_dma_ppa_size);
-
 	for (i = 0; i < nr_secs; i++) {
-		lba_list_media[i] = meta_list[i].lba;
-		meta_list[i].lba = lba_list_mem[i];
+		pr_ctx->lba_list_media[i] = meta_list[i].lba;
+		meta_list[i].lba = pr_ctx->lba_list_mem[i];
 	}
 
 	/* Fill the holes in the original bio */
@@ -255,7 +250,7 @@ static void pblk_end_partial_read(struct nvm_rq *rqd)
 		line = pblk_ppa_to_line(pblk, rqd->ppa_list[i]);
 		kref_put(&line->ref, pblk_line_put);
 
-		meta_list[hole].lba = lba_list_media[i];
+		meta_list[hole].lba = pr_ctx->lba_list_media[i];
 
 		src_bv = new_bio->bi_io_vec[i++];
 		dst_bv = bio->bi_io_vec[bio_init_idx + hole];
@@ -295,13 +290,9 @@ static int pblk_setup_partial_read(struct pblk *pblk, struct nvm_rq *rqd,
 	struct pblk_g_ctx *r_ctx = nvm_rq_to_pdu(rqd);
 	struct pblk_pr_ctx *pr_ctx;
 	struct bio *new_bio, *bio = r_ctx->private;
-	__le64 *lba_list_mem;
 	int nr_secs = rqd->nr_ppas;
 	int i;
 
-	/* Re-use allocated memory for intermediate lbas */
-	lba_list_mem = (((void *)rqd->ppa_list) + pblk_dma_ppa_size);
-
 	new_bio = bio_alloc(GFP_KERNEL, nr_holes);
 
 	if (pblk_bio_add_pages(pblk, new_bio, GFP_KERNEL, nr_holes))
@@ -312,12 +303,12 @@ static int pblk_setup_partial_read(struct pblk *pblk, struct nvm_rq *rqd,
 		goto fail_free_pages;
 	}
 
-	pr_ctx = kmalloc(sizeof(struct pblk_pr_ctx), GFP_KERNEL);
+	pr_ctx = kzalloc(sizeof(struct pblk_pr_ctx), GFP_KERNEL);
 	if (!pr_ctx)
 		goto fail_free_pages;
 
 	for (i = 0; i < nr_secs; i++)
-		lba_list_mem[i] = meta_list[i].lba;
+		pr_ctx->lba_list_mem[i] = meta_list[i].lba;
 
 	new_bio->bi_iter.bi_sector = 0; /* internal bio */
 	bio_set_op_attrs(new_bio, REQ_OP_READ, 0);
@@ -325,7 +316,6 @@ static int pblk_setup_partial_read(struct pblk *pblk, struct nvm_rq *rqd,
 	rqd->bio = new_bio;
 	rqd->nr_ppas = nr_holes;
 
-	pr_ctx->ppa_ptr = NULL;
 	pr_ctx->orig_bio = bio;
 	bitmap_copy(pr_ctx->bitmap, read_bitmap, NVM_MAX_VLBA);
 	pr_ctx->bio_init_idx = bio_init_idx;
diff --git a/drivers/lightnvm/pblk.h b/drivers/lightnvm/pblk.h
index 0f98ea24ee59..aea09879636f 100644
--- a/drivers/lightnvm/pblk.h
+++ b/drivers/lightnvm/pblk.h
@@ -132,6 +132,8 @@ struct pblk_pr_ctx {
 	unsigned int bio_init_idx;
 	void *ppa_ptr;
 	dma_addr_t dma_ppa_list;
+	__le64 lba_list_mem[NVM_MAX_VLBA];
+	__le64 lba_list_media[NVM_MAX_VLBA];
 };
 
 /* Pad context */
-- 
2.17.1
