Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mail-wm0-f67.google.com ([74.125.82.67]:49815 "EHLO
        mail-wm0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932461AbdJMMr7 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 13 Oct 2017 08:47:59 -0400
Received: by mail-wm0-f67.google.com with SMTP id b189so21118018wmd.4
        for <linux-block@vger.kernel.org>; Fri, 13 Oct 2017 05:47:58 -0700 (PDT)
From: =?UTF-8?q?Matias=20Bj=C3=B8rling?= <m@bjorling.me>
To: axboe@fb.com
Cc: linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        Hans Holmberg <hans.holmberg@cnexlabs.com>,
        =?UTF-8?q?Matias=20Bj=C3=B8rling?= <m@bjorling.me>
Subject: [GIT PULL 54/58] lightnvm: pblk: remove spinlock when freeing line metadata
Date: Fri, 13 Oct 2017 14:46:43 +0200
Message-Id: <20171013124647.32668-55-m@bjorling.me>
In-Reply-To: <20171013124647.32668-1-m@bjorling.me>
References: <20171013124647.32668-1-m@bjorling.me>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

From: Hans Holmberg <hans.holmberg@cnexlabs.com>

Lockdep complains about being in atomic context while freeing line
metadata - and rightly so as we take a spinlock and end up calling
vfree that might sleep(in pblk_mfree).

There is no need for holding the line manager free_lock while
freeing line metadata as the pipeline as stopped, so remove the lock.

Fixes: 588726d3ec68 ("lightnvm: pblk: fail gracefully on irrec. error")
Signed-off-by: Hans Holmberg <hans.holmberg@cnexlabs.com>
Signed-off-by: Matias Bjørling <m@bjorling.me>
---
 drivers/lightnvm/pblk-init.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/lightnvm/pblk-init.c b/drivers/lightnvm/pblk-init.c
index 52c85f4..f62112b 100644
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
2.9.3
