Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mail-pl0-f68.google.com ([209.85.160.68]:39408 "EHLO
        mail-pl0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729775AbeGMJDJ (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 13 Jul 2018 05:03:09 -0400
Received: by mail-pl0-f68.google.com with SMTP id p23-v6so660418plo.6
        for <linux-block@vger.kernel.org>; Fri, 13 Jul 2018 01:49:30 -0700 (PDT)
From: =?UTF-8?q?Matias=20Bj=C3=B8rling?= <mb@lightnvm.io>
To: axboe@fb.com
Cc: linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        bart.vanassche@wdc.com, hans.holmberg@cnexlabs.com,
        javier@cnexlabs.com, hlitz@ucsc.edu, igor.j.konopko@intel.com,
        marcin.dziegielewski@intel.com,
        =?UTF-8?q?Matias=20Bj=C3=B8rling?= <mb@lightnvm.io>
Subject: [GIT PULL 05/10] lightnvm: pblk: fix read_bitmap for 32bit archs
Date: Fri, 13 Jul 2018 10:48:40 +0200
Message-Id: <20180713084845.19511-6-mb@lightnvm.io>
In-Reply-To: <20180713084845.19511-1-mb@lightnvm.io>
References: <20180713084845.19511-1-mb@lightnvm.io>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

If using pblk on a 32bit architecture, and there is a need to
perform a partial read, the partial read bitmap will only have
allocated 32 entries, where as 64 are needed.

Make sure that the read_bitmap is initialized to 64bits on 32bit
architectures as well.

Signed-off-by: Matias Bjørling <mb@lightnvm.io>
Reviewed-by: Igor Konopko <igor.j.konopko@intel.com>
Reviewed-by: Javier González <javier@cnexlabs.com>
---
 drivers/lightnvm/pblk-read.c | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/drivers/lightnvm/pblk-read.c b/drivers/lightnvm/pblk-read.c
index 6e93c489ce57..bcfc6ea86e9d 100644
--- a/drivers/lightnvm/pblk-read.c
+++ b/drivers/lightnvm/pblk-read.c
@@ -401,7 +401,7 @@ int pblk_submit_read(struct pblk *pblk, struct bio *bio)
 	struct pblk_g_ctx *r_ctx;
 	struct nvm_rq *rqd;
 	unsigned int bio_init_idx;
-	unsigned long read_bitmap; /* Max 64 ppas per request */
+	DECLARE_BITMAP(read_bitmap, NVM_MAX_VLBA);
 	int ret = NVM_IO_ERR;
 
 	/* logic error: lba out-of-bounds. Ignore read request */
@@ -413,7 +413,7 @@ int pblk_submit_read(struct pblk *pblk, struct bio *bio)
 
 	generic_start_io_acct(q, READ, bio_sectors(bio), &pblk->disk->part0);
 
-	bitmap_zero(&read_bitmap, nr_secs);
+	bitmap_zero(read_bitmap, nr_secs);
 
 	rqd = pblk_alloc_rqd(pblk, PBLK_READ);
 
@@ -444,19 +444,19 @@ int pblk_submit_read(struct pblk *pblk, struct bio *bio)
 		rqd->ppa_list = rqd->meta_list + pblk_dma_meta_size;
 		rqd->dma_ppa_list = rqd->dma_meta_list + pblk_dma_meta_size;
 
-		pblk_read_ppalist_rq(pblk, rqd, bio, blba, &read_bitmap);
+		pblk_read_ppalist_rq(pblk, rqd, bio, blba, read_bitmap);
 	} else {
-		pblk_read_rq(pblk, rqd, bio, blba, &read_bitmap);
+		pblk_read_rq(pblk, rqd, bio, blba, read_bitmap);
 	}
 
-	if (bitmap_full(&read_bitmap, nr_secs)) {
+	if (bitmap_full(read_bitmap, nr_secs)) {
 		atomic_inc(&pblk->inflight_io);
 		__pblk_end_io_read(pblk, rqd, false);
 		return NVM_IO_DONE;
 	}
 
 	/* All sectors are to be read from the device */
-	if (bitmap_empty(&read_bitmap, rqd->nr_ppas)) {
+	if (bitmap_empty(read_bitmap, rqd->nr_ppas)) {
 		struct bio *int_bio = NULL;
 
 		/* Clone read bio to deal with read errors internally */
@@ -480,7 +480,7 @@ int pblk_submit_read(struct pblk *pblk, struct bio *bio)
 	/* The read bio request could be partially filled by the write buffer,
 	 * but there are some holes that need to be read from the drive.
 	 */
-	return pblk_partial_read(pblk, rqd, bio, bio_init_idx, &read_bitmap);
+	return pblk_partial_read(pblk, rqd, bio, bio_init_idx, read_bitmap);
 
 fail_rqd_free:
 	pblk_free_rqd(pblk, rqd, PBLK_READ);
-- 
2.11.0
