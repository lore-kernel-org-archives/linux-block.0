Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:42138 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S941653AbdEYEWA (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Thu, 25 May 2017 00:22:00 -0400
From: Ming Lei <ming.lei@redhat.com>
To: Jens Axboe <axboe@fb.com>, linux-block@vger.kernel.org,
        Christoph Hellwig <hch@infradead.org>
Cc: Bart Van Assche <bart.vanassche@sandisk.com>
Subject: [PATCH 5/7] scsi: use the introduced blk_mq_unquiesce_queue()
Date: Thu, 25 May 2017 12:21:29 +0800
Message-Id: <20170525042131.13172-6-ming.lei@redhat.com>
In-Reply-To: <20170525042131.13172-1-ming.lei@redhat.com>
References: <20170525042131.13172-1-ming.lei@redhat.com>
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

blk_mq_unquiesce_queue() is used for unquiescing the queue.

Signed-off-by: Ming Lei <ming.lei@redhat.com>
---
 drivers/scsi/scsi_lib.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/scsi/scsi_lib.c b/drivers/scsi/scsi_lib.c
index 814a4bd8405d..72b11f75719c 100644
--- a/drivers/scsi/scsi_lib.c
+++ b/drivers/scsi/scsi_lib.c
@@ -3030,7 +3030,10 @@ scsi_internal_device_unblock(struct scsi_device *sdev,
 		return -EINVAL;
 
 	if (q->mq_ops) {
-		blk_mq_start_stopped_hw_queues(q, false);
+		if (blk_queue_quiesced(q))
+			blk_mq_unquiesce_queue(q);
+		else
+			blk_mq_start_stopped_hw_queues(q, false);
 	} else {
 		spin_lock_irqsave(q->queue_lock, flags);
 		blk_start_queue(q);
-- 
2.9.4
