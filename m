Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:50888 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1752605AbeCMJnt (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Tue, 13 Mar 2018 05:43:49 -0400
From: Ming Lei <ming.lei@redhat.com>
To: James Bottomley <James.Bottomley@HansenPartnership.com>,
        Jens Axboe <axboe@fb.com>,
        "Martin K . Petersen" <martin.petersen@oracle.com>
Cc: Christoph Hellwig <hch@lst.de>, linux-scsi@vger.kernel.org,
        linux-block@vger.kernel.org, Meelis Roos <mroos@linux.ee>,
        Don Brace <don.brace@microsemi.com>,
        Kashyap Desai <kashyap.desai@broadcom.com>,
        Laurence Oberman <loberman@redhat.com>,
        Mike Snitzer <snitzer@redhat.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Ming Lei <ming.lei@redhat.com>, Omar Sandoval <osandov@fb.com>,
        James Bottomley <james.bottomley@hansenpartnership.com>
Subject: [PATCH V5 3/5] scsi: introduce force_blk_mq
Date: Tue, 13 Mar 2018 17:42:41 +0800
Message-Id: <20180313094243.8710-4-ming.lei@redhat.com>
In-Reply-To: <20180313094243.8710-1-ming.lei@redhat.com>
References: <20180313094243.8710-1-ming.lei@redhat.com>
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

>From scsi driver view, it is a bit troublesome to support both blk-mq
and non-blk-mq at the same time, especially when drivers need to support
multi hw-queue.

This patch introduces 'force_blk_mq' to scsi_host_template so that drivers
can provide blk-mq only support, so driver code can avoid the trouble
for supporting both.

Cc: Omar Sandoval <osandov@fb.com>,
Cc: "Martin K. Petersen" <martin.petersen@oracle.com>,
Cc: James Bottomley <james.bottomley@hansenpartnership.com>,
Cc: Christoph Hellwig <hch@lst.de>,
Cc: Don Brace <don.brace@microsemi.com>
Cc: Kashyap Desai <kashyap.desai@broadcom.com>
Cc: Mike Snitzer <snitzer@redhat.com>
Cc: Laurence Oberman <loberman@redhat.com>
Reviewed-by: Hannes Reinecke <hare@suse.de>
Reviewed-by: Christoph Hellwig <hch@lst.de>
Signed-off-by: Ming Lei <ming.lei@redhat.com>
---
 drivers/scsi/hosts.c     | 1 +
 include/scsi/scsi_host.h | 3 +++
 2 files changed, 4 insertions(+)

diff --git a/drivers/scsi/hosts.c b/drivers/scsi/hosts.c
index 57bf43e34863..cbbc32df7595 100644
--- a/drivers/scsi/hosts.c
+++ b/drivers/scsi/hosts.c
@@ -477,6 +477,7 @@ struct Scsi_Host *scsi_host_alloc(struct scsi_host_template *sht, int privsize)
 		shost->dma_boundary = 0xffffffff;
 
 	shost->use_blk_mq = scsi_use_blk_mq;
+	shost->use_blk_mq = scsi_use_blk_mq || shost->hostt->force_blk_mq;
 
 	device_initialize(&shost->shost_gendev);
 	dev_set_name(&shost->shost_gendev, "host%d", shost->host_no);
diff --git a/include/scsi/scsi_host.h b/include/scsi/scsi_host.h
index 1a1df0d21ee3..6c6366f0bd15 100644
--- a/include/scsi/scsi_host.h
+++ b/include/scsi/scsi_host.h
@@ -452,6 +452,9 @@ struct scsi_host_template {
 	/* True if the controller does not support WRITE SAME */
 	unsigned no_write_same:1;
 
+	/* True if the low-level driver supports blk-mq only */
+	unsigned force_blk_mq:1;
+
 	/*
 	 * Countdown for host blocking with no commands outstanding.
 	 */
-- 
2.9.5
