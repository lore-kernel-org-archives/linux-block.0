Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mail-wm0-f66.google.com ([74.125.82.66]:39404 "EHLO
        mail-wm0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751763AbeAENQp (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Fri, 5 Jan 2018 08:16:45 -0500
Received: by mail-wm0-f66.google.com with SMTP id i11so2417841wmf.4
        for <linux-block@vger.kernel.org>; Fri, 05 Jan 2018 05:16:44 -0800 (PST)
From: =?UTF-8?q?Matias=20Bj=C3=B8rling?= <m@bjorling.me>
To: axboe@fb.com
Cc: linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        =?UTF-8?q?Javier=20Gonz=C3=A1lez?= <javier@cnexlabs.com>,
        =?UTF-8?q?Matias=20Bj=C3=B8rling?= <m@bjorling.me>
Subject: [GIT PULL 05/25] lightnvm: remove unnecessary field from nvm_rq
Date: Fri,  5 Jan 2018 14:16:01 +0100
Message-Id: <20180105131621.20808-6-m@bjorling.me>
In-Reply-To: <20180105131621.20808-1-m@bjorling.me>
References: <20180105131621.20808-1-m@bjorling.me>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

From: Javier González <javier@cnexlabs.com>

Remove the wait filed in nvm_rq. It is not used anymore, as targets rely
on the functionality provided by the LightNVM subsystem when sending
sync I/O.

Signed-off-by: Javier González <javier@cnexlabs.com>
Signed-off-by: Matias Bjørling <m@bjorling.me>
---
 include/linux/lightnvm.h | 1 -
 1 file changed, 1 deletion(-)

diff --git a/include/linux/lightnvm.h b/include/linux/lightnvm.h
index 97ceb84..07cdb05 100644
--- a/include/linux/lightnvm.h
+++ b/include/linux/lightnvm.h
@@ -233,7 +233,6 @@ struct nvm_rq {
 	void *meta_list;
 	dma_addr_t dma_meta_list;
 
-	struct completion *wait;
 	nvm_end_io_fn *end_io;
 
 	uint8_t opcode;
-- 
2.9.3
