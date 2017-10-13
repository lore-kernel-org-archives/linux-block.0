Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mail-wm0-f66.google.com ([74.125.82.66]:51334 "EHLO
        mail-wm0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1758171AbdJMMrZ (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 13 Oct 2017 08:47:25 -0400
Received: by mail-wm0-f66.google.com with SMTP id f4so21574719wme.0
        for <linux-block@vger.kernel.org>; Fri, 13 Oct 2017 05:47:25 -0700 (PDT)
From: =?UTF-8?q?Matias=20Bj=C3=B8rling?= <m@bjorling.me>
To: axboe@fb.com
Cc: linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        =?UTF-8?q?Javier=20Gonz=C3=A1lez?= <javier@cnexlabs.com>,
        =?UTF-8?q?Matias=20Bj=C3=B8rling?= <m@bjorling.me>
Subject: [GIT PULL 19/58] lightnvm: pblk: decouple read/erase mempools
Date: Fri, 13 Oct 2017 14:46:08 +0200
Message-Id: <20171013124647.32668-20-m@bjorling.me>
In-Reply-To: <20171013124647.32668-1-m@bjorling.me>
References: <20171013124647.32668-1-m@bjorling.me>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

From: Javier González <javier@cnexlabs.com>

Since read and erase paths offer different guarantees for inflight I/Os,
separate the mempools to set the right min_nr for each on creation.

Reported-by: Jens Axboe <axboe@kernel.dk>
Signed-off-by: Javier González <javier@cnexlabs.com>
Signed-off-by: Matias Bjørling <m@bjorling.me>
---
 drivers/lightnvm/pblk-core.c |  8 ++++----
 drivers/lightnvm/pblk-init.c | 22 +++++++++++++++-------
 drivers/lightnvm/pblk.h      |  5 +++--
 3 files changed, 22 insertions(+), 13 deletions(-)

diff --git a/drivers/lightnvm/pblk-core.c b/drivers/lightnvm/pblk-core.c
index b925322..0c22e5c 100644
--- a/drivers/lightnvm/pblk-core.c
+++ b/drivers/lightnvm/pblk-core.c
@@ -64,7 +64,7 @@ static void pblk_end_io_erase(struct nvm_rq *rqd)
 	struct pblk *pblk = rqd->private;
 
 	__pblk_end_io_erase(pblk, rqd);
-	mempool_free(rqd, pblk->g_rq_pool);
+	mempool_free(rqd, pblk->e_rq_pool);
 }
 
 void __pblk_map_invalidate(struct pblk *pblk, struct pblk_line *line,
@@ -161,7 +161,7 @@ struct nvm_rq *pblk_alloc_rqd(struct pblk *pblk, int rw)
 		pool = pblk->w_rq_pool;
 		rq_size = pblk_w_rq_size;
 	} else {
-		pool = pblk->g_rq_pool;
+		pool = pblk->r_rq_pool;
 		rq_size = pblk_g_rq_size;
 	}
 
@@ -178,7 +178,7 @@ void pblk_free_rqd(struct pblk *pblk, struct nvm_rq *rqd, int rw)
 	if (rw == WRITE)
 		pool = pblk->w_rq_pool;
 	else
-		pool = pblk->g_rq_pool;
+		pool = pblk->r_rq_pool;
 
 	mempool_free(rqd, pool);
 }
@@ -1479,7 +1479,7 @@ int pblk_blk_erase_async(struct pblk *pblk, struct ppa_addr ppa)
 	struct nvm_rq *rqd;
 	int err;
 
-	rqd = mempool_alloc(pblk->g_rq_pool, GFP_KERNEL);
+	rqd = mempool_alloc(pblk->e_rq_pool, GFP_KERNEL);
 	memset(rqd, 0, pblk_g_rq_size);
 
 	pblk_setup_e_rq(pblk, rqd, ppa);
