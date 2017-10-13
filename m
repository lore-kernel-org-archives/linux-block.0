Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mail-wm0-f67.google.com ([74.125.82.67]:49065 "EHLO
        mail-wm0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932548AbdJMMsB (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 13 Oct 2017 08:48:01 -0400
Received: by mail-wm0-f67.google.com with SMTP id i124so21107809wmf.3
        for <linux-block@vger.kernel.org>; Fri, 13 Oct 2017 05:48:00 -0700 (PDT)
From: =?UTF-8?q?Matias=20Bj=C3=B8rling?= <m@bjorling.me>
To: axboe@fb.com
Cc: linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        =?UTF-8?q?Javier=20Gonz=C3=A1lez?= <javier@cnexlabs.com>,
        =?UTF-8?q?Matias=20Bj=C3=B8rling?= <m@bjorling.me>
Subject: [GIT PULL 56/58] lightnvm: pblk: avoid being reported as hung on rated GC
Date: Fri, 13 Oct 2017 14:46:45 +0200
Message-Id: <20171013124647.32668-57-m@bjorling.me>
In-Reply-To: <20171013124647.32668-1-m@bjorling.me>
References: <20171013124647.32668-1-m@bjorling.me>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

From: Javier González <javier@cnexlabs.com>

The amount of GC I/O on the write buffer is managed by the rate-limiter,
which is calculated as a function of the number of available free
blocks. When reaching the stable point, we risk having scheduled more
I/Os for GC than are allowed on the write buffer. This would result on
the GC semaphore balancing the outstanding read GC I/Os to be reported
as "hung", though the behavior is normal.

Solve this by allowing to schedule when we detect that the read GC path
is not moving forward.

Signed-off-by: Javier González <javier@cnexlabs.com>
Signed-off-by: Matias Bjørling <m@bjorling.me>
---
 drivers/lightnvm/pblk-gc.c | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/drivers/lightnvm/pblk-gc.c b/drivers/lightnvm/pblk-gc.c
index b8323e3..00d5698 100644
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
2.9.3
