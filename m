Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mail-wm0-f49.google.com ([74.125.82.49]:35659 "EHLO
        mail-wm0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753372AbdIFKwx (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Wed, 6 Sep 2017 06:52:53 -0400
Received: by mail-wm0-f49.google.com with SMTP id f199so7945742wme.0
        for <linux-block@vger.kernel.org>; Wed, 06 Sep 2017 03:52:52 -0700 (PDT)
From: "=?UTF-8?q?Javier=20Gonz=C3=A1lez?=" <jg@lightnvm.io>
To: mb@lightnvm.io, axboe@fb.com
Cc: linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        =?UTF-8?q?Javier=20Gonz=C3=A1lez?= <javier@cnexlabs.com>,
        =?UTF-8?q?Matias=20Bj=C3=B8rling?= <matias@cnexlabs.com>
Subject: [PATCH 16/18] lightnvm: pblk: enable 1 LUN configuration
Date: Wed,  6 Sep 2017 12:51:09 +0200
Message-Id: <1504695071-25928-17-git-send-email-javier@cnexlabs.com>
In-Reply-To: <1504695071-25928-1-git-send-email-javier@cnexlabs.com>
References: <1504695071-25928-1-git-send-email-javier@cnexlabs.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

Metadata I/Os are scheduled to minimize their impact on user data I/Os.
When there are enough LUNs instantiated (i.e., enought bandwidth), it is
easy to interleave metadata and data one after the other so that
metadata I/Os are the ones being blocked and not viceversa.

We do this by calculating the distance between the I/Os in terms of the
LUNs that are not in used, and selecting a free LUN that satisfies a
the simple heuristic that medatata is scheduled behind. The per-LUN
semaphores guarantee consistency. This works fine on >1 LUN
configuration. However, when a signle LUN is instantiated, this design
leads to a deadlock, where metadata waits to be scheduled on a free LUN.

This patch implements the 1 LUN case by simply scheduling the medatada
I/O after the data I/O. In the process, we refactor the way a line is
replaced to ensure that metadata writes are submitted after data writes
in order to guarantee block sequentiality. Note that, since there is
only one LUN, both I/Os will block each other by design. However, such
configuration only pursues tight read latencies, not write bandwidth.

Signed-off-by: Javier González <javier@cnexlabs.com>
Signed-off-by: Matias Bjørling <matias@cnexlabs.com>
---
 drivers/lightnvm/pblk-core.c  | 17 ++++++++++-------
 drivers/lightnvm/pblk-init.c  |  8 ++++++--
 drivers/lightnvm/pblk-map.c   | 21 ++++++++++++---------
 drivers/lightnvm/pblk-write.c |  8 +++++---
 drivers/lightnvm/pblk.h       |  2 +-
 5 files changed, 34 insertions(+), 22 deletions(-)

diff --git a/drivers/lightnvm/pblk-core.c b/drivers/lightnvm/pblk-core.c
index 1f746e31e379..873b66200678 100644
--- a/drivers/lightnvm/pblk-core.c
+++ b/drivers/lightnvm/pblk-core.c
@@ -1326,17 +1326,17 @@ void pblk_pipeline_stop(struct pblk *pblk)
 	spin_unlock(&l_mg->free_lock);
 }
 
-void pblk_line_replace_data(struct pblk *pblk)
+struct pblk_line *pblk_line_replace_data(struct pblk *pblk)
 {
 	struct pblk_line_mgmt *l_mg = &pblk->l_mg;
-	struct pblk_line *cur, *new;
+	struct pblk_line *cur, *new = NULL;
 	unsigned int left_seblks;
 	int is_next = 0;
 
 	cur = l_mg->data_line;
 	new = l_mg->data_next;
 	if (!new)
-		return;
+		goto out;
 	l_mg->data_line = new;
 
 	spin_lock(&l_mg->free_lock);
@@ -1344,7 +1344,7 @@ void pblk_line_replace_data(struct pblk *pblk)
 		l_mg->data_line = NULL;
 		l_mg->data_next = NULL;
 		spin_unlock(&l_mg->free_lock);
-		return;
+		goto out;
 	}
 
 	pblk_line_setup_metadata(new, l_mg, &pblk->lm);
@@ -1356,7 +1356,7 @@ void pblk_line_replace_data(struct pblk *pblk)
 		/* If line is not fully erased, erase it */
 		if (atomic_read(&new->left_eblks)) {
 			if (pblk_line_erase(pblk, new))
-				return;
+				goto out;
 		} else {
 			io_schedule();
 		}
@@ -1367,7 +1367,7 @@ void pblk_line_replace_data(struct pblk *pblk)
 	if (!pblk_line_init_metadata(pblk, new, cur)) {
 		new = pblk_line_retry(pblk, new);
 		if (!new)
-			return;
+			goto out;
 
 		goto retry_setup;
 	}
@@ -1375,7 +1375,7 @@ void pblk_line_replace_data(struct pblk *pblk)
 	if (!pblk_line_init_bb(pblk, new, 1)) {
 		new = pblk_line_retry(pblk, new);
 		if (!new)
-			return;
+			goto out;
 
 		goto retry_setup;
 	}
@@ -1399,6 +1399,9 @@ void pblk_line_replace_data(struct pblk *pblk)
 
 	if (is_next)
 		pblk_rl_free_lines_dec(&pblk->rl, l_mg->data_next);
+
+out:
+	return new;
 }
 
 void pblk_line_free(struct pblk *pblk, struct pblk_line *line)
