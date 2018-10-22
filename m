Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mga04.intel.com ([192.55.52.120]:63986 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728101AbeJVS6S (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Mon, 22 Oct 2018 14:58:18 -0400
From: Igor Konopko <igor.j.konopko@intel.com>
To: mb@lightnvm.io, javier@cnexlabs.com, hans.ml.holmberg@owltronix.com
Cc: linux-block@vger.kernel.org, igor.j.konopko@intel.com
Subject: [PATCH v2 2/5] lightnvm: pblk: Helpers for OOB metadata
Date: Mon, 22 Oct 2018 12:36:08 +0200
Message-Id: <20181022103611.39271-3-igor.j.konopko@intel.com>
In-Reply-To: <20181022103611.39271-1-igor.j.konopko@intel.com>
References: <20181022103611.39271-1-igor.j.konopko@intel.com>
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

Currently pblk assumes that size of OOB metadata on drive is always
equal to size of pblk_sec_meta struct. This commit add helpers which will
allow to handle different sizes of OOB metadata on drive.

Signed-off-by: Igor Konopko <igor.j.konopko@intel.com>
---
 drivers/lightnvm/pblk-core.c     |  5 +++--
 drivers/lightnvm/pblk-map.c      | 20 +++++++++++-------
 drivers/lightnvm/pblk-read.c     | 45 +++++++++++++++++++++++++---------------
 drivers/lightnvm/pblk-recovery.c | 13 ++++++------
 drivers/lightnvm/pblk.h          | 22 ++++++++++++++++++++
 5 files changed, 73 insertions(+), 32 deletions(-)

diff --git a/drivers/lightnvm/pblk-core.c b/drivers/lightnvm/pblk-core.c
index 6944aac43b01..0f33055f40eb 100644
--- a/drivers/lightnvm/pblk-core.c
+++ b/drivers/lightnvm/pblk-core.c
@@ -796,10 +796,11 @@ static int pblk_line_smeta_write(struct pblk *pblk, struct pblk_line *line,
 	rqd.is_seq = 1;
 
 	for (i = 0; i < lm->smeta_sec; i++, paddr++) {
-		struct pblk_sec_meta *meta_list = rqd.meta_list;
+		void *meta_list = rqd.meta_list;
 
 		rqd.ppa_list[i] = addr_to_gen_ppa(pblk, paddr, line->id);
-		meta_list[i].lba = lba_list[paddr] = addr_empty;
+		pblk_set_meta_lba(pblk, meta_list, i, addr_empty);
+		lba_list[paddr] = addr_empty;
 	}
 
 	ret = pblk_submit_io_sync_sem(pblk, &rqd);
diff --git a/drivers/lightnvm/pblk-map.c b/drivers/lightnvm/pblk-map.c
index 6dcbd44e3acb..4bae30129bc9 100644
--- a/drivers/lightnvm/pblk-map.c
+++ b/drivers/lightnvm/pblk-map.c
@@ -22,7 +22,7 @@
 static int pblk_map_page_data(struct pblk *pblk, unsigned int sentry,
 			      struct ppa_addr *ppa_list,
 			      unsigned long *lun_bitmap,
-			      struct pblk_sec_meta *meta_list,
+			      void *meta_list,
 			      unsigned int valid_secs)
 {
 	struct pblk_line *line = pblk_line_get_data(pblk);
@@ -68,14 +68,16 @@ static int pblk_map_page_data(struct pblk *pblk, unsigned int sentry,
 			kref_get(&line->ref);
 			w_ctx = pblk_rb_w_ctx(&pblk->rwb, sentry + i);
 			w_ctx->ppa = ppa_list[i];
-			meta_list[i].lba = cpu_to_le64(w_ctx->lba);
+			pblk_set_meta_lba(pblk, meta_list, i,
+					  cpu_to_le64(w_ctx->lba));
 			lba_list[paddr] = cpu_to_le64(w_ctx->lba);
 			if (lba_list[paddr] != addr_empty)
 				line->nr_valid_lbas++;
 			else
 				atomic64_inc(&pblk->pad_wa);
 		} else {
-			lba_list[paddr] = meta_list[i].lba = addr_empty;
+			lba_list[paddr] = addr_empty;
+			pblk_set_meta_lba(pblk, meta_list, i, addr_empty);
 			__pblk_map_invalidate(pblk, line, paddr);
 		}
 	}
@@ -88,7 +90,8 @@ void pblk_map_rq(struct pblk *pblk, struct nvm_rq *rqd, unsigned int sentry,
 		 unsigned long *lun_bitmap, unsigned int valid_secs,
 		 unsigned int off)
 {
-	struct pblk_sec_meta *meta_list = rqd->meta_list;
+	void *meta_list = rqd->meta_list;
+	void *meta_buffer;
 	struct ppa_addr *ppa_list = nvm_rq_to_ppa_list(rqd);
 	unsigned int map_secs;
 	int min = pblk->min_write_pgs;
@@ -96,8 +99,9 @@ void pblk_map_rq(struct pblk *pblk, struct nvm_rq *rqd, unsigned int sentry,
 
 	for (i = off; i < rqd->nr_ppas; i += min) {
 		map_secs = (i + min > valid_secs) ? (valid_secs % min) : min;
+		meta_buffer = pblk_get_meta(pblk, meta_list, i);
 		if (pblk_map_page_data(pblk, sentry + i, &ppa_list[i],
-					lun_bitmap, &meta_list[i], map_secs)) {
+					lun_bitmap, meta_buffer, map_secs)) {
 			bio_put(rqd->bio);
 			pblk_free_rqd(pblk, rqd, PBLK_WRITE);
 			pblk_pipeline_stop(pblk);
@@ -113,7 +117,8 @@ void pblk_map_erase_rq(struct pblk *pblk, struct nvm_rq *rqd,
 	struct nvm_tgt_dev *dev = pblk->dev;
 	struct nvm_geo *geo = &dev->geo;
 	struct pblk_line_meta *lm = &pblk->lm;
-	struct pblk_sec_meta *meta_list = rqd->meta_list;
+	void *meta_list = rqd->meta_list;
+	void *meta_buffer;
 	struct ppa_addr *ppa_list = nvm_rq_to_ppa_list(rqd);
 	struct pblk_line *e_line, *d_line;
 	unsigned int map_secs;
@@ -122,8 +127,9 @@ void pblk_map_erase_rq(struct pblk *pblk, struct nvm_rq *rqd,
 
 	for (i = 0; i < rqd->nr_ppas; i += min) {
 		map_secs = (i + min > valid_secs) ? (valid_secs % min) : min;
+		meta_buffer = pblk_get_meta(pblk, meta_list, i);
 		if (pblk_map_page_data(pblk, sentry + i, &ppa_list[i],
-					lun_bitmap, &meta_list[i], map_secs)) {
+					lun_bitmap, meta_buffer, map_secs)) {
 			bio_put(rqd->bio);
 			pblk_free_rqd(pblk, rqd, PBLK_WRITE);
 			pblk_pipeline_stop(pblk);
diff --git a/drivers/lightnvm/pblk-read.c b/drivers/lightnvm/pblk-read.c
index 19917d3c19b3..cc73a1594180 100644
--- a/drivers/lightnvm/pblk-read.c
+++ b/drivers/lightnvm/pblk-read.c
@@ -43,7 +43,7 @@ static void pblk_read_ppalist_rq(struct pblk *pblk, struct nvm_rq *rqd,
 				 struct bio *bio, sector_t blba,
 				 unsigned long *read_bitmap)
 {
-	struct pblk_sec_meta *meta_list = rqd->meta_list;
+	void *meta_list = rqd->meta_list;
 	struct ppa_addr ppas[NVM_MAX_VLBA];
 	int nr_secs = rqd->nr_ppas;
 	bool advanced_bio = false;
@@ -57,8 +57,10 @@ static void pblk_read_ppalist_rq(struct pblk *pblk, struct nvm_rq *rqd,
 
 retry:
 		if (pblk_ppa_empty(p)) {
+			__le64 addr_empty = cpu_to_le64(ADDR_EMPTY);
+
 			WARN_ON(test_and_set_bit(i, read_bitmap));
-			meta_list[i].lba = cpu_to_le64(ADDR_EMPTY);
+			pblk_set_meta_lba(pblk, meta_list, i, addr_empty);
 
 			if (unlikely(!advanced_bio)) {
 				bio_advance(bio, (i) * PBLK_EXPOSED_PAGE_SIZE);
@@ -78,7 +80,8 @@ static void pblk_read_ppalist_rq(struct pblk *pblk, struct nvm_rq *rqd,
 				goto retry;
 			}
 			WARN_ON(test_and_set_bit(i, read_bitmap));
-			meta_list[i].lba = cpu_to_le64(lba);
+			pblk_set_meta_lba(pblk, meta_list, i,
+					  cpu_to_le64(lba));
 			advanced_bio = true;
 #ifdef CONFIG_NVM_PBLK_DEBUG
 			atomic_long_inc(&pblk->cache_reads);
@@ -105,12 +108,12 @@ static void pblk_read_ppalist_rq(struct pblk *pblk, struct nvm_rq *rqd,
 static void pblk_read_check_seq(struct pblk *pblk, struct nvm_rq *rqd,
 				sector_t blba)
 {
-	struct pblk_sec_meta *meta_lba_list = rqd->meta_list;
+	void *meta_list = rqd->meta_list;
 	int nr_lbas = rqd->nr_ppas;
 	int i;
 
 	for (i = 0; i < nr_lbas; i++) {
-		u64 lba = le64_to_cpu(meta_lba_list[i].lba);
+		u64 lba = le64_to_cpu(pblk_get_meta_lba(pblk, meta_list, i));
 
 		if (lba == ADDR_EMPTY)
 			continue;
@@ -134,7 +137,7 @@ static void pblk_read_check_seq(struct pblk *pblk, struct nvm_rq *rqd,
 static void pblk_read_check_rand(struct pblk *pblk, struct nvm_rq *rqd,
 				 u64 *lba_list, int nr_lbas)
 {
-	struct pblk_sec_meta *meta_lba_list = rqd->meta_list;
+	void *meta_lba_list = rqd->meta_list;
 	int i, j;
 
 	for (i = 0, j = 0; i < nr_lbas; i++) {
@@ -144,7 +147,8 @@ static void pblk_read_check_rand(struct pblk *pblk, struct nvm_rq *rqd,
 		if (lba == ADDR_EMPTY)
 			continue;
 
-		meta_lba = le64_to_cpu(meta_lba_list[j].lba);
+		meta_lba = le64_to_cpu(pblk_get_meta_lba(pblk,
+							 meta_lba_list, j));
 
 		if (lba != meta_lba) {
 #ifdef CONFIG_NVM_PBLK_DEBUG
@@ -219,7 +223,7 @@ static void pblk_end_partial_read(struct nvm_rq *rqd)
 	struct bio *new_bio = rqd->bio;
 	struct bio *bio = pr_ctx->orig_bio;
 	struct bio_vec src_bv, dst_bv;
-	struct pblk_sec_meta *meta_list = rqd->meta_list;
+	void *meta_list = rqd->meta_list;
 	int bio_init_idx = pr_ctx->bio_init_idx;
 	unsigned long *read_bitmap = pr_ctx->bitmap;
 	int nr_secs = pr_ctx->orig_nr_secs;
@@ -237,8 +241,10 @@ static void pblk_end_partial_read(struct nvm_rq *rqd)
 	}
 
 	for (i = 0; i < nr_secs; i++) {
-		pr_ctx->lba_list_media[i] = meta_list[i].lba;
-		meta_list[i].lba = pr_ctx->lba_list_mem[i];
+		pr_ctx->lba_list_media[i] = le64_to_cpu(pblk_get_meta_lba(pblk,
+							meta_list, i));
+		pblk_set_meta_lba(pblk, meta_list, i,
+				  cpu_to_le64(pr_ctx->lba_list_mem[i]));
 	}
 
 	/* Fill the holes in the original bio */
@@ -250,7 +256,8 @@ static void pblk_end_partial_read(struct nvm_rq *rqd)
 		line = pblk_ppa_to_line(pblk, rqd->ppa_list[i]);
 		kref_put(&line->ref, pblk_line_put);
 
-		meta_list[hole].lba = pr_ctx->lba_list_media[i];
+		pblk_set_meta_lba(pblk, meta_list, hole,
+				  cpu_to_le64(pr_ctx->lba_list_media[i]));
 
 		src_bv = new_bio->bi_io_vec[i++];
 		dst_bv = bio->bi_io_vec[bio_init_idx + hole];
@@ -286,7 +293,7 @@ static int pblk_setup_partial_read(struct pblk *pblk, struct nvm_rq *rqd,
 			    unsigned long *read_bitmap,
 			    int nr_holes)
 {
-	struct pblk_sec_meta *meta_list = rqd->meta_list;
+	void *meta_list = rqd->meta_list;
 	struct pblk_g_ctx *r_ctx = nvm_rq_to_pdu(rqd);
 	struct pblk_pr_ctx *pr_ctx;
 	struct bio *new_bio, *bio = r_ctx->private;
@@ -307,8 +314,10 @@ static int pblk_setup_partial_read(struct pblk *pblk, struct nvm_rq *rqd,
 	if (!pr_ctx)
 		goto fail_free_pages;
 
-	for (i = 0; i < nr_secs; i++)
-		pr_ctx->lba_list_mem[i] = meta_list[i].lba;
+	for (i = 0; i < nr_secs; i++) {
+		pr_ctx->lba_list_mem[i] = le64_to_cpu(pblk_get_meta_lba(pblk,
+							      meta_list, i));
+	}
 
 	new_bio->bi_iter.bi_sector = 0; /* internal bio */
 	bio_set_op_attrs(new_bio, REQ_OP_READ, 0);
@@ -373,7 +382,7 @@ static int pblk_partial_read_bio(struct pblk *pblk, struct nvm_rq *rqd,
 static void pblk_read_rq(struct pblk *pblk, struct nvm_rq *rqd, struct bio *bio,
 			 sector_t lba, unsigned long *read_bitmap)
 {
-	struct pblk_sec_meta *meta_list = rqd->meta_list;
+	void *meta_list = rqd->meta_list;
 	struct ppa_addr ppa;
 
 	pblk_lookup_l2p_seq(pblk, &ppa, lba, 1);
@@ -384,8 +393,10 @@ static void pblk_read_rq(struct pblk *pblk, struct nvm_rq *rqd, struct bio *bio,
 
 retry:
 	if (pblk_ppa_empty(ppa)) {
+		__le64 addr_empty = cpu_to_le64(ADDR_EMPTY);
+
 		WARN_ON(test_and_set_bit(0, read_bitmap));
-		meta_list[0].lba = cpu_to_le64(ADDR_EMPTY);
+		pblk_set_meta_lba(pblk, meta_list, 0, addr_empty);
 		return;
 	}
 
@@ -399,7 +410,7 @@ static void pblk_read_rq(struct pblk *pblk, struct nvm_rq *rqd, struct bio *bio,
 		}
 
 		WARN_ON(test_and_set_bit(0, read_bitmap));
-		meta_list[0].lba = cpu_to_le64(lba);
+		pblk_set_meta_lba(pblk, meta_list, 0, cpu_to_le64(lba));
 
 #ifdef CONFIG_NVM_PBLK_DEBUG
 		atomic_long_inc(&pblk->cache_reads);
diff --git a/drivers/lightnvm/pblk-recovery.c b/drivers/lightnvm/pblk-recovery.c
index 5740b7509bd8..977b2ca5d849 100644
--- a/drivers/lightnvm/pblk-recovery.c
+++ b/drivers/lightnvm/pblk-recovery.c
@@ -124,7 +124,7 @@ static u64 pblk_sec_in_open_line(struct pblk *pblk, struct pblk_line *line)
 
 struct pblk_recov_alloc {
 	struct ppa_addr *ppa_list;
-	struct pblk_sec_meta *meta_list;
+	void *meta_list;
 	struct nvm_rq *rqd;
 	void *data;
 	dma_addr_t dma_ppa_list;
@@ -158,7 +158,7 @@ static int pblk_recov_pad_line(struct pblk *pblk, struct pblk_line *line,
 {
 	struct nvm_tgt_dev *dev = pblk->dev;
 	struct nvm_geo *geo = &dev->geo;
-	struct pblk_sec_meta *meta_list;
+	void *meta_list;
 	struct pblk_pad_rq *pad_rq;
 	struct nvm_rq *rqd;
 	struct bio *bio;
@@ -242,7 +242,8 @@ static int pblk_recov_pad_line(struct pblk *pblk, struct pblk_line *line,
 			dev_ppa = addr_to_gen_ppa(pblk, w_ptr, line->id);
 
 			pblk_map_invalidate(pblk, dev_ppa);
-			lba_list[w_ptr] = meta_list[i].lba = addr_empty;
+			lba_list[w_ptr] = addr_empty;
+			pblk_set_meta_lba(pblk, meta_list, i, addr_empty);
 			rqd->ppa_list[i] = dev_ppa;
 		}
 	}
@@ -336,7 +337,7 @@ static int pblk_recov_scan_oob(struct pblk *pblk, struct pblk_line *line,
 	struct nvm_tgt_dev *dev = pblk->dev;
 	struct nvm_geo *geo = &dev->geo;
 	struct ppa_addr *ppa_list;
-	struct pblk_sec_meta *meta_list;
+	void *meta_list;
 	struct nvm_rq *rqd;
 	struct bio *bio;
 	void *data;
@@ -434,7 +435,7 @@ static int pblk_recov_scan_oob(struct pblk *pblk, struct pblk_line *line,
 	}
 
 	for (i = 0; i < rqd->nr_ppas; i++) {
-		u64 lba = le64_to_cpu(meta_list[i].lba);
+		u64 lba = le64_to_cpu(pblk_get_meta_lba(pblk, meta_list, i));
 
 		lba_list[paddr++] = cpu_to_le64(lba);
 
@@ -463,7 +464,7 @@ static int pblk_recov_l2p_from_oob(struct pblk *pblk, struct pblk_line *line)
 	struct nvm_geo *geo = &dev->geo;
 	struct nvm_rq *rqd;
 	struct ppa_addr *ppa_list;
-	struct pblk_sec_meta *meta_list;
+	void *meta_list;
 	struct pblk_recov_alloc p;
 	void *data;
 	dma_addr_t dma_ppa_list, dma_meta_list;
diff --git a/drivers/lightnvm/pblk.h b/drivers/lightnvm/pblk.h
index 2aca840c7838..d09c1b341e07 100644
--- a/drivers/lightnvm/pblk.h
+++ b/drivers/lightnvm/pblk.h
@@ -1372,4 +1372,26 @@ static inline char *pblk_disk_name(struct pblk *pblk)
 
 	return disk->disk_name;
 }
+
+static inline struct pblk_sec_meta *pblk_get_meta(struct pblk *pblk,
+							 void *meta, int index)
+{
+	struct nvm_tgt_dev *dev = pblk->dev;
+	struct nvm_geo *geo = &dev->geo;
+
+	return meta + max_t(int, geo->sos, sizeof(struct pblk_sec_meta))
+		* index;
+}
+
+static inline void pblk_set_meta_lba(struct pblk *pblk, void *meta,
+				     int index, __le64 lba)
+{
+	pblk_get_meta(pblk, meta, index)->lba = lba;
+}
+
+static inline __le64 pblk_get_meta_lba(struct pblk *pblk, void *meta,
+				    int index)
+{
+	return pblk_get_meta(pblk, meta, index)->lba;
+}
 #endif /* PBLK_H_ */
-- 
2.14.4
