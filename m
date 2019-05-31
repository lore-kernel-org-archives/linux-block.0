Return-Path: <SRS0=RDeE=T7=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	UNWANTED_LANGUAGE_BODY autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 24BE9C28CC0
	for <linux-block@archiver.kernel.org>; Fri, 31 May 2019 02:29:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E5BF725F06
	for <linux-block@archiver.kernel.org>; Fri, 31 May 2019 02:29:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726747AbfEaC3G (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 30 May 2019 22:29:06 -0400
Received: from mx1.redhat.com ([209.132.183.28]:48960 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726372AbfEaC3G (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Thu, 30 May 2019 22:29:06 -0400
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 6F2B53082B6B;
        Fri, 31 May 2019 02:29:05 +0000 (UTC)
Received: from localhost (ovpn-8-17.pek2.redhat.com [10.72.8.17])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 6C550600C1;
        Fri, 31 May 2019 02:29:02 +0000 (UTC)
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
Subject: [PATCH 9/9] scsi: mp3sas: convert private reply queue to blk-mq hw queue
Date:   Fri, 31 May 2019 10:28:01 +0800
Message-Id: <20190531022801.10003-10-ming.lei@redhat.com>
In-Reply-To: <20190531022801.10003-1-ming.lei@redhat.com>
References: <20190531022801.10003-1-ming.lei@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.45]); Fri, 31 May 2019 02:29:05 +0000 (UTC)
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
 drivers/scsi/mpt3sas/mpt3sas_base.c  | 74 +++++-----------------------
 drivers/scsi/mpt3sas/mpt3sas_base.h  |  3 +-
 drivers/scsi/mpt3sas/mpt3sas_scsih.c | 17 +++++++
 3 files changed, 31 insertions(+), 63 deletions(-)

diff --git a/drivers/scsi/mpt3sas/mpt3sas_base.c b/drivers/scsi/mpt3sas/mpt3sas_base.c
index 8aacbd1e7db2..2b207d2925b4 100644
--- a/drivers/scsi/mpt3sas/mpt3sas_base.c
+++ b/drivers/scsi/mpt3sas/mpt3sas_base.c
@@ -2855,8 +2855,7 @@ _base_request_irq(struct MPT3SAS_ADAPTER *ioc, u8 index)
 static void
 _base_assign_reply_queues(struct MPT3SAS_ADAPTER *ioc)
 {
-	unsigned int cpu, nr_cpus, nr_msix, index = 0;
-	struct adapter_reply_queue *reply_q;
+	unsigned int nr_cpus, nr_msix;
 
 	if (!_base_is_controller_msix_enabled(ioc))
 		return;
@@ -2866,50 +2865,9 @@ _base_assign_reply_queues(struct MPT3SAS_ADAPTER *ioc)
 		return;
 	}
 
-	memset(ioc->cpu_msix_table, 0, ioc->cpu_msix_table_sz);
-
 	nr_cpus = num_online_cpus();
 	nr_msix = ioc->reply_queue_count = min(ioc->reply_queue_count,
 					       ioc->facts.MaxMSIxVectors);
-	if (!nr_msix)
-		return;
-
-	if (smp_affinity_enable) {
-		list_for_each_entry(reply_q, &ioc->reply_queue_list, list) {
-			const cpumask_t *mask = pci_irq_get_affinity(ioc->pdev,
-							reply_q->msix_index);
-			if (!mask) {
-				ioc_warn(ioc, "no affinity for msi %x\n",
-					 reply_q->msix_index);
-				continue;
-			}
-
-			for_each_cpu_and(cpu, mask, cpu_online_mask) {
-				if (cpu >= ioc->cpu_msix_table_sz)
-					break;
-				ioc->cpu_msix_table[cpu] = reply_q->msix_index;
-			}
-		}
-		return;
-	}
-	cpu = cpumask_first(cpu_online_mask);
-
-	list_for_each_entry(reply_q, &ioc->reply_queue_list, list) {
-
-		unsigned int i, group = nr_cpus / nr_msix;
-
-		if (cpu >= nr_cpus)
-			break;
-
-		if (index < nr_cpus % nr_msix)
-			group++;
-
-		for (i = 0 ; i < group ; i++) {
-			ioc->cpu_msix_table[cpu] = reply_q->msix_index;
-			cpu = cpumask_next(cpu, cpu_online_mask);
-		}
-		index++;
-	}
 }
 
 /**
@@ -2924,6 +2882,7 @@ _base_disable_msix(struct MPT3SAS_ADAPTER *ioc)
 		return;
 	pci_disable_msix(ioc->pdev);
 	ioc->msix_enable = 0;
+	ioc->smp_affinity_enable = 0;
 }
 
 /**
@@ -2980,6 +2939,9 @@ _base_enable_msix(struct MPT3SAS_ADAPTER *ioc)
 		goto try_ioapic;
 	}
 
+	if (irq_flags & PCI_IRQ_AFFINITY)
+		ioc->smp_affinity_enable = 1;
+
 	ioc->msix_enable = 1;
 	ioc->reply_queue_count = r;
 	for (i = 0; i < ioc->reply_queue_count; i++) {
@@ -3266,7 +3228,7 @@ mpt3sas_base_get_reply_virt_addr(struct MPT3SAS_ADAPTER *ioc, u32 phys_addr)
 }
 
 static inline u8
-_base_get_msix_index(struct MPT3SAS_ADAPTER *ioc)
+_base_get_msix_index(struct MPT3SAS_ADAPTER *ioc, struct scsi_cmnd *scmd)
 {
 	/* Enables reply_queue load balancing */
 	if (ioc->msix_load_balance)
