Return-Path: <SRS0=RDeE=T7=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E23FCC04AB6
	for <linux-block@archiver.kernel.org>; Fri, 31 May 2019 11:38:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AD3232684C
	for <linux-block@archiver.kernel.org>; Fri, 31 May 2019 11:38:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726724AbfEaLi2 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 31 May 2019 07:38:28 -0400
Received: from szxga05-in.huawei.com ([45.249.212.191]:17636 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726158AbfEaLi1 (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Fri, 31 May 2019 07:38:27 -0400
Received: from DGGEMS411-HUB.china.huawei.com (unknown [172.30.72.59])
        by Forcepoint Email with ESMTP id B126A814EBEEACD0F244;
        Fri, 31 May 2019 19:38:24 +0800 (CST)
Received: from [127.0.0.1] (10.202.227.238) by DGGEMS411-HUB.china.huawei.com
 (10.3.19.211) with Microsoft SMTP Server id 14.3.439.0; Fri, 31 May 2019
 19:38:19 +0800
Subject: Re: [PATCH 7/9] scsi: hisi_sas_v3: convert private reply queue to
 blk-mq hw queue
To:     Ming Lei <tom.leiming@gmail.com>, Hannes Reinecke <hare@suse.de>
References: <20190531022801.10003-1-ming.lei@redhat.com>
 <20190531022801.10003-8-ming.lei@redhat.com>
 <1afb4353-6703-a3f0-ca6c-d0b2bd754a56@suse.de>
 <CACVXFVMG8gkw8E0pmWBJC0tBH9D-WVjY2FnL2gsxDja3ryfbng@mail.gmail.com>
CC:     Ming Lei <ming.lei@redhat.com>, Jens Axboe <axboe@kernel.dk>,
        linux-block <linux-block@vger.kernel.org>,
        Linux SCSI List <linux-scsi@vger.kernel.org>,
        "Martin K . Petersen" <martin.petersen@oracle.com>,
        James Bottomley <James.Bottomley@hansenpartnership.com>,
        Bart Van Assche <bvanassche@acm.org>,
        Hannes Reinecke <hare@suse.com>,
        Don Brace <don.brace@microsemi.com>,
        Kashyap Desai <kashyap.desai@broadcom.com>,
        "Sathya Prakash" <sathya.prakash@broadcom.com>,
        Christoph Hellwig <hch@lst.de>
From:   John Garry <john.garry@huawei.com>
Message-ID: <c11faee4-fc38-9636-59b4-bc5c0d94ffbf@huawei.com>
Date:   Fri, 31 May 2019 12:38:10 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:45.0) Gecko/20100101
 Thunderbird/45.3.0
MIME-Version: 1.0
In-Reply-To: <CACVXFVMG8gkw8E0pmWBJC0tBH9D-WVjY2FnL2gsxDja3ryfbng@mail.gmail.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.202.227.238]
X-CFilter-Loop: Reflected
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org


