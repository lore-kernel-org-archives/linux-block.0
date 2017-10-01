Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mx1.mpynet.fi ([82.197.21.84]:50333 "EHLO mx1.mpynet.fi"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751035AbdJANZ7 (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Sun, 1 Oct 2017 09:25:59 -0400
Date: Sun, 1 Oct 2017 16:25:56 +0300
From: Rakesh Pandit <rakesh@tuxera.com>
To: Matias =?iso-8859-1?Q?Bj=F8rling?= <mb@lightnvm.io>,
        <linux-block@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC: Javier =?iso-8859-1?Q?Gonz=E1lez?= <jg@lightnvm.io>
Subject: [PATCH 5/6] lightnvm: pblk: free up mempool allocation for erases
 correctly
Message-ID: <20171001132555.GA5763@hercules.tuxera.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

While separating read and erase mempools in 22da65a1b pblk_g_rq_cache
was used two times to set aside memory both for erase and read
requests.  Because same kmem cache is used repeatedly a single call to
kmem_cache_destroy wouldn't deallocate everything.  Repeatedly doing
loading and unloading of pblk modules would eventually result in some
leak.

The fix is to really use separate kmem cache and track it
appropriately.

Fixes: 22da65a1b ("lightnvm: pblk: decouple read/erase mempools")
Signed-off-by: Rakesh Pandit <rakesh@tuxera.com>
---
 drivers/lightnvm/pblk-init.c | 16 ++++++++++++++--
 drivers/lightnvm/pblk.h      |  1 +
 2 files changed, 15 insertions(+), 2 deletions(-)

diff --git a/drivers/lightnvm/pblk-init.c b/drivers/lightnvm/pblk-init.c
index 9d9adcf..519e5cf 100644
--- a/drivers/lightnvm/pblk-init.c
+++ b/drivers/lightnvm/pblk-init.c
@@ -21,7 +21,7 @@
 #include "pblk.h"
 
 static struct kmem_cache *pblk_ws_cache, *pblk_rec_cache, *pblk_g_rq_cache,
-				*pblk_w_rq_cache;
+				*pblk_w_rq_cache, *pblk_e_rq_cache;
 static DECLARE_RWSEM(pblk_lock);
 struct bio_set *pblk_bio_set;
 
@@ -206,12 +206,23 @@ static int pblk_init_global_caches(struct pblk *pblk)
 		return -ENOMEM;
 	}
 
+	pblk_e_rq_cache = kmem_cache_create("pblk_e_rq", pblk_e_rq_size,
+				0, 0, NULL);
+	if (!pblk_e_rq_cache) {
+		kmem_cache_destroy(pblk_ws_cache);
+		kmem_cache_destroy(pblk_rec_cache);
+		kmem_cache_destroy(pblk_g_rq_cache);
+		up_write(&pblk_lock);
+		return -ENOMEM;
+	}
+
 	pblk_w_rq_cache = kmem_cache_create("pblk_w_rq", pblk_w_rq_size,
 				0, 0, NULL);
 	if (!pblk_w_rq_cache) {
 		kmem_cache_destroy(pblk_ws_cache);
 		kmem_cache_destroy(pblk_rec_cache);
 		kmem_cache_destroy(pblk_g_rq_cache);
+		kmem_cache_destroy(pblk_e_rq_cache);
 		up_write(&pblk_lock);
 		return -ENOMEM;
 	}
@@ -252,7 +263,7 @@ static int pblk_core_init(struct pblk *pblk)
 		goto free_rec_pool;
 
 	pblk->e_rq_pool = mempool_create_slab_pool(geo->nr_luns,
-							pblk_g_rq_cache);
+							pblk_e_rq_cache);
 	if (!pblk->e_rq_pool)
 		goto free_r_rq_pool;
 
@@ -327,6 +338,7 @@ static void pblk_core_free(struct pblk *pblk)
 	kmem_cache_destroy(pblk_ws_cache);
 	kmem_cache_destroy(pblk_rec_cache);
 	kmem_cache_destroy(pblk_g_rq_cache);
+	kmem_cache_destroy(pblk_e_rq_cache);
 	kmem_cache_destroy(pblk_w_rq_cache);
 }
 
diff --git a/drivers/lightnvm/pblk.h b/drivers/lightnvm/pblk.h
index fcac246..03834d1 100644
--- a/drivers/lightnvm/pblk.h
+++ b/drivers/lightnvm/pblk.h
@@ -651,6 +651,7 @@ struct pblk_line_ws {
 
 #define pblk_g_rq_size (sizeof(struct nvm_rq) + sizeof(struct pblk_g_ctx))
 #define pblk_w_rq_size (sizeof(struct nvm_rq) + sizeof(struct pblk_c_ctx))
+#define pblk_e_rq_size pblk_g_rq_size
 
 /*
  * pblk ring buffer operations
-- 
2.7.4