@@ -3274,7 +3236,7 @@ _base_get_msix_index(struct MPT3SAS_ADAPTER *ioc)
 		    base_mod64(atomic64_add_return(1,
 		    &ioc->total_io_cnt), ioc->reply_queue_count) : 0;
 
-	return ioc->cpu_msix_table[raw_smp_processor_id()];
+	return scsi_cmnd_hctx_index(ioc->shost, scmd);
 }
 
 /**
@@ -3325,7 +3287,7 @@ mpt3sas_base_get_smid_scsiio(struct MPT3SAS_ADAPTER *ioc, u8 cb_idx,
 
 	smid = tag + 1;
 	request->cb_idx = cb_idx;
-	request->msix_io = _base_get_msix_index(ioc);
+	request->msix_io = _base_get_msix_index(ioc, scmd);
 	request->smid = smid;
 	INIT_LIST_HEAD(&request->chain_list);
 	return smid;
@@ -3498,7 +3460,7 @@ _base_put_smid_mpi_ep_scsi_io(struct MPT3SAS_ADAPTER *ioc, u16 smid, u16 handle)
 	_base_clone_mpi_to_sys_mem(mpi_req_iomem, (void *)mfp,
 					ioc->request_sz);
 	descriptor.SCSIIO.RequestFlags = MPI2_REQ_DESCRIPT_FLAGS_SCSI_IO;
-	descriptor.SCSIIO.MSIxIndex =  _base_get_msix_index(ioc);
+	descriptor.SCSIIO.MSIxIndex =  _base_get_msix_index(ioc, NULL);
 	descriptor.SCSIIO.SMID = cpu_to_le16(smid);
 	descriptor.SCSIIO.DevHandle = cpu_to_le16(handle);
 	descriptor.SCSIIO.LMID = 0;
@@ -3520,7 +3482,7 @@ _base_put_smid_scsi_io(struct MPT3SAS_ADAPTER *ioc, u16 smid, u16 handle)
 
 
 	descriptor.SCSIIO.RequestFlags = MPI2_REQ_DESCRIPT_FLAGS_SCSI_IO;
-	descriptor.SCSIIO.MSIxIndex =  _base_get_msix_index(ioc);
+	descriptor.SCSIIO.MSIxIndex =  _base_get_msix_index(ioc, NULL);
 	descriptor.SCSIIO.SMID = cpu_to_le16(smid);
 	descriptor.SCSIIO.DevHandle = cpu_to_le16(handle);
 	descriptor.SCSIIO.LMID = 0;
@@ -3543,7 +3505,7 @@ mpt3sas_base_put_smid_fast_path(struct MPT3SAS_ADAPTER *ioc, u16 smid,
 
 	descriptor.SCSIIO.RequestFlags =
 	    MPI25_REQ_DESCRIPT_FLAGS_FAST_PATH_SCSI_IO;
-	descriptor.SCSIIO.MSIxIndex = _base_get_msix_index(ioc);
+	descriptor.SCSIIO.MSIxIndex = _base_get_msix_index(ioc, NULL);
 	descriptor.SCSIIO.SMID = cpu_to_le16(smid);
 	descriptor.SCSIIO.DevHandle = cpu_to_le16(handle);
 	descriptor.SCSIIO.LMID = 0;
@@ -3607,7 +3569,7 @@ mpt3sas_base_put_smid_nvme_encap(struct MPT3SAS_ADAPTER *ioc, u16 smid)
 
 	descriptor.Default.RequestFlags =
 		MPI26_REQ_DESCRIPT_FLAGS_PCIE_ENCAPSULATED;
-	descriptor.Default.MSIxIndex =  _base_get_msix_index(ioc);
+	descriptor.Default.MSIxIndex =  _base_get_msix_index(ioc, NULL);
 	descriptor.Default.SMID = cpu_to_le16(smid);
 	descriptor.Default.LMID = 0;
 	descriptor.Default.DescriptorTypeDependent = 0;
@@ -3639,7 +3601,7 @@ mpt3sas_base_put_smid_default(struct MPT3SAS_ADAPTER *ioc, u16 smid)
 	}
 	request = (u64 *)&descriptor;
 	descriptor.Default.RequestFlags = MPI2_REQ_DESCRIPT_FLAGS_DEFAULT_TYPE;
-	descriptor.Default.MSIxIndex =  _base_get_msix_index(ioc);
+	descriptor.Default.MSIxIndex =  _base_get_msix_index(ioc, NULL);
 	descriptor.Default.SMID = cpu_to_le16(smid);
 	descriptor.Default.LMID = 0;
 	descriptor.Default.DescriptorTypeDependent = 0;
@@ -6524,19 +6486,11 @@ mpt3sas_base_attach(struct MPT3SAS_ADAPTER *ioc)
 
 	dinitprintk(ioc, ioc_info(ioc, "%s\n", __func__));
 
-	/* setup cpu_msix_table */
 	ioc->cpu_count = num_online_cpus();
 	for_each_online_cpu(cpu_id)
 		last_cpu_id = cpu_id;
 	ioc->cpu_msix_table_sz = last_cpu_id + 1;
