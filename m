Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 92FBBC6FA82
	for <linux-block@archiver.kernel.org>; Wed, 28 Sep 2022 19:55:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233775AbiI1TzW (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 28 Sep 2022 15:55:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40348 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233996AbiI1TzT (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 28 Sep 2022 15:55:19 -0400
Received: from mail-ed1-f47.google.com (mail-ed1-f47.google.com [209.85.208.47])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1B8C33AB2B
        for <linux-block@vger.kernel.org>; Wed, 28 Sep 2022 12:55:16 -0700 (PDT)
Received: by mail-ed1-f47.google.com with SMTP id x92so5507113ede.9
        for <linux-block@vger.kernel.org>; Wed, 28 Sep 2022 12:55:16 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date;
        bh=9qxjLuGoYfBY9VR8HKNz32kEKmBsh/5GPU2w8/C7NLg=;
        b=ePO24Azbvo5hl7wthEZ0EfuE2ctca8U+glkOWcZgj8n+8T60idY/xpMUqgLFUfTgZu
         YVjs2f55uS7YBi+WO215meWzRR4wY9/ml/ZpGy8dpm1nTaIsx/7YdBriN7mQ+oEGHRYE
         xs7ApReO1o52paqijLgxHFDXXj+0KAzW0QI85PXdb1p5IHU/+nR0CQcPTBE14/9GgIFv
         SqP4+WYswjw0qKTbFW3hzpO9gL0fz4nboY1Ffzfj4mnsdvB+tfWaF3dbEyE5gT4ebWyi
         tqjGSyrTv+/L5tyV45VBI1oC2OHFCMaJZYxTgAnVX9VjaXbm/sldwoblUKmxM8V9mnqF
         Ipcg==
X-Gm-Message-State: ACrzQf33I5WzSHblutUcwOEk0e3HNRaT2U5limdzvAVAdtETUTDZ0QoF
        uu4WPWk5GaV7xWXzSBmxCqrhJEIuzS8=
X-Google-Smtp-Source: AMsMyM6JT1m0ccMQzjE7GKmUitewkXolxJZjt89cuJSfMUyrqq5EfBC4cqZuX2vK5YvRsfPJqbJeIA==
X-Received: by 2002:a05:6402:2549:b0:452:8292:b610 with SMTP id l9-20020a056402254900b004528292b610mr34895294edb.199.1664394914460;
        Wed, 28 Sep 2022 12:55:14 -0700 (PDT)
Received: from localhost.localdomain (46-116-236-159.bb.netvision.net.il. [46.116.236.159])
        by smtp.gmail.com with ESMTPSA id 16-20020a170906329000b007389c5a45f0sm2845747ejw.148.2022.09.28.12.55.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Sep 2022 12:55:13 -0700 (PDT)
From:   Sagi Grimberg <sagi@grimberg.me>
To:     linux-nvme@lists.infradead.org
Cc:     Christoph Hellwig <hch@lst.de>, Keith Busch <kbusch@kernel.org>,
        Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>,
        linux-block@vger.kernel.org, Jens Axboe <axboe@kernel.dk>,
        Hannes Reinecke <hare@suse.de>
Subject: [PATCH rfc] nvme: support io stats on the mpath device
Date:   Wed, 28 Sep 2022 22:55:10 +0300
Message-Id: <20220928195510.165062-2-sagi@grimberg.me>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220928195510.165062-1-sagi@grimberg.me>
References: <20220928195510.165062-1-sagi@grimberg.me>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Our mpath stack device is just a shim that selects a bottom namespace
and submits the bio to it without any fancy splitting. This also means
that we don't clone the bio or have any context to the bio beyond
submission. However it really sucks that we don't see the mpath device
io stats.

Given that the mpath device can't do that without adding some context
to it, we let the bottom device do it on its behalf (somewhat similar
to the approach taken in nvme_trace_bio_complete);

Signed-off-by: Sagi Grimberg <sagi@grimberg.me>
---
 drivers/nvme/host/apple.c     |  2 +-
 drivers/nvme/host/core.c      | 10 ++++++++++
 drivers/nvme/host/fc.c        |  2 +-
 drivers/nvme/host/multipath.c | 18 ++++++++++++++++++
 drivers/nvme/host/nvme.h      | 12 ++++++++++++
 drivers/nvme/host/pci.c       |  2 +-
 drivers/nvme/host/rdma.c      |  2 +-
 drivers/nvme/host/tcp.c       |  2 +-
 drivers/nvme/target/loop.c    |  2 +-
 9 files changed, 46 insertions(+), 6 deletions(-)

diff --git a/drivers/nvme/host/apple.c b/drivers/nvme/host/apple.c
index 5fc5ea196b40..6df4b8a5d8ab 100644
--- a/drivers/nvme/host/apple.c
+++ b/drivers/nvme/host/apple.c
@@ -763,7 +763,7 @@ static blk_status_t apple_nvme_queue_rq(struct blk_mq_hw_ctx *hctx,
 			goto out_free_cmd;
 	}
 
-	blk_mq_start_request(req);
+	nvme_start_request(req);
 	apple_nvme_submit_cmd(q, cmnd);
 	return BLK_STS_OK;
 
diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index 9bacfd014e3d..f42e6e40d84b 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -385,6 +385,8 @@ static inline void nvme_end_req(struct request *req)
 	nvme_end_req_zoned(req);
 	nvme_trace_bio_complete(req);
 	blk_mq_end_request(req, status);
+	if (req->cmd_flags & REQ_NVME_MPATH)
+		nvme_mpath_end_request(req);
 }
 
 void nvme_complete_rq(struct request *req)
@@ -419,6 +421,14 @@ void nvme_complete_rq(struct request *req)
 }
 EXPORT_SYMBOL_GPL(nvme_complete_rq);
 
