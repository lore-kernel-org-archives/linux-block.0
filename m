Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mail-lf0-f66.google.com ([209.85.215.66]:34780 "EHLO
        mail-lf0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752344AbeC2WHG (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 29 Mar 2018 18:07:06 -0400
Received: by mail-lf0-f66.google.com with SMTP id c78-v6so10370589lfh.1
        for <linux-block@vger.kernel.org>; Thu, 29 Mar 2018 15:07:06 -0700 (PDT)
From: =?UTF-8?q?Matias=20Bj=C3=B8rling?= <mb@lightnvm.io>
To: axboe@fb.com
Cc: linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        keith.busch@intel.com, javier@cnexlabs.com,
        Hans Holmberg <hans.holmberg@cnexlabs.com>,
        =?UTF-8?q?Matias=20Bj=C3=B8rling?= <mb@lightnvm.io>
Subject: [GIT PULL 09/37] lightnvm: pblk: delete writer kick timer before stopping thread
Date: Fri, 30 Mar 2018 00:04:56 +0200
Message-Id: <20180329220524.30363-10-mb@lightnvm.io>
In-Reply-To: <20180329220524.30363-1-mb@lightnvm.io>
References: <20180329220524.30363-1-mb@lightnvm.io>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

From: Hans Holmberg <hans.holmberg@cnexlabs.com>

Unless we delete the timer that wakes up the write thread
before we stop the thread we risk re-starting the thread, so
delete the timer first.

Signed-off-by: Hans Holmberg <hans.holmberg@cnexlabs.com>
Reviewed-by: Javier González <javier@cnexlabs.com>
Signed-off-by: Matias Bjørling <mb@lightnvm.io>
---
 drivers/lightnvm/pblk-init.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/lightnvm/pblk-init.c b/drivers/lightnvm/pblk-init.c
index 8416910ee8bf..49c65f1dd48b 100644
--- a/drivers/lightnvm/pblk-init.c
+++ b/drivers/lightnvm/pblk-init.c
@@ -912,9 +912,9 @@ static void pblk_writer_stop(struct pblk *pblk)
 	WARN(pblk_rb_sync_count(&pblk->rwb),
 			"Stopping not fully synced write buffer\n");
 
+	del_timer_sync(&pblk->wtimer);
 	if (pblk->writer_ts)
 		kthread_stop(pblk->writer_ts);
-	del_timer(&pblk->wtimer);
 }
 
 static void pblk_free(struct pblk *pblk)
-- 
2.11.0
