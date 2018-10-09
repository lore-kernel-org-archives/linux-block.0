Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mail-pf1-f194.google.com ([209.85.210.194]:38984 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727051AbeJISaK (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Tue, 9 Oct 2018 14:30:10 -0400
Received: by mail-pf1-f194.google.com with SMTP id c25-v6so674361pfe.6
        for <linux-block@vger.kernel.org>; Tue, 09 Oct 2018 04:13:44 -0700 (PDT)
From: =?UTF-8?q?Matias=20Bj=C3=B8rling?= <mb@lightnvm.io>
To: axboe@fb.com
Cc: linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        =?UTF-8?q?Matias=20Bj=C3=B8rling?= <mb@lightnvm.io>
Subject: [GIT PULL 09/45] lightnvm: pblk: remove size and out of bounds read check
Date: Tue,  9 Oct 2018 13:11:39 +0200
Message-Id: <20181009111215.7653-10-mb@lightnvm.io>
In-Reply-To: <20181009111215.7653-1-mb@lightnvm.io>
References: <20181009111215.7653-1-mb@lightnvm.io>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

The I/O size and capacity checks are already done by the block layer.

Signed-off-by: Matias Bjørling <mb@lightnvm.io>
Reviewed-by: Javier González <javier@cnexlabs.com>
---
 drivers/lightnvm/pblk-read.c | 7 -------
 1 file changed, 7 deletions(-)

diff --git a/drivers/lightnvm/pblk-read.c b/drivers/lightnvm/pblk-read.c
index 9c61c19be5dc..ba3dcb6be4c3 100644
--- a/drivers/lightnvm/pblk-read.c
+++ b/drivers/lightnvm/pblk-read.c
@@ -449,13 +449,6 @@ int pblk_submit_read(struct pblk *pblk, struct bio *bio)
 	DECLARE_BITMAP(read_bitmap, NVM_MAX_VLBA);
 	int ret = NVM_IO_ERR;
 
-	/* logic error: lba out-of-bounds. Ignore read request */
-	if (blba >= pblk->rl.nr_secs || nr_secs > NVM_MAX_VLBA) {
-		WARN(1, "pblk: read lba out of bounds (lba:%llu, nr:%d)\n",
-					(unsigned long long)blba, nr_secs);
-		return NVM_IO_ERR;
-	}
-
 	generic_start_io_acct(q, REQ_OP_READ, bio_sectors(bio),
 			      &pblk->disk->part0);
 
-- 
2.17.1
