Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mail-wm0-f65.google.com ([74.125.82.65]:35417 "EHLO
	mail-wm0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752756AbcF2OmX (ORCPT
	<rfc822;linux-block@vger.kernel.org>);
	Wed, 29 Jun 2016 10:42:23 -0400
Received: by mail-wm0-f65.google.com with SMTP id a66so14847366wme.2
        for <linux-block@vger.kernel.org>; Wed, 29 Jun 2016 07:42:18 -0700 (PDT)
From: =?UTF-8?q?Matias=20Bj=C3=B8rling?= <m@bjorling.me>
To: linux-block@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: =?UTF-8?q?Matias=20Bj=C3=B8rling?= <m@bjorling.me>
Subject: [RFC PATCH 11/11] lightnvm: make __nvm_submit_ppa static
Date: Wed, 29 Jun 2016 16:41:56 +0200
Message-Id: <1467211316-22373-12-git-send-email-m@bjorling.me>
In-Reply-To: <1467211316-22373-1-git-send-email-m@bjorling.me>
References: <1467211316-22373-1-git-send-email-m@bjorling.me>
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

