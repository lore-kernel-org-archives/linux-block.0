Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mail-wm0-f42.google.com ([74.125.82.42]:34178 "EHLO
        mail-wm0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753332AbdIFKws (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Wed, 6 Sep 2017 06:52:48 -0400
Received: by mail-wm0-f42.google.com with SMTP id 137so27135903wmj.1
        for <linux-block@vger.kernel.org>; Wed, 06 Sep 2017 03:52:47 -0700 (PDT)
From: "=?UTF-8?q?Javier=20Gonz=C3=A1lez?=" <jg@lightnvm.io>
To: mb@lightnvm.io, axboe@fb.com
Cc: linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        =?UTF-8?q?Javier=20Gonz=C3=A1lez?= <javier@cnexlabs.com>,
        =?UTF-8?q?Matias=20Bj=C3=B8rling?= <matias@cnexlabs.com>
Subject: [PATCH 11/18] lightnvm: pblk: refactor read path on GC
Date: Wed,  6 Sep 2017 12:51:04 +0200
Message-Id: <1504695071-25928-12-git-send-email-javier@cnexlabs.com>
In-Reply-To: <1504695071-25928-1-git-send-email-javier@cnexlabs.com>
References: <1504695071-25928-1-git-send-email-javier@cnexlabs.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

Simplify the part of the garbage collector where data is read from the
line being recycled and moved into an internal queue before being copied
to the memory buffer. This allows to get rid of a dedicated function,
which introduces an unnecessary dependency on the code.

Signed-off-by: Javier González <javier@cnexlabs.com>
Signed-off-by: Matias Bjørling <matias@cnexlabs.com>
---
 drivers/lightnvm/pblk-gc.c | 94 +++++++++++++++++++---------------------------
 1 file changed, 39 insertions(+), 55 deletions(-)

diff --git a/drivers/lightnvm/pblk-gc.c b/drivers/lightnvm/pblk-gc.c
index 27ee1f9b19c6..efa86295fbd1 100644
--- a/drivers/lightnvm/pblk-gc.c
+++ b/drivers/lightnvm/pblk-gc.c
@@ -56,57 +56,6 @@ static void pblk_gc_writer_kick(struct pblk_gc *gc)
 	wake_up_process(gc->gc_writer_ts);
 }
 
-/*
- * Responsible for managing all memory related to a gc request. Also in case of
- * failure
- */
-static int pblk_gc_move_valid_secs(struct pblk *pblk, struct pblk_gc_rq *gc_rq)
-{
-	struct nvm_tgt_dev *dev = pblk->dev;
-	struct nvm_geo *geo = &dev->geo;
-	struct pblk_gc *gc = &pblk->gc;
-	struct pblk_line *line = gc_rq->line;
-	void *data;
-	int ret = 0;
-
-	data = vmalloc(gc_rq->nr_secs * geo->sec_size);
-	if (!data) {
-		ret = -ENOMEM;
-		goto fail;
-	}
-
-	gc_rq->data = data;
-
-	/* Read from GC victim block */
-	ret = pblk_submit_read_gc(pblk, gc_rq);
-	if (ret)
-		goto fail;
-
-	if (!gc_rq->secs_to_gc)
-		goto fail;
-
-retry:
-	spin_lock(&gc->w_lock);
-	if (gc->w_entries >= PBLK_GC_RQ_QD) {
-		spin_unlock(&gc->w_lock);
-		pblk_gc_writer_kick(&pblk->gc);
-		usleep_range(128, 256);
-		goto retry;
-	}
-	gc->w_entries++;
-	list_add_tail(&gc_rq->list, &gc->w_list);
-	spin_unlock(&gc->w_lock);
-
-	pblk_gc_writer_kick(&pblk->gc);
-
-	return 0;
-
-fail:
-	pblk_gc_free_gc_rq(gc_rq);
-	kref_put(&line->ref, pblk_line_put);
-	return ret;
-}
-
 static void pblk_put_line_back(struct pblk *pblk, struct pblk_line *line)
 {
 	struct pblk_line_mgmt *l_mg = &pblk->l_mg;
@@ -130,18 +79,53 @@ static void pblk_gc_line_ws(struct work_struct *work)
 	struct pblk_line_ws *line_rq_ws = container_of(work,
 						struct pblk_line_ws, ws);
 	struct pblk *pblk = line_rq_ws->pblk;
+	struct nvm_tgt_dev *dev = pblk->dev;
+	struct nvm_geo *geo = &dev->geo;
 	struct pblk_gc *gc = &pblk->gc;
 	struct pblk_line *line = line_rq_ws->line;
 	struct pblk_gc_rq *gc_rq = line_rq_ws->priv;
+	int ret;
 
 	up(&gc->gc_sem);
 
-	if (pblk_gc_move_valid_secs(pblk, gc_rq)) {
-		pr_err("pblk: could not GC all sectors: line:%d (%d/%d)\n",
-						line->id, *line->vsc,
-						gc_rq->nr_secs);
+	gc_rq->data = vmalloc(gc_rq->nr_secs * geo->sec_size);
+	if (!gc_rq->data) {
+		pr_err("pblk: could not GC line:%d (%d/%d)\n",
+					line->id, *line->vsc, gc_rq->nr_secs);
+		goto out;
 	}
 
+	/* Read from GC victim block */
+	ret = pblk_submit_read_gc(pblk, gc_rq);
+	if (ret) {
+		pr_err("pblk: failed GC read in line:%d (err:%d)\n",
+								line->id, ret);
+		goto out;
+	}
+
+	if (!gc_rq->secs_to_gc)
+		goto out;
+
+retry:
+	spin_lock(&gc->w_lock);
+	if (gc->w_entries >= PBLK_GC_RQ_QD) {
+		spin_unlock(&gc->w_lock);
+		pblk_gc_writer_kick(&pblk->gc);
+		usleep_range(128, 256);
+		goto retry;
+	}
+	gc->w_entries++;
+	list_add_tail(&gc_rq->list, &gc->w_list);
+	spin_unlock(&gc->w_lock);
+
+	pblk_gc_writer_kick(&pblk->gc);
+
+	mempool_free(line_rq_ws, pblk->line_ws_pool);
+	return;
+
+out:
+	pblk_gc_free_gc_rq(gc_rq);
+	kref_put(&line->ref, pblk_line_put);
 	mempool_free(line_rq_ws, pblk->line_ws_pool);
 }
 
-- 
2.7.4
