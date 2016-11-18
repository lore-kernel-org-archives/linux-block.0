Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mail-wm0-f49.google.com ([74.125.82.49]:38615 "EHLO
        mail-wm0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753175AbcKROoB (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 18 Nov 2016 09:44:01 -0500
Received: by mail-wm0-f49.google.com with SMTP id f82so41996972wmf.1
        for <linux-block@vger.kernel.org>; Fri, 18 Nov 2016 06:44:00 -0800 (PST)
From: "=?UTF-8?q?Javier=20Gonz=C3=A1lez?=" <jg@lightnvm.io>
To: mb@lightnvm.io
Cc: linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        =?UTF-8?q?Javier=20Gonz=C3=A1lez?= <jg@lightnvm.io>,
        =?UTF-8?q?Javier=20Gonz=C3=A1lez?= <javier@cnexlabs.com>,
        =?UTF-8?q?Matias=20Bj=C3=B8rling?= <m@bjorling.me>
Subject: [PATCH 04/20] lightnvm: add ECC error codes
Date: Fri, 18 Nov 2016 15:43:26 +0100
Message-Id: <1479480222-18790-5-git-send-email-javier@cnexlabs.com>
In-Reply-To: <1479480222-18790-1-git-send-email-javier@cnexlabs.com>
References: <1479480222-18790-1-git-send-email-javier@cnexlabs.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

From: Javier González <jg@lightnvm.io>

Add ECC error codes to enable the appropriate handling in the target.

Signed-off-by: Javier González <javier@cnexlabs.com>
Signed-off-by: Matias Bjørling <m@bjorling.me>
---
 include/linux/lightnvm.h | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/include/linux/lightnvm.h b/include/linux/lightnvm.h
index 4480d1c..6b26a32 100644
--- a/include/linux/lightnvm.h
+++ b/include/linux/lightnvm.h
@@ -107,6 +107,8 @@ enum {
 	NVM_RSP_NOT_CHANGEABLE	= 0x1,
 	NVM_RSP_ERR_FAILWRITE	= 0x40ff,
 	NVM_RSP_ERR_EMPTYPAGE	= 0x42ff,
+	NVM_RSP_ERR_FAILECC	= 0x4281,
+	NVM_RSP_WARN_HIGHECC	= 0x4700,
 
 	/* Device opcodes */
 	NVM_OP_HBREAD		= 0x02,
-- 
2.7.4

