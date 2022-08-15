Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E1A46C00140
	for <linux-block@archiver.kernel.org>; Mon, 15 Aug 2022 17:01:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232902AbiHORBa (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 15 Aug 2022 13:01:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51824 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229631AbiHORB3 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 15 Aug 2022 13:01:29 -0400
Received: from mail-pg1-f174.google.com (mail-pg1-f174.google.com [209.85.215.174])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 97E3A23BE9
        for <linux-block@vger.kernel.org>; Mon, 15 Aug 2022 10:01:26 -0700 (PDT)
Received: by mail-pg1-f174.google.com with SMTP id d71so6962288pgc.13
        for <linux-block@vger.kernel.org>; Mon, 15 Aug 2022 10:01:26 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc;
        bh=UNGj07BnHW8f1vuB0qkxrtLxkS5rUBabWr49DRYa9GE=;
        b=NFa4FiUP6N0LolEDTZzrG5JfU3tT2oiPnDC1gnbSuHc2qQKqZlCLst6B4/2Co3NrOp
         COKinnV4AASYt6YzflqZrlUSXKLop2/eHLp9FkAXdr4yod6DJeJXx753NRN6l94uIPYa
         ohK/XszDFkS/OtaseeEsHnR7qJFlPwEUBPgBgL90K/zp99uvaU3/8NyiqWowhiABVX0L
         BC3XLBTgu81aajP8VbTof3cfmZybLD0vjcg/LOaO7ru+GVcplOr7SycZkY0eASf4SxWq
         L7CUjRsiOVX11QT1BEkWd+t2nVz4R9VNxoeMPZ+BqPbTvH/lR8LnI016jm0OAKPxwRpc
         SPCA==
X-Gm-Message-State: ACgBeo12ZtVsJ4dZZsYbC5c52G1aETez3gIpULDq9iY5tZyLACuY4bdG
        +VHN8GGNlP6IURD1hxDNjHidChTN1tP0Qw==
X-Google-Smtp-Source: AA6agR5o6xHTyn6+g9iji72sqs7jQQLqJNbqi/gX8+1BBZI7jZRKJGjftlVa3V+guxuws45VdO+ImA==
X-Received: by 2002:a05:6a00:816:b0:52f:43f9:b644 with SMTP id m22-20020a056a00081600b0052f43f9b644mr17055892pfk.57.1660582885920;
        Mon, 15 Aug 2022 10:01:25 -0700 (PDT)
Received: from bvanassche-linux.mtv.corp.google.com ([2620:15c:211:201:c1a1:6549:b273:880b])
        by smtp.gmail.com with ESMTPSA id m2-20020a170902db0200b0016eea511f2dsm7255690plx.242.2022.08.15.10.01.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Aug 2022 10:01:24 -0700 (PDT)
From:   Bart Van Assche <bvanassche@acm.org>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org, Christoph Hellwig <hch@lst.de>,
        Bart Van Assche <bvanassche@acm.org>,
        Jason Wang <jasowang@redhat.com>,
        Keith Busch <kbusch@kernel.org>,
        "Martin K . Petersen" <martin.petersen@oracle.com>,
        Doug Gilbert <dgilbert@interlog.com>,
        "Michael S . Tsirkin" <mst@redhat.com>,
        "Md. Haris Iqbal" <haris.iqbal@ionos.com>,
        Jack Wang <jinpu.wang@ionos.com>,
        James Smart <james.smart@broadcom.com>,
        Sagi Grimberg <sagi@grimberg.me>,
        John Garry <john.garry@huawei.com>,
        "James E.J. Bottomley" <jejb@linux.ibm.com>,
        Kashyap Desai <kashyap.desai@broadcom.com>,
        Sumit Saxena <sumit.saxena@broadcom.com>,
        Shivasharan S <shivasharan.srikanteshwara@broadcom.com>,
        Sathya Prakash Veerichetty <sathya.prakash@broadcom.com>,
        Sreekanth Reddy <sreekanth.reddy@broadcom.com>,
        Suganath Prabu Subramani 
        <suganath-prabu.subramani@broadcom.com>,
        Nilesh Javali <njavali@marvell.com>,
        GR-QLogic-Storage-Upstream@marvell.com,
        Don Brace <don.brace@microchip.com>,
        Chaitanya Kulkarni <kch@nvidia.com>,
        Damien Le Moal <damien.lemoal@opensource.wdc.com>,
        Johannes Thumshirn <johannes.thumshirn@wdc.com>,
        Ming Lei <ming.lei@redhat.com>,
        "Shin'ichiro Kawasaki" <shinichiro.kawasaki@wdc.com>,
        Vincent Fu <vincent.fu@samsung.com>,
        Bean Huo <beanhuo@micron.com>,
        Avri Altman <avri.altman@wdc.com>,
        Adrian Hunter <adrian.hunter@intel.com>
Subject: [PATCH v2 2/2] block: Change the return type of blk_mq_map_queues() into void
Date:   Mon, 15 Aug 2022 10:00:43 -0700
Message-Id: <20220815170043.19489-3-bvanassche@acm.org>
X-Mailer: git-send-email 2.37.1.595.g718a3a8f04-goog
In-Reply-To: <20220815170043.19489-1-bvanassche@acm.org>
References: <20220815170043.19489-1-bvanassche@acm.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Since blk_mq_map_queues() and the .map_queues() callbacks always return 0,
change their return type into void. Most callers ignore the returned value
anyway.

Cc: Christoph Hellwig <hch@lst.de>
Cc: Jason Wang <jasowang@redhat.com>
Cc: Keith Busch <kbusch@kernel.org>
Cc: Martin K. Petersen <martin.petersen@oracle.com>
Cc: Doug Gilbert <dgilbert@interlog.com>
Cc: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Bart Van Assche <bvanassche@acm.org>
---
 block/blk-mq-cpumap.c                     |  4 +---
 block/blk-mq-pci.c                        |  7 +++----
 block/blk-mq-rdma.c                       |  6 +++---
 block/blk-mq-virtio.c                     |  7 ++++---
 block/blk-mq.c                            | 10 ++++------
 drivers/block/null_blk/main.c             |  4 +---
 drivers/block/rnbd/rnbd-clt.c             |  4 +---
 drivers/block/virtio_blk.c                |  4 +---
 drivers/nvme/host/fc.c                    |  3 +--
 drivers/nvme/host/pci.c                   |  4 +---
 drivers/nvme/host/rdma.c                  |  4 +---
 drivers/nvme/host/tcp.c                   |  4 +---
 drivers/scsi/hisi_sas/hisi_sas_v2_hw.c    |  5 +----
 drivers/scsi/hisi_sas/hisi_sas_v3_hw.c    |  5 ++---
 drivers/scsi/megaraid/megaraid_sas_base.c |  6 ++----
 drivers/scsi/mpi3mr/mpi3mr_os.c           |  5 +----
 drivers/scsi/mpt3sas/mpt3sas_scsih.c      |  5 ++---
 drivers/scsi/pm8001/pm8001_init.c         |  2 +-
 drivers/scsi/qla2xxx/qla_nvme.c           |  6 +-----
 drivers/scsi/qla2xxx/qla_os.c             | 10 ++++------
 drivers/scsi/qlogicpti.c                  |  6 ++----
 drivers/scsi/scsi_debug.c                 |  7 ++-----
 drivers/scsi/scsi_lib.c                   |  4 ++--
 drivers/scsi/smartpqi/smartpqi_init.c     |  6 +++---
 drivers/scsi/virtio_scsi.c                |  4 ++--
 drivers/ufs/core/ufshcd.c                 |  9 +++------
 include/linux/blk-mq-pci.h                |  4 ++--
 include/linux/blk-mq-rdma.h               |  2 +-
 include/linux/blk-mq-virtio.h             |  2 +-
 include/linux/blk-mq.h                    |  4 ++--
 include/scsi/scsi_host.h                  |  2 +-
 31 files changed, 57 insertions(+), 98 deletions(-)

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
diff --git a/block/blk-mq-rdma.c b/block/blk-mq-rdma.c
index 14f968e58b8f..29c1f4d6eb04 100644
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
@@ -36,9 +36,9 @@ int blk_mq_rdma_map_queues(struct blk_mq_queue_map *map,
 			map->mq_map[cpu] = map->queue_offset + queue;
 	}
 
-	return 0;
+	return;
 
 fallback:
-	return blk_mq_map_queues(map);
+	blk_mq_map_queues(map);
 }
 EXPORT_SYMBOL_GPL(blk_mq_rdma_map_queues);
