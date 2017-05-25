Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:45540 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S941653AbdEYEV4 (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Thu, 25 May 2017 00:21:56 -0400
From: Ming Lei <ming.lei@redhat.com>
To: Jens Axboe <axboe@fb.com>, linux-block@vger.kernel.org,
        Christoph Hellwig <hch@infradead.org>
Cc: Bart Van Assche <bart.vanassche@sandisk.com>
Subject: [PATCH 3/7] dm: use the introduced blk_mq_unquiesce_queue()
Date: Thu, 25 May 2017 12:21:27 +0800
Message-Id: <20170525042131.13172-4-ming.lei@redhat.com>
In-Reply-To: <20170525042131.13172-1-ming.lei@redhat.com>
References: <20170525042131.13172-1-ming.lei@redhat.com>
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

blk_mq_unquiesce_queue() is used for unquiescing the queue.

Signed-off-by: Ming Lei <ming.lei@redhat.com>
---
 drivers/md/dm-rq.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/md/dm-rq.c b/drivers/md/dm-rq.c
index 2af27026aa2e..673fcf075077 100644
--- a/drivers/md/dm-rq.c
+++ b/drivers/md/dm-rq.c
@@ -71,7 +71,7 @@ static void dm_old_start_queue(struct request_queue *q)
 
 static void dm_mq_start_queue(struct request_queue *q)
 {
-	blk_mq_start_stopped_hw_queues(q, true);
+	blk_mq_unquiesce_queue(q);
 	blk_mq_kick_requeue_list(q);
 }
 
-- 
2.9.4
