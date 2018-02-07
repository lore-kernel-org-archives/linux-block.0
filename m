Return-Path: <prvs=56915ec98=bart.vanassche@wdc.com>
From: Bart Van Assche <bart.vanassche@wdc.com>
To: Jens Axboe <axboe@kernel.dk>
Cc: linux-block@vger.kernel.org,
	Christoph Hellwig <hch@lst.de>,
	Bart Van Assche <bart.vanassche@wdc.com>,
	Tejun Heo <tj@kernel.org>
Subject: [PATCH] blk-mq-debugfs: Show more request state information
Date: Tue,  6 Feb 2018 17:15:50 -0800
Message-Id: <20180207011550.26510-1-bart.vanassche@wdc.com>
List-ID: <linux-block@vger.kernel.org>

Since commit 634f9e4631a8 ("blk-mq: remove REQ_ATOM_COMPLETE usages
from blk-mq") blk_rq_is_complete() only reports whether or not a
request has completed for legacy queues. Hence modify the
blk-mq-debugfs code such that it shows the blk-mq request state
again.

Fixes: 634f9e4631a8 ("blk-mq: remove REQ_ATOM_COMPLETE usages from blk-mq")
Signed-off-by: Bart Van Assche <bart.vanassche@wdc.com>
Cc: Tejun Heo <tj@kernel.org>
---
 block/blk-mq-debugfs.c | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/block/blk-mq-debugfs.c b/block/blk-mq-debugfs.c
index 43084d64aa41..c62a3704515b 100644
--- a/block/blk-mq-debugfs.c
+++ b/block/blk-mq-debugfs.c
@@ -294,6 +294,13 @@ static const char *const rqf_name[] = {
 };
 #undef RQF_NAME
 
+static const char *blk_mq_rq_state_name[4] = {
+	[MQ_RQ_IDLE]		= "idle",
+	[MQ_RQ_IN_FLIGHT]	= "in_flight",
+	[MQ_RQ_COMPLETE]	= "complete",
+	[3]			= "(?)",
+};
+
 int __blk_mq_debugfs_rq_show(struct seq_file *m, struct request *rq)
 {
 	const struct blk_mq_ops *const mq_ops = rq->q->mq_ops;
@@ -310,7 +317,7 @@ int __blk_mq_debugfs_rq_show(struct seq_file *m, struct request *rq)
 	seq_puts(m, ", .rq_flags=");
 	blk_flags_show(m, (__force unsigned int)rq->rq_flags, rqf_name,
 		       ARRAY_SIZE(rqf_name));
-	seq_printf(m, ", complete=%d", blk_rq_is_complete(rq));
+	seq_printf(m, ", .state=%s", blk_mq_rq_state_name[blk_mq_rq_state(rq)]);
 	seq_printf(m, ", .tag=%d, .internal_tag=%d", rq->tag,
 		   rq->internal_tag);
 	if (mq_ops->show_rq)
-- 
2.16.1
