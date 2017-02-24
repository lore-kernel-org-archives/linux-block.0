Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mail-wr0-f172.google.com ([209.85.128.172]:34045 "EHLO
        mail-wr0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751414AbdBXQOU (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 24 Feb 2017 11:14:20 -0500
Received: by mail-wr0-f172.google.com with SMTP id o22so10615320wro.1
        for <linux-block@vger.kernel.org>; Fri, 24 Feb 2017 08:14:20 -0800 (PST)
From: "=?UTF-8?q?Javier=20Gonz=C3=A1lez?=" <jg@lightnvm.io>
To: mb@lightnvm.io
Cc: linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        =?UTF-8?q?Javier=20Gonz=C3=A1lez?= <javier@cnexlabs.com>,
        =?UTF-8?q?Matias=20Bj=C3=B8rling?= <matias@cnexlabs.com>
Subject: [PATCH 2/3] lightnvm: rename scrambler controller hint
Date: Fri, 24 Feb 2017 17:14:05 +0100
Message-Id: <1487952846-29476-2-git-send-email-javier@cnexlabs.com>
In-Reply-To: <1487952846-29476-1-git-send-email-javier@cnexlabs.com>
References: <1487952846-29476-1-git-send-email-javier@cnexlabs.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

According to the OCSSD 1.2 specification, the 0x200 hint enables the
media scrambler for the read/write opcode, providing that the controller
has been correctly configured by the firmware. Rename the macro to
represent this meaning.

Signed-off-by: Javier González <javier@cnexlabs.com>
Signed-off-by: Matias Bjørling <matias@cnexlabs.com>
---
 include/linux/lightnvm.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/linux/lightnvm.h b/include/linux/lightnvm.h
index 6a3534b..bebea80 100644
--- a/include/linux/lightnvm.h
+++ b/include/linux/lightnvm.h
@@ -123,7 +123,7 @@ enum {
 	/* NAND Access Modes */
 	NVM_IO_SUSPEND		= 0x80,
 	NVM_IO_SLC_MODE		= 0x100,
-	NVM_IO_SCRAMBLE_DISABLE	= 0x200,
+	NVM_IO_SCRAMBLE_ENABLE	= 0x200,
 
 	/* Block Types */
 	NVM_BLK_T_FREE		= 0x0,
-- 
2.7.4
