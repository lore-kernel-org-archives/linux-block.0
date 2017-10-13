Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mail-wm0-f68.google.com ([74.125.82.68]:48930 "EHLO
        mail-wm0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1758161AbdJMMrW (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 13 Oct 2017 08:47:22 -0400
Received: by mail-wm0-f68.google.com with SMTP id i124so21102974wmf.3
        for <linux-block@vger.kernel.org>; Fri, 13 Oct 2017 05:47:21 -0700 (PDT)
From: =?UTF-8?q?Matias=20Bj=C3=B8rling?= <m@bjorling.me>
To: axboe@fb.com
Cc: linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        =?UTF-8?q?Javier=20Gonz=C3=A1lez?= <javier@cnexlabs.com>,
        =?UTF-8?q?Matias=20Bj=C3=B8rling?= <m@bjorling.me>
Subject: [GIT PULL 15/58] lightnvm: pblk: fix write I/O sync stat
Date: Fri, 13 Oct 2017 14:46:04 +0200
Message-Id: <20171013124647.32668-16-m@bjorling.me>
In-Reply-To: <20171013124647.32668-1-m@bjorling.me>
References: <20171013124647.32668-1-m@bjorling.me>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

From: Javier González <javier@cnexlabs.com>

Fix stat counter to collect the right number of I/Os being synced on the
completion path.

Fixes: 0880a9aa2d91f ("lightnvm: pblk: delete redundant buffer pointer")
Signed-off-by: Javier González <javier@cnexlabs.com>
Signed-off-by: Matias Bjørling <m@bjorling.me>
---
 drivers/lightnvm/pblk-write.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/lightnvm/pblk-write.c b/drivers/lightnvm/pblk-write.c
index d89ac57..d82ca8b 100644
--- a/drivers/lightnvm/pblk-write.c
+++ b/drivers/lightnvm/pblk-write.c
@@ -38,7 +38,7 @@ static unsigned long pblk_end_w_bio(struct pblk *pblk, struct nvm_rq *rqd,
 							c_ctx->nr_padded);
 
 #ifdef CONFIG_NVM_DEBUG
-	atomic_long_add(c_ctx->nr_valid, &pblk->sync_writes);
+	atomic_long_add(rqd->nr_ppas, &pblk->sync_writes);
 #endif
 
 	ret = pblk_rb_sync_advance(&pblk->rwb, c_ctx->nr_valid);
-- 
2.9.3
