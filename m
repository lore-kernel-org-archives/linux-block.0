Return-Path: <jianchao.w.wang@oracle.com>
From: Jianchao Wang <jianchao.w.wang@oracle.com>
To: axboe@kernel.dk
Cc: linux-block@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] blk-mq: add plug trace event for multiple hw queues case
Date: Tue, 22 May 2018 15:08:10 +0800
Message-Id: <1526972890-1878-1-git-send-email-jianchao.w.wang@oracle.com>
List-ID: <linux-block@vger.kernel.org>

There is no plug trace event for multiple hw queues. This is
confusing when check block trace event log and find unplug one
there. Add plug trace event when request is added to a empty plug
list.

Signed-off-by: Jianchao Wang <jianchao.w.wang@oracle.com>
---
 block/blk-mq.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/block/blk-mq.c b/block/blk-mq.c
index 9ce9cac..ddf726a 100644
--- a/block/blk-mq.c
+++ b/block/blk-mq.c
@@ -1935,6 +1935,9 @@ static blk_qc_t blk_mq_make_request(struct request_queue *q, struct bio *bio)
 			same_queue_rq = NULL;
 		if (same_queue_rq)
 			list_del_init(&same_queue_rq->queuelist);
+		else
+			trace_block_plug(q);
+
 		list_add_tail(&rq->queuelist, &plug->mq_list);
 
 		blk_mq_put_ctx(data.ctx);
-- 
2.7.4
