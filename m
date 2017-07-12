Return-Path: <linux-block-owner@vger.kernel.org>
Received: from 22.17.110.36.static.bjtelecom.net ([36.110.17.22]:32220 "EHLO
        BJEXMBX011.didichuxing.com" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1753860AbdGLQyN (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 12 Jul 2017 12:54:13 -0400
Date: Thu, 13 Jul 2017 00:54:00 +0800
From: weiping zhang <zhangweiping@didichuxing.com>
To: <axboe@kernel.dk>
CC: <linux-block@vger.kernel.org>
Subject: [PATCH] blk-mq-debugfs: add mapping show for hw queue to cpu
Message-ID: <20170712165400.GA9696@localhost.didichuxing.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

A mapping show as following:

hctx		cpus
hctx0		  0   1
hctx1		  2
hctx2		  3
hctx3		  4   5

Signed-off-by: weiping zhang <zhangweiping@didichuxing.com>
---
 block/blk-mq-debugfs.c | 18 ++++++++++++++++++
 1 file changed, 18 insertions(+)

diff --git a/block/blk-mq-debugfs.c b/block/blk-mq-debugfs.c
index 9ebc294..a311d5a 100644
--- a/block/blk-mq-debugfs.c
+++ b/block/blk-mq-debugfs.c
@@ -175,6 +175,23 @@ static int queue_poll_stat_show(void *data, struct seq_file *m)
 	return 0;
 }
 
+static int queue_mapping_show(void *data, struct seq_file *m)
+{
+       struct request_queue *q = data;
+       struct blk_mq_hw_ctx *hctx;
+       struct blk_mq_ctx *ctx;
+       int i, j;
+
+       seq_puts(m, "hctx\t\tcpus\n");
+       queue_for_each_hw_ctx(q, hctx, i) {
+               seq_printf(m, "hctx%u\t\t", hctx->queue_num);
+               hctx_for_each_ctx(hctx, ctx, j)
+                       seq_printf(m, "%3u ", ctx->cpu);
+               seq_puts(m, "\n");
+       }
+       return 0;
+}
+
 #define HCTX_STATE_NAME(name) [BLK_MQ_S_##name] = #name
 static const char *const hctx_state_name[] = {
 	HCTX_STATE_NAME(STOPPED),
@@ -754,6 +771,7 @@ static const struct blk_mq_debugfs_attr blk_mq_debugfs_queue_attrs[] = {
 	{"requeue_list", 0400, .seq_ops = &queue_requeue_list_seq_ops},
 	{"state", 0600, queue_state_show, queue_state_write},
 	{"write_hints", 0600, queue_write_hint_show, queue_write_hint_store},
+	{"mapping", 0400, queue_mapping_show},
 	{},
 };
 
-- 
2.9.4
