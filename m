Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mail-pf1-f172.google.com ([209.85.210.172]:41252 "EHLO
        mail-pf1-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727101AbeJISaV (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Tue, 9 Oct 2018 14:30:21 -0400
Received: by mail-pf1-f172.google.com with SMTP id m77-v6so670609pfi.8
        for <linux-block@vger.kernel.org>; Tue, 09 Oct 2018 04:13:54 -0700 (PDT)
From: =?UTF-8?q?Matias=20Bj=C3=B8rling?= <mb@lightnvm.io>
To: axboe@fb.com
Cc: linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        =?UTF-8?q?Javier=20Gonz=C3=A1lez?= <javier@javigon.com>,
        =?UTF-8?q?Javier=20Gonz=C3=A1lez?= <javier@cnexlabs.com>,
        =?UTF-8?q?Matias=20Bj=C3=B8rling?= <mb@lightnvm.io>
Subject: [GIT PULL 12/45] lightnvm: pblk: improve line helpers
Date: Tue,  9 Oct 2018 13:11:42 +0200
Message-Id: <20181009111215.7653-13-mb@lightnvm.io>
In-Reply-To: <20181009111215.7653-1-mb@lightnvm.io>
References: <20181009111215.7653-1-mb@lightnvm.io>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

From: Javier González <javier@javigon.com>

The current helper to obtain a line from a ppa returns the line id,
which requires its users to explicitly retrieve the pointer to the line
with the id.

Make 2 different helpers: one returning the line id and one returning
the line directly.

Signed-off-by: Javier González <javier@cnexlabs.com>
Signed-off-by: Matias Bjørling <mb@lightnvm.io>
---
 drivers/lightnvm/pblk-core.c  | 15 ++++++---------
 drivers/lightnvm/pblk-rb.c    |  2 +-
 drivers/lightnvm/pblk-read.c  |  4 ++--
 drivers/lightnvm/pblk-write.c |  4 ++--
 drivers/lightnvm/pblk.h       | 13 +++++++++----
 5 files changed, 20 insertions(+), 18 deletions(-)

diff --git a/drivers/lightnvm/pblk-core.c b/drivers/lightnvm/pblk-core.c
index 5f99cf396072..36ac9eff8ebd 100644
--- a/drivers/lightnvm/pblk-core.c
+++ b/drivers/lightnvm/pblk-core.c
@@ -32,7 +32,7 @@ static void pblk_line_mark_bb(struct work_struct *work)
 		struct pblk_line *line;
 		int pos;
 
-		line = &pblk->lines[pblk_ppa_to_line(*ppa)];
+		line = pblk_ppa_to_line(pblk, *ppa);
 		pos = pblk_ppa_to_pos(&dev->geo, *ppa);
 
 		pblk_err(pblk, "failed to mark bb, line:%d, pos:%d\n",
@@ -80,7 +80,7 @@ static void __pblk_end_io_erase(struct pblk *pblk, struct nvm_rq *rqd)
 	struct pblk_line *line;
 	int pos;
 
-	line = &pblk->lines[pblk_ppa_to_line(rqd->ppa_addr)];
+	line = pblk_ppa_to_line(pblk, rqd->ppa_addr);
 	pos = pblk_ppa_to_pos(geo, rqd->ppa_addr);
 	chunk = &line->chks[pos];
 
@@ -192,7 +192,6 @@ void pblk_map_invalidate(struct pblk *pblk, struct ppa_addr ppa)
 {
 	struct pblk_line *line;
 	u64 paddr;
-	int line_id;
 
 #ifdef CONFIG_NVM_PBLK_DEBUG
 	/* Callers must ensure that the ppa points to a device address */
@@ -200,8 +199,7 @@ void pblk_map_invalidate(struct pblk *pblk, struct ppa_addr ppa)
 	BUG_ON(pblk_ppa_empty(ppa));
 #endif
 
-	line_id = pblk_ppa_to_line(ppa);
-	line = &pblk->lines[line_id];
+	line = pblk_ppa_to_line(pblk, ppa);
 	paddr = pblk_dev_ppa_to_line_addr(pblk, ppa);
 
 	__pblk_map_invalidate(pblk, line, paddr);
@@ -1430,7 +1428,7 @@ void pblk_ppa_to_line_put(struct pblk *pblk, struct ppa_addr ppa)
 {
 	struct pblk_line *line;
 
-	line = &pblk->lines[pblk_ppa_to_line(ppa)];
+	line = pblk_ppa_to_line(pblk, ppa);
 	kref_put(&line->ref, pblk_line_put_wq);
 }
 
@@ -1688,7 +1686,7 @@ int pblk_blk_erase_async(struct pblk *pblk, struct ppa_addr ppa)
 		struct nvm_geo *geo = &dev->geo;
 
 		pblk_err(pblk, "could not async erase line:%d,blk:%d\n",
-					pblk_ppa_to_line(ppa),
+					pblk_ppa_to_line_id(ppa),
 					pblk_ppa_to_pos(geo, ppa));
 	}
 
@@ -2059,8 +2057,7 @@ void pblk_lookup_l2p_seq(struct pblk *pblk, struct ppa_addr *ppas,
 
 		/* If the L2P entry maps to a line, the reference is valid */
 		if (!pblk_ppa_empty(ppa) && !pblk_addr_in_cache(ppa)) {
-			int line_id = pblk_ppa_to_line(ppa);
-			struct pblk_line *line = &pblk->lines[line_id];
+			struct pblk_line *line = pblk_ppa_to_line(pblk, ppa);
 
 			kref_get(&line->ref);
 		}
diff --git a/drivers/lightnvm/pblk-rb.c b/drivers/lightnvm/pblk-rb.c
index f6eec0212dfc..a7648e12f54f 100644
--- a/drivers/lightnvm/pblk-rb.c
+++ b/drivers/lightnvm/pblk-rb.c
@@ -225,7 +225,7 @@ static int __pblk_rb_update_l2p(struct pblk_rb *rb, unsigned int to_update)
 		pblk_update_map_dev(pblk, w_ctx->lba, w_ctx->ppa,
 							entry->cacheline);
 
-		line = &pblk->lines[pblk_ppa_to_line(w_ctx->ppa)];
+		line = pblk_ppa_to_line(pblk, w_ctx->ppa);
 		kref_put(&line->ref, pblk_line_put);
 		clean_wctx(w_ctx);
 		rb->l2p_update = (rb->l2p_update + 1) & (rb->nr_entries - 1);
diff --git a/drivers/lightnvm/pblk-read.c b/drivers/lightnvm/pblk-read.c
index ad1d7713bbda..49744caaa300 100644
--- a/drivers/lightnvm/pblk-read.c
+++ b/drivers/lightnvm/pblk-read.c
@@ -252,9 +252,9 @@ static void pblk_end_partial_read(struct nvm_rq *rqd)
 	i = 0;
 	hole = find_first_zero_bit(read_bitmap, nr_secs);
 	do {
-		int line_id = pblk_ppa_to_line(rqd->ppa_list[i]);
-		struct pblk_line *line = &pblk->lines[line_id];
+		struct pblk_line *line;
 
+		line = pblk_ppa_to_line(pblk, rqd->ppa_list[i]);
 		kref_put(&line->ref, pblk_line_put);
 
 		meta_list[hole].lba = lba_list_media[i];
diff --git a/drivers/lightnvm/pblk-write.c b/drivers/lightnvm/pblk-write.c
index df99c45778d4..c23b65aaa27b 100644
--- a/drivers/lightnvm/pblk-write.c
+++ b/drivers/lightnvm/pblk-write.c
@@ -113,7 +113,7 @@ static void pblk_map_remaining(struct pblk *pblk, struct ppa_addr *ppa)
 	u64 paddr;
 	int done = 0;
 
-	line = &pblk->lines[pblk_ppa_to_line(*ppa)];
+	line = pblk_ppa_to_line(pblk, *ppa);
 	spin_lock(&line->lock);
 
 	while (!done)  {
@@ -171,7 +171,7 @@ static void pblk_prepare_resubmit(struct pblk *pblk, unsigned int sentry,
 		/* Decrese the reference count to the line as we will
 		 * re-map these entries
 		 */
-		line = &pblk->lines[pblk_ppa_to_line(w_ctx->ppa)];
+		line = pblk_ppa_to_line(pblk, w_ctx->ppa);
 		kref_put(&line->ref, pblk_line_put);
 
 		pos = (pos + 1) & (rb->nr_entries - 1);
diff --git a/drivers/lightnvm/pblk.h b/drivers/lightnvm/pblk.h
index f95fe75fef6e..af9477b7e803 100644
--- a/drivers/lightnvm/pblk.h
+++ b/drivers/lightnvm/pblk.h
@@ -984,11 +984,17 @@ static inline int pblk_pad_distance(struct pblk *pblk)
 	return geo->mw_cunits * geo->all_luns * geo->ws_opt;
 }
 
-static inline int pblk_ppa_to_line(struct ppa_addr p)
+static inline int pblk_ppa_to_line_id(struct ppa_addr p)
 {
 	return p.a.blk;
 }
 
+static inline struct pblk_line *pblk_ppa_to_line(struct pblk *pblk,
+						 struct ppa_addr p)
+{
+	return &pblk->lines[pblk_ppa_to_line_id(p)];
+}
+
 static inline int pblk_ppa_to_pos(struct nvm_geo *geo, struct ppa_addr p)
 {
 	return p.a.lun * geo->num_ch + p.a.ch;
@@ -1039,7 +1045,7 @@ static inline struct nvm_chk_meta *pblk_dev_ppa_to_chunk(struct pblk *pblk,
 {
 	struct nvm_tgt_dev *dev = pblk->dev;
 	struct nvm_geo *geo = &dev->geo;
-	struct pblk_line *line = &pblk->lines[pblk_ppa_to_line(p)];
+	struct pblk_line *line = pblk_ppa_to_line(pblk, p);
 	int pos = pblk_ppa_to_pos(geo, p);
 
 	return &line->chks[pos];
@@ -1371,8 +1377,7 @@ static inline int pblk_check_io(struct pblk *pblk, struct nvm_rq *rqd)
 		int i;
 
 		for (i = 0; i < rqd->nr_ppas; i++) {
-			ppa = ppa_list[i];
-			line = &pblk->lines[pblk_ppa_to_line(ppa)];
+			line = pblk_ppa_to_line(pblk, ppa_list[i]);
 
 			spin_lock(&line->lock);
 			if (line->state != PBLK_LINESTATE_OPEN) {
-- 
2.17.1
