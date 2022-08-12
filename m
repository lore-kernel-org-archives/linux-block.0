Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 81D3AC25B0F
	for <linux-block@archiver.kernel.org>; Fri, 12 Aug 2022 21:09:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230128AbiHLVIa (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 12 Aug 2022 17:08:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58776 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233805AbiHLVIS (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 12 Aug 2022 17:08:18 -0400
Received: from mail-pj1-f44.google.com (mail-pj1-f44.google.com [209.85.216.44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F400AB56DD
        for <linux-block@vger.kernel.org>; Fri, 12 Aug 2022 14:08:16 -0700 (PDT)
Received: by mail-pj1-f44.google.com with SMTP id gp7so2035060pjb.4
        for <linux-block@vger.kernel.org>; Fri, 12 Aug 2022 14:08:16 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc;
        bh=A21gskHMfkJnr7VTOc2HGT+bEqdEjaqey9uaWlAwckE=;
        b=yQ9ABvgZZNPPge0ttOOuDerhkoOAH1G52WkJSojTTaVtd/M9Gd1QsAJsyNHrl4ZgPA
         mFekJ1DUebMzZ9FLffsMrnRCI3mUreLzp5p1R/r91p4rfYALtAl0N9mzBtV9XKbAUvHN
         +MXErVOh0MiJUKIXGIwwfLEz6E8lTijplPSBw1htTUhjU/Tvm3R8RRqm5/2Zrz8a9EP/
         EB6UBRt80qNAxue7YlDnfUG4s/DmcjDOB6dygboeCQ/p1v+7SKivKkT15zY8GAef2Kj0
         VakBwTak/sjBQuoE8cpLt147Aok0AG6PMVFKIwWgh38K00dy6QeOFqQ46A29E9tqfLU0
         IrEw==
X-Gm-Message-State: ACgBeo0USnGrorC4hOqPt71q5WPelZeAS8/2TtMlWqAcwYDZrglsPZpK
        NUE8BZDLvj57QT1TxK4Fggo=
X-Google-Smtp-Source: AA6agR5BiX97vOfV4FMRqE5d4/ckWY7b7lE/tMptIEvPFqzkR5SOjdVcDYmw4p7hU5pNOG3+u9ERWQ==
X-Received: by 2002:a17:90a:4291:b0:1f2:2a19:fc95 with SMTP id p17-20020a17090a429100b001f22a19fc95mr15530535pjg.29.1660338496361;
        Fri, 12 Aug 2022 14:08:16 -0700 (PDT)
Received: from bvanassche-linux.mtv.corp.google.com ([2620:15c:211:201:2414:9f13:41de:d21d])
        by smtp.gmail.com with ESMTPSA id w62-20020a17090a6bc400b001f3095af6a9sm245905pjj.38.2022.08.12.14.08.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 12 Aug 2022 14:08:15 -0700 (PDT)
From:   Bart Van Assche <bvanassche@acm.org>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org, Christoph Hellwig <hch@lst.de>,
        Jaegeuk Kim <jaegeuk@kernel.org>,
        Bart Van Assche <bvanassche@acm.org>,
        "Martin K . Petersen" <martin.petersen@oracle.com>,
        Keith Busch <keith.busch@intel.com>,
        "Michael S . Tsirkin" <mst@redhat.com>,
        Jason Wang <jasowang@redhat.com>
Subject: [PATCH 4/6] scsi: Change the return type of .map_queues() into void
Date:   Fri, 12 Aug 2022 14:07:58 -0700
Message-Id: <20220812210800.2253972-5-bvanassche@acm.org>
X-Mailer: git-send-email 2.37.1.595.g718a3a8f04-goog
In-Reply-To: <20220812210800.2253972-1-bvanassche@acm.org>
References: <20220812210800.2253972-1-bvanassche@acm.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Since all implementations of the SCSI host .map_queues() callback
function return 0, change the return type of this callback function into
void.

Cc: Martin K. Petersen <martin.petersen@oracle.com>
Cc: Christoph Hellwig <hch@lst.de>
Cc: Keith Busch <keith.busch@intel.com>
Cc: Michael S. Tsirkin <mst@redhat.com>
Cc: Jason Wang <jasowang@redhat.com>
Signed-off-by: Bart Van Assche <bvanassche@acm.org>
---
 drivers/scsi/hisi_sas/hisi_sas_v2_hw.c    | 5 +----
 drivers/scsi/hisi_sas/hisi_sas_v3_hw.c    | 3 +--
 drivers/scsi/megaraid/megaraid_sas_base.c | 6 ++----
 drivers/scsi/mpi3mr/mpi3mr_os.c           | 5 +----
 drivers/scsi/mpt3sas/mpt3sas_scsih.c      | 5 ++---
 drivers/scsi/pm8001/pm8001_init.c         | 2 +-
 drivers/scsi/qla2xxx/qla_os.c             | 5 ++---
 drivers/scsi/qlogicpti.c                  | 6 ++----
 drivers/scsi/scsi_debug.c                 | 7 ++-----
 drivers/scsi/scsi_lib.c                   | 6 ++++--
 drivers/scsi/smartpqi/smartpqi_init.c     | 3 +--
 drivers/scsi/virtio_scsi.c                | 3 +--
 drivers/ufs/core/ufshcd.c                 | 4 +---
 include/scsi/scsi_host.h                  | 2 +-
 14 files changed, 22 insertions(+), 40 deletions(-)

diff --git a/drivers/scsi/hisi_sas/hisi_sas_v2_hw.c b/drivers/scsi/hisi_sas/hisi_sas_v2_hw.c
index 70e401fd432a..c37027276162 100644
--- a/drivers/scsi/hisi_sas/hisi_sas_v2_hw.c
+++ b/drivers/scsi/hisi_sas/hisi_sas_v2_hw.c
@@ -3537,7 +3537,7 @@ static struct attribute *host_v2_hw_attrs[] = {
 
 ATTRIBUTE_GROUPS(host_v2_hw);
 
-static int map_queues_v2_hw(struct Scsi_Host *shost)
+static void map_queues_v2_hw(struct Scsi_Host *shost)
 {
 	struct hisi_hba *hisi_hba = shost_priv(shost);
 	struct blk_mq_queue_map *qmap = &shost->tag_set.map[HCTX_TYPE_DEFAULT];
@@ -3552,9 +3552,6 @@ static int map_queues_v2_hw(struct Scsi_Host *shost)
 		for_each_cpu(cpu, mask)
 			qmap->mq_map[cpu] = qmap->queue_offset + queue;
 	}
-
-	return 0;
-
 }
 
 static struct scsi_host_template sht_v2_hw = {
diff --git a/drivers/scsi/hisi_sas/hisi_sas_v3_hw.c b/drivers/scsi/hisi_sas/hisi_sas_v3_hw.c
index c1e541dcbac0..d716e5632d0f 100644
--- a/drivers/scsi/hisi_sas/hisi_sas_v3_hw.c
+++ b/drivers/scsi/hisi_sas/hisi_sas_v3_hw.c
@@ -3171,13 +3171,12 @@ static int debugfs_set_bist_v3_hw(struct hisi_hba *hisi_hba, bool enable)
 	return 0;
 }
 
-static int hisi_sas_map_queues(struct Scsi_Host *shost)
+static void hisi_sas_map_queues(struct Scsi_Host *shost)
 {
 	struct hisi_hba *hisi_hba = shost_priv(shost);
 	struct blk_mq_queue_map *qmap = &shost->tag_set.map[HCTX_TYPE_DEFAULT];
 
 	blk_mq_pci_map_queues(qmap, hisi_hba->pci_dev, BASE_VECTORS_V3_HW);
-	return 0;
 }
 
 static struct scsi_host_template sht_v3_hw = {
diff --git a/drivers/scsi/megaraid/megaraid_sas_base.c b/drivers/scsi/megaraid/megaraid_sas_base.c
index a3e117a4b8e7..f17813b1ffae 100644
--- a/drivers/scsi/megaraid/megaraid_sas_base.c
+++ b/drivers/scsi/megaraid/megaraid_sas_base.c
@@ -3174,7 +3174,7 @@ megasas_bios_param(struct scsi_device *sdev, struct block_device *bdev,
 	return 0;
 }
 
-static int megasas_map_queues(struct Scsi_Host *shost)
+static void megasas_map_queues(struct Scsi_Host *shost)
 {
 	struct megasas_instance *instance;
 	int qoff = 0, offset;
@@ -3183,7 +3183,7 @@ static int megasas_map_queues(struct Scsi_Host *shost)
 	instance = (struct megasas_instance *)shost->hostdata;
 
 	if (shost->nr_hw_queues == 1)
-		return 0;
+		return;
 
 	offset = instance->low_latency_index_start;
 
@@ -3209,8 +3209,6 @@ static int megasas_map_queues(struct Scsi_Host *shost)
 		map->queue_offset = qoff;
 		blk_mq_map_queues(map);
 	}
-
-	return 0;
 }
 
 static void megasas_aen_polling(struct work_struct *work);
diff --git a/drivers/scsi/mpi3mr/mpi3mr_os.c b/drivers/scsi/mpi3mr/mpi3mr_os.c
index bfa1165e23b6..9681c8bf24ed 100644
--- a/drivers/scsi/mpi3mr/mpi3mr_os.c
+++ b/drivers/scsi/mpi3mr/mpi3mr_os.c
@@ -3464,7 +3464,7 @@ static int mpi3mr_bios_param(struct scsi_device *sdev,
  *
  * Return: return zero.
  */
-static int mpi3mr_map_queues(struct Scsi_Host *shost)
+static void mpi3mr_map_queues(struct Scsi_Host *shost)
 {
 	struct mpi3mr_ioc *mrioc = shost_priv(shost);
 	int i, qoff, offset;
@@ -3500,9 +3500,6 @@ static int mpi3mr_map_queues(struct Scsi_Host *shost)
 		qoff += map->nr_queues;
 		offset += map->nr_queues;
 	}
-
-	return 0;
-
 }
 
 /**
diff --git a/drivers/scsi/mpt3sas/mpt3sas_scsih.c b/drivers/scsi/mpt3sas/mpt3sas_scsih.c
index def37a7e5980..44618bf66d9b 100644
--- a/drivers/scsi/mpt3sas/mpt3sas_scsih.c
+++ b/drivers/scsi/mpt3sas/mpt3sas_scsih.c
@@ -11872,7 +11872,7 @@ scsih_scan_finished(struct Scsi_Host *shost, unsigned long time)
  * scsih_map_queues - map reply queues with request queues
  * @shost: SCSI host pointer
  */
-static int scsih_map_queues(struct Scsi_Host *shost)
+static void scsih_map_queues(struct Scsi_Host *shost)
 {
 	struct MPT3SAS_ADAPTER *ioc =
 	    (struct MPT3SAS_ADAPTER *)shost->hostdata;
@@ -11882,7 +11882,7 @@ static int scsih_map_queues(struct Scsi_Host *shost)
 	int iopoll_q_count = ioc->reply_queue_count - nr_msix_vectors;
 
 	if (shost->nr_hw_queues == 1)
-		return 0;
+		return;
 
 	for (i = 0, qoff = 0; i < shost->nr_maps; i++) {
 		map = &shost->tag_set.map[i];
@@ -11910,7 +11910,6 @@ static int scsih_map_queues(struct Scsi_Host *shost)
 
 		qoff += map->nr_queues;
 	}
-	return 0;
 }
 
 /* shost template for SAS 2.0 HBA devices */
diff --git a/drivers/scsi/pm8001/pm8001_init.c b/drivers/scsi/pm8001/pm8001_init.c
index a0028e130a7e..2ff2fac1e403 100644
--- a/drivers/scsi/pm8001/pm8001_init.c
+++ b/drivers/scsi/pm8001/pm8001_init.c
@@ -81,7 +81,7 @@ LIST_HEAD(hba_list);
 
 struct workqueue_struct *pm8001_wq;
 
-static int pm8001_map_queues(struct Scsi_Host *shost)
+static void pm8001_map_queues(struct Scsi_Host *shost)
 {
 	struct sas_ha_struct *sha = SHOST_TO_SAS_HA(shost);
 	struct pm8001_hba_info *pm8001_ha = sha->lldd_ha;
diff --git a/drivers/scsi/qla2xxx/qla_os.c b/drivers/scsi/qla2xxx/qla_os.c
index 26cd27684410..87a93892deac 100644
--- a/drivers/scsi/qla2xxx/qla_os.c
+++ b/drivers/scsi/qla2xxx/qla_os.c
@@ -350,7 +350,7 @@ MODULE_PARM_DESC(ql2xrspq_follow_inptr_legacy,
 
 static void qla2x00_clear_drv_active(struct qla_hw_data *);
 static void qla2x00_free_device(scsi_qla_host_t *);
-static int qla2xxx_map_queues(struct Scsi_Host *shost);
+static void qla2xxx_map_queues(struct Scsi_Host *shost);
 static void qla2x00_destroy_deferred_work(struct qla_hw_data *);
 
 u32 ql2xnvme_queues = DEF_NVME_HW_QUEUES;
@@ -7994,7 +7994,7 @@ qla_pci_reset_done(struct pci_dev *pdev)
 	clear_bit(ABORT_ISP_ACTIVE, &base_vha->dpc_flags);
 }
 
-static int qla2xxx_map_queues(struct Scsi_Host *shost)
+static void qla2xxx_map_queues(struct Scsi_Host *shost)
 {
 	scsi_qla_host_t *vha = (scsi_qla_host_t *)shost->hostdata;
 	struct blk_mq_queue_map *qmap = &shost->tag_set.map[HCTX_TYPE_DEFAULT];
@@ -8003,7 +8003,6 @@ static int qla2xxx_map_queues(struct Scsi_Host *shost)
 		blk_mq_map_queues(qmap);
 	else
 		blk_mq_pci_map_queues(qmap, vha->hw->pdev, vha->irq_offset);
-	return 0;
 }
 
 struct scsi_host_template qla2xxx_driver_template = {
diff --git a/drivers/scsi/qlogicpti.c b/drivers/scsi/qlogicpti.c
index 57f2f4135a06..a5aa716e9086 100644
--- a/drivers/scsi/qlogicpti.c
+++ b/drivers/scsi/qlogicpti.c
@@ -814,7 +814,7 @@ static void qpti_get_clock(struct qlogicpti *qpti)
 /* The request and response queues must each be aligned
  * on a page boundary.
  */
-static int qpti_map_queues(struct qlogicpti *qpti)
+static void qpti_map_queues(struct qlogicpti *qpti)
 {
 	struct platform_device *op = qpti->op;
 
@@ -840,7 +840,6 @@ static int qpti_map_queues(struct qlogicpti *qpti)
 	}
 	memset(qpti->res_cpu, 0, QSIZE(RES_QUEUE_LEN));
 	memset(qpti->req_cpu, 0, QSIZE(QLOGICPTI_REQ_QUEUE_LEN));
-	return 0;
 }
 
 const char *qlogicpti_info(struct Scsi_Host *host)
@@ -1339,8 +1338,7 @@ static int qpti_sbus_probe(struct platform_device *op)
 	/* Clear out scsi_cmnd array. */
 	memset(qpti->cmd_slots, 0, sizeof(qpti->cmd_slots));
 
-	if (qpti_map_queues(qpti) < 0)
-		goto fail_free_irq;
+	qpti_map_queues(qpti);
 
 	/* Load the firmware. */
 	if (qlogicpti_load_firmware(qpti))
diff --git a/drivers/scsi/scsi_debug.c b/drivers/scsi/scsi_debug.c
index b8a76b89f85a..697fc57bc711 100644
--- a/drivers/scsi/scsi_debug.c
+++ b/drivers/scsi/scsi_debug.c
@@ -7474,12 +7474,12 @@ static int resp_not_ready(struct scsi_cmnd *scp, struct sdebug_dev_info *devip)
 	return check_condition_result;
 }
 
-static int sdebug_map_queues(struct Scsi_Host *shost)
+static void sdebug_map_queues(struct Scsi_Host *shost)
 {
 	int i, qoff;
 
 	if (shost->nr_hw_queues == 1)
-		return 0;
+		return;
 
 	for (i = 0, qoff = 0; i < HCTX_MAX_TYPES; i++) {
 		struct blk_mq_queue_map *map = &shost->tag_set.map[i];
@@ -7501,9 +7501,6 @@ static int sdebug_map_queues(struct Scsi_Host *shost)
 
 		qoff += map->nr_queues;
 	}
-
-	return 0;
-
 }
 
 static int sdebug_blk_mq_poll(struct Scsi_Host *shost, unsigned int queue_num)
diff --git a/drivers/scsi/scsi_lib.c b/drivers/scsi/scsi_lib.c
index 4ea75b35ce9b..ab40e2a2633a 100644
--- a/drivers/scsi/scsi_lib.c
+++ b/drivers/scsi/scsi_lib.c
@@ -1853,8 +1853,10 @@ static int scsi_map_queues(struct blk_mq_tag_set *set)
 {
 	struct Scsi_Host *shost = container_of(set, struct Scsi_Host, tag_set);
 
-	if (shost->hostt->map_queues)
-		return shost->hostt->map_queues(shost);
+	if (shost->hostt->map_queues) {
+		shost->hostt->map_queues(shost);
+		return 0;
+	}
 	blk_mq_map_queues(&set->map[HCTX_TYPE_DEFAULT]);
 	return 0;
 }
diff --git a/drivers/scsi/smartpqi/smartpqi_init.c b/drivers/scsi/smartpqi/smartpqi_init.c
index bc43f3fe5ba5..b971fbe3b3a1 100644
--- a/drivers/scsi/smartpqi/smartpqi_init.c
+++ b/drivers/scsi/smartpqi/smartpqi_init.c
@@ -6436,13 +6436,12 @@ static int pqi_slave_alloc(struct scsi_device *sdev)
 	return 0;
 }
 
-static int pqi_map_queues(struct Scsi_Host *shost)
+static void pqi_map_queues(struct Scsi_Host *shost)
 {
 	struct pqi_ctrl_info *ctrl_info = shost_to_hba(shost);
 
 	blk_mq_pci_map_queues(&shost->tag_set.map[HCTX_TYPE_DEFAULT],
 			      ctrl_info->pci_dev, 0);
-	return 0;
 }
 
 static inline bool pqi_is_tape_changer_device(struct pqi_scsi_dev *device)
diff --git a/drivers/scsi/virtio_scsi.c b/drivers/scsi/virtio_scsi.c
index afc12e25b715..077a8e24bd28 100644
--- a/drivers/scsi/virtio_scsi.c
+++ b/drivers/scsi/virtio_scsi.c
@@ -711,13 +711,12 @@ static int virtscsi_abort(struct scsi_cmnd *sc)
 	return virtscsi_tmf(vscsi, cmd);
 }
 
-static int virtscsi_map_queues(struct Scsi_Host *shost)
+static void virtscsi_map_queues(struct Scsi_Host *shost)
 {
 	struct virtio_scsi *vscsi = shost_priv(shost);
 	struct blk_mq_queue_map *qmap = &shost->tag_set.map[HCTX_TYPE_DEFAULT];
 
 	blk_mq_virtio_map_queues(qmap, vscsi->vdev, 2);
-	return 0;
 }
 
 static void virtscsi_commit_rqs(struct Scsi_Host *shost, u16 hwq)
diff --git a/drivers/ufs/core/ufshcd.c b/drivers/ufs/core/ufshcd.c
index a619622b894a..93ab6f9380fe 100644
--- a/drivers/ufs/core/ufshcd.c
+++ b/drivers/ufs/core/ufshcd.c
@@ -2701,7 +2701,7 @@ static inline bool is_device_wlun(struct scsi_device *sdev)
  * Associate the UFS controller queue with the default and poll HCTX types.
  * Initialize the mq_map[] arrays.
  */
-static int ufshcd_map_queues(struct Scsi_Host *shost)
+static void ufshcd_map_queues(struct Scsi_Host *shost)
 {
 	int i;
 
@@ -2722,8 +2722,6 @@ static int ufshcd_map_queues(struct Scsi_Host *shost)
 		map->queue_offset = 0;
 		blk_mq_map_queues(map);
 	}
-
-	return 0;
 }
 
 static void ufshcd_init_lrb(struct ufs_hba *hba, struct ufshcd_lrb *lrb, int i)
diff --git a/include/scsi/scsi_host.h b/include/scsi/scsi_host.h
index aa7b7496c93a..7d51af3e7c40 100644
--- a/include/scsi/scsi_host.h
+++ b/include/scsi/scsi_host.h
@@ -276,7 +276,7 @@ struct scsi_host_template {
 	 *
 	 * Status: OPTIONAL
 	 */
-	int (* map_queues)(struct Scsi_Host *shost);
+	void (* map_queues)(struct Scsi_Host *shost);
 
 	/*
 	 * SCSI interface of blk_poll - poll for IO completions.
