Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EC8AAC2BB41
	for <linux-block@archiver.kernel.org>; Fri, 12 Aug 2022 21:09:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231698AbiHLVIb (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 12 Aug 2022 17:08:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58820 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233872AbiHLVIX (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 12 Aug 2022 17:08:23 -0400
Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 313A9B56E3
        for <linux-block@vger.kernel.org>; Fri, 12 Aug 2022 14:08:21 -0700 (PDT)
Received: by mail-pl1-f179.google.com with SMTP id x23so1739645pll.7
        for <linux-block@vger.kernel.org>; Fri, 12 Aug 2022 14:08:21 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc;
        bh=2VzsOM24s765PKEeca8bFaT6JYwE/lxbD0CDgbloRRk=;
        b=D49WiuFkstZXcy3Twjww5ZPFgSBk5qr0tS6l5au8OcLrrr2cM+gYCaXXrRDArAtw9Y
         w94IRLw2nd03jzIUyIsm0WAXRHUcu60VegKJHpoBNmFIQpy78DlvWGg8YJSjo4+8/55T
         QZM2hAQ+qCAEW1QW3Sc0ZBWX+CFAIt6ysYxHyJJHN40UMKZPeuY+J+lSeP8WbxPf4Wes
         9dOfR0W0fdB8bz/EeUNdDMycYag5X5f1FnUvmWznbIenEoU5EXe5G4Ovj/Vr3SL4qU9S
         1UqF6AmQdjqVGe847BYLPquItvXSPBYGA36/Yn+CtpaCxxFCfoB6RnLtVSNFVStRM09Y
         ZLmQ==
X-Gm-Message-State: ACgBeo2FtQSztYUiGeGMp2KfuQtCEeD6f9wL+RloEawfDu3T6PTnX1O5
        HSQdZvNFVkcdshKZZgoI4Lc=
X-Google-Smtp-Source: AA6agR6tFP/huoXLi5DxlTv3pBUtvYiOplSwT8Dz0EdkLxWxDRr82mm/pVj7uUXh9Fe434sgmw6lbg==
X-Received: by 2002:a17:903:124e:b0:171:4c36:a6c8 with SMTP id u14-20020a170903124e00b001714c36a6c8mr5780401plh.169.1660338500608;
        Fri, 12 Aug 2022 14:08:20 -0700 (PDT)
Received: from bvanassche-linux.mtv.corp.google.com ([2620:15c:211:201:2414:9f13:41de:d21d])
        by smtp.gmail.com with ESMTPSA id w62-20020a17090a6bc400b001f3095af6a9sm245905pjj.38.2022.08.12.14.08.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 12 Aug 2022 14:08:19 -0700 (PDT)
From:   Bart Van Assche <bvanassche@acm.org>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org, Christoph Hellwig <hch@lst.de>,
        Jaegeuk Kim <jaegeuk@kernel.org>,
        Bart Van Assche <bvanassche@acm.org>,
        "Martin K . Petersen" <martin.petersen@oracle.com>,
        Keith Busch <keith.busch@intel.com>
Subject: [PATCH 6/6] block: Change the return type of .map_queues() into void
Date:   Fri, 12 Aug 2022 14:08:00 -0700
Message-Id: <20220812210800.2253972-7-bvanassche@acm.org>
X-Mailer: git-send-email 2.37.1.595.g718a3a8f04-goog
In-Reply-To: <20220812210800.2253972-1-bvanassche@acm.org>
References: <20220812210800.2253972-1-bvanassche@acm.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

All .map_queues() implementations return 0. Hence change the return type
of these callback functions and also of blk_mq_update_queue_map() into
void.

Cc: Christoph Hellwig <hch@lst.de>
Cc: Martin K. Petersen <martin.petersen@oracle.com>
Cc: Keith Busch <keith.busch@intel.com>
Signed-off-by: Bart Van Assche <bvanassche@acm.org>
---
 block/blk-mq-rdma.c           | 5 ++---
 block/blk-mq.c                | 9 +++------
 drivers/block/null_blk/main.c | 4 +---
 drivers/block/rnbd/rnbd-clt.c | 4 +---
 drivers/block/virtio_blk.c    | 4 +---
 drivers/nvme/host/fc.c        | 3 +--
 drivers/nvme/host/pci.c       | 4 +---
 drivers/nvme/host/rdma.c      | 4 +---
 drivers/nvme/host/tcp.c       | 4 +---
 drivers/scsi/scsi_lib.c       | 9 +++------
 include/linux/blk-mq-rdma.h   | 2 +-
 include/linux/blk-mq.h        | 2 +-
 12 files changed, 17 insertions(+), 37 deletions(-)

diff --git a/block/blk-mq-rdma.c b/block/blk-mq-rdma.c
index 18c2e00ba0d1..29c1f4d6eb04 100644
--- a/block/blk-mq-rdma.c
+++ b/block/blk-mq-rdma.c
@@ -21,7 +21,7 @@
  * @set->nr_hw_queues, or @dev does not provide an affinity mask for a
  * vector, we fallback to the naive mapping.
  */
-int blk_mq_rdma_map_queues(struct blk_mq_queue_map *map,
+void blk_mq_rdma_map_queues(struct blk_mq_queue_map *map,
 		struct ib_device *dev, int first_vec)
 {
 	const struct cpumask *mask;
@@ -36,10 +36,9 @@ int blk_mq_rdma_map_queues(struct blk_mq_queue_map *map,
 			map->mq_map[cpu] = map->queue_offset + queue;
 	}
 
-	return 0;
+	return;
 
 fallback:
 	blk_mq_map_queues(map);
-	return 0;
 }
 EXPORT_SYMBOL_GPL(blk_mq_rdma_map_queues);
diff --git a/block/blk-mq.c b/block/blk-mq.c
index 0b0fcd01c0e2..96742de0475f 100644
--- a/block/blk-mq.c
+++ b/block/blk-mq.c
@@ -4187,7 +4187,7 @@ static int blk_mq_alloc_set_map_and_rqs(struct blk_mq_tag_set *set)
 	return 0;
 }
 
-static int blk_mq_update_queue_map(struct blk_mq_tag_set *set)
+static void blk_mq_update_queue_map(struct blk_mq_tag_set *set)
 {
 	/*
 	 * blk_mq_map_queues() and multiple .map_queues() implementations
@@ -4217,11 +4217,10 @@ static int blk_mq_update_queue_map(struct blk_mq_tag_set *set)
 		for (i = 0; i < set->nr_maps; i++)
 			blk_mq_clear_mq_map(&set->map[i]);
 
-		return set->ops->map_queues(set);
+		set->ops->map_queues(set);
 	} else {
 		BUG_ON(set->nr_maps > 1);
 		blk_mq_map_queues(&set->map[HCTX_TYPE_DEFAULT]);
-		return 0;
 	}
 }
 
@@ -4320,9 +4319,7 @@ int blk_mq_alloc_tag_set(struct blk_mq_tag_set *set)
 		set->map[i].nr_queues = is_kdump_kernel() ? 1 : set->nr_hw_queues;
 	}
 
-	ret = blk_mq_update_queue_map(set);
-	if (ret)
-		goto out_free_mq_map;
+	blk_mq_update_queue_map(set);
 
 	ret = blk_mq_alloc_set_map_and_rqs(set);
 	if (ret)
diff --git a/drivers/block/null_blk/main.c b/drivers/block/null_blk/main.c
index 535059209693..1f154f92f4c2 100644
--- a/drivers/block/null_blk/main.c
+++ b/drivers/block/null_blk/main.c
@@ -1528,7 +1528,7 @@ static bool should_requeue_request(struct request *rq)
 	return false;
 }
 
-static int null_map_queues(struct blk_mq_tag_set *set)
+static void null_map_queues(struct blk_mq_tag_set *set)
 {
 	struct nullb *nullb = set->driver_data;
 	int i, qoff;
@@ -1579,8 +1579,6 @@ static int null_map_queues(struct blk_mq_tag_set *set)
 		qoff += map->nr_queues;
 		blk_mq_map_queues(map);
 	}
-
-	return 0;
 }
 
 static int null_poll(struct blk_mq_hw_ctx *hctx, struct io_comp_batch *iob)
diff --git a/drivers/block/rnbd/rnbd-clt.c b/drivers/block/rnbd/rnbd-clt.c
index 04da33a22ef4..9d01e7ab33e4 100644
--- a/drivers/block/rnbd/rnbd-clt.c
+++ b/drivers/block/rnbd/rnbd-clt.c
@@ -1165,7 +1165,7 @@ static int rnbd_rdma_poll(struct blk_mq_hw_ctx *hctx, struct io_comp_batch *iob)
 	return cnt;
 }
 
-static int rnbd_rdma_map_queues(struct blk_mq_tag_set *set)
+static void rnbd_rdma_map_queues(struct blk_mq_tag_set *set)
 {
 	struct rnbd_clt_session *sess = set->driver_data;
 
@@ -1194,8 +1194,6 @@ static int rnbd_rdma_map_queues(struct blk_mq_tag_set *set)
 			set->map[HCTX_TYPE_DEFAULT].nr_queues,
 			set->map[HCTX_TYPE_READ].nr_queues);
 	}
-
-	return 0;
 }
 
 static struct blk_mq_ops rnbd_mq_ops = {
diff --git a/drivers/block/virtio_blk.c b/drivers/block/virtio_blk.c
index 30255fcaf181..23c5a1239520 100644
--- a/drivers/block/virtio_blk.c
+++ b/drivers/block/virtio_blk.c
@@ -802,7 +802,7 @@ static const struct attribute_group *virtblk_attr_groups[] = {
 	NULL,
 };
 
-static int virtblk_map_queues(struct blk_mq_tag_set *set)
+static void virtblk_map_queues(struct blk_mq_tag_set *set)
 {
 	struct virtio_blk *vblk = set->driver_data;
 	int i, qoff;
@@ -827,8 +827,6 @@ static int virtblk_map_queues(struct blk_mq_tag_set *set)
 		else
 			blk_mq_virtio_map_queues(&set->map[i], vblk->vdev, 0);
 	}
-
-	return 0;
 }
 
 static void virtblk_complete_batch(struct io_comp_batch *iob)
diff --git a/drivers/nvme/host/fc.c b/drivers/nvme/host/fc.c
index 9987797620b6..23b356c649b6 100644
--- a/drivers/nvme/host/fc.c
+++ b/drivers/nvme/host/fc.c
@@ -2858,7 +2858,7 @@ nvme_fc_complete_rq(struct request *rq)
 	nvme_fc_ctrl_put(ctrl);
 }
 
-static int nvme_fc_map_queues(struct blk_mq_tag_set *set)
+static void nvme_fc_map_queues(struct blk_mq_tag_set *set)
 {
 	struct nvme_fc_ctrl *ctrl = set->driver_data;
 	int i;
@@ -2878,7 +2878,6 @@ static int nvme_fc_map_queues(struct blk_mq_tag_set *set)
 		else
 			blk_mq_map_queues(map);
 	}
-	return 0;
 }
 
 static const struct blk_mq_ops nvme_fc_mq_ops = {
diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c
index de1b4463142d..7a35ac0fe32d 100644
--- a/drivers/nvme/host/pci.c
+++ b/drivers/nvme/host/pci.c
@@ -450,7 +450,7 @@ static int queue_irq_offset(struct nvme_dev *dev)
 	return 0;
 }
 
-static int nvme_pci_map_queues(struct blk_mq_tag_set *set)
+static void nvme_pci_map_queues(struct blk_mq_tag_set *set)
 {
 	struct nvme_dev *dev = set->driver_data;
 	int i, qoff, offset;
@@ -477,8 +477,6 @@ static int nvme_pci_map_queues(struct blk_mq_tag_set *set)
 		qoff += map->nr_queues;
 		offset += map->nr_queues;
 	}
-
-	return 0;
 }
 
 /*
diff --git a/drivers/nvme/host/rdma.c b/drivers/nvme/host/rdma.c
index 3100643be299..ba08851e42c3 100644
--- a/drivers/nvme/host/rdma.c
+++ b/drivers/nvme/host/rdma.c
@@ -2188,7 +2188,7 @@ static void nvme_rdma_complete_rq(struct request *rq)
 	nvme_complete_rq(rq);
 }
 
-static int nvme_rdma_map_queues(struct blk_mq_tag_set *set)
+static void nvme_rdma_map_queues(struct blk_mq_tag_set *set)
 {
 	struct nvme_rdma_ctrl *ctrl = set->driver_data;
 	struct nvmf_ctrl_options *opts = ctrl->ctrl.opts;
@@ -2231,8 +2231,6 @@ static int nvme_rdma_map_queues(struct blk_mq_tag_set *set)
 		ctrl->io_queues[HCTX_TYPE_DEFAULT],
 		ctrl->io_queues[HCTX_TYPE_READ],
 		ctrl->io_queues[HCTX_TYPE_POLL]);
-
-	return 0;
 }
 
 static const struct blk_mq_ops nvme_rdma_mq_ops = {
diff --git a/drivers/nvme/host/tcp.c b/drivers/nvme/host/tcp.c
index e82dcfcda29b..7bf83d119f91 100644
--- a/drivers/nvme/host/tcp.c
+++ b/drivers/nvme/host/tcp.c
@@ -2468,7 +2468,7 @@ static blk_status_t nvme_tcp_queue_rq(struct blk_mq_hw_ctx *hctx,
 	return BLK_STS_OK;
 }
 
-static int nvme_tcp_map_queues(struct blk_mq_tag_set *set)
+static void nvme_tcp_map_queues(struct blk_mq_tag_set *set)
 {
 	struct nvme_tcp_ctrl *ctrl = set->driver_data;
 	struct nvmf_ctrl_options *opts = ctrl->ctrl.opts;
@@ -2509,8 +2509,6 @@ static int nvme_tcp_map_queues(struct blk_mq_tag_set *set)
 		ctrl->io_queues[HCTX_TYPE_DEFAULT],
 		ctrl->io_queues[HCTX_TYPE_READ],
 		ctrl->io_queues[HCTX_TYPE_POLL]);
-
-	return 0;
 }
 
 static int nvme_tcp_poll(struct blk_mq_hw_ctx *hctx, struct io_comp_batch *iob)
diff --git a/drivers/scsi/scsi_lib.c b/drivers/scsi/scsi_lib.c
index ab40e2a2633a..677f632d6fd3 100644
--- a/drivers/scsi/scsi_lib.c
+++ b/drivers/scsi/scsi_lib.c
@@ -1849,16 +1849,13 @@ static int scsi_init_hctx(struct blk_mq_hw_ctx *hctx, void *data,
 	return 0;
 }
 
-static int scsi_map_queues(struct blk_mq_tag_set *set)
+static void scsi_map_queues(struct blk_mq_tag_set *set)
 {
 	struct Scsi_Host *shost = container_of(set, struct Scsi_Host, tag_set);
 
-	if (shost->hostt->map_queues) {
-		shost->hostt->map_queues(shost);
-		return 0;
-	}
+	if (shost->hostt->map_queues)
+		return shost->hostt->map_queues(shost);
 	blk_mq_map_queues(&set->map[HCTX_TYPE_DEFAULT]);
-	return 0;
 }
 
 void __scsi_init_queue(struct Scsi_Host *shost, struct request_queue *q)
diff --git a/include/linux/blk-mq-rdma.h b/include/linux/blk-mq-rdma.h
index 5cc5f0f36218..53b58c610e76 100644
--- a/include/linux/blk-mq-rdma.h
+++ b/include/linux/blk-mq-rdma.h
@@ -5,7 +5,7 @@
 struct blk_mq_tag_set;
 struct ib_device;
 
-int blk_mq_rdma_map_queues(struct blk_mq_queue_map *map,
+void blk_mq_rdma_map_queues(struct blk_mq_queue_map *map,
 		struct ib_device *dev, int first_vec);
 
 #endif /* _LINUX_BLK_MQ_RDMA_H */
diff --git a/include/linux/blk-mq.h b/include/linux/blk-mq.h
index 5fc5d6b2d55a..b1ae475e34a7 100644
--- a/include/linux/blk-mq.h
+++ b/include/linux/blk-mq.h
@@ -630,7 +630,7 @@ struct blk_mq_ops {
 	 * @map_queues: This allows drivers specify their own queue mapping by
 	 * overriding the setup-time function that builds the mq_map.
 	 */
-	int (*map_queues)(struct blk_mq_tag_set *set);
+	void (*map_queues)(struct blk_mq_tag_set *set);
 
 #ifdef CONFIG_BLK_DEBUG_FS
 	/**