>>> -fallback:
>>> -     for_each_possible_cpu(cpu)
>>> -             hisi_hba->reply_map[cpu] = cpu % hisi_hba->queue_count;
>>> -     /* Don't clean all CQ masks */
>>> -}
>>> -
>>>  static int interrupt_init_v3_hw(struct hisi_hba *hisi_hba)
>>>  {
>>>       struct device *dev = hisi_hba->dev;
>>> @@ -2383,11 +2359,6 @@ static int interrupt_init_v3_hw(struct hisi_hba *hisi_hba)
>>>
>>>               min_msi = MIN_AFFINE_VECTORS_V3_HW;
>>>
>>> -             hisi_hba->reply_map = devm_kcalloc(dev, nr_cpu_ids,
>>> -                                                sizeof(unsigned int),
>>> -                                                GFP_KERNEL);
>>> -             if (!hisi_hba->reply_map)
>>> -                     return -ENOMEM;
>>>               vectors = pci_alloc_irq_vectors_affinity(hisi_hba->pci_dev,
>>>                                                        min_msi, max_msi,
>>>                                                        PCI_IRQ_MSI |
>>> @@ -2395,7 +2366,6 @@ static int interrupt_init_v3_hw(struct hisi_hba *hisi_hba)
>>>                                                        &desc);
>>>               if (vectors < 0)
>>>                       return -ENOENT;
>>> -             setup_reply_map_v3_hw(hisi_hba, vectors - BASE_VECTORS_V3_HW);
>>>       } else {
>>>               min_msi = max_msi;
>>>               vectors = pci_alloc_irq_vectors(hisi_hba->pci_dev, min_msi,
>>> @@ -2896,6 +2866,18 @@ static void debugfs_snapshot_restore_v3_hw(struct hisi_hba *hisi_hba)
>>>       clear_bit(HISI_SAS_REJECT_CMD_BIT, &hisi_hba->flags);
>>>  }
>>>
>>> +static int hisi_sas_map_queues(struct Scsi_Host *shost)
>>> +{
>>> +     struct hisi_hba *hisi_hba = shost_priv(shost);
>>> +     struct blk_mq_queue_map *qmap = &shost->tag_set.map[HCTX_TYPE_DEFAULT];
>>> +
>>> +     if (auto_affine_msi_experimental)
>>> +             return blk_mq_pci_map_queues(qmap, hisi_hba->pci_dev,
>>> +                             BASE_VECTORS_V3_HW);
>>> +     else
>>> +             return blk_mq_map_queues(qmap);

I don't think that the mapping which blk_mq_map_queues() creates are not 
want we want. I'm guessing that we still would like a mapping similar to 
what blk_mq_pci_map_queues() produces, which is an even spread, putting 
adjacent CPUs on the same queue.

For my system with 96 cpus and 16 queues, blk_mq_map_queues() would map 
queue 0 to cpu 0, 16, 32, 48 ..., queue 1 to cpu 1, 17, 33 and so on.

>>> +}
>>> +
>>>  static struct scsi_host_template sht_v3_hw = {
>>>       .name                   = DRV_NAME,
>>>       .module                 = THIS_MODULE,
>>
>> As mentioned, we should be using a common function here.
>>
>>> @@ -2906,6 +2888,8 @@ static struct scsi_host_template sht_v3_hw = {
>>>       .scan_start             = hisi_sas_scan_start,
>>>       .change_queue_depth     = sas_change_queue_depth,
>>>       .bios_param             = sas_bios_param,
>>> +     .map_queues             = hisi_sas_map_queues,
>>> +     .host_tagset            = 1,
>>>       .this_id                = -1,
>>>       .sg_tablesize           = HISI_SAS_SGE_PAGE_CNT,
>>>       .sg_prot_tablesize      = HISI_SAS_SGE_PAGE_CNT,
>>> @@ -3092,6 +3076,8 @@ hisi_sas_v3_probe(struct pci_dev *pdev, const struct pci_device_id *id)
>>>       if (hisi_sas_debugfs_enable)
>>>               hisi_sas_debugfs_init(hisi_hba);
>>>
>>> +     shost->nr_hw_queues = hisi_hba->cq_nvecs;

There's an ordering issue here, which can be fixed without too much trouble.

Value hisi_hba->cq_nvecs is not set until after this point, in 
hisi_sas_v3_probe()->hw->hw_init->hisi_sas_v3_init()->interrupt_init_v3_hw() 


Please see revised patch, below.


>>> +
>>>       rc = scsi_add_host(shost, dev);
>>>       if (rc)
>>>               goto err_out_ha;
>>>
>> Well, I'd rather see the v3 hardware converted to 'real' blk-mq first;
>> the hardware itself is pretty much multiqueue already, so we should be
>> better off converting it to blk-mq.
>
>>From John Garry's input, the tags is still hostwide, then not sure how to
> partition the hostwide tags into each hw queue's tags. That can be quite
> hard to do if the queue depth isn't big enough.

JFYI, There is no limition on which command tags can be used on which queue.

And, as I mentioned in response to "hisi_sas_v3: multiqueue support", 
the hw queue depth is configurable, and we make it same value as max 
commands tags, that being 4096.

>
> Thanks,
> Ming Lei
>
> .
>

Thanks,
John

 From b3c4ded715e1a7282f59fbd216bd2f0e852986aa Mon Sep 17 00:00:00 2001
From: Ming Lei <ming.lei@redhat.com>
Date: Fri, 31 May 2019 10:27:59 +0800
Subject: [PATCH] scsi: hisi_sas_v3: convert private reply queue to blk-mq hw
  queue

SCSI's reply qeueue is very similar with blk-mq's hw queue, both
assigned by IRQ vector, so map te private reply queue into blk-mq's hw
queue via .host_tagset.

Then the private reply mapping can be removed.

Another benefit is that the request/irq lost issue may be solved in
generic approach because managed IRQ may be shutdown during CPU
hotplug.

Signed-off-by: Ming Lei <ming.lei@redhat.com>

diff --git a/drivers/scsi/hisi_sas/hisi_sas.h 
b/drivers/scsi/hisi_sas/hisi_sas.h
index fc87994b5d73..3d48848dbde7 100644
--- a/drivers/scsi/hisi_sas/hisi_sas.h
+++ b/drivers/scsi/hisi_sas/hisi_sas.h
@@ -26,6 +26,7 @@
  #include <linux/platform_device.h>
  #include <linux/property.h>
  #include <linux/regmap.h>
+#include <linux/blk-mq-pci.h>
  #include <scsi/sas_ata.h>
  #include <scsi/libsas.h>

@@ -378,7 +379,6 @@ struct hisi_hba {
  	u32 intr_coal_count;	/* Interrupt count to coalesce */

  	int cq_nvecs;
-	unsigned int *reply_map;

  	/* debugfs memories */
  	u32 *debugfs_global_reg;
diff --git a/drivers/scsi/hisi_sas/hisi_sas_main.c 
b/drivers/scsi/hisi_sas/hisi_sas_main.c
index 8a7feb8ed8d6..a1c1f30b9fdb 100644
--- a/drivers/scsi/hisi_sas/hisi_sas_main.c
+++ b/drivers/scsi/hisi_sas/hisi_sas_main.c
@@ -441,6 +441,19 @@ static int hisi_sas_dif_dma_map(struct hisi_hba 
*hisi_hba,
  	return rc;
  }

+static struct scsi_cmnd *sas_task_to_scsi_cmd(struct sas_task *task)
+{
+	if (!task->uldd_task)
+		return NULL;
+
+	if (dev_is_sata(task->dev)) {
+		struct ata_queued_cmd *qc = task->uldd_task;
+		return qc->scsicmd;
+	} else {
+		return task->uldd_task;
+	}
+}
+
  static int hisi_sas_task_prep(struct sas_task *task,
  			      struct hisi_sas_dq **dq_pointer,
  			      bool is_tmf, struct hisi_sas_tmf_task *tmf,
@@ -459,6 +472,7 @@ static int hisi_sas_task_prep(struct sas_task *task,
  	struct hisi_sas_dq *dq;
  	unsigned long flags;
  	int wr_q_index;
+	struct scsi_cmnd *scsi_cmnd;

  	if (DEV_IS_GONE(sas_dev)) {
  		if (sas_dev)
@@ -471,9 +485,10 @@ static int hisi_sas_task_prep(struct sas_task *task,
  		return -ECOMM;
  	}

-	if (hisi_hba->reply_map) {
-		int cpu = raw_smp_processor_id();
-		unsigned int dq_index = hisi_hba->reply_map[cpu];
+	scsi_cmnd = sas_task_to_scsi_cmd(task);
+	if (hisi_hba->shost->hostt->host_tagset) {
+		unsigned int dq_index = scsi_cmnd_hctx_index(
+				hisi_hba->shost, scsi_cmnd);

  		*dq_pointer = dq = &hisi_hba->dq[dq_index];
  	} else {
@@ -503,21 +518,8 @@ static int hisi_sas_task_prep(struct sas_task *task,

  	if (hisi_hba->hw->slot_index_alloc)
  		rc = hisi_hba->hw->slot_index_alloc(hisi_hba, device);
-	else {
-		struct scsi_cmnd *scsi_cmnd = NULL;
-
-		if (task->uldd_task) {
-			struct ata_queued_cmd *qc;
-
-			if (dev_is_sata(device)) {
-				qc = task->uldd_task;
-				scsi_cmnd = qc->scsicmd;
-			} else {
-				scsi_cmnd = task->uldd_task;
-			}
-		}
+	else
  		rc  = hisi_sas_slot_index_alloc(hisi_hba, scsi_cmnd);
-	}
  	if (rc < 0)
  		goto err_out_dif_dma_unmap;

diff --git a/drivers/scsi/hisi_sas/hisi_sas_v3_hw.c 
b/drivers/scsi/hisi_sas/hisi_sas_v3_hw.c
index 49620c2411df..0aa750cbefb3 100644
--- a/drivers/scsi/hisi_sas/hisi_sas_v3_hw.c
+++ b/drivers/scsi/hisi_sas/hisi_sas_v3_hw.c
@@ -2344,36 +2344,9 @@ static irqreturn_t cq_interrupt_v3_hw(int irq_no, 
void *p)
  	return IRQ_HANDLED;
  }

-static void setup_reply_map_v3_hw(struct hisi_hba *hisi_hba, int nvecs)
+static int interrupt_pre_init_v3_hw(struct hisi_hba *hisi_hba)
  {
-	const struct cpumask *mask;
-	int queue, cpu;
-
-	for (queue = 0; queue < nvecs; queue++) {
-		struct hisi_sas_cq *cq = &hisi_hba->cq[queue];
-
-		mask = pci_irq_get_affinity(hisi_hba->pci_dev, queue +
-					    BASE_VECTORS_V3_HW);
-		if (!mask)
-			goto fallback;
-		cq->pci_irq_mask = mask;
-		for_each_cpu(cpu, mask)
-			hisi_hba->reply_map[cpu] = queue;
-	}
-	return;
-
-fallback:
-	for_each_possible_cpu(cpu)
-		hisi_hba->reply_map[cpu] = cpu % hisi_hba->queue_count;
-	/* Don't clean all CQ masks */
-}
-
-static int interrupt_init_v3_hw(struct hisi_hba *hisi_hba)
-{
-	struct device *dev = hisi_hba->dev;
-	struct pci_dev *pdev = hisi_hba->pci_dev;
-	int vectors, rc;
-	int i, k;
+	int vectors;
  	int max_msi = HISI_SAS_MSI_COUNT_V3_HW, min_msi;

  	if (auto_affine_msi_experimental) {
@@ -2383,11 +2356,6 @@ static int interrupt_init_v3_hw(struct hisi_hba 
*hisi_hba)

  		min_msi = MIN_AFFINE_VECTORS_V3_HW;

-		hisi_hba->reply_map = devm_kcalloc(dev, nr_cpu_ids,
-						   sizeof(unsigned int),
-						   GFP_KERNEL);
-		if (!hisi_hba->reply_map)
-			return -ENOMEM;
  		vectors = pci_alloc_irq_vectors_affinity(hisi_hba->pci_dev,
  							 min_msi, max_msi,
  							 PCI_IRQ_MSI |
@@ -2395,7 +2363,6 @@ static int interrupt_init_v3_hw(struct hisi_hba 
*hisi_hba)
  							 &desc);
  		if (vectors < 0)
  			return -ENOENT;
-		setup_reply_map_v3_hw(hisi_hba, vectors - BASE_VECTORS_V3_HW);
  	} else {
  		min_msi = max_msi;
  		vectors = pci_alloc_irq_vectors(hisi_hba->pci_dev, min_msi,
@@ -2403,16 +2370,25 @@ static int interrupt_init_v3_hw(struct hisi_hba 
*hisi_hba)
  		if (vectors < 0)
  			return vectors;
  	}
-
  	hisi_hba->cq_nvecs = vectors - BASE_VECTORS_V3_HW;

+	return 0;
+}
+
+static int interrupt_init_v3_hw(struct hisi_hba *hisi_hba)
+{
+	struct device *dev = hisi_hba->dev;
+	struct pci_dev *pdev = hisi_hba->pci_dev;
+	int rc, i, k;
+
+	dev_err(dev,  "%s hisi_hba->cq_nvecs=%d\n", __func__, hisi_hba->cq_nvecs);
+
  	rc = devm_request_irq(dev, pci_irq_vector(pdev, 1),
  			      int_phy_up_down_bcast_v3_hw, 0,
  			      DRV_NAME " phy", hisi_hba);
  	if (rc) {
  		dev_err(dev, "could not request phy interrupt, rc=%d\n", rc);
-		rc = -ENOENT;
-		goto free_irq_vectors;
+		return -ENOENT;
  	}

  	rc = devm_request_irq(dev, pci_irq_vector(pdev, 2),
@@ -2467,8 +2443,6 @@ static int interrupt_init_v3_hw(struct hisi_hba 
*hisi_hba)
  	free_irq(pci_irq_vector(pdev, 2), hisi_hba);
  free_phy_irq:
  	free_irq(pci_irq_vector(pdev, 1), hisi_hba);
-free_irq_vectors:
-	pci_free_irq_vectors(pdev);
  	return rc;
  }

@@ -2896,6 +2870,18 @@ static void debugfs_snapshot_restore_v3_hw(struct 
hisi_hba *hisi_hba)
  	clear_bit(HISI_SAS_REJECT_CMD_BIT, &hisi_hba->flags);
  }

+static int hisi_sas_map_queues(struct Scsi_Host *shost)
+{
+	struct hisi_hba *hisi_hba = shost_priv(shost);
+	struct blk_mq_queue_map *qmap = &shost->tag_set.map[HCTX_TYPE_DEFAULT];
+
+	if (auto_affine_msi_experimental)
+		return blk_mq_pci_map_queues(qmap, hisi_hba->pci_dev,
+				BASE_VECTORS_V3_HW);
+	else
+		return blk_mq_map_queues(qmap);
+}
+
  static struct scsi_host_template sht_v3_hw = {
  	.name			= DRV_NAME,
  	.module			= THIS_MODULE,
@@ -2906,6 +2892,8 @@ static struct scsi_host_template sht_v3_hw = {
  	.scan_start		= hisi_sas_scan_start,
  	.change_queue_depth	= sas_change_queue_depth,
  	.bios_param		= sas_bios_param,
+	.map_queues		= hisi_sas_map_queues,
+	.host_tagset		= 1,
  	.this_id		= -1,
  	.sg_tablesize		= HISI_SAS_SGE_PAGE_CNT,
  	.sg_prot_tablesize	= HISI_SAS_SGE_PAGE_CNT,
@@ -3092,15 +3080,21 @@ hisi_sas_v3_probe(struct pci_dev *pdev, const 
struct pci_device_id *id)
  	if (hisi_sas_debugfs_enable)
  		hisi_sas_debugfs_init(hisi_hba);

+
+	rc = interrupt_pre_init_v3_hw(hisi_hba);
+	if (rc < 0)
+		goto err_out_interrupts;
+	shost->nr_hw_queues = hisi_hba->cq_nvecs;
+
  	rc = scsi_add_host(shost, dev);
  	if (rc)
-		goto err_out_ha;
+		goto err_out_interrupts;

  	rc = sas_register_ha(sha);
  	if (rc)
  		goto err_out_register_ha;

-	rc = hisi_hba->hw->hw_init(hisi_hba);
+	rc = hisi_sas_v3_init(hisi_hba);
  	if (rc)
  		goto err_out_register_ha;

@@ -3110,6 +3104,8 @@ hisi_sas_v3_probe(struct pci_dev *pdev, const 
struct pci_device_id *id)

  err_out_register_ha:
  	scsi_remove_host(shost);
+err_out_interrupts:
+	pci_free_irq_vectors(pdev);
  err_out_ha:
  	scsi_host_put(shost);
  err_out_regions:
-- 
2.17.1





