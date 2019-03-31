Return-Path: <SRS0=bw4W=SC=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5D857C43381
	for <linux-block@archiver.kernel.org>; Sun, 31 Mar 2019 03:10:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2820F20881
	for <linux-block@archiver.kernel.org>; Sun, 31 Mar 2019 03:10:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731111AbfCaDK2 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Sat, 30 Mar 2019 23:10:28 -0400
Received: from mx1.redhat.com ([209.132.183.28]:57548 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730061AbfCaDK2 (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Sat, 30 Mar 2019 23:10:28 -0400
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 111425AFE9;
        Sun, 31 Mar 2019 03:10:28 +0000 (UTC)
Received: from localhost (ovpn-8-16.pek2.redhat.com [10.72.8.16])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 298B2452B;
        Sun, 31 Mar 2019 03:10:26 +0000 (UTC)
From:   Ming Lei <ming.lei@redhat.com>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org, Ming Lei <ming.lei@redhat.com>,
        James Smart <james.smart@broadcom.com>,
        Bart Van Assche <bart.vanassche@wdc.com>,
        linux-scsi@vger.kernel.org,
        "Martin K . Petersen" <martin.petersen@oracle.com>,
        Christoph Hellwig <hch@lst.de>,
        "James E . J . Bottomley" <jejb@linux.vnet.ibm.com>,
        jianchao wang <jianchao.w.wang@oracle.com>
Subject: [PATCH 5/5] SCSI: don't grab queue usage counter before run queue
Date:   Sun, 31 Mar 2019 11:09:54 +0800
Message-Id: <20190331030954.22320-6-ming.lei@redhat.com>
In-Reply-To: <20190331030954.22320-1-ming.lei@redhat.com>
References: <20190331030954.22320-1-ming.lei@redhat.com>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.39]); Sun, 31 Mar 2019 03:10:28 +0000 (UTC)
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Now resources for dispatch is freed in queue's release handler,
we don't need to worry about the possible race between blk_cleanup_queue
and run queue.

So don't grab the queue usage counter before run queue in
scsi_end_request().

Cc: James Smart <james.smart@broadcom.com>
Cc: Bart Van Assche <bart.vanassche@wdc.com>
Cc: linux-scsi@vger.kernel.org,
Cc: Martin K . Petersen <martin.petersen@oracle.com>,
Cc: Christoph Hellwig <hch@lst.de>,
Cc: James E . J . Bottomley <jejb@linux.vnet.ibm.com>,
Cc: jianchao wang <jianchao.w.wang@oracle.com>
Signed-off-by: Ming Lei <ming.lei@redhat.com>
---
 drivers/scsi/scsi_lib.c | 7 -------
 1 file changed, 7 deletions(-)

diff --git a/drivers/scsi/scsi_lib.c b/drivers/scsi/scsi_lib.c
index 601b9f1de267..18bf341d1236 100644
--- a/drivers/scsi/scsi_lib.c
+++ b/drivers/scsi/scsi_lib.c
@@ -604,12 +604,6 @@ static bool scsi_end_request(struct request *req, blk_status_t error,
 	 */
 	scsi_mq_uninit_cmd(cmd);
 
-	/*
-	 * queue is still alive, so grab the ref for preventing it
-	 * from being cleaned up during running queue.
-	 */
-	percpu_ref_get(&q->q_usage_counter);
-
 	__blk_mq_end_request(req, error);
 
 	if (scsi_target(sdev)->single_lun ||
@@ -618,7 +612,6 @@ static bool scsi_end_request(struct request *req, blk_status_t error,
 	else
 		blk_mq_run_hw_queues(q, true);
 
-	percpu_ref_put(&q->q_usage_counter);
 	put_device(&sdev->sdev_gendev);
 	return false;
 }
-- 
2.9.5

