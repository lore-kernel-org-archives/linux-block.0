Return-Path: <Bart.VanAssche@sandisk.com>
From: Bart Van Assche <bart.vanassche@sandisk.com>
To: Jens Axboe <axboe@kernel.dk>
CC: <linux-block@vger.kernel.org>, Christoph Hellwig <hch@lst.de>, "Bart Van
 Assche" <bart.vanassche@sandisk.com>, Omar Sandoval <osandov@fb.com>, Ming
 Lei <ming.lei@redhat.com>
Subject: [PATCH v2 1/4] blk-mq-debugfs: Show atomic request flags
Date: Wed, 31 May 2017 14:30:47 -0700
Message-ID: <20170531213050.30276-2-bart.vanassche@sandisk.com>
In-Reply-To: <20170531213050.30276-1-bart.vanassche@sandisk.com>
References: <20170531213050.30276-1-bart.vanassche@sandisk.com>
MIME-Version: 1.0
Content-Type: text/plain
Return-Path: Bart.VanAssche@sandisk.com
List-ID: <linux-block@vger.kernel.org>

When analyzing e.g. queue lockups it is important to know whether
or not a request has already been started. Hence also show the
atomic request flags.

Signed-off-by: Bart Van Assche <bart.vanassche@sandisk.com>
Reviewed-by: Hannes Reinecke <hare@suse.com>
Cc: Omar Sandoval <osandov@fb.com>
Cc: Christoph Hellwig <hch@lst.de>
Cc: Ming Lei <ming.lei@redhat.com>
---
 block/blk-mq-debugfs.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/block/blk-mq-debugfs.c b/block/blk-mq-debugfs.c
index 803aed4d7221..d56ddd7a1285 100644
--- a/block/blk-mq-debugfs.c
+++ b/block/blk-mq-debugfs.c
@@ -267,6 +267,14 @@ static const char *const rqf_name[] = {
 };
 #undef RQF_NAME
 
+#define RQAF_NAME(name) [REQ_ATOM_##name] = #name
+static const char *const rqaf_name[] = {
+	RQAF_NAME(COMPLETE),
+	RQAF_NAME(STARTED),
+	RQAF_NAME(POLL_SLEPT),
+};
+#undef RQAF_NAME
+
 int __blk_mq_debugfs_rq_show(struct seq_file *m, struct request *rq)
 {
 	const struct blk_mq_ops *const mq_ops = rq->q->mq_ops;
@@ -283,6 +291,8 @@ int __blk_mq_debugfs_rq_show(struct seq_file *m, struct request *rq)
 	seq_puts(m, ", .rq_flags=");
 	blk_flags_show(m, (__force unsigned int)rq->rq_flags, rqf_name,
 		       ARRAY_SIZE(rqf_name));
+	seq_puts(m, ", .atomic_flags=");
+	blk_flags_show(m, rq->atomic_flags, rqaf_name, ARRAY_SIZE(rqaf_name));
 	seq_printf(m, ", .tag=%d, .internal_tag=%d", rq->tag,
 		   rq->internal_tag);
 	if (mq_ops->show_rq)
-- 
2.12.2
