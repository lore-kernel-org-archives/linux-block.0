Return-Path: <SRS0=U0+/=T3=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E13F2C04AB3
	for <linux-block@archiver.kernel.org>; Mon, 27 May 2019 15:03:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C12152182B
	for <linux-block@archiver.kernel.org>; Mon, 27 May 2019 15:03:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725991AbfE0PDA (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 27 May 2019 11:03:00 -0400
Received: from mx1.redhat.com ([209.132.183.28]:43886 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726704AbfE0PC5 (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Mon, 27 May 2019 11:02:57 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 291C23001A63;
        Mon, 27 May 2019 15:02:57 +0000 (UTC)
Received: from localhost (ovpn-8-24.pek2.redhat.com [10.72.8.24])
        by smtp.corp.redhat.com (Postfix) with ESMTP id AA00679805;
        Mon, 27 May 2019 15:02:53 +0000 (UTC)
From:   Ming Lei <ming.lei@redhat.com>
To:     Jens Axboe <axboe@kernel.dk>,
        "Martin K . Petersen" <martin.petersen@oracle.com>
Cc:     linux-block@vger.kernel.org,
        James Bottomley <James.Bottomley@HansenPartnership.com>,
        linux-scsi@vger.kernel.org, Bart Van Assche <bvanassche@acm.org>,
        Hannes Reinecke <hare@suse.com>,
        John Garry <john.garry@huawei.com>,
        Keith Busch <keith.busch@intel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Don Brace <don.brace@microsemi.com>,
        Kashyap Desai <kashyap.desai@broadcom.com>,
        Sathya Prakash <sathya.prakash@broadcom.com>,
        Christoph Hellwig <hch@lst.de>, Ming Lei <ming.lei@redhat.com>
Subject: [PATCH V2 3/5] scsi: core: implement callback of .complete_queue_affinity
Date:   Mon, 27 May 2019 23:02:05 +0800
Message-Id: <20190527150207.11372-4-ming.lei@redhat.com>
In-Reply-To: <20190527150207.11372-1-ming.lei@redhat.com>
References: <20190527150207.11372-1-ming.lei@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.45]); Mon, 27 May 2019 15:02:57 +0000 (UTC)
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Implement scsi core's callback of .complete_queue_affinity for
supporting to drain in-flight requests in case that SCSI HBA
supports multiple completion queue.

Signed-off-by: Ming Lei <ming.lei@redhat.com>
---
 drivers/scsi/scsi_lib.c  | 14 ++++++++++++++
 include/scsi/scsi_host.h | 10 ++++++++++
 2 files changed, 24 insertions(+)

diff --git a/drivers/scsi/scsi_lib.c b/drivers/scsi/scsi_lib.c
index 65d0a10c76ad..ac57dc98a8c0 100644
--- a/drivers/scsi/scsi_lib.c
+++ b/drivers/scsi/scsi_lib.c
@@ -1750,6 +1750,19 @@ static int scsi_map_queues(struct blk_mq_tag_set *set)
 	return blk_mq_map_queues(&set->map[HCTX_TYPE_DEFAULT]);
 }
 
+static const struct cpumask *
+scsi_complete_queue_affinity(struct blk_mq_hw_ctx *hctx, int cpu)
+{
+	struct request_queue *q = hctx->queue;
+	struct scsi_device *sdev = q->queuedata;
+	struct Scsi_Host *shost = sdev->host;
+
+	if (shost->hostt->complete_queue_affinity)
+		return shost->hostt->complete_queue_affinity(shost, cpu);
+
+	return NULL;
+}
+
 void __scsi_init_queue(struct Scsi_Host *shost, struct request_queue *q)
 {
 	struct device *dev = shost->dma_dev;
@@ -1802,6 +1815,7 @@ static const struct blk_mq_ops scsi_mq_ops = {
 	.initialize_rq_fn = scsi_initialize_rq,
 	.busy		= scsi_mq_lld_busy,
 	.map_queues	= scsi_map_queues,
+	.complete_queue_affinity = scsi_complete_queue_affinity,
 };
 
 struct request_queue *scsi_mq_alloc_queue(struct scsi_device *sdev)
diff --git a/include/scsi/scsi_host.h b/include/scsi/scsi_host.h
index a5fcdad4a03e..65ccac1429a1 100644
--- a/include/scsi/scsi_host.h
+++ b/include/scsi/scsi_host.h
@@ -268,6 +268,16 @@ struct scsi_host_template {
 	 */
 	int (* map_queues)(struct Scsi_Host *shost);
 
+	/*
+	 * This functions lets the driver expose complete queue's cpu
+	 * affinity to the block layer. @cpu is used for retrieving
+	 * the mapped completion queue.
+	 *
+	 * Status: OPTIONAL
+	 */
+	const struct cpumask * (* complete_queue_affinity)(struct Scsi_Host *,
+							   int cpu);
+
 	/*
 	 * This function determines the BIOS parameters for a given
 	 * harddisk.  These tend to be numbers that are made up by
-- 
2.20.1

