Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mail-wm0-f47.google.com ([74.125.82.47]:38677 "EHLO
        mail-wm0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932747AbdIFPBS (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Wed, 6 Sep 2017 11:01:18 -0400
Received: by mail-wm0-f47.google.com with SMTP id 187so32068531wmn.1
        for <linux-block@vger.kernel.org>; Wed, 06 Sep 2017 08:01:18 -0700 (PDT)
From: "=?UTF-8?q?Javier=20Gonz=C3=A1lez?=" <jg@lightnvm.io>
To: mb@lightnvm.io, axboe@fb.com
Cc: linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        =?UTF-8?q?Javier=20Gonz=C3=A1lez?= <javier@cnexlabs.com>,
        =?UTF-8?q?Matias=20Bj=C3=B8rling?= <matias@cnexlabs.com>
Subject: [PATCH 4/6] lightnvm: pblk: free padded entries in write buffer
Date: Wed,  6 Sep 2017 17:01:04 +0200
Message-Id: <1504710066-4699-5-git-send-email-javier@cnexlabs.com>
In-Reply-To: <1504710066-4699-1-git-send-email-javier@cnexlabs.com>
References: <1504710066-4699-1-git-send-email-javier@cnexlabs.com>
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
index acb07bbcb416..84bff271abd8 100644
--- a/drivers/lightnvm/pblk-core.c
+++ b/drivers/lightnvm/pblk-core.c
@@ -192,7 +192,6 @@ void pblk_bio_free_pages(struct pblk *pblk, struct bio *bio, int off,
 
 	WARN_ON(off + nr_pages != bio->bi_vcnt);
 
-	bio_advance(bio, off * PBLK_EXPOSED_PAGE_SIZE);
 	for (i = off; i < nr_pages + off; i++) {
 		bv = bio->bi_io_vec[i];
 		mempool_free(bv.bv_page, pblk->page_pool);
diff --git a/drivers/lightnvm/pblk-write.c b/drivers/lightnvm/pblk-write.c
index 3ad9e56d2473..6acb4a92435f 100644
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
@@ -521,7 +528,8 @@ static void pblk_free_write_rqd(struct pblk *pblk, struct nvm_rq *rqd)
 	struct bio *bio = rqd->bio;
 
 	if (c_ctx->nr_padded)
-		pblk_bio_free_pages(pblk, bio, rqd->nr_ppas, c_ctx->nr_padded);
+		pblk_bio_free_pages(pblk, bio, c_ctx->nr_valid,
+							c_ctx->nr_padded);
 }
 
 static int pblk_submit_write(struct pblk *pblk)
-- 
2.7.4
