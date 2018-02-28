Return-Path: <linux-block-owner@vger.kernel.org>
Received: from esa3.hgst.iphmx.com ([216.71.153.141]:1215 "EHLO
        esa3.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933510AbeB1T20 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 28 Feb 2018 14:28:26 -0500
From: Bart Van Assche <bart.vanassche@wdc.com>
To: Jens Axboe <axboe@kernel.dk>
Cc: linux-block@vger.kernel.org, Christoph Hellwig <hch@lst.de>,
        Bart Van Assche <bart.vanassche@wdc.com>,
        Michael Lyle <mlyle@lyle.org>,
        Kent Overstreet <kent.overstreet@gmail.com>,
        Hannes Reinecke <hare@suse.de>,
        Johannes Thumshirn <jthumshirn@suse.de>,
        Ming Lei <ming.lei@redhat.com>
Subject: [PATCH 06/11] bcache: Use the blk_queue_flag_{set,clear}() functions
Date: Wed, 28 Feb 2018 11:28:18 -0800
Message-Id: <20180228192823.5191-7-bart.vanassche@wdc.com>
In-Reply-To: <20180228192823.5191-1-bart.vanassche@wdc.com>
References: <20180228192823.5191-1-bart.vanassche@wdc.com>
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

Use the blk_queue_flag_{set,clear}() functions instead of open-coding
these.

Signed-off-by: Bart Van Assche <bart.vanassche@wdc.com>
Cc: Michael Lyle <mlyle@lyle.org>
Cc: Kent Overstreet <kent.overstreet@gmail.com>
Cc: Christoph Hellwig <hch@lst.de>
Cc: Hannes Reinecke <hare@suse.de>
Cc: Johannes Thumshirn <jthumshirn@suse.de>
Cc: Ming Lei <ming.lei@redhat.com>
---
 drivers/md/bcache/super.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/md/bcache/super.c b/drivers/md/bcache/super.c
index 312895788036..047e30cb93dc 100644
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
