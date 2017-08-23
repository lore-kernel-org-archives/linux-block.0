Return-Path: <prvs=401b34db8=bart.vanassche@wdc.com>
From: Bart Van Assche <bart.vanassche@wdc.com>
To: Jens Axboe <axboe@kernel.dk>
Cc: linux-block@vger.kernel.org,
	Christoph Hellwig <hch@lst.de>,
	Damien Le Moal <Damien.LeMoal@wdc.com>,
	Bart Van Assche <bart.vanassche@wdc.com>,
	Hannes Reinecke <hare@suse.de>,
	Johannes Thumshirn <jthumshirn@suse.de>
Subject: [PATCH 1/5] block: Warn if blk_queue_rq_timed_out() is called for a blk-mq queue
Date: Wed, 23 Aug 2017 10:56:29 -0700
Message-Id: <20170823175633.12680-2-bart.vanassche@wdc.com>
In-Reply-To: <20170823175633.12680-1-bart.vanassche@wdc.com>
References: <20170823175633.12680-1-bart.vanassche@wdc.com>
List-ID: <linux-block@vger.kernel.org>

The timeout handler set by blk_queue_rq_timed_out() is only used
in single queue mode. Calling this function for blk-mq drivers is
wrong. Hence issue a warning if this function is called by a blk-mq
driver.

Signed-off-by: Bart Van Assche <bart.vanassche@wdc.com>
Cc: Christoph Hellwig <hch@lst.de>
Cc: Hannes Reinecke <hare@suse.de>
Cc: Johannes Thumshirn <jthumshirn@suse.de>
---
 block/blk-settings.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/block/blk-settings.c b/block/blk-settings.c
index be1f115b538b..8559e9563c52 100644
--- a/block/blk-settings.c
+++ b/block/blk-settings.c
@@ -68,6 +68,7 @@ EXPORT_SYMBOL_GPL(blk_queue_rq_timeout);
 
 void blk_queue_rq_timed_out(struct request_queue *q, rq_timed_out_fn *fn)
 {
+	WARN_ON_ONCE(q->mq_ops);
 	q->rq_timed_out_fn = fn;
 }
 EXPORT_SYMBOL_GPL(blk_queue_rq_timed_out);
-- 
2.14.0
