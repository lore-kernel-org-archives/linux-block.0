Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mail-wm0-f65.google.com ([74.125.82.65]:36241 "EHLO
        mail-wm0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755888AbdLTRW0 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 20 Dec 2017 12:22:26 -0500
Received: by mail-wm0-f65.google.com with SMTP id b76so11235473wmg.1
        for <linux-block@vger.kernel.org>; Wed, 20 Dec 2017 09:22:25 -0800 (PST)
From: =?UTF-8?q?Matias=20Bj=C3=B8rling?= <m@bjorling.me>
To: linux-block@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: =?UTF-8?q?Javier=20Gonz=C3=A1lez?= <javier@cnexlabs.com>,
        =?UTF-8?q?Matias=20Bj=C3=B8rling?= <m@bjorling.me>
Subject: [PATCH 11/25] lightnvm: pblk: remove pblk_for_each_lun helper
Date: Wed, 20 Dec 2017 18:21:51 +0100
Message-Id: <20171220172205.26464-12-m@bjorling.me>
In-Reply-To: <20171220172205.26464-1-m@bjorling.me>
References: <20171220172205.26464-1-m@bjorling.me>
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
index b62790e..7b09fb2 100644
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
