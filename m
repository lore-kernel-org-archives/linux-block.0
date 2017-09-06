Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mail-wm0-f44.google.com ([74.125.82.44]:36228 "EHLO
        mail-wm0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753347AbdIFKwt (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Wed, 6 Sep 2017 06:52:49 -0400
Received: by mail-wm0-f44.google.com with SMTP id i145so28015665wmf.1
        for <linux-block@vger.kernel.org>; Wed, 06 Sep 2017 03:52:49 -0700 (PDT)
From: "=?UTF-8?q?Javier=20Gonz=C3=A1lez?=" <jg@lightnvm.io>
To: mb@lightnvm.io, axboe@fb.com
Cc: linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        =?UTF-8?q?Javier=20Gonz=C3=A1lez?= <javier@cnexlabs.com>,
        =?UTF-8?q?Matias=20Bj=C3=B8rling?= <matias@cnexlabs.com>
Subject: [PATCH 13/18] lightnvm: pblk: fix write I/O sync stat
Date: Wed,  6 Sep 2017 12:51:06 +0200
Message-Id: <1504695071-25928-14-git-send-email-javier@cnexlabs.com>
In-Reply-To: <1504695071-25928-1-git-send-email-javier@cnexlabs.com>
References: <1504695071-25928-1-git-send-email-javier@cnexlabs.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

Fix stat counter to collect the right number of I/Os being synced on the
completion path.

Signed-off-by: Javier González <javier@cnexlabs.com>
Signed-off-by: Matias Bjørling <matias@cnexlabs.com>
---
 drivers/lightnvm/pblk-write.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/lightnvm/pblk-write.c b/drivers/lightnvm/pblk-write.c
index 33dd90251a60..fb4d9c3983db 100644
--- a/drivers/lightnvm/pblk-write.c
+++ b/drivers/lightnvm/pblk-write.c
@@ -41,7 +41,7 @@ static unsigned long pblk_end_w_bio(struct pblk *pblk, struct nvm_rq *rqd,
 							c_ctx->nr_padded);
 
 #ifdef CONFIG_NVM_DEBUG
-	atomic_long_add(c_ctx->nr_valid, &pblk->sync_writes);
+	atomic_long_add(rqd->nr_ppas, &pblk->sync_writes);
 #endif
 
 	ret = pblk_rb_sync_advance(&pblk->rwb, c_ctx->nr_valid);
-- 
2.7.4
