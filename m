Return-Path: <linux-block-owner@vger.kernel.org>
Received: from iad1-shared-relay2.dreamhost.com ([208.113.157.41]:44080 "EHLO
        iad1-shared-relay2.dreamhost.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1752500AbdF3KQ2 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 30 Jun 2017 06:16:28 -0400
Received: from iad1-shared-relay1.dreamhost.com (iad1-shared-relay1.dreamhost.com [208.113.157.50])
        by iad1-shared-relay2.dreamhost.com (Postfix) with ESMTP id AD9013E5214
        for <linux-block@vger.kernel.org>; Thu, 29 Jun 2017 15:12:13 -0700 (PDT)
Received: from ware.dreamhost.com (ware.dreamhost.com [64.111.127.160])
        by iad1-shared-relay1.dreamhost.com (Postfix) with ESMTP id A7C1DB400AA
        for <linux-block@vger.kernel.org>; Thu, 29 Jun 2017 15:12:07 -0700 (PDT)
In-Reply-To: <20170629134510.GA32385@infradead.org>
References: <20170629134510.GA32385@infradead.org>
From: Dan Carpenter <dan.carpenter@oracle.com>
Date: Wed, 28 Jun 2017 14:48:18 +0300
Subject: [PATCH 19/19] bcache: Update continue_at() documentation
To: linux-block@vger.kernel.org
Message-Id: <20170629221207.999A9100127@ware.dreamhost.com>
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

continue_at() doesn't have a return statement anymore.

Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>
---
 drivers/md/bcache/closure.h | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/drivers/md/bcache/closure.h b/drivers/md/bcache/closure.h
index 1ec84ca..295b7e4 100644
--- a/drivers/md/bcache/closure.h
+++ b/drivers/md/bcache/closure.h
@@ -312,8 +312,6 @@ static inline void closure_wake_up(struct closure_waitlist *list)
  * been dropped with closure_put()), it will resume execution at @fn running out
  * of @wq (or, if @wq is NULL, @fn will be called by closure_put() directly).
  *
- * NOTE: This macro expands to a return in the calling function!
- *
  * This is because after calling continue_at() you no longer have a ref on @cl,
  * and whatever @cl owns may be freed out from under you - a running closure fn
  * has a ref on its own closure which continue_at() drops.
@@ -340,8 +338,6 @@ do {									\
  * Causes @fn to be executed out of @cl, in @wq context (or called directly if
  * @wq is NULL).
  *
- * NOTE: like continue_at(), this macro expands to a return in the caller!
- *
  * The ref the caller of continue_at_nobarrier() had on @cl is now owned by @fn,
  * thus it's not safe to touch anything protected by @cl after a
  * continue_at_nobarrier().
-- 
1.8.3.1
