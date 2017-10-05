Return-Path: <linux-block-owner@vger.kernel.org>
Received: from esa2.hgst.iphmx.com ([68.232.143.124]:44036 "EHLO
        esa2.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751174AbdJEABQ (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Wed, 4 Oct 2017 20:01:16 -0400
From: Bart Van Assche <bart.vanassche@wdc.com>
To: Jens Axboe <axboe@kernel.dk>
Cc: linux-block@vger.kernel.org, Christoph Hellwig <hch@lst.de>,
        "Martin K . Petersen" <martin.petersen@oracle.com>,
        =Oleksandr Natalenko <oleksandr@natalenko.name>,
        "Luis R . Rodriguez" <mcgrof@kernel.org>,
        Ming Lei <ming.lei@redhat.com>,
        Bart Van Assche <bart.vanassche@wdc.com>,
        "David S . Miller" <davem@davemloft.net>,
        Hannes Reinecke <hare@suse.com>,
        Johannes Thumshirn <jthumshirn@suse.de>
Subject: [PATCH v6 7/9] ide, scsi: Tell the block layer at request allocation time about preempt requests
Date: Wed,  4 Oct 2017 17:01:08 -0700
Message-Id: <20171005000110.15904-8-bart.vanassche@wdc.com>
In-Reply-To: <20171005000110.15904-1-bart.vanassche@wdc.com>
References: <20171005000110.15904-1-bart.vanassche@wdc.com>
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

Convert blk_get_request(q, op, __GFP_RECLAIM) into blk_get_request(q,
op, BLK_MQ_PREEMPT). This patch does not change any functionality.

Signed-off-by: Bart Van Assche <bart.vanassche@wdc.com>
Cc: Martin K. Petersen <martin.petersen@oracle.com>
Cc: David S. Miller <davem@davemloft.net>
Cc: Ming Lei <ming.lei@redhat.com>
Cc: Christoph Hellwig <hch@lst.de>
Cc: Hannes Reinecke <hare@suse.com>
Cc: Johannes Thumshirn <jthumshirn@suse.de>
---
 drivers/ide/ide-pm.c    | 4 ++--
 drivers/scsi/scsi_lib.c | 6 +++---
 2 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/ide/ide-pm.c b/drivers/ide/ide-pm.c
index 544f02d673ca..f56d742908df 100644
--- a/drivers/ide/ide-pm.c
+++ b/drivers/ide/ide-pm.c
@@ -89,9 +89,9 @@ int generic_ide_resume(struct device *dev)
 	}
 
 	memset(&rqpm, 0, sizeof(rqpm));
-	rq = blk_get_request(drive->queue, REQ_OP_DRV_IN, __GFP_RECLAIM);
+	rq = blk_get_request_flags(drive->queue, REQ_OP_DRV_IN,
+				   BLK_MQ_REQ_PREEMPT);
 	ide_req(rq)->type = ATA_PRIV_PM_RESUME;
-	rq->rq_flags |= RQF_PREEMPT;
 	rq->special = &rqpm;
 	rqpm.pm_step = IDE_PM_START_RESUME;
 	rqpm.pm_state = PM_EVENT_ON;
diff --git a/drivers/scsi/scsi_lib.c b/drivers/scsi/scsi_lib.c
index 9cf6a80fe297..1c16a247fae6 100644
--- a/drivers/scsi/scsi_lib.c
+++ b/drivers/scsi/scsi_lib.c
@@ -252,9 +252,9 @@ int scsi_execute(struct scsi_device *sdev, const unsigned char *cmd,
 	struct scsi_request *rq;
 	int ret = DRIVER_ERROR << 24;
 
-	req = blk_get_request(sdev->request_queue,
+	req = blk_get_request_flags(sdev->request_queue,
 			data_direction == DMA_TO_DEVICE ?
-			REQ_OP_SCSI_OUT : REQ_OP_SCSI_IN, __GFP_RECLAIM);
+			REQ_OP_SCSI_OUT : REQ_OP_SCSI_IN, BLK_MQ_REQ_PREEMPT);
 	if (IS_ERR(req))
 		return ret;
 	rq = scsi_req(req);
@@ -268,7 +268,7 @@ int scsi_execute(struct scsi_device *sdev, const unsigned char *cmd,
 	rq->retries = retries;
 	req->timeout = timeout;
 	req->cmd_flags |= flags;
-	req->rq_flags |= rq_flags | RQF_QUIET | RQF_PREEMPT;
+	req->rq_flags |= rq_flags | RQF_QUIET;
 
 	/*
 	 * head injection *required* here otherwise quiesce won't work
-- 
2.14.2
