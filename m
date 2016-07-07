Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mail-wm0-f68.google.com ([74.125.82.68]:33996 "EHLO
	mail-wm0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933245AbcGGHyx (ORCPT
	<rfc822;linux-block@vger.kernel.org>); Thu, 7 Jul 2016 03:54:53 -0400
Received: by mail-wm0-f68.google.com with SMTP id 187so3535533wmz.1
        for <linux-block@vger.kernel.org>; Thu, 07 Jul 2016 00:54:53 -0700 (PDT)
From: =?UTF-8?q?Matias=20Bj=C3=B8rling?= <m@bjorling.me>
To: linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
	axboe@fb.com
Cc: =?UTF-8?q?Matias=20Bj=C3=B8rling?= <m@bjorling.me>
Subject: [PATCH 17/17] lightnvm: make __nvm_submit_ppa static
Date: Thu,  7 Jul 2016 09:54:23 +0200
Message-Id: <1467878063-22919-18-git-send-email-m@bjorling.me>
In-Reply-To: <1467878063-22919-1-git-send-email-m@bjorling.me>
References: <1467878063-22919-1-git-send-email-m@bjorling.me>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

The __nvm_submit_ppa() function is not used outside lightnvm core.

Signed-off-by: Matias Bjørling <m@bjorling.me>
---
 drivers/lightnvm/core.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/lightnvm/core.c b/drivers/lightnvm/core.c
index 00b64f7..9ebd2cf 100644
--- a/drivers/lightnvm/core.c
+++ b/drivers/lightnvm/core.c
@@ -325,7 +325,7 @@ static void nvm_end_io_sync(struct nvm_rq *rqd)
 	complete(waiting);
 }
 
-int __nvm_submit_ppa(struct nvm_dev *dev, struct nvm_rq *rqd, int opcode,
+static int __nvm_submit_ppa(struct nvm_dev *dev, struct nvm_rq *rqd, int opcode,
 						int flags, void *buf, int len)
 {
 	DECLARE_COMPLETION_ONSTACK(wait);
-- 
2.1.4

