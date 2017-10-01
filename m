Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mx1.mpynet.fi ([82.197.21.84]:25536 "EHLO mx1.mpynet.fi"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751118AbdJAN0h (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Sun, 1 Oct 2017 09:26:37 -0400
Date: Sun, 1 Oct 2017 16:26:35 +0300
From: Rakesh Pandit <rakesh@tuxera.com>
To: Matias =?iso-8859-1?Q?Bj=F8rling?= <mb@lightnvm.io>,
        <linux-block@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC: Javier =?iso-8859-1?Q?Gonz=E1lez?= <jg@lightnvm.io>
Subject: [PATCH 6/6] lightnvm: pblk: fix releases of kmem cache in error path
Message-ID: <20171001132633.GA5783@hercules.tuxera.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

If pblk_core_init fails lets destroy all global caches.

Signed-off-by: Rakesh Pandit <rakesh@tuxera.com>
---
 drivers/lightnvm/pblk-init.c | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/drivers/lightnvm/pblk-init.c b/drivers/lightnvm/pblk-init.c
index 519e5cf..9f39800 100644
--- a/drivers/lightnvm/pblk-init.c
+++ b/drivers/lightnvm/pblk-init.c
@@ -246,7 +246,7 @@ static int pblk_core_init(struct pblk *pblk)
 	pblk->page_bio_pool = mempool_create_page_pool(nvm_max_phys_sects(dev),
 									0);
 	if (!pblk->page_bio_pool)
-		return -ENOMEM;
+		goto free_global_caches;
 
 	pblk->gen_ws_pool = mempool_create_slab_pool(PBLK_GEN_WS_POOL_SIZE,
 							pblk_ws_cache);
@@ -314,6 +314,12 @@ static int pblk_core_init(struct pblk *pblk)
 	mempool_destroy(pblk->gen_ws_pool);
 free_page_bio_pool:
 	mempool_destroy(pblk->page_bio_pool);
+free_global_caches:
+	kmem_cache_destroy(pblk_ws_cache);
+	kmem_cache_destroy(pblk_rec_cache);
+	kmem_cache_destroy(pblk_g_rq_cache);
+	kmem_cache_destroy(pblk_e_rq_cache);
+	kmem_cache_destroy(pblk_w_rq_cache);
 	return -ENOMEM;
 }
 
-- 
2.7.4
