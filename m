Return-Path: <fangwei1@huawei.com>
From: Wei Fang <fangwei1@huawei.com>
To: <axboe@kernel.dk>
CC: <linux-block@vger.kernel.org>, Wei Fang <fangwei1@huawei.com>
Subject: [PATCH] block: fix a type conversion error in __get_request()
Date: Mon, 4 Jul 2016 21:03:40 +0800
Message-ID: <1467637420-4967-1-git-send-email-fangwei1@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
List-ID: <linux-block@vger.kernel.org>

Theoretically, request only flags in enum rq_flag_bits can bigger
than 31 after we add some new flags in the future, so we can't
store REQ_IO_STAT in op_flags which is a int type in __get_request().
Actually, when REQ_IO_STAT become 31, the most-significant bit of
op_flags will be 1, and OR it to ->cmd_flags will cause the top 32
bits of ->cmd_flags become 1.

Fix it by using a u64-type object to store flags.

Signed-off-by: Wei Fang <fangwei1@huawei.com>
---
 block/blk-core.c |   11 ++++++-----
 1 files changed, 6 insertions(+), 5 deletions(-)

diff --git a/block/blk-core.c b/block/blk-core.c
index c94c7ad..3860b7d 100644
--- a/block/blk-core.c
+++ b/block/blk-core.c
@@ -1077,6 +1077,7 @@ static struct request *__get_request(struct request_list *rl, int op,
 	struct io_cq *icq = NULL;
 	const bool is_sync = rw_is_sync(op, op_flags) != 0;
 	int may_queue;
+	u64 cmd_flags = (u64)(unsigned int)op_flags;
 
 	if (unlikely(blk_queue_dying(q)))
 		return ERR_PTR(-ENODEV);
@@ -1125,7 +1126,7 @@ static struct request *__get_request(struct request_list *rl, int op,
 
 	/*
 	 * Decide whether the new request will be managed by elevator.  If
-	 * so, mark @op_flags and increment elvpriv.  Non-zero elvpriv will
+	 * so, mark @cmd_flags and increment elvpriv.  Non-zero elvpriv will
 	 * prevent the current elevator from being destroyed until the new
 	 * request is freed.  This guarantees icq's won't be destroyed and
 	 * makes creating new ones safe.
@@ -1134,14 +1135,14 @@ static struct request *__get_request(struct request_list *rl, int op,
 	 * it will be created after releasing queue_lock.
 	 */
 	if (blk_rq_should_init_elevator(bio) && !blk_queue_bypass(q)) {
-		op_flags |= REQ_ELVPRIV;
+		cmd_flags |= REQ_ELVPRIV;
 		q->nr_rqs_elvpriv++;
 		if (et->icq_cache && ioc)
 			icq = ioc_lookup_icq(ioc, q);
 	}
 
 	if (blk_queue_io_stat(q))
-		op_flags |= REQ_IO_STAT;
+		cmd_flags |= REQ_IO_STAT;
 	spin_unlock_irq(q->queue_lock);
 
 	/* allocate and init request */
@@ -1151,10 +1152,10 @@ static struct request *__get_request(struct request_list *rl, int op,
 
 	blk_rq_init(q, rq);
 	blk_rq_set_rl(rq, rl);
-	req_set_op_attrs(rq, op, op_flags | REQ_ALLOCED);
+	req_set_op_attrs(rq, op, cmd_flags | REQ_ALLOCED);
 
 	/* init elvpriv */
-	if (op_flags & REQ_ELVPRIV) {
+	if (cmd_flags & REQ_ELVPRIV) {
 		if (unlikely(et->icq_cache && !icq)) {
 			if (ioc)
 				icq = ioc_create_icq(ioc, q, gfp_mask);
-- 
1.7.1
