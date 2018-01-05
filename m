Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mail-wm0-f66.google.com ([74.125.82.66]:40280 "EHLO
        mail-wm0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752068AbeAENRD (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Fri, 5 Jan 2018 08:17:03 -0500
Received: by mail-wm0-f66.google.com with SMTP id f206so2406506wmf.5
        for <linux-block@vger.kernel.org>; Fri, 05 Jan 2018 05:17:02 -0800 (PST)
From: =?UTF-8?q?Matias=20Bj=C3=B8rling?= <m@bjorling.me>
To: axboe@fb.com
Cc: linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        =?UTF-8?q?Javier=20Gonz=C3=A1lez?= <javier@cnexlabs.com>,
        =?UTF-8?q?Matias=20Bj=C3=B8rling?= <m@bjorling.me>
Subject: [GIT PULL 22/25] lightnvm: pblk: free write buffer on init failure
Date: Fri,  5 Jan 2018 14:16:18 +0100
Message-Id: <20180105131621.20808-23-m@bjorling.me>
In-Reply-To: <20180105131621.20808-1-m@bjorling.me>
References: <20180105131621.20808-1-m@bjorling.me>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

From: Javier González <javier@cnexlabs.com>

Refactor the way we free the write buffer to ensure that all entries get
freed in case of an error on the init sequence.

Signed-off-by: Javier González <javier@cnexlabs.com>
Signed-off-by: Matias Bjørling <m@bjorling.me>
---
 drivers/lightnvm/pblk-init.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/lightnvm/pblk-init.c b/drivers/lightnvm/pblk-init.c
index 7e11926..8c40bc3 100644
--- a/drivers/lightnvm/pblk-init.c
+++ b/drivers/lightnvm/pblk-init.c
@@ -355,6 +355,8 @@ static void pblk_core_free(struct pblk *pblk)
 	mempool_destroy(pblk->e_rq_pool);
 	mempool_destroy(pblk->w_rq_pool);
 
+	pblk_rwb_free(pblk);
+
 	pblk_free_global_caches(pblk);
 }
 
@@ -931,7 +933,6 @@ static void pblk_tear_down(struct pblk *pblk)
 	pblk_pipeline_stop(pblk);
 	pblk_writer_stop(pblk);
 	pblk_rb_sync_l2p(&pblk->rwb);
-	pblk_rwb_free(pblk);
 	pblk_rl_free(&pblk->rl);
 
 	pr_debug("pblk: consistent tear down\n");
-- 
2.9.3
