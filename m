Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mail-it1-f194.google.com ([209.85.166.194]:37517 "EHLO
        mail-it1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388110AbeKFW7D (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Tue, 6 Nov 2018 17:59:03 -0500
Received: by mail-it1-f194.google.com with SMTP id j79-v6so5640218itb.2
        for <linux-block@vger.kernel.org>; Tue, 06 Nov 2018 05:33:47 -0800 (PST)
From: Hans Holmberg <hans.ml.holmberg@owltronix.com>
To: Matias Bjorling <mb@lightnvm.io>
Cc: Javier Gonzales <javier@cnexlabs.com>,
        Sebastien Boisvert <sboisvert@gydle.com>,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        Hans Holmberg <hans.holmberg@cnexlabs.com>
Subject: [PATCH v3 5/7] lightnvm: pblk: remove unused macro
Date: Tue,  6 Nov 2018 14:33:28 +0100
Message-Id: <20181106133330.26570-6-hans.ml.holmberg@owltronix.com>
In-Reply-To: <20181106133330.26570-1-hans.ml.holmberg@owltronix.com>
References: <20181106133330.26570-1-hans.ml.holmberg@owltronix.com>
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

From: Hans Holmberg <hans.holmberg@cnexlabs.com>

ADDR_POOL_SIZE is not used anymore, so remove the define.

Signed-off-by: Hans Holmberg <hans.holmberg@cnexlabs.com>
---
 drivers/lightnvm/pblk-init.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/drivers/lightnvm/pblk-init.c b/drivers/lightnvm/pblk-init.c
index f083130d9920..3219f335fce9 100644
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
