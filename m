Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mail-lf0-f67.google.com ([209.85.215.67]:42660 "EHLO
        mail-lf0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752640AbeC2WHk (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 29 Mar 2018 18:07:40 -0400
Received: by mail-lf0-f67.google.com with SMTP id a22-v6so10328698lfg.9
        for <linux-block@vger.kernel.org>; Thu, 29 Mar 2018 15:07:39 -0700 (PDT)
From: =?UTF-8?q?Matias=20Bj=C3=B8rling?= <mb@lightnvm.io>
To: axboe@fb.com
Cc: linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        keith.busch@intel.com, javier@cnexlabs.com,
        Dan Carpenter <dan.carpenter@oracle.com>,
        =?UTF-8?q?Matias=20Bj=C3=B8rling?= <mb@lightnvm.io>
Subject: [GIT PULL 36/37] lightnvm: pblk: remove some unnecessary NULL checks
Date: Fri, 30 Mar 2018 00:05:23 +0200
Message-Id: <20180329220524.30363-37-mb@lightnvm.io>
In-Reply-To: <20180329220524.30363-1-mb@lightnvm.io>
References: <20180329220524.30363-1-mb@lightnvm.io>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

From: Dan Carpenter <dan.carpenter@oracle.com>

Smatch complains that flush_workqueue() dereferences the work queue
pointer but then we check if it's NULL on the next line when it's too
late.  These NULL checks can be removed because the module won't load if
we can't allocate the work queues.

Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>
Signed-off-by: Matias Bjørling <mb@lightnvm.io>
---
 drivers/lightnvm/pblk-gc.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/lightnvm/pblk-gc.c b/drivers/lightnvm/pblk-gc.c
index 7143b0f740fb..6851a5c67189 100644
--- a/drivers/lightnvm/pblk-gc.c
+++ b/drivers/lightnvm/pblk-gc.c
@@ -664,12 +664,10 @@ void pblk_gc_exit(struct pblk *pblk)
 		kthread_stop(gc->gc_reader_ts);
 
 	flush_workqueue(gc->gc_reader_wq);
-	if (gc->gc_reader_wq)
-		destroy_workqueue(gc->gc_reader_wq);
+	destroy_workqueue(gc->gc_reader_wq);
 
 	flush_workqueue(gc->gc_line_reader_wq);
-	if (gc->gc_line_reader_wq)
-		destroy_workqueue(gc->gc_line_reader_wq);
+	destroy_workqueue(gc->gc_line_reader_wq);
 
 	if (gc->gc_writer_ts)
 		kthread_stop(gc->gc_writer_ts);
-- 
2.11.0
