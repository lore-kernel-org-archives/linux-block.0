Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mail-wm0-f44.google.com ([74.125.82.44]:35631 "EHLO
        mail-wm0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753348AbdIFKwt (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Wed, 6 Sep 2017 06:52:49 -0400
Received: by mail-wm0-f44.google.com with SMTP id f199so7945140wme.0
        for <linux-block@vger.kernel.org>; Wed, 06 Sep 2017 03:52:49 -0700 (PDT)
From: "=?UTF-8?q?Javier=20Gonz=C3=A1lez?=" <jg@lightnvm.io>
To: mb@lightnvm.io, axboe@fb.com
Cc: linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        =?UTF-8?q?Javier=20Gonz=C3=A1lez?= <javier@cnexlabs.com>,
        =?UTF-8?q?Matias=20Bj=C3=B8rling?= <matias@cnexlabs.com>
Subject: [PATCH 12/18] lightnvm: pblk: free padded entries in write buffer
Date: Wed,  6 Sep 2017 12:51:05 +0200
Message-Id: <1504695071-25928-13-git-send-email-javier@cnexlabs.com>
In-Reply-To: <1504695071-25928-1-git-send-email-javier@cnexlabs.com>
References: <1504695071-25928-1-git-send-email-javier@cnexlabs.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

When a REQ_FLUSH reaches pblk, the bio cannot be directly completed.
Instead, data on the write buffer is flushed and the bio is completed on
the completion pah. This might require some sectors to be padded in
order to guarantee a successful write.

This patch fixes a memory leak on the padded pages. A consequence of
this bad free was that internal bios not containing data (only a flush)
were not being completed.

Fixes: a4bd217b4326 ("lightnvm: physical block device (pblk) target")
Signed-off-by: Javier González <javier@cnexlabs.com>
Signed-off-by: Matias Bjørling <matias@cnexlabs.com>
---
 drivers/lightnvm/pblk-core.c  |  1 -
 drivers/lightnvm/pblk-write.c | 14 +++++++++++---
 2 files changed, 11 insertions(+), 4 deletions(-)

diff --git a/drivers/lightnvm/pblk-core.c b/drivers/lightnvm/pblk-core.c
index e69e8829b093..1f746e31e379 100644
--- a/drivers/lightnvm/pblk-core.c
+++ b/drivers/lightnvm/pblk-core.c
@@ -187,7 +187,6 @@ void pblk_bio_free_pages(struct pblk *pblk, struct bio *bio, int off,
 
 	WARN_ON(off + nr_pages != bio->bi_vcnt);
 
-	bio_advance(bio, off * PBLK_EXPOSED_PAGE_SIZE);
 	for (i = off; i < nr_pages + off; i++) {
 		bv = bio->bi_io_vec[i];
 		mempool_free(bv.bv_page, pblk->page_pool);
diff --git a/drivers/lightnvm/pblk-write.c b/drivers/lightnvm/pblk-write.c
index e5d77af1aad1..33dd90251a60 100644
--- a/drivers/lightnvm/pblk-write.c
+++ b/drivers/lightnvm/pblk-write.c
@@ -25,13 +25,20 @@ static unsigned long pblk_end_w_bio(struct pblk *pblk, struct nvm_rq *rqd,
 	unsigned long ret;
 	int i;
 
-	for (i = 0; i < c_ctx->nr_valid; i++) {
+	i = 0;
+	do {
 		struct pblk_w_ctx *w_ctx;
 
 		w_ctx = pblk_rb_w_ctx(&pblk->rwb, c_ctx->sentry + i);
 		while ((original_bio = bio_list_pop(&w_ctx->bios)))
 			bio_endio(original_bio);
-	}
+
+		i++;
+	} while (i < c_ctx->nr_valid);
+
+	if (c_ctx->nr_padded)
+		pblk_bio_free_pages(pblk, rqd->bio, c_ctx->nr_valid,
+							c_ctx->nr_padded);
 
 #ifdef CONFIG_NVM_DEBUG
 	atomic_long_add(c_ctx->nr_valid, &pblk->sync_writes);
@@ -516,7 +523,8 @@ static void pblk_free_write_rqd(struct pblk *pblk, struct nvm_rq *rqd)
 	struct bio *bio = rqd->bio;
 
 	if (c_ctx->nr_padded)
-		pblk_bio_free_pages(pblk, bio, rqd->nr_ppas, c_ctx->nr_padded);
+		pblk_bio_free_pages(pblk, bio, c_ctx->nr_valid,
+							c_ctx->nr_padded);
 }
 
 static int pblk_submit_write(struct pblk *pblk)
-- 
2.7.4
