Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mail-wm0-f68.google.com ([74.125.82.68]:35049 "EHLO
        mail-wm0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751726AbeAENQv (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Fri, 5 Jan 2018 08:16:51 -0500
Received: by mail-wm0-f68.google.com with SMTP id a79so2426620wma.0
        for <linux-block@vger.kernel.org>; Fri, 05 Jan 2018 05:16:51 -0800 (PST)
From: =?UTF-8?q?Matias=20Bj=C3=B8rling?= <m@bjorling.me>
To: axboe@fb.com
Cc: linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        =?UTF-8?q?Javier=20Gonz=C3=A1lez?= <javier@cnexlabs.com>,
        =?UTF-8?q?Matias=20Bj=C3=B8rling?= <m@bjorling.me>
Subject: [GIT PULL 11/25] lightnvm: pblk: remove pblk_for_each_lun helper
Date: Fri,  5 Jan 2018 14:16:07 +0100
Message-Id: <20180105131621.20808-12-m@bjorling.me>
In-Reply-To: <20180105131621.20808-1-m@bjorling.me>
References: <20180105131621.20808-1-m@bjorling.me>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

From: Javier González <javier@cnexlabs.com>

Signed-off-by: Javier González <javier@cnexlabs.com>
Signed-off-by: Matias Bjørling <m@bjorling.me>
---
 drivers/lightnvm/pblk.h | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/drivers/lightnvm/pblk.h b/drivers/lightnvm/pblk.h
index d68a94d..1dbb0bf 100644
--- a/drivers/lightnvm/pblk.h
+++ b/drivers/lightnvm/pblk.h
@@ -51,10 +51,6 @@
 
 #define NR_PHY_IN_LOG (PBLK_EXPOSED_PAGE_SIZE / PBLK_SECTOR)
 
-#define pblk_for_each_lun(pblk, rlun, i) \
-		for ((i) = 0, rlun = &(pblk)->luns[0]; \
-			(i) < (pblk)->nr_luns; (i)++, rlun = &(pblk)->luns[(i)])
-
 /* Static pool sizes */
 #define PBLK_GEN_WS_POOL_SIZE (2)
 
-- 
2.9.3
