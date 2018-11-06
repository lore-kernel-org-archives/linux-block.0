Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mail-it1-f194.google.com ([209.85.166.194]:39942 "EHLO
        mail-it1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388419AbeKFW7E (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Tue, 6 Nov 2018 17:59:04 -0500
Received: by mail-it1-f194.google.com with SMTP id e11so14300036itl.5
        for <linux-block@vger.kernel.org>; Tue, 06 Nov 2018 05:33:49 -0800 (PST)
From: Hans Holmberg <hans.ml.holmberg@owltronix.com>
To: Matias Bjorling <mb@lightnvm.io>
Cc: Javier Gonzales <javier@cnexlabs.com>,
        Sebastien Boisvert <sboisvert@gydle.com>,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        Hans Holmberg <hans.holmberg@cnexlabs.com>
Subject: [PATCH v3 6/7] lightnvm: pblk: fix pblk_lines_init error handling path
Date: Tue,  6 Nov 2018 14:33:29 +0100
Message-Id: <20181106133330.26570-7-hans.ml.holmberg@owltronix.com>
In-Reply-To: <20181106133330.26570-1-hans.ml.holmberg@owltronix.com>
References: <20181106133330.26570-1-hans.ml.holmberg@owltronix.com>
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

From: Hans Holmberg <hans.holmberg@cnexlabs.com>

The chunk metadata is allocated with vmalloc, so we need to use
vfree to free it.

Fixes: 090ee26fd512 ("lightnvm: use internal allocation for chunk log page")

Signed-off-by: Hans Holmberg <hans.holmberg@cnexlabs.com>
---
 drivers/lightnvm/pblk-init.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/lightnvm/pblk-init.c b/drivers/lightnvm/pblk-init.c
index 3219f335fce9..0e37104de596 100644
--- a/drivers/lightnvm/pblk-init.c
+++ b/drivers/lightnvm/pblk-init.c
@@ -1060,7 +1060,7 @@ static int pblk_lines_init(struct pblk *pblk)
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
