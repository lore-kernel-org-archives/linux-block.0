Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mail-it1-f194.google.com ([209.85.166.194]:38430 "EHLO
        mail-it1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729004AbeKEVBb (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Mon, 5 Nov 2018 16:01:31 -0500
Received: by mail-it1-f194.google.com with SMTP id k141-v6so10272577itk.3
        for <linux-block@vger.kernel.org>; Mon, 05 Nov 2018 03:42:12 -0800 (PST)
From: Hans Holmberg <hans@owltronix.com>
To: Matias Bjorling <mb@lightnvm.io>
Cc: Javier Gonzales <javier@cnexlabs.com>, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Hans Holmberg <hans.ml.holmberg@owltronix.com>,
        Hans Holmberg <hans.holmberg@cnexlabs.com>
Subject: [PATCH 6/7] lightnvm: pblk: fix pblk_lines_init error handling path
Date: Mon,  5 Nov 2018 12:41:12 +0100
Message-Id: <20181105114113.30932-7-hans.ml.holmberg@cnexlabs.com>
In-Reply-To: <20181105114113.30932-1-hans.ml.holmberg@cnexlabs.com>
References: <20181105114113.30932-1-hans.ml.holmberg@cnexlabs.com>
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

From: Hans Holmberg <hans.ml.holmberg@owltronix.com>

From: Hans Holmberg <hans.holmberg@cnexlabs.com>

The chunk metadata is allocated with vmalloc, so we need to use
vfree to free it.

Fixes: 090ee26fd512 ("lightnvm: use internal allocation for chunk log page")

Signed-off-by: Hans Holmberg <hans.holmberg@cnexlabs.com>
---
 drivers/lightnvm/pblk-init.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/lightnvm/pblk-init.c b/drivers/lightnvm/pblk-init.c
index 33c1e83327c3..ae9686b5d521 100644
--- a/drivers/lightnvm/pblk-init.c
+++ b/drivers/lightnvm/pblk-init.c
@@ -1053,7 +1053,7 @@ static int pblk_lines_init(struct pblk *pblk)
 		pblk_line_meta_free(l_mg, &pblk->lines[i]);
 	kfree(pblk->lines);
 fail_free_chunk_meta:
-	kfree(chunk_meta);
+	vfree(chunk_meta);
 fail_free_luns:
 	kfree(pblk->luns);
 fail_free_meta:
-- 
2.17.1
