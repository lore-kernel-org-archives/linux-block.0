Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mail-pf1-f193.google.com ([209.85.210.193]:34164 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726795AbeJISbO (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Tue, 9 Oct 2018 14:31:14 -0400
Received: by mail-pf1-f193.google.com with SMTP id k19-v6so685532pfi.1
        for <linux-block@vger.kernel.org>; Tue, 09 Oct 2018 04:14:48 -0700 (PDT)
From: =?UTF-8?q?Matias=20Bj=C3=B8rling?= <mb@lightnvm.io>
To: axboe@fb.com
Cc: linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        Hans Holmberg <hans.holmberg@cnexlabs.com>,
        =?UTF-8?q?Matias=20Bj=C3=B8rling?= <mb@lightnvm.io>
Subject: [GIT PULL 28/45] lightnvm: pblk: stop recreating global caches
Date: Tue,  9 Oct 2018 13:11:58 +0200
Message-Id: <20181009111215.7653-29-mb@lightnvm.io>
In-Reply-To: <20181009111215.7653-1-mb@lightnvm.io>
References: <20181009111215.7653-1-mb@lightnvm.io>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

From: Hans Holmberg <hans.holmberg@cnexlabs.com>

Pblk should not create a set of global caches every time
a pblk instance is created. The global caches should be
made available only when there is one or more pblk instances.

This patch bundles the global caches together with a kref
keeping track of whether the caches should be available or not.

Also, turn the global pblk lock into a mutex that explicitly
protects the caches (as this was the only purpose of the lock).

Signed-off-by: Hans Holmberg <hans.holmberg@cnexlabs.com>
Signed-off-by: Matias Bjørling <mb@lightnvm.io>
---
 drivers/lightnvm/pblk-init.c | 132 +++++++++++++++++++++++------------
 1 file changed, 86 insertions(+), 46 deletions(-)

diff --git a/drivers/lightnvm/pblk-init.c b/drivers/lightnvm/pblk-init.c
index 9aebdee8e4c9..fb66bc84d5ca 100644
--- a/drivers/lightnvm/pblk-init.c
+++ b/drivers/lightnvm/pblk-init.c
@@ -26,9 +26,24 @@ static unsigned int write_buffer_size;
 module_param(write_buffer_size, uint, 0644);
 MODULE_PARM_DESC(write_buffer_size, "number of entries in a write buffer");
 
-static struct kmem_cache *pblk_ws_cache, *pblk_rec_cache, *pblk_g_rq_cache,
-				*pblk_w_rq_cache;
-static DECLARE_RWSEM(pblk_lock);
+struct pblk_global_caches {
+	struct kmem_cache	*ws;
+	struct kmem_cache	*rec;
+	struct kmem_cache	*g_rq;
+	struct kmem_cache	*w_rq;
+
+	struct kref		kref;
+
+	struct mutex		mutex; /* Ensures consistency between
+					* caches and kref
+					*/
+};
+
+static struct pblk_global_caches pblk_caches = {
+	.mutex = __MUTEX_INITIALIZER(pblk_caches.mutex),
+	.kref = KREF_INIT(0),
+};
+
 struct bio_set pblk_bio_set;
 
 static int pblk_rw_io(struct request_queue *q, struct pblk *pblk,
@@ -307,53 +322,80 @@ static int pblk_set_addrf(struct pblk *pblk)
 	return 0;
 }
 
-static int pblk_init_global_caches(struct pblk *pblk)
+static int pblk_create_global_caches(void)
 {
-	down_write(&pblk_lock);
-	pblk_ws_cache = kmem_cache_create("pblk_blk_ws",
+
+	pblk_caches.ws = kmem_cache_create("pblk_blk_ws",
 				sizeof(struct pblk_line_ws), 0, 0, NULL);
-	if (!pblk_ws_cache) {
-		up_write(&pblk_lock);
+	if (!pblk_caches.ws)
 		return -ENOMEM;
-	}
 
-	pblk_rec_cache = kmem_cache_create("pblk_rec",
+	pblk_caches.rec = kmem_cache_create("pblk_rec",
 				sizeof(struct pblk_rec_ctx), 0, 0, NULL);
-	if (!pblk_rec_cache) {
-		kmem_cache_destroy(pblk_ws_cache);
-		up_write(&pblk_lock);
-		return -ENOMEM;
-	}
+	if (!pblk_caches.rec)
+		goto fail_destroy_ws;
 
-	pblk_g_rq_cache = kmem_cache_create("pblk_g_rq", pblk_g_rq_size,
+	pblk_caches.g_rq = kmem_cache_create("pblk_g_rq", pblk_g_rq_size,
 				0, 0, NULL);
-	if (!pblk_g_rq_cache) {
-		kmem_cache_destroy(pblk_ws_cache);
-		kmem_cache_destroy(pblk_rec_cache);
-		up_write(&pblk_lock);
-		return -ENOMEM;
-	}
+	if (!pblk_caches.g_rq)
+		goto fail_destroy_rec;
 
-	pblk_w_rq_cache = kmem_cache_create("pblk_w_rq", pblk_w_rq_size,
+	pblk_caches.w_rq = kmem_cache_create("pblk_w_rq", pblk_w_rq_size,
 				0, 0, NULL);
-	if (!pblk_w_rq_cache) {
-		kmem_cache_destroy(pblk_ws_cache);
-		kmem_cache_destroy(pblk_rec_cache);
-		kmem_cache_destroy(pblk_g_rq_cache);
-		up_write(&pblk_lock);
-		return -ENOMEM;
-	}
-	up_write(&pblk_lock);
+	if (!pblk_caches.w_rq)
+		goto fail_destroy_g_rq;
 
 	return 0;
+
+fail_destroy_g_rq:
+	kmem_cache_destroy(pblk_caches.g_rq);
+fail_destroy_rec:
+	kmem_cache_destroy(pblk_caches.rec);
+fail_destroy_ws:
+	kmem_cache_destroy(pblk_caches.ws);
+
+	return -ENOMEM;
+}
+
+static int pblk_get_global_caches(void)
+{
+	int ret;
+
+	mutex_lock(&pblk_caches.mutex);
+
+	if (kref_read(&pblk_caches.kref) > 0) {
+		kref_get(&pblk_caches.kref);
+		mutex_unlock(&pblk_caches.mutex);
+		return 0;
+	}
+
+	ret = pblk_create_global_caches();
+
+	if (!ret)
+		kref_get(&pblk_caches.kref);
+
+	mutex_unlock(&pblk_caches.mutex);
+
+	return ret;
+}
+
+static void pblk_destroy_global_caches(struct kref *ref)
+{
+	struct pblk_global_caches *c;
+
+	c = container_of(ref, struct pblk_global_caches, kref);
+
+	kmem_cache_destroy(c->ws);
+	kmem_cache_destroy(c->rec);
+	kmem_cache_destroy(c->g_rq);
+	kmem_cache_destroy(c->w_rq);
 }
 
-static void pblk_free_global_caches(struct pblk *pblk)
+static void pblk_put_global_caches(void)
 {
-	kmem_cache_destroy(pblk_ws_cache);
-	kmem_cache_destroy(pblk_rec_cache);
-	kmem_cache_destroy(pblk_g_rq_cache);
-	kmem_cache_destroy(pblk_w_rq_cache);
+	mutex_lock(&pblk_caches.mutex);
+	kref_put(&pblk_caches.kref, pblk_destroy_global_caches);
+	mutex_unlock(&pblk_caches.mutex);
 }
 
 static int pblk_core_init(struct pblk *pblk)
@@ -382,7 +424,7 @@ static int pblk_core_init(struct pblk *pblk)
 	if (!pblk->pad_dist)
 		return -ENOMEM;
 
-	if (pblk_init_global_caches(pblk))
+	if (pblk_get_global_caches())
 		goto fail_free_pad_dist;
 
 	/* Internal bios can be at most the sectors signaled by the device. */
@@ -391,27 +433,27 @@ static int pblk_core_init(struct pblk *pblk)
 		goto free_global_caches;
 
 	ret = mempool_init_slab_pool(&pblk->gen_ws_pool, PBLK_GEN_WS_POOL_SIZE,
-				     pblk_ws_cache);
+				     pblk_caches.ws);
 	if (ret)
 		goto free_page_bio_pool;
 
 	ret = mempool_init_slab_pool(&pblk->rec_pool, geo->all_luns,
-				     pblk_rec_cache);
+				     pblk_caches.rec);
 	if (ret)
 		goto free_gen_ws_pool;
 
 	ret = mempool_init_slab_pool(&pblk->r_rq_pool, geo->all_luns,
-				     pblk_g_rq_cache);
+				     pblk_caches.g_rq);
 	if (ret)
 		goto free_rec_pool;
 
 	ret = mempool_init_slab_pool(&pblk->e_rq_pool, geo->all_luns,
-				     pblk_g_rq_cache);
+				     pblk_caches.g_rq);
 	if (ret)
 		goto free_r_rq_pool;
 
 	ret = mempool_init_slab_pool(&pblk->w_rq_pool, geo->all_luns,
-				     pblk_w_rq_cache);
+				     pblk_caches.w_rq);
 	if (ret)
 		goto free_e_rq_pool;
 
@@ -457,7 +499,7 @@ static int pblk_core_init(struct pblk *pblk)
 free_page_bio_pool:
 	mempool_exit(&pblk->page_bio_pool);
 free_global_caches:
-	pblk_free_global_caches(pblk);
+	pblk_put_global_caches();
 fail_free_pad_dist:
 	kfree(pblk->pad_dist);
 	return -ENOMEM;
@@ -481,7 +523,7 @@ static void pblk_core_free(struct pblk *pblk)
 	mempool_exit(&pblk->e_rq_pool);
 	mempool_exit(&pblk->w_rq_pool);
 
-	pblk_free_global_caches(pblk);
+	pblk_put_global_caches();
 	kfree(pblk->pad_dist);
 }
 
@@ -1074,7 +1116,6 @@ static void pblk_exit(void *private, bool graceful)
 {
 	struct pblk *pblk = private;
 
-	down_write(&pblk_lock);
 	pblk_gc_exit(pblk, graceful);
 	pblk_tear_down(pblk, graceful);
 
@@ -1083,7 +1124,6 @@ static void pblk_exit(void *private, bool graceful)
 #endif
 
 	pblk_free(pblk);
-	up_write(&pblk_lock);
 }
 
 static sector_t pblk_capacity(void *private)
-- 
2.17.1
