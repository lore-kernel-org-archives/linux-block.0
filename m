Return-Path: <SRS0=U0+/=T3=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9D1E8C04AB3
	for <linux-block@archiver.kernel.org>; Mon, 27 May 2019 15:02:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 749D72182B
	for <linux-block@archiver.kernel.org>; Mon, 27 May 2019 15:02:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726302AbfE0PCs (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 27 May 2019 11:02:48 -0400
Received: from mx1.redhat.com ([209.132.183.28]:38980 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726115AbfE0PCs (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Mon, 27 May 2019 11:02:48 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id DD86D3092663;
        Mon, 27 May 2019 15:02:42 +0000 (UTC)
Received: from localhost (ovpn-8-24.pek2.redhat.com [10.72.8.24])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 3C63A7D90B;
        Mon, 27 May 2019 15:02:35 +0000 (UTC)
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
Subject: [PATCH V2 1/5] scsi: select reply queue from request's CPU
Date:   Mon, 27 May 2019 23:02:03 +0800
Message-Id: <20190527150207.11372-2-ming.lei@redhat.com>
In-Reply-To: <20190527150207.11372-1-ming.lei@redhat.com>
References: <20190527150207.11372-1-ming.lei@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.43]); Mon, 27 May 2019 15:02:48 +0000 (UTC)
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Hisi_sas_v3_hw, hpsa, megaraid and mpt3sas use single blk-mq hw queue
to submit request, meantime apply multiple private reply queues served as
completion queue. The mapping between CPU and reply queue is setup via
pci_alloc_irq_vectors_affinity(PCI_IRQ_AFFINITY) just like the usual
blk-mq queue mapping.

These drivers always use current CPU(raw_smp_processor_id) to figure out
the reply queue. Switch to use request's CPU to get the reply queue,
so we can drain in-flight request via blk-mq's API before the last CPU of
the reply queue becomes offline.

Signed-off-by: Ming Lei <ming.lei@redhat.com>
---
 drivers/scsi/hisi_sas/hisi_sas_main.c       |  5 +++--
 drivers/scsi/hpsa.c                         |  2 +-
 drivers/scsi/megaraid/megaraid_sas_fusion.c |  4 ++--
 drivers/scsi/mpt3sas/mpt3sas_base.c         | 16 ++++++++--------
 include/scsi/scsi_cmnd.h                    | 11 +++++++++++
 5 files changed, 25 insertions(+), 13 deletions(-)

diff --git a/drivers/scsi/hisi_sas/hisi_sas_main.c b/drivers/scsi/hisi_sas/hisi_sas_main.c
index 8a7feb8ed8d6..ab9d8e7bfc8e 100644
--- a/drivers/scsi/hisi_sas/hisi_sas_main.c
+++ b/drivers/scsi/hisi_sas/hisi_sas_main.c
@@ -471,9 +471,10 @@ static int hisi_sas_task_prep(struct sas_task *task,
 		return -ECOMM;
 	}
 
+	/* only V3 hardware setup .reply_map */
 	if (hisi_hba->reply_map) {
-		int cpu = raw_smp_processor_id();
-		unsigned int dq_index = hisi_hba->reply_map[cpu];
+		unsigned int dq_index = hisi_hba->reply_map[
+			scsi_cmnd_cpu(task->uldd_task)];
 
 		*dq_pointer = dq = &hisi_hba->dq[dq_index];
 	} else {
diff --git a/drivers/scsi/hpsa.c b/drivers/scsi/hpsa.c
index 1bef1da273c2..72f9edb86752 100644
--- a/drivers/scsi/hpsa.c
+++ b/drivers/scsi/hpsa.c
@@ -1145,7 +1145,7 @@ static void __enqueue_cmd_and_start_io(struct ctlr_info *h,
 	dial_down_lockup_detection_during_fw_flash(h, c);
 	atomic_inc(&h->commands_outstanding);
 
-	reply_queue = h->reply_map[raw_smp_processor_id()];
+	reply_queue = h->reply_map[scsi_cmnd_cpu(c->scsi_cmd)];
 	switch (c->cmd_type) {
 	case CMD_IOACCEL1:
 		set_ioaccel1_performant_mode(h, c, reply_queue);
diff --git a/drivers/scsi/megaraid/megaraid_sas_fusion.c b/drivers/scsi/megaraid/megaraid_sas_fusion.c
index 4dfa0685a86c..6bed77cfaf9a 100644
--- a/drivers/scsi/megaraid/megaraid_sas_fusion.c
+++ b/drivers/scsi/megaraid/megaraid_sas_fusion.c
@@ -2699,7 +2699,7 @@ megasas_build_ldio_fusion(struct megasas_instance *instance,
 	}
 
 	cmd->request_desc->SCSIIO.MSIxIndex =
-		instance->reply_map[raw_smp_processor_id()];
+		instance->reply_map[scsi_cmnd_cpu(scp)];
 
 	if (instance->adapter_type >= VENTURA_SERIES) {
 		/* FP for Optimal raid level 1.
@@ -3013,7 +3013,7 @@ megasas_build_syspd_fusion(struct megasas_instance *instance,
 	cmd->request_desc->SCSIIO.DevHandle = io_request->DevHandle;
 
 	cmd->request_desc->SCSIIO.MSIxIndex =
-		instance->reply_map[raw_smp_processor_id()];
+		instance->reply_map[scsi_cmnd_cpu(scmd)];
 
 	if (!fp_possible) {
 		/* system pd firmware path */
diff --git a/drivers/scsi/mpt3sas/mpt3sas_base.c b/drivers/scsi/mpt3sas/mpt3sas_base.c
index 8aacbd1e7db2..8135e980f591 100644
--- a/drivers/scsi/mpt3sas/mpt3sas_base.c
+++ b/drivers/scsi/mpt3sas/mpt3sas_base.c
@@ -3266,7 +3266,7 @@ mpt3sas_base_get_reply_virt_addr(struct MPT3SAS_ADAPTER *ioc, u32 phys_addr)
 }
 
 static inline u8
-_base_get_msix_index(struct MPT3SAS_ADAPTER *ioc)
+_base_get_msix_index(struct MPT3SAS_ADAPTER *ioc, struct scsi_cmnd *scmd)
 {
 	/* Enables reply_queue load balancing */
 	if (ioc->msix_load_balance)
@@ -3274,7 +3274,7 @@ _base_get_msix_index(struct MPT3SAS_ADAPTER *ioc)
 		    base_mod64(atomic64_add_return(1,
 		    &ioc->total_io_cnt), ioc->reply_queue_count) : 0;
 
-	return ioc->cpu_msix_table[raw_smp_processor_id()];
+	return ioc->cpu_msix_table[scsi_cmnd_cpu(scmd)];
 }
 
 /**
@@ -3325,7 +3325,7 @@ mpt3sas_base_get_smid_scsiio(struct MPT3SAS_ADAPTER *ioc, u8 cb_idx,
 
 	smid = tag + 1;
 	request->cb_idx = cb_idx;
-	request->msix_io = _base_get_msix_index(ioc);
+	request->msix_io = _base_get_msix_index(ioc, scmd);
 	request->smid = smid;
 	INIT_LIST_HEAD(&request->chain_list);
 	return smid;
@@ -3498,7 +3498,7 @@ _base_put_smid_mpi_ep_scsi_io(struct MPT3SAS_ADAPTER *ioc, u16 smid, u16 handle)
 	_base_clone_mpi_to_sys_mem(mpi_req_iomem, (void *)mfp,
 					ioc->request_sz);
 	descriptor.SCSIIO.RequestFlags = MPI2_REQ_DESCRIPT_FLAGS_SCSI_IO;
-	descriptor.SCSIIO.MSIxIndex =  _base_get_msix_index(ioc);
+	descriptor.SCSIIO.MSIxIndex =  _base_get_msix_index(ioc, NULL);
 	descriptor.SCSIIO.SMID = cpu_to_le16(smid);
 	descriptor.SCSIIO.DevHandle = cpu_to_le16(handle);
 	descriptor.SCSIIO.LMID = 0;
@@ -3520,7 +3520,7 @@ _base_put_smid_scsi_io(struct MPT3SAS_ADAPTER *ioc, u16 smid, u16 handle)
 
 
 	descriptor.SCSIIO.RequestFlags = MPI2_REQ_DESCRIPT_FLAGS_SCSI_IO;
-	descriptor.SCSIIO.MSIxIndex =  _base_get_msix_index(ioc);
+	descriptor.SCSIIO.MSIxIndex =  _base_get_msix_index(ioc, NULL);
 	descriptor.SCSIIO.SMID = cpu_to_le16(smid);
 	descriptor.SCSIIO.DevHandle = cpu_to_le16(handle);
 	descriptor.SCSIIO.LMID = 0;
@@ -3543,7 +3543,7 @@ mpt3sas_base_put_smid_fast_path(struct MPT3SAS_ADAPTER *ioc, u16 smid,
 
 	descriptor.SCSIIO.RequestFlags =
 	    MPI25_REQ_DESCRIPT_FLAGS_FAST_PATH_SCSI_IO;
-	descriptor.SCSIIO.MSIxIndex = _base_get_msix_index(ioc);
+	descriptor.SCSIIO.MSIxIndex = _base_get_msix_index(ioc, NULL);
 	descriptor.SCSIIO.SMID = cpu_to_le16(smid);
 	descriptor.SCSIIO.DevHandle = cpu_to_le16(handle);
 	descriptor.SCSIIO.LMID = 0;
@@ -3607,7 +3607,7 @@ mpt3sas_base_put_smid_nvme_encap(struct MPT3SAS_ADAPTER *ioc, u16 smid)
 
 	descriptor.Default.RequestFlags =
 		MPI26_REQ_DESCRIPT_FLAGS_PCIE_ENCAPSULATED;
-	descriptor.Default.MSIxIndex =  _base_get_msix_index(ioc);
+	descriptor.Default.MSIxIndex =  _base_get_msix_index(ioc, NULL);
 	descriptor.Default.SMID = cpu_to_le16(smid);
 	descriptor.Default.LMID = 0;
 	descriptor.Default.DescriptorTypeDependent = 0;
@@ -3639,7 +3639,7 @@ mpt3sas_base_put_smid_default(struct MPT3SAS_ADAPTER *ioc, u16 smid)
 	}
 	request = (u64 *)&descriptor;
 	descriptor.Default.RequestFlags = MPI2_REQ_DESCRIPT_FLAGS_DEFAULT_TYPE;
-	descriptor.Default.MSIxIndex =  _base_get_msix_index(ioc);
+	descriptor.Default.MSIxIndex =  _base_get_msix_index(ioc, NULL);
 	descriptor.Default.SMID = cpu_to_le16(smid);
 	descriptor.Default.LMID = 0;
 	descriptor.Default.DescriptorTypeDependent = 0;
diff --git a/include/scsi/scsi_cmnd.h b/include/scsi/scsi_cmnd.h
index 76ed5e4acd38..ab60883c2c40 100644
--- a/include/scsi/scsi_cmnd.h
+++ b/include/scsi/scsi_cmnd.h
@@ -332,4 +332,15 @@ static inline unsigned scsi_transfer_length(struct scsi_cmnd *scmd)
 	return xfer_len;
 }
 
+static inline int scsi_cmnd_cpu(struct scsi_cmnd *scmd)
+{
+	if (!scmd || !scmd->request)
+		return raw_smp_processor_id();
+
+	if (!scmd->request->mq_ctx)
+		return raw_smp_processor_id();
+
+	return blk_mq_rq_cpu(scmd->request);
+}
+
 #endif /* _SCSI_SCSI_CMND_H */
-- 
2.20.1

