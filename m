Return-Path: <Bart.VanAssche@wdc.com>
From: Bart Van Assche <bart.vanassche@wdc.com>
To: Jens Axboe <axboe@kernel.dk>
CC: <linux-block@vger.kernel.org>, Christoph Hellwig <hch@lst.de>, "Bart Van
 Assche" <bart.vanassche@wdc.com>, Bart Van Assche
	<bart.vanassche@sandisk.com>, Hannes Reinecke <hare@suse.com>, Omar Sandoval
	<osandov@fb.com>, Ming Lei <ming.lei@redhat.com>
Subject: [PATCH v5 06/12] blk-mq: Initialize .rq_flags in blk_mq_rq_ctx_init()
Date: Tue, 20 Jun 2017 11:15:43 -0700
Message-ID: <20170620181549.24903-7-bart.vanassche@wdc.com>
In-Reply-To: <20170620181549.24903-1-bart.vanassche@wdc.com>
References: <20170620181549.24903-1-bart.vanassche@wdc.com>
MIME-Version: 1.0
Content-Type: text/plain
Return-Path: Bart.VanAssche@wdc.com
List-ID: <linux-block@vger.kernel.org>

From: Bart Van Assche <bart.vanassche@sandisk.com>

Initialization of blk-mq requests is a bit weird: blk_mq_rq_ctx_init()
is called after a value has been assigned to .rq_flags and .rq_flags
is initialized in __blk_mq_finish_request(). Initialize .rq_flags in
blk_mq_rq_ctx_init() instead of relying on __blk_mq_finish_request().
Moving the initialization of .rq_flags is fine because all changes
and tests of .rq_flags occur between blk_get_request() and finishing
a request.

Signed-off-by: Bart Van Assche <bart.vanassche@sandisk.com>
Cc: Christoph Hellwig <hch@lst.de>
Cc: Hannes Reinecke <hare@suse.com>
Cc: Omar Sandoval <osandov@fb.com>
Cc: Ming Lei <ming.lei@redhat.com>
---
 block/blk-mq.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/block/blk-mq.c b/block/blk-mq.c
index 2d21fbccc3a5..6268380c680f 100644
--- a/block/blk-mq.c
+++ b/block/blk-mq.c
@@ -228,6 +228,8 @@ static struct request *blk_mq_rq_ctx_init(struct blk_mq_alloc_data *data,
 	struct blk_mq_tags *tags = blk_mq_tags_from_data(data);
 	struct request *rq = tags->static_rqs[tag];
 
+	rq->rq_flags = 0;
+
 	if (data->flags & BLK_MQ_REQ_INTERNAL) {
 		rq->tag = -1;
 		rq->internal_tag = tag;
@@ -423,7 +425,6 @@ void blk_mq_free_request(struct request *rq)
 		atomic_dec(&hctx->nr_active);
 
 	wbt_done(q->rq_wb, &rq->issue_stat);
-	rq->rq_flags = 0;
 
 	clear_bit(REQ_ATOM_STARTED, &rq->atomic_flags);
 	clear_bit(REQ_ATOM_POLL_SLEPT, &rq->atomic_flags);
-- 
2.13.1