+void nvme_start_request(struct request *rq)
+{
+	if (rq->cmd_flags & REQ_NVME_MPATH)
+		nvme_mpath_start_request(rq);
+	blk_mq_start_request(rq);
+}
+EXPORT_SYMBOL_GPL(nvme_start_request);
+
 void nvme_complete_batch_req(struct request *req)
 {
 	trace_nvme_complete_rq(req);
diff --git a/drivers/nvme/host/fc.c b/drivers/nvme/host/fc.c
index 127abaf9ba5d..2cdcc7f5d0a9 100644
--- a/drivers/nvme/host/fc.c
+++ b/drivers/nvme/host/fc.c
@@ -2744,7 +2744,7 @@ nvme_fc_start_fcp_op(struct nvme_fc_ctrl *ctrl, struct nvme_fc_queue *queue,
 	atomic_set(&op->state, FCPOP_STATE_ACTIVE);
 
 	if (!(op->flags & FCOP_FLAGS_AEN))
-		blk_mq_start_request(op->rq);
+		nvme_start_request(op->rq);
 
 	cmdiu->csn = cpu_to_be32(atomic_inc_return(&queue->csn));
 	ret = ctrl->lport->ops->fcp_io(&ctrl->lport->localport,
diff --git a/drivers/nvme/host/multipath.c b/drivers/nvme/host/multipath.c
index 6ef497c75a16..9d2ff9ed8c6c 100644
--- a/drivers/nvme/host/multipath.c
+++ b/drivers/nvme/host/multipath.c
@@ -114,6 +114,23 @@ void nvme_failover_req(struct request *req)
 	kblockd_schedule_work(&ns->head->requeue_work);
 }
 
+void nvme_mpath_start_request(struct request *rq)
+{
+	struct nvme_ns *ns = rq->q->queuedata;
+
+	nvme_req(rq)->start_time = bdev_start_io_acct(ns->head->disk->part0,
+					blk_rq_bytes(rq) >> SECTOR_SHIFT,
+					req_op(rq), jiffies);
+}
+
+void nvme_mpath_end_request(struct request *rq)
+{
+	struct nvme_ns *ns = rq->q->queuedata;
+
+	bdev_end_io_acct(ns->head->disk->part0,
+		req_op(rq), nvme_req(rq)->start_time);
+}
+
 void nvme_kick_requeue_lists(struct nvme_ctrl *ctrl)
 {
 	struct nvme_ns *ns;
@@ -501,6 +518,7 @@ int nvme_mpath_alloc_disk(struct nvme_ctrl *ctrl, struct nvme_ns_head *head)
 
 	blk_queue_flag_set(QUEUE_FLAG_NONROT, head->disk->queue);
 	blk_queue_flag_set(QUEUE_FLAG_NOWAIT, head->disk->queue);
+	blk_queue_flag_set(QUEUE_FLAG_IO_STAT, head->disk->queue);
 	/*
 	 * This assumes all controllers that refer to a namespace either
 	 * support poll queues or not.  That is not a strict guarantee,
diff --git a/drivers/nvme/host/nvme.h b/drivers/nvme/host/nvme.h
index 2d5d44a73f26..08f94c404cd8 100644
--- a/drivers/nvme/host/nvme.h
+++ b/drivers/nvme/host/nvme.h
@@ -162,6 +162,9 @@ struct nvme_request {
 	u8			retries;
 	u8			flags;
 	u16			status;
+#ifdef CONFIG_NVME_MULTIPATH
+	unsigned long		start_time;
+#endif
 	struct nvme_ctrl	*ctrl;
 };
 
@@ -753,6 +756,7 @@ static inline enum req_op nvme_req_op(struct nvme_command *cmd)
 }
 
 #define NVME_QID_ANY -1
+void nvme_start_request(struct request *rq);
 void nvme_init_request(struct request *req, struct nvme_command *cmd);
 void nvme_cleanup_cmd(struct request *req);
 blk_status_t nvme_setup_cmd(struct nvme_ns *ns, struct request *req);
@@ -861,6 +865,8 @@ bool nvme_mpath_clear_current_path(struct nvme_ns *ns);
 void nvme_mpath_revalidate_paths(struct nvme_ns *ns);
 void nvme_mpath_clear_ctrl_paths(struct nvme_ctrl *ctrl);
 void nvme_mpath_shutdown_disk(struct nvme_ns_head *head);
+void nvme_mpath_start_request(struct request *rq);
+void nvme_mpath_end_request(struct request *rq);
 
 static inline void nvme_trace_bio_complete(struct request *req)
 {
@@ -946,6 +952,12 @@ static inline void nvme_mpath_start_freeze(struct nvme_subsystem *subsys)
 static inline void nvme_mpath_default_iopolicy(struct nvme_subsystem *subsys)
 {
 }
+static inline void nvme_mpath_start_request(struct request *rq)
+{
+}
+static inline void nvme_mpath_end_request(struct request *rq)
+{
+}
 #endif /* CONFIG_NVME_MULTIPATH */
 
 int nvme_revalidate_zones(struct nvme_ns *ns);
diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c
index 3bdb97205699..e898b9e4e6e0 100644
--- a/drivers/nvme/host/pci.c
+++ b/drivers/nvme/host/pci.c
@@ -929,7 +929,7 @@ static blk_status_t nvme_prep_rq(struct nvme_dev *dev, struct request *req)
 			goto out_unmap_data;
 	}
 
-	blk_mq_start_request(req);
+	nvme_start_request(req);
 	return BLK_STS_OK;
 out_unmap_data:
 	nvme_unmap_data(dev, req);
diff --git a/drivers/nvme/host/rdma.c b/drivers/nvme/host/rdma.c
index 8e52d2362fa1..ab9d5a17704b 100644
--- a/drivers/nvme/host/rdma.c
+++ b/drivers/nvme/host/rdma.c
@@ -2089,7 +2089,7 @@ static blk_status_t nvme_rdma_queue_rq(struct blk_mq_hw_ctx *hctx,
 	if (ret)
 		goto unmap_qe;
 
-	blk_mq_start_request(rq);
+	nvme_start_request(rq);
 
 	if (IS_ENABLED(CONFIG_BLK_DEV_INTEGRITY) &&
 	    queue->pi_support &&
diff --git a/drivers/nvme/host/tcp.c b/drivers/nvme/host/tcp.c
index 2524b5304bfb..a1df405de7f1 100644
--- a/drivers/nvme/host/tcp.c
+++ b/drivers/nvme/host/tcp.c
@@ -2461,7 +2461,7 @@ static blk_status_t nvme_tcp_queue_rq(struct blk_mq_hw_ctx *hctx,
 	if (unlikely(ret))
 		return ret;
 
-	blk_mq_start_request(rq);
+	nvme_start_request(rq);
 
 	nvme_tcp_queue_request(req, true, bd->last);
 
diff --git a/drivers/nvme/target/loop.c b/drivers/nvme/target/loop.c
index 9750a7fca268..c327615decc2 100644
--- a/drivers/nvme/target/loop.c
+++ b/drivers/nvme/target/loop.c
@@ -145,7 +145,7 @@ static blk_status_t nvme_loop_queue_rq(struct blk_mq_hw_ctx *hctx,
 	if (ret)
 		return ret;
 
-	blk_mq_start_request(req);
+	nvme_start_request(req);
 	iod->cmd.common.flags |= NVME_CMD_SGL_METABUF;
 	iod->req.port = queue->ctrl->port;
 	if (!nvmet_req_init(&iod->req, &queue->nvme_cq,
-- 
2.34.1

