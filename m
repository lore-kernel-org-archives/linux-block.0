Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 94C2DC282E7
	for <linux-block@archiver.kernel.org>; Fri, 12 Aug 2022 21:09:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230114AbiHLVIa (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 12 Aug 2022 17:08:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58738 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233793AbiHLVIM (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 12 Aug 2022 17:08:12 -0400
Received: from mail-pf1-f176.google.com (mail-pf1-f176.google.com [209.85.210.176])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7B552B4426
        for <linux-block@vger.kernel.org>; Fri, 12 Aug 2022 14:08:11 -0700 (PDT)
Received: by mail-pf1-f176.google.com with SMTP id y141so1937678pfb.7
        for <linux-block@vger.kernel.org>; Fri, 12 Aug 2022 14:08:11 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc;
        bh=LsmXrLkuvPDoYrBSFGfCDAwOUzDQtSz/zVykfiuT9BA=;
        b=uGiiO4D4HyQZp1Rvk2uxGtBbfP9H7t6mDXkFVwqyaf41XNYjl8Ck1oM0ObVguhNWU9
         c8DMq6okD5uss/R7JTvLliasH8jd9qk9Km1cBZE/GFe5eFKncpqN3L8umDH4Ndfr7O0L
         875bTWOPRQCQbv5duGDg5+PtlvgEW7E1hJAuCnFUAI2VXnb2J735lLisW5W0iKMSlzex
         vA9vHC+8N2G0Gq2Mqllb5Yq1Xa2FT5ysAKTgNM8yhycG/YYQC5fBJ+ObdglP582Wvfsy
         qTfymogA2UFoY0adTmCS3xgppl28jtgrx+WBVar9qYdtF3yc5JuyUwyRm3UCy/9/Owz/
         Dpzw==
X-Gm-Message-State: ACgBeo3gkOKj73dQkONshYKrAnwW8qsaROYRwlTETsVzWdY8sGw4NyIO
        sq+bHXPCbCBtCNCOYiaref4=
X-Google-Smtp-Source: AA6agR4VpH3m8i/5qvRfZxiSiL5Qnui2lmtL/R3aJ4muy10C3lTBzm1ewRevbr4eekiBy86iV2PjGQ==
X-Received: by 2002:a65:6d86:0:b0:41c:d0c0:d6b5 with SMTP id bc6-20020a656d86000000b0041cd0c0d6b5mr4674536pgb.534.1660338490939;
        Fri, 12 Aug 2022 14:08:10 -0700 (PDT)
Received: from bvanassche-linux.mtv.corp.google.com ([2620:15c:211:201:2414:9f13:41de:d21d])
        by smtp.gmail.com with ESMTPSA id w62-20020a17090a6bc400b001f3095af6a9sm245905pjj.38.2022.08.12.14.08.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 12 Aug 2022 14:08:10 -0700 (PDT)
From:   Bart Van Assche <bvanassche@acm.org>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org, Christoph Hellwig <hch@lst.de>,
        Jaegeuk Kim <jaegeuk@kernel.org>,
        Bart Van Assche <bvanassche@acm.org>,
        "Martin K . Petersen" <martin.petersen@oracle.com>,
        Keith Busch <keith.busch@intel.com>
Subject: [PATCH 2/6] block: Change the return type of blk_mq_pci_map_queues() into void
Date:   Fri, 12 Aug 2022 14:07:56 -0700
Message-Id: <20220812210800.2253972-3-bvanassche@acm.org>
X-Mailer: git-send-email 2.37.1.595.g718a3a8f04-goog
In-Reply-To: <20220812210800.2253972-1-bvanassche@acm.org>
References: <20220812210800.2253972-1-bvanassche@acm.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Since blk_mq_pci_map_queues() always returns 0, change its return type
into void. Most callers ignore the returned value anyway.

Cc: Christoph Hellwig <hch@lst.de>
Cc: Martin K. Petersen <martin.petersen@oracle.com>
Cc: Keith Busch <keith.busch@intel.com>
Signed-off-by: Bart Van Assche <bvanassche@acm.org>
---
 block/blk-mq-pci.c                     | 7 +++----
 drivers/scsi/hisi_sas/hisi_sas_v3_hw.c | 4 ++--
 drivers/scsi/qla2xxx/qla_nvme.c        | 6 +-----
 drivers/scsi/qla2xxx/qla_os.c          | 5 ++---
 drivers/scsi/smartpqi/smartpqi_init.c  | 5 +++--
 include/linux/blk-mq-pci.h             | 4 ++--
 6 files changed, 13 insertions(+), 18 deletions(-)

diff --git a/block/blk-mq-pci.c b/block/blk-mq-pci.c
index b595a94c4d16..a90b88fd1332 100644
--- a/block/blk-mq-pci.c
+++ b/block/blk-mq-pci.c
@@ -23,8 +23,8 @@
  * that maps a queue to the CPUs that have irq affinity for the corresponding
  * vector.
  */
-int blk_mq_pci_map_queues(struct blk_mq_queue_map *qmap, struct pci_dev *pdev,
-			    int offset)
+void blk_mq_pci_map_queues(struct blk_mq_queue_map *qmap, struct pci_dev *pdev,
+			   int offset)
 {
 	const struct cpumask *mask;
 	unsigned int queue, cpu;
@@ -38,11 +38,10 @@ int blk_mq_pci_map_queues(struct blk_mq_queue_map *qmap, struct pci_dev *pdev,
 			qmap->mq_map[cpu] = qmap->queue_offset + queue;
 	}
 
-	return 0;
+	return;
 
 fallback:
 	WARN_ON_ONCE(qmap->nr_queues > 1);
 	blk_mq_clear_mq_map(qmap);
-	return 0;
 }
 EXPORT_SYMBOL_GPL(blk_mq_pci_map_queues);
diff --git a/drivers/scsi/hisi_sas/hisi_sas_v3_hw.c b/drivers/scsi/hisi_sas/hisi_sas_v3_hw.c
index efe8c5be5870..c1e541dcbac0 100644
--- a/drivers/scsi/hisi_sas/hisi_sas_v3_hw.c
+++ b/drivers/scsi/hisi_sas/hisi_sas_v3_hw.c
@@ -3176,8 +3176,8 @@ static int hisi_sas_map_queues(struct Scsi_Host *shost)
 	struct hisi_hba *hisi_hba = shost_priv(shost);
 	struct blk_mq_queue_map *qmap = &shost->tag_set.map[HCTX_TYPE_DEFAULT];
 
-	return blk_mq_pci_map_queues(qmap, hisi_hba->pci_dev,
-				     BASE_VECTORS_V3_HW);
+	blk_mq_pci_map_queues(qmap, hisi_hba->pci_dev, BASE_VECTORS_V3_HW);
+	return 0;
 }
 
 static struct scsi_host_template sht_v3_hw = {
diff --git a/drivers/scsi/qla2xxx/qla_nvme.c b/drivers/scsi/qla2xxx/qla_nvme.c
index 7450c3458be7..02fdeb0d31ec 100644
--- a/drivers/scsi/qla2xxx/qla_nvme.c
+++ b/drivers/scsi/qla2xxx/qla_nvme.c
@@ -684,12 +684,8 @@ static void qla_nvme_map_queues(struct nvme_fc_local_port *lport,
 		struct blk_mq_queue_map *map)
 {
 	struct scsi_qla_host *vha = lport->private;
-	int rc;
 
-	rc = blk_mq_pci_map_queues(map, vha->hw->pdev, vha->irq_offset);
-	if (rc)
-		ql_log(ql_log_warn, vha, 0x21de,
-		       "pci map queue failed 0x%x", rc);
+	blk_mq_pci_map_queues(map, vha->hw->pdev, vha->irq_offset);
 }
 
 static void qla_nvme_localport_delete(struct nvme_fc_local_port *lport)
diff --git a/drivers/scsi/qla2xxx/qla_os.c b/drivers/scsi/qla2xxx/qla_os.c
index c4e7dd14930d..26cd27684410 100644
--- a/drivers/scsi/qla2xxx/qla_os.c
+++ b/drivers/scsi/qla2xxx/qla_os.c
@@ -7996,15 +7996,14 @@ qla_pci_reset_done(struct pci_dev *pdev)
 
 static int qla2xxx_map_queues(struct Scsi_Host *shost)
 {
-	int rc = 0;
 	scsi_qla_host_t *vha = (scsi_qla_host_t *)shost->hostdata;
 	struct blk_mq_queue_map *qmap = &shost->tag_set.map[HCTX_TYPE_DEFAULT];
 
 	if (USER_CTRL_IRQ(vha->hw) || !vha->hw->mqiobase)
 		blk_mq_map_queues(qmap);
 	else
-		rc = blk_mq_pci_map_queues(qmap, vha->hw->pdev, vha->irq_offset);
-	return rc;
+		blk_mq_pci_map_queues(qmap, vha->hw->pdev, vha->irq_offset);
+	return 0;
 }
 
 struct scsi_host_template qla2xxx_driver_template = {
diff --git a/drivers/scsi/smartpqi/smartpqi_init.c b/drivers/scsi/smartpqi/smartpqi_init.c
index 7a8c2c75acba..bc43f3fe5ba5 100644
--- a/drivers/scsi/smartpqi/smartpqi_init.c
+++ b/drivers/scsi/smartpqi/smartpqi_init.c
@@ -6440,8 +6440,9 @@ static int pqi_map_queues(struct Scsi_Host *shost)
 {
 	struct pqi_ctrl_info *ctrl_info = shost_to_hba(shost);
 
-	return blk_mq_pci_map_queues(&shost->tag_set.map[HCTX_TYPE_DEFAULT],
-					ctrl_info->pci_dev, 0);
+	blk_mq_pci_map_queues(&shost->tag_set.map[HCTX_TYPE_DEFAULT],
+			      ctrl_info->pci_dev, 0);
+	return 0;
 }
 
 static inline bool pqi_is_tape_changer_device(struct pqi_scsi_dev *device)
diff --git a/include/linux/blk-mq-pci.h b/include/linux/blk-mq-pci.h
index 0b1f45c62623..ca544e1d3508 100644
--- a/include/linux/blk-mq-pci.h
+++ b/include/linux/blk-mq-pci.h
@@ -5,7 +5,7 @@
 struct blk_mq_queue_map;
 struct pci_dev;
 
-int blk_mq_pci_map_queues(struct blk_mq_queue_map *qmap, struct pci_dev *pdev,
-			  int offset);
+void blk_mq_pci_map_queues(struct blk_mq_queue_map *qmap, struct pci_dev *pdev,
+			   int offset);
 
 #endif /* _LINUX_BLK_MQ_PCI_H */
