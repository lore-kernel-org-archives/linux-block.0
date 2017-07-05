Return-Path: <linux-block-owner@vger.kernel.org>
Received: from bombadil.infradead.org ([65.50.211.133]:35146 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751886AbdGEWvg (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Wed, 5 Jul 2017 18:51:36 -0400
Date: Wed, 5 Jul 2017 15:51:34 -0700
From: Christoph Hellwig <hch@infradead.org>
To: Meelis Roos <mroos@linux.ee>
Cc: Linux Kernel list <linux-kernel@vger.kernel.org>,
        linux-block@vger.kernel.org
Subject: Re: OOPS from cciss_ioctl in 4.12+git
Message-ID: <20170705225134.GA31786@infradead.org>
References: <alpine.LRH.2.20.1707051555130.20086@math.ut.ee>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <alpine.LRH.2.20.1707051555130.20086@math.ut.ee>
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

Hi Meelis,

can you try the patch below?

Also we're trying to move people away from the cciss driver, can you
check if the hpsa SCSI driver works for you as well?

diff --git a/drivers/block/cciss.c b/drivers/block/cciss.c
index 02a611993bb4..678af946be30 100644
--- a/drivers/block/cciss.c
+++ b/drivers/block/cciss.c
@@ -1944,6 +1944,13 @@ static void cciss_get_serial_no(ctlr_info_t *h, int logvol,
 	return;
 }
 
+static void cciss_initialize_rq(struct request *rq)
+{
+	struct scsi_request *sreq = blk_mq_rq_to_pdu(rq);
+
+	scsi_req_init(sreq);
+}
+
 /*
  * cciss_add_disk sets up the block device queue for a logical drive
  */
@@ -1956,6 +1963,7 @@ static int cciss_add_disk(ctlr_info_t *h, struct gendisk *disk,
 
 	disk->queue->cmd_size = sizeof(struct scsi_request);
 	disk->queue->request_fn = do_cciss_request;
+	disk->queue->initialize_rq_fn = cciss_initialize_rq;
 	disk->queue->queue_lock = &h->lock;
 	queue_flag_set_unlocked(QUEUE_FLAG_SCSI_PASSTHROUGH, disk->queue);
 	if (blk_init_allocated_queue(disk->queue) < 0)
