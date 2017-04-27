Return-Path: <Bart.VanAssche@sandisk.com>
From: Bart Van Assche <bart.vanassche@sandisk.com>
To: Jens Axboe <axboe@kernel.dk>
CC: <linux-block@vger.kernel.org>, Bart Van Assche
	<bart.vanassche@sandisk.com>, Omar Sandoval <osandov@fb.com>, Hannes Reinecke
	<hare@suse.com>
Subject: [PATCH 5/6] blk-mq-debugfs: Show busy requests
Date: Thu, 27 Apr 2017 08:54:36 -0700
Message-ID: <20170427155437.23228-6-bart.vanassche@sandisk.com>
In-Reply-To: <20170427155437.23228-1-bart.vanassche@sandisk.com>
References: <20170427155437.23228-1-bart.vanassche@sandisk.com>
MIME-Version: 1.0
Content-Type: text/plain
Return-Path: Bart.VanAssche@sandisk.com
List-ID: <linux-block@vger.kernel.org>

Requests that got stuck in a block driver are neither on
blk_mq_ctx.rq_list nor on any hw dispatch queue. Make these
visible in debugfs through the "busy" attribute.

Signed-off-by: Bart Van Assche <bart.vanassche@sandisk.com>
Cc: Omar Sandoval <osandov@fb.com>
Cc: Hannes Reinecke <hare@suse.com>
---
 block/blk-mq-debugfs.c | 38 ++++++++++++++++++++++++++++++++++++++
 1 file changed, 38 insertions(+)

diff --git a/block/blk-mq-debugfs.c b/block/blk-mq-debugfs.c
index 5092d90e37f6..a5e286e04569 100644
--- a/block/blk-mq-debugfs.c
+++ b/block/blk-mq-debugfs.c
@@ -428,6 +428,43 @@ static const struct file_operations hctx_dispatch_fops = {
 	.release	= seq_release,
 };
 
+struct show_busy_ctx {
+	struct seq_file		*m;
+	struct blk_mq_hw_ctx	*hctx;
+};
+
+static void hctx_show_busy(struct request *rq, void *data, bool reserved)
+{
+	const struct show_busy_ctx *ctx = data;
+	struct request_queue *q = rq->q;
+
+	if (q->queue_hw_ctx[rq->mq_ctx->index_hw] == ctx->hctx &&
+	    test_bit(REQ_ATOM_STARTED, &rq->atomic_flags))
+		blk_mq_debugfs_rq_show(ctx->m, &rq->queuelist);
+}
+
+static int hctx_busy_show(struct seq_file *m, void *v)
+{
+	struct blk_mq_hw_ctx *hctx = m->private;
+	struct show_busy_ctx ctx = { .m = m, .hctx = hctx };
+
+	blk_mq_tagset_busy_iter(hctx->queue->tag_set, hctx_show_busy, &ctx);
+
+	return 0;
+}
+
+static int hctx_busy_open(struct inode *inode, struct file *file)
+{
+	return single_open(file, hctx_busy_show, inode->i_private);
+}
+
+static const struct file_operations hctx_busy_fops = {
+	.open		= hctx_busy_open,
+	.read		= seq_read,
+	.llseek		= seq_lseek,
+	.release	= single_release,
+};
+
 static int hctx_ctx_map_show(struct seq_file *m, void *v)
 {
 	struct blk_mq_hw_ctx *hctx = m->private;
@@ -885,6 +922,7 @@ static const struct blk_mq_debugfs_attr blk_mq_debugfs_hctx_attrs[] = {
 	{"state", 0400, &hctx_state_fops},
 	{"flags", 0400, &hctx_flags_fops},
 	{"dispatch", 0400, &hctx_dispatch_fops},
+	{"busy", 0400, &hctx_busy_fops},
 	{"ctx_map", 0400, &hctx_ctx_map_fops},
 	{"tags", 0400, &hctx_tags_fops},
 	{"tags_bitmap", 0400, &hctx_tags_bitmap_fops},
-- 
2.12.2
