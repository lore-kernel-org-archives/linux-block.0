Return-Path: <Bart.VanAssche@sandisk.com>
From: Bart Van Assche <bart.vanassche@sandisk.com>
To: Jens Axboe <axboe@kernel.dk>
CC: <linux-block@vger.kernel.org>, Bart Van Assche
	<bart.vanassche@sandisk.com>, Hannes Reinecke <hare@suse.com>
Subject: [PATCH v3 5/8] blk-mq: Make blk_flags_show() callers append a newline character
Date: Tue, 18 Apr 2017 16:29:46 -0700
Message-ID: <20170418232949.5228-6-bart.vanassche@sandisk.com>
In-Reply-To: <20170418232949.5228-1-bart.vanassche@sandisk.com>
References: <20170418232949.5228-1-bart.vanassche@sandisk.com>
MIME-Version: 1.0
Content-Type: text/plain
Return-Path: Bart.VanAssche@sandisk.com
List-ID: <linux-block@vger.kernel.org>

This patch does not change any functionality but makes it possible
to produce a single line of output with multiple flag-to-name
translations.

Signed-off-by: Bart Van Assche <bart.vanassche@sandisk.com>
Reviewed-by: Omar Sandoval <osandov@fb.com>
Cc: Hannes Reinecke <hare@suse.com>
---
 block/blk-mq-debugfs.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/block/blk-mq-debugfs.c b/block/blk-mq-debugfs.c
index 34cac9a5fd28..27054293b37b 100644
--- a/block/blk-mq-debugfs.c
+++ b/block/blk-mq-debugfs.c
@@ -60,7 +60,6 @@ static int blk_flags_show(struct seq_file *m, const unsigned long flags,
 		else
 			seq_printf(m, "%d", i);
 	}
-	seq_puts(m, "\n");
 	return 0;
 }
 
@@ -102,6 +101,7 @@ static int blk_queue_flags_show(struct seq_file *m, void *v)
 
 	blk_flags_show(m, q->queue_flags, blk_queue_flag_name,
 		       ARRAY_SIZE(blk_queue_flag_name));
+	seq_puts(m, "\n");
 	return 0;
 }
 
@@ -190,6 +190,7 @@ static int hctx_state_show(struct seq_file *m, void *v)
 
 	blk_flags_show(m, hctx->state, hctx_state_name,
 		       ARRAY_SIZE(hctx_state_name));
+	seq_puts(m, "\n");
 	return 0;
 }
 
@@ -233,6 +234,7 @@ static int hctx_flags_show(struct seq_file *m, void *v)
 	blk_flags_show(m,
 		       hctx->flags ^ BLK_ALLOC_POLICY_TO_MQ_FLAG(alloc_policy),
 		       hctx_flag_name, ARRAY_SIZE(hctx_flag_name));
+	seq_puts(m, "\n");
 	return 0;
 }
 
-- 
2.12.2
