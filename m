Return-Path: <Bart.VanAssche@wdc.com>
From: Bart Van Assche <bart.vanassche@wdc.com>
To: Jens Axboe <axboe@kernel.dk>
CC: <linux-block@vger.kernel.org>, Christoph Hellwig <hch@lst.de>, "Bart Van
 Assche" <bart.vanassche@wdc.com>, Bart Van Assche
	<bart.vanassche@sandisk.com>, Hannes Reinecke <hare@suse.com>, Omar Sandoval
	<osandov@fb.com>, Ming Lei <ming.lei@redhat.com>
Subject: [PATCH v4 06/12] blk-mq: Initialize .rq_flags in blk_mq_rq_ctx_init()
Date: Mon, 19 Jun 2017 15:07:55 -0700
Message-ID: <20170619220801.12557-7-bart.vanassche@wdc.com>
In-Reply-To: <20170619220801.12557-1-bart.vanassche@wdc.com>
References: <20170619220801.12557-1-bart.vanassche@wdc.com>
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
 block/blk-mq.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/block/blk-mq.c b/block/blk-mq.c
index 8cd423ba585d..679b52790bc1 100644
--- a/block/blk-mq.c
+++ b/block/blk-mq.c
@@ -260,6 +260,7 @@ static struct request *blk_mq_rq_ctx_init(struct blk_mq_alloc_data *data,
 	rq->q = data->q;
 	rq->mq_ctx = data->ctx;
 	rq->cmd_flags = op;
+	rq->rq_flags = 0;
 	if (blk_queue_io_stat(data->q))
 		rq->rq_flags |= RQF_IO_STAT;
 	/* do not touch atomic flags, it needs atomic ops against the timer */
@@ -435,7 +436,6 @@ void blk_mq_free_request(struct request *rq)
 		atomic_dec(&hctx->nr_active);
 
 	wbt_done(q->rq_wb, &rq->issue_stat);
-	rq->rq_flags = 0;
 
 	clear_bit(REQ_ATOM_STARTED, &rq->atomic_flags);
 	clear_bit(REQ_ATOM_POLL_SLEPT, &rq->atomic_flags);
-- 
2.13.1
