Return-Path: <Bart.VanAssche@sandisk.com>
From: Bart Van Assche <bart.vanassche@sandisk.com>
To: Jens Axboe <axboe@kernel.dk>
CC: <linux-block@vger.kernel.org>, Bart Van Assche
	<bart.vanassche@sandisk.com>, Omar Sandoval <osandov@fb.com>, Hannes Reinecke
	<hare@suse.com>
Subject: [PATCH 3/6] blk-mq-debugfs: Show atomic request flags
Date: Thu, 27 Apr 2017 08:54:34 -0700
Message-ID: <20170427155437.23228-4-bart.vanassche@sandisk.com>
In-Reply-To: <20170427155437.23228-1-bart.vanassche@sandisk.com>
References: <20170427155437.23228-1-bart.vanassche@sandisk.com>
MIME-Version: 1.0
Content-Type: text/plain
Return-Path: Bart.VanAssche@sandisk.com
List-ID: <linux-block@vger.kernel.org>

When analyzing e.g. queue lockups it is important to know whether
or not a request has already been started. Hence also show the
atomic request flags.

Signed-off-by: Bart Van Assche <bart.vanassche@sandisk.com>
Cc: Omar Sandoval <osandov@fb.com>
Cc: Hannes Reinecke <hare@suse.com>
---
 block/blk-mq-debugfs.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/block/blk-mq-debugfs.c b/block/blk-mq-debugfs.c
index bcd2a7d4a3a5..9cb673bc7230 100644
--- a/block/blk-mq-debugfs.c
+++ b/block/blk-mq-debugfs.c
@@ -308,6 +308,12 @@ static const char *const rqf_name[] = {
 	[ilog2((__force u32)RQF_SPECIAL_PAYLOAD)]	= "SPECIAL_PAYLOAD",
 };
 
+static const char *const rqaf_name[] = {
+	[REQ_ATOM_COMPLETE]	= "COMPLETE",
+	[REQ_ATOM_STARTED]	= "STARTED",
+	[REQ_ATOM_POLL_SLEPT]	= "POLL_SLEPT",
+};
+
 static int blk_mq_debugfs_rq_show(struct seq_file *m, void *v)
 {
 	struct request *rq = list_entry_rq(v);
@@ -325,6 +331,8 @@ static int blk_mq_debugfs_rq_show(struct seq_file *m, void *v)
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
