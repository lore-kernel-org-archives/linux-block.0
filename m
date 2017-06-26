Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mail-wm0-f42.google.com ([74.125.82.42]:37329 "EHLO
        mail-wm0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751997AbdFZJ6i (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 26 Jun 2017 05:58:38 -0400
Received: by mail-wm0-f42.google.com with SMTP id i127so3038255wma.0
        for <linux-block@vger.kernel.org>; Mon, 26 Jun 2017 02:58:37 -0700 (PDT)
From: "=?UTF-8?q?Javier=20Gonz=C3=A1lez?=" <jg@lightnvm.io>
To: mb@lightnvm.io, axboe@fb.com
Cc: linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        =?UTF-8?q?Javier=20Gonz=C3=A1lez?= <javier@cnexlabs.com>,
        =?UTF-8?q?Matias=20Bj=C3=B8rling?= <matias@cnexlabs.com>
Subject: [PATCH 19/20] lightnvm: pblk: set mempool and workqueue params.
Date: Mon, 26 Jun 2017 11:57:28 +0200
Message-Id: <1498471049-25505-20-git-send-email-javier@cnexlabs.com>
In-Reply-To: <1498471049-25505-1-git-send-email-javier@cnexlabs.com>
References: <1498471049-25505-1-git-send-email-javier@cnexlabs.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

Make constants to define sizes for internal mempools and workqueues. In
this process, adjust the values to be more meaningful given the internal
constrains of the FTL. In order to do this for workqueues, separate the
current auxiliary workqueue into two dedicated workqueues to manage
lines being closed and bad blocks.

Signed-off-by: Javier González <javier@cnexlabs.com>
Signed-off-by: Matias Bjørling <matias@cnexlabs.com>
---
 drivers/lightnvm/pblk-core.c  |  7 ++++---
 drivers/lightnvm/pblk-init.c  | 39 ++++++++++++++++++++++++++-------------
 drivers/lightnvm/pblk-write.c |  5 +++--
 drivers/lightnvm/pblk.h       | 13 +++++++++++--
 4 files changed, 44 insertions(+), 20 deletions(-)

diff --git a/drivers/lightnvm/pblk-core.c b/drivers/lightnvm/pblk-core.c
index ba3b88f0e1f7..823e53f95a80 100644
--- a/drivers/lightnvm/pblk-core.c
+++ b/drivers/lightnvm/pblk-core.c
@@ -33,7 +33,7 @@ static void pblk_mark_bb(struct pblk *pblk, struct pblk_line *line,
 		pr_err("pblk: attempted to erase bb: line:%d, pos:%d\n",
 							line->id, pos);
 
-	pblk_line_run_ws(pblk, NULL, ppa, pblk_line_mark_bb);
+	pblk_line_run_ws(pblk, NULL, ppa, pblk_line_mark_bb, pblk->bb_wq);
 }
 
 static void __pblk_end_io_erase(struct pblk *pblk, struct nvm_rq *rqd)
@@ -1528,7 +1528,8 @@ void pblk_line_mark_bb(struct work_struct *work)
 }
 
 void pblk_line_run_ws(struct pblk *pblk, struct pblk_line *line, void *priv,
-		      void (*work)(struct work_struct *))
+		      void (*work)(struct work_struct *),
+		      struct workqueue_struct *wq)
 {
 	struct pblk_line_ws *line_ws;
 
@@ -1541,7 +1542,7 @@ void pblk_line_run_ws(struct pblk *pblk, struct pblk_line *line, void *priv,
 	line_ws->priv = priv;
 
 	INIT_WORK(&line_ws->ws, work);
-	queue_work(pblk->kw_wq, &line_ws->ws);
+	queue_work(wq, &line_ws->ws);
 }
 
 void pblk_down_rq(struct pblk *pblk, struct ppa_addr *ppa_list, int nr_ppas,
diff --git a/drivers/lightnvm/pblk-init.c b/drivers/lightnvm/pblk-init.c
index 41db12deaa49..78a9bebac1fe 100644
--- a/drivers/lightnvm/pblk-init.c
+++ b/drivers/lightnvm/pblk-init.c
@@ -250,7 +250,7 @@ static int pblk_core_init(struct pblk *pblk)
 	if (!pblk->page_pool)
 		return -ENOMEM;
 
-	pblk->line_ws_pool = mempool_create_slab_pool(geo->nr_luns,
+	pblk->line_ws_pool = mempool_create_slab_pool(PBLK_WS_POOL_SIZE,
 							pblk_blk_ws_cache);
 	if (!pblk->line_ws_pool)
 		goto free_page_pool;
@@ -259,35 +259,45 @@ static int pblk_core_init(struct pblk *pblk)
 	if (!pblk->rec_pool)
 		goto free_blk_ws_pool;
 
-	pblk->g_rq_pool = mempool_create_slab_pool(64, pblk_g_rq_cache);
+	pblk->g_rq_pool = mempool_create_slab_pool(PBLK_READ_REQ_POOL_SIZE,
+							pblk_g_rq_cache);
 	if (!pblk->g_rq_pool)
 		goto free_rec_pool;
 
-	pblk->w_rq_pool = mempool_create_slab_pool(64, pblk_w_rq_cache);
+	pblk->w_rq_pool = mempool_create_slab_pool(geo->nr_luns * 2,
+							pblk_w_rq_cache);
 	if (!pblk->w_rq_pool)
 		goto free_g_rq_pool;
 
 	pblk->line_meta_pool =
-			mempool_create_slab_pool(16, pblk_line_meta_cache);
+			mempool_create_slab_pool(PBLK_META_POOL_SIZE,
+							pblk_line_meta_cache);
 	if (!pblk->line_meta_pool)
 		goto free_w_rq_pool;
 
-	pblk->kw_wq = alloc_workqueue("pblk-aux-wq",
-					WQ_MEM_RECLAIM | WQ_UNBOUND, 1);
-	if (!pblk->kw_wq)
+	pblk->close_wq = alloc_workqueue("pblk-close-wq",
+			WQ_MEM_RECLAIM | WQ_UNBOUND, PBLK_NR_CLOSE_JOBS);
+	if (!pblk->close_wq)
 		goto free_line_meta_pool;
 
+	pblk->bb_wq = alloc_workqueue("pblk-bb-wq",
+			WQ_MEM_RECLAIM | WQ_UNBOUND, 0);
+	if (!pblk->bb_wq)
+		goto free_close_wq;
+
 	if (pblk_set_ppaf(pblk))
-		goto free_kw_wq;
+		goto free_bb_wq;
 
 	if (pblk_rwb_init(pblk))
-		goto free_kw_wq;
+		goto free_bb_wq;
 
 	INIT_LIST_HEAD(&pblk->compl_list);
 	return 0;
 
-free_kw_wq:
-	destroy_workqueue(pblk->kw_wq);
+free_bb_wq:
+	destroy_workqueue(pblk->bb_wq);
+free_close_wq:
+	destroy_workqueue(pblk->close_wq);
 free_line_meta_pool:
 	mempool_destroy(pblk->line_meta_pool);
 free_w_rq_pool:
@@ -305,8 +315,11 @@ static int pblk_core_init(struct pblk *pblk)
 
 static void pblk_core_free(struct pblk *pblk)
 {
-	if (pblk->kw_wq)
-		destroy_workqueue(pblk->kw_wq);
+	if (pblk->close_wq)
+		destroy_workqueue(pblk->close_wq);
+
+	if (pblk->bb_wq)
+		destroy_workqueue(pblk->bb_wq);
 
 	mempool_destroy(pblk->page_pool);
 	mempool_destroy(pblk->line_ws_pool);
diff --git a/drivers/lightnvm/pblk-write.c b/drivers/lightnvm/pblk-write.c
index a50bfbd12c32..f071fb79e199 100644
--- a/drivers/lightnvm/pblk-write.c
+++ b/drivers/lightnvm/pblk-write.c
@@ -150,7 +150,7 @@ static void pblk_end_w_fail(struct pblk *pblk, struct nvm_rq *rqd)
 	}
 
 	INIT_WORK(&recovery->ws_rec, pblk_submit_rec);
-	queue_work(pblk->kw_wq, &recovery->ws_rec);
+	queue_work(pblk->close_wq, &recovery->ws_rec);
 
 out:
 	pblk_complete_write(pblk, rqd, c_ctx);
@@ -198,7 +198,8 @@ static void pblk_end_io_write_meta(struct nvm_rq *rqd)
 
 	sync = atomic_add_return(rqd->nr_ppas, &emeta->sync);
 	if (sync == emeta->nr_entries)
-		pblk_line_run_ws(pblk, line, NULL, pblk_line_close_ws);
+		pblk_line_run_ws(pblk, line, NULL, pblk_line_close_ws,
+								pblk->close_wq);
 
 	bio_put(rqd->bio);
 	pblk_free_rqd(pblk, rqd, READ);
diff --git a/drivers/lightnvm/pblk.h b/drivers/lightnvm/pblk.h
index aaee718f1029..862bca130144 100644
--- a/drivers/lightnvm/pblk.h
+++ b/drivers/lightnvm/pblk.h
@@ -40,6 +40,12 @@
 #define PBLK_MAX_REQ_ADDRS (64)
 #define PBLK_MAX_REQ_ADDRS_PW (6)
 
+#define PBLK_WS_POOL_SIZE (128)
+#define PBLK_META_POOL_SIZE (128)
+#define PBLK_READ_REQ_POOL_SIZE (1024)
+
+#define PBLK_NR_CLOSE_JOBS (4)
+
 #define PBLK_CACHE_NAME_LEN (DISK_NAME_LEN + 16)
 
 #define PBLK_COMMAND_TIMEOUT_MS 30000
@@ -599,7 +605,9 @@ struct pblk {
 	mempool_t *w_rq_pool;
 	mempool_t *line_meta_pool;
 
-	struct workqueue_struct *kw_wq;
+	struct workqueue_struct *close_wq;
+	struct workqueue_struct *bb_wq;
+
 	struct timer_list wtimer;
 
 	struct pblk_gc gc;
@@ -692,7 +700,8 @@ void pblk_line_close(struct pblk *pblk, struct pblk_line *line);
 void pblk_line_close_ws(struct work_struct *work);
 void pblk_line_mark_bb(struct work_struct *work);
 void pblk_line_run_ws(struct pblk *pblk, struct pblk_line *line, void *priv,
-		      void (*work)(struct work_struct *));
+		      void (*work)(struct work_struct *),
+		      struct workqueue_struct *wq);
 u64 pblk_line_smeta_start(struct pblk *pblk, struct pblk_line *line);
 int pblk_line_read_smeta(struct pblk *pblk, struct pblk_line *line);
 int pblk_line_read_emeta(struct pblk *pblk, struct pblk_line *line,
-- 
2.7.4
