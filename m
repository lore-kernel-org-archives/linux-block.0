Return-Path: <Bart.VanAssche@sandisk.com>
From: Bart Van Assche <bart.vanassche@sandisk.com>
To: Jens Axboe <axboe@kernel.dk>
CC: <linux-block@vger.kernel.org>, Christoph Hellwig <hch@lst.de>, "Bart Van
 Assche" <bart.vanassche@sandisk.com>, Omar Sandoval <osandov@fb.com>, "Hannes
 Reinecke" <hare@suse.com>, Ming Lei <ming.lei@redhat.com>
Subject: [PATCH 1/5] blk-mq: Only register debugfs attributes for blk-mq queues
Date: Thu, 25 May 2017 16:38:06 -0700
Message-ID: <20170525233810.23211-2-bart.vanassche@sandisk.com>
In-Reply-To: <20170525233810.23211-1-bart.vanassche@sandisk.com>
References: <20170525233810.23211-1-bart.vanassche@sandisk.com>
MIME-Version: 1.0
Content-Type: text/plain
Return-Path: Bart.VanAssche@sandisk.com
List-ID: <linux-block@vger.kernel.org>

The code in blk-mq-debugfs.c assumes that it is working on a blk-mq
queue and is not intended to work on a blk-sq queue. Hence only
register blk-mq debugfs attributes for blk-mq queues.

Fixes: commit 9c1051aacde8 ("blk-mq: untangle debugfs and sysfs")
Signed-off-by: Bart Van Assche <bart.vanassche@sandisk.com>
Cc: Omar Sandoval <osandov@fb.com>
Cc: Christoph Hellwig <hch@lst.de>
Cc: Hannes Reinecke <hare@suse.com>
Cc: Ming Lei <ming.lei@redhat.com>
---
 block/blk-sysfs.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/block/blk-sysfs.c b/block/blk-sysfs.c
index 5e7b3924996c..0494baa743a3 100644
--- a/block/blk-sysfs.c
+++ b/block/blk-sysfs.c
@@ -888,10 +888,10 @@ int blk_register_queue(struct gendisk *disk)
 		goto unlock;
 	}
 
-	if (q->mq_ops)
+	if (q->mq_ops) {
 		__blk_mq_register_dev(dev, q);
-
-	blk_mq_debugfs_register(q);
+		blk_mq_debugfs_register(q);
+	}
 
 	kobject_uevent(&q->kobj, KOBJ_ADD);
 
-- 
2.12.2
