Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mail-wm0-f66.google.com ([74.125.82.66]:38401 "EHLO
        mail-wm0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1756018AbdLTRWj (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 20 Dec 2017 12:22:39 -0500
Received: by mail-wm0-f66.google.com with SMTP id 64so11126187wme.3
        for <linux-block@vger.kernel.org>; Wed, 20 Dec 2017 09:22:38 -0800 (PST)
From: =?UTF-8?q?Matias=20Bj=C3=B8rling?= <m@bjorling.me>
To: linux-block@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: =?UTF-8?q?Javier=20Gonz=C3=A1lez?= <javier@cnexlabs.com>,
        =?UTF-8?q?Matias=20Bj=C3=B8rling?= <m@bjorling.me>
Subject: [PATCH 24/25] lightnvm: pblk: add iostat support
Date: Wed, 20 Dec 2017 18:22:04 +0100
Message-Id: <20171220172205.26464-25-m@bjorling.me>
In-Reply-To: <20171220172205.26464-1-m@bjorling.me>
References: <20171220172205.26464-1-m@bjorling.me>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

From: Javier González <javier@cnexlabs.com>

Since pblk registers its own block device, the iostat accounting is
not automatically done for us. Therefore, add the necessary
accounting logic to satisfy the iostat interface.

Signed-off-by: Javier González <javier@cnexlabs.com>
Signed-off-by: Matias Bjørling <m@bjorling.me>
---
 drivers/lightnvm/pblk-cache.c |  5 +++++
 drivers/lightnvm/pblk-read.c  | 31 +++++++++++++++++++------------
 drivers/lightnvm/pblk.h       |  1 +
 3 files changed, 25 insertions(+), 12 deletions(-)

diff --git a/drivers/lightnvm/pblk-cache.c b/drivers/lightnvm/pblk-cache.c
index 0d227ef..000fcad 100644
--- a/drivers/lightnvm/pblk-cache.c
+++ b/drivers/lightnvm/pblk-cache.c
@@ -19,12 +19,16 @@
 
 int pblk_write_to_cache(struct pblk *pblk, struct bio *bio, unsigned long flags)
 {
+	struct request_queue *q = pblk->dev->q;
 	struct pblk_w_ctx w_ctx;
 	sector_t lba = pblk_get_lba(bio);
+	unsigned long start_time = jiffies;
 	unsigned int bpos, pos;
 	int nr_entries = pblk_get_secs(bio);
 	int i, ret;
 
+	generic_start_io_acct(q, WRITE, bio_sectors(bio), &pblk->disk->part0);
+
 	/* Update the write buffer head (mem) with the entries that we can
 	 * write. The write in itself cannot fail, so there is no need to
 	 * rollback from here on.
@@ -67,6 +71,7 @@ int pblk_write_to_cache(struct pblk *pblk, struct bio *bio, unsigned long flags)
 	pblk_rl_inserted(&pblk->rl, nr_entries);
 
 out:
+	generic_end_io_acct(q, WRITE, &pblk->disk->part0, start_time);
 	pblk_write_should_kick(pblk);
 	return ret;
 }
diff --git a/drivers/lightnvm/pblk-read.c b/drivers/lightnvm/pblk-read.c
index 0fe0c04..2f76128 100644
--- a/drivers/lightnvm/pblk-read.c
+++ b/drivers/lightnvm/pblk-read.c
@@ -158,8 +158,12 @@ static void pblk_end_user_read(struct bio *bio)
 static void __pblk_end_io_read(struct pblk *pblk, struct nvm_rq *rqd,
 			       bool put_line)
 {
+	struct nvm_tgt_dev *dev = pblk->dev;
 	struct pblk_g_ctx *r_ctx = nvm_rq_to_pdu(rqd);
 	struct bio *bio = rqd->bio;
+	unsigned long start_time = r_ctx->start_time;
+
+	generic_end_io_acct(dev->q, READ, &pblk->disk->part0, start_time);
 
 	if (rqd->error)
 		pblk_log_read_err(pblk, rqd);
@@ -193,9 +197,9 @@ static void pblk_end_io_read(struct nvm_rq *rqd)
 	__pblk_end_io_read(pblk, rqd, true);
 }
 
-static int pblk_fill_partial_read_bio(struct pblk *pblk, struct nvm_rq *rqd,
-				      unsigned int bio_init_idx,
-				      unsigned long *read_bitmap)
+static int pblk_partial_read_bio(struct pblk *pblk, struct nvm_rq *rqd,
+				 unsigned int bio_init_idx,
+				 unsigned long *read_bitmap)
 {
 	struct bio *new_bio, *bio = rqd->bio;
 	struct pblk_sec_meta *meta_list = rqd->meta_list;
@@ -306,6 +310,8 @@ static int pblk_fill_partial_read_bio(struct pblk *pblk, struct nvm_rq *rqd,
 	return NVM_IO_OK;
 
 err:
+	pr_err("pblk: failed to perform partial read\n");
+
 	/* Free allocated pages in new bio */
 	pblk_bio_free_pages(pblk, bio, 0, new_bio->bi_vcnt);
 	__pblk_end_io_read(pblk, rqd, false);
@@ -357,6 +363,7 @@ static void pblk_read_rq(struct pblk *pblk, struct nvm_rq *rqd,
 int pblk_submit_read(struct pblk *pblk, struct bio *bio)
 {
 	struct nvm_tgt_dev *dev = pblk->dev;
+	struct request_queue *q = dev->q;
 	sector_t blba = pblk_get_lba(bio);
 	unsigned int nr_secs = pblk_get_secs(bio);
 	struct pblk_g_ctx *r_ctx;
@@ -372,6 +379,8 @@ int pblk_submit_read(struct pblk *pblk, struct bio *bio)
 		return NVM_IO_ERR;
 	}
 
+	generic_start_io_acct(q, READ, bio_sectors(bio), &pblk->disk->part0);
+
 	bitmap_zero(&read_bitmap, nr_secs);
 
 	rqd = pblk_alloc_rqd(pblk, PBLK_READ);
@@ -383,6 +392,7 @@ int pblk_submit_read(struct pblk *pblk, struct bio *bio)
 	rqd->end_io = pblk_end_io_read;
 
 	r_ctx = nvm_rq_to_pdu(rqd);
+	r_ctx->start_time = jiffies;
 	r_ctx->lba = blba;
 
 	/* Save the index for this bio's start. This is needed in case
@@ -422,7 +432,7 @@ int pblk_submit_read(struct pblk *pblk, struct bio *bio)
 		int_bio = bio_clone_fast(bio, GFP_KERNEL, pblk_bio_set);
 		if (!int_bio) {
 			pr_err("pblk: could not clone read bio\n");
-			return NVM_IO_ERR;
+			goto fail_end_io;
 		}
 
 		rqd->bio = int_bio;
@@ -433,7 +443,7 @@ int pblk_submit_read(struct pblk *pblk, struct bio *bio)
 			pr_err("pblk: read IO submission failed\n");
 			if (int_bio)
 				bio_put(int_bio);
-			return ret;
+			goto fail_end_io;
 		}
 
 		return NVM_IO_OK;
@@ -442,17 +452,14 @@ int pblk_submit_read(struct pblk *pblk, struct bio *bio)
 	/* The read bio request could be partially filled by the write buffer,
 	 * but there are some holes that need to be read from the drive.
 	 */
-	ret = pblk_fill_partial_read_bio(pblk, rqd, bio_init_idx, &read_bitmap);
-	if (ret) {
-		pr_err("pblk: failed to perform partial read\n");
-		return ret;
-	}
-
-	return NVM_IO_OK;
+	return pblk_partial_read_bio(pblk, rqd, bio_init_idx, &read_bitmap);
 
 fail_rqd_free:
 	pblk_free_rqd(pblk, rqd, PBLK_READ);
 	return ret;
+fail_end_io:
+	__pblk_end_io_read(pblk, rqd, false);
+	return ret;
 }
 
 static int read_ppalist_rq_gc(struct pblk *pblk, struct nvm_rq *rqd,
diff --git a/drivers/lightnvm/pblk.h b/drivers/lightnvm/pblk.h
index cb38990..1e9eafd 100644
--- a/drivers/lightnvm/pblk.h
+++ b/drivers/lightnvm/pblk.h
@@ -113,6 +113,7 @@ struct pblk_c_ctx {
 /* read context */
 struct pblk_g_ctx {
 	void *private;
+	unsigned long start_time;
 	u64 lba;
 };
 
-- 
2.9.3
