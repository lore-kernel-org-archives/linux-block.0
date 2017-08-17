Return-Path: <prvs=395369d0d=bart.vanassche@wdc.com>
From: Bart Van Assche <bart.vanassche@wdc.com>
To: Jens Axboe <axboe@kernel.dk>
Cc: linux-block@vger.kernel.org,
	Christoph Hellwig <hch@lst.de>,
	Bart Van Assche <bart.vanassche@wdc.com>,
	Hannes Reinecke <hare@suse.de>,
	Johannes Thumshirn <jthumshirn@suse.de>
Subject: [PATCH 02/12] block: Unexport blk_queue_end_tag()
Date: Thu, 17 Aug 2017 16:23:01 -0700
Message-Id: <20170817232311.25948-3-bart.vanassche@wdc.com>
In-Reply-To: <20170817232311.25948-1-bart.vanassche@wdc.com>
References: <20170817232311.25948-1-bart.vanassche@wdc.com>
List-ID: <linux-block@vger.kernel.org>

This function is only used inside the block layer core. Hence
unexport it.

Signed-off-by: Bart Van Assche <bart.vanassche@wdc.com>
Cc: Christoph Hellwig <hch@lst.de>
Cc: Hannes Reinecke <hare@suse.de>
Cc: Johannes Thumshirn <jthumshirn@suse.de>
---
 block/blk-tag.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/block/blk-tag.c b/block/blk-tag.c
index 2290f65b9d73..e1a9c15eb1b8 100644
--- a/block/blk-tag.c
+++ b/block/blk-tag.c
@@ -290,7 +290,6 @@ void blk_queue_end_tag(struct request_queue *q, struct request *rq)
 	 */
 	clear_bit_unlock(tag, bqt->tag_map);
 }
-EXPORT_SYMBOL(blk_queue_end_tag);
 
 /**
  * blk_queue_start_tag - find a free tag and assign it
-- 
2.14.0
