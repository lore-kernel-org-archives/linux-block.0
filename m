Return-Path: <geliangtang@gmail.com>
Return-Path: <geliangtang@gmail.com>
From: Geliang Tang <geliangtang@gmail.com>
To: Jens Axboe <axboe@kernel.dk>
Cc: Geliang Tang <geliangtang@gmail.com>,
	linux-block@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] block: use list_entry_rq
Date: Fri, 13 Jan 2017 23:17:10 +0800
Message-Id: <5b23d0cb523f4719673a462ab1569ae99084337e.1483685419.git.geliangtang@gmail.com>
List-ID: <linux-block@vger.kernel.org>

Use list_entry_rq() instead of open-coding it.

Signed-off-by: Geliang Tang <geliangtang@gmail.com>
---
 block/blk-core.c | 4 ++--
 block/blk-mq.c   | 6 +++---
 2 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/block/blk-core.c b/block/blk-core.c
index 61ba08c..3c254d9 100644
--- a/block/blk-core.c
+++ b/block/blk-core.c
@@ -3148,8 +3148,8 @@ EXPORT_SYMBOL(blk_start_plug);
 
 static int plug_rq_cmp(void *priv, struct list_head *a, struct list_head *b)
 {
-	struct request *rqa = container_of(a, struct request, queuelist);
-	struct request *rqb = container_of(b, struct request, queuelist);
+	struct request *rqa = list_entry_rq(a);
+	struct request *rqb = list_entry_rq(b);
 
 	return !(rqa->q < rqb->q ||
 		(rqa->q == rqb->q && blk_rq_pos(rqa) < blk_rq_pos(rqb)));
diff --git a/block/blk-mq.c b/block/blk-mq.c
index a8e67a1..e24b881 100644
--- a/block/blk-mq.c
+++ b/block/blk-mq.c
@@ -553,7 +553,7 @@ static void blk_mq_requeue_work(struct work_struct *work)
 	}
 
 	while (!list_empty(&rq_list)) {
-		rq = list_entry(rq_list.next, struct request, queuelist);
+		rq = list_entry_rq(rq_list.next);
 		list_del_init(&rq->queuelist);
 		blk_mq_insert_request(rq, false, false, false);
 	}
@@ -1192,8 +1192,8 @@ static void blk_mq_insert_requests(struct request_queue *q,
 
 static int plug_ctx_cmp(void *priv, struct list_head *a, struct list_head *b)
 {
-	struct request *rqa = container_of(a, struct request, queuelist);
-	struct request *rqb = container_of(b, struct request, queuelist);
+	struct request *rqa = list_entry_rq(a);
+	struct request *rqb = list_entry_rq(b);
 
 	return !(rqa->mq_ctx < rqb->mq_ctx ||
 		 (rqa->mq_ctx == rqb->mq_ctx &&
-- 
2.9.3
