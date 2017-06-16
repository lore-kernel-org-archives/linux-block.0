Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:34432 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752822AbdFPIHF (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Fri, 16 Jun 2017 04:07:05 -0400
From: Ming Lei <ming.lei@redhat.com>
To: Jens Axboe <axboe@fb.com>, linux-block@vger.kernel.org,
        Christoph Hellwig <hch@infradead.org>
Cc: Bart Van Assche <bart.vanassche@sandisk.com>,
        Ming Lei <ming.lei@redhat.com>
Subject: [PATCH] blk-tag: not touch rq->internal_tag
Date: Fri, 16 Jun 2017 16:06:55 +0800
Message-Id: <20170616080655.23838-1-ming.lei@redhat.com>
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

rq->internal_tag is introduced only for blk-mq, so
it isn't necessary to touch this variable in blk-tag.

Signed-off-by: Ming Lei <ming.lei@redhat.com>
---
 block/blk-tag.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/block/blk-tag.c b/block/blk-tag.c
index 07cc329fa4b0..bae1decb6ec3 100644
--- a/block/blk-tag.c
+++ b/block/blk-tag.c
@@ -272,7 +272,6 @@ void blk_queue_end_tag(struct request_queue *q, struct request *rq)
 	list_del_init(&rq->queuelist);
 	rq->rq_flags &= ~RQF_QUEUED;
 	rq->tag = -1;
-	rq->internal_tag = -1;
 
 	if (unlikely(bqt->tag_index[tag] == NULL))
 		printk(KERN_ERR "%s: tag %d is missing\n",
-- 
2.9.4
