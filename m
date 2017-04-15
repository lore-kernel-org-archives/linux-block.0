Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mail-dm3nam03on0041.outbound.protection.outlook.com ([104.47.41.41]:38016
        "EHLO NAM03-DM3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1754723AbdDOS4V (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Sat, 15 Apr 2017 14:56:21 -0400
From: =?UTF-8?q?Matias=20Bj=C3=B8rling?= <matias@cnexlabs.com>
To: <axboe@fb.com>
CC: <linux-block@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        =?UTF-8?q?Javier=20Gonz=C3=A1lez?= <jg@lightnvm.io>,
        =?UTF-8?q?Javier=20Gonz=C3=A1lez?= <javier@cnexlabs.com>,
        =?UTF-8?q?Matias=20Bj=C3=B8rling?= <matias@cnexlabs.com>
Subject: [GIT PULL 04/19] lightnvm: rename scrambler controller hint
Date: Sat, 15 Apr 2017 20:55:38 +0200
Message-ID: <20170415185553.16098-5-matias@cnexlabs.com>
In-Reply-To: <20170415185553.16098-1-matias@cnexlabs.com>
References: <20170415185553.16098-1-matias@cnexlabs.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

From: Javier González <jg@lightnvm.io>

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
index e11163f..eff7d1f 100644
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
2.9.3
