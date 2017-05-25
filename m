Return-Path: <Bart.VanAssche@sandisk.com>
From: Bart Van Assche <bart.vanassche@sandisk.com>
To: Jens Axboe <axboe@kernel.dk>
CC: <linux-block@vger.kernel.org>, Christoph Hellwig <hch@lst.de>, "Bart Van
 Assche" <bart.vanassche@sandisk.com>, Hannes Reinecke <hare@suse.com>, "Omar
 Sandoval" <osandov@fb.com>, Ming Lei <ming.lei@redhat.com>
Subject: [PATCH 4/5] blk-mq-debugfs: Show busy requests
Date: Thu, 25 May 2017 16:38:09 -0700
Message-ID: <20170525233810.23211-5-bart.vanassche@sandisk.com>
In-Reply-To: <20170525233810.23211-1-bart.vanassche@sandisk.com>
References: <20170525233810.23211-1-bart.vanassche@sandisk.com>
MIME-Version: 1.0
Content-Type: text/plain
Return-Path: Bart.VanAssche@sandisk.com
List-ID: <linux-block@vger.kernel.org>

Requests that got stuck in a block driver are neither on
blk_mq_ctx.rq_list nor on any hw dispatch queue. Make these
visible in debugfs through the "busy" attribute.

Signed-off-by: Bart Van Assche <bart.vanassche@sandisk.com>
Cc: Christoph Hellwig <hch@lst.de>
Cc: Hannes Reinecke <hare@suse.com>
Cc: Omar Sandoval <osandov@fb.com>
Cc: Ming Lei <ming.lei@redhat.com>
---
 block/blk-mq-debugfs.c | 25 +++++++++++++++++++++++++
 1 file changed, 25 insertions(+)

diff --git a/block/blk-mq-debugfs.c b/block/blk-mq-debugfs.c
index 8b06a12c1461..70a2b955afee 100644
--- a/block/blk-mq-debugfs.c
+++ b/block/blk-mq-debugfs.c
@@ -370,6 +370,30 @@ static const struct seq_operations hctx_dispatch_seq_ops = {
 	.show	= blk_mq_debugfs_rq_show,
 };
 
+struct show_busy_ctx {
+	struct seq_file		*m;
+	struct blk_mq_hw_ctx	*hctx;
+};
+
+static void hctx_show_busy(struct request *rq, void *data, bool reserved)
+{
+	const struct show_busy_ctx *ctx = data;
+
+	if (blk_mq_map_queue(rq->q, rq->mq_ctx->cpu) == ctx->hctx &&
+	    test_bit(REQ_ATOM_STARTED, &rq->atomic_flags))
+		blk_mq_debugfs_rq_show(ctx->m, &rq->queuelist);
+}
+
+static int hctx_busy_show(void *data, struct seq_file *m)
+{
+	struct blk_mq_hw_ctx *hctx = data;
+	struct show_busy_ctx ctx = { .m = m, .hctx = hctx };
+
+	blk_mq_tagset_busy_iter(hctx->queue->tag_set, hctx_show_busy, &ctx);
+
+	return 0;
+}
+
 static int hctx_ctx_map_show(void *data, struct seq_file *m)
 {
 	struct blk_mq_hw_ctx *hctx = data;
@@ -705,6 +729,7 @@ static const struct blk_mq_debugfs_attr blk_mq_debugfs_hctx_attrs[] = {
 	{"state", 0400, hctx_state_show},
 	{"flags", 0400, hctx_flags_show},
 	{"dispatch", 0400, .seq_ops = &hctx_dispatch_seq_ops},
+	{"busy", 0400, hctx_busy_show},
 	{"ctx_map", 0400, hctx_ctx_map_show},
 	{"tags", 0400, hctx_tags_show},
 	{"tags_bitmap", 0400, hctx_tags_bitmap_show},
-- 
2.12.2
