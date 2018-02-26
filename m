Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mail-pg0-f65.google.com ([74.125.83.65]:41691 "EHLO
        mail-pg0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752057AbeBZUWb (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 26 Feb 2018 15:22:31 -0500
Received: by mail-pg0-f65.google.com with SMTP id q27so5018105pgn.8
        for <linux-block@vger.kernel.org>; Mon, 26 Feb 2018 12:22:31 -0800 (PST)
From: Heiner Litz <hlitz@ucsc.edu>
To: linux-block@vger.kernel.org
Cc: javier@cnexlabs.com, mb@lightnvm.io, Heiner Litz <hlitz@ucsc.edu>
Subject: [PATCH][RESEND] lightnvm: Avoid validation of default op value
Date: Mon, 26 Feb 2018 12:22:19 -0800
Message-Id: <20180226202219.2880-1-hlitz@ucsc.edu>
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

Fixes: 38401d231de65 ("lightnvm: set target over-provision on create ioctl")

Signed-off-by: Heiner Litz <hlitz@ucsc.edu>
---
 drivers/lightnvm/core.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/lightnvm/core.c b/drivers/lightnvm/core.c
index dcc9e621e651..74b53fc1b813 100644
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
2.14.1
