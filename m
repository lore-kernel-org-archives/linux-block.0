Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:60028 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751257AbdIPDGv (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Fri, 15 Sep 2017 23:06:51 -0400
From: Ming Lei <ming.lei@redhat.com>
To: Jens Axboe <axboe@fb.com>, linux-block@vger.kernel.org
Cc: Omar Sandoval <osandov@fb.com>, Ming Lei <ming.lei@redhat.com>
Subject: [PATCH V2 7/7] blk-mq-sched: warning on inserting a req with driver tag allocated
Date: Sat, 16 Sep 2017 11:03:51 +0800
Message-Id: <20170916030351.28019-9-ming.lei@redhat.com>
In-Reply-To: <20170916030351.28019-1-ming.lei@redhat.com>
References: <20170916030351.28019-1-ming.lei@redhat.com>
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

In case of IO scheduler, any request shouldn't have a tag
assigned before dispatching, so add the warning to monitor
possible bug.

Signed-off-by: Ming Lei <ming.lei@redhat.com>
---
 block/blk-mq-sched.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/block/blk-mq-sched.c b/block/blk-mq-sched.c
index c2ea8c2b896b..b6934a9424ff 100644
--- a/block/blk-mq-sched.c
+++ b/block/blk-mq-sched.c
@@ -271,10 +271,8 @@ static bool blk_mq_sched_bypass_insert(struct blk_mq_hw_ctx *hctx,
 		return true;
 	}
 
-	if (has_sched) {
+	if (has_sched)
 		rq->rq_flags |= RQF_SORTED;
-		WARN_ON(rq->tag != -1);
-	}
 
 	return false;
 }
@@ -355,6 +353,8 @@ void blk_mq_sched_insert_request(struct request *rq, bool at_head,
 		goto run;
 	}
 
+	WARN_ON(e && (rq->tag != -1));
+
 	if (blk_mq_sched_bypass_insert(hctx, !!e, rq))
 		goto run;
 
-- 
2.9.5
