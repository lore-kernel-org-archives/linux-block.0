Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mail-wm0-f67.google.com ([74.125.82.67]:55969 "EHLO
        mail-wm0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1758297AbdJMMrn (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 13 Oct 2017 08:47:43 -0400
Received: by mail-wm0-f67.google.com with SMTP id u138so21645447wmu.4
        for <linux-block@vger.kernel.org>; Fri, 13 Oct 2017 05:47:42 -0700 (PDT)
From: =?UTF-8?q?Matias=20Bj=C3=B8rling?= <m@bjorling.me>
To: axboe@fb.com
Cc: linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        =?UTF-8?q?Javier=20Gonz=C3=A1lez?= <javier@cnexlabs.com>,
        =?UTF-8?q?Matias=20Bj=C3=B8rling?= <m@bjorling.me>
Subject: [GIT PULL 37/58] lightnvm: pblk: enable 1 LUN configuration
Date: Fri, 13 Oct 2017 14:46:26 +0200
Message-Id: <20171013124647.32668-38-m@bjorling.me>
In-Reply-To: <20171013124647.32668-1-m@bjorling.me>
References: <20171013124647.32668-1-m@bjorling.me>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

From: Javier González <javier@cnexlabs.com>

Metadata I/Os are scheduled to minimize their impact on user data I/Os.
When there are enough LUNs instantiated (i.e., enough bandwidth), it is
easy to interleave metadata and data one after the other so that
metadata I/Os are the ones being blocked and not vice-versa.

We do this by calculating the distance between the I/Os in terms of the
LUNs that are not in used, and selecting a free LUN that satisfies a
the simple heuristic that metadata is scheduled behind. The per-LUN
semaphores guarantee consistency. This works fine on >1 LUN
configuration. However, when a single LUN is instantiated, this design
leads to a deadlock, where metadata waits to be scheduled on a free LUN.

This patch implements the 1 LUN case by simply scheduling the metadada
I/O after the data I/O. In the process, we refactor the way a line is
replaced to ensure that metadata writes are submitted after data writes
in order to guarantee block sequentiality. Note that, since there is
only one LUN, both I/Os will block each other by design. However, such
configuration only pursues tight read latencies, not write bandwidth.

Signed-off-by: Javier González <javier@cnexlabs.com>
Signed-off-by: Matias Bjørling <m@bjorling.me>
---
 drivers/lightnvm/pblk-core.c | 17 ++++++++++-------
 drivers/lightnvm/pblk-init.c |  8 ++++++--
 drivers/lightnvm/pblk-map.c  | 21 ++++++++++++---------
 drivers/lightnvm/pblk.h      |  2 +-
 4 files changed, 29 insertions(+), 19 deletions(-)

diff --git a/drivers/lightnvm/pblk-core.c b/drivers/lightnvm/pblk-core.c
index 0a41fb9..e38e918 100644
--- a/drivers/lightnvm/pblk-core.c
+++ b/drivers/lightnvm/pblk-core.c
@@ -1372,17 +1372,17 @@ void pblk_pipeline_stop(struct pblk *pblk)
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
@@ -1390,7 +1390,7 @@ void pblk_line_replace_data(struct pblk *pblk)
 		l_mg->data_line = NULL;
 		l_mg->data_next = NULL;
 		spin_unlock(&l_mg->free_lock);
-		return;
+		goto out;
 	}
 
 	pblk_line_setup_metadata(new, l_mg, &pblk->lm);
@@ -1402,7 +1402,7 @@ void pblk_line_replace_data(struct pblk *pblk)
 		/* If line is not fully erased, erase it */
 		if (atomic_read(&new->left_eblks)) {
 			if (pblk_line_erase(pblk, new))
-				return;
+				goto out;
 		} else {
 			io_schedule();
 		}
@@ -1413,7 +1413,7 @@ void pblk_line_replace_data(struct pblk *pblk)
 	if (!pblk_line_init_metadata(pblk, new, cur)) {
 		new = pblk_line_retry(pblk, new);
 		if (!new)
-			return;
+			goto out;
 
 		goto retry_setup;
 	}
@@ -1421,7 +1421,7 @@ void pblk_line_replace_data(struct pblk *pblk)
 	if (!pblk_line_init_bb(pblk, new, 1)) {
 		new = pblk_line_retry(pblk, new);
 		if (!new)
-			return;
+			goto out;
 
 		goto retry_setup;
 	}
@@ -1445,6 +1445,9 @@ void pblk_line_replace_data(struct pblk *pblk)
 
 	if (is_next)
 		pblk_rl_free_lines_dec(&pblk->rl, l_mg->data_next);
+
+out:
+	return new;
 }
 
 void pblk_line_free(struct pblk *pblk, struct pblk_line *line)
diff --git a/drivers/lightnvm/pblk-init.c b/drivers/lightnvm/pblk-init.c
index 3452764..3c37491 100644
--- a/drivers/lightnvm/pblk-init.c
+++ b/drivers/lightnvm/pblk-init.c
@@ -711,8 +711,12 @@ static int pblk_lines_init(struct pblk *pblk)
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
index fddb924..3bc4c94 100644
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
 
diff --git a/drivers/lightnvm/pblk.h b/drivers/lightnvm/pblk.h
index e470437..191b1ec 100644
--- a/drivers/lightnvm/pblk.h
+++ b/drivers/lightnvm/pblk.h
@@ -719,7 +719,7 @@ struct bio *pblk_bio_map_addr(struct pblk *pblk, void *data,
 			      int alloc_type, gfp_t gfp_mask);
 struct pblk_line *pblk_line_get(struct pblk *pblk);
 struct pblk_line *pblk_line_get_first_data(struct pblk *pblk);
-void pblk_line_replace_data(struct pblk *pblk);
+struct pblk_line *pblk_line_replace_data(struct pblk *pblk);
 int pblk_line_recov_alloc(struct pblk *pblk, struct pblk_line *line);
 void pblk_line_recov_close(struct pblk *pblk, struct pblk_line *line);
 struct pblk_line *pblk_line_get_data(struct pblk *pblk);
-- 
2.9.3
