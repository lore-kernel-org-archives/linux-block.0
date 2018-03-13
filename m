Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:47754 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1752403AbeCMJnj (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Tue, 13 Mar 2018 05:43:39 -0400
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
        Ming Lei <ming.lei@redhat.com>, Hannes Reinecke <hare@suse.de>,
        James Bottomley <james.bottomley@hansenpartnership.com>,
        Artem Bityutskiy <artem.bityutskiy@intel.com>
Subject: [PATCH V5 2/5] scsi: megaraid_sas: fix selection of reply queue
Date: Tue, 13 Mar 2018 17:42:40 +0800
Message-Id: <20180313094243.8710-3-ming.lei@redhat.com>
In-Reply-To: <20180313094243.8710-1-ming.lei@redhat.com>
References: <20180313094243.8710-1-ming.lei@redhat.com>
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

>From 84676c1f21 (genirq/affinity: assign vectors to all possible CPUs),
one msix vector can be created without any online CPU mapped, then
command may be queued, and won't be notified after its completion.

This patch setups mapping between cpu and reply queue according to irq
affinity info retrived by pci_irq_get_affinity(), and uses this info
to choose reply queue for queuing one command.

Then the chosen reply queue has to be active, and fixes IO hang caused
by using inactive reply queue which doesn't have any online CPU mapped.

Cc: Hannes Reinecke <hare@suse.de>
Cc: "Martin K. Petersen" <martin.petersen@oracle.com>,
Cc: James Bottomley <james.bottomley@hansenpartnership.com>,
Cc: Christoph Hellwig <hch@lst.de>,
Cc: Don Brace <don.brace@microsemi.com>
Cc: Kashyap Desai <kashyap.desai@broadcom.com>
Cc: Laurence Oberman <loberman@redhat.com>
Cc: Mike Snitzer <snitzer@redhat.com>
Cc: Meelis Roos <mroos@linux.ee>
Cc: Artem Bityutskiy <artem.bityutskiy@intel.com>
Fixes: 84676c1f21e8 ("genirq/affinity: assign vectors to all possible CPUs")
Signed-off-by: Ming Lei <ming.lei@redhat.com>
---
 drivers/scsi/megaraid/megaraid_sas.h        |  1 +
 drivers/scsi/megaraid/megaraid_sas_base.c   | 39 ++++++++++++++++++++++++++---
 drivers/scsi/megaraid/megaraid_sas_fusion.c | 12 +++------
 3 files changed, 41 insertions(+), 11 deletions(-)

diff --git a/drivers/scsi/megaraid/megaraid_sas.h b/drivers/scsi/megaraid/megaraid_sas.h
index ba6503f37756..27fab8235ea5 100644
--- a/drivers/scsi/megaraid/megaraid_sas.h
+++ b/drivers/scsi/megaraid/megaraid_sas.h
@@ -2128,6 +2128,7 @@ enum MR_PD_TYPE {
 
 struct megasas_instance {
 
+	unsigned int *reply_map;
 	__le32 *producer;
 	dma_addr_t producer_h;
 	__le32 *consumer;
diff --git a/drivers/scsi/megaraid/megaraid_sas_base.c b/drivers/scsi/megaraid/megaraid_sas_base.c
index a71ee67df084..dde0798b8a91 100644
--- a/drivers/scsi/megaraid/megaraid_sas_base.c
+++ b/drivers/scsi/megaraid/megaraid_sas_base.c
@@ -5165,6 +5165,26 @@ megasas_setup_jbod_map(struct megasas_instance *instance)
 		instance->use_seqnum_jbod_fp = false;
 }
 
+static void megasas_setup_reply_map(struct megasas_instance *instance)
+{
+	const struct cpumask *mask;
+	unsigned int queue, cpu;
+
+	for (queue = 0; queue < instance->msix_vectors; queue++) {
+		mask = pci_irq_get_affinity(instance->pdev, queue);
+		if (!mask)
+			goto fallback;
+
+		for_each_cpu(cpu, mask)
+			instance->reply_map[cpu] = queue;
+	}
+	return;
+
+fallback:
+	for_each_possible_cpu(cpu)
+		instance->reply_map[cpu] = cpu % instance->msix_vectors;
+}
+
 /**
  * megasas_init_fw -	Initializes the FW
  * @instance:		Adapter soft state
@@ -5343,6 +5363,8 @@ static int megasas_init_fw(struct megasas_instance *instance)
 			goto fail_setup_irqs;
 	}
 
+	megasas_setup_reply_map(instance);
+
 	dev_info(&instance->pdev->dev,
 		"firmware supports msix\t: (%d)", fw_msix_count);
 	dev_info(&instance->pdev->dev,
@@ -6123,20 +6145,29 @@ static inline int megasas_alloc_mfi_ctrl_mem(struct megasas_instance *instance)
  */
 static int megasas_alloc_ctrl_mem(struct megasas_instance *instance)
 {
+	instance->reply_map = kzalloc(sizeof(unsigned int) * nr_cpu_ids,
+				      GFP_KERNEL);
+	if (!instance->reply_map)
+		return -ENOMEM;
+
 	switch (instance->adapter_type) {
 	case MFI_SERIES:
 		if (megasas_alloc_mfi_ctrl_mem(instance))
-			return -ENOMEM;
+			goto fail;
 		break;
 	case VENTURA_SERIES:
 	case THUNDERBOLT_SERIES:
 	case INVADER_SERIES:
 		if (megasas_alloc_fusion_context(instance))
-			return -ENOMEM;
+			goto fail;
 		break;
 	}
 
 	return 0;
+ fail:
+	kfree(instance->reply_map);
+	instance->reply_map = NULL;
+	return -ENOMEM;
 }
 
 /*
@@ -6148,6 +6179,7 @@ static int megasas_alloc_ctrl_mem(struct megasas_instance *instance)
  */
 static inline void megasas_free_ctrl_mem(struct megasas_instance *instance)
 {
+	kfree(instance->reply_map);
 	if (instance->adapter_type == MFI_SERIES) {
 		if (instance->producer)
 			pci_free_consistent(instance->pdev, sizeof(u32),
@@ -6540,7 +6572,6 @@ static int megasas_probe_one(struct pci_dev *pdev,
 		pci_free_irq_vectors(instance->pdev);
 fail_init_mfi:
 	scsi_host_put(host);
-
 fail_alloc_instance:
 	pci_disable_device(pdev);
 
@@ -6746,6 +6777,8 @@ megasas_resume(struct pci_dev *pdev)
 	if (rval < 0)
 		goto fail_reenable_msix;
 
+	megasas_setup_reply_map(instance);
+
 	if (instance->adapter_type != MFI_SERIES) {
 		megasas_reset_reply_desc(instance);
 		if (megasas_ioc_init_fusion(instance)) {
diff --git a/drivers/scsi/megaraid/megaraid_sas_fusion.c b/drivers/scsi/megaraid/megaraid_sas_fusion.c
index 073ced07e662..2994176a0121 100644
--- a/drivers/scsi/megaraid/megaraid_sas_fusion.c
+++ b/drivers/scsi/megaraid/megaraid_sas_fusion.c
@@ -2655,11 +2655,8 @@ megasas_build_ldio_fusion(struct megasas_instance *instance,
 			fp_possible = (io_info.fpOkForIo > 0) ? true : false;
 	}
 
-	/* Use raw_smp_processor_id() for now until cmd->request->cpu is CPU
-	   id by default, not CPU group id, otherwise all MSI-X queues won't
-	   be utilized */
-	cmd->request_desc->SCSIIO.MSIxIndex = instance->msix_vectors ?
-		raw_smp_processor_id() % instance->msix_vectors : 0;
+	cmd->request_desc->SCSIIO.MSIxIndex =
+		instance->reply_map[raw_smp_processor_id()];
 
 	praid_context = &io_request->RaidContext;
 
@@ -2985,10 +2982,9 @@ megasas_build_syspd_fusion(struct megasas_instance *instance,
 	}
 
 	cmd->request_desc->SCSIIO.DevHandle = io_request->DevHandle;
-	cmd->request_desc->SCSIIO.MSIxIndex =
-		instance->msix_vectors ?
-		(raw_smp_processor_id() % instance->msix_vectors) : 0;
 
+	cmd->request_desc->SCSIIO.MSIxIndex =
+		instance->reply_map[raw_smp_processor_id()];
 
 	if (!fp_possible) {
 		/* system pd firmware path */
-- 
2.9.5
