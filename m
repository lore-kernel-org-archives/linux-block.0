Return-Path: <SRS0=CiZa=NZ=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E963FC43441
	for <linux-block@archiver.kernel.org>; Wed, 14 Nov 2018 04:35:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B668A2145D
	for <linux-block@archiver.kernel.org>; Wed, 14 Nov 2018 04:35:38 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B668A2145D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-block-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727213AbeKNOhH (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 14 Nov 2018 09:37:07 -0500
Received: from mx1.redhat.com ([209.132.183.28]:58802 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726813AbeKNOhH (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Wed, 14 Nov 2018 09:37:07 -0500
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id D3ABB58E5A;
        Wed, 14 Nov 2018 04:35:36 +0000 (UTC)
Received: from localhost (ovpn-8-18.pek2.redhat.com [10.72.8.18])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 122695D6A6;
        Wed, 14 Nov 2018 04:35:32 +0000 (UTC)
From:   Ming Lei <ming.lei@redhat.com>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org, Ming Lei <ming.lei@redhat.com>,
        Andrew Jones <drjones@redhat.com>,
        Bart Van Assche <bart.vanassche@wdc.com>,
        linux-scsi@vger.kernel.org,
        "Martin K . Petersen" <martin.petersen@oracle.com>,
        Christoph Hellwig <hch@lst.de>,
        "James E . J . Bottomley" <jejb@linux.vnet.ibm.com>,
        stable <stable@vger.kernel.org>
Subject: [RFC PATCH] SCSI: fix queue cleanup race before queue is initialized done
Date:   Wed, 14 Nov 2018 12:35:12 +0800
Message-Id: <20181114043512.19627-1-ming.lei@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.39]); Wed, 14 Nov 2018 04:35:37 +0000 (UTC)
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

c2856ae2f315d ("blk-mq: quiesce queue before freeing queue") has
already fixed this race, however the implied synchronize_rcu()
in blk_mq_quiesce_queue() can slow down LUN probe a lot, so caused
performance regression.

Then 1311326cf4755c7 ("blk-mq: avoid to synchronize rcu inside blk_cleanup_queue()")
tried to only quiesce queue for avoiding unnecessary synchronize_rcu()
in case that queue isn't initialized done.

However, turns out we still need to quiesce the queue in case that
queue isn't initialized done. Because when one SCSI command is
completed, the user is waken up immediately, then the scsi device
can be removed, meantime the run queue in scsi_end_request() can
be still in-progress, so kernel panic is triggered.

In Red Hat QE lab, there are several reports about this kind of kernel
panic triggered during kernel booting.

Fixes: 1311326cf4755c7 ("blk-mq: avoid to synchronize rcu inside blk_cleanup_queue()")
Cc: Andrew Jones <drjones@redhat.com>
Cc: Bart Van Assche <bart.vanassche@wdc.com>
Cc: linux-scsi@vger.kernel.org
Cc: Martin K. Petersen <martin.petersen@oracle.com>
Cc: Christoph Hellwig <hch@lst.de>
Cc: James E.J. Bottomley <jejb@linux.vnet.ibm.com>
Cc: stable <stable@vger.kernel.org>
Signed-off-by: Ming Lei <ming.lei@redhat.com>
---
 block/blk-core.c        |  6 +++---
 drivers/scsi/scsi_lib.c | 36 ++++++++++++++++++++++++++++++------
 2 files changed, 33 insertions(+), 9 deletions(-)

diff --git a/block/blk-core.c b/block/blk-core.c
index ce12515f9b9b..cf7742a677c4 100644
--- a/block/blk-core.c
+++ b/block/blk-core.c
@@ -798,9 +798,9 @@ void blk_cleanup_queue(struct request_queue *q)
 	 * dispatch may still be in-progress since we dispatch requests
 	 * from more than one contexts.
 	 *
-	 * No need to quiesce queue if it isn't initialized yet since
-	 * blk_freeze_queue() should be enough for cases of passthrough
-	 * request.
+	 * We rely on driver to deal with the race in case that queue
+	 * initialization isn't done.
+	 *
 	 */
 	if (q->mq_ops && blk_queue_init_done(q))
 		blk_mq_quiesce_queue(q);
diff --git a/drivers/scsi/scsi_lib.c b/drivers/scsi/scsi_lib.c
index c7fccbb8f554..7ec7a8a2d000 100644
--- a/drivers/scsi/scsi_lib.c
+++ b/drivers/scsi/scsi_lib.c
@@ -697,13 +697,37 @@ static bool scsi_end_request(struct request *req, blk_status_t error,
 		 */
 		scsi_mq_uninit_cmd(cmd);
 
-		__blk_mq_end_request(req, error);
+		/*
+		 * When block queue initialization isn't done, the request
+		 * queue won't be quiesced in blk_cleanup_queue() for avoiding
+		 * slowing down LUN probe, so queue still may be run even though
+		 * its resource is cleaned up, this way can cause kernel panic.
+		 *
+		 * Workaround this issue by freeing request after running the
+		 * queue when queue initialization isn't done, so the queue's
+		 * usage counter can be held during running queue.
+		 *
+		 * This way is safe because sdev->device_busy has been decreased
+		 * already, and scsi_queue_rq() may guarantee the forward-progress.
+		 *
+		 */
+		if (blk_queue_init_done(q)) {
+			__blk_mq_end_request(req, error);
+
+			if (scsi_target(sdev)->single_lun ||
+					!list_empty(&sdev->host->starved_list))
+				kblockd_schedule_work(&sdev->requeue_work);
+			else
+				blk_mq_run_hw_queues(q, true);
+		} else {
 
-		if (scsi_target(sdev)->single_lun ||
-		    !list_empty(&sdev->host->starved_list))
-			kblockd_schedule_work(&sdev->requeue_work);
-		else
-			blk_mq_run_hw_queues(q, true);
+			if (scsi_target(sdev)->single_lun ||
+					!list_empty(&sdev->host->starved_list))
+				kblockd_schedule_work(&sdev->requeue_work);
+			else
+				blk_mq_run_hw_queues(q, true);
+			__blk_mq_end_request(req, error);
+		}
 	} else {
 		unsigned long flags;
 
-- 
2.9.5

