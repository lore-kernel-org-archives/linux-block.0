Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mail-wm0-f65.google.com ([74.125.82.65]:36832 "EHLO
        mail-wm0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751231AbdLUIUt (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 21 Dec 2017 03:20:49 -0500
Received: by mail-wm0-f65.google.com with SMTP id b76so14216577wmg.1
        for <linux-block@vger.kernel.org>; Thu, 21 Dec 2017 00:20:48 -0800 (PST)
Subject: Re: [PATCH V2 6/6] nvme-pci: remove .init_request callback
To: Ming Lei <ming.lei@redhat.com>, linux-nvme@lists.infradead.org,
        Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@fb.com>,
        linux-block@vger.kernel.org
Cc: Bart Van Assche <bart.vanassche@sandisk.com>,
        Keith Busch <keith.busch@intel.com>,
        Yi Zhang <yi.zhang@redhat.com>,
        Johannes Thumshirn <jthumshirn@suse.de>
References: <20171214023103.18272-1-ming.lei@redhat.com>
 <20171214023103.18272-7-ming.lei@redhat.com>
From: Sagi Grimberg <sagi@grimberg.me>
Message-ID: <0fcf3176-7864-8631-e293-2bfa7aacea38@grimberg.me>
Date: Thu, 21 Dec 2017 10:20:45 +0200
MIME-Version: 1.0
In-Reply-To: <20171214023103.18272-7-ming.lei@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

Ming,

I'd prefer that we make the pci driver match
the rest of the drivers in nvme.

IMO it would be better to allocate a queues array at probe time
and simply reuse it at reset sequence.

Can this (untested) patch also fix the issue your seeing:
--
diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c
index f26aaa393016..a8edb29dac16 100644
--- a/drivers/nvme/host/pci.c
+++ b/drivers/nvme/host/pci.c
@@ -75,7 +75,7 @@ static void nvme_dev_disable(struct nvme_dev *dev, 
bool shutdown);
   * Represents an NVM Express device.  Each nvme_dev is a PCI function.
   */
  struct nvme_dev {
-       struct nvme_queue **queues;
+       struct nvme_queue *queues;
         struct blk_mq_tag_set tagset;
         struct blk_mq_tag_set admin_tagset;
         u32 __iomem *dbs;
@@ -365,7 +365,7 @@ static int nvme_admin_init_hctx(struct blk_mq_hw_ctx 
*hctx, void *data,
                                 unsigned int hctx_idx)
  {
         struct nvme_dev *dev = data;
-       struct nvme_queue *nvmeq = dev->queues[0];
+       struct nvme_queue *nvmeq = &dev->queues[0];

         WARN_ON(hctx_idx != 0);
         WARN_ON(dev->admin_tagset.tags[0] != hctx->tags);
@@ -387,7 +387,7 @@ static int nvme_init_hctx(struct blk_mq_hw_ctx 
*hctx, void *data,
                           unsigned int hctx_idx)
  {
         struct nvme_dev *dev = data;
-       struct nvme_queue *nvmeq = dev->queues[hctx_idx + 1];
+       struct nvme_queue *nvmeq = &dev->queues[hctx_idx + 1];

         if (!nvmeq->tags)
                 nvmeq->tags = &dev->tagset.tags[hctx_idx];
@@ -403,7 +403,7 @@ static int nvme_init_request(struct blk_mq_tag_set 
*set, struct request *req,
         struct nvme_dev *dev = set->driver_data;
         struct nvme_iod *iod = blk_mq_rq_to_pdu(req);
         int queue_idx = (set == &dev->tagset) ? hctx_idx + 1 : 0;
-       struct nvme_queue *nvmeq = dev->queues[queue_idx];
+       struct nvme_queue *nvmeq = &dev->queues[queue_idx];

         BUG_ON(!nvmeq);
         iod->nvmeq = nvmeq;
@@ -1046,7 +1046,7 @@ static int nvme_poll(struct blk_mq_hw_ctx *hctx, 
unsigned int tag)
  static void nvme_pci_submit_async_event(struct nvme_ctrl *ctrl)
  {
         struct nvme_dev *dev = to_nvme_dev(ctrl);
-       struct nvme_queue *nvmeq = dev->queues[0];
+       struct nvme_queue *nvmeq = &dev->queues[0];
         struct nvme_command c;

         memset(&c, 0, sizeof(c));
@@ -1290,10 +1290,8 @@ static void nvme_free_queues(struct nvme_dev 
*dev, int lowest)
         int i;

         for (i = dev->ctrl.queue_count - 1; i >= lowest; i--) {
-               struct nvme_queue *nvmeq = dev->queues[i];
                 dev->ctrl.queue_count--;
-               dev->queues[i] = NULL;
-               nvme_free_queue(nvmeq);
+               nvme_free_queue(&dev->queues[i]);
         }
  }

@@ -1325,7 +1323,7 @@ static int nvme_suspend_queue(struct nvme_queue 
*nvmeq)

  static void nvme_disable_admin_queue(struct nvme_dev *dev, bool shutdown)
  {
-       struct nvme_queue *nvmeq = dev->queues[0];
+       struct nvme_queue *nvmeq = &dev->queues[0];

         if (!nvmeq)
                 return;
@@ -1387,10 +1385,7 @@ static int nvme_alloc_sq_cmds(struct nvme_dev 
*dev, struct nvme_queue *nvmeq,
  static struct nvme_queue *nvme_alloc_queue(struct nvme_dev *dev, int qid,
                                                         int depth, int 
node)
  {
-       struct nvme_queue *nvmeq = kzalloc_node(sizeof(*nvmeq), GFP_KERNEL,
-                                                       node);
-       if (!nvmeq)
-               return NULL;
+       struct nvme_queue *nvmeq = &dev->queues[qid];

         nvmeq->cqes = dma_zalloc_coherent(dev->dev, CQ_SIZE(depth),
                                           &nvmeq->cq_dma_addr, GFP_KERNEL);
@@ -1409,7 +1404,6 @@ static struct nvme_queue *nvme_alloc_queue(struct 
nvme_dev *dev, int qid,
         nvmeq->q_depth = depth;
         nvmeq->qid = qid;
         nvmeq->cq_vector = -1;
-       dev->queues[qid] = nvmeq;
         dev->ctrl.queue_count++;

         return nvmeq;
@@ -1592,7 +1586,7 @@ static int nvme_pci_configure_admin_queue(struct 
nvme_dev *dev)
         if (result < 0)
                 return result;

-       nvmeq = dev->queues[0];
+       nvmeq = &dev->queues[0];
         if (!nvmeq) {
                 nvmeq = nvme_alloc_queue(dev, 0, NVME_AQ_DEPTH,
                                         dev_to_node(dev->dev));
@@ -1638,7 +1632,7 @@ static int nvme_create_io_queues(struct nvme_dev *dev)

         max = min(dev->max_qid, dev->ctrl.queue_count - 1);
         for (i = dev->online_queues; i <= max; i++) {
-               ret = nvme_create_queue(dev->queues[i], i);
+               ret = nvme_create_queue(&dev->queues[i], i);
                 if (ret)
                         break;
         }
@@ -1894,7 +1888,7 @@ static int nvme_setup_host_mem(struct nvme_dev *dev)

  static int nvme_setup_io_queues(struct nvme_dev *dev)
  {
-       struct nvme_queue *adminq = dev->queues[0];
+       struct nvme_queue *adminq = &dev->queues[0];
         struct pci_dev *pdev = to_pci_dev(dev->dev);
         int result, nr_io_queues;
         unsigned long size;
@@ -2020,7 +2014,7 @@ static void nvme_disable_io_queues(struct nvme_dev 
*dev, int queues)
   retry:
                 timeout = ADMIN_TIMEOUT;
                 for (; i > 0; i--, sent++)
-                       if (nvme_delete_queue(dev->queues[i], opcode))
+                       if (nvme_delete_queue(&dev->queues[i], opcode))
                                 break;

                 while (sent--) {
@@ -2209,7 +2203,7 @@ static void nvme_dev_disable(struct nvme_dev *dev, 
bool shutdown)

         queues = dev->online_queues - 1;
         for (i = dev->ctrl.queue_count - 1; i > 0; i--)
-               nvme_suspend_queue(dev->queues[i]);
+               nvme_suspend_queue(&dev->queues[i]);

         if (dead) {
                 /* A device might become IO incapable very soon during
@@ -2217,7 +2211,7 @@ static void nvme_dev_disable(struct nvme_dev *dev, 
bool shutdown)
                  * queue_count can be 0 here.
                  */
                 if (dev->ctrl.queue_count)
-                       nvme_suspend_queue(dev->queues[0]);
+                       nvme_suspend_queue(&dev->queues[0]);
         } else {
                 nvme_disable_io_queues(dev, queues);
                 nvme_disable_admin_queue(dev, shutdown);
@@ -2462,6 +2456,7 @@ static int nvme_probe(struct pci_dev *pdev, const 
struct pci_device_id *id)
         int node, result = -ENOMEM;
         struct nvme_dev *dev;
         unsigned long quirks = id->driver_data;
+       unsigned int alloc_size;

         node = dev_to_node(&pdev->dev);
         if (node == NUMA_NO_NODE)
@@ -2470,8 +2465,9 @@ static int nvme_probe(struct pci_dev *pdev, const 
struct pci_device_id *id)
         dev = kzalloc_node(sizeof(*dev), GFP_KERNEL, node);
         if (!dev)
                 return -ENOMEM;
-       dev->queues = kzalloc_node((num_possible_cpus() + 1) * 
sizeof(void *),
-                                                       GFP_KERNEL, node);
+
+       alloc_size = (num_possible_cpus() + 1) * sizeof(struct 
nvme_queue *);
+       dev->queues = kzalloc_node(alloc_size, GFP_KERNEL, node);
         if (!dev->queues)
                 goto free;
--
