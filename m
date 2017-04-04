Return-Path: <Adam.Manzanares@wdc.com>
From: <adam.manzanares@wdc.com>
To: <axboe@kernel.dk>, <linux-block@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>
CC: <hch@infradead.org>, <Bart.VanAssche@sandisk.com>, Adam Manzanares
	<adam.manzanares@wdc.com>
Subject: [PATCH] Block SQ/MQ Request Priority
Date: Tue, 4 Apr 2017 08:25:14 -0700
Message-ID: <1491319514-6671-1-git-send-email-adam.manzanares@wdc.com>
MIME-Version: 1.0
Content-Type: text/plain
Return-Path: Adam.Manzanares@wdc.com
List-ID: <linux-block@vger.kernel.org>

From: Adam Manzanares <adam.manzanares@wdc.com>

In 4.10 I introduced a patch that associates the ioc priority with
each request in the block layer. This work was done in the single queue
block layer code. This patch unifies ioc priority to request mapping across
the single/multi queue block layers.

I have tested this patch with the null block device driver with the following
parameters.

null_blk queue_mode=2 irqmode=0 use_per_node_hctx=1 nr_devices=1

I have not seen a performance regression with this patch and I would appreciate
any feedback or additional testing.

I have also verified that io priorities are passed to the device when using
the SQ and MQ path to a SATA HDD that supports io priorities.

Thanks.

Reviewed-by: Christoph Hellwig <hch@lst.de>
Signed-off-by: Adam Manzanares <adam.manzanares@wdc.com>
---
 block/blk-core.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/block/blk-core.c b/block/blk-core.c
index 43b7d06..316a539 100644
--- a/block/blk-core.c
+++ b/block/blk-core.c
@@ -1149,7 +1149,6 @@ static struct request *__get_request(struct request_list *rl, unsigned int op,
 
 	blk_rq_init(q, rq);
 	blk_rq_set_rl(rq, rl);
-	blk_rq_set_prio(rq, ioc);
 	rq->cmd_flags = op;
 	rq->rq_flags = rq_flags;
 
@@ -1636,6 +1635,7 @@ void init_request_from_bio(struct request *req, struct bio *bio)
 
 	req->errors = 0;
 	req->__sector = bio->bi_iter.bi_sector;
+	blk_rq_set_prio(req, rq_ioc(bio));
 	if (ioprio_valid(bio_prio(bio)))
 		req->ioprio = bio_prio(bio);
 	blk_rq_bio_prep(req->q, req, bio);
-- 
2.7.4

Western Digital Corporation (and its subsidiaries) E-mail Confidentiality Notice & Disclaimer:

This e-mail and any files transmitted with it may contain confidential or legally privileged information of WDC and/or its affiliates, and are intended solely for the use of the individual or entity to which they are addressed. If you are not the intended recipient, any disclosure, copying, distribution or any action taken or omitted to be taken in reliance on it, is prohibited. If you have received this e-mail in error, please notify the sender immediately and delete the e-mail in its entirety from your system.
