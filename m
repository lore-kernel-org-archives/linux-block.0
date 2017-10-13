Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mail-wm0-f67.google.com ([74.125.82.67]:45084 "EHLO
        mail-wm0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1758213AbdJMMra (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 13 Oct 2017 08:47:30 -0400
Received: by mail-wm0-f67.google.com with SMTP id q124so21260642wmb.0
        for <linux-block@vger.kernel.org>; Fri, 13 Oct 2017 05:47:29 -0700 (PDT)
From: =?UTF-8?q?Matias=20Bj=C3=B8rling?= <m@bjorling.me>
To: axboe@fb.com
Cc: linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        =?UTF-8?q?Javier=20Gonz=C3=A1lez?= <javier@cnexlabs.com>,
        =?UTF-8?q?Matias=20Bj=C3=B8rling?= <m@bjorling.me>
Subject: [GIT PULL 23/58] lightnvm: pblk: normalize ppa namings
Date: Fri, 13 Oct 2017 14:46:12 +0200
Message-Id: <20171013124647.32668-24-m@bjorling.me>
In-Reply-To: <20171013124647.32668-1-m@bjorling.me>
References: <20171013124647.32668-1-m@bjorling.me>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

From: Javier González <javier@cnexlabs.com>

Normalize the way we name ppa variables to improve code readability.

Signed-off-by: Javier González <javier@cnexlabs.com>
Signed-off-by: Matias Bjørling <m@bjorling.me>
---
 drivers/lightnvm/pblk-core.c | 48 +++++++++++++++++++++++---------------------
 1 file changed, 25 insertions(+), 23 deletions(-)

diff --git a/drivers/lightnvm/pblk-core.c b/drivers/lightnvm/pblk-core.c
index 0da5886..b6d7c66 100644
--- a/drivers/lightnvm/pblk-core.c
+++ b/drivers/lightnvm/pblk-core.c
@@ -1746,7 +1746,7 @@ void pblk_up_rq(struct pblk *pblk, struct ppa_addr *ppa_list, int nr_ppas,
 
 void pblk_update_map(struct pblk *pblk, sector_t lba, struct ppa_addr ppa)
 {
-	struct ppa_addr l2p_ppa;
+	struct ppa_addr ppa_l2p;
 
 	/* logic error: lba out-of-bounds. Ignore update */
 	if (!(lba < pblk->rl.nr_secs)) {
@@ -1755,10 +1755,10 @@ void pblk_update_map(struct pblk *pblk, sector_t lba, struct ppa_addr ppa)
 	}
 
 	spin_lock(&pblk->trans_lock);
-	l2p_ppa = pblk_trans_map_get(pblk, lba);
+	ppa_l2p = pblk_trans_map_get(pblk, lba);
 
-	if (!pblk_addr_in_cache(l2p_ppa) && !pblk_ppa_empty(l2p_ppa))
-		pblk_map_invalidate(pblk, l2p_ppa);
+	if (!pblk_addr_in_cache(ppa_l2p) && !pblk_ppa_empty(ppa_l2p))
+		pblk_map_invalidate(pblk, ppa_l2p);
 
 	pblk_trans_map_set(pblk, lba, ppa);
 	spin_unlock(&pblk->trans_lock);
@@ -1775,16 +1775,16 @@ void pblk_update_map_cache(struct pblk *pblk, sector_t lba, struct ppa_addr ppa)
 	pblk_update_map(pblk, lba, ppa);
 }
 
-int pblk_update_map_gc(struct pblk *pblk, sector_t lba, struct ppa_addr ppa,
+int pblk_update_map_gc(struct pblk *pblk, sector_t lba, struct ppa_addr ppa_new,
 		       struct pblk_line *gc_line)
 {
-	struct ppa_addr l2p_ppa;
+	struct ppa_addr ppa_l2p;
 	int ret = 1;
 
 #ifdef CONFIG_NVM_DEBUG
 	/* Callers must ensure that the ppa points to a cache address */
-	BUG_ON(!pblk_addr_in_cache(ppa));
-	BUG_ON(pblk_rb_pos_oob(&pblk->rwb, pblk_addr_to_cacheline(ppa)));
+	BUG_ON(!pblk_addr_in_cache(ppa_new));
+	BUG_ON(pblk_rb_pos_oob(&pblk->rwb, pblk_addr_to_cacheline(ppa_new)));
 #endif
 
 	/* logic error: lba out-of-bounds. Ignore update */
@@ -1794,36 +1794,38 @@ int pblk_update_map_gc(struct pblk *pblk, sector_t lba, struct ppa_addr ppa,
 	}
 
 	spin_lock(&pblk->trans_lock);
-	l2p_ppa = pblk_trans_map_get(pblk, lba);
+	ppa_l2p = pblk_trans_map_get(pblk, lba);
 
 	/* Prevent updated entries to be overwritten by GC */
-	if (pblk_addr_in_cache(l2p_ppa) || pblk_ppa_empty(l2p_ppa) ||
-				pblk_tgt_ppa_to_line(l2p_ppa) != gc_line->id) {
+	if (pblk_addr_in_cache(ppa_l2p) || pblk_ppa_empty(ppa_l2p) ||
+				pblk_tgt_ppa_to_line(ppa_l2p) != gc_line->id) {
+
 		ret = 0;
 		goto out;
 	}
 
-	pblk_trans_map_set(pblk, lba, ppa);
+	pblk_trans_map_set(pblk, lba, ppa_new);
 out:
 	spin_unlock(&pblk->trans_lock);
 	return ret;
 }
 
-void pblk_update_map_dev(struct pblk *pblk, sector_t lba, struct ppa_addr ppa,
-			 struct ppa_addr entry_line)
+void pblk_update_map_dev(struct pblk *pblk, sector_t lba,
+			 struct ppa_addr ppa_mapped, struct ppa_addr ppa_cache)
 {
-	struct ppa_addr l2p_line;
+	struct ppa_addr ppa_l2p;
 
 #ifdef CONFIG_NVM_DEBUG
 	/* Callers must ensure that the ppa points to a device address */
-	BUG_ON(pblk_addr_in_cache(ppa));
+	BUG_ON(pblk_addr_in_cache(ppa_mapped));
 #endif
 	/* Invalidate and discard padded entries */
 	if (lba == ADDR_EMPTY) {
 #ifdef CONFIG_NVM_DEBUG
 		atomic_long_inc(&pblk->padded_wb);
 #endif
-		pblk_map_invalidate(pblk, ppa);
+		if (!pblk_ppa_empty(ppa_mapped))
+			pblk_map_invalidate(pblk, ppa_mapped);
 		return;
 	}
 
@@ -1834,22 +1836,22 @@ void pblk_update_map_dev(struct pblk *pblk, sector_t lba, struct ppa_addr ppa,
 	}
 
 	spin_lock(&pblk->trans_lock);
-	l2p_line = pblk_trans_map_get(pblk, lba);
+	ppa_l2p = pblk_trans_map_get(pblk, lba);
 
 	/* Do not update L2P if the cacheline has been updated. In this case,
 	 * the mapped ppa must be invalidated
 	 */
-	if (l2p_line.ppa != entry_line.ppa) {
-		if (!pblk_ppa_empty(ppa))
-			pblk_map_invalidate(pblk, ppa);
+	if (!pblk_ppa_comp(ppa_l2p, ppa_cache)) {
+		if (!pblk_ppa_empty(ppa_mapped))
+			pblk_map_invalidate(pblk, ppa_mapped);
 		goto out;
 	}
 
 #ifdef CONFIG_NVM_DEBUG
-	WARN_ON(!pblk_addr_in_cache(l2p_line) && !pblk_ppa_empty(l2p_line));
+	WARN_ON(!pblk_addr_in_cache(ppa_l2p) && !pblk_ppa_empty(ppa_l2p));
 #endif
 
-	pblk_trans_map_set(pblk, lba, ppa);
+	pblk_trans_map_set(pblk, lba, ppa_mapped);
 out:
 	spin_unlock(&pblk->trans_lock);
 }
-- 
2.9.3
