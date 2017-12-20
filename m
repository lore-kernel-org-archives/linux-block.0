Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mail-wm0-f67.google.com ([74.125.82.67]:34228 "EHLO
        mail-wm0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1756023AbdLTRWk (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 20 Dec 2017 12:22:40 -0500
Received: by mail-wm0-f67.google.com with SMTP id y82so16622011wmg.1
        for <linux-block@vger.kernel.org>; Wed, 20 Dec 2017 09:22:39 -0800 (PST)
From: =?UTF-8?q?Matias=20Bj=C3=B8rling?= <m@bjorling.me>
To: linux-block@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: =?UTF-8?q?Matias=20Bj=C3=B8rling?= <m@bjorling.me>
Subject: [PATCH 25/25] lightnvm: pblk: refactor pblk_ppa_comp function
Date: Wed, 20 Dec 2017 18:22:05 +0100
Message-Id: <20171220172205.26464-26-m@bjorling.me>
In-Reply-To: <20171220172205.26464-1-m@bjorling.me>
References: <20171220172205.26464-1-m@bjorling.me>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

Shorten function to simply return the value of the if statement.

Signed-off-by: Matias Bjørling <m@bjorling.me>
---
 drivers/lightnvm/pblk.h | 5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

diff --git a/drivers/lightnvm/pblk.h b/drivers/lightnvm/pblk.h
index 1e9eafd..a1434da 100644
--- a/drivers/lightnvm/pblk.h
+++ b/drivers/lightnvm/pblk.h
@@ -1047,10 +1047,7 @@ static inline void pblk_ppa_set_empty(struct ppa_addr *ppa_addr)
 
 static inline bool pblk_ppa_comp(struct ppa_addr lppa, struct ppa_addr rppa)
 {
-	if (lppa.ppa == rppa.ppa)
-		return true;
-
-	return false;
+	return (lppa.ppa == rppa.ppa);
 }
 
 static inline int pblk_addr_in_cache(struct ppa_addr ppa)
-- 
2.9.3
