Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mail-wm0-f44.google.com ([74.125.82.44]:54894 "EHLO
        mail-wm0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751883AbdJFLwj (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Fri, 6 Oct 2017 07:52:39 -0400
Received: by mail-wm0-f44.google.com with SMTP id i124so7420222wmf.3
        for <linux-block@vger.kernel.org>; Fri, 06 Oct 2017 04:52:39 -0700 (PDT)
From: "=?UTF-8?q?Javier=20Gonz=C3=A1lez?=" <jg@lightnvm.io>
To: mb@lightnvm.io
Cc: linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        =?UTF-8?q?Javier=20Gonz=C3=A1lez?= <javier@cnexlabs.com>
Subject: [PATCH 2/2] lightnvm: pblk: avoid being reported as hung on rated GC
Date: Fri,  6 Oct 2017 13:52:22 +0200
Message-Id: <1507290742-8970-3-git-send-email-javier@cnexlabs.com>
In-Reply-To: <1507290742-8970-1-git-send-email-javier@cnexlabs.com>
References: <1507290742-8970-1-git-send-email-javier@cnexlabs.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

The amount of GC I/O on the write buffer is managed by the rate-limiter,
which is calculated as a function of the number of available free
blocks. When reaching the stable point, we risk having scheduled more
I/Os for GC than are allowed on the write buffer. This would result on
the GC semaphore balancing the outstanding read GC I/Os to be reported
as "hung", though the behavior is normal.

Solve this by allowing to schedule when we detect that the read GC path
is not moving forward.

Signed-off-by: Javier González <javier@cnexlabs.com>
---
 drivers/lightnvm/pblk-gc.c | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/drivers/lightnvm/pblk-gc.c b/drivers/lightnvm/pblk-gc.c
index b8323e34d1bc..00d5698d64a9 100644
--- a/drivers/lightnvm/pblk-gc.c
+++ b/drivers/lightnvm/pblk-gc.c
@@ -218,7 +218,13 @@ static void pblk_gc_line_prepare_ws(struct work_struct *work)
 	gc_rq_ws->line = line;
 	gc_rq_ws->priv = gc_rq;
 
-	down(&gc->gc_sem);
+	/* The write GC path can be much slower than the read GC one due to
+	 * the budget imposed by the rate-limiter. Balance in case that we get
+	 * back pressure from the write GC path.
+	 */
+	while (down_timeout(&gc->gc_sem, msecs_to_jiffies(30000)))
+		io_schedule();
+
 	kref_get(&line->ref);
 
 	INIT_WORK(&gc_rq_ws->ws, pblk_gc_line_ws);
-- 
2.7.4
