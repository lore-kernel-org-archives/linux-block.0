Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mga12.intel.com ([192.55.52.136]:38380 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1756429AbeFOW11 (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Fri, 15 Jun 2018 18:27:27 -0400
From: Igor Konopko <igor.j.konopko@intel.com>
To: mb@lightnvm.io, javier@cnexlabs.com
Cc: linux-block@vger.kernel.org, michal.sorn@intel.com,
        marcin.dziegielewski@intel.com, igor.j.konopko@intel.com
Subject: [PATCH 1/5] lightnvm: pblk: Helpers for OOB metadata
Date: Sat, 16 Jun 2018 00:27:02 +0200
Message-Id: <20180615222706.3801-2-igor.j.konopko@intel.com>
In-Reply-To: <20180615222706.3801-1-igor.j.konopko@intel.com>
References: <20180615222706.3801-1-igor.j.konopko@intel.com>
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

Currently pblk assumes that size of OOB metadata on drive is always
equal to size of pblk_sec_meta struct. This commit add helpers which will
allow to handle different sizes of OOB metadata on drive.

Signed-off-by: Igor Konopko <igor.j.konopko@intel.com>
---
 drivers/lightnvm/pblk-core.c     | 10 +++++----
 drivers/lightnvm/pblk-map.c      | 21 ++++++++++++-------
 drivers/lightnvm/pblk-read.c     | 45 +++++++++++++++++++++++++---------------
 drivers/lightnvm/pblk-recovery.c | 24 ++++++++++++---------
 drivers/lightnvm/pblk.h          | 29 ++++++++++++++++++++++++++
 5 files changed, 91 insertions(+), 38 deletions(-)

diff --git a/drivers/lightnvm/pblk-core.c b/drivers/lightnvm/pblk-core.c
index 66ab1036f2fb..8a0ac466872f 100644
--- a/drivers/lightnvm/pblk-core.c
+++ b/drivers/lightnvm/pblk-core.c
@@ -685,7 +685,7 @@ static int pblk_line_submit_emeta_io(struct pblk *pblk, struct pblk_line *line,
 	rqd.nr_ppas = rq_ppas;
 
 	if (dir == PBLK_WRITE) {
-		struct pblk_sec_meta *meta_list = rqd.meta_list;
+		void *meta_list = rqd.meta_list;
 
 		rqd.flags = pblk_set_progr_mode(pblk, PBLK_WRITE);
 		for (i = 0; i < rqd.nr_ppas; ) {
@@ -693,7 +693,8 @@ static int pblk_line_submit_emeta_io(struct pblk *pblk, struct pblk_line *line,
 			paddr = __pblk_alloc_page(pblk, line, min);
 			spin_unlock(&line->lock);
 			for (j = 0; j < min; j++, i++, paddr++) {
-				meta_list[i].lba = cpu_to_le64(ADDR_EMPTY);
+				pblk_get_meta_at(pblk, meta_list, i)->lba =
+					cpu_to_le64(ADDR_EMPTY);
 				rqd.ppa_list[i] =
 					addr_to_gen_ppa(pblk, paddr, id);
 			}
@@ -825,14 +826,15 @@ static int pblk_line_submit_smeta_io(struct pblk *pblk, struct pblk_line *line,
 	rqd.nr_ppas = lm->smeta_sec;
 
 	for (i = 0; i < lm->smeta_sec; i++, paddr++) {
-		struct pblk_sec_meta *meta_list = rqd.meta_list;
+		void *meta_list = rqd.meta_list;
 
 		rqd.ppa_list[i] = addr_to_gen_ppa(pblk, paddr, line->id);
 
 		if (dir == PBLK_WRITE) {
 			__le64 addr_empty = cpu_to_le64(ADDR_EMPTY);
 
-			meta_list[i].lba = lba_list[paddr] = addr_empty;
+			pblk_get_meta_at(pblk, meta_list, i)->lba =
+				lba_list[paddr] = addr_empty;
 		}
 	}
 
diff --git a/drivers/lightnvm/pblk-map.c b/drivers/lightnvm/pblk-map.c
index 953ca31dda68..92c40b546c4e 100644
--- a/drivers/lightnvm/pblk-map.c
+++ b/drivers/lightnvm/pblk-map.c
@@ -21,7 +21,7 @@
 static int pblk_map_page_data(struct pblk *pblk, unsigned int sentry,
 			      struct ppa_addr *ppa_list,
 			      unsigned long *lun_bitmap,
-			      struct pblk_sec_meta *meta_list,
+			      void *meta_list,
 			      unsigned int valid_secs)
 {
 	struct pblk_line *line = pblk_line_get_data(pblk);
@@ -67,14 +67,17 @@ static int pblk_map_page_data(struct pblk *pblk, unsigned int sentry,
 			kref_get(&line->ref);
 			w_ctx = pblk_rb_w_ctx(&pblk->rwb, sentry + i);
 			w_ctx->ppa = ppa_list[i];
-			meta_list[i].lba = cpu_to_le64(w_ctx->lba);
+			pblk_get_meta_at(pblk, meta_list, i)->lba =
+							cpu_to_le64(w_ctx->lba);
 			lba_list[paddr] = cpu_to_le64(w_ctx->lba);
 			if (lba_list[paddr] != addr_empty)
 				line->nr_valid_lbas++;
 			else
 				atomic64_inc(&pblk->pad_wa);
 		} else {
-			lba_list[paddr] = meta_list[i].lba = addr_empty;
+			lba_list[paddr] =
+				pblk_get_meta_at(pblk, meta_list, i)->lba =
+					addr_empty;
 			__pblk_map_invalidate(pblk, line, paddr);
 		}
 	}
@@ -87,7 +90,7 @@ void pblk_map_rq(struct pblk *pblk, struct nvm_rq *rqd, unsigned int sentry,
 		 unsigned long *lun_bitmap, unsigned int valid_secs,
 		 unsigned int off)
 {
-	struct pblk_sec_meta *meta_list = rqd->meta_list;
+	void *meta_list = rqd->meta_list;
 	unsigned int map_secs;
 	int min = pblk->min_write_pgs;
 	int i;
@@ -95,7 +98,9 @@ void pblk_map_rq(struct pblk *pblk, struct nvm_rq *rqd, unsigned int sentry,
 	for (i = off; i < rqd->nr_ppas; i += min) {
 		map_secs = (i + min > valid_secs) ? (valid_secs % min) : min;
 		if (pblk_map_page_data(pblk, sentry + i, &rqd->ppa_list[i],
-					lun_bitmap, &meta_list[i], map_secs)) {
+					lun_bitmap,
+					pblk_get_meta_at(pblk, meta_list, i),
+					map_secs)) {
 			bio_put(rqd->bio);
 			pblk_free_rqd(pblk, rqd, PBLK_WRITE);
 			pblk_pipeline_stop(pblk);
@@ -111,7 +116,7 @@ void pblk_map_erase_rq(struct pblk *pblk, struct nvm_rq *rqd,
 	struct nvm_tgt_dev *dev = pblk->dev;
 	struct nvm_geo *geo = &dev->geo;
 	struct pblk_line_meta *lm = &pblk->lm;
-	struct pblk_sec_meta *meta_list = rqd->meta_list;
+	void *meta_list = rqd->meta_list;
 	struct pblk_line *e_line, *d_line;
 	unsigned int map_secs;
 	int min = pblk->min_write_pgs;
@@ -120,7 +125,9 @@ void pblk_map_erase_rq(struct pblk *pblk, struct nvm_rq *rqd,
 	for (i = 0; i < rqd->nr_ppas; i += min) {
 		map_secs = (i + min > valid_secs) ? (valid_secs % min) : min;
 		if (pblk_map_page_data(pblk, sentry + i, &rqd->ppa_list[i],
-					lun_bitmap, &meta_list[i], map_secs)) {
+					lun_bitmap,
+					pblk_get_meta_at(pblk, meta_list, i),
+					map_secs)) {
 			bio_put(rqd->bio);
 			pblk_free_rqd(pblk, rqd, PBLK_WRITE);
 			pblk_pipeline_stop(pblk);
diff --git a/drivers/lightnvm/pblk-read.c b/drivers/lightnvm/pblk-read.c
index 6e93c489ce57..81cf79ea2dc6 100644
--- a/drivers/lightnvm/pblk-read.c
+++ b/drivers/lightnvm/pblk-read.c
@@ -42,7 +42,7 @@ static void pblk_read_ppalist_rq(struct pblk *pblk, struct nvm_rq *rqd,
 				 struct bio *bio, sector_t blba,
 				 unsigned long *read_bitmap)
 {
-	struct pblk_sec_meta *meta_list = rqd->meta_list;
+	void *meta_list = rqd->meta_list;
 	struct ppa_addr ppas[PBLK_MAX_REQ_ADDRS];
 	int nr_secs = rqd->nr_ppas;
 	bool advanced_bio = false;
@@ -57,7 +57,8 @@ static void pblk_read_ppalist_rq(struct pblk *pblk, struct nvm_rq *rqd,
 retry:
 		if (pblk_ppa_empty(p)) {
 			WARN_ON(test_and_set_bit(i, read_bitmap));
-			meta_list[i].lba = cpu_to_le64(ADDR_EMPTY);
+			pblk_get_meta_at(pblk, meta_list, i)->lba =
+					cpu_to_le64(ADDR_EMPTY);
 
 			if (unlikely(!advanced_bio)) {
 				bio_advance(bio, (i) * PBLK_EXPOSED_PAGE_SIZE);
@@ -77,7 +78,8 @@ static void pblk_read_ppalist_rq(struct pblk *pblk, struct nvm_rq *rqd,
 				goto retry;
 			}
 			WARN_ON(test_and_set_bit(i, read_bitmap));
-			meta_list[i].lba = cpu_to_le64(lba);
+			pblk_get_meta_at(pblk, meta_list, i)->lba =
+					cpu_to_le64(lba);
 			advanced_bio = true;
 #ifdef CONFIG_NVM_PBLK_DEBUG
 			atomic_long_inc(&pblk->cache_reads);
@@ -106,13 +108,16 @@ static void pblk_read_ppalist_rq(struct pblk *pblk, struct nvm_rq *rqd,
 static void pblk_read_check_seq(struct pblk *pblk, struct nvm_rq *rqd,
 				sector_t blba)
 {
-	struct pblk_sec_meta *meta_lba_list = rqd->meta_list;
+	void *meta_lba_list = rqd->meta_list;
 	int nr_lbas = rqd->nr_ppas;
 	int i;
 
-	for (i = 0; i < nr_lbas; i++) {
-		u64 lba = le64_to_cpu(meta_lba_list[i].lba);
+	if (!pblk_is_oob_meta_supported(pblk))
+		return;
 
+	for (i = 0; i < nr_lbas; i++) {
+		u64 lba = le64_to_cpu(
+				pblk_get_meta_at(pblk, meta_lba_list, i)->lba);
 		if (lba == ADDR_EMPTY)
 			continue;
 
@@ -136,17 +141,21 @@ static void pblk_read_check_seq(struct pblk *pblk, struct nvm_rq *rqd,
 static void pblk_read_check_rand(struct pblk *pblk, struct nvm_rq *rqd,
 				 u64 *lba_list, int nr_lbas)
 {
-	struct pblk_sec_meta *meta_lba_list = rqd->meta_list;
+	void *meta_lba_list = rqd->meta_list;
 	int i, j;
 
-	for (i = 0, j = 0; i < nr_lbas; i++) {
+	if (!pblk_is_oob_meta_supported(pblk))
+		return;
+
+	for (i = 0; j = 0, i < nr_lbas; i++) {
 		u64 lba = lba_list[i];
 		u64 meta_lba;
 
 		if (lba == ADDR_EMPTY)
 			continue;
 
-		meta_lba = le64_to_cpu(meta_lba_list[j].lba);
+		meta_lba = le64_to_cpu(
+				pblk_get_meta_at(pblk, meta_lba_list, i)->lba);
 
 		if (lba != meta_lba) {
 #ifdef CONFIG_NVM_PBLK_DEBUG
@@ -235,7 +244,7 @@ static int pblk_partial_read(struct pblk *pblk, struct nvm_rq *rqd,
 			     struct bio *orig_bio, unsigned int bio_init_idx,
 			     unsigned long *read_bitmap)
 {
-	struct pblk_sec_meta *meta_list = rqd->meta_list;
+	void *meta_list = rqd->meta_list;
 	struct bio *new_bio;
 	struct bio_vec src_bv, dst_bv;
 	void *ppa_ptr = NULL;
@@ -261,7 +270,7 @@ static int pblk_partial_read(struct pblk *pblk, struct nvm_rq *rqd,
 	}
 
 	for (i = 0; i < nr_secs; i++)
-		lba_list_mem[i] = meta_list[i].lba;
+		lba_list_mem[i] = pblk_get_meta_at(pblk, meta_list, i)->lba;
 
 	new_bio->bi_iter.bi_sector = 0; /* internal bio */
 	bio_set_op_attrs(new_bio, REQ_OP_READ, 0);
@@ -300,8 +309,8 @@ static int pblk_partial_read(struct pblk *pblk, struct nvm_rq *rqd,
 	}
 
 	for (i = 0; i < nr_secs; i++) {
-		lba_list_media[i] = meta_list[i].lba;
-		meta_list[i].lba = lba_list_mem[i];
+		lba_list_media[i] = pblk_get_meta_at(pblk, meta_list, i)->lba;
+		pblk_get_meta_at(pblk, meta_list, i)->lba = lba_list_mem[i];
 	}
 
 	/* Fill the holes in the original bio */
@@ -313,7 +322,8 @@ static int pblk_partial_read(struct pblk *pblk, struct nvm_rq *rqd,
 
 		kref_put(&line->ref, pblk_line_put);
 
-		meta_list[hole].lba = lba_list_media[i];
+		pblk_get_meta_at(pblk, meta_list, hole)->lba =
+						lba_list_media[i];
 
 		src_bv = new_bio->bi_io_vec[i++];
 		dst_bv = orig_bio->bi_io_vec[bio_init_idx + hole];
@@ -354,7 +364,7 @@ static int pblk_partial_read(struct pblk *pblk, struct nvm_rq *rqd,
 static void pblk_read_rq(struct pblk *pblk, struct nvm_rq *rqd, struct bio *bio,
 			 sector_t lba, unsigned long *read_bitmap)
 {
-	struct pblk_sec_meta *meta_list = rqd->meta_list;
+	void *meta_list = rqd->meta_list;
 	struct ppa_addr ppa;
 
 	pblk_lookup_l2p_seq(pblk, &ppa, lba, 1);
@@ -366,7 +376,8 @@ static void pblk_read_rq(struct pblk *pblk, struct nvm_rq *rqd, struct bio *bio,
 retry:
 	if (pblk_ppa_empty(ppa)) {
 		WARN_ON(test_and_set_bit(0, read_bitmap));
-		meta_list[0].lba = cpu_to_le64(ADDR_EMPTY);
+		pblk_get_meta_at(pblk, meta_list, 0)->lba =
+						cpu_to_le64(ADDR_EMPTY);
 		return;
 	}
 
@@ -380,7 +391,7 @@ static void pblk_read_rq(struct pblk *pblk, struct nvm_rq *rqd, struct bio *bio,
 		}
 
 		WARN_ON(test_and_set_bit(0, read_bitmap));
-		meta_list[0].lba = cpu_to_le64(lba);
+		pblk_get_meta_at(pblk, meta_list, 0)->lba = cpu_to_le64(lba);
 
 #ifdef CONFIG_NVM_PBLK_DEBUG
 		atomic_long_inc(&pblk->cache_reads);
diff --git a/drivers/lightnvm/pblk-recovery.c b/drivers/lightnvm/pblk-recovery.c
index b1a91cb3ca4d..0007e8011476 100644
--- a/drivers/lightnvm/pblk-recovery.c
+++ b/drivers/lightnvm/pblk-recovery.c
@@ -98,7 +98,7 @@ static int pblk_calc_sec_in_line(struct pblk *pblk, struct pblk_line *line)
 
 struct pblk_recov_alloc {
 	struct ppa_addr *ppa_list;
-	struct pblk_sec_meta *meta_list;
+	void *meta_list;
 	struct nvm_rq *rqd;
 	void *data;
 	dma_addr_t dma_ppa_list;
@@ -111,7 +111,7 @@ static int pblk_recov_read_oob(struct pblk *pblk, struct pblk_line *line,
 	struct nvm_tgt_dev *dev = pblk->dev;
 	struct nvm_geo *geo = &dev->geo;
 	struct ppa_addr *ppa_list;
-	struct pblk_sec_meta *meta_list;
+	void *meta_list;
 	struct nvm_rq *rqd;
 	struct bio *bio;
 	void *data;
@@ -199,7 +199,8 @@ static int pblk_recov_read_oob(struct pblk *pblk, struct pblk_line *line,
 	}
 
 	for (i = 0; i < rqd->nr_ppas; i++) {
-		u64 lba = le64_to_cpu(meta_list[i].lba);
+		u64 lba = le64_to_cpu(pblk_get_meta_at(pblk,
+							meta_list, i)->lba);
 
 		if (lba == ADDR_EMPTY || lba > pblk->rl.nr_secs)
 			continue;
@@ -240,7 +241,7 @@ static int pblk_recov_pad_oob(struct pblk *pblk, struct pblk_line *line,
 	struct nvm_tgt_dev *dev = pblk->dev;
 	struct nvm_geo *geo = &dev->geo;
 	struct ppa_addr *ppa_list;
-	struct pblk_sec_meta *meta_list;
+	void *meta_list;
 	struct pblk_pad_rq *pad_rq;
 	struct nvm_rq *rqd;
 	struct bio *bio;
@@ -332,7 +333,8 @@ static int pblk_recov_pad_oob(struct pblk *pblk, struct pblk_line *line,
 			dev_ppa = addr_to_gen_ppa(pblk, w_ptr, line->id);
 
 			pblk_map_invalidate(pblk, dev_ppa);
-			lba_list[w_ptr] = meta_list[i].lba = addr_empty;
+			lba_list[w_ptr] = pblk_get_meta_at(pblk,
+						meta_list, i)->lba = addr_empty;
 			rqd->ppa_list[i] = dev_ppa;
 		}
 	}
@@ -389,7 +391,7 @@ static int pblk_recov_scan_all_oob(struct pblk *pblk, struct pblk_line *line,
 	struct nvm_tgt_dev *dev = pblk->dev;
 	struct nvm_geo *geo = &dev->geo;
 	struct ppa_addr *ppa_list;
-	struct pblk_sec_meta *meta_list;
+	void *meta_list;
 	struct nvm_rq *rqd;
 	struct bio *bio;
 	void *data;
@@ -473,7 +475,8 @@ static int pblk_recov_scan_all_oob(struct pblk *pblk, struct pblk_line *line,
 	if (!rec_round++ && !rqd->error) {
 		rec_round = 0;
 		for (i = 0; i < rqd->nr_ppas; i++, r_ptr++) {
-			u64 lba = le64_to_cpu(meta_list[i].lba);
+			u64 lba = le64_to_cpu(pblk_get_meta_at(pblk,
+							meta_list, i)->lba);
 
 			if (lba == ADDR_EMPTY || lba > pblk->rl.nr_secs)
 				continue;
@@ -523,7 +526,7 @@ static int pblk_recov_scan_oob(struct pblk *pblk, struct pblk_line *line,
 	struct nvm_tgt_dev *dev = pblk->dev;
 	struct nvm_geo *geo = &dev->geo;
 	struct ppa_addr *ppa_list;
-	struct pblk_sec_meta *meta_list;
+	void *meta_list;
 	struct nvm_rq *rqd;
 	struct bio *bio;
 	void *data;
@@ -619,7 +622,8 @@ static int pblk_recov_scan_oob(struct pblk *pblk, struct pblk_line *line,
 	}
 
 	for (i = 0; i < rqd->nr_ppas; i++) {
-		u64 lba = le64_to_cpu(meta_list[i].lba);
+		u64 lba = le64_to_cpu(pblk_get_meta_at(pblk,
+							meta_list, i)->lba);
 
 		if (lba == ADDR_EMPTY || lba > pblk->rl.nr_secs)
 			continue;
@@ -641,7 +645,7 @@ static int pblk_recov_l2p_from_oob(struct pblk *pblk, struct pblk_line *line)
 	struct nvm_geo *geo = &dev->geo;
 	struct nvm_rq *rqd;
 	struct ppa_addr *ppa_list;
-	struct pblk_sec_meta *meta_list;
+	void *meta_list;
 	struct pblk_recov_alloc p;
 	void *data;
 	dma_addr_t dma_ppa_list, dma_meta_list;
diff --git a/drivers/lightnvm/pblk.h b/drivers/lightnvm/pblk.h
index c072955d72c2..f82c3a0b0de5 100644
--- a/drivers/lightnvm/pblk.h
+++ b/drivers/lightnvm/pblk.h
@@ -1420,4 +1420,33 @@ static inline void pblk_setup_uuid(struct pblk *pblk)
 	uuid_le_gen(&uuid);
 	memcpy(pblk->instance_uuid, uuid.b, 16);
 }
+
+static inline int pblk_is_oob_meta_supported(struct pblk *pblk)
+{
+	struct nvm_tgt_dev *dev = pblk->dev;
+	struct nvm_geo *geo = &dev->geo;
+
+	/* Pblk uses OOB meta to store LBA of given physical sector.
+	 * The LBA is eventually used in recovery mode and/or for handling
+	 * telemetry events (e.g., relocate sector).
+	 */
+
+	return (geo->sos >= sizeof(struct pblk_sec_meta));
+}
+
+static inline struct pblk_sec_meta *pblk_get_meta_at(struct pblk *pblk,
+						void *meta_ptr, int index)
+{
+	struct nvm_tgt_dev *dev = pblk->dev;
+	struct nvm_geo *geo = &dev->geo;
+
+	if (pblk_is_oob_meta_supported(pblk))
+		/* We need to have oob meta layout the same as on drive */
+		return meta_ptr + geo->sos * index;
+	else
+		/* We can create virtual oob meta layout since drive does
+		 * not have real oob metadata
+		 */
+		return meta_ptr + sizeof(struct pblk_sec_meta) * index;
+}
 #endif /* PBLK_H_ */
-- 
2.14.3
