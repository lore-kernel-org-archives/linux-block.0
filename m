Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mail-wm0-f49.google.com ([74.125.82.49]:35026 "EHLO
        mail-wm0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752158AbdAZQFm (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 26 Jan 2017 11:05:42 -0500
Received: by mail-wm0-f49.google.com with SMTP id r126so78479331wmr.0
        for <linux-block@vger.kernel.org>; Thu, 26 Jan 2017 08:04:43 -0800 (PST)
From: "=?UTF-8?q?Javier=20Gonz=C3=A1lez?=" <jg@lightnvm.io>
To: mb@lightnvm.io
Cc: linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        =?UTF-8?q?Javier=20Gonz=C3=A1lez?= <javier@cnexlabs.com>
Subject: [PATCH] lightnvm: free properly on target creation error
Date: Thu, 26 Jan 2017 16:57:39 +0100
Message-Id: <1485446259-2396-1-git-send-email-javier@cnexlabs.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

Fix a memory leak when target creation fails. More specifically, free
the entire device structure given to the target (tgt_dev).

Signed-off-by: Javier González <javier@cnexlabs.com>
---
 drivers/lightnvm/core.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/lightnvm/core.c b/drivers/lightnvm/core.c
index 8baae61..d5bb5e1 100644
--- a/drivers/lightnvm/core.c
+++ b/drivers/lightnvm/core.c
@@ -309,7 +309,7 @@ static int nvm_create_tgt(struct nvm_dev *dev, struct nvm_ioctl_create *create)
 err_queue:
 	blk_cleanup_queue(tqueue);
 err_dev:
-	kfree(tgt_dev);
+	nvm_remove_tgt_dev(tgt_dev);
 err_t:
 	kfree(t);
 err_reserve:
-- 
2.7.4

