Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mail-wm0-f45.google.com ([74.125.82.45]:37015 "EHLO
        mail-wm0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752974AbdIFKwp (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Wed, 6 Sep 2017 06:52:45 -0400
Received: by mail-wm0-f45.google.com with SMTP id u26so29535911wma.0
        for <linux-block@vger.kernel.org>; Wed, 06 Sep 2017 03:52:44 -0700 (PDT)
From: "=?UTF-8?q?Javier=20Gonz=C3=A1lez?=" <jg@lightnvm.io>
To: mb@lightnvm.io, axboe@fb.com
Cc: linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        =?UTF-8?q?Javier=20Gonz=C3=A1lez?= <javier@cnexlabs.com>,
        =?UTF-8?q?Matias=20Bj=C3=B8rling?= <matias@cnexlabs.com>
Subject: [PATCH 08/18] lightnvm: pblk: check lba sanity on read path
Date: Wed,  6 Sep 2017 12:51:01 +0200
Message-Id: <1504695071-25928-9-git-send-email-javier@cnexlabs.com>
In-Reply-To: <1504695071-25928-1-git-send-email-javier@cnexlabs.com>
References: <1504695071-25928-1-git-send-email-javier@cnexlabs.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

As part of pblk's recovery scheme, we store the lba mapped to each
physical sector on the device's out-of-bound (OOB) area. On the read
path, we can use this information to validate that the data being
delivered to the upper layers corresponds to the lba being requested.
The cost of this check is an extra copy on the DMA region on the device
and an extra comparison in the host, given that (i) the OOB area is
being read together with the data in the media, and (ii) the DMA region
allocated for the ppa list can be reused for the metadata stored on the
OOB area.

Signed-off-by: Javier González <javier@cnexlabs.com>
Signed-off-by: Matias Bjørling <matias@cnexlabs.com>
---
 drivers/lightnvm/pblk-read.c | 48 ++++++++++++++++++++++++++++++++++++++++++--
 drivers/lightnvm/pblk.h      |  2 ++
 2 files changed, 48 insertions(+), 2 deletions(-)

diff --git a/drivers/lightnvm/pblk-read.c b/drivers/lightnvm/pblk-read.c
index 9bbdca8a65ab..ae440a43e09c 100644
--- a/drivers/lightnvm/pblk-read.c
+++ b/drivers/lightnvm/pblk-read.c
@@ -41,6 +41,7 @@ static int pblk_read_from_cache(struct pblk *pblk, struct bio *bio,
 static void pblk_read_ppalist_rq(struct pblk *pblk, struct nvm_rq *rqd,
 				 sector_t blba, unsigned long *read_bitmap)
 {
+	struct pblk_sec_meta *meta_list = rqd->meta_list;
 	struct bio *bio = rqd->bio;
 	struct ppa_addr ppas[PBLK_MAX_REQ_ADDRS];
 	int nr_secs = rqd->nr_ppas;
@@ -56,6 +57,7 @@ static void pblk_read_ppalist_rq(struct pblk *pblk, struct nvm_rq *rqd,
 retry:
 		if (pblk_ppa_empty(p)) {
 			WARN_ON(test_and_set_bit(i, read_bitmap));
+			meta_list[i].lba = cpu_to_le64(ADDR_EMPTY);
 
 			if (unlikely(!advanced_bio)) {
 				bio_advance(bio, (i) * PBLK_EXPOSED_PAGE_SIZE);
@@ -75,6 +77,7 @@ static void pblk_read_ppalist_rq(struct pblk *pblk, struct nvm_rq *rqd,
 				goto retry;
 			}
 			WARN_ON(test_and_set_bit(i, read_bitmap));
+			meta_list[i].lba = cpu_to_le64(lba);
 			advanced_bio = true;
 #ifdef CONFIG_NVM_DEBUG
 			atomic_long_inc(&pblk->cache_reads);
@@ -110,6 +113,23 @@ static int pblk_submit_read_io(struct pblk *pblk, struct nvm_rq *rqd)
 	return NVM_IO_OK;
 }
 
+static void pblk_read_check(struct pblk *pblk, struct nvm_rq *rqd,
+			   sector_t blba)
+{
+	struct pblk_sec_meta *meta_list = rqd->meta_list;
+	int nr_lbas = rqd->nr_ppas;
+	int i;
+
+	for (i = 0; i < nr_lbas; i++) {
+		u64 lba = le64_to_cpu(meta_list[i].lba);
+
+		if (lba == ADDR_EMPTY)
+			continue;
+
+		WARN(lba != blba + i, "pblk: corrupted read LBA\n");
+	}
+}
+
 static void pblk_end_io_read(struct nvm_rq *rqd)
 {
 	struct pblk *pblk = rqd->private;
@@ -124,6 +144,7 @@ static void pblk_end_io_read(struct nvm_rq *rqd)
 		WARN_ONCE(bio->bi_status, "pblk: corrupted read error\n");
 #endif
 
+	pblk_read_check(pblk, rqd, r_ctx->lba);
 	nvm_dev_dma_free(dev->parent, rqd->meta_list, rqd->dma_meta_list);
 
 	bio_put(bio);
@@ -151,15 +172,21 @@ static int pblk_fill_partial_read_bio(struct pblk *pblk, struct nvm_rq *rqd,
 				      unsigned long *read_bitmap)
 {
 	struct bio *new_bio, *bio = rqd->bio;
+	struct pblk_sec_meta *meta_list = rqd->meta_list;
 	struct bio_vec src_bv, dst_bv;
 	void *ppa_ptr = NULL;
 	void *src_p, *dst_p;
 	dma_addr_t dma_ppa_list = 0;
+	__le64 *lba_list_mem, *lba_list_media;
 	int nr_secs = rqd->nr_ppas;
 	int nr_holes = nr_secs - bitmap_weight(read_bitmap, nr_secs);
 	int i, ret, hole;
 	DECLARE_COMPLETION_ONSTACK(wait);
 
+	/* Re-use allocated memory for intermediate lbas */
+	lba_list_mem = (((void *)rqd->ppa_list) + pblk_dma_ppa_size);
+	lba_list_media = (((void *)rqd->ppa_list) + 2 * pblk_dma_ppa_size);
+
 	new_bio = bio_alloc(GFP_KERNEL, nr_holes);
 	if (!new_bio) {
 		pr_err("pblk: could not alloc read bio\n");
@@ -174,6 +201,9 @@ static int pblk_fill_partial_read_bio(struct pblk *pblk, struct nvm_rq *rqd,
 		goto err;
 	}
 
+	for (i = 0; i < nr_secs; i++)
+		lba_list_mem[i] = meta_list[i].lba;
+
 	new_bio->bi_iter.bi_sector = 0; /* internal bio */
 	bio_set_op_attrs(new_bio, REQ_OP_READ, 0);
 	new_bio->bi_private = &wait;
@@ -214,10 +244,17 @@ static int pblk_fill_partial_read_bio(struct pblk *pblk, struct nvm_rq *rqd,
 		rqd->dma_ppa_list = dma_ppa_list;
 	}
 
+	for (i = 0; i < nr_secs; i++) {
+		lba_list_media[i] = meta_list[i].lba;
+		meta_list[i].lba = lba_list_mem[i];
+	}
+
 	/* Fill the holes in the original bio */
 	i = 0;
 	hole = find_first_zero_bit(read_bitmap, nr_secs);
 	do {
+		meta_list[hole].lba = lba_list_media[i];
+
 		src_bv = new_bio->bi_io_vec[i++];
 		dst_bv = bio->bi_io_vec[bio_init_idx + hole];
 
@@ -258,6 +295,7 @@ static int pblk_fill_partial_read_bio(struct pblk *pblk, struct nvm_rq *rqd,
 static void pblk_read_rq(struct pblk *pblk, struct nvm_rq *rqd,
 			 sector_t lba, unsigned long *read_bitmap)
 {
+	struct pblk_sec_meta *meta_list = rqd->meta_list;
 	struct bio *bio = rqd->bio;
 	struct ppa_addr ppa;
 
@@ -270,6 +308,7 @@ static void pblk_read_rq(struct pblk *pblk, struct nvm_rq *rqd,
 retry:
 	if (pblk_ppa_empty(ppa)) {
 		WARN_ON(test_and_set_bit(0, read_bitmap));
+		meta_list[0].lba = cpu_to_le64(ADDR_EMPTY);
 		return;
 	}
 
@@ -281,6 +320,9 @@ static void pblk_read_rq(struct pblk *pblk, struct nvm_rq *rqd,
 			pblk_lookup_l2p_seq(pblk, &ppa, lba, 1);
 			goto retry;
 		}
+
+		meta_list[0].lba = cpu_to_le64(lba);
+
 		WARN_ON(test_and_set_bit(0, read_bitmap));
 #ifdef CONFIG_NVM_DEBUG
 			atomic_long_inc(&pblk->cache_reads);
@@ -297,9 +339,10 @@ int pblk_submit_read(struct pblk *pblk, struct bio *bio)
 	struct nvm_tgt_dev *dev = pblk->dev;
 	sector_t blba = pblk_get_lba(bio);
 	unsigned int nr_secs = pblk_get_secs(bio);
+	struct pblk_g_ctx *r_ctx;
 	struct nvm_rq *rqd;
-	unsigned long read_bitmap; /* Max 64 ppas per request */
 	unsigned int bio_init_idx;
+	unsigned long read_bitmap; /* Max 64 ppas per request */
 	int ret = NVM_IO_ERR;
 
 	/* logic error: lba out-of-bounds. Ignore read request */
@@ -316,6 +359,8 @@ int pblk_submit_read(struct pblk *pblk, struct bio *bio)
 		pr_err_ratelimited("pblk: not able to alloc rqd");
 		return NVM_IO_ERR;
 	}
+	r_ctx = nvm_rq_to_pdu(rqd);
+	r_ctx->lba = blba;
 
 	rqd->opcode = NVM_OP_PREAD;
 	rqd->bio = bio;
@@ -355,7 +400,6 @@ int pblk_submit_read(struct pblk *pblk, struct bio *bio)
 	/* All sectors are to be read from the device */
 	if (bitmap_empty(&read_bitmap, rqd->nr_ppas)) {
 		struct bio *int_bio = NULL;
-		struct pblk_g_ctx *r_ctx = nvm_rq_to_pdu(rqd);
 
 		/* Clone read bio to deal with read errors internally */
 		int_bio = bio_clone_fast(bio, GFP_KERNEL, pblk_bio_set);
diff --git a/drivers/lightnvm/pblk.h b/drivers/lightnvm/pblk.h
index b7f5fa8b49d0..f43d672585b4 100644
--- a/drivers/lightnvm/pblk.h
+++ b/drivers/lightnvm/pblk.h
@@ -98,6 +98,7 @@ enum {
 };
 
 #define pblk_dma_meta_size (sizeof(struct pblk_sec_meta) * PBLK_MAX_REQ_ADDRS)
+#define pblk_dma_ppa_size (sizeof(u64) * PBLK_MAX_REQ_ADDRS)
 
 /* write buffer completion context */
 struct pblk_c_ctx {
@@ -112,6 +113,7 @@ struct pblk_c_ctx {
 /* generic context */
 struct pblk_g_ctx {
 	void *private;
+	u64 lba;
 };
 
 /* Pad context */
-- 
2.7.4
