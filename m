Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mail-pa0-f66.google.com ([209.85.220.66]:33042 "EHLO
        mail-pa0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S966025AbcIWWVQ (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 23 Sep 2016 18:21:16 -0400
Subject: Re: [PATCH 11/13] nvme: switch to use pci_alloc_irq_vectors
To: Christoph Hellwig <hch@lst.de>, axboe@fb.com, tglx@linutronix.de
References: <1473862739-15032-1-git-send-email-hch@lst.de>
 <1473862739-15032-12-git-send-email-hch@lst.de>
Cc: agordeev@redhat.com, keith.busch@intel.com,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org
From: Sagi Grimberg <sagi@grimberg.me>
Message-ID: <c8150106-764e-f8e9-4c1c-27e60ad96e83@grimberg.me>
Date: Fri, 23 Sep 2016 15:21:14 -0700
MIME-Version: 1.0
In-Reply-To: <1473862739-15032-12-git-send-email-hch@lst.de>
Content-Type: text/plain; charset=windows-1252; format=flowed
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org



On 14/09/16 07:18, Christoph Hellwig wrote:
> Use the new helper to automatically select the right interrupt type, as
> well as to use the automatic interupt affinity assignment.

Patch title and the change description are a little short IMO to
describe what is going on here (need the blk-mq side too).

I'd also think it would be better to split this to 2 patches but
really not a must...

> +static int nvme_pci_map_queues(struct blk_mq_tag_set *set)
> +{
> +	struct nvme_dev *dev = set->driver_data;
> +
> +	return blk_mq_pci_map_queues(set, to_pci_dev(dev->dev));
> +}
> +

Question: is using pci_alloc_irq_vectors() obligated for
supplying blk-mq with the device affinity mask?

If I do this completely-untested [1] what will happen?

[1]:
--
diff --git a/drivers/nvme/host/rdma.c b/drivers/nvme/host/rdma.c
index 8d2875b4c56d..76693d406efe 100644
--- a/drivers/nvme/host/rdma.c
+++ b/drivers/nvme/host/rdma.c
@@ -1518,6 +1518,14 @@ static void nvme_rdma_complete_rq(struct request *rq)
         blk_mq_end_request(rq, error);
  }

+static int nvme_rdma_map_queues(struct blk_mq_tag_set *set)
+{
+       struct nvme_rdma_ctrl *ctrl = set->driver_data;
+       struct device *dev = ctrl->device->dev.dma_device;
+
+       return blk_mq_pci_map_queues(set, to_pci_dev(dev));
+}
+
  static struct blk_mq_ops nvme_rdma_mq_ops = {
         .queue_rq       = nvme_rdma_queue_rq,
         .complete       = nvme_rdma_complete_rq,
@@ -1528,6 +1536,7 @@ static struct blk_mq_ops nvme_rdma_mq_ops = {
         .init_hctx      = nvme_rdma_init_hctx,
         .poll           = nvme_rdma_poll,
         .timeout        = nvme_rdma_timeout,
+       .map_queues     = nvme_rdma_map_queues,
  };

  static struct blk_mq_ops nvme_rdma_admin_mq_ops = {
--