diff --git a/drivers/lightnvm/pblk-init.c b/drivers/lightnvm/pblk-init.c
index 3405522..2f8d3f9 100644
--- a/drivers/lightnvm/pblk-init.c
+++ b/drivers/lightnvm/pblk-init.c
@@ -261,15 +261,20 @@ static int pblk_core_init(struct pblk *pblk)
 	if (!pblk->rec_pool)
 		goto free_gen_ws_pool;
 
-	pblk->g_rq_pool = mempool_create_slab_pool(PBLK_READ_REQ_POOL_SIZE,
+	pblk->r_rq_pool = mempool_create_slab_pool(geo->nr_luns,
 							pblk_g_rq_cache);
-	if (!pblk->g_rq_pool)
+	if (!pblk->r_rq_pool)
 		goto free_rec_pool;
 
-	pblk->w_rq_pool = mempool_create_slab_pool(geo->nr_luns * 2,
+	pblk->e_rq_pool = mempool_create_slab_pool(geo->nr_luns,
+							pblk_g_rq_cache);
+	if (!pblk->e_rq_pool)
+		goto free_r_rq_pool;
+
+	pblk->w_rq_pool = mempool_create_slab_pool(geo->nr_luns,
 							pblk_w_rq_cache);
 	if (!pblk->w_rq_pool)
-		goto free_g_rq_pool;
+		goto free_e_rq_pool;
 
 	pblk->line_meta_pool =
 			mempool_create_slab_pool(PBLK_META_POOL_SIZE,
@@ -304,8 +309,10 @@ static int pblk_core_init(struct pblk *pblk)
 	mempool_destroy(pblk->line_meta_pool);
 free_w_rq_pool:
 	mempool_destroy(pblk->w_rq_pool);
-free_g_rq_pool:
-	mempool_destroy(pblk->g_rq_pool);
+free_e_rq_pool:
+	mempool_destroy(pblk->e_rq_pool);
+free_r_rq_pool:
+	mempool_destroy(pblk->r_rq_pool);
 free_rec_pool:
 	mempool_destroy(pblk->rec_pool);
 free_gen_ws_pool:
@@ -326,7 +333,8 @@ static void pblk_core_free(struct pblk *pblk)
 	mempool_destroy(pblk->page_bio_pool);
 	mempool_destroy(pblk->gen_ws_pool);
 	mempool_destroy(pblk->rec_pool);
-	mempool_destroy(pblk->g_rq_pool);
+	mempool_destroy(pblk->r_rq_pool);
+	mempool_destroy(pblk->e_rq_pool);
 	mempool_destroy(pblk->w_rq_pool);
 	mempool_destroy(pblk->line_meta_pool);
 
diff --git a/drivers/lightnvm/pblk.h b/drivers/lightnvm/pblk.h
index efaa781..419e1b7 100644
--- a/drivers/lightnvm/pblk.h
+++ b/drivers/lightnvm/pblk.h
@@ -41,7 +41,6 @@
 #define PBLK_MAX_REQ_ADDRS_PW (6)
 
 #define PBLK_META_POOL_SIZE (128)
-#define PBLK_READ_REQ_POOL_SIZE (1024)
 
 #define PBLK_NR_CLOSE_JOBS (4)
 
@@ -60,6 +59,7 @@
 
 #define ERASE 2 /* READ = 0, WRITE = 1 */
 
+/* Static pool sizes */
 #define PBLK_GEN_WS_POOL_SIZE (2)
 
 enum {
@@ -624,8 +624,9 @@ struct pblk {
 	mempool_t *page_bio_pool;
 	mempool_t *gen_ws_pool;
 	mempool_t *rec_pool;
-	mempool_t *g_rq_pool;
+	mempool_t *r_rq_pool;
 	mempool_t *w_rq_pool;
+	mempool_t *e_rq_pool;
 	mempool_t *line_meta_pool;
 
 	struct workqueue_struct *close_wq;
-- 
2.9.3
