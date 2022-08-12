Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 58442C00140
	for <linux-block@archiver.kernel.org>; Fri, 12 Aug 2022 21:09:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229646AbiHLVI3 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 12 Aug 2022 17:08:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58720 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233675AbiHLVIK (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 12 Aug 2022 17:08:10 -0400
Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B8FC8B4426
        for <linux-block@vger.kernel.org>; Fri, 12 Aug 2022 14:08:09 -0700 (PDT)
Received: by mail-pl1-f179.google.com with SMTP id m2so1749851pls.4
        for <linux-block@vger.kernel.org>; Fri, 12 Aug 2022 14:08:09 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc;
        bh=jergAwzYxFwIRDZ7smxypohSe4H0FutPEesfPOIeVGw=;
        b=TTVTJgHhco9UQVxPyH9jS+J1Dqc5SywUKIvjgELQz0pY1exotXcCXubwCOzKTrNzSo
         owMwQszlG8LCXyGSDdWNPE40wAAOLjQ/veAZkvkK3HMCJh8rNYFYdLfykWyM07LGDFFN
         YLC75A9N4FzSQzi1JCa7EFDTyY19VjMhLawxxDDOG/EuuBy6e1lAsLM90uKYakV8q0ex
         0CdOTf36sO1U+SX90mVYIyCEpTATQqw3p9ahHv+ia4Os4MsWBGVDCTbCX4HBZM/7+f7x
         4cIPY6hwoXwRS59MPRnh7DXL5PQJleNFY1gGiIMcpgUxaJ5i4wnTf23DIbDDWuBAVcRW
         KRHg==
X-Gm-Message-State: ACgBeo0ZH/DQyNp6DtDAx3OfdLxOYaJaAmhsElF8jMuM5E4emKkImiqN
        nML0OWkPOOTiK9l5J8lvQ+VR/mGPeuw=
X-Google-Smtp-Source: AA6agR5U1OKSyAaYcHlcaJSozNFmdm7l6/WVmsgfEgHUiufAnasEuo4gFjIVLrGRfjo8ylIXKtB1Bg==
X-Received: by 2002:a17:902:c945:b0:16e:d24d:1b27 with SMTP id i5-20020a170902c94500b0016ed24d1b27mr5900690pla.51.1660338489164;
        Fri, 12 Aug 2022 14:08:09 -0700 (PDT)
Received: from bvanassche-linux.mtv.corp.google.com ([2620:15c:211:201:2414:9f13:41de:d21d])
        by smtp.gmail.com with ESMTPSA id w62-20020a17090a6bc400b001f3095af6a9sm245905pjj.38.2022.08.12.14.08.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 12 Aug 2022 14:08:08 -0700 (PDT)
From:   Bart Van Assche <bvanassche@acm.org>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org, Christoph Hellwig <hch@lst.de>,
        Jaegeuk Kim <jaegeuk@kernel.org>,
        Bart Van Assche <bvanassche@acm.org>,
        "Martin K . Petersen" <martin.petersen@oracle.com>,
        Keith Busch <keith.busch@intel.com>
Subject: [PATCH 1/6] block: Change the return type of blk_mq_map_queues() into void
Date:   Fri, 12 Aug 2022 14:07:55 -0700
Message-Id: <20220812210800.2253972-2-bvanassche@acm.org>
X-Mailer: git-send-email 2.37.1.595.g718a3a8f04-goog
In-Reply-To: <20220812210800.2253972-1-bvanassche@acm.org>
References: <20220812210800.2253972-1-bvanassche@acm.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Since blk_mq_map_queues() always returns 0, change its return type into
void. Most callers ignore the returned value anyway.

Cc: Christoph Hellwig <hch@lst.de>
Cc: Martin K. Petersen <martin.petersen@oracle.com>
Cc: Keith Busch <keith.busch@intel.com>
Signed-off-by: Bart Van Assche <bvanassche@acm.org>
---
 block/blk-mq-cpumap.c         | 4 +---
 block/blk-mq-rdma.c           | 3 ++-
 block/blk-mq-virtio.c         | 3 ++-
 block/blk-mq.c                | 3 ++-
 drivers/scsi/qla2xxx/qla_os.c | 4 ++--
 drivers/scsi/scsi_lib.c       | 3 ++-
 drivers/ufs/core/ufshcd.c     | 5 ++---
 include/linux/blk-mq.h        | 2 +-
 8 files changed, 14 insertions(+), 13 deletions(-)

diff --git a/block/blk-mq-cpumap.c b/block/blk-mq-cpumap.c
index 3db84d3197f1..9c2fce1a7b50 100644
--- a/block/blk-mq-cpumap.c
+++ b/block/blk-mq-cpumap.c
@@ -32,7 +32,7 @@ static int get_first_sibling(unsigned int cpu)
 	return cpu;
 }
 
-int blk_mq_map_queues(struct blk_mq_queue_map *qmap)
+void blk_mq_map_queues(struct blk_mq_queue_map *qmap)
 {
 	unsigned int *map = qmap->mq_map;
 	unsigned int nr_queues = qmap->nr_queues;
@@ -70,8 +70,6 @@ int blk_mq_map_queues(struct blk_mq_queue_map *qmap)
 				map[cpu] = map[first_sibling];
 		}
 	}
-
-	return 0;
 }
 EXPORT_SYMBOL_GPL(blk_mq_map_queues);
 
