Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mail-lf0-f68.google.com ([209.85.215.68]:42129 "EHLO
        mail-lf0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752365AbeFANFN (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Fri, 1 Jun 2018 09:05:13 -0400
Received: by mail-lf0-f68.google.com with SMTP id v135-v6so14745018lfa.9
        for <linux-block@vger.kernel.org>; Fri, 01 Jun 2018 06:05:13 -0700 (PDT)
From: =?UTF-8?q?Matias=20Bj=C3=B8rling?= <mb@lightnvm.io>
To: axboe@fb.com
Cc: linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        javier@cnexlabs.com, igor.j.konopko@intel.com,
        marcin.dziegielewski@intel.com,
        =?UTF-8?q?Matias=20Bj=C3=B8rling?= <mb@lightnvm.io>
Subject: [GIT PULL 15/18] lightnvm: proper error handling for pblk_bio_add_pages
Date: Fri,  1 Jun 2018 15:04:29 +0200
Message-Id: <20180601130432.30866-16-mb@lightnvm.io>
In-Reply-To: <20180601130432.30866-1-mb@lightnvm.io>
References: <20180601130432.30866-1-mb@lightnvm.io>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

From: Igor Konopko <igor.j.konopko@intel.com>

Currently in case of error caused by bio_pc_add_page in
pblk_bio_add_pages two issues occur when calling from
pblk_rb_read_to_bio(). First one is in pblk_bio_free_pages, since we
are trying to free pages not allocated from our mempool. Second one
is the warn from dma_pool_free, that we are trying to free NULL
pointer dma.

This commit fix both issues.

Signed-off-by: Igor Konopko <igor.j.konopko@intel.com>
Signed-off-by: Marcin Dziegielewski <marcin.dziegielewski@intel.com>
Signed-off-by: Matias Bjørling <mb@lightnvm.io>
---
 drivers/lightnvm/pblk-core.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/lightnvm/pblk-core.c b/drivers/lightnvm/pblk-core.c
index e43093e27084..a20b41c355c5 100644
--- a/drivers/lightnvm/pblk-core.c
+++ b/drivers/lightnvm/pblk-core.c
@@ -278,7 +278,9 @@ void pblk_free_rqd(struct pblk *pblk, struct nvm_rq *rqd, int type)
 		return;
 	}
 
-	nvm_dev_dma_free(dev->parent, rqd->meta_list, rqd->dma_meta_list);
+	if (rqd->meta_list)
+		nvm_dev_dma_free(dev->parent, rqd->meta_list,
+				rqd->dma_meta_list);
 	mempool_free(rqd, pool);
 }
 
@@ -316,7 +318,7 @@ int pblk_bio_add_pages(struct pblk *pblk, struct bio *bio, gfp_t flags,
 
 	return 0;
 err:
-	pblk_bio_free_pages(pblk, bio, 0, i - 1);
+	pblk_bio_free_pages(pblk, bio, (bio->bi_vcnt - i), i);
 	return -1;
 }
 
-- 
2.11.0
