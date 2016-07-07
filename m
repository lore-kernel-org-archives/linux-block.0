Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mail-wm0-f65.google.com ([74.125.82.65]:33381 "EHLO
	mail-wm0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756594AbcGGHyi (ORCPT
	<rfc822;linux-block@vger.kernel.org>); Thu, 7 Jul 2016 03:54:38 -0400
Received: by mail-wm0-f65.google.com with SMTP id n127so996968wme.0
        for <linux-block@vger.kernel.org>; Thu, 07 Jul 2016 00:54:37 -0700 (PDT)
From: =?UTF-8?q?Matias=20Bj=C3=B8rling?= <m@bjorling.me>
To: linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
	axboe@fb.com
Cc: =?UTF-8?q?Javier=20Gonz=C3=A1lez?= <javier@cnexlabs.com>,
	=?UTF-8?q?Matias=20Bj=C3=B8rling?= <m@bjorling.me>
Subject: [PATCH 03/17] lightnvm: initialize ppa_addr in dev_to_generic_addr()
Date: Thu,  7 Jul 2016 09:54:09 +0200
Message-Id: <1467878063-22919-4-git-send-email-m@bjorling.me>
In-Reply-To: <1467878063-22919-1-git-send-email-m@bjorling.me>
References: <1467878063-22919-1-git-send-email-m@bjorling.me>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

From: Javier González <javier@cnexlabs.com>

The ->reserved bit is not initialized when allocated on stack.
This may lead targets to misinterpret the PPA as cached.

Signed-off-by: Javier González <javier@cnexlabs.com>
Signed-off-by: Matias Bjørling <m@bjorling.me>
---
 include/linux/lightnvm.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/include/linux/lightnvm.h b/include/linux/lightnvm.h
index 9c56148..cee4c8d 100644
--- a/include/linux/lightnvm.h
+++ b/include/linux/lightnvm.h
@@ -385,6 +385,7 @@ static inline struct ppa_addr dev_to_generic_addr(struct nvm_dev *dev,
 {
 	struct ppa_addr l;
 
+	l.ppa = 0;
 	/*
 	 * (r.ppa << X offset) & X len bitmask. X eq. blk, pg, etc.
 	 */
-- 
2.1.4