diff --git a/block/blk-mq-virtio.c b/block/blk-mq-virtio.c
index 7b8a42c35102..6589f076a096 100644
--- a/block/blk-mq-virtio.c
+++ b/block/blk-mq-virtio.c
@@ -21,7 +21,7 @@
  * that maps a queue to the CPUs that have irq affinity for the corresponding
  * vector.
  */
-int blk_mq_virtio_map_queues(struct blk_mq_queue_map *qmap,
+void blk_mq_virtio_map_queues(struct blk_mq_queue_map *qmap,
 		struct virtio_device *vdev, int first_vec)
 {
 	const struct cpumask *mask;
@@ -39,8 +39,9 @@ int blk_mq_virtio_map_queues(struct blk_mq_queue_map *qmap,
 			qmap->mq_map[cpu] = qmap->queue_offset + queue;
 	}
 
-	return 0;
+	return;
+
 fallback:
-	return blk_mq_map_queues(qmap);
+	blk_mq_map_queues(qmap);
 }
 EXPORT_SYMBOL_GPL(blk_mq_virtio_map_queues);
diff --git a/block/blk-mq.c b/block/blk-mq.c
index 5ee62b95f3e5..9c362ae790e5 100644
--- a/block/blk-mq.c
+++ b/block/blk-mq.c
@@ -4210,7 +4210,7 @@ static int blk_mq_alloc_set_map_and_rqs(struct blk_mq_tag_set *set)
 	return 0;
 }
 
