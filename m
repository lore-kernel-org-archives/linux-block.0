Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mail-pg1-f195.google.com ([209.85.215.195]:41987 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726418AbeJIS3v (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Tue, 9 Oct 2018 14:29:51 -0400
Received: by mail-pg1-f195.google.com with SMTP id i4-v6so645405pgq.9
        for <linux-block@vger.kernel.org>; Tue, 09 Oct 2018 04:13:24 -0700 (PDT)
From: =?UTF-8?q?Matias=20Bj=C3=B8rling?= <mb@lightnvm.io>
To: axboe@fb.com
Cc: linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        =?UTF-8?q?Matias=20Bj=C3=B8rling?= <mb@lightnvm.io>
Subject: [GIT PULL 03/45] lightnvm: pblk: fix rqd.error return value in pblk_blk_erase_sync
Date: Tue,  9 Oct 2018 13:11:33 +0200
Message-Id: <20181009111215.7653-4-mb@lightnvm.io>
In-Reply-To: <20181009111215.7653-1-mb@lightnvm.io>
References: <20181009111215.7653-1-mb@lightnvm.io>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

rqd.error is masked by the return value of pblk_submit_io_sync.
The rqd structure is then passed on to the end_io function, which
assumes that any error should lead to a chunk being marked
offline/bad. Since the pblk_submit_io_sync can fail before the
command is issued to the device, the error value maybe not correspond
to a media failure, leading to chunks being immaturely retired.

Also, the pblk_blk_erase_sync function prints an error message in case
the erase fails. Since the caller prints an error message by itself,
remove the error message in this function.

Signed-off-by: Matias Bjørling <mb@lightnvm.io>
Reviewed-by: Javier González <javier@cnexlabs.com>
Reviewed-by: Hans Holmberg <hans.holmberg@cnexlabs.com>
---
 drivers/lightnvm/pblk-core.c | 19 ++-----------------
 1 file changed, 2 insertions(+), 17 deletions(-)

diff --git a/drivers/lightnvm/pblk-core.c b/drivers/lightnvm/pblk-core.c
index 72acf2f6dbd6..72de7456845b 100644
--- a/drivers/lightnvm/pblk-core.c
+++ b/drivers/lightnvm/pblk-core.c
@@ -886,10 +886,8 @@ static void pblk_setup_e_rq(struct pblk *pblk, struct nvm_rq *rqd,
 
 static int pblk_blk_erase_sync(struct pblk *pblk, struct ppa_addr ppa)
 {
-	struct nvm_rq rqd;
-	int ret = 0;
-
-	memset(&rqd, 0, sizeof(struct nvm_rq));
+	struct nvm_rq rqd = {NULL};
+	int ret;
 
 	pblk_setup_e_rq(pblk, &rqd, ppa);
 
@@ -897,19 +895,6 @@ static int pblk_blk_erase_sync(struct pblk *pblk, struct ppa_addr ppa)
 	 * with writes. Thus, there is no need to take the LUN semaphore.
 	 */
 	ret = pblk_submit_io_sync(pblk, &rqd);
-	if (ret) {
-		struct nvm_tgt_dev *dev = pblk->dev;
-		struct nvm_geo *geo = &dev->geo;
-
-		pblk_err(pblk, "could not sync erase line:%d,blk:%d\n",
-					pblk_ppa_to_line(ppa),
-					pblk_ppa_to_pos(geo, ppa));
-
-		rqd.error = ret;
-		goto out;
-	}
-
-out:
 	rqd.private = pblk;
 	__pblk_end_io_erase(pblk, &rqd);
 
-- 
2.17.1
