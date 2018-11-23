Return-Path: <SRS0=Lvn3=OC=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 762B2C43441
	for <linux-block@archiver.kernel.org>; Fri, 23 Nov 2018 15:50:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3DF08205C9
	for <linux-block@archiver.kernel.org>; Fri, 23 Nov 2018 15:50:56 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3DF08205C9
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-block-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391057AbeKXCfi (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 23 Nov 2018 21:35:38 -0500
Received: from mga11.intel.com ([192.55.52.93]:38778 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732448AbeKXCfi (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Fri, 23 Nov 2018 21:35:38 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmsmga102.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 23 Nov 2018 07:50:52 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.56,270,1539673200"; 
   d="scan'208";a="110944889"
Received: from gklab-106-154.igk.intel.com ([10.102.106.154])
  by orsmga002.jf.intel.com with ESMTP; 23 Nov 2018 07:50:49 -0800
From:   Igor Konopko <igor.j.konopko@intel.com>
To:     mb@lightnvm.io
Cc:     linux-block@vger.kernel.org, javier@cnexlabs.com,
        hans.holmberg@cnexlabs.com, igor.j.konopko@intel.com
Subject: [PATCH v3 2/5] lightnvm: pblk: Helpers for OOB metadata
Date:   Fri, 23 Nov 2018 16:45:35 +0100
Message-Id: <20181123154538.59748-3-igor.j.konopko@intel.com>
X-Mailer: git-send-email 2.14.5
In-Reply-To: <20181123154538.59748-1-igor.j.konopko@intel.com>
References: <20181123154538.59748-1-igor.j.konopko@intel.com>
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Currently pblk assumes that size of OOB metadata on drive is always
equal to size of pblk_sec_meta struct. This commit add helpers which will
allow to handle different sizes of OOB metadata on drive in the future.
Still, after this patch only OOB metadata equal to 16b is supported.

Signed-off-by: Igor Konopko <igor.j.konopko@intel.com>
---
 drivers/lightnvm/pblk-core.c     |  5 +++--
 drivers/lightnvm/pblk-init.c     |  6 ++++++
 drivers/lightnvm/pblk-map.c      | 21 +++++++++++++-------
 drivers/lightnvm/pblk-read.c     | 42 +++++++++++++++++++++++++---------------
 drivers/lightnvm/pblk-recovery.c | 13 +++++++------
 drivers/lightnvm/pblk.h          |  6 ++++++
 6 files changed, 62 insertions(+), 31 deletions(-)

diff --git a/drivers/lightnvm/pblk-core.c b/drivers/lightnvm/pblk-core.c
index 6581c35f51ee..9509d6dbed53 100644
--- a/drivers/lightnvm/pblk-core.c
+++ b/drivers/lightnvm/pblk-core.c
@@ -796,10 +796,11 @@ static int pblk_line_smeta_write(struct pblk *pblk, struct pblk_line *line,
 	rqd.is_seq = 1;
 
 	for (i = 0; i < lm->smeta_sec; i++, paddr++) {
-		struct pblk_sec_meta *meta_list = rqd.meta_list;
+		void *meta_list = rqd.meta_list;
 
 		rqd.ppa_list[i] = addr_to_gen_ppa(pblk, paddr, line->id);
-		meta_list[i].lba = lba_list[paddr] = addr_empty;
+		pblk_get_meta(pblk, meta_list, i)->lba = lba_list[paddr] =
+								addr_empty;
 	}
 
 	ret = pblk_submit_io_sync_sem(pblk, &rqd);
diff --git a/drivers/lightnvm/pblk-init.c b/drivers/lightnvm/pblk-init.c
index 0e37104de596..6e7a0c6c6655 100644
--- a/drivers/lightnvm/pblk-init.c
+++ b/drivers/lightnvm/pblk-init.c
@@ -409,6 +409,12 @@ static int pblk_core_init(struct pblk *pblk)
 		queue_max_hw_sectors(dev->q) / (geo->csecs >> SECTOR_SHIFT));
 	pblk_set_sec_per_write(pblk, pblk->min_write_pgs);
 
+	pblk->oob_meta_size = geo->sos;
+	if (pblk->oob_meta_size != sizeof(struct pblk_sec_meta)) {
+		pblk_err(pblk, "Unsupported metadata size\n");
+		return -EINVAL;
+	}
+
 	pblk->pad_dist = kcalloc(pblk->min_write_pgs - 1, sizeof(atomic64_t),
 								GFP_KERNEL);
 	if (!pblk->pad_dist)
diff --git a/drivers/lightnvm/pblk-map.c b/drivers/lightnvm/pblk-map.c
index 5a3c28cce8ab..0c6d962bad78 100644
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
@@ -74,14 +74,17 @@ static int pblk_map_page_data(struct pblk *pblk, unsigned int sentry,
 			kref_get(&line->ref);
 			w_ctx = pblk_rb_w_ctx(&pblk->rwb, sentry + i);
 			w_ctx->ppa = ppa_list[i];
-			meta_list[i].lba = cpu_to_le64(w_ctx->lba);
+			pblk_get_meta(pblk, meta_list, i)->lba =
+						cpu_to_le64(w_ctx->lba);
 			lba_list[paddr] = cpu_to_le64(w_ctx->lba);
 			if (lba_list[paddr] != addr_empty)
 				line->nr_valid_lbas++;
 			else
 				atomic64_inc(&pblk->pad_wa);
 		} else {
-			lba_list[paddr] = meta_list[i].lba = addr_empty;
+			lba_list[paddr] = addr_empty;
+			pblk_get_meta(pblk, meta_list, i)->lba =
+								addr_empty;
 			__pblk_map_invalidate(pblk, line, paddr);
 		}
 	}
@@ -94,7 +97,8 @@ int pblk_map_rq(struct pblk *pblk, struct nvm_rq *rqd, unsigned int sentry,
 		 unsigned long *lun_bitmap, unsigned int valid_secs,
 		 unsigned int off)
 {
-	struct pblk_sec_meta *meta_list = rqd->meta_list;
+	void *meta_list = rqd->meta_list;
+	void *meta_buffer;
 	struct ppa_addr *ppa_list = nvm_rq_to_ppa_list(rqd);
 	unsigned int map_secs;
 	int min = pblk->min_write_pgs;
@@ -103,9 +107,10 @@ int pblk_map_rq(struct pblk *pblk, struct nvm_rq *rqd, unsigned int sentry,
 
 	for (i = off; i < rqd->nr_ppas; i += min) {
 		map_secs = (i + min > valid_secs) ? (valid_secs % min) : min;
+		meta_buffer = pblk_get_meta(pblk, meta_list, i);
 
 		ret = pblk_map_page_data(pblk, sentry + i, &ppa_list[i],
-					lun_bitmap, &meta_list[i], map_secs);
+					lun_bitmap, meta_buffer, map_secs);
 		if (ret)
 			return ret;
 	}
@@ -121,7 +126,8 @@ int pblk_map_erase_rq(struct pblk *pblk, struct nvm_rq *rqd,
 	struct nvm_tgt_dev *dev = pblk->dev;
 	struct nvm_geo *geo = &dev->geo;
 	struct pblk_line_meta *lm = &pblk->lm;
-	struct pblk_sec_meta *meta_list = rqd->meta_list;
+	void *meta_list = rqd->meta_list;
+	void *meta_buffer;
 	struct ppa_addr *ppa_list = nvm_rq_to_ppa_list(rqd);
 	struct pblk_line *e_line, *d_line;
 	unsigned int map_secs;
@@ -132,9 +138,10 @@ int pblk_map_erase_rq(struct pblk *pblk, struct nvm_rq *rqd,
 
 	for (i = 0; i < rqd->nr_ppas; i += min) {
 		map_secs = (i + min > valid_secs) ? (valid_secs % min) : min;
+		meta_buffer = pblk_get_meta(pblk, meta_list, i);
 
 		ret = pblk_map_page_data(pblk, sentry + i, &ppa_list[i],
-					lun_bitmap, &meta_list[i], map_secs);
+					lun_bitmap, meta_buffer, map_secs);
 		if (ret)
 			return ret;
 
diff --git a/drivers/lightnvm/pblk-read.c b/drivers/lightnvm/pblk-read.c
index 19917d3c19b3..f13a7afd815f 100644
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
+			pblk_get_meta(pblk, meta_list, i)->lba = addr_empty;
 
 			if (unlikely(!advanced_bio)) {
 				bio_advance(bio, (i) * PBLK_EXPOSED_PAGE_SIZE);
@@ -78,7 +80,8 @@ static void pblk_read_ppalist_rq(struct pblk *pblk, struct nvm_rq *rqd,
 				goto retry;
 			}
 			WARN_ON(test_and_set_bit(i, read_bitmap));
-			meta_list[i].lba = cpu_to_le64(lba);
+			pblk_get_meta(pblk, meta_list, i)->lba =
+							cpu_to_le64(lba);
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
+		u64 lba = le64_to_cpu(pblk_get_meta(pblk, meta_list, i)->lba);
 
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
+		meta_lba = le64_to_cpu(pblk_get_meta(pblk,
+						     meta_lba_list, j)->lba);
 
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
+		pr_ctx->lba_list_media[i] = le64_to_cpu(pblk_get_meta(pblk,
+							meta_list, i)->lba);
+		pblk_get_meta(pblk, meta_list, i)->lba =
+					cpu_to_le64(pr_ctx->lba_list_mem[i]);
 	}
 
 	/* Fill the holes in the original bio */
@@ -250,7 +256,8 @@ static void pblk_end_partial_read(struct nvm_rq *rqd)
 		line = pblk_ppa_to_line(pblk, rqd->ppa_list[i]);
 		kref_put(&line->ref, pblk_line_put);
 
-		meta_list[hole].lba = pr_ctx->lba_list_media[i];
+		pblk_get_meta(pblk, meta_list, hole)->lba =
+					cpu_to_le64(pr_ctx->lba_list_media[i]);
 
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
@@ -308,7 +315,8 @@ static int pblk_setup_partial_read(struct pblk *pblk, struct nvm_rq *rqd,
 		goto fail_free_pages;
 
 	for (i = 0; i < nr_secs; i++)
-		pr_ctx->lba_list_mem[i] = meta_list[i].lba;
+		pr_ctx->lba_list_mem[i] = le64_to_cpu(pblk_get_meta(pblk,
+							meta_list, i)->lba);
 
 	new_bio->bi_iter.bi_sector = 0; /* internal bio */
 	bio_set_op_attrs(new_bio, REQ_OP_READ, 0);
@@ -373,7 +381,7 @@ static int pblk_partial_read_bio(struct pblk *pblk, struct nvm_rq *rqd,
 static void pblk_read_rq(struct pblk *pblk, struct nvm_rq *rqd, struct bio *bio,
 			 sector_t lba, unsigned long *read_bitmap)
 {
-	struct pblk_sec_meta *meta_list = rqd->meta_list;
+	void *meta_list = rqd->meta_list;
 	struct ppa_addr ppa;
 
 	pblk_lookup_l2p_seq(pblk, &ppa, lba, 1);
@@ -384,8 +392,10 @@ static void pblk_read_rq(struct pblk *pblk, struct nvm_rq *rqd, struct bio *bio,
 
 retry:
 	if (pblk_ppa_empty(ppa)) {
+		__le64 addr_empty = cpu_to_le64(ADDR_EMPTY);
+
 		WARN_ON(test_and_set_bit(0, read_bitmap));
-		meta_list[0].lba = cpu_to_le64(ADDR_EMPTY);
+		pblk_get_meta(pblk, meta_list, 0)->lba = addr_empty;
 		return;
 	}
 
@@ -399,7 +409,7 @@ static void pblk_read_rq(struct pblk *pblk, struct nvm_rq *rqd, struct bio *bio,
 		}
 
 		WARN_ON(test_and_set_bit(0, read_bitmap));
-		meta_list[0].lba = cpu_to_le64(lba);
+		pblk_get_meta(pblk, meta_list, 0)->lba = cpu_to_le64(lba);
 
 #ifdef CONFIG_NVM_PBLK_DEBUG
 		atomic_long_inc(&pblk->cache_reads);
diff --git a/drivers/lightnvm/pblk-recovery.c b/drivers/lightnvm/pblk-recovery.c
index 416d9840544b..902c54ab1318 100644
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
+			pblk_get_meta(pblk, meta_list, i)->lba = addr_empty;
 			rqd->ppa_list[i] = dev_ppa;
 		}
 	}
@@ -337,7 +338,7 @@ static int pblk_recov_scan_oob(struct pblk *pblk, struct pblk_line *line,
 	struct pblk_line_meta *lm = &pblk->lm;
 	struct nvm_geo *geo = &dev->geo;
 	struct ppa_addr *ppa_list;
-	struct pblk_sec_meta *meta_list;
+	void *meta_list;
 	struct nvm_rq *rqd;
 	struct bio *bio;
 	void *data;
@@ -435,7 +436,7 @@ static int pblk_recov_scan_oob(struct pblk *pblk, struct pblk_line *line,
 	}
 
 	for (i = 0; i < rqd->nr_ppas; i++) {
-		u64 lba = le64_to_cpu(meta_list[i].lba);
+		u64 lba = le64_to_cpu(pblk_get_meta(pblk, meta_list, i)->lba);
 
 		lba_list[paddr++] = cpu_to_le64(lba);
 
@@ -464,7 +465,7 @@ static int pblk_recov_l2p_from_oob(struct pblk *pblk, struct pblk_line *line)
 	struct nvm_geo *geo = &dev->geo;
 	struct nvm_rq *rqd;
 	struct ppa_addr *ppa_list;
-	struct pblk_sec_meta *meta_list;
+	void *meta_list;
 	struct pblk_recov_alloc p;
 	void *data;
 	dma_addr_t dma_ppa_list, dma_meta_list;
diff --git a/drivers/lightnvm/pblk.h b/drivers/lightnvm/pblk.h
index 0e9d3960ac4c..80f356688803 100644
--- a/drivers/lightnvm/pblk.h
+++ b/drivers/lightnvm/pblk.h
@@ -634,6 +634,7 @@ struct pblk {
 
 	int min_write_pgs; /* Minimum amount of pages required by controller */
 	int max_write_pgs; /* Maximum amount of pages supported by controller */
+	int oob_meta_size; /* Size of OOB sector metadata */
 
 	sector_t capacity; /* Device capacity when bad blocks are subtracted */
 
@@ -1380,6 +1381,11 @@ static inline unsigned int pblk_get_min_chks(struct pblk *pblk)
 	 */
 
 	return DIV_ROUND_UP(100, pblk->op) * lm->blk_per_line;
+}
 
+static inline struct pblk_sec_meta *pblk_get_meta(struct pblk *pblk,
+							 void *meta, int index)
+{
+	return meta + pblk->oob_meta_size * index;
 }
 #endif /* PBLK_H_ */
-- 
2.14.4

