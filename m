Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mail-wm0-f65.google.com ([74.125.82.65]:53034 "EHLO
        mail-wm0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1758215AbdJMMra (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 13 Oct 2017 08:47:30 -0400
Received: by mail-wm0-f65.google.com with SMTP id k4so21549676wmc.1
        for <linux-block@vger.kernel.org>; Fri, 13 Oct 2017 05:47:30 -0700 (PDT)
From: =?UTF-8?q?Matias=20Bj=C3=B8rling?= <m@bjorling.me>
To: axboe@fb.com
Cc: linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        =?UTF-8?q?Javier=20Gonz=C3=A1lez?= <javier@cnexlabs.com>,
        =?UTF-8?q?Matias=20Bj=C3=B8rling?= <m@bjorling.me>
Subject: [GIT PULL 24/58] lightnvm: pblk: refactor read lba sanity check
Date: Fri, 13 Oct 2017 14:46:13 +0200
Message-Id: <20171013124647.32668-25-m@bjorling.me>
In-Reply-To: <20171013124647.32668-1-m@bjorling.me>
References: <20171013124647.32668-1-m@bjorling.me>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

From: Javier González <javier@cnexlabs.com>

Refactor lba sanity check on read path to avoid code duplication.

Signed-off-by: Javier González <javier@cnexlabs.com>
Signed-off-by: Matias Bjørling <m@bjorling.me>
---
 drivers/lightnvm/pblk-read.c | 29 ++++++++++-------------------
 1 file changed, 10 insertions(+), 19 deletions(-)

diff --git a/drivers/lightnvm/pblk-read.c b/drivers/lightnvm/pblk-read.c
index d2b6e2a..eaaf9d5 100644
--- a/drivers/lightnvm/pblk-read.c
+++ b/drivers/lightnvm/pblk-read.c
@@ -39,21 +39,14 @@ static int pblk_read_from_cache(struct pblk *pblk, struct bio *bio,
 }
 
 static void pblk_read_ppalist_rq(struct pblk *pblk, struct nvm_rq *rqd,
-				 unsigned long *read_bitmap)
+				 sector_t blba, unsigned long *read_bitmap)
 {
 	struct bio *bio = rqd->bio;
 	struct ppa_addr ppas[PBLK_MAX_REQ_ADDRS];
-	sector_t blba = pblk_get_lba(bio);
 	int nr_secs = rqd->nr_ppas;
 	bool advanced_bio = false;
 	int i, j = 0;
 
-	/* logic error: lba out-of-bounds. Ignore read request */
-	if (blba + nr_secs >= pblk->rl.nr_secs) {
-		WARN(1, "pblk: read lbas out of bounds\n");
-		return;
-	}
-
 	pblk_lookup_l2p_seq(pblk, ppas, blba, nr_secs);
 
 	for (i = 0; i < nr_secs; i++) {
@@ -259,17 +252,10 @@ static int pblk_fill_partial_read_bio(struct pblk *pblk, struct nvm_rq *rqd,
 }
 
 static void pblk_read_rq(struct pblk *pblk, struct nvm_rq *rqd,
-			 unsigned long *read_bitmap)
+			 sector_t lba, unsigned long *read_bitmap)
 {
 	struct bio *bio = rqd->bio;
 	struct ppa_addr ppa;
-	sector_t lba = pblk_get_lba(bio);
-
-	/* logic error: lba out-of-bounds. Ignore read request */
-	if (lba >= pblk->rl.nr_secs) {
-		WARN(1, "pblk: read lba out of bounds\n");
-		return;
-	}
 
 	pblk_lookup_l2p_seq(pblk, &ppa, lba, 1);
 
@@ -305,14 +291,19 @@ static void pblk_read_rq(struct pblk *pblk, struct nvm_rq *rqd,
 int pblk_submit_read(struct pblk *pblk, struct bio *bio)
 {
 	struct nvm_tgt_dev *dev = pblk->dev;
+	sector_t blba = pblk_get_lba(bio);
 	unsigned int nr_secs = pblk_get_secs(bio);
 	struct nvm_rq *rqd;
 	unsigned long read_bitmap; /* Max 64 ppas per request */
 	unsigned int bio_init_idx;
 	int ret = NVM_IO_ERR;
 
-	if (nr_secs > PBLK_MAX_REQ_ADDRS)
+	/* logic error: lba out-of-bounds. Ignore read request */
+	if (blba >= pblk->rl.nr_secs || nr_secs > PBLK_MAX_REQ_ADDRS) {
+		WARN(1, "pblk: read lba out of bounds (lba:%llu, nr:%d)\n",
+					(unsigned long long)blba, nr_secs);
 		return NVM_IO_ERR;
+	}
 
 	bitmap_zero(&read_bitmap, nr_secs);
 
@@ -340,9 +331,9 @@ int pblk_submit_read(struct pblk *pblk, struct bio *bio)
 		rqd->ppa_list = rqd->meta_list + pblk_dma_meta_size;
 		rqd->dma_ppa_list = rqd->dma_meta_list + pblk_dma_meta_size;
 
-		pblk_read_ppalist_rq(pblk, rqd, &read_bitmap);
+		pblk_read_ppalist_rq(pblk, rqd, blba, &read_bitmap);
 	} else {
-		pblk_read_rq(pblk, rqd, &read_bitmap);
+		pblk_read_rq(pblk, rqd, blba, &read_bitmap);
 	}
 
 	bio_get(bio);
-- 
2.9.3
