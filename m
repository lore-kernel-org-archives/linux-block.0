Return-Path: <Bart.VanAssche@sandisk.com>
From: Bart Van Assche <bart.vanassche@sandisk.com>
To: Jens Axboe <axboe@kernel.dk>
CC: <linux-block@vger.kernel.org>, Bart Van Assche
	<bart.vanassche@sandisk.com>, Omar Sandoval <osandov@fb.com>
Subject: [PATCH 2/4] blk-mq-debug: Avoid that sparse complains about req_flags_t usage
Date: Wed, 1 Feb 2017 10:20:57 -0800
Message-ID: <20170201182059.25601-3-bart.vanassche@sandisk.com>
In-Reply-To: <20170201182059.25601-1-bart.vanassche@sandisk.com>
References: <20170201182059.25601-1-bart.vanassche@sandisk.com>
MIME-Version: 1.0
Content-Type: text/plain
Return-Path: Bart.VanAssche@sandisk.com
List-ID: <linux-block@vger.kernel.org>

Avoid that sparse reports the following complaints:

block/elevator.c:541:29: warning: incorrect type in assignment (different base types)
block/elevator.c:541:29:    expected bool [unsigned] [usertype] next_sorted
block/elevator.c:541:29:    got restricted req_flags_t

block/blk-mq-debugfs.c:92:54: warning: cast from restricted req_flags_t

Signed-off-by: Bart Van Assche <bart.vanassche@sandisk.com>
Cc: Omar Sandoval <osandov@fb.com>
---
 block/blk-mq-debugfs.c | 3 ++-
 block/elevator.c       | 2 +-
 2 files changed, 3 insertions(+), 2 deletions(-)

diff --git a/block/blk-mq-debugfs.c b/block/blk-mq-debugfs.c
index 7bcd4b6edf83..aece9116b4f6 100644
--- a/block/blk-mq-debugfs.c
+++ b/block/blk-mq-debugfs.c
@@ -89,7 +89,8 @@ static int blk_mq_debugfs_rq_show(struct seq_file *m, void *v)
 	struct request *rq = list_entry_rq(v);
 
 	seq_printf(m, "%p {.cmd_type=%u, .cmd_flags=0x%x, .rq_flags=0x%x, .tag=%d, .internal_tag=%d}\n",
-		   rq, rq->cmd_type, rq->cmd_flags, (unsigned int)rq->rq_flags,
+		   rq, rq->cmd_type, rq->cmd_flags,
+		   (__force unsigned int)rq->rq_flags,
 		   rq->tag, rq->internal_tag);
 	return 0;
 }
diff --git a/block/elevator.c b/block/elevator.c
index ef7f59469acc..9138efeee0c8 100644
--- a/block/elevator.c
+++ b/block/elevator.c
@@ -538,7 +538,7 @@ void elv_merge_requests(struct request_queue *q, struct request *rq,
 	if (e->uses_mq && e->type->ops.mq.requests_merged)
 		e->type->ops.mq.requests_merged(q, rq, next);
 	else if (e->type->ops.sq.elevator_merge_req_fn) {
-		next_sorted = next->rq_flags & RQF_SORTED;
+		next_sorted = (__force bool)(next->rq_flags & RQF_SORTED);
 		if (next_sorted)
 			e->type->ops.sq.elevator_merge_req_fn(q, rq, next);
 	}
-- 
2.11.0
