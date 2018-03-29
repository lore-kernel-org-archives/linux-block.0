Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mail-lf0-f68.google.com ([209.85.215.68]:40321 "EHLO
        mail-lf0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752590AbeC2WHV (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 29 Mar 2018 18:07:21 -0400
Received: by mail-lf0-f68.google.com with SMTP id e5-v6so10343634lfb.7
        for <linux-block@vger.kernel.org>; Thu, 29 Mar 2018 15:07:20 -0700 (PDT)
From: =?UTF-8?q?Matias=20Bj=C3=B8rling?= <mb@lightnvm.io>
To: axboe@fb.com
Cc: linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        keith.busch@intel.com, javier@cnexlabs.com,
        Heiner Litz <hlitz@ucsc.edu>,
        =?UTF-8?q?Matias=20Bj=C3=B8rling?= <mb@lightnvm.io>
Subject: [GIT PULL 21/37] lightnvm: Avoid validation of default op value
Date: Fri, 30 Mar 2018 00:05:08 +0200
Message-Id: <20180329220524.30363-22-mb@lightnvm.io>
In-Reply-To: <20180329220524.30363-1-mb@lightnvm.io>
References: <20180329220524.30363-1-mb@lightnvm.io>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

From: Heiner Litz <hlitz@ucsc.edu>

Fixes: 38401d231de65 ("lightnvm: set target over-provision on create ioctl")
Signed-off-by: Heiner Litz <hlitz@ucsc.edu>
Reviewed-by: Javier González <javier@cnexlabs.com>
Signed-off-by: Matias Bjørling <mb@lightnvm.io>
---
 drivers/lightnvm/core.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/lightnvm/core.c b/drivers/lightnvm/core.c
index 5b197d6bb6d9..c4f12b1ae8b8 100644
--- a/drivers/lightnvm/core.c
+++ b/drivers/lightnvm/core.c
@@ -304,11 +304,9 @@ static int __nvm_config_extended(struct nvm_dev *dev,
 	}
 
 	/* op not set falls into target's default */
-	if (e->op == 0xFFFF)
+	if (e->op == 0xFFFF) {
 		e->op = NVM_TARGET_DEFAULT_OP;
-
-	if (e->op < NVM_TARGET_MIN_OP ||
-	    e->op > NVM_TARGET_MAX_OP) {
+	} else if (e->op < NVM_TARGET_MIN_OP || e->op > NVM_TARGET_MAX_OP) {
 		pr_err("nvm: invalid over provisioning value\n");
 		return -EINVAL;
 	}
-- 
2.11.0
