Return-Path: <axboe@kernel.dk>
From: Jens Axboe <axboe@kernel.dk>
To: linux-block@vger.kernel.org,
	linux-ide@vger.kernel.org,
	linux-scsi@vger.kernel.org
Cc: Jens Axboe <axboe@kernel.dk>
Subject: [PATCH 08/30] scsi: provide mq_ops->busy() hook
Date: Wed, 31 Oct 2018 11:59:00 -0600
Message-Id: <20181031175922.8849-9-axboe@kernel.dk>
In-Reply-To: <20181031175922.8849-1-axboe@kernel.dk>
References: <20181031175922.8849-1-axboe@kernel.dk>
List-ID: <linux-block@vger.kernel.org>

Only the SCSI legacy path provides a way to check if target is
currently busy, provide the same for the MQ path.

Cc: linux-scsi@vger.kernel.org
Reviewed-by: Hannes Reinecke <hare@suse.com>
Signed-off-by: Jens Axboe <axboe@kernel.dk>
---
 drivers/scsi/scsi_lib.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/scsi/scsi_lib.c b/drivers/scsi/scsi_lib.c
index c7fccbb8f554..8b0345924a92 100644
--- a/drivers/scsi/scsi_lib.c
+++ b/drivers/scsi/scsi_lib.c
@@ -1675,6 +1675,11 @@ static int scsi_lld_busy(struct request_queue *q)
 	return 0;
 }
 
+static bool scsi_mq_lld_busy(struct request_queue *q)
+{
+	return scsi_lld_busy(q);
+}
+
 /*
  * Kill a request for a dead device
  */
@@ -2326,6 +2331,7 @@ static const struct blk_mq_ops scsi_mq_ops = {
 	.init_request	= scsi_mq_init_request,
 	.exit_request	= scsi_mq_exit_request,
 	.initialize_rq_fn = scsi_initialize_rq,
+	.busy		= scsi_mq_lld_busy,
 	.map_queues	= scsi_map_queues,
 };
 
-- 
2.17.1
