Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mail-wm0-f68.google.com ([74.125.82.68]:48926 "EHLO
        mail-wm0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1758151AbdJMMrV (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 13 Oct 2017 08:47:21 -0400
Received: by mail-wm0-f68.google.com with SMTP id i124so21102868wmf.3
        for <linux-block@vger.kernel.org>; Fri, 13 Oct 2017 05:47:20 -0700 (PDT)
From: =?UTF-8?q?Matias=20Bj=C3=B8rling?= <m@bjorling.me>
To: axboe@fb.com
Cc: linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        =?UTF-8?q?Javier=20Gonz=C3=A1lez?= <javier@cnexlabs.com>,
        =?UTF-8?q?Matias=20Bj=C3=B8rling?= <m@bjorling.me>
Subject: [GIT PULL 14/58] lightnvm: pblk: free padded entries in write buffer
Date: Fri, 13 Oct 2017 14:46:03 +0200
Message-Id: <20171013124647.32668-15-m@bjorling.me>
In-Reply-To: <20171013124647.32668-1-m@bjorling.me>
References: <20171013124647.32668-1-m@bjorling.me>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

From: Javier González <javier@cnexlabs.com>

When a REQ_FLUSH reaches pblk, the bio cannot be directly completed.
Instead, data on the write buffer is flushed and the bio is completed on
the completion pah. This might require some sectors to be padded in
order to guarantee a successful write.

This patch fixes a memory leak on the padded pages. A consequence of
this bad free was that internal bios not containing data (only a flush)
were not being completed.

Fixes: a4bd217b4326 ("lightnvm: physical block device (pblk) target")
Signed-off-by: Javier González <javier@cnexlabs.com>
Signed-off-by: Matias Bjørling <m@bjorling.me>
---
 drivers/lightnvm/pblk-core.c  | 1 -
 drivers/lightnvm/pblk-write.c | 7 ++++++-
 2 files changed, 6 insertions(+), 2 deletions(-)

diff --git a/drivers/lightnvm/pblk-core.c b/drivers/lightnvm/pblk-core.c
index a68c6ae..9299a5a 100644
--- a/drivers/lightnvm/pblk-core.c
+++ b/drivers/lightnvm/pblk-core.c
@@ -190,7 +190,6 @@ void pblk_bio_free_pages(struct pblk *pblk, struct bio *bio, int off,
 
 	WARN_ON(off + nr_pages != bio->bi_vcnt);
 
-	bio_advance(bio, off * PBLK_EXPOSED_PAGE_SIZE);
 	for (i = off; i < nr_pages + off; i++) {
 		bv = bio->bi_io_vec[i];
 		mempool_free(bv.bv_page, pblk->page_pool);
diff --git a/drivers/lightnvm/pblk-write.c b/drivers/lightnvm/pblk-write.c
index 3ad9e56..d89ac57 100644
--- a/drivers/lightnvm/pblk-write.c
+++ b/drivers/lightnvm/pblk-write.c
@@ -33,6 +33,10 @@ static unsigned long pblk_end_w_bio(struct pblk *pblk, struct nvm_rq *rqd,
 			bio_endio(original_bio);
 	}
 
+	if (c_ctx->nr_padded)
+		pblk_bio_free_pages(pblk, rqd->bio, c_ctx->nr_valid,
+							c_ctx->nr_padded);
+
 #ifdef CONFIG_NVM_DEBUG
 	atomic_long_add(c_ctx->nr_valid, &pblk->sync_writes);
 #endif
@@ -521,7 +525,8 @@ static void pblk_free_write_rqd(struct pblk *pblk, struct nvm_rq *rqd)
 	struct bio *bio = rqd->bio;
 
 	if (c_ctx->nr_padded)
-		pblk_bio_free_pages(pblk, bio, rqd->nr_ppas, c_ctx->nr_padded);
+		pblk_bio_free_pages(pblk, bio, c_ctx->nr_valid,
+							c_ctx->nr_padded);
 }
 
 static int pblk_submit_write(struct pblk *pblk)
-- 
2.9.3
