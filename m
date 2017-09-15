Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mail-wm0-f47.google.com ([74.125.82.47]:46533 "EHLO
        mail-wm0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751434AbdIOMgB (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 15 Sep 2017 08:36:01 -0400
Received: by mail-wm0-f47.google.com with SMTP id i189so7960596wmf.1
        for <linux-block@vger.kernel.org>; Fri, 15 Sep 2017 05:36:01 -0700 (PDT)
From: "=?UTF-8?q?Javier=20Gonz=C3=A1lez?=" <jg@lightnvm.io>
To: linux-block@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
        =?UTF-8?q?Javier=20Gonz=C3=A1lez?= <javier@cnexlabs.com>
Subject: [PATCH] lightnvm: pblk: enable 1 LUN configuration
Date: Fri, 15 Sep 2017 14:35:52 +0200
Message-Id: <1505478953-16915-5-git-send-email-javier@cnexlabs.com>
In-Reply-To: <1505478953-16915-1-git-send-email-javier@cnexlabs.com>
References: <1505478953-16915-1-git-send-email-javier@cnexlabs.com>
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
---
 drivers/lightnvm/pblk-core.c | 17 ++++++++++-------
 drivers/lightnvm/pblk-init.c |  8 ++++++--
 drivers/lightnvm/pblk-map.c  | 21 ++++++++++++---------
 drivers/lightnvm/pblk.h      |  2 +-
 4 files changed, 29 insertions(+), 19 deletions(-)

diff --git a/drivers/lightnvm/pblk-core.c b/drivers/lightnvm/pblk-core.c
index d2587e37034f..64a6a255514e 100644
--- a/drivers/lightnvm/pblk-core.c
+++ b/drivers/lightnvm/pblk-core.c
@@ -1370,17 +1370,17 @@ void pblk_pipeline_stop(struct pblk *pblk)
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
@@ -1388,7 +1388,7 @@ void pblk_line_replace_data(struct pblk *pblk)
 		l_mg->data_line = NULL;
 		l_mg->data_next = NULL;
 		spin_unlock(&l_mg->free_lock);
-		return;
+		goto out;
 	}
 
 	pblk_line_setup_metadata(new, l_mg, &pblk->lm);
@@ -1400,7 +1400,7 @@ void pblk_line_replace_data(struct pblk *pblk)
 		/* If line is not fully erased, erase it */
 		if (atomic_read(&new->left_eblks)) {
 			if (pblk_line_erase(pblk, new))
-				return;
+				goto out;
 		} else {
 			io_schedule();
 		}
@@ -1411,7 +1411,7 @@ void pblk_line_replace_data(struct pblk *pblk)
 	if (!pblk_line_init_metadata(pblk, new, cur)) {
 		new = pblk_line_retry(pblk, new);
 		if (!new)
-			return;
+			goto out;
 
 		goto retry_setup;
 	}
@@ -1419,7 +1419,7 @@ void pblk_line_replace_data(struct pblk *pblk)
 	if (!pblk_line_init_bb(pblk, new, 1)) {
 		new = pblk_line_retry(pblk, new);
 		if (!new)
-			return;
+			goto out;
 
 		goto retry_setup;
 	}
@@ -1443,6 +1443,9 @@ void pblk_line_replace_data(struct pblk *pblk)
 
 	if (is_next)
 		pblk_rl_free_lines_dec(&pblk->rl, l_mg->data_next);
+
+out:
+	return new;
 }
 
 void pblk_line_free(struct pblk *pblk, struct pblk_line *line)
diff --git a/drivers/lightnvm/pblk-init.c b/drivers/lightnvm/pblk-init.c
index 670e5858611e..9d9adcf3e141 100644
--- a/drivers/lightnvm/pblk-init.c
+++ b/drivers/lightnvm/pblk-init.c
@@ -708,8 +708,12 @@ static int pblk_lines_init(struct pblk *pblk)
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
 
diff --git a/drivers/lightnvm/pblk.h b/drivers/lightnvm/pblk.h
index 8e9ae213b707..eaf539715d71 100644
--- a/drivers/lightnvm/pblk.h
+++ b/drivers/lightnvm/pblk.h
@@ -718,7 +718,7 @@ struct bio *pblk_bio_map_addr(struct pblk *pblk, void *data,
 			      int alloc_type, gfp_t gfp_mask);
 struct pblk_line *pblk_line_get(struct pblk *pblk);
 struct pblk_line *pblk_line_get_first_data(struct pblk *pblk);
-void pblk_line_replace_data(struct pblk *pblk);
+struct pblk_line *pblk_line_replace_data(struct pblk *pblk);
 int pblk_line_recov_alloc(struct pblk *pblk, struct pblk_line *line);
 void pblk_line_recov_close(struct pblk *pblk, struct pblk_line *line);
 struct pblk_line *pblk_line_get_data(struct pblk *pblk);
-- 
2.7.4
