Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mail-wm0-f65.google.com ([74.125.82.65]:45150 "EHLO
        mail-wm0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932176AbdJMMru (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 13 Oct 2017 08:47:50 -0400
Received: by mail-wm0-f65.google.com with SMTP id q124so21262944wmb.0
        for <linux-block@vger.kernel.org>; Fri, 13 Oct 2017 05:47:49 -0700 (PDT)
From: =?UTF-8?q?Matias=20Bj=C3=B8rling?= <m@bjorling.me>
To: axboe@fb.com
Cc: linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        Rakesh Pandit <rakesh@tuxera.com>,
        =?UTF-8?q?Matias=20Bj=C3=B8rling?= <m@bjorling.me>
Subject: [GIT PULL 44/58] lightnvm: pblk: fix releases of kmem cache in error path
Date: Fri, 13 Oct 2017 14:46:33 +0200
Message-Id: <20171013124647.32668-45-m@bjorling.me>
In-Reply-To: <20171013124647.32668-1-m@bjorling.me>
References: <20171013124647.32668-1-m@bjorling.me>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

From: Rakesh Pandit <rakesh@tuxera.com>

If pblk_core_init fails lets destroy all global caches.

Signed-off-by: Rakesh Pandit <rakesh@tuxera.com>
Signed-off-by: Matias Bjørling <m@bjorling.me>
---
 drivers/lightnvm/pblk-init.c | 17 ++++++++++++-----
 1 file changed, 12 insertions(+), 5 deletions(-)

diff --git a/drivers/lightnvm/pblk-init.c b/drivers/lightnvm/pblk-init.c
index 56ece7d..2e59973 100644
--- a/drivers/lightnvm/pblk-init.c
+++ b/drivers/lightnvm/pblk-init.c
@@ -220,6 +220,14 @@ static int pblk_init_global_caches(struct pblk *pblk)
 	return 0;
 }
 
+static void pblk_free_global_caches(struct pblk *pblk)
+{
+	kmem_cache_destroy(pblk_ws_cache);
+	kmem_cache_destroy(pblk_rec_cache);
+	kmem_cache_destroy(pblk_g_rq_cache);
+	kmem_cache_destroy(pblk_w_rq_cache);
+}
+
 static int pblk_core_init(struct pblk *pblk)
 {
 	struct nvm_tgt_dev *dev = pblk->dev;
@@ -235,7 +243,7 @@ static int pblk_core_init(struct pblk *pblk)
 	pblk->page_bio_pool = mempool_create_page_pool(nvm_max_phys_sects(dev),
 									0);
 	if (!pblk->page_bio_pool)
-		return -ENOMEM;
+		goto free_global_caches;
 
 	pblk->gen_ws_pool = mempool_create_slab_pool(PBLK_GEN_WS_POOL_SIZE,
 							pblk_ws_cache);
@@ -303,6 +311,8 @@ static int pblk_core_init(struct pblk *pblk)
 	mempool_destroy(pblk->gen_ws_pool);
 free_page_bio_pool:
 	mempool_destroy(pblk->page_bio_pool);
+free_global_caches:
+	pblk_free_global_caches(pblk);
 	return -ENOMEM;
 }
 
@@ -324,10 +334,7 @@ static void pblk_core_free(struct pblk *pblk)
 	mempool_destroy(pblk->e_rq_pool);
 	mempool_destroy(pblk->w_rq_pool);
 
-	kmem_cache_destroy(pblk_ws_cache);
-	kmem_cache_destroy(pblk_rec_cache);
-	kmem_cache_destroy(pblk_g_rq_cache);
-	kmem_cache_destroy(pblk_w_rq_cache);
+	pblk_free_global_caches(pblk);
 }
 
 static void pblk_luns_free(struct pblk *pblk)
-- 
2.9.3
