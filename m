Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mail-pf0-f193.google.com ([209.85.192.193]:40432 "EHLO
        mail-pf0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750877AbeBZTqH (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 26 Feb 2018 14:46:07 -0500
Received: by mail-pf0-f193.google.com with SMTP id m5so6941002pff.7
        for <linux-block@vger.kernel.org>; Mon, 26 Feb 2018 11:46:06 -0800 (PST)
From: Heiner Litz <hlitz@ucsc.edu>
To: linux-block@vger.kernel.org
Cc: javier@cnexlabs.com, mb@lightnvm.io, Heiner Litz <hlitz@ucsc.edu>
Subject: [PATCH] lightnvm: Avoid validation of default op value Avoid validation of default op value, if default value is given. In preparation of using the rsvd field of the extended config for additional paramters while using default op.
Date: Mon, 26 Feb 2018 11:45:57 -0800
Message-Id: <20180226194557.12226-1-hlitz@ucsc.edu>
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

 Fixes: 38401d231de65 ("lightnvm: set target over-provision on create ioctl")

Signed-off-by: Heiner Litz <hlitz@ucsc.edu>
---
 drivers/lightnvm/core.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/drivers/lightnvm/core.c b/drivers/lightnvm/core.c
index dcc9e621e651..4e6095e2af06 100644
--- a/drivers/lightnvm/core.c
+++ b/drivers/lightnvm/core.c
@@ -304,10 +304,9 @@ static int __nvm_config_extended(struct nvm_dev *dev,
 	}
 
 	/* op not set falls into target's default */
-	if (e->op == 0xFFFF)
+	if (e->op == 0xFFFF) {
 		e->op = NVM_TARGET_DEFAULT_OP;
-
-	if (e->op < NVM_TARGET_MIN_OP ||
+	} else if (e->op < NVM_TARGET_MIN_OP ||
 	    e->op > NVM_TARGET_MAX_OP) {
 		pr_err("nvm: invalid over provisioning value\n");
 		return -EINVAL;
-- 
2.14.1
