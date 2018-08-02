Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mail-lf1-f67.google.com ([209.85.167.67]:40015 "EHLO
        mail-lf1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731233AbeHBWvw (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Thu, 2 Aug 2018 18:51:52 -0400
Received: by mail-lf1-f67.google.com with SMTP id y200-v6so2534164lfd.7
        for <linux-block@vger.kernel.org>; Thu, 02 Aug 2018 13:59:00 -0700 (PDT)
From: =?UTF-8?q?Matias=20Bj=C3=B8rling?= <mb@lightnvm.io>
To: igor.j.konopko@intel.com, marcin.dziegielewski@intel.com,
        javier@cnexlabs.com, hans.holmberg@cnexlabs.com, hlitz@ucsc.edu,
        youngtack.jin@circuitblvd.com
Cc: linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        =?UTF-8?q?Matias=20Bj=C3=B8rling?= <mb@lightnvm.io>
Subject: [PATCH] lightnvm: pblk: remove unnecessary drive version check
Date: Thu,  2 Aug 2018 22:58:41 +0200
Message-Id: <20180802205841.22039-1-mb@lightnvm.io>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

The nvme driver checks for 1.2 and 2.0 compatibility. If an unsupported
version is reported, the device will not be initialized.

Signed-off-by: Matias Bjørling <mb@lightnvm.io>
---
 drivers/lightnvm/pblk-init.c | 8 --------
 1 file changed, 8 deletions(-)

diff --git a/drivers/lightnvm/pblk-init.c b/drivers/lightnvm/pblk-init.c
index 537e98f2b24a..e9e2fedff387 100644
--- a/drivers/lightnvm/pblk-init.c
+++ b/drivers/lightnvm/pblk-init.c
@@ -1202,14 +1202,6 @@ static void *pblk_init(struct nvm_tgt_dev *dev, struct gendisk *tdisk,
 	pblk->state = PBLK_STATE_RUNNING;
 	pblk->gc.gc_enabled = 0;
 
-	if (!(geo->version == NVM_OCSSD_SPEC_12 ||
-					geo->version == NVM_OCSSD_SPEC_20)) {
-		pblk_err(pblk, "OCSSD version not supported (%u)\n",
-							geo->version);
-		kfree(pblk);
-		return ERR_PTR(-EINVAL);
-	}
-
 	if (geo->version == NVM_OCSSD_SPEC_12 && geo->dom & NVM_RSP_L2P) {
 		pblk_err(pblk, "host-side L2P table not supported. (%x)\n",
 							geo->dom);
-- 
2.11.0
