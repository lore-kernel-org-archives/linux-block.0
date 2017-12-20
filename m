Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mail-wm0-f67.google.com ([74.125.82.67]:40072 "EHLO
        mail-wm0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755918AbdLTRWR (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 20 Dec 2017 12:22:17 -0500
Received: by mail-wm0-f67.google.com with SMTP id f206so11104173wmf.5
        for <linux-block@vger.kernel.org>; Wed, 20 Dec 2017 09:22:16 -0800 (PST)
From: =?UTF-8?q?Matias=20Bj=C3=B8rling?= <m@bjorling.me>
To: linux-block@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: =?UTF-8?q?Matias=20Bj=C3=B8rling?= <m@bjorling.me>
Subject: [PATCH 03/25] lightnvm: use internal pblk methods
Date: Wed, 20 Dec 2017 18:21:43 +0100
Message-Id: <20171220172205.26464-4-m@bjorling.me>
In-Reply-To: <20171220172205.26464-1-m@bjorling.me>
References: <20171220172205.26464-1-m@bjorling.me>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

Now that rrpc has been removed, the only users of the ppa helpers
is pblk. However, pblk already defines similar functions.

Switch pblk to use the internal ones, and remove the generic ppa
helpers.

Signed-off-by: Matias Bjørling <m@bjorling.me>
---
 drivers/lightnvm/pblk-map.c   |  2 +-
 drivers/lightnvm/pblk-write.c |  4 ++--
 include/linux/lightnvm.h      | 19 -------------------
 3 files changed, 3 insertions(+), 22 deletions(-)

diff --git a/drivers/lightnvm/pblk-map.c b/drivers/lightnvm/pblk-map.c
index 6f3ecde..7445e64 100644
--- a/drivers/lightnvm/pblk-map.c
+++ b/drivers/lightnvm/pblk-map.c
@@ -146,7 +146,7 @@ void pblk_map_erase_rq(struct pblk *pblk, struct nvm_rq *rqd,
 		return;
 
 	/* Erase blocks that are bad in this line but might not be in next */
-	if (unlikely(ppa_empty(*erase_ppa)) &&
+	if (unlikely(pblk_ppa_empty(*erase_ppa)) &&
 			bitmap_weight(d_line->blk_bitmap, lm->blk_per_line)) {
 		int bit = -1;
 
diff --git a/drivers/lightnvm/pblk-write.c b/drivers/lightnvm/pblk-write.c
index 6c1cafa..6c30b7a 100644
--- a/drivers/lightnvm/pblk-write.c
+++ b/drivers/lightnvm/pblk-write.c
@@ -439,7 +439,7 @@ static int pblk_submit_io_set(struct pblk *pblk, struct nvm_rq *rqd)
 	struct pblk_line *meta_line;
 	int err;
 
-	ppa_set_empty(&erase_ppa);
+	pblk_ppa_set_empty(&erase_ppa);
 
 	/* Assign lbas to ppas and populate request structure */
 	err = pblk_setup_w_rq(pblk, rqd, &erase_ppa);
@@ -457,7 +457,7 @@ static int pblk_submit_io_set(struct pblk *pblk, struct nvm_rq *rqd)
 		return NVM_IO_ERR;
 	}
 
-	if (!ppa_empty(erase_ppa)) {
+	if (!pblk_ppa_empty(erase_ppa)) {
 		/* Submit erase for next data line */
 		if (pblk_blk_erase_async(pblk, erase_ppa)) {
 			struct pblk_line *e_line = pblk_line_get_erase(pblk);
diff --git a/include/linux/lightnvm.h b/include/linux/lightnvm.h
index b7f111f..c506e5d 100644
--- a/include/linux/lightnvm.h
+++ b/include/linux/lightnvm.h
@@ -417,25 +417,6 @@ static inline struct ppa_addr dev_to_generic_addr(struct nvm_tgt_dev *tgt_dev,
 	return l;
 }
 
-static inline int ppa_empty(struct ppa_addr ppa_addr)
-{
-	return (ppa_addr.ppa == ADDR_EMPTY);
-}
-
-static inline void ppa_set_empty(struct ppa_addr *ppa_addr)
-{
-	ppa_addr->ppa = ADDR_EMPTY;
-}
-
-static inline int ppa_cmp_blk(struct ppa_addr ppa1, struct ppa_addr ppa2)
-{
-	if (ppa_empty(ppa1) || ppa_empty(ppa2))
-		return 0;
-
-	return ((ppa1.g.ch == ppa2.g.ch) && (ppa1.g.lun == ppa2.g.lun) &&
-					(ppa1.g.blk == ppa2.g.blk));
-}
-
 typedef blk_qc_t (nvm_tgt_make_rq_fn)(struct request_queue *, struct bio *);
 typedef sector_t (nvm_tgt_capacity_fn)(void *);
 typedef void *(nvm_tgt_init_fn)(struct nvm_tgt_dev *, struct gendisk *,
-- 
2.9.3
