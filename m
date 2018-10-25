Return-Path: <axboe@kernel.dk>
From: Jens Axboe <axboe@kernel.dk>
To: linux-block@vger.kernel.org,
	linux-scsi@vger.kernel.org,
	linux-ide@vger.kernel.org
Cc: Jens Axboe <axboe@kernel.dk>,
	Bart Van Assche <bvanassche@acm.org>,
	Parav Pandit <parav@mellanox.com>
Subject: [PATCH 05/28] IB/srp: remove old request_fn_active check
Date: Thu, 25 Oct 2018 15:10:16 -0600
Message-Id: <20181025211039.11559-6-axboe@kernel.dk>
In-Reply-To: <20181025211039.11559-1-axboe@kernel.dk>
References: <20181025211039.11559-1-axboe@kernel.dk>
List-ID: <linux-block@vger.kernel.org>

This check is only viable for non scsi-mq. Since that is going away,
kill this legacy check.

Cc: Bart Van Assche <bvanassche@acm.org>
Cc: Parav Pandit <parav@mellanox.com>
Cc: linux-scsi@vger.kernel.org
Signed-off-by: Jens Axboe <axboe@kernel.dk>
---
 drivers/infiniband/ulp/srp/ib_srp.c | 7 -------
 1 file changed, 7 deletions(-)

diff --git a/drivers/infiniband/ulp/srp/ib_srp.c b/drivers/infiniband/ulp/srp/ib_srp.c
index 0b34e909505f..5a79444c2f3c 100644
--- a/drivers/infiniband/ulp/srp/ib_srp.c
+++ b/drivers/infiniband/ulp/srp/ib_srp.c
@@ -1334,13 +1334,6 @@ static void srp_terminate_io(struct srp_rport *rport)
 	struct scsi_device *sdev;
 	int i, j;
 
-	/*
-	 * Invoking srp_terminate_io() while srp_queuecommand() is running
-	 * is not safe. Hence the warning statement below.
-	 */
-	shost_for_each_device(sdev, shost)
-		WARN_ON_ONCE(sdev->request_queue->request_fn_active);
-
 	for (i = 0; i < target->ch_count; i++) {
 		ch = &target->ch[i];
 
-- 
2.17.1
