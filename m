Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mail-wm0-f67.google.com ([74.125.82.67]:51366 "EHLO
        mail-wm0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753189AbeD3JKX (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 30 Apr 2018 05:10:23 -0400
Received: by mail-wm0-f67.google.com with SMTP id j4so11905209wme.1
        for <linux-block@vger.kernel.org>; Mon, 30 Apr 2018 02:10:23 -0700 (PDT)
From: "=?UTF-8?q?Javier=20Gonz=C3=A1lez?=" <javier@javigon.com>
To: mb@lightnvm.io
Cc: linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        =?UTF-8?q?Javier=20Gonz=C3=A1lez?= <javier@cnexlabs.com>
Subject: [PATCH 07/11] lightnvm: pblk: remove unnecessary indirection
Date: Mon, 30 Apr 2018 11:10:05 +0200
Message-Id: <1525079409-6588-8-git-send-email-javier@cnexlabs.com>
In-Reply-To: <1525079409-6588-1-git-send-email-javier@cnexlabs.com>
References: <1525079409-6588-1-git-send-email-javier@cnexlabs.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

Call nvm_submit_io directly and remove an unnecessary indirection on the
read path.

Signed-off-by: Javier González <javier@cnexlabs.com>
---
 drivers/lightnvm/pblk-read.c | 14 ++------------
 1 file changed, 2 insertions(+), 12 deletions(-)

diff --git a/drivers/lightnvm/pblk-read.c b/drivers/lightnvm/pblk-read.c
index b201fc486adb..a2e678de428f 100644
--- a/drivers/lightnvm/pblk-read.c
+++ b/drivers/lightnvm/pblk-read.c
@@ -102,16 +102,6 @@ static void pblk_read_ppalist_rq(struct pblk *pblk, struct nvm_rq *rqd,
 #endif
 }
 
-static int pblk_submit_read_io(struct pblk *pblk, struct nvm_rq *rqd)
-{
-	int err;
-
-	err = pblk_submit_io(pblk, rqd);
-	if (err)
-		return NVM_IO_ERR;
-
-	return NVM_IO_OK;
-}
 
 static void pblk_read_check_seq(struct pblk *pblk, struct nvm_rq *rqd,
 				sector_t blba)
@@ -485,9 +475,9 @@ int pblk_submit_read(struct pblk *pblk, struct bio *bio)
 		rqd->bio = int_bio;
 		r_ctx->private = bio;
 
-		ret = pblk_submit_read_io(pblk, rqd);
-		if (ret) {
+		if (pblk_submit_io(pblk, rqd)) {
 			pr_err("pblk: read IO submission failed\n");
+			ret = NVM_IO_ERR;
 			if (int_bio)
 				bio_put(int_bio);
 			goto fail_end_io;
-- 
2.7.4
