Return-Path: <prvs=403a468a2=bart.vanassche@wdc.com>
From: Bart Van Assche <bart.vanassche@wdc.com>
To: Jens Axboe <axboe@kernel.dk>
Cc: linux-block@vger.kernel.org,
	Christoph Hellwig <hch@lst.de>,
	Bart Van Assche <bart.vanassche@wdc.com>,
	Hannes Reinecke <hare@suse.de>,
	Johannes Thumshirn <jthumshirn@suse.de>
Subject: [PATCH 1/4] skd: Rename skd_softirq_done() into skd_complete_rq()
Date: Fri, 25 Aug 2017 14:24:11 -0700
Message-Id: <20170825212414.28322-2-bart.vanassche@wdc.com>
In-Reply-To: <20170825212414.28322-1-bart.vanassche@wdc.com>
References: <20170825212414.28322-1-bart.vanassche@wdc.com>
List-ID: <linux-block@vger.kernel.org>

The latter name follows more closely the function names used in
other blk-mq drivers.

Suggested-by: Christoph Hellwig <hch@lst.de>
Signed-off-by: Bart Van Assche <bart.vanassche@wdc.com>
Cc: Christoph Hellwig <hch@lst.de>
Cc: Hannes Reinecke <hare@suse.de>
Cc: Johannes Thumshirn <jthumshirn@suse.de>
---
 drivers/block/skd_main.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/block/skd_main.c b/drivers/block/skd_main.c
index 577618c57975..a55c8ef1a21d 100644
--- a/drivers/block/skd_main.c
+++ b/drivers/block/skd_main.c
@@ -629,7 +629,7 @@ static void skd_end_request(struct skd_device *skdev, struct request *req,
 	blk_mq_complete_request(req);
 }
 
-static void skd_softirq_done(struct request *req)
+static void skd_complete_rq(struct request *req)
 {
 	struct skd_request_context *skreq = blk_mq_rq_to_pdu(req);
 
@@ -2821,7 +2821,7 @@ static int skd_cons_sksb(struct skd_device *skdev)
 
 static const struct blk_mq_ops skd_mq_ops = {
 	.queue_rq	= skd_mq_queue_rq,
-	.complete	= skd_softirq_done,
+	.complete	= skd_complete_rq,
 	.timeout	= skd_timed_out,
 	.init_request	= skd_init_request,
 	.exit_request	= skd_exit_request,
-- 
2.14.1
