Return-Path: <Bart.VanAssche@sandisk.com>
From: Bart Van Assche <bart.vanassche@sandisk.com>
To: Jens Axboe <axboe@kernel.dk>
CC: <linux-block@vger.kernel.org>, Christoph Hellwig <hch@lst.de>, "Bart Van
 Assche" <bart.vanassche@sandisk.com>, Hannes Reinecke <hare@suse.com>, "Omar
 Sandoval" <osandov@fb.com>, Ming Lei <ming.lei@redhat.com>
Subject: [PATCH 5/5] blk-mq-debugfs: Add 'kick' operation
Date: Thu, 25 May 2017 16:38:10 -0700
Message-ID: <20170525233810.23211-6-bart.vanassche@sandisk.com>
In-Reply-To: <20170525233810.23211-1-bart.vanassche@sandisk.com>
References: <20170525233810.23211-1-bart.vanassche@sandisk.com>
MIME-Version: 1.0
Content-Type: text/plain
Return-Path: Bart.VanAssche@sandisk.com
List-ID: <linux-block@vger.kernel.org>

Running a queue causes the block layer to examine the per-CPU and
hw queues but not the requeue list. Hence add a 'kick' operation
that also examines the requeue list.

Signed-off-by: Bart Van Assche <bart.vanassche@sandisk.com>
Cc: Christoph Hellwig <hch@lst.de>
Cc: Hannes Reinecke <hare@suse.com>
Cc: Omar Sandoval <osandov@fb.com>
Cc: Ming Lei <ming.lei@redhat.com>
---
 block/blk-mq-debugfs.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/block/blk-mq-debugfs.c b/block/blk-mq-debugfs.c
index 70a2b955afee..89277a888800 100644
--- a/block/blk-mq-debugfs.c
+++ b/block/blk-mq-debugfs.c
@@ -114,10 +114,12 @@ static ssize_t queue_state_write(void *data, const char __user *buf,
 		blk_mq_run_hw_queues(q, true);
 	} else if (strcmp(op, "start") == 0) {
 		blk_mq_start_stopped_hw_queues(q, true);
+	} else if (strcmp(op, "kick") == 0) {
+		blk_mq_kick_requeue_list(q);
 	} else {
 		pr_err("%s: unsupported operation '%s'\n", __func__, op);
 inval:
-		pr_err("%s: use either 'run' or 'start'\n", __func__);
+		pr_err("%s: use 'run', 'start' or 'kick'\n", __func__);
 		return -EINVAL;
 	}
 	return count;
-- 
2.12.2
