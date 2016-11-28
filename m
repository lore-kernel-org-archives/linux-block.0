Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mail-wj0-f194.google.com ([209.85.210.194]:34088 "EHLO
        mail-wj0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755546AbcK1Vjn (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 28 Nov 2016 16:39:43 -0500
Received: by mail-wj0-f194.google.com with SMTP id xy5so15802189wjc.1
        for <linux-block@vger.kernel.org>; Mon, 28 Nov 2016 13:39:43 -0800 (PST)
From: =?UTF-8?q?Matias=20Bj=C3=B8rling?= <m@bjorling.me>
To: linux-block@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: axboe@fb.com, =?UTF-8?q?Javier=20Gonz=C3=A1lez?= <jg@lightnvm.io>,
        =?UTF-8?q?Javier=20Gonz=C3=A1lez?= <javier@cnexlabs.com>,
        =?UTF-8?q?Matias=20Bj=C3=B8rling?= <m@bjorling.me>
Subject: [PATCH 06/23] lightnvm: add ECC error codes
Date: Mon, 28 Nov 2016 22:38:57 +0100
Message-Id: <20161128213914.12516-7-m@bjorling.me>
In-Reply-To: <20161128213914.12516-1-m@bjorling.me>
References: <20161128213914.12516-1-m@bjorling.me>
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
2.9.3

