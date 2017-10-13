Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mail-wm0-f65.google.com ([74.125.82.65]:55899 "EHLO
        mail-wm0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1758165AbdJMMrY (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 13 Oct 2017 08:47:24 -0400
Received: by mail-wm0-f65.google.com with SMTP id u138so21642700wmu.4
        for <linux-block@vger.kernel.org>; Fri, 13 Oct 2017 05:47:23 -0700 (PDT)
From: =?UTF-8?q?Matias=20Bj=C3=B8rling?= <m@bjorling.me>
To: axboe@fb.com
Cc: linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        =?UTF-8?q?Javier=20Gonz=C3=A1lez?= <javier@cnexlabs.com>,
        =?UTF-8?q?Matias=20Bj=C3=B8rling?= <m@bjorling.me>
Subject: [GIT PULL 17/58] lightnvm: pblk: fix min size for page mempool
Date: Fri, 13 Oct 2017 14:46:06 +0200
Message-Id: <20171013124647.32668-18-m@bjorling.me>
In-Reply-To: <20171013124647.32668-1-m@bjorling.me>
References: <20171013124647.32668-1-m@bjorling.me>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

From: Javier González <javier@cnexlabs.com>

pblk uses an internal page mempool for allocating pages on internal
bios. The main two users of this memory pool are partial reads (reads
with some sectors in cache and some on media) and padded writes, which
need to add dummy pages to an existing bio already containing valid
data (and with a large enough bioset allocated). In both cases, the
maximum number of pages per bio is defined by the maximum number of
physical sectors supported by the underlying device.

This patch fixes a bad mempool allocation, where the min_nr of elements
on the pool was fixed (to 16), which is lower than the maximum number
of sectors supported by NVMe (as of the time for this patch). Instead,
use the maximum number of allowed sectors reported by the device.

Reported-by: Jens Axboe <axboe@kernel.dk>
Signed-off-by: Javier González <javier@cnexlabs.com>
Signed-off-by: Matias Bjørling <m@bjorling.me>
---
 drivers/lightnvm/pblk-core.c |  6 +++---
 drivers/lightnvm/pblk-init.c | 15 ++++++++-------
 drivers/lightnvm/pblk-read.c |  2 +-
 drivers/lightnvm/pblk.h      |  2 +-
 4 files changed, 13 insertions(+), 12 deletions(-)

diff --git a/drivers/lightnvm/pblk-core.c b/drivers/lightnvm/pblk-core.c
index 9299a5a..f5fbb9a 100644
--- a/drivers/lightnvm/pblk-core.c
+++ b/drivers/lightnvm/pblk-core.c
@@ -192,7 +192,7 @@ void pblk_bio_free_pages(struct pblk *pblk, struct bio *bio, int off,
 
 	for (i = off; i < nr_pages + off; i++) {
 		bv = bio->bi_io_vec[i];
-		mempool_free(bv.bv_page, pblk->page_pool);
+		mempool_free(bv.bv_page, pblk->page_bio_pool);
 	}
 }
 
@@ -204,14 +204,14 @@ int pblk_bio_add_pages(struct pblk *pblk, struct bio *bio, gfp_t flags,
 	int i, ret;
 
 	for (i = 0; i < nr_pages; i++) {
-		page = mempool_alloc(pblk->page_pool, flags);
+		page = mempool_alloc(pblk->page_bio_pool, flags);
 		if (!page)
 			goto err;
 
 		ret = bio_add_pc_page(q, bio, page, PBLK_EXPOSED_PAGE_SIZE, 0);
 		if (ret != PBLK_EXPOSED_PAGE_SIZE) {
 			pr_err("pblk: could not add page to bio\n");
-			mempool_free(page, pblk->page_pool);
+			mempool_free(page, pblk->page_bio_pool);
 			goto err;
 		}
 	}
diff --git a/drivers/lightnvm/pblk-init.c b/drivers/lightnvm/pblk-init.c
index eee4eeb..7b1f29c 100644
--- a/drivers/lightnvm/pblk-init.c
+++ b/drivers/lightnvm/pblk-init.c
@@ -132,7 +132,6 @@ static int pblk_rwb_init(struct pblk *pblk)
 }
 
 /* Minimum pages needed within a lun */
-#define PAGE_POOL_SIZE 16
 #define ADDR_POOL_SIZE 64
 
 static int pblk_set_ppaf(struct pblk *pblk)
@@ -247,14 +246,16 @@ static int pblk_core_init(struct pblk *pblk)
 	if (pblk_init_global_caches(pblk))
 		return -ENOMEM;
 
-	pblk->page_pool = mempool_create_page_pool(PAGE_POOL_SIZE, 0);
-	if (!pblk->page_pool)
+	/* internal bios can be at most the sectors signaled by the device. */
+	pblk->page_bio_pool = mempool_create_page_pool(nvm_max_phys_sects(dev),
+									0);
+	if (!pblk->page_bio_pool)
 		return -ENOMEM;
 
 	pblk->line_ws_pool = mempool_create_slab_pool(PBLK_WS_POOL_SIZE,
 							pblk_blk_ws_cache);
 	if (!pblk->line_ws_pool)
-		goto free_page_pool;
+		goto free_page_bio_pool;
 
 	pblk->rec_pool = mempool_create_slab_pool(geo->nr_luns, pblk_rec_cache);
 	if (!pblk->rec_pool)
@@ -309,8 +310,8 @@ static int pblk_core_init(struct pblk *pblk)
 	mempool_destroy(pblk->rec_pool);
 free_blk_ws_pool:
 	mempool_destroy(pblk->line_ws_pool);
-free_page_pool:
-	mempool_destroy(pblk->page_pool);
+free_page_bio_pool:
+	mempool_destroy(pblk->page_bio_pool);
 	return -ENOMEM;
 }
 
@@ -322,7 +323,7 @@ static void pblk_core_free(struct pblk *pblk)
 	if (pblk->bb_wq)
 		destroy_workqueue(pblk->bb_wq);
 
-	mempool_destroy(pblk->page_pool);
+	mempool_destroy(pblk->page_bio_pool);
 	mempool_destroy(pblk->line_ws_pool);
 	mempool_destroy(pblk->rec_pool);
 	mempool_destroy(pblk->g_rq_pool);
diff --git a/drivers/lightnvm/pblk-read.c b/drivers/lightnvm/pblk-read.c
index ee8efb5..402c732 100644
--- a/drivers/lightnvm/pblk-read.c
+++ b/drivers/lightnvm/pblk-read.c
@@ -238,7 +238,7 @@ static int pblk_fill_partial_read_bio(struct pblk *pblk, struct nvm_rq *rqd,
 		kunmap_atomic(src_p);
 		kunmap_atomic(dst_p);
 
-		mempool_free(src_bv.bv_page, pblk->page_pool);
+		mempool_free(src_bv.bv_page, pblk->page_bio_pool);
 
 		hole = find_next_zero_bit(read_bitmap, nr_secs, hole + 1);
 	} while (hole < nr_secs);
diff --git a/drivers/lightnvm/pblk.h b/drivers/lightnvm/pblk.h
index b592e51..229f602 100644
--- a/drivers/lightnvm/pblk.h
+++ b/drivers/lightnvm/pblk.h
@@ -620,7 +620,7 @@ struct pblk {
 
 	struct list_head compl_list;
 
-	mempool_t *page_pool;
+	mempool_t *page_bio_pool;
 	mempool_t *line_ws_pool;
 	mempool_t *rec_pool;
 	mempool_t *g_rq_pool;
-- 
2.9.3
