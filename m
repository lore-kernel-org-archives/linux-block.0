Return-Path: <SRS0=Lvn3=OC=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 54673C43441
	for <linux-block@archiver.kernel.org>; Fri, 23 Nov 2018 15:51:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1E9E8205C9
	for <linux-block@archiver.kernel.org>; Fri, 23 Nov 2018 15:51:20 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1E9E8205C9
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-block-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391053AbeKXCgC (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 23 Nov 2018 21:36:02 -0500
Received: from mga11.intel.com ([192.55.52.93]:38790 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2391042AbeKXCgC (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Fri, 23 Nov 2018 21:36:02 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmsmga102.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 23 Nov 2018 07:51:04 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.56,270,1539673200"; 
   d="scan'208";a="110944927"
Received: from gklab-106-154.igk.intel.com ([10.102.106.154])
  by orsmga002.jf.intel.com with ESMTP; 23 Nov 2018 07:51:02 -0800
From:   Igor Konopko <igor.j.konopko@intel.com>
To:     mb@lightnvm.io
Cc:     linux-block@vger.kernel.org, javier@cnexlabs.com,
        hans.holmberg@cnexlabs.com, igor.j.konopko@intel.com
Subject: [PATCH v3 5/5] lightnvm: pblk: Support for packed metadata
Date:   Fri, 23 Nov 2018 16:45:38 +0100
Message-Id: <20181123154538.59748-6-igor.j.konopko@intel.com>
X-Mailer: git-send-email 2.14.5
In-Reply-To: <20181123154538.59748-1-igor.j.konopko@intel.com>
References: <20181123154538.59748-1-igor.j.konopko@intel.com>
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

In current pblk implementation, l2p mapping for not closed lines
is always stored only in OOB metadata and recovered from it.

Such a solution does not provide data integrity when drives does
not have such a OOB metadata space.

The goal of this patch is to add support for so called packed
metadata, which store l2p mapping for open lines in last sector
of every write unit.

After this set of changes, drives with OOB >0 and <16b are still
not supported.

Signed-off-by: Igor Konopko <igor.j.konopko@intel.com>
---
 drivers/lightnvm/pblk-core.c     | 53 +++++++++++++++++++++++++++++++++++++---
 drivers/lightnvm/pblk-init.c     | 37 +++++++++++++++++++++++++---
 drivers/lightnvm/pblk-rb.c       |  3 +++
 drivers/lightnvm/pblk-read.c     |  6 +++++
 drivers/lightnvm/pblk-recovery.c |  5 ++--
 drivers/lightnvm/pblk-sysfs.c    |  7 ++++++
 drivers/lightnvm/pblk-write.c    | 14 ++++++++---
 drivers/lightnvm/pblk.h          | 10 +++++++-
 8 files changed, 121 insertions(+), 14 deletions(-)

diff --git a/drivers/lightnvm/pblk-core.c b/drivers/lightnvm/pblk-core.c
index 2ebd3b079a96..615817bf97e3 100644
--- a/drivers/lightnvm/pblk-core.c
+++ b/drivers/lightnvm/pblk-core.c
@@ -376,7 +376,7 @@ void pblk_write_should_kick(struct pblk *pblk)
 {
 	unsigned int secs_avail = pblk_rb_read_count(&pblk->rwb);
 
-	if (secs_avail >= pblk->min_write_pgs)
+	if (secs_avail >= pblk->min_write_pgs_data)
 		pblk_write_kick(pblk);
 }
 
@@ -407,7 +407,9 @@ struct list_head *pblk_line_gc_list(struct pblk *pblk, struct pblk_line *line)
 	struct pblk_line_meta *lm = &pblk->lm;
 	struct pblk_line_mgmt *l_mg = &pblk->l_mg;
 	struct list_head *move_list = NULL;
-	int vsc = le32_to_cpu(*line->vsc);
+	int packed_meta = (le32_to_cpu(*line->vsc) / pblk->min_write_pgs_data)
+			* (pblk->min_write_pgs - pblk->min_write_pgs_data);
+	int vsc = le32_to_cpu(*line->vsc) + packed_meta;
 
 	lockdep_assert_held(&line->lock);
 
@@ -620,12 +622,15 @@ struct bio *pblk_bio_map_addr(struct pblk *pblk, void *data,
 }
 
 int pblk_calc_secs(struct pblk *pblk, unsigned long secs_avail,
-		   unsigned long secs_to_flush)
+		   unsigned long secs_to_flush, bool skip_meta)
 {
 	int max = pblk->sec_per_write;
 	int min = pblk->min_write_pgs;
 	int secs_to_sync = 0;
 
+	if (skip_meta && pblk->min_write_pgs_data != pblk->min_write_pgs)
+		min = max = pblk->min_write_pgs_data;
+
 	if (secs_avail >= max)
 		secs_to_sync = max;
 	else if (secs_avail >= min)
@@ -852,7 +857,7 @@ int pblk_line_emeta_read(struct pblk *pblk, struct pblk_line *line,
 next_rq:
 	memset(&rqd, 0, sizeof(struct nvm_rq));
 
-	rq_ppas = pblk_calc_secs(pblk, left_ppas, 0);
+	rq_ppas = pblk_calc_secs(pblk, left_ppas, 0, false);
 	rq_len = rq_ppas * geo->csecs;
 
 	bio = pblk_bio_map_addr(pblk, emeta_buf, rq_ppas, rq_len,
@@ -2161,3 +2166,43 @@ void pblk_lookup_l2p_rand(struct pblk *pblk, struct ppa_addr *ppas,
 	}
 	spin_unlock(&pblk->trans_lock);
 }
+
+void pblk_set_packed_meta(struct pblk *pblk, struct nvm_rq *rqd)
+{
+	void *meta_list = rqd->meta_list;
+	void *page;
+	int i = 0;
+
+	if (pblk_is_oob_meta_supported(pblk))
+		return;
+
+	/* We need to zero out metadata corresponding to packed meta page */
+	pblk_get_meta(pblk, meta_list, rqd->nr_ppas - 1)->lba =
+						cpu_to_le64(ADDR_EMPTY);
+
+	page = page_to_virt(rqd->bio->bi_io_vec[rqd->bio->bi_vcnt - 1].bv_page);
+	/* We need to fill last page of request (packed metadata)
+	 * with data from oob meta buffer.
+	 */
+	for (; i < rqd->nr_ppas; i++)
+		memcpy(page + (i * sizeof(struct pblk_sec_meta)),
+			pblk_get_meta(pblk, meta_list, i),
+			sizeof(struct pblk_sec_meta));
+}
+
+void pblk_get_packed_meta(struct pblk *pblk, struct nvm_rq *rqd)
+{
+	void *meta_list = rqd->meta_list;
+	void *page;
+	int i = 0;
+
+	if (pblk_is_oob_meta_supported(pblk))
+		return;
+
+	page = page_to_virt(rqd->bio->bi_io_vec[rqd->bio->bi_vcnt - 1].bv_page);
+	/* We need to fill oob meta buffer with data from packe metadata */
+	for (; i < rqd->nr_ppas; i++)
+		memcpy(pblk_get_meta(pblk, meta_list, i),
+			page + (i * sizeof(struct pblk_sec_meta)),
+			sizeof(struct pblk_sec_meta));
+}
diff --git a/drivers/lightnvm/pblk-init.c b/drivers/lightnvm/pblk-init.c
index a728f861edd6..5536338eea76 100644
--- a/drivers/lightnvm/pblk-init.c
+++ b/drivers/lightnvm/pblk-init.c
@@ -403,6 +403,7 @@ static int pblk_core_init(struct pblk *pblk)
 	pblk->nr_flush_rst = 0;
 
 	pblk->min_write_pgs = geo->ws_opt;
+	pblk->min_write_pgs_data = pblk->min_write_pgs;
 	max_write_ppas = pblk->min_write_pgs * geo->all_luns;
 	pblk->max_write_pgs = min_t(int, max_write_ppas, NVM_MAX_VLBA);
 	pblk->max_write_pgs = min_t(int, pblk->max_write_pgs,
@@ -410,7 +411,36 @@ static int pblk_core_init(struct pblk *pblk)
 	pblk_set_sec_per_write(pblk, pblk->min_write_pgs);
 
 	pblk->oob_meta_size = geo->sos;
-	if (pblk->oob_meta_size < sizeof(struct pblk_sec_meta)) {
+	if (!pblk_is_oob_meta_supported(pblk)) {
+		/* For drives which does not have OOB metadata feature
+		 * in order to support recovery feature we need to use
+		 * so called packed metadata. Packed metada will store
+		 * the same information as OOB metadata (l2p table mapping,
+		 * but in the form of the single page at the end of
+		 * every write request.
+		 */
+		if (pblk->min_write_pgs
+			* sizeof(struct pblk_sec_meta) > PAGE_SIZE) {
+			/* We want to keep all the packed metadata on single
+			 * page per write requests. So we need to ensure that
+			 * it will fit.
+			 *
+			 * This is more like sanity check, since there is
+			 * no device with such a big minimal write size
+			 * (above 1 metabytes).
+			 */
+			pblk_err(pblk, "Not supported min write size\n");
+			return -EINVAL;
+		}
+		/* For packed meta approach we do some simplification.
+		 * On read path we always issue requests which size
+		 * equal to max_write_pgs, with all pages filled with
+		 * user payload except of last one page which will be
+		 * filled with packed metadata.
+		 */
+		pblk->max_write_pgs = pblk->min_write_pgs;
+		pblk->min_write_pgs_data = pblk->min_write_pgs - 1;
+	} else if (pblk->oob_meta_size < sizeof(struct pblk_sec_meta)) {
 		pblk_err(pblk, "Unsupported metadata size\n");
 		return -EINVAL;
 	}
@@ -645,7 +675,7 @@ static int pblk_set_provision(struct pblk *pblk, int nr_free_chks)
 	struct pblk_line_meta *lm = &pblk->lm;
 	struct nvm_geo *geo = &dev->geo;
 	sector_t provisioned;
-	int sec_meta, blk_meta;
+	int sec_meta, blk_meta, clba;
 	int minimum;
 
 	if (geo->op == NVM_TARGET_DEFAULT_OP)
@@ -686,7 +716,8 @@ static int pblk_set_provision(struct pblk *pblk, int nr_free_chks)
 	sec_meta = (lm->smeta_sec + lm->emeta_sec[0]) * l_mg->nr_free_lines;
 	blk_meta = DIV_ROUND_UP(sec_meta, geo->clba);
 
-	pblk->capacity = (provisioned - blk_meta) * geo->clba;
+	clba = (geo->clba / pblk->min_write_pgs) * pblk->min_write_pgs_data;
+	pblk->capacity = (provisioned - blk_meta) * clba;
 
 	atomic_set(&pblk->rl.free_blocks, nr_free_chks);
 	atomic_set(&pblk->rl.free_user_blocks, nr_free_chks);
diff --git a/drivers/lightnvm/pblk-rb.c b/drivers/lightnvm/pblk-rb.c
index 9f7fa0fe9c77..d4ca8c64ee0f 100644
--- a/drivers/lightnvm/pblk-rb.c
+++ b/drivers/lightnvm/pblk-rb.c
@@ -552,6 +552,9 @@ unsigned int pblk_rb_read_to_bio(struct pblk_rb *rb, struct nvm_rq *rqd,
 		to_read = count;
 	}
 
+	/* Add space for packed metadata if in use*/
+	pad += (pblk->min_write_pgs - pblk->min_write_pgs_data);
+
 	c_ctx->sentry = pos;
 	c_ctx->nr_valid = to_read;
 	c_ctx->nr_padded = pad;
diff --git a/drivers/lightnvm/pblk-read.c b/drivers/lightnvm/pblk-read.c
index f13a7afd815f..32b285cf5846 100644
--- a/drivers/lightnvm/pblk-read.c
+++ b/drivers/lightnvm/pblk-read.c
@@ -112,6 +112,9 @@ static void pblk_read_check_seq(struct pblk *pblk, struct nvm_rq *rqd,
 	int nr_lbas = rqd->nr_ppas;
 	int i;
 
+	if (!pblk_is_oob_meta_supported(pblk))
+		return;
+
 	for (i = 0; i < nr_lbas; i++) {
 		u64 lba = le64_to_cpu(pblk_get_meta(pblk, meta_list, i)->lba);
 
@@ -140,6 +143,9 @@ static void pblk_read_check_rand(struct pblk *pblk, struct nvm_rq *rqd,
 	void *meta_lba_list = rqd->meta_list;
 	int i, j;
 
+	if (!pblk_is_oob_meta_supported(pblk))
+		return;
+
 	for (i = 0, j = 0; i < nr_lbas; i++) {
 		u64 lba = lba_list[i];
 		u64 meta_lba;
diff --git a/drivers/lightnvm/pblk-recovery.c b/drivers/lightnvm/pblk-recovery.c
index 5bb8a2a4f87b..65abc043e268 100644
--- a/drivers/lightnvm/pblk-recovery.c
+++ b/drivers/lightnvm/pblk-recovery.c
@@ -188,7 +188,7 @@ static int pblk_recov_pad_line(struct pblk *pblk, struct pblk_line *line,
 	kref_init(&pad_rq->ref);
 
 next_pad_rq:
-	rq_ppas = pblk_calc_secs(pblk, left_ppas, 0);
+	rq_ppas = pblk_calc_secs(pblk, left_ppas, 0, false);
 	if (rq_ppas < pblk->min_write_pgs) {
 		pblk_err(pblk, "corrupted pad line %d\n", line->id);
 		goto fail_free_pad;
@@ -366,7 +366,7 @@ static int pblk_recov_scan_oob(struct pblk *pblk, struct pblk_line *line,
 next_rq:
 	memset(rqd, 0, pblk_g_rq_size);
 
-	rq_ppas = pblk_calc_secs(pblk, left_ppas, 0);
+	rq_ppas = pblk_calc_secs(pblk, left_ppas, 0, false);
 	if (!rq_ppas)
 		rq_ppas = pblk->min_write_pgs;
 	rq_len = rq_ppas * geo->csecs;
@@ -435,6 +435,7 @@ static int pblk_recov_scan_oob(struct pblk *pblk, struct pblk_line *line,
 		goto retry_rq;
 	}
 
+	pblk_get_packed_meta(pblk, rqd);
 	for (i = 0; i < rqd->nr_ppas; i++) {
 		u64 lba = le64_to_cpu(pblk_get_meta(pblk, meta_list, i)->lba);
 
diff --git a/drivers/lightnvm/pblk-sysfs.c b/drivers/lightnvm/pblk-sysfs.c
index 2d2818155aa8..7d8958df9472 100644
--- a/drivers/lightnvm/pblk-sysfs.c
+++ b/drivers/lightnvm/pblk-sysfs.c
@@ -479,6 +479,13 @@ static ssize_t pblk_sysfs_set_sec_per_write(struct pblk *pblk,
 	if (kstrtouint(page, 0, &sec_per_write))
 		return -EINVAL;
 
+	if (!pblk_is_oob_meta_supported(pblk)) {
+		/* For packed metadata case it is
+		 * not allowed to change sec_per_write.
+		 */
+		return -EINVAL;
+	}
+
 	if (sec_per_write < pblk->min_write_pgs
 				|| sec_per_write > pblk->max_write_pgs
 				|| sec_per_write % pblk->min_write_pgs != 0)
diff --git a/drivers/lightnvm/pblk-write.c b/drivers/lightnvm/pblk-write.c
index 2bf78f81862d..dc8c598c0b6f 100644
--- a/drivers/lightnvm/pblk-write.c
+++ b/drivers/lightnvm/pblk-write.c
@@ -348,7 +348,7 @@ static int pblk_calc_secs_to_sync(struct pblk *pblk, unsigned int secs_avail,
 {
 	int secs_to_sync;
 
-	secs_to_sync = pblk_calc_secs(pblk, secs_avail, secs_to_flush);
+	secs_to_sync = pblk_calc_secs(pblk, secs_avail, secs_to_flush, true);
 
 #ifdef CONFIG_NVM_PBLK_DEBUG
 	if ((!secs_to_sync && secs_to_flush)
@@ -518,6 +518,11 @@ static int pblk_submit_io_set(struct pblk *pblk, struct nvm_rq *rqd)
 		return NVM_IO_ERR;
 	}
 
+	/* This is the first place when we have write requests mapped
+	 * and we can fill packed metadata with l2p mappings.
+	 */
+	pblk_set_packed_meta(pblk, rqd);
+
 	meta_line = pblk_should_submit_meta_io(pblk, rqd);
 
 	/* Submit data write for current data line */
@@ -569,7 +574,7 @@ static int pblk_submit_write(struct pblk *pblk, int *secs_left)
 	struct bio *bio;
 	struct nvm_rq *rqd;
 	unsigned int secs_avail, secs_to_sync, secs_to_com;
-	unsigned int secs_to_flush;
+	unsigned int secs_to_flush, packed_meta_pgs;
 	unsigned long pos;
 	unsigned int resubmit;
 
@@ -607,7 +612,7 @@ static int pblk_submit_write(struct pblk *pblk, int *secs_left)
 			return 0;
 
 		secs_to_flush = pblk_rb_flush_point_count(&pblk->rwb);
-		if (!secs_to_flush && secs_avail < pblk->min_write_pgs)
+		if (!secs_to_flush && secs_avail < pblk->min_write_pgs_data)
 			return 0;
 
 		secs_to_sync = pblk_calc_secs_to_sync(pblk, secs_avail,
@@ -622,7 +627,8 @@ static int pblk_submit_write(struct pblk *pblk, int *secs_left)
 		pos = pblk_rb_read_commit(&pblk->rwb, secs_to_com);
 	}
 
-	bio = bio_alloc(GFP_KERNEL, secs_to_sync);
+	packed_meta_pgs = (pblk->min_write_pgs - pblk->min_write_pgs_data);
+	bio = bio_alloc(GFP_KERNEL, secs_to_sync + packed_meta_pgs);
 
 	bio->bi_iter.bi_sector = 0; /* internal bio */
 	bio_set_op_attrs(bio, REQ_OP_WRITE, 0);
diff --git a/drivers/lightnvm/pblk.h b/drivers/lightnvm/pblk.h
index 9087d53d5c25..dc99949980a6 100644
--- a/drivers/lightnvm/pblk.h
+++ b/drivers/lightnvm/pblk.h
@@ -632,6 +632,7 @@ struct pblk {
 	int state;			/* pblk line state */
 
 	int min_write_pgs; /* Minimum amount of pages required by controller */
+	int min_write_pgs_data; /* Minimum amount of payload pages */
 	int max_write_pgs; /* Maximum amount of pages supported by controller */
 	int oob_meta_size; /* Size of OOB sector metadata */
 
@@ -838,7 +839,7 @@ void pblk_dealloc_page(struct pblk *pblk, struct pblk_line *line, int nr_secs);
 u64 pblk_alloc_page(struct pblk *pblk, struct pblk_line *line, int nr_secs);
 u64 __pblk_alloc_page(struct pblk *pblk, struct pblk_line *line, int nr_secs);
 int pblk_calc_secs(struct pblk *pblk, unsigned long secs_avail,
-		   unsigned long secs_to_flush);
+		   unsigned long secs_to_flush, bool skip_meta);
 void pblk_down_rq(struct pblk *pblk, struct ppa_addr ppa,
 		  unsigned long *lun_bitmap);
 void pblk_down_chunk(struct pblk *pblk, struct ppa_addr ppa);
@@ -862,6 +863,8 @@ void pblk_lookup_l2p_rand(struct pblk *pblk, struct ppa_addr *ppas,
 			  u64 *lba_list, int nr_secs);
 void pblk_lookup_l2p_seq(struct pblk *pblk, struct ppa_addr *ppas,
 			 sector_t blba, int nr_secs);
+void pblk_set_packed_meta(struct pblk *pblk, struct nvm_rq *rqd);
+void pblk_get_packed_meta(struct pblk *pblk, struct nvm_rq *rqd);
 
 /*
  * pblk user I/O write path
@@ -1392,4 +1395,9 @@ static inline int pblk_dma_meta_size(struct pblk *pblk)
 {
 	return pblk->oob_meta_size * NVM_MAX_VLBA;
 }
+
+static inline int pblk_is_oob_meta_supported(struct pblk *pblk)
+{
+	return pblk->oob_meta_size > 0;
+}
 #endif /* PBLK_H_ */
-- 
2.14.4

