Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mail-lf0-f65.google.com ([209.85.215.65]:34595 "EHLO
        mail-lf0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751763AbeBUIDy (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 21 Feb 2018 03:03:54 -0500
Received: by mail-lf0-f65.google.com with SMTP id l191so1085917lfe.1
        for <linux-block@vger.kernel.org>; Wed, 21 Feb 2018 00:03:54 -0800 (PST)
From: hans.ml.holmberg@owltronix.com
To: =?UTF-8?q?Matias=20Bj=C3=B8rling?= <mb@lightnvm.io>
Cc: =?UTF-8?q?Javier=20Gonz=C3=A1lez?= <jg@lightnvm.io>,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        Hans Holmberg <hans.holmberg@cnexlabs.com>
Subject: [PATCH 1/3] lightnvm: pblk: delete writer kick timer before stopping thread
Date: Wed, 21 Feb 2018 09:02:59 +0100
Message-Id: <1519200181-10886-2-git-send-email-hans.ml.holmberg@owltronix.com>
In-Reply-To: <1519200181-10886-1-git-send-email-hans.ml.holmberg@owltronix.com>
References: <1519200181-10886-1-git-send-email-hans.ml.holmberg@owltronix.com>
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

From: Hans Holmberg <hans.holmberg@cnexlabs.com>

Unless we delete the timer that wakes up the write thread
before we stop the thread we risk re-starting the thread, so
delete the timer first.

Signed-off-by: Hans Holmberg <hans.holmberg@cnexlabs.com>
---
 drivers/lightnvm/pblk-init.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/lightnvm/pblk-init.c b/drivers/lightnvm/pblk-init.c
index a2b54a8..862ac4e 100644
--- a/drivers/lightnvm/pblk-init.c
+++ b/drivers/lightnvm/pblk-init.c
@@ -923,9 +923,9 @@ static void pblk_writer_stop(struct pblk *pblk)
 	WARN(pblk_rb_sync_count(&pblk->rwb),
 			"Stopping not fully synced write buffer\n");
 
+	del_timer_sync(&pblk->wtimer);
 	if (pblk->writer_ts)
 		kthread_stop(pblk->writer_ts);
-	del_timer(&pblk->wtimer);
 }
 
 static void pblk_free(struct pblk *pblk)
-- 
2.7.4
