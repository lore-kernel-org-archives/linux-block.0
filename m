Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mail-wm0-f54.google.com ([74.125.82.54]:35902 "EHLO
        mail-wm0-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752784AbdIFKWs (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Wed, 6 Sep 2017 06:22:48 -0400
Received: by mail-wm0-f54.google.com with SMTP id i145so27745751wmf.1
        for <linux-block@vger.kernel.org>; Wed, 06 Sep 2017 03:22:48 -0700 (PDT)
From: "=?UTF-8?q?Javier=20Gonz=C3=A1lez?=" <jg@lightnvm.io>
To: mb@lightnvm.io, axboe@fb.com
Cc: linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        =?UTF-8?q?Javier=20Gonz=C3=A1lez?= <javier@cnexlabs.com>
Subject: [PATCH] lightnvm: Add error code for bad write pointer
Date: Wed,  6 Sep 2017 12:22:38 +0200
Message-Id: <1504693358-12702-1-git-send-email-javier@cnexlabs.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

Add new error code introduced on the OCSSD spec 2.0 for write pointer
mismatch on the device side. This indicates to the host that a write on
a block (chunk) is not respecting the required sequentiality.

Signed-off-by: Javier González <javier@cnexlabs.com>
---
 include/linux/lightnvm.h | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/include/linux/lightnvm.h b/include/linux/lightnvm.h
index 7dfa56ebbc6d..81b71c6d5873 100644
--- a/include/linux/lightnvm.h
+++ b/include/linux/lightnvm.h
@@ -102,7 +102,8 @@ enum {
 	/* Status codes */
 	NVM_RSP_SUCCESS		= 0x0,
 	NVM_RSP_NOT_CHANGEABLE	= 0x1,
-	NVM_RSP_ERR_FAILWRITE	= 0x40ff,
+	NVM_RSP_ERR_FAILWRITE	= 0x40ff,	/* Generic write failure */
+	NVM_RSP_ERR_FAILWP	= 0x42f0,	/* Write pointer failure */
 	NVM_RSP_ERR_EMPTYPAGE	= 0x42ff,
 	NVM_RSP_ERR_FAILECC	= 0x4281,
 	NVM_RSP_ERR_FAILCRC	= 0x4004,
-- 
2.7.4