-static int blk_mq_update_queue_map(struct blk_mq_tag_set *set)
+static void blk_mq_update_queue_map(struct blk_mq_tag_set *set)
 {
 	/*
 	 * blk_mq_map_queues() and multiple .map_queues() implementations
@@ -4240,10 +4240,10 @@ static int blk_mq_update_queue_map(struct blk_mq_tag_set *set)
 		for (i = 0; i < set->nr_maps; i++)
 			blk_mq_clear_mq_map(&set->map[i]);
 
-		return set->ops->map_queues(set);
+		set->ops->map_queues(set);
 	} else {
 		BUG_ON(set->nr_maps > 1);
-		return blk_mq_map_queues(&set->map[HCTX_TYPE_DEFAULT]);
+		blk_mq_map_queues(&set->map[HCTX_TYPE_DEFAULT]);
 	}
 }
 
@@ -4342,9 +4342,7 @@ int blk_mq_alloc_tag_set(struct blk_mq_tag_set *set)
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
index 127abaf9ba5d..42767fb75455 100644
--- a/drivers/nvme/host/fc.c
+++ b/drivers/nvme/host/fc.c
@@ -2860,7 +2860,7 @@ nvme_fc_complete_rq(struct request *rq)
 	nvme_fc_ctrl_put(ctrl);
 }
 
-static int nvme_fc_map_queues(struct blk_mq_tag_set *set)
+static void nvme_fc_map_queues(struct blk_mq_tag_set *set)
 {
 	struct nvme_fc_ctrl *ctrl = set->driver_data;
 	int i;
@@ -2880,7 +2880,6 @@ static int nvme_fc_map_queues(struct blk_mq_tag_set *set)
 		else
 			blk_mq_map_queues(map);
 	}
-	return 0;
 }
 
 static const struct blk_mq_ops nvme_fc_mq_ops = {
diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c
index 3a1c37f32f30..4a8cfb360d31 100644
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
index 044da18c06f5..ef151c23d495 100644
--- a/drivers/nvme/host/tcp.c
+++ b/drivers/nvme/host/tcp.c
@@ -2471,7 +2471,7 @@ static blk_status_t nvme_tcp_queue_rq(struct blk_mq_hw_ctx *hctx,
 	return BLK_STS_OK;
 }
 
-static int nvme_tcp_map_queues(struct blk_mq_tag_set *set)
+static void nvme_tcp_map_queues(struct blk_mq_tag_set *set)
 {
 	struct nvme_tcp_ctrl *ctrl = set->driver_data;
 	struct nvmf_ctrl_options *opts = ctrl->ctrl.opts;
@@ -2512,8 +2512,6 @@ static int nvme_tcp_map_queues(struct blk_mq_tag_set *set)
 		ctrl->io_queues[HCTX_TYPE_DEFAULT],
 		ctrl->io_queues[HCTX_TYPE_READ],
 		ctrl->io_queues[HCTX_TYPE_POLL]);
-
-	return 0;
 }
 
 static int nvme_tcp_poll(struct blk_mq_hw_ctx *hctx, struct io_comp_batch *iob)
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
index efe8c5be5870..d716e5632d0f 100644
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
 
-	return blk_mq_pci_map_queues(qmap, hisi_hba->pci_dev,
-				     BASE_VECTORS_V3_HW);
+	blk_mq_pci_map_queues(qmap, hisi_hba->pci_dev, BASE_VECTORS_V3_HW);
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
index 0bd0fd1042df..87a93892deac 100644
--- a/drivers/scsi/qla2xxx/qla_os.c
+++ b/drivers/scsi/qla2xxx/qla_os.c
@@ -350,7 +350,7 @@ MODULE_PARM_DESC(ql2xrspq_follow_inptr_legacy,
 
 static void qla2x00_clear_drv_active(struct qla_hw_data *);
 static void qla2x00_free_device(scsi_qla_host_t *);
-static int qla2xxx_map_queues(struct Scsi_Host *shost);
+static void qla2xxx_map_queues(struct Scsi_Host *shost);
 static void qla2x00_destroy_deferred_work(struct qla_hw_data *);
 
 u32 ql2xnvme_queues = DEF_NVME_HW_QUEUES;
@@ -7994,17 +7994,15 @@ qla_pci_reset_done(struct pci_dev *pdev)
 	clear_bit(ABORT_ISP_ACTIVE, &base_vha->dpc_flags);
 }
 
-static int qla2xxx_map_queues(struct Scsi_Host *shost)
+static void qla2xxx_map_queues(struct Scsi_Host *shost)
 {
-	int rc;
 	scsi_qla_host_t *vha = (scsi_qla_host_t *)shost->hostdata;
 	struct blk_mq_queue_map *qmap = &shost->tag_set.map[HCTX_TYPE_DEFAULT];
 
 	if (USER_CTRL_IRQ(vha->hw) || !vha->hw->mqiobase)
-		rc = blk_mq_map_queues(qmap);
+		blk_mq_map_queues(qmap);
 	else
-		rc = blk_mq_pci_map_queues(qmap, vha->hw->pdev, vha->irq_offset);
-	return rc;
+		blk_mq_pci_map_queues(qmap, vha->hw->pdev, vha->irq_offset);
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
index 4dbd29ab1dcc..677f632d6fd3 100644
--- a/drivers/scsi/scsi_lib.c
+++ b/drivers/scsi/scsi_lib.c
@@ -1849,13 +1849,13 @@ static int scsi_init_hctx(struct blk_mq_hw_ctx *hctx, void *data,
 	return 0;
 }
 
-static int scsi_map_queues(struct blk_mq_tag_set *set)
+static void scsi_map_queues(struct blk_mq_tag_set *set)
 {
 	struct Scsi_Host *shost = container_of(set, struct Scsi_Host, tag_set);
 
 	if (shost->hostt->map_queues)
 		return shost->hostt->map_queues(shost);
-	return blk_mq_map_queues(&set->map[HCTX_TYPE_DEFAULT]);
+	blk_mq_map_queues(&set->map[HCTX_TYPE_DEFAULT]);
 }
 
 void __scsi_init_queue(struct Scsi_Host *shost, struct request_queue *q)
diff --git a/drivers/scsi/smartpqi/smartpqi_init.c b/drivers/scsi/smartpqi/smartpqi_init.c
index 7a8c2c75acba..b971fbe3b3a1 100644
--- a/drivers/scsi/smartpqi/smartpqi_init.c
+++ b/drivers/scsi/smartpqi/smartpqi_init.c
@@ -6436,12 +6436,12 @@ static int pqi_slave_alloc(struct scsi_device *sdev)
 	return 0;
 }
 
-static int pqi_map_queues(struct Scsi_Host *shost)
+static void pqi_map_queues(struct Scsi_Host *shost)
 {
 	struct pqi_ctrl_info *ctrl_info = shost_to_hba(shost);
 
-	return blk_mq_pci_map_queues(&shost->tag_set.map[HCTX_TYPE_DEFAULT],
-					ctrl_info->pci_dev, 0);
+	blk_mq_pci_map_queues(&shost->tag_set.map[HCTX_TYPE_DEFAULT],
+			      ctrl_info->pci_dev, 0);
 }
 
 static inline bool pqi_is_tape_changer_device(struct pqi_scsi_dev *device)
diff --git a/drivers/scsi/virtio_scsi.c b/drivers/scsi/virtio_scsi.c
index 578c4b6d0f7d..077a8e24bd28 100644
--- a/drivers/scsi/virtio_scsi.c
+++ b/drivers/scsi/virtio_scsi.c
@@ -711,12 +711,12 @@ static int virtscsi_abort(struct scsi_cmnd *sc)
 	return virtscsi_tmf(vscsi, cmd);
 }
 
-static int virtscsi_map_queues(struct Scsi_Host *shost)
+static void virtscsi_map_queues(struct Scsi_Host *shost)
 {
 	struct virtio_scsi *vscsi = shost_priv(shost);
 	struct blk_mq_queue_map *qmap = &shost->tag_set.map[HCTX_TYPE_DEFAULT];
 
-	return blk_mq_virtio_map_queues(qmap, vscsi->vdev, 2);
+	blk_mq_virtio_map_queues(qmap, vscsi->vdev, 2);
 }
 
 static void virtscsi_commit_rqs(struct Scsi_Host *shost, u16 hwq)
diff --git a/drivers/ufs/core/ufshcd.c b/drivers/ufs/core/ufshcd.c
index 6bc679d22927..f27a812a4416 100644
--- a/drivers/ufs/core/ufshcd.c
+++ b/drivers/ufs/core/ufshcd.c
@@ -2701,9 +2701,9 @@ static inline bool is_device_wlun(struct scsi_device *sdev)
  * Associate the UFS controller queue with the default and poll HCTX types.
  * Initialize the mq_map[] arrays.
  */
-static int ufshcd_map_queues(struct Scsi_Host *shost)
+static void ufshcd_map_queues(struct Scsi_Host *shost)
 {
-	int i, ret;
+	int i;
 
 	for (i = 0; i < shost->nr_maps; i++) {
 		struct blk_mq_queue_map *map = &shost->tag_set.map[i];
@@ -2720,11 +2720,8 @@ static int ufshcd_map_queues(struct Scsi_Host *shost)
 			WARN_ON_ONCE(true);
 		}
 		map->queue_offset = 0;
-		ret = blk_mq_map_queues(map);
-		WARN_ON_ONCE(ret);
+		blk_mq_map_queues(map);
 	}
-
-	return 0;
 }
 
 static void ufshcd_init_lrb(struct ufs_hba *hba, struct ufshcd_lrb *lrb, int i)
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
diff --git a/include/linux/blk-mq-virtio.h b/include/linux/blk-mq-virtio.h
index 687ae287e1dc..13226e9b22dd 100644
--- a/include/linux/blk-mq-virtio.h
+++ b/include/linux/blk-mq-virtio.h
@@ -5,7 +5,7 @@
 struct blk_mq_queue_map;
 struct virtio_device;
 
-int blk_mq_virtio_map_queues(struct blk_mq_queue_map *qmap,
+void blk_mq_virtio_map_queues(struct blk_mq_queue_map *qmap,
 		struct virtio_device *vdev, int first_vec);
 
 #endif /* _LINUX_BLK_MQ_VIRTIO_H */
diff --git a/include/linux/blk-mq.h b/include/linux/blk-mq.h
index effee1dc715a..b1ae475e34a7 100644
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
@@ -881,7 +881,7 @@ void blk_mq_freeze_queue_wait(struct request_queue *q);
 int blk_mq_freeze_queue_wait_timeout(struct request_queue *q,
 				     unsigned long timeout);
 
-int blk_mq_map_queues(struct blk_mq_queue_map *qmap);
+void blk_mq_map_queues(struct blk_mq_queue_map *qmap);
 void blk_mq_update_nr_hw_queues(struct blk_mq_tag_set *set, int nr_hw_queues);
 
 void blk_mq_quiesce_queue_nowait(struct request_queue *q);
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
