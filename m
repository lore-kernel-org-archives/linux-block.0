Return-Path: <Bart.VanAssche@sandisk.com>
From: Bart Van Assche <bart.vanassche@sandisk.com>
To: Jens Axboe <axboe@kernel.dk>
CC: <linux-block@vger.kernel.org>, Bart Van Assche
	<bart.vanassche@sandisk.com>, Omar Sandoval <osandov@fb.com>, Hannes Reinecke
	<hare@suse.com>
Subject: [PATCH 2/6] blk-mq: Move the "state" debugfs attribute one level down
Date: Tue, 11 Apr 2017 13:58:38 -0700
Message-ID: <20170411205842.28137-3-bart.vanassche@sandisk.com>
In-Reply-To: <20170411205842.28137-1-bart.vanassche@sandisk.com>
References: <20170411205842.28137-1-bart.vanassche@sandisk.com>
MIME-Version: 1.0
Content-Type: text/plain
Return-Path: Bart.VanAssche@sandisk.com
List-ID: <linux-block@vger.kernel.org>

Move the "state" attribute from the top level to the "mq" directory
as requested by Omar.

Signed-off-by: Bart Van Assche <bart.vanassche@sandisk.com>
Cc: Omar Sandoval <osandov@fb.com>
Cc: Hannes Reinecke <hare@suse.com>
---
 block/blk-mq-debugfs.c | 9 +--------
 1 file changed, 1 insertion(+), 8 deletions(-)

diff --git a/block/blk-mq-debugfs.c b/block/blk-mq-debugfs.c
index a1ce823578c7..564470d4af52 100644
--- a/block/blk-mq-debugfs.c
+++ b/block/blk-mq-debugfs.c
@@ -149,11 +149,6 @@ static const struct file_operations blk_queue_flags_fops = {
 	.write		= blk_queue_flags_store,
 };
 
-static const struct blk_mq_debugfs_attr blk_queue_attrs[] = {
-	{"state", 0600, &blk_queue_flags_fops},
-	{},
-};
-
 static void print_stat(struct seq_file *m, struct blk_rq_stat *stat)
 {
 	if (stat->nr_samples) {
@@ -762,6 +757,7 @@ static const struct file_operations ctx_completed_fops = {
 
 static const struct blk_mq_debugfs_attr blk_mq_debugfs_queue_attrs[] = {
 	{"poll_stat", 0400, &queue_poll_stat_fops},
+	{"state", 0600, &blk_queue_flags_fops},
 	{},
 };
 
@@ -877,9 +873,6 @@ int blk_mq_debugfs_register_hctxs(struct request_queue *q)
 	if (!q->debugfs_dir)
 		return -ENOENT;
 
-	if (!debugfs_create_files(q->debugfs_dir, q, blk_queue_attrs))
-		goto err;
-
 	q->mq_debugfs_dir = debugfs_create_dir("mq", q->debugfs_dir);
 	if (!q->mq_debugfs_dir)
 		goto err;
-- 
2.12.0
