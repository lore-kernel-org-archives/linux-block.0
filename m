Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mail-wr0-f173.google.com ([209.85.128.173]:36092 "EHLO
        mail-wr0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752360AbdGGTJA (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Fri, 7 Jul 2017 15:09:00 -0400
Received: by mail-wr0-f173.google.com with SMTP id c11so59218435wrc.3
        for <linux-block@vger.kernel.org>; Fri, 07 Jul 2017 12:09:00 -0700 (PDT)
From: "=?UTF-8?q?Javier=20Gonz=C3=A1lez?=" <jg@lightnvm.io>
To: mb@lightnvm.io, axboe@fb.com
Cc: linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        =?UTF-8?q?Javier=20Gonz=C3=A1lez?= <javier@cnexlabs.com>,
        =?UTF-8?q?Matias=20Bj=C3=B8rling?= <matias@cnexlabs.com>
Subject: [PATCH 2/2] lightnvm: pblk: remove unnecessary checks
Date: Fri,  7 Jul 2017 21:08:53 +0200
Message-Id: <1499454533-14907-3-git-send-email-javier@cnexlabs.com>
In-Reply-To: <1499454533-14907-1-git-send-email-javier@cnexlabs.com>
References: <1499454533-14907-1-git-send-email-javier@cnexlabs.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

Remove unnecessary checks when freeing dma memory in the completion
path.

Signed-off-by: Javier González <javier@cnexlabs.com>
Signed-off-by: Matias Bjørling <matias@cnexlabs.com>
---
 drivers/lightnvm/pblk-write.c | 7 +------
 1 file changed, 1 insertion(+), 6 deletions(-)

diff --git a/drivers/lightnvm/pblk-write.c b/drivers/lightnvm/pblk-write.c
index cc2b9414d17c..3ad9e56d2473 100644
--- a/drivers/lightnvm/pblk-write.c
+++ b/drivers/lightnvm/pblk-write.c
@@ -39,9 +39,7 @@ static unsigned long pblk_end_w_bio(struct pblk *pblk, struct nvm_rq *rqd,
 
 	ret = pblk_rb_sync_advance(&pblk->rwb, c_ctx->nr_valid);
 
-	if (rqd->meta_list)
-		nvm_dev_dma_free(dev->parent, rqd->meta_list,
-							rqd->dma_meta_list);
+	nvm_dev_dma_free(dev->parent, rqd->meta_list, rqd->dma_meta_list);
 
 	bio_put(rqd->bio);
 	pblk_free_rqd(pblk, rqd, WRITE);
@@ -224,9 +222,6 @@ static int pblk_alloc_w_rq(struct pblk *pblk, struct nvm_rq *rqd,
 	if (!rqd->meta_list)
 		return -ENOMEM;
 
-	if (unlikely(nr_secs == 1))
-		return 0;
-
 	rqd->ppa_list = rqd->meta_list + pblk_dma_meta_size;
 	rqd->dma_ppa_list = rqd->dma_meta_list + pblk_dma_meta_size;
 
-- 
2.7.4
