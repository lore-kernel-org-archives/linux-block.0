Return-Path: <SRS0=U0+/=T3=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 21334C04AB3
	for <linux-block@archiver.kernel.org>; Mon, 27 May 2019 15:03:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F2DFC2182B
	for <linux-block@archiver.kernel.org>; Mon, 27 May 2019 15:03:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726884AbfE0PDG (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 27 May 2019 11:03:06 -0400
Received: from mx1.redhat.com ([209.132.183.28]:38168 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726704AbfE0PDG (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Mon, 27 May 2019 11:03:06 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 44B88307D85B;
        Mon, 27 May 2019 15:03:05 +0000 (UTC)
Received: from localhost (ovpn-8-24.pek2.redhat.com [10.72.8.24])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 68AA27D5A4;
        Mon, 27 May 2019 15:02:59 +0000 (UTC)
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
Subject: [PATCH V2 4/5] scsi: implement .complete_queue_affinity
Date:   Mon, 27 May 2019 23:02:06 +0800
Message-Id: <20190527150207.11372-5-ming.lei@redhat.com>
In-Reply-To: <20190527150207.11372-1-ming.lei@redhat.com>
References: <20190527150207.11372-1-ming.lei@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.48]); Mon, 27 May 2019 15:03:05 +0000 (UTC)
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Implement .complete_queue_affinity callback for all in-tree drivers
which support private completion queues.

Signed-off-by: Ming Lei <ming.lei@redhat.com>
---
 drivers/scsi/hisi_sas/hisi_sas_v3_hw.c    | 11 +++++++++++
 drivers/scsi/hpsa.c                       | 12 ++++++++++++
 drivers/scsi/megaraid/megaraid_sas_base.c | 10 ++++++++++
 drivers/scsi/mpt3sas/mpt3sas_scsih.c      | 11 +++++++++++
 4 files changed, 44 insertions(+)

diff --git a/drivers/scsi/hisi_sas/hisi_sas_v3_hw.c b/drivers/scsi/hisi_sas/hisi_sas_v3_hw.c
index 49620c2411df..799ee15c8786 100644
--- a/drivers/scsi/hisi_sas/hisi_sas_v3_hw.c
+++ b/drivers/scsi/hisi_sas/hisi_sas_v3_hw.c
@@ -2896,6 +2896,16 @@ static void debugfs_snapshot_restore_v3_hw(struct hisi_hba *hisi_hba)
 	clear_bit(HISI_SAS_REJECT_CMD_BIT, &hisi_hba->flags);
 }
 
