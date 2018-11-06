Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mail-it1-f194.google.com ([209.85.166.194]:39721 "EHLO
        mail-it1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388310AbeKFW67 (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Tue, 6 Nov 2018 17:58:59 -0500
Received: by mail-it1-f194.google.com with SMTP id m15so17567044itl.4
        for <linux-block@vger.kernel.org>; Tue, 06 Nov 2018 05:33:44 -0800 (PST)
From: Hans Holmberg <hans.ml.holmberg@owltronix.com>
To: Matias Bjorling <mb@lightnvm.io>
Cc: Javier Gonzales <javier@cnexlabs.com>,
        Sebastien Boisvert <sboisvert@gydle.com>,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        Hans Holmberg <hans.holmberg@cnexlabs.com>
Subject: [PATCH v3 3/7] lightnvm: pblk: stop writes gracefully when running out of lines
Date: Tue,  6 Nov 2018 14:33:26 +0100
Message-Id: <20181106133330.26570-4-hans.ml.holmberg@owltronix.com>
In-Reply-To: <20181106133330.26570-1-hans.ml.holmberg@owltronix.com>
References: <20181106133330.26570-1-hans.ml.holmberg@owltronix.com>
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

From: Hans Holmberg <hans.holmberg@cnexlabs.com>

If mapping fails (i.e. when running out of lines), handle the error
and stop writing.

Signed-off-by: Hans Holmberg <hans.holmberg@cnexlabs.com>
---
 drivers/lightnvm/pblk-map.c   | 47 +++++++++++++++++++++--------------
 drivers/lightnvm/pblk-write.c | 30 ++++++++++++++--------
 drivers/lightnvm/pblk.h       |  4 +--
 3 files changed, 51 insertions(+), 30 deletions(-)

diff --git a/drivers/lightnvm/pblk-map.c b/drivers/lightnvm/pblk-map.c
index 6dcbd44e3acb..5a3c28cce8ab 100644
--- a/drivers/lightnvm/pblk-map.c
+++ b/drivers/lightnvm/pblk-map.c
@@ -33,6 +33,9 @@ static int pblk_map_page_data(struct pblk *pblk, unsigned int sentry,
 	int nr_secs = pblk->min_write_pgs;
 	int i;
 
+	if (!line)
+		return -ENOSPC;
+
 	if (pblk_line_is_full(line)) {
 		struct pblk_line *prev_line = line;
 
@@ -42,8 +45,11 @@ static int pblk_map_page_data(struct pblk *pblk, unsigned int sentry,
 		line = pblk_line_replace_data(pblk);
 		pblk_line_close_meta(pblk, prev_line);
 
-		if (!line)
-			return -EINTR;
+		if (!line) {
+			pblk_pipeline_stop(pblk);
+			return -ENOSPC;
+		}
+
 	}
 
 	emeta = line->emeta;
@@ -84,7 +90,7 @@ static int pblk_map_page_data(struct pblk *pblk, unsigned int sentry,
 	return 0;
 }
 
-void pblk_map_rq(struct pblk *pblk, struct nvm_rq *rqd, unsigned int sentry,
+int pblk_map_rq(struct pblk *pblk, struct nvm_rq *rqd, unsigned int sentry,
 		 unsigned long *lun_bitmap, unsigned int valid_secs,
 		 unsigned int off)
 {
@@ -93,20 +99,22 @@ void pblk_map_rq(struct pblk *pblk, struct nvm_rq *rqd, unsigned int sentry,
 	unsigned int map_secs;
 	int min = pblk->min_write_pgs;
 	int i;
+	int ret;
 
 	for (i = off; i < rqd->nr_ppas; i += min) {
 		map_secs = (i + min > valid_secs) ? (valid_secs % min) : min;
-		if (pblk_map_page_data(pblk, sentry + i, &ppa_list[i],
-					lun_bitmap, &meta_list[i], map_secs)) {
-			bio_put(rqd->bio);
-			pblk_free_rqd(pblk, rqd, PBLK_WRITE);
-			pblk_pipeline_stop(pblk);
-		}
+
+		ret = pblk_map_page_data(pblk, sentry + i, &ppa_list[i],
+					lun_bitmap, &meta_list[i], map_secs);
+		if (ret)
+			return ret;
 	}
+
+	return 0;
 }
 
 /* only if erase_ppa is set, acquire erase semaphore */
-void pblk_map_erase_rq(struct pblk *pblk, struct nvm_rq *rqd,
+int pblk_map_erase_rq(struct pblk *pblk, struct nvm_rq *rqd,
 		       unsigned int sentry, unsigned long *lun_bitmap,
 		       unsigned int valid_secs, struct ppa_addr *erase_ppa)
 {
@@ -119,15 +127,16 @@ void pblk_map_erase_rq(struct pblk *pblk, struct nvm_rq *rqd,
 	unsigned int map_secs;
 	int min = pblk->min_write_pgs;
 	int i, erase_lun;
+	int ret;
+
 
 	for (i = 0; i < rqd->nr_ppas; i += min) {
 		map_secs = (i + min > valid_secs) ? (valid_secs % min) : min;
-		if (pblk_map_page_data(pblk, sentry + i, &ppa_list[i],
-					lun_bitmap, &meta_list[i], map_secs)) {
-			bio_put(rqd->bio);
-			pblk_free_rqd(pblk, rqd, PBLK_WRITE);
-			pblk_pipeline_stop(pblk);
-		}
+
+		ret = pblk_map_page_data(pblk, sentry + i, &ppa_list[i],
+					lun_bitmap, &meta_list[i], map_secs);
+		if (ret)
+			return ret;
 
 		erase_lun = pblk_ppa_to_pos(geo, ppa_list[i]);
 
@@ -163,7 +172,7 @@ void pblk_map_erase_rq(struct pblk *pblk, struct nvm_rq *rqd,
 	 */
 	e_line = pblk_line_get_erase(pblk);
 	if (!e_line)
-		return;
+		return -ENOSPC;
 
 	/* Erase blocks that are bad in this line but might not be in next */
 	if (unlikely(pblk_ppa_empty(*erase_ppa)) &&
@@ -174,7 +183,7 @@ void pblk_map_erase_rq(struct pblk *pblk, struct nvm_rq *rqd,
 		bit = find_next_bit(d_line->blk_bitmap,
 						lm->blk_per_line, bit + 1);
 		if (bit >= lm->blk_per_line)
-			return;
+			return 0;
 
 		spin_lock(&e_line->lock);
 		if (test_bit(bit, e_line->erase_bitmap)) {
@@ -188,4 +197,6 @@ void pblk_map_erase_rq(struct pblk *pblk, struct nvm_rq *rqd,
 		*erase_ppa = pblk->luns[bit].bppa; /* set ch and lun */
 		erase_ppa->a.blk = e_line->id;
 	}
+
+	return 0;
 }
diff --git a/drivers/lightnvm/pblk-write.c b/drivers/lightnvm/pblk-write.c
index 750f04b8a227..2bf78f81862d 100644
--- a/drivers/lightnvm/pblk-write.c
+++ b/drivers/lightnvm/pblk-write.c
@@ -334,12 +334,13 @@ static int pblk_setup_w_rq(struct pblk *pblk, struct nvm_rq *rqd,
 	}
 
 	if (likely(!e_line || !atomic_read(&e_line->left_eblks)))
-		pblk_map_rq(pblk, rqd, c_ctx->sentry, lun_bitmap, valid, 0);
+		ret = pblk_map_rq(pblk, rqd, c_ctx->sentry, lun_bitmap,
+							valid, 0);
 	else
-		pblk_map_erase_rq(pblk, rqd, c_ctx->sentry, lun_bitmap,
+		ret = pblk_map_erase_rq(pblk, rqd, c_ctx->sentry, lun_bitmap,
 							valid, erase_ppa);
 
-	return 0;
+	return ret;
 }
 
 static int pblk_calc_secs_to_sync(struct pblk *pblk, unsigned int secs_avail,
@@ -563,7 +564,7 @@ static void pblk_free_write_rqd(struct pblk *pblk, struct nvm_rq *rqd)
 							c_ctx->nr_padded);
 }
 
-static int pblk_submit_write(struct pblk *pblk)
+static int pblk_submit_write(struct pblk *pblk, int *secs_left)
 {
 	struct bio *bio;
 	struct nvm_rq *rqd;
@@ -572,6 +573,8 @@ static int pblk_submit_write(struct pblk *pblk)
 	unsigned long pos;
 	unsigned int resubmit;
 
+	*secs_left = 0;
+
 	spin_lock(&pblk->resubmit_lock);
 	resubmit = !list_empty(&pblk->resubmit_list);
 	spin_unlock(&pblk->resubmit_lock);
@@ -601,17 +604,17 @@ static int pblk_submit_write(struct pblk *pblk)
 		 */
 		secs_avail = pblk_rb_read_count(&pblk->rwb);
 		if (!secs_avail)
-			return 1;
+			return 0;
 
 		secs_to_flush = pblk_rb_flush_point_count(&pblk->rwb);
 		if (!secs_to_flush && secs_avail < pblk->min_write_pgs)
-			return 1;
+			return 0;
 
 		secs_to_sync = pblk_calc_secs_to_sync(pblk, secs_avail,
 					secs_to_flush);
 		if (secs_to_sync > pblk->max_write_pgs) {
 			pblk_err(pblk, "bad buffer sync calculation\n");
-			return 1;
+			return 0;
 		}
 
 		secs_to_com = (secs_to_sync > secs_avail) ?
@@ -640,6 +643,7 @@ static int pblk_submit_write(struct pblk *pblk)
 	atomic_long_add(secs_to_sync, &pblk->sub_writes);
 #endif
 
+	*secs_left = 1;
 	return 0;
 
 fail_free_bio:
@@ -648,16 +652,22 @@ static int pblk_submit_write(struct pblk *pblk)
 	bio_put(bio);
 	pblk_free_rqd(pblk, rqd, PBLK_WRITE);
 
-	return 1;
+	return -EINTR;
 }
 
 int pblk_write_ts(void *data)
 {
 	struct pblk *pblk = data;
+	int secs_left;
+	int write_failure = 0;
 
 	while (!kthread_should_stop()) {
-		if (!pblk_submit_write(pblk))
-			continue;
+		if (!write_failure) {
+			write_failure = pblk_submit_write(pblk, &secs_left);
+
+			if (secs_left)
+				continue;
+		}
 		set_current_state(TASK_INTERRUPTIBLE);
 		io_schedule();
 	}
diff --git a/drivers/lightnvm/pblk.h b/drivers/lightnvm/pblk.h
index 02bb2e98f8a9..f415aae600c8 100644
--- a/drivers/lightnvm/pblk.h
+++ b/drivers/lightnvm/pblk.h
@@ -871,10 +871,10 @@ int pblk_write_gc_to_cache(struct pblk *pblk, struct pblk_gc_rq *gc_rq);
 /*
  * pblk map
  */
-void pblk_map_erase_rq(struct pblk *pblk, struct nvm_rq *rqd,
+int pblk_map_erase_rq(struct pblk *pblk, struct nvm_rq *rqd,
 		       unsigned int sentry, unsigned long *lun_bitmap,
 		       unsigned int valid_secs, struct ppa_addr *erase_ppa);
-void pblk_map_rq(struct pblk *pblk, struct nvm_rq *rqd, unsigned int sentry,
+int pblk_map_rq(struct pblk *pblk, struct nvm_rq *rqd, unsigned int sentry,
 		 unsigned long *lun_bitmap, unsigned int valid_secs,
 		 unsigned int off);
 
-- 
2.17.1
