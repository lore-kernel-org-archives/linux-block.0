Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mail-wm0-f44.google.com ([74.125.82.44]:49561 "EHLO
        mail-wm0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751719AbdJCNvR (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Tue, 3 Oct 2017 09:51:17 -0400
Received: by mail-wm0-f44.google.com with SMTP id b189so12981769wmd.4
        for <linux-block@vger.kernel.org>; Tue, 03 Oct 2017 06:51:16 -0700 (PDT)
From: Hans Holmberg <hans.ml.holmberg@owltronix.com>
To: Matias Bjorling <mb@lightnvm.io>
Cc: linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        Javier Gonzales <jg@lightnvm.io>,
        Andrey Ryabinin <aryabinin@virtuozzo.com>,
        Christoph Hellwig <hch@lst.de>,
        Hans Holmberg <hans.holmberg@cnexlabs.com>
Subject: [PATCH] lightnvm: pblk: use vfree_atomic when freeing line metadata
Date: Tue,  3 Oct 2017 15:48:44 +0200
Message-Id: <1507038524-24587-1-git-send-email-hans.ml.holmberg@owltronix.com>
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

From: Hans Holmberg <hans.holmberg@cnexlabs.com>

The commit bf22e37a6413 ("mm: add vfree_atomic()") made vfree unsafe to
call in atomic context (unless the call came from an interrupt) and
introduced vfree_atomic that is safe to call in atomic context.

So, since we're holding locks when freeing line metadata, we need to
use the atomic version of vfree.

Fix this by introducing an atomic variant of pblk_mfree and
switching to that in pblk_line_meta_free.

Signed-off-by: Hans Holmberg <hans.holmberg@cnexlabs.com>
---

The patch is for:
https://github.com/OpenChannelSSD/linux branch for-4.15/pblk

 drivers/lightnvm/pblk-init.c | 3 ++-
 drivers/lightnvm/pblk.h      | 8 ++++++++
 2 files changed, 10 insertions(+), 1 deletion(-)

diff --git a/drivers/lightnvm/pblk-init.c b/drivers/lightnvm/pblk-init.c
index c452478..3a191a6 100644
--- a/drivers/lightnvm/pblk-init.c
+++ b/drivers/lightnvm/pblk-init.c
@@ -396,7 +396,8 @@ static void pblk_line_meta_free(struct pblk *pblk)
 	spin_lock(&l_mg->free_lock);
 	for (i = 0; i < PBLK_DATA_LINES; i++) {
 		kfree(l_mg->sline_meta[i]);
-		pblk_mfree(l_mg->eline_meta[i]->buf, l_mg->emeta_alloc_type);
+		pblk_mfree_atomic(l_mg->eline_meta[i]->buf,
+				  l_mg->emeta_alloc_type);
 		kfree(l_mg->eline_meta[i]);
 	}
 	spin_unlock(&l_mg->free_lock);
diff --git a/drivers/lightnvm/pblk.h b/drivers/lightnvm/pblk.h
index 03965da..93f98e3 100644
--- a/drivers/lightnvm/pblk.h
+++ b/drivers/lightnvm/pblk.h
@@ -881,6 +881,14 @@ static inline void pblk_mfree(void *ptr, int type)
 		vfree(ptr);
 }
 
+static inline void pblk_mfree_atomic(void *ptr, int type)
+{
+	if (type == PBLK_KMALLOC_META)
+		kfree(ptr);
+	else
+		vfree_atomic(ptr);
+}
+
 static inline struct nvm_rq *nvm_rq_from_c_ctx(void *c_ctx)
 {
 	return c_ctx - sizeof(struct nvm_rq);
-- 
2.7.4
