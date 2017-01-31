Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mail-bn3nam01on0058.outbound.protection.outlook.com ([104.47.33.58]:53760
        "EHLO NAM01-BN3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1752043AbdAaMSk (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Tue, 31 Jan 2017 07:18:40 -0500
From: =?UTF-8?q?Matias=20Bj=C3=B8rling?= <matias@cnexlabs.com>
To: <axboe@fb.com>
CC: <linux-block@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        =?UTF-8?q?Javier=20Gonz=C3=A1lez?= <jg@lightnvm.io>,
        =?UTF-8?q?Javier=20Gonz=C3=A1lez?= <javier@cnexlabs.com>,
        =?UTF-8?q?Matias=20Bj=C3=B8rling?= <matias@cnexlabs.com>
Subject: [PATCH 11/12] lightnvm: free properly on target creation error
Date: Tue, 31 Jan 2017 13:17:19 +0100
Message-ID: <20170131121720.10971-12-matias@cnexlabs.com>
In-Reply-To: <20170131121720.10971-1-matias@cnexlabs.com>
References: <20170131121720.10971-1-matias@cnexlabs.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

From: Javier González <jg@lightnvm.io>

Fix a memory leak when target creation fails. More specifically, free
the entire device structure given to the target (tgt_dev).

Signed-off-by: Javier González <javier@cnexlabs.com>
Signed-off-by: Matias Bjørling <matias@cnexlabs.com>
---
 drivers/lightnvm/core.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/lightnvm/core.c b/drivers/lightnvm/core.c
index 4f4db99..b2cd3d6 100644
--- a/drivers/lightnvm/core.c
+++ b/drivers/lightnvm/core.c
@@ -303,7 +303,7 @@ static int nvm_create_tgt(struct nvm_dev *dev, struct nvm_ioctl_create *create)
 err_queue:
 	blk_cleanup_queue(tqueue);
 err_dev:
-	kfree(tgt_dev);
+	nvm_remove_tgt_dev(tgt_dev);
 err_t:
 	kfree(t);
 err_reserve:
-- 
2.9.3

