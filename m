Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mail-wm0-f43.google.com ([74.125.82.43]:45742 "EHLO
        mail-wm0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751278AbdJEIgz (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Thu, 5 Oct 2017 04:36:55 -0400
Received: by mail-wm0-f43.google.com with SMTP id q124so640648wmb.0
        for <linux-block@vger.kernel.org>; Thu, 05 Oct 2017 01:36:54 -0700 (PDT)
From: Hans Holmberg <hans.ml.holmberg@owltronix.com>
To: Matias Bjorling <mb@lightnvm.io>
Cc: linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        Javier Gonzales <jg@lightnvm.io>,
        Andrey Ryabinin <aryabinin@virtuozzo.com>,
        Hans Holmberg <hans.holmberg@cnexlabs.com>
Subject: [PATCH] lightnvm: pblk: remove spinlock when freeing line metadata
Date: Thu,  5 Oct 2017 10:35:46 +0200
Message-Id: <1507192546-12156-1-git-send-email-hans.ml.holmberg@owltronix.com>
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

From: Hans Holmberg <hans.holmberg@cnexlabs.com>

Lockdep complains about being in atomic context while freeing line
metadata - and rightly so as we take a spinlock and end up calling
vfree that might sleep(in pblk_mfree).

There is no need for holding the line manager free_lock while
freeing line metadata, so remove the lock.

Signed-off-by: Hans Holmberg <hans.holmberg@cnexlabs.com>
---
This patch is for:
https://github.com/OpenChannelSSD/linux branch for-4.15/pblk

 drivers/lightnvm/pblk-init.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/lightnvm/pblk-init.c b/drivers/lightnvm/pblk-init.c
index c452478..a645117 100644
--- a/drivers/lightnvm/pblk-init.c
+++ b/drivers/lightnvm/pblk-init.c
@@ -393,13 +393,11 @@ static void pblk_line_meta_free(struct pblk *pblk)
 	kfree(l_mg->bb_aux);
 	kfree(l_mg->vsc_list);
 
-	spin_lock(&l_mg->free_lock);
 	for (i = 0; i < PBLK_DATA_LINES; i++) {
 		kfree(l_mg->sline_meta[i]);
 		pblk_mfree(l_mg->eline_meta[i]->buf, l_mg->emeta_alloc_type);
 		kfree(l_mg->eline_meta[i]);
 	}
-	spin_unlock(&l_mg->free_lock);
 
 	kfree(pblk->lines);
 }
-- 
2.7.4
