Return-Path: <SRS0=RDeE=T7=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7A22FC28CC0
	for <linux-block@archiver.kernel.org>; Fri, 31 May 2019 02:29:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5C6A125F06
	for <linux-block@archiver.kernel.org>; Fri, 31 May 2019 02:29:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726724AbfEaC3B (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 30 May 2019 22:29:01 -0400
Received: from mx1.redhat.com ([209.132.183.28]:34962 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726372AbfEaC3A (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Thu, 30 May 2019 22:29:00 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 2A8AE307D8BE;
        Fri, 31 May 2019 02:29:00 +0000 (UTC)
Received: from localhost (ovpn-8-17.pek2.redhat.com [10.72.8.17])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 364AE643EF;
        Fri, 31 May 2019 02:28:58 +0000 (UTC)
From:   Ming Lei <ming.lei@redhat.com>
To:     Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
        linux-scsi@vger.kernel.org,
        "Martin K . Petersen" <martin.petersen@oracle.com>
Cc:     James Bottomley <James.Bottomley@HansenPartnership.com>,
        Bart Van Assche <bvanassche@acm.org>,
        Hannes Reinecke <hare@suse.com>,
        John Garry <john.garry@huawei.com>,
        Don Brace <don.brace@microsemi.com>,
        Kashyap Desai <kashyap.desai@broadcom.com>,
        Sathya Prakash <sathya.prakash@broadcom.com>,
        Christoph Hellwig <hch@lst.de>, Ming Lei <ming.lei@redhat.com>
Subject: [PATCH 8/9] scsi: megaraid: convert private reply queue to blk-mq hw queue
Date:   Fri, 31 May 2019 10:28:00 +0800
Message-Id: <20190531022801.10003-9-ming.lei@redhat.com>
In-Reply-To: <20190531022801.10003-1-ming.lei@redhat.com>
References: <20190531022801.10003-1-ming.lei@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.48]); Fri, 31 May 2019 02:29:00 +0000 (UTC)
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

SCSI's reply qeueue is very similar with blk-mq's hw queue, both
assigned by IRQ vector, so map te private reply queue into blk-mq's hw
queue via .host_tagset.

Then the private reply mapping can be removed.

Another benefit is that the request/irq lost issue may be solved in
generic approach because managed IRQ may be shutdown during CPU
hotplug.

Signed-off-by: Ming Lei <ming.lei@redhat.com>
---
 drivers/scsi/megaraid/megaraid_sas_base.c   | 50 ++++++++-------------
 drivers/scsi/megaraid/megaraid_sas_fusion.c |  4 +-
 2 files changed, 20 insertions(+), 34 deletions(-)

diff --git a/drivers/scsi/megaraid/megaraid_sas_base.c b/drivers/scsi/megaraid/megaraid_sas_base.c
index 3dd1df472dc6..b49999b90231 100644
--- a/drivers/scsi/megaraid/megaraid_sas_base.c
+++ b/drivers/scsi/megaraid/megaraid_sas_base.c
@@ -33,6 +33,7 @@
 #include <linux/fs.h>
 #include <linux/compat.h>
 #include <linux/blkdev.h>
+#include <linux/blk-mq-pci.h>
 #include <linux/mutex.h>
 #include <linux/poll.h>
 #include <linux/vmalloc.h>
@@ -3165,6 +3166,19 @@ megasas_fw_cmds_outstanding_show(struct device *cdev,
 	return snprintf(buf, PAGE_SIZE, "%d\n", atomic_read(&instance->fw_outstanding));
 }
 
+static int megasas_map_queues(struct Scsi_Host *shost)
+{
+	struct megasas_instance *instance = (struct megasas_instance *)
+		shost->hostdata;
+	struct blk_mq_queue_map *qmap = &shost->tag_set.map[HCTX_TYPE_DEFAULT];
+
+	if (smp_affinity_enable && instance->msix_vectors)
+		return blk_mq_pci_map_queues(qmap, instance->pdev, 0);
+	else
+		return blk_mq_map_queues(qmap);
+}
+
+
 static DEVICE_ATTR(fw_crash_buffer, S_IRUGO | S_IWUSR,
 	megasas_fw_crash_buffer_show, megasas_fw_crash_buffer_store);
 static DEVICE_ATTR(fw_crash_buffer_size, S_IRUGO,
@@ -3207,7 +3221,9 @@ static struct scsi_host_template megasas_template = {
 	.shost_attrs = megaraid_host_attrs,
 	.bios_param = megasas_bios_param,
 	.change_queue_depth = scsi_change_queue_depth,
+	.map_queues =  megasas_map_queues,
 	.no_write_same = 1,
+	.host_tagset = 1,
 };
 
 /**
@@ -5407,26 +5423,6 @@ megasas_setup_jbod_map(struct megasas_instance *instance)
 		instance->use_seqnum_jbod_fp = false;
 }
 
-static void megasas_setup_reply_map(struct megasas_instance *instance)
-{
-	const struct cpumask *mask;
-	unsigned int queue, cpu;
-
-	for (queue = 0; queue < instance->msix_vectors; queue++) {
-		mask = pci_irq_get_affinity(instance->pdev, queue);
-		if (!mask)
-			goto fallback;
-
-		for_each_cpu(cpu, mask)
-			instance->reply_map[cpu] = queue;
-	}
-	return;
-
-fallback:
-	for_each_possible_cpu(cpu)
-		instance->reply_map[cpu] = cpu % instance->msix_vectors;
-}
-
 /**
  * megasas_get_device_list -	Get the PD and LD device list from FW.
  * @instance:			Adapter soft state
@@ -5666,8 +5662,6 @@ static int megasas_init_fw(struct megasas_instance *instance)
 			goto fail_init_adapter;
 	}
 
-	megasas_setup_reply_map(instance);
-
 	dev_info(&instance->pdev->dev,
 		"firmware supports msix\t: (%d)", fw_msix_count);
 	dev_info(&instance->pdev->dev,
@@ -6298,6 +6292,8 @@ static int megasas_io_attach(struct megasas_instance *instance)
 	host->max_lun = MEGASAS_MAX_LUN;
 	host->max_cmd_len = 16;
 
+	host->nr_hw_queues = instance->msix_vectors ?: 1;
+
 	/*
 	 * Notify the mid-layer about the new controller
 	 */
@@ -6464,11 +6460,6 @@ static inline int megasas_alloc_mfi_ctrl_mem(struct megasas_instance *instance)
  */
 static int megasas_alloc_ctrl_mem(struct megasas_instance *instance)
 {
-	instance->reply_map = kcalloc(nr_cpu_ids, sizeof(unsigned int),
-				      GFP_KERNEL);
-	if (!instance->reply_map)
-		return -ENOMEM;
-
 	switch (instance->adapter_type) {
 	case MFI_SERIES:
 		if (megasas_alloc_mfi_ctrl_mem(instance))
@@ -6485,8 +6476,6 @@ static int megasas_alloc_ctrl_mem(struct megasas_instance *instance)
 
 	return 0;
  fail:
-	kfree(instance->reply_map);
-	instance->reply_map = NULL;
 	return -ENOMEM;
 }
 
@@ -6499,7 +6488,6 @@ static int megasas_alloc_ctrl_mem(struct megasas_instance *instance)
  */
 static inline void megasas_free_ctrl_mem(struct megasas_instance *instance)
 {
-	kfree(instance->reply_map);
 	if (instance->adapter_type == MFI_SERIES) {
 		if (instance->producer)
 			dma_free_coherent(&instance->pdev->dev, sizeof(u32),
@@ -7142,8 +7130,6 @@ megasas_resume(struct pci_dev *pdev)
 	if (rval < 0)
 		goto fail_reenable_msix;
 
-	megasas_setup_reply_map(instance);
-
 	if (instance->adapter_type != MFI_SERIES) {
 		megasas_reset_reply_desc(instance);
 		if (megasas_ioc_init_fusion(instance)) {
diff --git a/drivers/scsi/megaraid/megaraid_sas_fusion.c b/drivers/scsi/megaraid/megaraid_sas_fusion.c
index 4dfa0685a86c..4f909f32bf5c 100644
--- a/drivers/scsi/megaraid/megaraid_sas_fusion.c
+++ b/drivers/scsi/megaraid/megaraid_sas_fusion.c
@@ -2699,7 +2699,7 @@ megasas_build_ldio_fusion(struct megasas_instance *instance,
 	}
 
 	cmd->request_desc->SCSIIO.MSIxIndex =
-		instance->reply_map[raw_smp_processor_id()];
+		scsi_cmnd_hctx_index(instance->host, scp);
 
 	if (instance->adapter_type >= VENTURA_SERIES) {
 		/* FP for Optimal raid level 1.
@@ -3013,7 +3013,7 @@ megasas_build_syspd_fusion(struct megasas_instance *instance,
 	cmd->request_desc->SCSIIO.DevHandle = io_request->DevHandle;
 
 	cmd->request_desc->SCSIIO.MSIxIndex =
-		instance->reply_map[raw_smp_processor_id()];
+		scsi_cmnd_hctx_index(instance->host, scmd);
 
 	if (!fp_possible) {
 		/* system pd firmware path */
-- 
2.20.1

