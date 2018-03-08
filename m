Return-Path: <prvs=5980fa318=bart.vanassche@wdc.com>
From: Bart Van Assche <bart.vanassche@wdc.com>
To: Jens Axboe <axboe@kernel.dk>
Cc: linux-block@vger.kernel.org,
	Christoph Hellwig <hch@lst.de>,
	Bart Van Assche <bart.vanassche@wdc.com>,
	Kent Overstreet <kent.overstreet@gmail.com>,
	Hannes Reinecke <hare@suse.de>,
	Ming Lei <ming.lei@redhat.com>
Subject: [PATCH v2 06/11] bcache: Use the blk_queue_flag_{set,clear}() functions
Date: Wed,  7 Mar 2018 17:10:07 -0800
Message-Id: <20180308011012.31522-7-bart.vanassche@wdc.com>
In-Reply-To: <20180308011012.31522-1-bart.vanassche@wdc.com>
References: <20180308011012.31522-1-bart.vanassche@wdc.com>
List-ID: <linux-block@vger.kernel.org>

Use the blk_queue_flag_{set,clear}() functions instead of open-coding
these.

Signed-off-by: Bart Van Assche <bart.vanassche@wdc.com>
Reviewed-by: Michael Lyle <mlyle@lyle.org>
Reviewed-by: Johannes Thumshirn <jthumshirn@suse.de>
Reviewed-by: Martin K. Petersen <martin.petersen@oracle.com>
Cc: Kent Overstreet <kent.overstreet@gmail.com>
Cc: Christoph Hellwig <hch@lst.de>
Cc: Hannes Reinecke <hare@suse.de>
Cc: Ming Lei <ming.lei@redhat.com>
---
 drivers/md/bcache/super.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/md/bcache/super.c b/drivers/md/bcache/super.c
index 4d1d8dfb2d2a..e8dfa804bd98 100644
--- a/drivers/md/bcache/super.c
+++ b/drivers/md/bcache/super.c
@@ -833,9 +833,9 @@ static int bcache_device_init(struct bcache_device *d, unsigned block_size,
 	q->limits.io_min		= block_size;
 	q->limits.logical_block_size	= block_size;
 	q->limits.physical_block_size	= block_size;
-	set_bit(QUEUE_FLAG_NONROT,	&d->disk->queue->queue_flags);
-	clear_bit(QUEUE_FLAG_ADD_RANDOM, &d->disk->queue->queue_flags);
-	set_bit(QUEUE_FLAG_DISCARD,	&d->disk->queue->queue_flags);
+	blk_queue_flag_set(QUEUE_FLAG_NONROT, d->disk->queue);
+	blk_queue_flag_clear(QUEUE_FLAG_ADD_RANDOM, d->disk->queue);
+	blk_queue_flag_set(QUEUE_FLAG_DISCARD, d->disk->queue);
 
 	blk_queue_write_cache(q, true, true);
 
-- 
2.16.2
