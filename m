Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mail-wm0-f54.google.com ([74.125.82.54]:37721 "EHLO
        mail-wm0-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752099AbdAZLrx (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 26 Jan 2017 06:47:53 -0500
Received: by mail-wm0-f54.google.com with SMTP id c206so79676013wme.0
        for <linux-block@vger.kernel.org>; Thu, 26 Jan 2017 03:47:53 -0800 (PST)
From: "=?UTF-8?q?Javier=20Gonz=C3=A1lez?=" <jg@lightnvm.io>
To: mb@lightnvm.io
Cc: linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        =?UTF-8?q?Javier=20Gonz=C3=A1lez?= <javier@cnexlabs.com>
Subject: [PATCH 3/3] lightnvm: Add CRC read error
Date: Thu, 26 Jan 2017 12:47:40 +0100
Message-Id: <1485431260-20268-3-git-send-email-javier@cnexlabs.com>
In-Reply-To: <1485431260-20268-1-git-send-email-javier@cnexlabs.com>
References: <1485431260-20268-1-git-send-email-javier@cnexlabs.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

Let the host differentiate between a read error and a CRC check error on
the device side.

Signed-off-by: Javier González <javier@cnexlabs.com>
---
 include/linux/lightnvm.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/include/linux/lightnvm.h b/include/linux/lightnvm.h
index 11c318e..51cda67 100644
--- a/include/linux/lightnvm.h
+++ b/include/linux/lightnvm.h
@@ -108,6 +108,7 @@ enum {
 	NVM_RSP_ERR_FAILWRITE	= 0x40ff,
 	NVM_RSP_ERR_EMPTYPAGE	= 0x42ff,
 	NVM_RSP_ERR_FAILECC	= 0x4281,
+	NVM_RSP_ERR_FAILCRC	= 0x4004,
 	NVM_RSP_WARN_HIGHECC	= 0x4700,
 
 	/* Device opcodes */
-- 
2.7.4