diff --git a/drivers/lightnvm/pblk-init.c b/drivers/lightnvm/pblk-init.c
index 12c05aebac16..0409839cc8fc 100644
--- a/drivers/lightnvm/pblk-init.c
+++ b/drivers/lightnvm/pblk-init.c
@@ -714,8 +714,12 @@ static int pblk_lines_init(struct pblk *pblk)
 	}
 
 	lm->emeta_bb = geo->nr_luns - i;
-	lm->min_blk_line = 1 + DIV_ROUND_UP(lm->smeta_sec + lm->emeta_sec[0],
-							geo->sec_per_blk);
+
+	lm->min_blk_line = 1;
+	if (geo->nr_luns > 1)
+		lm->min_blk_line += DIV_ROUND_UP(lm->smeta_sec +
+					lm->emeta_sec[0], geo->sec_per_blk);
+
 	if (lm->min_blk_line > lm->blk_per_line) {
 		pr_err("pblk: config. not supported. Min. LUN in line:%d\n",
 							lm->blk_per_line);
diff --git a/drivers/lightnvm/pblk-map.c b/drivers/lightnvm/pblk-map.c
index fddb924f6dde..3bc4c94f9cf2 100644
--- a/drivers/lightnvm/pblk-map.c
+++ b/drivers/lightnvm/pblk-map.c
@@ -25,13 +25,23 @@ static void pblk_map_page_data(struct pblk *pblk, unsigned int sentry,
 			       unsigned int valid_secs)
 {
 	struct pblk_line *line = pblk_line_get_data(pblk);
-	struct pblk_emeta *emeta = line->emeta;
+	struct pblk_emeta *emeta;
 	struct pblk_w_ctx *w_ctx;
-	__le64 *lba_list = emeta_to_lbas(pblk, emeta->buf);
+	__le64 *lba_list;
 	u64 paddr;
 	int nr_secs = pblk->min_write_pgs;
 	int i;
 
+	if (pblk_line_is_full(line)) {
+		struct pblk_line *prev_line = line;
+
+		line = pblk_line_replace_data(pblk);
+		pblk_line_close_meta(pblk, prev_line);
+	}
+
+	emeta = line->emeta;
+	lba_list = emeta_to_lbas(pblk, emeta->buf);
+
 	paddr = pblk_alloc_page(pblk, line, nr_secs);
 
 	for (i = 0; i < nr_secs; i++, paddr++) {
@@ -60,13 +70,6 @@ static void pblk_map_page_data(struct pblk *pblk, unsigned int sentry,
 		}
 	}
 
-	if (pblk_line_is_full(line)) {
-		struct pblk_line *prev_line = line;
-
-		pblk_line_replace_data(pblk);
-		pblk_line_close_meta(pblk, prev_line);
-	}
-
 	pblk_down_rq(pblk, ppa_list, nr_secs, lun_bitmap);
 }
 
diff --git a/drivers/lightnvm/pblk-write.c b/drivers/lightnvm/pblk-write.c
index fb4d9c3983db..73300c059784 100644
--- a/drivers/lightnvm/pblk-write.c
+++ b/drivers/lightnvm/pblk-write.c
@@ -188,7 +188,8 @@ static void pblk_end_io_write_meta(struct nvm_rq *rqd)
 	struct pblk_emeta *emeta = line->emeta;
 	int sync;
 
-	pblk_up_page(pblk, rqd->ppa_list, rqd->nr_ppas);
+	if (dev->geo.nr_luns > 1)
+		pblk_up_page(pblk, rqd->ppa_list, rqd->nr_ppas);
 
 	if (rqd->error) {
 		pblk_log_write_err(pblk, rqd);
@@ -332,7 +333,7 @@ static inline int pblk_valid_meta_ppa(struct pblk *pblk,
 	 * the distance to not be optimal, but allow metadata I/Os to succeed.
 	 */
 	ppa_opt = addr_to_gen_ppa(pblk, paddr + data_line->meta_distance, 0);
-	if (unlikely(ppa_opt.ppa == ppa.ppa)) {
+	if (geo->nr_luns > 1 && unlikely(ppa_opt.ppa == ppa.ppa)) {
 		data_line->meta_distance--;
 		return 0;
 	}
@@ -414,7 +415,8 @@ int pblk_submit_meta_io(struct pblk *pblk, struct pblk_line *meta_line)
 		spin_unlock(&l_mg->close_lock);
 	}
 
-	pblk_down_page(pblk, rqd->ppa_list, rqd->nr_ppas);
+	if (geo->nr_luns > 1)
+		pblk_down_page(pblk, rqd->ppa_list, rqd->nr_ppas);
 
 	ret = pblk_submit_io(pblk, rqd);
 	if (ret) {
diff --git a/drivers/lightnvm/pblk.h b/drivers/lightnvm/pblk.h
index 2ae9d94e9852..f6d2e1e72057 100644
--- a/drivers/lightnvm/pblk.h
+++ b/drivers/lightnvm/pblk.h
@@ -716,7 +716,7 @@ struct bio *pblk_bio_map_addr(struct pblk *pblk, void *data,
 			      int alloc_type, gfp_t gfp_mask, int reading);
 struct pblk_line *pblk_line_get(struct pblk *pblk);
 struct pblk_line *pblk_line_get_first_data(struct pblk *pblk);
-void pblk_line_replace_data(struct pblk *pblk);
+struct pblk_line *pblk_line_replace_data(struct pblk *pblk);
 int pblk_line_recov_alloc(struct pblk *pblk, struct pblk_line *line);
 void pblk_line_recov_close(struct pblk *pblk, struct pblk_line *line);
 struct pblk_line *pblk_line_get_data(struct pblk *pblk);
-- 
2.7.4
