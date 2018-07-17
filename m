Return-Path: <prvs=72995191e=bart.vanassche@wdc.com>
From: Bart Van Assche <bart.vanassche@wdc.com>
To: Jens Axboe <axboe@kernel.dk>
Cc: linux-block@vger.kernel.org,
	Christoph Hellwig <hch@lst.de>,
	Bart Van Assche <bart.vanassche@wdc.com>,
	Ming Lei <ming.lei@redhat.com>,
	Alan Stern <stern@rowland.harvard.edu>,
	Johannes Thumshirn <jthumshirn@suse.de>
Subject: [PATCH 1/3] block: Fix a comment in a header file
Date: Tue, 17 Jul 2018 16:49:38 -0700
Message-Id: <20180717234940.11231-2-bart.vanassche@wdc.com>
In-Reply-To: <20180717234940.11231-1-bart.vanassche@wdc.com>
References: <20180717234940.11231-1-bart.vanassche@wdc.com>
List-ID: <linux-block@vger.kernel.org>

Since the REQ_PREEMPT flag has been renamed into RQF_PREEMPT, update the
comment that refers to that flag.

Signed-off-by: Bart Van Assche <bart.vanassche@wdc.com>
Cc: Christoph Hellwig <hch@lst.de>
Cc: Ming Lei <ming.lei@redhat.com>
Cc: Alan Stern <stern@rowland.harvard.edu>
Cc: Johannes Thumshirn <jthumshirn@suse.de>
---
 include/linux/blkdev.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/linux/blkdev.h b/include/linux/blkdev.h
index 79226ca8f80f..e35ed66d744e 100644
--- a/include/linux/blkdev.h
+++ b/include/linux/blkdev.h
@@ -700,7 +700,7 @@ struct request_queue {
 #define QUEUE_FLAG_REGISTERED  26	/* queue has been registered to a disk */
 #define QUEUE_FLAG_SCSI_PASSTHROUGH 27	/* queue supports SCSI commands */
 #define QUEUE_FLAG_QUIESCED    28	/* queue has been quiesced */
-#define QUEUE_FLAG_PREEMPT_ONLY	29	/* only process REQ_PREEMPT requests */
+#define QUEUE_FLAG_PREEMPT_ONLY	29	/* only process RQF_PREEMPT requests */
 
 #define QUEUE_FLAG_DEFAULT	((1 << QUEUE_FLAG_IO_STAT) |		\
 				 (1 << QUEUE_FLAG_SAME_COMP)	|	\
-- 
2.18.0
