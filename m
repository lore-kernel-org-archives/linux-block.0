Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mga09.intel.com ([134.134.136.24]:25419 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S932089AbeEWMao (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Wed, 23 May 2018 08:30:44 -0400
From: Igor Konopko <igor.j.konopko@intel.com>
To: mb@lightnvm.io
Cc: linux-block@vger.kernel.org, marcin.dziegielewski@intel.com,
        Igor Konopko <igor.j.konopko@intel.com>
Subject: [PATCH 1/3] lightnvm: Proper error handling for pblk_bio_add_pages
Date: Wed, 23 May 2018 14:29:54 +0200
Message-Id: <20180523122956.24137-2-igor.j.konopko@intel.com>
In-Reply-To: <20180523122956.24137-1-igor.j.konopko@intel.com>
References: <20180523122956.24137-1-igor.j.konopko@intel.com>
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

Currently in case of error caused by bio_pc_add_page in pblk_bio_add_pages
two issues occur when calling from pblk_rb_read_to_bio().
First one is in pblk_bio_free_pages, since we are trying to free
pages not allocated from our mempool. Second one is the warn from
dma_pool_free, that we are trying to free NULL pointer dma. 
This commit fix that both issues.

Signed-off-by: Igor Konopko <igor.j.konopko@intel.com>
Signed-off-by: Marcin Dziegielewski <marcin.dziegielewski@intel.com>
---
 drivers/lightnvm/pblk-core.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/lightnvm/pblk-core.c b/drivers/lightnvm/pblk-core.c
index e43093e27084..6d21f9dbca5f 100644
--- a/drivers/lightnvm/pblk-core.c
+++ b/drivers/lightnvm/pblk-core.c
@@ -278,7 +278,8 @@ void pblk_free_rqd(struct pblk *pblk, struct nvm_rq *rqd, int type)
 		return;
 	}
 
-	nvm_dev_dma_free(dev->parent, rqd->meta_list, rqd->dma_meta_list);
+	if (rqd->meta_list)
+		nvm_dev_dma_free(dev->parent, rqd->meta_list,
+				 rqd->dma_meta_list);
 	mempool_free(rqd, pool);
 }
 
@@ -316,7 +317,7 @@ int pblk_bio_add_pages(struct pblk *pblk, struct bio *bio, gfp_t flags,
 
 	return 0;
 err:
-	pblk_bio_free_pages(pblk, bio, 0, i - 1);
+	pblk_bio_free_pages(pblk, bio, (bio->bi_vcnt - i), i);
 	return -1;
 }
 
-- 
2.14.3
