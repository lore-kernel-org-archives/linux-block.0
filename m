Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mail-wm0-f44.google.com ([74.125.82.44]:43765 "EHLO
        mail-wm0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751906AbdINKeS (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 14 Sep 2017 06:34:18 -0400
Received: by mail-wm0-f44.google.com with SMTP id a137so4907274wma.0
        for <linux-block@vger.kernel.org>; Thu, 14 Sep 2017 03:34:18 -0700 (PDT)
From: "=?UTF-8?q?Javier=20Gonz=C3=A1lez?=" <jg@lightnvm.io>
To: axboe@fb.com
Cc: linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        =?UTF-8?q?Javier=20Gonz=C3=A1lez?= <javier@cnexlabs.com>
Subject: [PATCH 3/5] lightnvm: pblk: decouple read/erase mempools
Date: Thu, 14 Sep 2017 12:33:45 +0200
Message-Id: <1505385227-28706-4-git-send-email-javier@cnexlabs.com>
In-Reply-To: <1505385227-28706-1-git-send-email-javier@cnexlabs.com>
References: <1505385227-28706-1-git-send-email-javier@cnexlabs.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

Since read and erase paths offer different guarantees for inflight I/Os,
separate the mempools to set the right min_nr for each on creation.

Reported-by: Jens Axboe <axboe@kernel.dk>
Signed-off-by: Javier González <javier@cnexlabs.com>
---
 drivers/lightnvm/pblk-core.c | 12 ++++--------
 drivers/lightnvm/pblk-init.c | 22 +++++++++++++++-------
 drivers/lightnvm/pblk.h      |  5 +++--
 3 files changed, 22 insertions(+), 17 deletions(-)

diff --git a/drivers/lightnvm/pblk-core.c b/drivers/lightnvm/pblk-core.c
index b7a6b223b1a5..9e35ec7c1d9f 100644
--- a/drivers/lightnvm/pblk-core.c
+++ b/drivers/lightnvm/pblk-core.c
@@ -64,7 +64,7 @@ static void pblk_end_io_erase(struct nvm_rq *rqd)
 	struct pblk *pblk = rqd->private;
 
 	__pblk_end_io_erase(pblk, rqd);
-	mempool_free(rqd, pblk->g_rq_pool);
+	mempool_free(rqd, pblk->e_rq_pool);
 }
 
 void __pblk_map_invalidate(struct pblk *pblk, struct pblk_line *line,
@@ -161,13 +161,11 @@ struct nvm_rq *pblk_alloc_rqd(struct pblk *pblk, int rw)
 		pool = pblk->w_rq_pool;
 		rq_size = pblk_w_rq_size;
 	} else {
-		pool = pblk->g_rq_pool;
+		pool = pblk->r_rq_pool;
 		rq_size = pblk_g_rq_size;
 	}
 
 	rqd = mempool_alloc(pool, GFP_KERNEL);
-	if (!rqd)
-		return NULL;
 	memset(rqd, 0, rq_size);
 
 	return rqd;
@@ -180,7 +178,7 @@ void pblk_free_rqd(struct pblk *pblk, struct nvm_rq *rqd, int rw)
 	if (rw == WRITE)
 		pool = pblk->w_rq_pool;
 	else
-		pool = pblk->g_rq_pool;
+		pool = pblk->r_rq_pool;
 
 	mempool_free(rqd, pool);
 }
@@ -1479,9 +1477,7 @@ int pblk_blk_erase_async(struct pblk *pblk, struct ppa_addr ppa)
 	struct nvm_rq *rqd;
 	int err;
 
-	rqd = mempool_alloc(pblk->g_rq_pool, GFP_KERNEL);
-	if (!rqd)
-		return -ENOMEM;
+	rqd = mempool_alloc(pblk->e_rq_pool, GFP_KERNEL);
 	memset(rqd, 0, pblk_g_rq_size);
 
 	pblk_setup_e_rq(pblk, rqd, ppa);
diff --git a/drivers/lightnvm/pblk-init.c b/drivers/lightnvm/pblk-init.c
index 0c65abb96dc6..5f8a9fd2f29a 100644
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
index dee8f66e6ce2..0120e0ade703 100644
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
@@ -623,8 +623,9 @@ struct pblk {
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
2.7.4
