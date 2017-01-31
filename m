Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mail-bn3nam01on0043.outbound.protection.outlook.com ([104.47.33.43]:32224
        "EHLO NAM01-BN3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1752021AbdAaMSY (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Tue, 31 Jan 2017 07:18:24 -0500
From: =?UTF-8?q?Matias=20Bj=C3=B8rling?= <matias@cnexlabs.com>
To: <axboe@fb.com>
CC: <linux-block@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        =?UTF-8?q?Javier=20Gonz=C3=A1lez?= <jg@lightnvm.io>,
        =?UTF-8?q?Javier=20Gonz=C3=A1lez?= <javier@cnexlabs.com>,
        =?UTF-8?q?Matias=20Bj=C3=B8rling?= <matias@cnexlabs.com>
Subject: [PATCH 10/12] lightnvm: Add CRC read error
Date: Tue, 31 Jan 2017 13:17:18 +0100
Message-ID: <20170131121720.10971-11-matias@cnexlabs.com>
In-Reply-To: <20170131121720.10971-1-matias@cnexlabs.com>
References: <20170131121720.10971-1-matias@cnexlabs.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

From: Javier González <jg@lightnvm.io>

Let the host differentiate between a read error and a CRC check error on
the device side.

Signed-off-by: Javier González <javier@cnexlabs.com>
Signed-off-by: Matias Bjørling <matias@cnexlabs.com>
---
 include/linux/lightnvm.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/include/linux/lightnvm.h b/include/linux/lightnvm.h
index 17cd454..bc282d2 100644
--- a/include/linux/lightnvm.h
+++ b/include/linux/lightnvm.h
@@ -107,6 +107,7 @@ enum {
 	NVM_RSP_ERR_FAILWRITE	= 0x40ff,
 	NVM_RSP_ERR_EMPTYPAGE	= 0x42ff,
 	NVM_RSP_ERR_FAILECC	= 0x4281,
+	NVM_RSP_ERR_FAILCRC	= 0x4004,
 	NVM_RSP_WARN_HIGHECC	= 0x4700,
 
 	/* Device opcodes */
-- 
2.9.3

