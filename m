Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mail-co1nam03on0089.outbound.protection.outlook.com ([104.47.40.89]:19668
        "EHLO NAM03-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S933093AbcIZCyt (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Sun, 25 Sep 2016 22:54:49 -0400
To: Jens Axboe <axboe@fb.com>
CC: "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
From: Bart Van Assche <bart.vanassche@sandisk.com>
Subject: [PATCH] bsg: Add sparse annotations to bsg_request_fn()
Message-ID: <6dfb1793-ca6a-c3b6-b3fc-272e68ca6880@sandisk.com>
Date: Sun, 25 Sep 2016 19:54:38 -0700
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

Avoid that sparse complains about unbalanced lock actions.

Signed-off-by: Bart Van Assche <bart.vanassche@sandisk.com>
---
 block/bsg-lib.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/block/bsg-lib.c b/block/bsg-lib.c
index 650f427..b2a61e3 100644
--- a/block/bsg-lib.c
+++ b/block/bsg-lib.c
@@ -161,6 +161,8 @@ failjob_rls_job:
  * Drivers/subsys should pass this to the queue init function.
  */
 void bsg_request_fn(struct request_queue *q)
+	__releases(q->queue_lock)
+	__acquires(q->queue_lock)
 {
 	struct device *dev = q->queuedata;
 	struct request *req;
-- 
2.10.0

