Return-Path: <SRS0=iCYb=RZ=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 33106C43381
	for <linux-block@archiver.kernel.org>; Fri, 22 Mar 2019 14:51:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0228B20883
	for <linux-block@archiver.kernel.org>; Fri, 22 Mar 2019 14:51:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728450AbfCVOvw (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 22 Mar 2019 10:51:52 -0400
Received: from mga01.intel.com ([192.55.52.88]:1145 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728072AbfCVOvw (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Fri, 22 Mar 2019 10:51:52 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga101.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 22 Mar 2019 07:51:44 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.60,256,1549958400"; 
   d="scan'208";a="216593208"
Received: from gklab-107-059.igk.intel.com ([10.102.107.59])
  by orsmga001.jf.intel.com with ESMTP; 22 Mar 2019 07:51:42 -0700
From:   Igor Konopko <igor.j.konopko@intel.com>
To:     mb@lightnvm.io, javier@javigon.com, hans.holmberg@cnexlabs.com
Cc:     linux-block@vger.kernel.org, igor.j.konopko@intel.com
Subject: [PATCH v2 03/16] lightnvm: pblk: simplify partial read path
Date:   Fri, 22 Mar 2019 15:48:30 +0100
Message-Id: <20190322144843.9602-4-igor.j.konopko@intel.com>
X-Mailer: git-send-email 2.9.5
In-Reply-To: <20190322144843.9602-1-igor.j.konopko@intel.com>
References: <20190322144843.9602-1-igor.j.konopko@intel.com>
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

This patch changes the approach to handling partial read path, what is
needed for supporting multi-page bvec, which is currently broken.

In old approach merging of data from round buffer and drive was fully
made by drive. This had some disadvantages - code was complex and
relies on bio internals, so it was hard to maintain and was strongly
dependent on bio changes.

In new approach most of the handling is done mostly by block layer
functions such as bio_split(), bio_chain() and generic_make request()
and generally is less complex and easier to maintain. Below some more
details of the new approach.

When read bio arrives, it is cloned for pblk internal purposes. All
the L2P mapping, which includes copying data from round buffer to bio
and thus bio_advance() calls is done on the cloned bio, so the original
bio is untouched. Later if we found that we have partial read case, we
still have original bio untouched, so we can split it and continue to
process only first 4K of it in current context, when the rest will be
called as separate bio request which is passed to generic_make_request()
for further processing.

Signed-off-by: Igor Konopko <igor.j.konopko@intel.com>
---
 drivers/lightnvm/pblk-core.c |  16 +++
 drivers/lightnvm/pblk-read.c | 276 +++++++++++--------------------------------
 drivers/lightnvm/pblk.h      |  22 ++--
 3 files changed, 97 insertions(+), 217 deletions(-)

diff --git a/drivers/lightnvm/pblk-core.c b/drivers/lightnvm/pblk-core.c
index 39280c1..f2edec6 100644
--- a/drivers/lightnvm/pblk-core.c
+++ b/drivers/lightnvm/pblk-core.c
@@ -1529,6 +1529,22 @@ void pblk_rq_to_line_put(struct pblk *pblk, struct nvm_rq *rqd)
 		pblk_ppa_to_line_put(pblk, ppa_list[i]);
 }
 
+void pblk_rq_to_line_partial_put(struct pblk *pblk, struct nvm_rq *rqd,
+					int offset)
+{
+	struct ppa_addr ppa;
+	struct pblk_line *line;
+	int i = offset;
+
+	for (; i < rqd->nr_ppas; i++) {
+		ppa = rqd->ppa_list[i];
+		if (!pblk_ppa_empty(ppa) && !pblk_addr_in_cache(ppa)) {
+			line = pblk_ppa_to_line(pblk, ppa);
+			kref_put(&line->ref, pblk_line_put);
+		}
+	}
+}
+
 static void pblk_stop_writes(struct pblk *pblk, struct pblk_line *line)
 {
 	lockdep_assert_held(&pblk->l_mg.free_lock);
diff --git a/drivers/lightnvm/pblk-read.c b/drivers/lightnvm/pblk-read.c
index 597fe6d..264d1d7 100644
--- a/drivers/lightnvm/pblk-read.c
+++ b/drivers/lightnvm/pblk-read.c
@@ -41,28 +41,30 @@ static int pblk_read_from_cache(struct pblk *pblk, struct bio *bio,
 
 static void pblk_read_ppalist_rq(struct pblk *pblk, struct nvm_rq *rqd,
 				 struct bio *bio, sector_t blba,
-				 unsigned long *read_bitmap)
+				 struct pblk_read_info *info)
 {
 	void *meta_list = rqd->meta_list;
-	struct ppa_addr ppas[NVM_MAX_VLBA];
 	int nr_secs = rqd->nr_ppas;
 	bool advanced_bio = false;
-	int i, j = 0;
+	int i;
 
-	pblk_lookup_l2p_seq(pblk, ppas, blba, nr_secs);
+	pblk_lookup_l2p_seq(pblk, rqd->ppa_list, blba, nr_secs);
+	info->first_sec_from_cache = nr_secs;
+	info->first_sec_from_drive = nr_secs;
 
 	for (i = 0; i < nr_secs; i++) {
-		struct ppa_addr p = ppas[i];
 		struct pblk_sec_meta *meta = pblk_get_meta(pblk, meta_list, i);
 		sector_t lba = blba + i;
 
 retry:
-		if (pblk_ppa_empty(p)) {
+		if (pblk_ppa_empty(rqd->ppa_list[i])) {
 			__le64 addr_empty = cpu_to_le64(ADDR_EMPTY);
 
-			WARN_ON(test_and_set_bit(i, read_bitmap));
-			meta->lba = addr_empty;
+			info->secs_from_cache = true;
+			info->first_sec_from_cache = min_t(int, i,
+						info->first_sec_from_cache);
 
+			meta->lba = addr_empty;
 			if (unlikely(!advanced_bio)) {
 				bio_advance(bio, (i) * PBLK_EXPOSED_PAGE_SIZE);
 				advanced_bio = true;
@@ -74,13 +76,18 @@ static void pblk_read_ppalist_rq(struct pblk *pblk, struct nvm_rq *rqd,
 		/* Try to read from write buffer. The address is later checked
 		 * on the write buffer to prevent retrieving overwritten data.
 		 */
-		if (pblk_addr_in_cache(p)) {
-			if (!pblk_read_from_cache(pblk, bio, lba, p, i,
-								advanced_bio)) {
-				pblk_lookup_l2p_seq(pblk, &p, lba, 1);
+		if (pblk_addr_in_cache(rqd->ppa_list[i])) {
+			if (!pblk_read_from_cache(pblk, bio, lba,
+					rqd->ppa_list[i], i, advanced_bio)) {
+				pblk_lookup_l2p_seq(pblk, &rqd->ppa_list[i],
+							lba, 1);
 				goto retry;
 			}
-			WARN_ON(test_and_set_bit(i, read_bitmap));
+
+			info->secs_from_cache = true;
+			info->first_sec_from_cache = min_t(int, i,
+						info->first_sec_from_cache);
+
 			meta->lba = cpu_to_le64(lba);
 			advanced_bio = true;
 #ifdef CONFIG_NVM_PBLK_DEBUG
@@ -88,7 +95,9 @@ static void pblk_read_ppalist_rq(struct pblk *pblk, struct nvm_rq *rqd,
 #endif
 		} else {
 			/* Read from media non-cached sectors */
-			rqd->ppa_list[j++] = p;
+			info->secs_from_drive = true;
+			info->first_sec_from_drive = min_t(int, i,
+						info->first_sec_from_drive);
 		}
 
 next:
@@ -223,172 +232,8 @@ static void pblk_end_io_read(struct nvm_rq *rqd)
 	__pblk_end_io_read(pblk, rqd, true);
 }
 
-static void pblk_end_partial_read(struct nvm_rq *rqd)
-{
-	struct pblk *pblk = rqd->private;
-	struct pblk_g_ctx *r_ctx = nvm_rq_to_pdu(rqd);
-	struct pblk_pr_ctx *pr_ctx = r_ctx->private;
-	struct pblk_sec_meta *meta;
-	struct bio *new_bio = rqd->bio;
-	struct bio *bio = pr_ctx->orig_bio;
-	struct bio_vec src_bv, dst_bv;
-	void *meta_list = rqd->meta_list;
-	int bio_init_idx = pr_ctx->bio_init_idx;
-	unsigned long *read_bitmap = pr_ctx->bitmap;
-	int nr_secs = pr_ctx->orig_nr_secs;
-	int nr_holes = nr_secs - bitmap_weight(read_bitmap, nr_secs);
-	void *src_p, *dst_p;
-	int hole, i;
-
-	if (unlikely(nr_holes == 1)) {
-		struct ppa_addr ppa;
-
-		ppa = rqd->ppa_addr;
-		rqd->ppa_list = pr_ctx->ppa_ptr;
-		rqd->dma_ppa_list = pr_ctx->dma_ppa_list;
-		rqd->ppa_list[0] = ppa;
-	}
-
-	for (i = 0; i < nr_secs; i++) {
-		meta = pblk_get_meta(pblk, meta_list, i);
-		pr_ctx->lba_list_media[i] = le64_to_cpu(meta->lba);
-		meta->lba = cpu_to_le64(pr_ctx->lba_list_mem[i]);
-	}
-
-	/* Fill the holes in the original bio */
-	i = 0;
-	hole = find_first_zero_bit(read_bitmap, nr_secs);
-	do {
-		struct pblk_line *line;
-
-		line = pblk_ppa_to_line(pblk, rqd->ppa_list[i]);
-		kref_put(&line->ref, pblk_line_put);
-
-		meta = pblk_get_meta(pblk, meta_list, hole);
-		meta->lba = cpu_to_le64(pr_ctx->lba_list_media[i]);
-
-		src_bv = new_bio->bi_io_vec[i++];
-		dst_bv = bio->bi_io_vec[bio_init_idx + hole];
-
-		src_p = kmap_atomic(src_bv.bv_page);
-		dst_p = kmap_atomic(dst_bv.bv_page);
-
-		memcpy(dst_p + dst_bv.bv_offset,
-			src_p + src_bv.bv_offset,
-			PBLK_EXPOSED_PAGE_SIZE);
-
-		kunmap_atomic(src_p);
-		kunmap_atomic(dst_p);
-
-		mempool_free(src_bv.bv_page, &pblk->page_bio_pool);
-
-		hole = find_next_zero_bit(read_bitmap, nr_secs, hole + 1);
-	} while (hole < nr_secs);
-
-	bio_put(new_bio);
-	kfree(pr_ctx);
-
-	/* restore original request */
-	rqd->bio = NULL;
-	rqd->nr_ppas = nr_secs;
-
-	pblk_end_user_read(bio, rqd->error);
-	__pblk_end_io_read(pblk, rqd, false);
-}
-
-static int pblk_setup_partial_read(struct pblk *pblk, struct nvm_rq *rqd,
-			    unsigned int bio_init_idx,
-			    unsigned long *read_bitmap,
-			    int nr_holes)
-{
-	void *meta_list = rqd->meta_list;
-	struct pblk_g_ctx *r_ctx = nvm_rq_to_pdu(rqd);
-	struct pblk_pr_ctx *pr_ctx;
-	struct bio *new_bio, *bio = r_ctx->private;
-	int nr_secs = rqd->nr_ppas;
-	int i;
-
-	new_bio = bio_alloc(GFP_KERNEL, nr_holes);
-
-	if (pblk_bio_add_pages(pblk, new_bio, GFP_KERNEL, nr_holes))
-		goto fail_bio_put;
-
-	if (nr_holes != new_bio->bi_vcnt) {
-		WARN_ONCE(1, "pblk: malformed bio\n");
-		goto fail_free_pages;
-	}
-
-	pr_ctx = kzalloc(sizeof(struct pblk_pr_ctx), GFP_KERNEL);
-	if (!pr_ctx)
-		goto fail_free_pages;
-
-	for (i = 0; i < nr_secs; i++) {
-		struct pblk_sec_meta *meta = pblk_get_meta(pblk, meta_list, i);
-
-		pr_ctx->lba_list_mem[i] = le64_to_cpu(meta->lba);
-	}
-
-	new_bio->bi_iter.bi_sector = 0; /* internal bio */
-	bio_set_op_attrs(new_bio, REQ_OP_READ, 0);
-
-	rqd->bio = new_bio;
-	rqd->nr_ppas = nr_holes;
-
-	pr_ctx->orig_bio = bio;
-	bitmap_copy(pr_ctx->bitmap, read_bitmap, NVM_MAX_VLBA);
-	pr_ctx->bio_init_idx = bio_init_idx;
-	pr_ctx->orig_nr_secs = nr_secs;
-	r_ctx->private = pr_ctx;
-
-	if (unlikely(nr_holes == 1)) {
-		pr_ctx->ppa_ptr = rqd->ppa_list;
-		pr_ctx->dma_ppa_list = rqd->dma_ppa_list;
-		rqd->ppa_addr = rqd->ppa_list[0];
-	}
-	return 0;
-
-fail_free_pages:
-	pblk_bio_free_pages(pblk, new_bio, 0, new_bio->bi_vcnt);
-fail_bio_put:
-	bio_put(new_bio);
-
-	return -ENOMEM;
-}
-
-static int pblk_partial_read_bio(struct pblk *pblk, struct nvm_rq *rqd,
-				 unsigned int bio_init_idx,
-				 unsigned long *read_bitmap, int nr_secs)
-{
-	int nr_holes;
-	int ret;
-
-	nr_holes = nr_secs - bitmap_weight(read_bitmap, nr_secs);
-
-	if (pblk_setup_partial_read(pblk, rqd, bio_init_idx, read_bitmap,
-				    nr_holes))
-		return NVM_IO_ERR;
-
-	rqd->end_io = pblk_end_partial_read;
-
-	ret = pblk_submit_io(pblk, rqd);
-	if (ret) {
-		bio_put(rqd->bio);
-		pblk_err(pblk, "partial read IO submission failed\n");
-		goto err;
-	}
-
-	return NVM_IO_OK;
-
-err:
-	pblk_err(pblk, "failed to perform partial read\n");
-
-	/* Free allocated pages in new bio */
-	pblk_bio_free_pages(pblk, rqd->bio, 0, rqd->bio->bi_vcnt);
-	return NVM_IO_ERR;
-}
-
 static void pblk_read_rq(struct pblk *pblk, struct nvm_rq *rqd, struct bio *bio,
-			 sector_t lba, unsigned long *read_bitmap)
+			 sector_t lba, struct pblk_read_info *info)
 {
 	struct pblk_sec_meta *meta = pblk_get_meta(pblk, rqd->meta_list, 0);
 	struct ppa_addr ppa;
@@ -403,8 +248,8 @@ static void pblk_read_rq(struct pblk *pblk, struct nvm_rq *rqd, struct bio *bio,
 	if (pblk_ppa_empty(ppa)) {
 		__le64 addr_empty = cpu_to_le64(ADDR_EMPTY);
 
-		WARN_ON(test_and_set_bit(0, read_bitmap));
 		meta->lba = addr_empty;
+		info->secs_from_cache = true;
 		return;
 	}
 
@@ -417,14 +262,14 @@ static void pblk_read_rq(struct pblk *pblk, struct nvm_rq *rqd, struct bio *bio,
 			goto retry;
 		}
 
-		WARN_ON(test_and_set_bit(0, read_bitmap));
 		meta->lba = cpu_to_le64(lba);
-
+		info->secs_from_cache = true;
 #ifdef CONFIG_NVM_PBLK_DEBUG
 		atomic_long_inc(&pblk->cache_reads);
 #endif
 	} else {
 		rqd->ppa_addr = ppa;
+		info->secs_from_drive = true;
 	}
 }
 
@@ -436,15 +281,12 @@ void pblk_submit_read(struct pblk *pblk, struct bio *bio)
 	unsigned int nr_secs = pblk_get_secs(bio);
 	struct pblk_g_ctx *r_ctx;
 	struct nvm_rq *rqd;
-	struct bio *int_bio;
-	unsigned int bio_init_idx;
-	DECLARE_BITMAP(read_bitmap, NVM_MAX_VLBA);
+	struct bio *int_bio, *split_bio;
+	struct pblk_read_info info = {0};
 
 	generic_start_io_acct(q, REQ_OP_READ, bio_sectors(bio),
 			      &pblk->disk->part0);
 
-	bitmap_zero(read_bitmap, nr_secs);
-
 	rqd = pblk_alloc_rqd(pblk, PBLK_READ);
 
 	rqd->opcode = NVM_OP_PREAD;
@@ -456,11 +298,6 @@ void pblk_submit_read(struct pblk *pblk, struct bio *bio)
 	r_ctx->start_time = jiffies;
 	r_ctx->lba = blba;
 
-	/* Save the index for this bio's start. This is needed in case
-	 * we need to fill a partial read.
-	 */
-	bio_init_idx = pblk_get_bi_idx(bio);
-
 	if (pblk_alloc_rqd_meta(pblk, rqd)) {
 		bio_io_error(bio);
 		pblk_free_rqd(pblk, rqd, PBLK_READ);
@@ -474,34 +311,63 @@ void pblk_submit_read(struct pblk *pblk, struct bio *bio)
 	int_bio = bio_clone_fast(bio, GFP_KERNEL, &pblk_bio_set);
 
 	if (nr_secs > 1)
-		pblk_read_ppalist_rq(pblk, rqd, bio, blba, read_bitmap);
+		pblk_read_ppalist_rq(pblk, rqd, int_bio, blba, &info);
 	else
-		pblk_read_rq(pblk, rqd, bio, blba, read_bitmap);
+		pblk_read_rq(pblk, rqd, int_bio, blba, &info);
 
+split_retry:
 	r_ctx->private = bio; /* original bio */
 	rqd->bio = int_bio; /* internal bio */
 
-	if (bitmap_full(read_bitmap, nr_secs)) {
+	if (info.secs_from_cache && !info.secs_from_drive) {
 		pblk_end_user_read(bio, 0);
 		atomic_inc(&pblk->inflight_io);
 		__pblk_end_io_read(pblk, rqd, false);
 		return;
 	}
 
-	if (!bitmap_empty(read_bitmap, rqd->nr_ppas)) {
+	if (info.secs_from_cache && info.secs_from_drive) {
 		/* The read bio request could be partially filled by the write
 		 * buffer, but there are some holes that need to be read from
-		 * the drive.
+		 * the drive. In order to handle this, we will use block layer
+		 * mechanism to split this request in to smaller ones and make
+		 * a chain of it.
+		 */
+		int split = max_t(int, info.first_sec_from_cache,
+					info.first_sec_from_drive);
+
+		split_bio = bio_split(bio, split * NR_PHY_IN_LOG, GFP_KERNEL,
+					&pblk_bio_set);
+		bio_chain(split_bio, bio);
+		generic_make_request(bio);
+
+		/* New bio contains first N sectors of the previous one, so
+		 * we can continue to use existing rqd, but we need to shrink
+		 * the number of PPAs in it. We also need to release line
+		 * references on the rest of the PPAs. Finally we also need
+		 * to update pblk_read_info struct properly in order to avoid
+		 * another interation of l2p lookup.
+		 */
+		bio = split_bio;
+		pblk_rq_to_line_partial_put(pblk, rqd, split);
+#ifdef CONFIG_NVM_PBLK_DEBUG
+		atomic_long_sub((rqd->nr_ppas - split), &pblk->inflight_reads);
+#endif
+		rqd->nr_ppas = split;
+		if (rqd->nr_ppas == 1)
+			rqd->ppa_addr = rqd->ppa_list[0];
+
+		if (info.first_sec_from_cache > info.first_sec_from_drive)
+			info.secs_from_cache = false;
+		else
+			info.secs_from_drive = false;
+
+		/* Recreate int_bio - existing might have some needed internal
+		 * fields modified already.
 		 */
 		bio_put(int_bio);
-		rqd->bio = NULL;
-		if (pblk_partial_read_bio(pblk, rqd, bio_init_idx, read_bitmap,
-					    nr_secs)) {
-			pblk_err(pblk, "read IO submission failed\n");
-			bio_io_error(bio);
-			__pblk_end_io_read(pblk, rqd, false);
-		}
-		return;
+		int_bio = bio_clone_fast(bio, GFP_KERNEL, &pblk_bio_set);
+		goto split_retry;
 	}
 
 	/* All sectors are to be read from the device */
diff --git a/drivers/lightnvm/pblk.h b/drivers/lightnvm/pblk.h
index a3c925d..e284a93 100644
--- a/drivers/lightnvm/pblk.h
+++ b/drivers/lightnvm/pblk.h
@@ -123,18 +123,6 @@ struct pblk_g_ctx {
 	u64 lba;
 };
 
-/* partial read context */
-struct pblk_pr_ctx {
-	struct bio *orig_bio;
-	DECLARE_BITMAP(bitmap, NVM_MAX_VLBA);
-	unsigned int orig_nr_secs;
-	unsigned int bio_init_idx;
-	void *ppa_ptr;
-	dma_addr_t dma_ppa_list;
-	u64 lba_list_mem[NVM_MAX_VLBA];
-	u64 lba_list_media[NVM_MAX_VLBA];
-};
-
 /* Pad context */
 struct pblk_pad_rq {
 	struct pblk *pblk;
@@ -726,6 +714,14 @@ struct pblk_line_ws {
 	struct work_struct ws;
 };
 
+/* L2P lookup on read path info */
+struct pblk_read_info {
+	int first_sec_from_cache;
+	int first_sec_from_drive;
+	bool secs_from_cache;
+	bool secs_from_drive;
+};
+
 #define pblk_g_rq_size (sizeof(struct nvm_rq) + sizeof(struct pblk_g_ctx))
 #define pblk_w_rq_size (sizeof(struct nvm_rq) + sizeof(struct pblk_c_ctx))
 
@@ -809,6 +805,8 @@ struct pblk_line *pblk_line_get_first_data(struct pblk *pblk);
 struct pblk_line *pblk_line_replace_data(struct pblk *pblk);
 void pblk_ppa_to_line_put(struct pblk *pblk, struct ppa_addr ppa);
 void pblk_rq_to_line_put(struct pblk *pblk, struct nvm_rq *rqd);
+void pblk_rq_to_line_partial_put(struct pblk *pblk, struct nvm_rq *rqd,
+					int offset);
 int pblk_line_recov_alloc(struct pblk *pblk, struct pblk_line *line);
 void pblk_line_recov_close(struct pblk *pblk, struct pblk_line *line);
 struct pblk_line *pblk_line_get_data(struct pblk *pblk);
-- 
2.9.5

