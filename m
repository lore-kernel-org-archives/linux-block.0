Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mail-pg0-f50.google.com ([74.125.83.50]:49242 "EHLO
        mail-pg0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751487AbdJKRjY (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 11 Oct 2017 13:39:24 -0400
Received: by mail-pg0-f50.google.com with SMTP id v13so1372133pgq.6
        for <linux-block@vger.kernel.org>; Wed, 11 Oct 2017 10:39:24 -0700 (PDT)
From: Omar Sandoval <osandov@osandov.com>
To: linux-block@vger.kernel.org
Cc: kernel-team@fb.com, Bin Zha <zhabin.zb@alibaba-inc.com>
Subject: [PATCH] kyber: fix hang on domain token wait queue
Date: Wed, 11 Oct 2017 10:39:15 -0700
Message-Id: <0c81254e266944c463e7dc12da15cc99edc466b8.1507743307.git.osandov@fb.com>
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

From: Omar Sandoval <osandov@fb.com>

When we're getting a domain token, if we fail to get a token on our
first attempt, we put the current hardware queue on a wait queue and
then try again just in case a token was freed after our initial attempt
but before we got on the wait queue. If this second attempt succeeds, we
currently leave the hardware queue on the wait queue. Usually this is
okay; we'll just run the hardware queue one extra time when another
token is freed. However, if the hardware queue doesn't have any other
requests waiting, then when it it gets the extra wakeup, it won't have
anything to free and therefore won't wake up any other hardware queues.
If tokens are limited, then we won't make forward progress and the
device will hang.

Reported-by: Bin Zha <zhabin.zb@alibaba-inc.com>
Signed-off-by: Omar Sandoval <osandov@fb.com>
---
Based on Bin Zha's patch with an added comment and open-coded
remove_wait_queue() using list_del_init() instead of doing a
INIT_LIST_HEAD() after the wait queue lock has been dropped.

Based on v4.14-rc4.

 block/kyber-iosched.c | 10 +++++++++-
 1 file changed, 9 insertions(+), 1 deletion(-)

diff --git a/block/kyber-iosched.c b/block/kyber-iosched.c
index f58cab82105b..db5bfc6342d3 100644
--- a/block/kyber-iosched.c
+++ b/block/kyber-iosched.c
@@ -541,9 +541,17 @@ static int kyber_get_domain_token(struct kyber_queue_data *kqd,
 
 		/*
 		 * Try again in case a token was freed before we got on the wait
-		 * queue.
+		 * queue. The waker may have already removed the entry from the
+		 * wait queue, but list_del_init() is okay with that.
 		 */
 		nr = __sbitmap_queue_get(domain_tokens);
+		if (nr >= 0) {
+			unsigned long flags;
+
+			spin_lock_irqsave(&ws->wait.lock, flags);
+			list_del_init(&wait->entry);
+			spin_unlock_irqrestore(&ws->wait.lock, flags);
+		}
 	}
 	return nr;
 }
-- 
2.14.2