+static const struct cpumask *
+hisi_sas_complete_queue_affinity(struct Scsi_Host *sh, int cpu)
+{
+	struct hisi_hba *hisi_hba = shost_priv(sh);
+	unsigned reply_queue = hisi_hba->reply_map[cpu];
+
+	return pci_irq_get_affinity(hisi_hba->pci_dev,
+			reply_queue + BASE_VECTORS_V3_HW);
+}
+
 static struct scsi_host_template sht_v3_hw = {
 	.name			= DRV_NAME,
 	.module			= THIS_MODULE,
@@ -2917,6 +2927,7 @@ static struct scsi_host_template sht_v3_hw = {
 	.shost_attrs		= host_attrs_v3_hw,
 	.tag_alloc_policy	= BLK_TAG_ALLOC_RR,
 	.host_reset             = hisi_sas_host_reset,
+	.complete_queue_affinity = hisi_sas_complete_queue_affinity,
 };
 
 static const struct hisi_sas_hw hisi_sas_v3_hw = {
diff --git a/drivers/scsi/hpsa.c b/drivers/scsi/hpsa.c
index 72f9edb86752..87d37f945c76 100644
--- a/drivers/scsi/hpsa.c
+++ b/drivers/scsi/hpsa.c
@@ -271,6 +271,8 @@ static void hpsa_free_cmd_pool(struct ctlr_info *h);
 #define VPD_PAGE (1 << 8)
 #define HPSA_SIMPLE_ERROR_BITS 0x03
 
+static const struct cpumask *hpsa_complete_queue_affinity(
+		struct Scsi_Host *, int);
 static int hpsa_scsi_queue_command(struct Scsi_Host *h, struct scsi_cmnd *cmd);
 static void hpsa_scan_start(struct Scsi_Host *);
 static int hpsa_scan_finished(struct Scsi_Host *sh,
@@ -962,6 +964,7 @@ static struct scsi_host_template hpsa_driver_template = {
 	.name			= HPSA,
 	.proc_name		= HPSA,
 	.queuecommand		= hpsa_scsi_queue_command,
+	.complete_queue_affinity = hpsa_complete_queue_affinity,
 	.scan_start		= hpsa_scan_start,
 	.scan_finished		= hpsa_scan_finished,
 	.change_queue_depth	= hpsa_change_queue_depth,
@@ -4824,6 +4827,15 @@ static int hpsa_scsi_ioaccel_direct_map(struct ctlr_info *h,
 		cmd->cmnd, cmd->cmd_len, dev->scsi3addr, dev);
 }
 
+static const struct cpumask *
+hpsa_complete_queue_affinity(struct Scsi_Host *sh, int cpu)
+{
+	struct ctlr_info *h = shost_to_hba(sh);
+	unsigned reply_queue = h->reply_map[cpu];
+
+	return pci_irq_get_affinity(h->pdev, reply_queue);
+}
+
 /*
  * Set encryption parameters for the ioaccel2 request
  */
diff --git a/drivers/scsi/megaraid/megaraid_sas_base.c b/drivers/scsi/megaraid/megaraid_sas_base.c
index 3dd1df472dc6..59b71e8f98a8 100644
--- a/drivers/scsi/megaraid/megaraid_sas_base.c
+++ b/drivers/scsi/megaraid/megaraid_sas_base.c
@@ -3165,6 +3165,15 @@ megasas_fw_cmds_outstanding_show(struct device *cdev,
 	return snprintf(buf, PAGE_SIZE, "%d\n", atomic_read(&instance->fw_outstanding));
 }
 
+static const struct cpumask *
+megasas_complete_queue_affinity(struct Scsi_Host *sh, int cpu)
+{
+	struct megasas_instance *instance = (struct megasas_instance *)sh->hostdata;
+	unsigned reply_queue = instance->reply_map[cpu];
+
+	return pci_irq_get_affinity(instance->pdev, reply_queue);
+}
+
 static DEVICE_ATTR(fw_crash_buffer, S_IRUGO | S_IWUSR,
 	megasas_fw_crash_buffer_show, megasas_fw_crash_buffer_store);
 static DEVICE_ATTR(fw_crash_buffer_size, S_IRUGO,
@@ -3208,6 +3217,7 @@ static struct scsi_host_template megasas_template = {
 	.bios_param = megasas_bios_param,
 	.change_queue_depth = scsi_change_queue_depth,
 	.no_write_same = 1,
+	.complete_queue_affinity        = megasas_complete_queue_affinity,
 };
 
 /**
diff --git a/drivers/scsi/mpt3sas/mpt3sas_scsih.c b/drivers/scsi/mpt3sas/mpt3sas_scsih.c
index 1ccfbc7eebe0..2db1d6fc4bda 100644
--- a/drivers/scsi/mpt3sas/mpt3sas_scsih.c
+++ b/drivers/scsi/mpt3sas/mpt3sas_scsih.c
@@ -10161,6 +10161,15 @@ scsih_scan_finished(struct Scsi_Host *shost, unsigned long time)
 	return 1;
 }
 
+static const struct cpumask *
+mpt3sas_complete_queue_affinity(struct Scsi_Host *sh, int cpu)
+{
+	struct MPT3SAS_ADAPTER *ioc = shost_priv(sh);
+	unsigned reply_queue = ioc->cpu_msix_table[cpu];
+
+       return pci_irq_get_affinity(ioc->pdev, reply_queue);
+}
+
 /* shost template for SAS 2.0 HBA devices */
 static struct scsi_host_template mpt2sas_driver_template = {
 	.module				= THIS_MODULE,
@@ -10189,6 +10198,7 @@ static struct scsi_host_template mpt2sas_driver_template = {
 	.sdev_attrs			= mpt3sas_dev_attrs,
 	.track_queue_depth		= 1,
 	.cmd_size			= sizeof(struct scsiio_tracker),
+	.complete_queue_affinity        = mpt3sas_complete_queue_affinity,
 };
 
 /* raid transport support for SAS 2.0 HBA devices */
@@ -10227,6 +10237,7 @@ static struct scsi_host_template mpt3sas_driver_template = {
 	.sdev_attrs			= mpt3sas_dev_attrs,
 	.track_queue_depth		= 1,
 	.cmd_size			= sizeof(struct scsiio_tracker),
+	.complete_queue_affinity        = mpt3sas_complete_queue_affinity,
 };
 
 /* raid transport support for SAS 3.0 HBA devices */
-- 
2.20.1