-	ioc->cpu_msix_table = kzalloc(ioc->cpu_msix_table_sz, GFP_KERNEL);
 	ioc->reply_queue_count = 1;
-	if (!ioc->cpu_msix_table) {
-		dfailprintk(ioc,
-			    ioc_info(ioc, "allocation for cpu_msix_table failed!!!\n"));
-		r = -ENOMEM;
-		goto out_free_resources;
-	}
 
 	if (ioc->is_warpdrive) {
 		ioc->reply_post_host_index = kcalloc(ioc->cpu_msix_table_sz,
@@ -6748,7 +6702,6 @@ mpt3sas_base_attach(struct MPT3SAS_ADAPTER *ioc)
 	mpt3sas_base_free_resources(ioc);
 	_base_release_memory_pools(ioc);
 	pci_set_drvdata(ioc->pdev, NULL);
-	kfree(ioc->cpu_msix_table);
 	if (ioc->is_warpdrive)
 		kfree(ioc->reply_post_host_index);
 	kfree(ioc->pd_handles);
@@ -6789,7 +6742,6 @@ mpt3sas_base_detach(struct MPT3SAS_ADAPTER *ioc)
 	_base_release_memory_pools(ioc);
 	mpt3sas_free_enclosure_list(ioc);
 	pci_set_drvdata(ioc->pdev, NULL);
-	kfree(ioc->cpu_msix_table);
 	if (ioc->is_warpdrive)
 		kfree(ioc->reply_post_host_index);
 	kfree(ioc->pd_handles);
diff --git a/drivers/scsi/mpt3sas/mpt3sas_base.h b/drivers/scsi/mpt3sas/mpt3sas_base.h
index 480219f0efc5..4d441e031025 100644
--- a/drivers/scsi/mpt3sas/mpt3sas_base.h
+++ b/drivers/scsi/mpt3sas/mpt3sas_base.h
@@ -1022,7 +1022,6 @@ typedef void (*MPT3SAS_FLUSH_RUNNING_CMDS)(struct MPT3SAS_ADAPTER *ioc);
  * @start_scan_failed: means port enable failed, return's the ioc_status
  * @msix_enable: flag indicating msix is enabled
  * @msix_vector_count: number msix vectors
- * @cpu_msix_table: table for mapping cpus to msix index
  * @cpu_msix_table_sz: table size
  * @total_io_cnt: Gives total IO count, used to load balance the interrupts
  * @msix_load_balance: Enables load balancing of interrupts across
@@ -1183,6 +1182,7 @@ struct MPT3SAS_ADAPTER {
 	u16		broadcast_aen_pending;
 	u8		shost_recovery;
 	u8		got_task_abort_from_ioctl;
+	u8		smp_affinity_enable;
 
 	struct mutex	reset_in_progress_mutex;
 	spinlock_t	ioc_reset_in_progress_lock;
@@ -1199,7 +1199,6 @@ struct MPT3SAS_ADAPTER {
 
 	u8		msix_enable;
 	u16		msix_vector_count;
-	u8		*cpu_msix_table;
 	u16		cpu_msix_table_sz;
 	resource_size_t __iomem **reply_post_host_index;
 	u32		ioc_reset_count;
diff --git a/drivers/scsi/mpt3sas/mpt3sas_scsih.c b/drivers/scsi/mpt3sas/mpt3sas_scsih.c
index 1ccfbc7eebe0..59c1f9e694a0 100644
--- a/drivers/scsi/mpt3sas/mpt3sas_scsih.c
+++ b/drivers/scsi/mpt3sas/mpt3sas_scsih.c
@@ -55,6 +55,7 @@
 #include <linux/interrupt.h>
 #include <linux/aer.h>
 #include <linux/raid_class.h>
+#include <linux/blk-mq-pci.h>
 #include <asm/unaligned.h>
 
 #include "mpt3sas_base.h"
@@ -10161,6 +10162,17 @@ scsih_scan_finished(struct Scsi_Host *shost, unsigned long time)
 	return 1;
 }
 
+static int mpt3sas_map_queues(struct Scsi_Host *shost)
+{
+	struct MPT3SAS_ADAPTER *ioc = shost_priv(shost);
+	struct blk_mq_queue_map *qmap = &shost->tag_set.map[HCTX_TYPE_DEFAULT];
+
+	if (ioc->smp_affinity_enable)
+		return blk_mq_pci_map_queues(qmap, ioc->pdev, 0);
+	else
+		return blk_mq_map_queues(qmap);
+}
+
 /* shost template for SAS 2.0 HBA devices */
 static struct scsi_host_template mpt2sas_driver_template = {
 	.module				= THIS_MODULE,
@@ -10189,6 +10201,8 @@ static struct scsi_host_template mpt2sas_driver_template = {
 	.sdev_attrs			= mpt3sas_dev_attrs,
 	.track_queue_depth		= 1,
 	.cmd_size			= sizeof(struct scsiio_tracker),
+	.host_tagset			= 1,
+	.map_queues			= mpt3sas_map_queues,
 };
 
 /* raid transport support for SAS 2.0 HBA devices */
@@ -10227,6 +10241,8 @@ static struct scsi_host_template mpt3sas_driver_template = {
 	.sdev_attrs			= mpt3sas_dev_attrs,
 	.track_queue_depth		= 1,
 	.cmd_size			= sizeof(struct scsiio_tracker),
+	.host_tagset			= 1,
+	.map_queues			= mpt3sas_map_queues,
 };
 
 /* raid transport support for SAS 3.0 HBA devices */
@@ -10538,6 +10554,7 @@ _scsih_probe(struct pci_dev *pdev, const struct pci_device_id *id)
 	} else
 		ioc->hide_drives = 0;
 
+	shost->nr_hw_queues = ioc->reply_queue_count;
 	rv = scsi_add_host(shost, &pdev->dev);
 	if (rv) {
 		ioc_err(ioc, "failure at %s:%d/%s()!\n",
-- 
2.20.1

