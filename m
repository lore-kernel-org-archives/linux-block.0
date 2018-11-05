Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mail-io1-f67.google.com ([209.85.166.67]:41856 "EHLO
        mail-io1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729004AbeKEVB3 (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Mon, 5 Nov 2018 16:01:29 -0500
Received: by mail-io1-f67.google.com with SMTP id a5-v6so6229518ioq.8
        for <linux-block@vger.kernel.org>; Mon, 05 Nov 2018 03:42:11 -0800 (PST)
From: Hans Holmberg <hans@owltronix.com>
To: Matias Bjorling <mb@lightnvm.io>
Cc: Javier Gonzales <javier@cnexlabs.com>, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Hans Holmberg <hans.ml.holmberg@owltronix.com>,
        Hans Holmberg <hans.holmberg@cnexlabs.com>
Subject: [PATCH 5/7] lightnvm: pblk: remove unused macro
Date: Mon,  5 Nov 2018 12:41:11 +0100
Message-Id: <20181105114113.30932-6-hans.ml.holmberg@cnexlabs.com>
In-Reply-To: <20181105114113.30932-1-hans.ml.holmberg@cnexlabs.com>
References: <20181105114113.30932-1-hans.ml.holmberg@cnexlabs.com>
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

From: Hans Holmberg <hans.ml.holmberg@owltronix.com>

From: Hans Holmberg <hans.holmberg@cnexlabs.com>

ADDR_POOL_SIZE is not used anymore, so remove the define.

Signed-off-by: Hans Holmberg <hans.holmberg@cnexlabs.com>
---
 drivers/lightnvm/pblk-init.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/drivers/lightnvm/pblk-init.c b/drivers/lightnvm/pblk-init.c
index 8b89bb26b0f1..33c1e83327c3 100644
--- a/drivers/lightnvm/pblk-init.c
+++ b/drivers/lightnvm/pblk-init.c
@@ -207,9 +207,6 @@ static int pblk_rwb_init(struct pblk *pblk)
 	return pblk_rb_init(&pblk->rwb, buffer_size, threshold, geo->csecs);
 }
 
-/* Minimum pages needed within a lun */
-#define ADDR_POOL_SIZE 64
-
 static int pblk_set_addrf_12(struct pblk *pblk, struct nvm_geo *geo,
 			     struct nvm_addrf_12 *dst)
 {
-- 
2.17.1
