Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mail-lf0-f49.google.com ([209.85.215.49]:34085 "EHLO
        mail-lf0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S941772AbcJ0SB5 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 27 Oct 2016 14:01:57 -0400
Received: by mail-lf0-f49.google.com with SMTP id b81so38503589lfe.1
        for <linux-block@vger.kernel.org>; Thu, 27 Oct 2016 11:01:56 -0700 (PDT)
From: "=?UTF-8?q?Javier=20Gonz=C3=A1lez?=" <jg@lightnvm.io>
To: mb@lightnvm.io
Cc: linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        =?UTF-8?q?Javier=20Gonz=C3=A1lez?= <javier@cnexlabs.com>
Subject: [PATCH 6/7] lightnvm: add ECC error codes
Date: Thu, 27 Oct 2016 20:01:38 +0200
Message-Id: <1477591299-26504-7-git-send-email-javier@cnexlabs.com>
In-Reply-To: <1477591299-26504-1-git-send-email-javier@cnexlabs.com>
References: <1477591299-26504-1-git-send-email-javier@cnexlabs.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

Add ECC error codes to enable the appropriate handling in the target.

Signed-off-by: Javier González <javier@cnexlabs.com>
---
 include/linux/lightnvm.h | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/include/linux/lightnvm.h b/include/linux/lightnvm.h
index e3ccaff..33643ae 100644
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

