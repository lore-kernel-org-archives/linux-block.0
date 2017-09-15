Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mail-wm0-f53.google.com ([74.125.82.53]:46948 "EHLO
        mail-wm0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751453AbdIOMZr (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 15 Sep 2017 08:25:47 -0400
Received: by mail-wm0-f53.google.com with SMTP id i189so7887876wmf.1
        for <linux-block@vger.kernel.org>; Fri, 15 Sep 2017 05:25:46 -0700 (PDT)
From: "=?UTF-8?q?Javier=20Gonz=C3=A1lez?=" <jg@lightnvm.io>
To: linux-block@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
        =?UTF-8?q?Javier=20Gonz=C3=A1lez?= <javier@cnexlabs.com>
Subject: [PATCH 03/11] lightnvm: pblk: refactor read lba sanity check
Date: Fri, 15 Sep 2017 14:25:31 +0200
Message-Id: <1505478339-13089-4-git-send-email-javier@cnexlabs.com>
In-Reply-To: <1505478339-13089-1-git-send-email-javier@cnexlabs.com>
References: <1505478339-13089-1-git-send-email-javier@cnexlabs.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

Refactor lba sanity check on read path to avoid code duplication.

Signed-off-by: Javier González <javier@cnexlabs.com>
---
 drivers/lightnvm/pblk-read.c | 29 ++++++++++-------------------
 1 file changed, 10 insertions(+), 19 deletions(-)

diff --git a/drivers/lightnvm/pblk-read.c b/drivers/lightnvm/pblk-read.c
index d2b6e2a7d7d5..eaaf9d55ba97 100644
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
2.7.4
