Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mail-lj1-f193.google.com ([209.85.208.193]:46221 "EHLO
        mail-lj1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726481AbeHTQPf (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 20 Aug 2018 12:15:35 -0400
Received: by mail-lj1-f193.google.com with SMTP id 203-v6so11477564ljj.13
        for <linux-block@vger.kernel.org>; Mon, 20 Aug 2018 06:00:01 -0700 (PDT)
From: =?UTF-8?q?Matias=20Bj=C3=B8rling?= <mb@lightnvm.io>
To: igor.j.konopko@intel.com, marcin.dziegielewski@intel.com,
        javier@cnexlabs.com, hans.holmberg@cnexlabs.com, hlitz@ucsc.edu,
        youngtack.jin@circuitblvd.com
Cc: linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        =?UTF-8?q?Matias=20Bj=C3=B8rling?= <mb@lightnvm.io>
Subject: [PATCH] lightnvm: pblk: remove size and out of bounds read check
Date: Mon, 20 Aug 2018 14:59:53 +0200
Message-Id: <20180820125953.15364-1-mb@lightnvm.io>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

The I/O size and capacity check are already done by the block layer.

Signed-off-by: Matias Bjørling <mb@lightnvm.io>
---
 drivers/lightnvm/pblk-read.c | 7 -------
 1 file changed, 7 deletions(-)

diff --git a/drivers/lightnvm/pblk-read.c b/drivers/lightnvm/pblk-read.c
index f275c7e5abe4..d0fbd50ecc90 100644
--- a/drivers/lightnvm/pblk-read.c
+++ b/drivers/lightnvm/pblk-read.c
@@ -452,13 +452,6 @@ int pblk_submit_read(struct pblk *pblk, struct bio *bio)
 	DECLARE_BITMAP(read_bitmap, NVM_MAX_VLBA);
 	int ret = NVM_IO_ERR;
 
-	/* logic error: lba out-of-bounds. Ignore read request */
-	if (blba >= pblk->rl.nr_secs || nr_secs > NVM_MAX_VLBA) {
-		WARN(1, "pblk: read lba out of bounds (lba:%llu, nr:%d)\n",
-					(unsigned long long)blba, nr_secs);
-		return NVM_IO_ERR;
-	}
-
 	generic_start_io_acct(q, READ, bio_sectors(bio), &pblk->disk->part0);
 
 	bitmap_zero(read_bitmap, nr_secs);
-- 
2.11.0
