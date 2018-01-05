Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mail-wm0-f67.google.com ([74.125.82.67]:37564 "EHLO
        mail-wm0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751913AbeAENQu (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Fri, 5 Jan 2018 08:16:50 -0500
Received: by mail-wm0-f67.google.com with SMTP id f140so2414014wmd.2
        for <linux-block@vger.kernel.org>; Fri, 05 Jan 2018 05:16:50 -0800 (PST)
From: =?UTF-8?q?Matias=20Bj=C3=B8rling?= <m@bjorling.me>
To: axboe@fb.com
Cc: linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        =?UTF-8?q?Javier=20Gonz=C3=A1lez?= <javier@cnexlabs.com>,
        =?UTF-8?q?Matias=20Bj=C3=B8rling?= <m@bjorling.me>
Subject: [GIT PULL 10/25] lightnvm: pblk: compress and reorder helper functions
Date: Fri,  5 Jan 2018 14:16:06 +0100
Message-Id: <20180105131621.20808-11-m@bjorling.me>
In-Reply-To: <20180105131621.20808-1-m@bjorling.me>
References: <20180105131621.20808-1-m@bjorling.me>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

From: Javier González <javier@cnexlabs.com>

Through time, we have generated some redundant helper functions.
Refactor them to eliminate redundant and unnecessary code. Also, reorder
them to improve readability

Signed-off-by: Javier González <javier@cnexlabs.com>
Signed-off-by: Matias Bjørling <m@bjorling.me>
---
 drivers/lightnvm/pblk-core.c     |  24 ++++----
 drivers/lightnvm/pblk-rb.c       |   2 +-
 drivers/lightnvm/pblk-read.c     |   4 +-
 drivers/lightnvm/pblk-recovery.c |  20 +++----
 drivers/lightnvm/pblk.h          | 121 +++++++++++++++------------------------
 5 files changed, 72 insertions(+), 99 deletions(-)

diff --git a/drivers/lightnvm/pblk-core.c b/drivers/lightnvm/pblk-core.c
index 0849046..54d0cef 100644
--- a/drivers/lightnvm/pblk-core.c
+++ b/drivers/lightnvm/pblk-core.c
@@ -32,8 +32,8 @@ static void pblk_line_mark_bb(struct work_struct *work)
 		struct pblk_line *line;
 		int pos;
 
-		line = &pblk->lines[pblk_dev_ppa_to_line(*ppa)];
-		pos = pblk_dev_ppa_to_pos(&dev->geo, *ppa);
+		line = &pblk->lines[pblk_ppa_to_line(*ppa)];
+		pos = pblk_ppa_to_pos(&dev->geo, *ppa);
 
 		pr_err("pblk: failed to mark bb, line:%d, pos:%d\n",
 				line->id, pos);
@@ -48,7 +48,7 @@ static void pblk_mark_bb(struct pblk *pblk, struct pblk_line *line,
 {
 	struct nvm_tgt_dev *dev = pblk->dev;
 	struct nvm_geo *geo = &dev->geo;
-	int pos = pblk_dev_ppa_to_pos(geo, *ppa);
+	int pos = pblk_ppa_to_pos(geo, *ppa);
 
 	pr_debug("pblk: erase failed: line:%d, pos:%d\n", line->id, pos);
 	atomic_long_inc(&pblk->erase_failed);
@@ -66,7 +66,7 @@ static void __pblk_end_io_erase(struct pblk *pblk, struct nvm_rq *rqd)
 {
 	struct pblk_line *line;
 
-	line = &pblk->lines[pblk_dev_ppa_to_line(rqd->ppa_addr)];
+	line = &pblk->lines[pblk_ppa_to_line(rqd->ppa_addr)];
 	atomic_dec(&line->left_seblks);
 
 	if (rqd->error) {
@@ -144,7 +144,7 @@ void pblk_map_invalidate(struct pblk *pblk, struct ppa_addr ppa)
 	BUG_ON(pblk_ppa_empty(ppa));
 #endif
 
-	line_id = pblk_tgt_ppa_to_line(ppa);
+	line_id = pblk_ppa_to_line(ppa);
 	line = &pblk->lines[line_id];
 	paddr = pblk_dev_ppa_to_line_addr(pblk, ppa);
 
@@ -650,7 +650,7 @@ static int pblk_line_submit_emeta_io(struct pblk *pblk, struct pblk_line *line,
 	} else {
 		for (i = 0; i < rqd.nr_ppas; ) {
 			struct ppa_addr ppa = addr_to_gen_ppa(pblk, paddr, id);
-			int pos = pblk_dev_ppa_to_pos(geo, ppa);
+			int pos = pblk_ppa_to_pos(geo, ppa);
 			int read_type = PBLK_READ_RANDOM;
 
 			if (pblk_io_aligned(pblk, rq_ppas))
@@ -668,7 +668,7 @@ static int pblk_line_submit_emeta_io(struct pblk *pblk, struct pblk_line *line,
 				}
 
 				ppa = addr_to_gen_ppa(pblk, paddr, id);
-				pos = pblk_dev_ppa_to_pos(geo, ppa);
+				pos = pblk_ppa_to_pos(geo, ppa);
 			}
 
 			if (pblk_boundary_paddr_checks(pblk, paddr + min)) {
@@ -854,8 +854,8 @@ static int pblk_blk_erase_sync(struct pblk *pblk, struct ppa_addr ppa)
 		struct nvm_geo *geo = &dev->geo;
 
 		pr_err("pblk: could not sync erase line:%d,blk:%d\n",
-					pblk_dev_ppa_to_line(ppa),
-					pblk_dev_ppa_to_pos(geo, ppa));
+					pblk_ppa_to_line(ppa),
+					pblk_ppa_to_pos(geo, ppa));
 
 		rqd.error = ret;
 		goto out;
@@ -1561,8 +1561,8 @@ int pblk_blk_erase_async(struct pblk *pblk, struct ppa_addr ppa)
 		struct nvm_geo *geo = &dev->geo;
 
 		pr_err("pblk: could not async erase line:%d,blk:%d\n",
-					pblk_dev_ppa_to_line(ppa),
-					pblk_dev_ppa_to_pos(geo, ppa));
+					pblk_ppa_to_line(ppa),
+					pblk_ppa_to_pos(geo, ppa));
 	}
 
 	return err;
@@ -1884,7 +1884,7 @@ void pblk_lookup_l2p_seq(struct pblk *pblk, struct ppa_addr *ppas,
 
 		/* If the L2P entry maps to a line, the reference is valid */
 		if (!pblk_ppa_empty(ppa) && !pblk_addr_in_cache(ppa)) {
-			int line_id = pblk_dev_ppa_to_line(ppa);
+			int line_id = pblk_ppa_to_line(ppa);
 			struct pblk_line *line = &pblk->lines[line_id];
 
 			kref_get(&line->ref);
diff --git a/drivers/lightnvm/pblk-rb.c b/drivers/lightnvm/pblk-rb.c
index b8f78e4..62db408 100644
--- a/drivers/lightnvm/pblk-rb.c
+++ b/drivers/lightnvm/pblk-rb.c
@@ -226,7 +226,7 @@ static int __pblk_rb_update_l2p(struct pblk_rb *rb, unsigned int to_update)
 		pblk_update_map_dev(pblk, w_ctx->lba, w_ctx->ppa,
 							entry->cacheline);
 
-		line = &pblk->lines[pblk_tgt_ppa_to_line(w_ctx->ppa)];
+		line = &pblk->lines[pblk_ppa_to_line(w_ctx->ppa)];
 		kref_put(&line->ref, pblk_line_put);
 		clean_wctx(w_ctx);
 		rb->l2p_update = (rb->l2p_update + 1) & (rb->nr_entries - 1);
diff --git a/drivers/lightnvm/pblk-read.c b/drivers/lightnvm/pblk-read.c
index ca79d8f..0fe0c04 100644
--- a/drivers/lightnvm/pblk-read.c
+++ b/drivers/lightnvm/pblk-read.c
@@ -141,7 +141,7 @@ static void pblk_read_put_rqd_kref(struct pblk *pblk, struct nvm_rq *rqd)
 		struct ppa_addr ppa = ppa_list[i];
 		struct pblk_line *line;
 
-		line = &pblk->lines[pblk_dev_ppa_to_line(ppa)];
+		line = &pblk->lines[pblk_ppa_to_line(ppa)];
 		kref_put(&line->ref, pblk_line_put_wq);
 	}
 }
@@ -270,7 +270,7 @@ static int pblk_fill_partial_read_bio(struct pblk *pblk, struct nvm_rq *rqd,
 	i = 0;
 	hole = find_first_zero_bit(read_bitmap, nr_secs);
 	do {
-		int line_id = pblk_dev_ppa_to_line(rqd->ppa_list[i]);
+		int line_id = pblk_ppa_to_line(rqd->ppa_list[i]);
 		struct pblk_line *line = &pblk->lines[line_id];
 
 		kref_put(&line->ref, pblk_line_put);
diff --git a/drivers/lightnvm/pblk-recovery.c b/drivers/lightnvm/pblk-recovery.c
index ceec12d..1b272ae 100644
--- a/drivers/lightnvm/pblk-recovery.c
+++ b/drivers/lightnvm/pblk-recovery.c
@@ -149,7 +149,7 @@ static int pblk_recov_l2p_from_emeta(struct pblk *pblk, struct pblk_line *line)
 		struct ppa_addr ppa;
 		int pos;
 
-		ppa = addr_to_pblk_ppa(pblk, i, line->id);
+		ppa = addr_to_gen_ppa(pblk, i, line->id);
 		pos = pblk_ppa_to_pos(geo, ppa);
 
 		/* Do not update bad blocks */
@@ -263,12 +263,12 @@ static int pblk_recov_read_oob(struct pblk *pblk, struct pblk_line *line,
 		int pos;
 
 		ppa = addr_to_gen_ppa(pblk, r_ptr_int, line->id);
-		pos = pblk_dev_ppa_to_pos(geo, ppa);
+		pos = pblk_ppa_to_pos(geo, ppa);
 
 		while (test_bit(pos, line->blk_bitmap)) {
 			r_ptr_int += pblk->min_write_pgs;
 			ppa = addr_to_gen_ppa(pblk, r_ptr_int, line->id);
-			pos = pblk_dev_ppa_to_pos(geo, ppa);
+			pos = pblk_ppa_to_pos(geo, ppa);
 		}
 
 		for (j = 0; j < pblk->min_write_pgs; j++, i++, r_ptr_int++)
@@ -411,12 +411,12 @@ static int pblk_recov_pad_oob(struct pblk *pblk, struct pblk_line *line,
 		int pos;
 
 		w_ptr = pblk_alloc_page(pblk, line, pblk->min_write_pgs);
-		ppa = addr_to_pblk_ppa(pblk, w_ptr, line->id);
+		ppa = addr_to_gen_ppa(pblk, w_ptr, line->id);
 		pos = pblk_ppa_to_pos(geo, ppa);
 
 		while (test_bit(pos, line->blk_bitmap)) {
 			w_ptr += pblk->min_write_pgs;
-			ppa = addr_to_pblk_ppa(pblk, w_ptr, line->id);
+			ppa = addr_to_gen_ppa(pblk, w_ptr, line->id);
 			pos = pblk_ppa_to_pos(geo, ppa);
 		}
 
@@ -541,12 +541,12 @@ static int pblk_recov_scan_all_oob(struct pblk *pblk, struct pblk_line *line,
 
 		w_ptr = pblk_alloc_page(pblk, line, pblk->min_write_pgs);
 		ppa = addr_to_gen_ppa(pblk, w_ptr, line->id);
-		pos = pblk_dev_ppa_to_pos(geo, ppa);
+		pos = pblk_ppa_to_pos(geo, ppa);
 
 		while (test_bit(pos, line->blk_bitmap)) {
 			w_ptr += pblk->min_write_pgs;
 			ppa = addr_to_gen_ppa(pblk, w_ptr, line->id);
-			pos = pblk_dev_ppa_to_pos(geo, ppa);
+			pos = pblk_ppa_to_pos(geo, ppa);
 		}
 
 		for (j = 0; j < pblk->min_write_pgs; j++, i++, w_ptr++)
@@ -672,12 +672,12 @@ static int pblk_recov_scan_oob(struct pblk *pblk, struct pblk_line *line,
 
 		paddr = pblk_alloc_page(pblk, line, pblk->min_write_pgs);
 		ppa = addr_to_gen_ppa(pblk, paddr, line->id);
-		pos = pblk_dev_ppa_to_pos(geo, ppa);
+		pos = pblk_ppa_to_pos(geo, ppa);
 
 		while (test_bit(pos, line->blk_bitmap)) {
 			paddr += pblk->min_write_pgs;
 			ppa = addr_to_gen_ppa(pblk, paddr, line->id);
-			pos = pblk_dev_ppa_to_pos(geo, ppa);
+			pos = pblk_ppa_to_pos(geo, ppa);
 		}
 
 		for (j = 0; j < pblk->min_write_pgs; j++, i++, paddr++)
@@ -817,7 +817,7 @@ static u64 pblk_line_emeta_start(struct pblk *pblk, struct pblk_line *line)
 
 	while (emeta_secs) {
 		emeta_start--;
-		ppa = addr_to_pblk_ppa(pblk, emeta_start, line->id);
+		ppa = addr_to_gen_ppa(pblk, emeta_start, line->id);
 		pos = pblk_ppa_to_pos(geo, ppa);
 		if (!test_bit(pos, line->blk_bitmap))
 			emeta_secs--;
diff --git a/drivers/lightnvm/pblk.h b/drivers/lightnvm/pblk.h
index c150728..d68a94d 100644
--- a/drivers/lightnvm/pblk.h
+++ b/drivers/lightnvm/pblk.h
@@ -910,12 +910,7 @@ static inline int pblk_pad_distance(struct pblk *pblk)
 	return NVM_MEM_PAGE_WRITE * geo->all_luns * geo->sec_per_pl;
 }
 
-static inline int pblk_dev_ppa_to_line(struct ppa_addr p)
-{
-	return p.g.blk;
-}
-
-static inline int pblk_tgt_ppa_to_line(struct ppa_addr p)
+static inline int pblk_ppa_to_line(struct ppa_addr p)
 {
 	return p.g.blk;
 }
@@ -925,10 +920,34 @@ static inline int pblk_ppa_to_pos(struct nvm_geo *geo, struct ppa_addr p)
 	return p.g.lun * geo->nr_chnls + p.g.ch;
 }
 
-/* A block within a line corresponds to the lun */
-static inline int pblk_dev_ppa_to_pos(struct nvm_geo *geo, struct ppa_addr p)
+static inline struct ppa_addr addr_to_gen_ppa(struct pblk *pblk, u64 paddr,
+					      u64 line_id)
 {
-	return p.g.lun * geo->nr_chnls + p.g.ch;
+	struct ppa_addr ppa;
+
+	ppa.ppa = 0;
+	ppa.g.blk = line_id;
+	ppa.g.pg = (paddr & pblk->ppaf.pg_mask) >> pblk->ppaf.pg_offset;
+	ppa.g.lun = (paddr & pblk->ppaf.lun_mask) >> pblk->ppaf.lun_offset;
+	ppa.g.ch = (paddr & pblk->ppaf.ch_mask) >> pblk->ppaf.ch_offset;
+	ppa.g.pl = (paddr & pblk->ppaf.pln_mask) >> pblk->ppaf.pln_offset;
+	ppa.g.sec = (paddr & pblk->ppaf.sec_mask) >> pblk->ppaf.sec_offset;
+
+	return ppa;
+}
+
+static inline u64 pblk_dev_ppa_to_line_addr(struct pblk *pblk,
+							struct ppa_addr p)
+{
+	u64 paddr;
+
+	paddr = (u64)p.g.pg << pblk->ppaf.pg_offset;
+	paddr |= (u64)p.g.lun << pblk->ppaf.lun_offset;
+	paddr |= (u64)p.g.ch << pblk->ppaf.ch_offset;
+	paddr |= (u64)p.g.pl << pblk->ppaf.pln_offset;
+	paddr |= (u64)p.g.sec << pblk->ppaf.sec_offset;
+
+	return paddr;
 }
 
 static inline struct ppa_addr pblk_ppa32_to_ppa64(struct pblk *pblk, u32 ppa32)
@@ -960,24 +979,6 @@ static inline struct ppa_addr pblk_ppa32_to_ppa64(struct pblk *pblk, u32 ppa32)
 	return ppa64;
 }
 
-static inline struct ppa_addr pblk_trans_map_get(struct pblk *pblk,
-								sector_t lba)
-{
-	struct ppa_addr ppa;
-
-	if (pblk->ppaf_bitsize < 32) {
-		u32 *map = (u32 *)pblk->trans_map;
-
-		ppa = pblk_ppa32_to_ppa64(pblk, map[lba]);
-	} else {
-		struct ppa_addr *map = (struct ppa_addr *)pblk->trans_map;
-
-		ppa = map[lba];
-	}
-
-	return ppa;
-}
-
 static inline u32 pblk_ppa64_to_ppa32(struct pblk *pblk, struct ppa_addr ppa64)
 {
 	u32 ppa32 = 0;
@@ -999,6 +1000,24 @@ static inline u32 pblk_ppa64_to_ppa32(struct pblk *pblk, struct ppa_addr ppa64)
 	return ppa32;
 }
 
+static inline struct ppa_addr pblk_trans_map_get(struct pblk *pblk,
+								sector_t lba)
+{
+	struct ppa_addr ppa;
+
+	if (pblk->ppaf_bitsize < 32) {
+		u32 *map = (u32 *)pblk->trans_map;
+
+		ppa = pblk_ppa32_to_ppa64(pblk, map[lba]);
+	} else {
+		struct ppa_addr *map = (struct ppa_addr *)pblk->trans_map;
+
+		ppa = map[lba];
+	}
+
+	return ppa;
+}
+
 static inline void pblk_trans_map_set(struct pblk *pblk, sector_t lba,
 						struct ppa_addr ppa)
 {
@@ -1013,21 +1032,6 @@ static inline void pblk_trans_map_set(struct pblk *pblk, sector_t lba,
 	}
 }
 
-static inline u64 pblk_dev_ppa_to_line_addr(struct pblk *pblk,
-							struct ppa_addr p)
-{
-	u64 paddr;
-
-	paddr = 0;
-	paddr |= (u64)p.g.pg << pblk->ppaf.pg_offset;
-	paddr |= (u64)p.g.lun << pblk->ppaf.lun_offset;
-	paddr |= (u64)p.g.ch << pblk->ppaf.ch_offset;
-	paddr |= (u64)p.g.pl << pblk->ppaf.pln_offset;
-	paddr |= (u64)p.g.sec << pblk->ppaf.sec_offset;
-
-	return paddr;
-}
-
 static inline int pblk_ppa_empty(struct ppa_addr ppa_addr)
 {
 	return (ppa_addr.ppa == ADDR_EMPTY);
@@ -1066,32 +1070,6 @@ static inline struct ppa_addr pblk_cacheline_to_addr(int addr)
 	return p;
 }
 
-static inline struct ppa_addr addr_to_gen_ppa(struct pblk *pblk, u64 paddr,
-					      u64 line_id)
-{
-	struct ppa_addr ppa;
-
-	ppa.ppa = 0;
-	ppa.g.blk = line_id;
-	ppa.g.pg = (paddr & pblk->ppaf.pg_mask) >> pblk->ppaf.pg_offset;
-	ppa.g.lun = (paddr & pblk->ppaf.lun_mask) >> pblk->ppaf.lun_offset;
-	ppa.g.ch = (paddr & pblk->ppaf.ch_mask) >> pblk->ppaf.ch_offset;
-	ppa.g.pl = (paddr & pblk->ppaf.pln_mask) >> pblk->ppaf.pln_offset;
-	ppa.g.sec = (paddr & pblk->ppaf.sec_mask) >> pblk->ppaf.sec_offset;
-
-	return ppa;
-}
-
-static inline struct ppa_addr addr_to_pblk_ppa(struct pblk *pblk, u64 paddr,
-					 u64 line_id)
-{
-	struct ppa_addr ppa;
-
-	ppa = addr_to_gen_ppa(pblk, paddr, line_id);
-
-	return ppa;
-}
-
 static inline u32 pblk_calc_meta_header_crc(struct pblk *pblk,
 					    struct line_header *header)
 {
@@ -1245,7 +1223,7 @@ static inline int pblk_check_io(struct pblk *pblk, struct nvm_rq *rqd)
 
 		for (i = 0; i < rqd->nr_ppas; i++) {
 			ppa = ppa_list[i];
-			line = &pblk->lines[pblk_dev_ppa_to_line(ppa)];
+			line = &pblk->lines[pblk_ppa_to_line(ppa)];
 
 			spin_lock(&line->lock);
 			if (line->state != PBLK_LINESTATE_OPEN) {
@@ -1288,11 +1266,6 @@ static inline unsigned int pblk_get_secs(struct bio *bio)
 	return  bio->bi_iter.bi_size / PBLK_EXPOSED_PAGE_SIZE;
 }
 
-static inline sector_t pblk_get_sector(sector_t lba)
-{
-	return lba * NR_PHY_IN_LOG;
-}
-
 static inline void pblk_setup_uuid(struct pblk *pblk)
 {
 	uuid_le uuid;
-- 
2.9.3
