Return-Path: <SRS0=CiZa=NZ=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E1675C43441
	for <linux-block@archiver.kernel.org>; Wed, 14 Nov 2018 16:02:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A5F3A208E7
	for <linux-block@archiver.kernel.org>; Wed, 14 Nov 2018 16:02:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="L0jGb0Wh"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A5F3A208E7
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-block-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733018AbeKOCGS (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 14 Nov 2018 21:06:18 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:41662 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726295AbeKOCGS (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 14 Nov 2018 21:06:18 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From
        :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=nUpJdPjf9N9BAGHC85bRBnFsXzdMNjEYBayY+uI9Ho0=; b=L0jGb0Whg2RgZntcRfwMrVTHaN
        nRj+pAzcTadOfZH3yKkmIKH4thwCz3JqzXNFF0pmdq1sPnhBgbySX+Ai9XZq6RFnOFPDl7+olViMN
        QIAdHr9bT76++x6zL5UhpdiDru7sQCBEWVO2ISG7iSkm8cOj/YwHpM+8nvmOqnyNU1SLEhm6UCqvo
        qp6ElIs/NitSQwgNAouwWAH4WdnQ9TUa8qYngjyzh+OumepBH2LUui0jaI3TBva4p/gYpwHxB04zR
        uQbIpmr0LJ0MkGYKT6v2FKovTVmKQJF791VRE4A3/Rq8OOYmnMYJcgQ5Dr4KHVsbgPoli5kWfzHDS
        VtTZmgpw==;
Received: from 089144211136.atnat0020.highway.a1.net ([89.144.211.136] helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1gMxcb-00069P-Ee; Wed, 14 Nov 2018 16:02:29 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org, linux-mmc@vger.kernel.org,
        drbd-dev@lists.linbit.com
Subject: [PATCH 03/16] block: don't hold the queue_lock over blk_abort_request
Date:   Wed, 14 Nov 2018 17:02:06 +0100
Message-Id: <20181114160219.28328-4-hch@lst.de>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20181114160219.28328-1-hch@lst.de>
References: <20181114160219.28328-1-hch@lst.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

There is nothing it could synchronize against, so don't go through
the pains of acquiring the lock.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 block/blk-timeout.c                 |  2 +-
 drivers/ata/libata-eh.c             |  4 ----
 drivers/block/mtip32xx/mtip32xx.c   |  5 +----
 drivers/scsi/libsas/sas_ata.c       |  5 -----
 drivers/scsi/libsas/sas_scsi_host.c | 10 ++--------
 5 files changed, 4 insertions(+), 22 deletions(-)

diff --git a/block/blk-timeout.c b/block/blk-timeout.c
index 3b0179fbdd6a..124c26128bf6 100644
--- a/block/blk-timeout.c
+++ b/block/blk-timeout.c
@@ -75,7 +75,7 @@ ssize_t part_timeout_store(struct device *dev, struct device_attribute *attr,
  * This function requests that the block layer start recovery for the
  * request by deleting the timer and calling the q's timeout function.
  * LLDDs who implement their own error recovery MAY ignore the timeout
- * event if they generated blk_abort_req. Must hold queue lock.
+ * event if they generated blk_abort_request.
  */
 void blk_abort_request(struct request *req)
 {
diff --git a/drivers/ata/libata-eh.c b/drivers/ata/libata-eh.c
index 01306c018398..938ed513b070 100644
--- a/drivers/ata/libata-eh.c
+++ b/drivers/ata/libata-eh.c
@@ -919,8 +919,6 @@ static void ata_eh_set_pending(struct ata_port *ap, int fastdrain)
 void ata_qc_schedule_eh(struct ata_queued_cmd *qc)
 {
 	struct ata_port *ap = qc->ap;
-	struct request_queue *q = qc->scsicmd->device->request_queue;
-	unsigned long flags;
 
 	WARN_ON(!ap->ops->error_handler);
 
@@ -932,9 +930,7 @@ void ata_qc_schedule_eh(struct ata_queued_cmd *qc)
 	 * Note that ATA_QCFLAG_FAILED is unconditionally set after
 	 * this function completes.
 	 */
-	spin_lock_irqsave(q->queue_lock, flags);
 	blk_abort_request(qc->scsicmd->request);
-	spin_unlock_irqrestore(q->queue_lock, flags);
 }
 
 /**
diff --git a/drivers/block/mtip32xx/mtip32xx.c b/drivers/block/mtip32xx/mtip32xx.c
index a4c44db097e0..2b0ac9d01e51 100644
--- a/drivers/block/mtip32xx/mtip32xx.c
+++ b/drivers/block/mtip32xx/mtip32xx.c
@@ -2770,10 +2770,7 @@ static int mtip_service_thread(void *data)
 
 			blk_mq_quiesce_queue(dd->queue);
 
-			spin_lock(dd->queue->queue_lock);
-			blk_mq_tagset_busy_iter(&dd->tags,
-							mtip_queue_cmd, dd);
-			spin_unlock(dd->queue->queue_lock);
+			blk_mq_tagset_busy_iter(&dd->tags, mtip_queue_cmd, dd);
 
 			set_bit(MTIP_PF_ISSUE_CMDS_BIT, &dd->port->flags);
 
diff --git a/drivers/scsi/libsas/sas_ata.c b/drivers/scsi/libsas/sas_ata.c
index 4f6cdf53e913..c90b278cc28c 100644
--- a/drivers/scsi/libsas/sas_ata.c
+++ b/drivers/scsi/libsas/sas_ata.c
@@ -601,12 +601,7 @@ void sas_ata_task_abort(struct sas_task *task)
 
 	/* Bounce SCSI-initiated commands to the SCSI EH */
 	if (qc->scsicmd) {
-		struct request_queue *q = qc->scsicmd->device->request_queue;
-		unsigned long flags;
-
-		spin_lock_irqsave(q->queue_lock, flags);
 		blk_abort_request(qc->scsicmd->request);
-		spin_unlock_irqrestore(q->queue_lock, flags);
 		return;
 	}
 
diff --git a/drivers/scsi/libsas/sas_scsi_host.c b/drivers/scsi/libsas/sas_scsi_host.c
index 33229348dcb6..af085432c5fe 100644
--- a/drivers/scsi/libsas/sas_scsi_host.c
+++ b/drivers/scsi/libsas/sas_scsi_host.c
@@ -930,16 +930,10 @@ void sas_task_abort(struct sas_task *task)
 		return;
 	}
 
-	if (dev_is_sata(task->dev)) {
+	if (dev_is_sata(task->dev))
 		sas_ata_task_abort(task);
-	} else {
-		struct request_queue *q = sc->device->request_queue;
-		unsigned long flags;
-
-		spin_lock_irqsave(q->queue_lock, flags);
+	else
 		blk_abort_request(sc->request);
-		spin_unlock_irqrestore(q->queue_lock, flags);
-	}
 }
 
 void sas_target_destroy(struct scsi_target *starget)
-- 
2.19.1

