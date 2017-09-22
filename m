Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mga11.intel.com ([192.55.52.93]:14443 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752319AbdIVPEW (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Fri, 22 Sep 2017 11:04:22 -0400
Date: Fri, 22 Sep 2017 11:09:16 -0400
From: Keith Busch <keith.busch@intel.com>
To: Christoph Hellwig <hch@lst.de>
Cc: Jens Axboe <axboe@kernel.dk>, Sagi Grimberg <sagi@grimberg.me>,
        linux-nvme@lists.infradead.org, linux-block@vger.kernel.org
Subject: Re: [PATCH 9/9] nvme: implement multipath access to nvme subsystems
Message-ID: <20170922150915.GA1294@localhost.localdomain>
References: <20170918231453.27128-1-hch@lst.de>
 <20170918231453.27128-10-hch@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20170918231453.27128-10-hch@lst.de>
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

On Mon, Sep 18, 2017 at 04:14:53PM -0700, Christoph Hellwig wrote:
> +static void nvme_failover_req(struct request *req)
> +{
> +	struct nvme_ns *ns = req->q->queuedata;
> +	unsigned long flags;
> +
> +	spin_lock_irqsave(&ns->head->requeue_lock, flags);
> +	blk_steal_bios(&ns->head->requeue_list, req);
> +	spin_unlock_irqrestore(&ns->head->requeue_lock, flags);
> +
> +	nvme_reset_ctrl(ns->ctrl);
> +	kblockd_schedule_work(&ns->head->requeue_work);
> +}

Need to call blk_mq_free_req after stealing all its bios to prevent
leaking that entered request.

All together, I needed just two small changes to the entire series to
get everything testing successfully. Here's the diff on top of your set:

---
diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index 5449c83..55620ba 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -115,6 +115,8 @@ static void nvme_failover_req(struct request *req)
 	blk_steal_bios(&ns->head->requeue_list, req);
 	spin_unlock_irqrestore(&ns->head->requeue_lock, flags);
 
+	blk_mq_free_request(req);
+
 	nvme_reset_ctrl(ns->ctrl);
 	kblockd_schedule_work(&ns->head->requeue_work);
 }
@@ -1935,6 +1937,9 @@ static int nvme_init_subsystem(struct nvme_ctrl *ctrl, struct nvme_id_ctrl *id)
 {
 	struct nvme_subsystem *subsys, *found;
 
+	if (ctrl->identified)
+		return 0;
+
 	subsys = kzalloc(sizeof(*subsys), GFP_KERNEL);
 	if (!subsys)
 		return -ENOMEM;
--
