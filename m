Return-Path: <jianchao.w.wang@oracle.com>
Subject: Re: [PATCH V5 0/9] nvme: pci: fix & improve timeout handling
To: Ming Lei <ming.lei@redhat.com>
Cc: Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
        Laurence Oberman <loberman@redhat.com>,
        Sagi Grimberg <sagi@grimberg.me>,
        James Smart <james.smart@broadcom.com>, linux-nvme@lists.infradead.org,
        Keith Busch <keith.busch@intel.com>, Christoph Hellwig <hch@lst.de>
References: <20180511122933.27155-1-ming.lei@redhat.com>
 <776f21e1-dc19-1b77-9ba4-44f0b8366625@oracle.com>
 <20180514093850.GA807@ming.t460p>
 <008cb38d-aa91-6ab7-64d9-417d6c53a1eb@oracle.com>
 <20180514122211.GB807@ming.t460p> <20180515003332.GB21743@ming.t460p>
 <d97b375f-9b47-6b95-bd5b-8166dae93676@oracle.com>
 <20180515125640.GC13679@ming.t460p>
From: "jianchao.wang" <jianchao.w.wang@oracle.com>
Message-ID: <d54bd139-888c-c1dd-ae54-8959a31b404a@oracle.com>
Date: Wed, 16 May 2018 11:03:09 +0800
MIME-Version: 1.0
In-Reply-To: <20180515125640.GC13679@ming.t460p>
Content-Type: multipart/mixed;
 boundary="------------0BCD74E933FF1A68A3AD0DF5"
List-ID: <linux-block@vger.kernel.org>

This is a multi-part message in MIME format.
--------------0BCD74E933FF1A68A3AD0DF5
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit

Hi Ming

On 05/15/2018 08:56 PM, Ming Lei wrote:
> Looks a nice fix on nvme_create_queue(), but seems the change on 
> adapter_alloc_cq() is missed in above patch.
> 
> Could you prepare a formal one so that I may integrate it to V6?

Please refer to

Thanks
Jianchao

--------------0BCD74E933FF1A68A3AD0DF5
Content-Type: text/x-patch;
 name="0001-nvme-pci-set-nvmeq-cq_vector-after-alloc-cq-sq.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
 filename*0="0001-nvme-pci-set-nvmeq-cq_vector-after-alloc-cq-sq.patch"

>From 9bb6db79901ef303cd40c4c911604bc053b1ad95 Mon Sep 17 00:00:00 2001
From: Jianchao Wang <jianchao.w.wang@oracle.com>
Date: Wed, 16 May 2018 09:45:45 +0800
Subject: [PATCH] nvme-pci: set nvmeq->cq_vector after alloc cq/sq

Currently nvmeq->cq_vector is set before alloc cq/sq. If the alloc
cq/sq command timeout, nvme_suspend_queue will invoke free_irq
for the nvmeq because the cq_vector is valid, this will cause warning
'Trying to free already-free IRQ xxx'. set nvmeq->cq_vector after
alloc cq/sq successes to fix this.

Signed-off-by: Jianchao Wang <jianchao.w.wang@oracle.com>
---
 drivers/nvme/host/pci.c | 25 ++++++++++++++++---------
 1 file changed, 16 insertions(+), 9 deletions(-)

diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c
index fbc71fa..c830092 100644
--- a/drivers/nvme/host/pci.c
+++ b/drivers/nvme/host/pci.c
@@ -1070,7 +1070,7 @@ static int adapter_delete_queue(struct nvme_dev *dev, u8 opcode, u16 id)
 }
 
 static int adapter_alloc_cq(struct nvme_dev *dev, u16 qid,
-						struct nvme_queue *nvmeq)
+						struct nvme_queue *nvmeq, int cq_vector)
 {
 	struct nvme_command c;
 	int flags = NVME_QUEUE_PHYS_CONTIG | NVME_CQ_IRQ_ENABLED;
@@ -1085,7 +1085,7 @@ static int adapter_alloc_cq(struct nvme_dev *dev, u16 qid,
 	c.create_cq.cqid = cpu_to_le16(qid);
 	c.create_cq.qsize = cpu_to_le16(nvmeq->q_depth - 1);
 	c.create_cq.cq_flags = cpu_to_le16(flags);
-	c.create_cq.irq_vector = cpu_to_le16(nvmeq->cq_vector);
+	c.create_cq.irq_vector = cpu_to_le16(cq_vector);
 
 	return nvme_submit_sync_cmd(dev->ctrl.admin_q, &c, NULL, 0);
 }
@@ -1450,6 +1450,7 @@ static int nvme_create_queue(struct nvme_queue *nvmeq, int qid)
 {
 	struct nvme_dev *dev = nvmeq->dev;
 	int result;
+	int cq_vector;
 
 	if (dev->cmb && use_cmb_sqes && (dev->cmbsz & NVME_CMBSZ_SQS)) {
 		unsigned offset = (qid - 1) * roundup(SQ_SIZE(nvmeq->q_depth),
@@ -1462,15 +1463,21 @@ static int nvme_create_queue(struct nvme_queue *nvmeq, int qid)
 	 * A queue's vector matches the queue identifier unless the controller
 	 * has only one vector available.
 	 */
-	nvmeq->cq_vector = dev->num_vecs == 1 ? 0 : qid;
-	result = adapter_alloc_cq(dev, qid, nvmeq);
+	cq_vector = dev->num_vecs == 1 ? 0 : qid;
+	result = adapter_alloc_cq(dev, qid, nvmeq, cq_vector);
 	if (result < 0)
-		goto release_vector;
+		goto out;
 
 	result = adapter_alloc_sq(dev, qid, nvmeq);
 	if (result < 0)
 		goto release_cq;
 
+	/*
+	 * set cq_vector after alloc cq/sq, otherwise, if alloc cq/sq command
+	 * timeout, nvme_suspend_queue will invoke free_irq for it and cause warning
+	 * 'Trying to free already-free IRQ xxx'
+	 */
+	nvmeq->cq_vector = cq_vector;
 	nvme_init_queue(nvmeq, qid);
 	result = queue_request_irq(nvmeq);
 	if (result < 0)
@@ -1478,13 +1485,13 @@ static int nvme_create_queue(struct nvme_queue *nvmeq, int qid)
 
 	return result;
 
- release_sq:
+release_sq:
+	nvmeq->cq_vector = -1;
 	dev->online_queues--;
 	adapter_delete_sq(dev, qid);
- release_cq:
+release_cq:
 	adapter_delete_cq(dev, qid);
- release_vector:
-	nvmeq->cq_vector = -1;
+out:
 	return result;
 }
 
-- 
2.7.4


--------------0BCD74E933FF1A68A3AD0DF5--
