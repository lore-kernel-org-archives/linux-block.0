Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mail-pl1-f196.google.com ([209.85.214.196]:36908 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726613AbeJISaf (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Tue, 9 Oct 2018 14:30:35 -0400
Received: by mail-pl1-f196.google.com with SMTP id az3-v6so673810plb.4
        for <linux-block@vger.kernel.org>; Tue, 09 Oct 2018 04:14:08 -0700 (PDT)
From: =?UTF-8?q?Matias=20Bj=C3=B8rling?= <mb@lightnvm.io>
To: axboe@fb.com
Cc: linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        Hans Holmberg <hans.holmberg@cnexlabs.com>,
        =?UTF-8?q?Matias=20Bj=C3=B8rling?= <mb@lightnvm.io>
Subject: [GIT PULL 16/45] lightnvm: introduce nvm_rq_to_ppa_list
Date: Tue,  9 Oct 2018 13:11:46 +0200
Message-Id: <20181009111215.7653-17-mb@lightnvm.io>
In-Reply-To: <20181009111215.7653-1-mb@lightnvm.io>
References: <20181009111215.7653-1-mb@lightnvm.io>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

From: Hans Holmberg <hans.holmberg@cnexlabs.com>

There is a number of places in the lightnvm subsystem where the user
iterates over the ppa list. Before iterating, the user must know if it
is a single or multiple LBAs due to vector commands using either the
nvm_rq ->ppa_addr or ->ppa_list fields on command submission, which
leads to open-coding the if/else statement.

Instead of having multiple if/else's, move it into a function that can
be called by its users.

A nice side effect of this cleanup is that this patch fixes up a
bunch of cases where we don't consider the single-ppa case in pblk.

Signed-off-by: Hans Holmberg <hans.holmberg@cnexlabs.com>
Signed-off-by: Matias Bjørling <mb@lightnvm.io>
---
 drivers/lightnvm/core.c          | 14 ++++----------
 drivers/lightnvm/pblk-map.c      | 10 ++++++----
 drivers/lightnvm/pblk-read.c     | 11 ++++-------
 drivers/lightnvm/pblk-recovery.c |  9 ++++++---
 drivers/lightnvm/pblk-write.c    | 18 ++++++++----------
 drivers/lightnvm/pblk.h          |  4 +---
 include/linux/lightnvm.h         |  5 +++++
 7 files changed, 34 insertions(+), 37 deletions(-)

diff --git a/drivers/lightnvm/core.c b/drivers/lightnvm/core.c
index 8df188e0767e..efb976a863d2 100644
--- a/drivers/lightnvm/core.c
+++ b/drivers/lightnvm/core.c
@@ -603,22 +603,16 @@ static void nvm_ppa_dev_to_tgt(struct nvm_tgt_dev *tgt_dev,
 
 static void nvm_rq_tgt_to_dev(struct nvm_tgt_dev *tgt_dev, struct nvm_rq *rqd)
 {
-	if (rqd->nr_ppas == 1) {
-		nvm_ppa_tgt_to_dev(tgt_dev, &rqd->ppa_addr, 1);
-		return;
-	}
+	struct ppa_addr *ppa_list = nvm_rq_to_ppa_list(rqd);
 
-	nvm_ppa_tgt_to_dev(tgt_dev, rqd->ppa_list, rqd->nr_ppas);
+	nvm_ppa_tgt_to_dev(tgt_dev, ppa_list, rqd->nr_ppas);
 }
 
 static void nvm_rq_dev_to_tgt(struct nvm_tgt_dev *tgt_dev, struct nvm_rq *rqd)
 {
-	if (rqd->nr_ppas == 1) {
-		nvm_ppa_dev_to_tgt(tgt_dev, &rqd->ppa_addr, 1);
-		return;
-	}
+	struct ppa_addr *ppa_list = nvm_rq_to_ppa_list(rqd);
 
-	nvm_ppa_dev_to_tgt(tgt_dev, rqd->ppa_list, rqd->nr_ppas);
+	nvm_ppa_dev_to_tgt(tgt_dev, ppa_list, rqd->nr_ppas);
 }
 
 int nvm_register_tgt_type(struct nvm_tgt_type *tt)
diff --git a/drivers/lightnvm/pblk-map.c b/drivers/lightnvm/pblk-map.c
index 953ca31dda68..dc0efb852475 100644
--- a/drivers/lightnvm/pblk-map.c
+++ b/drivers/lightnvm/pblk-map.c
@@ -88,13 +88,14 @@ void pblk_map_rq(struct pblk *pblk, struct nvm_rq *rqd, unsigned int sentry,
 		 unsigned int off)
 {
 	struct pblk_sec_meta *meta_list = rqd->meta_list;
+	struct ppa_addr *ppa_list = nvm_rq_to_ppa_list(rqd);
 	unsigned int map_secs;
 	int min = pblk->min_write_pgs;
 	int i;
 
 	for (i = off; i < rqd->nr_ppas; i += min) {
 		map_secs = (i + min > valid_secs) ? (valid_secs % min) : min;
-		if (pblk_map_page_data(pblk, sentry + i, &rqd->ppa_list[i],
+		if (pblk_map_page_data(pblk, sentry + i, &ppa_list[i],
 					lun_bitmap, &meta_list[i], map_secs)) {
 			bio_put(rqd->bio);
 			pblk_free_rqd(pblk, rqd, PBLK_WRITE);
@@ -112,6 +113,7 @@ void pblk_map_erase_rq(struct pblk *pblk, struct nvm_rq *rqd,
 	struct nvm_geo *geo = &dev->geo;
 	struct pblk_line_meta *lm = &pblk->lm;
 	struct pblk_sec_meta *meta_list = rqd->meta_list;
+	struct ppa_addr *ppa_list = nvm_rq_to_ppa_list(rqd);
 	struct pblk_line *e_line, *d_line;
 	unsigned int map_secs;
 	int min = pblk->min_write_pgs;
@@ -119,14 +121,14 @@ void pblk_map_erase_rq(struct pblk *pblk, struct nvm_rq *rqd,
 
 	for (i = 0; i < rqd->nr_ppas; i += min) {
 		map_secs = (i + min > valid_secs) ? (valid_secs % min) : min;
-		if (pblk_map_page_data(pblk, sentry + i, &rqd->ppa_list[i],
+		if (pblk_map_page_data(pblk, sentry + i, &ppa_list[i],
 					lun_bitmap, &meta_list[i], map_secs)) {
 			bio_put(rqd->bio);
 			pblk_free_rqd(pblk, rqd, PBLK_WRITE);
 			pblk_pipeline_stop(pblk);
 		}
 
-		erase_lun = pblk_ppa_to_pos(geo, rqd->ppa_list[i]);
+		erase_lun = pblk_ppa_to_pos(geo, ppa_list[i]);
 
 		/* line can change after page map. We might also be writing the
 		 * last line.
@@ -141,7 +143,7 @@ void pblk_map_erase_rq(struct pblk *pblk, struct nvm_rq *rqd,
 			set_bit(erase_lun, e_line->erase_bitmap);
 			atomic_dec(&e_line->left_eblks);
 
-			*erase_ppa = rqd->ppa_list[i];
+			*erase_ppa = ppa_list[i];
 			erase_ppa->a.blk = e_line->id;
 
 			spin_unlock(&e_line->lock);
diff --git a/drivers/lightnvm/pblk-read.c b/drivers/lightnvm/pblk-read.c
index 49744caaa300..d3ff8c3e9010 100644
--- a/drivers/lightnvm/pblk-read.c
+++ b/drivers/lightnvm/pblk-read.c
@@ -116,10 +116,9 @@ static void pblk_read_check_seq(struct pblk *pblk, struct nvm_rq *rqd,
 
 		if (lba != blba + i) {
 #ifdef CONFIG_NVM_PBLK_DEBUG
-			struct ppa_addr *p;
+			struct ppa_addr *ppa_list = nvm_rq_to_ppa_list(rqd);
 
-			p = (nr_lbas == 1) ? &rqd->ppa_list[i] : &rqd->ppa_addr;
-			print_ppa(pblk, p, "seq", i);
+			print_ppa(pblk, &ppa_list[i], "seq", i);
 #endif
 			pblk_err(pblk, "corrupted read LBA (%llu/%llu)\n",
 							lba, (u64)blba + i);
@@ -148,11 +147,9 @@ static void pblk_read_check_rand(struct pblk *pblk, struct nvm_rq *rqd,
 
 		if (lba != meta_lba) {
 #ifdef CONFIG_NVM_PBLK_DEBUG
-			struct ppa_addr *p;
-			int nr_ppas = rqd->nr_ppas;
+			struct ppa_addr *ppa_list = nvm_rq_to_ppa_list(rqd);
 
-			p = (nr_ppas == 1) ? &rqd->ppa_list[j] : &rqd->ppa_addr;
-			print_ppa(pblk, p, "seq", j);
+			print_ppa(pblk, &ppa_list[j], "seq", j);
 #endif
 			pblk_err(pblk, "corrupted read LBA (%llu/%llu)\n",
 								lba, meta_lba);
diff --git a/drivers/lightnvm/pblk-recovery.c b/drivers/lightnvm/pblk-recovery.c
index cf629ab016ba..3bd2b6b0a359 100644
--- a/drivers/lightnvm/pblk-recovery.c
+++ b/drivers/lightnvm/pblk-recovery.c
@@ -161,6 +161,8 @@ static int pblk_recov_read_oob(struct pblk *pblk, struct pblk_line *line,
 	if (pblk_io_aligned(pblk, rq_ppas))
 		rqd->is_seq = 1;
 
+	ppa_list = nvm_rq_to_ppa_list(rqd);
+
 	for (i = 0; i < rqd->nr_ppas; ) {
 		struct ppa_addr ppa;
 		int pos;
@@ -175,7 +177,7 @@ static int pblk_recov_read_oob(struct pblk *pblk, struct pblk_line *line,
 		}
 
 		for (j = 0; j < pblk->min_write_pgs; j++, i++, r_ptr_int++)
-			rqd->ppa_list[i] =
+			ppa_list[i] =
 				addr_to_gen_ppa(pblk, r_ptr_int, line->id);
 	}
 
@@ -202,7 +204,7 @@ static int pblk_recov_read_oob(struct pblk *pblk, struct pblk_line *line,
 		if (lba == ADDR_EMPTY || lba > pblk->rl.nr_secs)
 			continue;
 
-		pblk_update_map(pblk, lba, rqd->ppa_list[i]);
+		pblk_update_map(pblk, lba, ppa_list[i]);
 	}
 
 	left_ppas -= rq_ppas;
@@ -221,10 +223,11 @@ static void pblk_recov_complete(struct kref *ref)
 
 static void pblk_end_io_recov(struct nvm_rq *rqd)
 {
+	struct ppa_addr *ppa_list = nvm_rq_to_ppa_list(rqd);
 	struct pblk_pad_rq *pad_rq = rqd->private;
 	struct pblk *pblk = pad_rq->pblk;
 
-	pblk_up_page(pblk, rqd->ppa_list, rqd->nr_ppas);
+	pblk_up_page(pblk, ppa_list, rqd->nr_ppas);
 
 	pblk_free_rqd(pblk, rqd, PBLK_WRITE_INT);
 
diff --git a/drivers/lightnvm/pblk-write.c b/drivers/lightnvm/pblk-write.c
index 625ed5a3a020..c20bb7f6d703 100644
--- a/drivers/lightnvm/pblk-write.c
+++ b/drivers/lightnvm/pblk-write.c
@@ -208,15 +208,10 @@ static void pblk_submit_rec(struct work_struct *work)
 	struct pblk *pblk = recovery->pblk;
 	struct nvm_rq *rqd = recovery->rqd;
 	struct pblk_c_ctx *c_ctx = nvm_rq_to_pdu(rqd);
-	struct ppa_addr *ppa_list;
+	struct ppa_addr *ppa_list = nvm_rq_to_ppa_list(rqd);
 
 	pblk_log_write_err(pblk, rqd);
 
-	if (rqd->nr_ppas == 1)
-		ppa_list = &rqd->ppa_addr;
-	else
-		ppa_list = rqd->ppa_list;
-
 	pblk_map_remaining(pblk, ppa_list);
 	pblk_queue_resubmit(pblk, c_ctx);
 
@@ -273,9 +268,10 @@ static void pblk_end_io_write_meta(struct nvm_rq *rqd)
 	struct pblk_g_ctx *m_ctx = nvm_rq_to_pdu(rqd);
 	struct pblk_line *line = m_ctx->private;
 	struct pblk_emeta *emeta = line->emeta;
+	struct ppa_addr *ppa_list = nvm_rq_to_ppa_list(rqd);
 	int sync;
 
-	pblk_up_page(pblk, rqd->ppa_list, rqd->nr_ppas);
+	pblk_up_page(pblk, ppa_list, rqd->nr_ppas);
 
 	if (rqd->error) {
 		pblk_log_write_err(pblk, rqd);
@@ -375,6 +371,7 @@ int pblk_submit_meta_io(struct pblk *pblk, struct pblk_line *meta_line)
 	struct pblk_line_mgmt *l_mg = &pblk->l_mg;
 	struct pblk_line_meta *lm = &pblk->lm;
 	struct pblk_emeta *emeta = meta_line->emeta;
+	struct ppa_addr *ppa_list;
 	struct pblk_g_ctx *m_ctx;
 	struct bio *bio;
 	struct nvm_rq *rqd;
@@ -409,12 +406,13 @@ int pblk_submit_meta_io(struct pblk *pblk, struct pblk_line *meta_line)
 	if (ret)
 		goto fail_free_bio;
 
+	ppa_list = nvm_rq_to_ppa_list(rqd);
 	for (i = 0; i < rqd->nr_ppas; ) {
 		spin_lock(&meta_line->lock);
 		paddr = __pblk_alloc_page(pblk, meta_line, rq_ppas);
 		spin_unlock(&meta_line->lock);
 		for (j = 0; j < rq_ppas; j++, i++, paddr++)
-			rqd->ppa_list[i] = addr_to_gen_ppa(pblk, paddr, id);
+			ppa_list[i] = addr_to_gen_ppa(pblk, paddr, id);
 	}
 
 	spin_lock(&l_mg->close_lock);
@@ -423,7 +421,7 @@ int pblk_submit_meta_io(struct pblk *pblk, struct pblk_line *meta_line)
 		list_del(&meta_line->list);
 	spin_unlock(&l_mg->close_lock);
 
-	pblk_down_page(pblk, rqd->ppa_list, rqd->nr_ppas);
+	pblk_down_page(pblk, ppa_list, rqd->nr_ppas);
 
 	ret = pblk_submit_io(pblk, rqd);
 	if (ret) {
@@ -434,7 +432,7 @@ int pblk_submit_meta_io(struct pblk *pblk, struct pblk_line *meta_line)
 	return NVM_IO_OK;
 
 fail_rollback:
-	pblk_up_page(pblk, rqd->ppa_list, rqd->nr_ppas);
+	pblk_up_page(pblk, ppa_list, rqd->nr_ppas);
 	spin_lock(&l_mg->close_lock);
 	pblk_dealloc_page(pblk, meta_line, rq_ppas);
 	list_add(&meta_line->list, &meta_line->list);
diff --git a/drivers/lightnvm/pblk.h b/drivers/lightnvm/pblk.h
index 1865ac1560fa..60c509a00574 100644
--- a/drivers/lightnvm/pblk.h
+++ b/drivers/lightnvm/pblk.h
@@ -1362,9 +1362,7 @@ static inline int pblk_boundary_ppa_checks(struct nvm_tgt_dev *tgt_dev,
 static inline int pblk_check_io(struct pblk *pblk, struct nvm_rq *rqd)
 {
 	struct nvm_tgt_dev *dev = pblk->dev;
-	struct ppa_addr *ppa_list;
-
-	ppa_list = (rqd->nr_ppas > 1) ? rqd->ppa_list : &rqd->ppa_addr;
+	struct ppa_addr *ppa_list = nvm_rq_to_ppa_list(rqd);
 
 	if (pblk_boundary_ppa_checks(dev, ppa_list, rqd->nr_ppas)) {
 		WARN_ON(1);
diff --git a/include/linux/lightnvm.h b/include/linux/lightnvm.h
index 77743a02ec0d..50ac5b21297c 100644
--- a/include/linux/lightnvm.h
+++ b/include/linux/lightnvm.h
@@ -320,6 +320,11 @@ static inline void *nvm_rq_to_pdu(struct nvm_rq *rqdata)
 	return rqdata + 1;
 }
 
+static inline struct ppa_addr *nvm_rq_to_ppa_list(struct nvm_rq *rqd)
+{
+	return (rqd->nr_ppas > 1) ? rqd->ppa_list : &rqd->ppa_addr;
+}
+
 enum {
 	NVM_BLK_ST_FREE =	0x1,	/* Free block */
 	NVM_BLK_ST_TGT =	0x2,	/* Block in use by target */
-- 
2.17.1
