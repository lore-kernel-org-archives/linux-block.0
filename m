Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:56586 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751516AbdINQme (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Thu, 14 Sep 2017 12:42:34 -0400
From: Ming Lei <ming.lei@redhat.com>
To: Jens Axboe <axboe@fb.com>, linux-block@vger.kernel.org
Cc: Omar Sandoval <osandov@fb.com>, Ming Lei <ming.lei@redhat.com>
Subject: [PATCH 1/6] blk-flush: don't run queue for requests of bypassing flush
Date: Fri, 15 Sep 2017 00:42:08 +0800
Message-Id: <20170914164213.17859-2-ming.lei@redhat.com>
In-Reply-To: <20170914164213.17859-1-ming.lei@redhat.com>
References: <20170914164213.17859-1-ming.lei@redhat.com>
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

blk_insert_flush() should only insert request since run
queue always follows it.

For the case of bypassing flush, we don't need to run queue
since every blk_insert_flush() follows one run queue.

Signed-off-by: Ming Lei <ming.lei@redhat.com>
---
 block/blk-flush.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/block/blk-flush.c b/block/blk-flush.c
index 4938bec8cfef..81bd1a843043 100644
--- a/block/blk-flush.c
+++ b/block/blk-flush.c
@@ -463,7 +463,7 @@ void blk_insert_flush(struct request *rq)
 	if ((policy & REQ_FSEQ_DATA) &&
 	    !(policy & (REQ_FSEQ_PREFLUSH | REQ_FSEQ_POSTFLUSH))) {
 		if (q->mq_ops)
-			blk_mq_sched_insert_request(rq, false, true, false, false);
+			blk_mq_sched_insert_request(rq, false, false, false, false);
 		else
 			list_add_tail(&rq->queuelist, &q->queue_head);
 		return;
-- 
2.9.5