diff --git a/block/blk-mq-rdma.c b/block/blk-mq-rdma.c
index 14f968e58b8f..18c2e00ba0d1 100644
--- a/block/blk-mq-rdma.c
+++ b/block/blk-mq-rdma.c
@@ -39,6 +39,7 @@ int blk_mq_rdma_map_queues(struct blk_mq_queue_map *map,
 	return 0;
 
 fallback:
-	return blk_mq_map_queues(map);
+	blk_mq_map_queues(map);
+	return 0;
 }
 EXPORT_SYMBOL_GPL(blk_mq_rdma_map_queues);
diff --git a/block/blk-mq-virtio.c b/block/blk-mq-virtio.c
index 7b8a42c35102..fa84e748cb69 100644
--- a/block/blk-mq-virtio.c
+++ b/block/blk-mq-virtio.c
@@ -41,6 +41,7 @@ int blk_mq_virtio_map_queues(struct blk_mq_queue_map *qmap,
 
 	return 0;
 fallback:
-	return blk_mq_map_queues(qmap);
+	blk_mq_map_queues(qmap);
+	return 0;
 }
 EXPORT_SYMBOL_GPL(blk_mq_virtio_map_queues);
diff --git a/block/blk-mq.c b/block/blk-mq.c
index 530aad95cc33..0b0fcd01c0e2 100644
--- a/block/blk-mq.c
+++ b/block/blk-mq.c
@@ -4220,7 +4220,8 @@ static int blk_mq_update_queue_map(struct blk_mq_tag_set *set)
 		return set->ops->map_queues(set);
 	} else {
 		BUG_ON(set->nr_maps > 1);
-		return blk_mq_map_queues(&set->map[HCTX_TYPE_DEFAULT]);
+		blk_mq_map_queues(&set->map[HCTX_TYPE_DEFAULT]);
+		return 0;
 	}
 }
 
diff --git a/drivers/scsi/qla2xxx/qla_os.c b/drivers/scsi/qla2xxx/qla_os.c
index 0bd0fd1042df..c4e7dd14930d 100644
--- a/drivers/scsi/qla2xxx/qla_os.c
+++ b/drivers/scsi/qla2xxx/qla_os.c
@@ -7996,12 +7996,12 @@ qla_pci_reset_done(struct pci_dev *pdev)
 
 static int qla2xxx_map_queues(struct Scsi_Host *shost)
 {
-	int rc;
+	int rc = 0;
 	scsi_qla_host_t *vha = (scsi_qla_host_t *)shost->hostdata;
 	struct blk_mq_queue_map *qmap = &shost->tag_set.map[HCTX_TYPE_DEFAULT];
 
 	if (USER_CTRL_IRQ(vha->hw) || !vha->hw->mqiobase)
-		rc = blk_mq_map_queues(qmap);
+		blk_mq_map_queues(qmap);
 	else
 		rc = blk_mq_pci_map_queues(qmap, vha->hw->pdev, vha->irq_offset);
 	return rc;
diff --git a/drivers/scsi/scsi_lib.c b/drivers/scsi/scsi_lib.c
index 4dbd29ab1dcc..4ea75b35ce9b 100644
--- a/drivers/scsi/scsi_lib.c
+++ b/drivers/scsi/scsi_lib.c
@@ -1855,7 +1855,8 @@ static int scsi_map_queues(struct blk_mq_tag_set *set)
 
 	if (shost->hostt->map_queues)
 		return shost->hostt->map_queues(shost);
-	return blk_mq_map_queues(&set->map[HCTX_TYPE_DEFAULT]);
+	blk_mq_map_queues(&set->map[HCTX_TYPE_DEFAULT]);
+	return 0;
 }
 
 void __scsi_init_queue(struct Scsi_Host *shost, struct request_queue *q)
diff --git a/drivers/ufs/core/ufshcd.c b/drivers/ufs/core/ufshcd.c
index 3bc0709a5dc2..a619622b894a 100644
--- a/drivers/ufs/core/ufshcd.c
+++ b/drivers/ufs/core/ufshcd.c
@@ -2703,7 +2703,7 @@ static inline bool is_device_wlun(struct scsi_device *sdev)
  */
 static int ufshcd_map_queues(struct Scsi_Host *shost)
 {
-	int i, ret;
+	int i;
 
 	for (i = 0; i < shost->nr_maps; i++) {
 		struct blk_mq_queue_map *map = &shost->tag_set.map[i];
@@ -2720,8 +2720,7 @@ static int ufshcd_map_queues(struct Scsi_Host *shost)
 			WARN_ON_ONCE(true);
 		}
 		map->queue_offset = 0;
-		ret = blk_mq_map_queues(map);
-		WARN_ON_ONCE(ret);
+		blk_mq_map_queues(map);
 	}
 
 	return 0;
diff --git a/include/linux/blk-mq.h b/include/linux/blk-mq.h
index effee1dc715a..5fc5d6b2d55a 100644
--- a/include/linux/blk-mq.h
+++ b/include/linux/blk-mq.h
@@ -881,7 +881,7 @@ void blk_mq_freeze_queue_wait(struct request_queue *q);
 int blk_mq_freeze_queue_wait_timeout(struct request_queue *q,
 				     unsigned long timeout);
 
-int blk_mq_map_queues(struct blk_mq_queue_map *qmap);
+void blk_mq_map_queues(struct blk_mq_queue_map *qmap);
 void blk_mq_update_nr_hw_queues(struct blk_mq_tag_set *set, int nr_hw_queues);
 
 void blk_mq_quiesce_queue_nowait(struct request_queue *q);
