Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mail-wm0-f51.google.com ([74.125.82.51]:46527 "EHLO
        mail-wm0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751364AbdIOMgB (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 15 Sep 2017 08:36:01 -0400
Received: by mail-wm0-f51.google.com with SMTP id i189so7960494wmf.1
        for <linux-block@vger.kernel.org>; Fri, 15 Sep 2017 05:36:00 -0700 (PDT)
From: "=?UTF-8?q?Javier=20Gonz=C3=A1lez?=" <jg@lightnvm.io>
To: linux-block@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
        =?UTF-8?q?Javier=20Gonz=C3=A1lez?= <javier@cnexlabs.com>
Subject: [PATCH] lightnvm: pblk: remove I/O dependency on write path
Date: Fri, 15 Sep 2017 14:35:51 +0200
Message-Id: <1505478953-16915-4-git-send-email-javier@cnexlabs.com>
In-Reply-To: <1505478953-16915-1-git-send-email-javier@cnexlabs.com>
References: <1505478953-16915-1-git-send-email-javier@cnexlabs.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

pblk schedules user I/O, metadata I/O and erases on the write path in
order to minimize collisions at the media level. Until now, there has
been a dependency between user and metadata I/Os that could lead to a
deadlock as both take the per-LUN semaphore to schedule submission.

This path removes this dependency and guarantees forward progress at a
per I/O granurality.

Signed-off-by: Javier González <javier@cnexlabs.com>
---
 drivers/lightnvm/pblk-write.c | 145 +++++++++++++++++++-----------------------
 1 file changed, 65 insertions(+), 80 deletions(-)

diff --git a/drivers/lightnvm/pblk-write.c b/drivers/lightnvm/pblk-write.c
index cec526759547..89a1b46ec728 100644
--- a/drivers/lightnvm/pblk-write.c
+++ b/drivers/lightnvm/pblk-write.c
@@ -223,15 +223,16 @@ static int pblk_alloc_w_rq(struct pblk *pblk, struct nvm_rq *rqd,
 }
 
 static int pblk_setup_w_rq(struct pblk *pblk, struct nvm_rq *rqd,
-			   struct pblk_c_ctx *c_ctx, struct ppa_addr *erase_ppa)
+			   struct ppa_addr *erase_ppa)
 {
 	struct pblk_line_meta *lm = &pblk->lm;
 	struct pblk_line *e_line = pblk_line_get_erase(pblk);
+	struct pblk_c_ctx *c_ctx = nvm_rq_to_pdu(rqd);
 	unsigned int valid = c_ctx->nr_valid;
 	unsigned int padded = c_ctx->nr_padded;
 	unsigned int nr_secs = valid + padded;
 	unsigned long *lun_bitmap;
-	int ret = 0;
+	int ret;
 
 	lun_bitmap = kzalloc(lm->lun_bitmap_len, GFP_KERNEL);
 	if (!lun_bitmap)
@@ -297,55 +298,6 @@ static int pblk_calc_secs_to_sync(struct pblk *pblk, unsigned int secs_avail,
 	return secs_to_sync;
 }
 
-static inline int pblk_valid_meta_ppa(struct pblk *pblk,
-				      struct pblk_line *meta_line,
-				      struct ppa_addr *ppa_list, int nr_ppas)
-{
-	struct nvm_tgt_dev *dev = pblk->dev;
-	struct nvm_geo *geo = &dev->geo;
-	struct pblk_line *data_line;
-	struct ppa_addr ppa, ppa_opt;
-	u64 paddr;
-	int i;
-
-	data_line = &pblk->lines[pblk_dev_ppa_to_line(ppa_list[0])];
-	paddr = pblk_lookup_page(pblk, meta_line);
-	ppa = addr_to_gen_ppa(pblk, paddr, 0);
-
-	if (test_bit(pblk_ppa_to_pos(geo, ppa), data_line->blk_bitmap))
-		return 1;
-
-	/* Schedule a metadata I/O that is half the distance from the data I/O
-	 * with regards to the number of LUNs forming the pblk instance. This
-	 * balances LUN conflicts across every I/O.
-	 *
-	 * When the LUN configuration changes (e.g., due to GC), this distance
-	 * can align, which would result on a LUN deadlock. In this case, modify
-	 * the distance to not be optimal, but allow metadata I/Os to succeed.
-	 */
-	ppa_opt = addr_to_gen_ppa(pblk, paddr + data_line->meta_distance, 0);
-	if (unlikely(ppa_opt.ppa == ppa.ppa)) {
-		data_line->meta_distance--;
-		return 0;
-	}
-
-	for (i = 0; i < nr_ppas; i += pblk->min_write_pgs)
-		if (ppa_list[i].g.ch == ppa_opt.g.ch &&
-					ppa_list[i].g.lun == ppa_opt.g.lun)
-			return 1;
-
-	if (test_bit(pblk_ppa_to_pos(geo, ppa_opt), data_line->blk_bitmap)) {
-		for (i = 0; i < nr_ppas; i += pblk->min_write_pgs)
-			if (ppa_list[i].g.ch == ppa.g.ch &&
-						ppa_list[i].g.lun == ppa.g.lun)
-				return 0;
-
-		return 1;
-	}
-
-	return 0;
-}
-
 int pblk_submit_meta_io(struct pblk *pblk, struct pblk_line *meta_line)
 {
 	struct nvm_tgt_dev *dev = pblk->dev;
@@ -424,8 +376,44 @@ int pblk_submit_meta_io(struct pblk *pblk, struct pblk_line *meta_line)
 	return ret;
 }
 
-static int pblk_sched_meta_io(struct pblk *pblk, struct ppa_addr *prev_list,
-			       int prev_n)
+static inline bool pblk_valid_meta_ppa(struct pblk *pblk,
+				       struct pblk_line *meta_line,
+				       struct nvm_rq *data_rqd)
+{
+	struct nvm_tgt_dev *dev = pblk->dev;
+	struct nvm_geo *geo = &dev->geo;
+	struct pblk_c_ctx *data_c_ctx = nvm_rq_to_pdu(data_rqd);
+	struct pblk_line *data_line = pblk_line_get_data(pblk);
+	struct ppa_addr ppa, ppa_opt;
+	u64 paddr;
+	int pos_opt;
+
+	/* Schedule a metadata I/O that is half the distance from the data I/O
+	 * with regards to the number of LUNs forming the pblk instance. This
+	 * balances LUN conflicts across every I/O.
+	 *
+	 * When the LUN configuration changes (e.g., due to GC), this distance
+	 * can align, which would result on metadata and data I/Os colliding. In
+	 * this case, modify the distance to not be optimal, but move the
+	 * optimal in the right direction.
+	 */
+	paddr = pblk_lookup_page(pblk, meta_line);
+	ppa = addr_to_gen_ppa(pblk, paddr, 0);
+	ppa_opt = addr_to_gen_ppa(pblk, paddr + data_line->meta_distance, 0);
+	pos_opt = pblk_ppa_to_pos(geo, ppa_opt);
+
+	if (test_bit(pos_opt, data_c_ctx->lun_bitmap) ||
+				test_bit(pos_opt, data_line->blk_bitmap))
+		return true;
+
+	if (unlikely(pblk_ppa_comp(ppa_opt, ppa)))
+		data_line->meta_distance--;
+
+	return false;
+}
+
+static struct pblk_line *pblk_should_submit_meta_io(struct pblk *pblk,
+						    struct nvm_rq *data_rqd)
 {
 	struct pblk_line_meta *lm = &pblk->lm;
 	struct pblk_line_mgmt *l_mg = &pblk->l_mg;
@@ -435,57 +423,45 @@ static int pblk_sched_meta_io(struct pblk *pblk, struct ppa_addr *prev_list,
 retry:
 	if (list_empty(&l_mg->emeta_list)) {
 		spin_unlock(&l_mg->close_lock);
-		return 0;
+		return NULL;
 	}
 	meta_line = list_first_entry(&l_mg->emeta_list, struct pblk_line, list);
 	if (meta_line->emeta->mem >= lm->emeta_len[0])
 		goto retry;
 	spin_unlock(&l_mg->close_lock);
 
-	if (!pblk_valid_meta_ppa(pblk, meta_line, prev_list, prev_n))
-		return 0;
+	if (!pblk_valid_meta_ppa(pblk, meta_line, data_rqd))
+		return NULL;
 
-	return pblk_submit_meta_io(pblk, meta_line);
+	return meta_line;
 }
 
 static int pblk_submit_io_set(struct pblk *pblk, struct nvm_rq *rqd)
 {
-	struct pblk_c_ctx *c_ctx = nvm_rq_to_pdu(rqd);
 	struct ppa_addr erase_ppa;
+	struct pblk_line *meta_line;
 	int err;
 
 	ppa_set_empty(&erase_ppa);
 
 	/* Assign lbas to ppas and populate request structure */
-	err = pblk_setup_w_rq(pblk, rqd, c_ctx, &erase_ppa);
+	err = pblk_setup_w_rq(pblk, rqd, &erase_ppa);
 	if (err) {
 		pr_err("pblk: could not setup write request: %d\n", err);
 		return NVM_IO_ERR;
 	}
 
-	if (likely(ppa_empty(erase_ppa))) {
-		/* Submit metadata write for previous data line */
-		err = pblk_sched_meta_io(pblk, rqd->ppa_list, rqd->nr_ppas);
-		if (err) {
-			pr_err("pblk: metadata I/O submission failed: %d", err);
-			return NVM_IO_ERR;
-		}
+	meta_line = pblk_should_submit_meta_io(pblk, rqd);
 
-		/* Submit data write for current data line */
-		err = pblk_submit_io(pblk, rqd);
-		if (err) {
-			pr_err("pblk: data I/O submission failed: %d\n", err);
-			return NVM_IO_ERR;
-		}
-	} else {
-		/* Submit data write for current data line */
-		err = pblk_submit_io(pblk, rqd);
-		if (err) {
-			pr_err("pblk: data I/O submission failed: %d\n", err);
-			return NVM_IO_ERR;
-		}
+	/* Submit data write for current data line */
+	err = pblk_submit_io(pblk, rqd);
+	if (err) {
+		pr_err("pblk: data I/O submission failed: %d\n", err);
+		return NVM_IO_ERR;
+	}
 
-		/* Submit available erase for next data line */
+	if (!ppa_empty(erase_ppa)) {
+		/* Submit erase for next data line */
 		if (pblk_blk_erase_async(pblk, erase_ppa)) {
 			struct pblk_line *e_line = pblk_line_get_erase(pblk);
 			struct nvm_tgt_dev *dev = pblk->dev;
@@ -498,6 +474,15 @@ static int pblk_submit_io_set(struct pblk *pblk, struct nvm_rq *rqd)
 		}
 	}
 
+	if (meta_line) {
+		/* Submit metadata write for previous data line */
+		err = pblk_submit_meta_io(pblk, meta_line);
+		if (err) {
+			pr_err("pblk: metadata I/O submission failed: %d", err);
+			return NVM_IO_ERR;
+		}
+	}
+
 	return NVM_IO_OK;
 }
 
-- 
2.7.4
