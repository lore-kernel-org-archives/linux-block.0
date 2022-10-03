Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DB57AC433F5
	for <linux-block@archiver.kernel.org>; Mon,  3 Oct 2022 09:47:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230393AbiJCJrA (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 3 Oct 2022 05:47:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47834 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229669AbiJCJqe (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Mon, 3 Oct 2022 05:46:34 -0400
Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F07715B04E
        for <linux-block@vger.kernel.org>; Mon,  3 Oct 2022 02:43:49 -0700 (PDT)
Received: by mail-wm1-f43.google.com with SMTP id i203-20020a1c3bd4000000b003b3df9a5ecbso8706092wma.1
        for <linux-block@vger.kernel.org>; Mon, 03 Oct 2022 02:43:49 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date;
        bh=dY6T2rPEWG/mT84R+nSgsINRdss5Cg0549TjuWhIX0g=;
        b=Y53ONSgfahux952eXSFkaBJ3+dHHJChfV1sWKM8ELme/jWBCJtx+NV6nOwsVGVu2Rn
         kgCikSMLMyeaaqDIYDgYeNq3oLw6lfsXCQimAz8g4U8VvpZDuRJMDEHxKIGcdMoZbDe0
         Zg9GkzmesfU/Ha09RDHp8h4vJ4JpPGhXfu9Pk1Rnv0swVhmmOvxVgCx389guXcSQ2w8q
         z7DGTjj/5aV6w0MlkRfZxgtOOOZCryJkeCz36BS2ajhdAWFa2TExhZzYbF3lw8H73TrB
         1hdpiE9n/zFckd51SIZKn0Sq6DUcsMfPsjrA4rRrJWnxAOsl5cmtLH+JIPLeNDjizBzS
         P2+A==
X-Gm-Message-State: ACrzQf3L9mwU8obn17hFvLjJeH8iTjHq7R6A2K9ggAFc2EBHdYsopSEv
        uPE/tNhl3w6J38LFIYoj1zk=
X-Google-Smtp-Source: AMsMyM749L3GX1JH04KPM/Ty74nswQRwfTox0LUw0kL4Dl/HNqyvnHb4FiV9WhT3lHA+ldyxgGMWlQ==
X-Received: by 2002:a05:600c:1ca8:b0:3b4:a5d1:2033 with SMTP id k40-20020a05600c1ca800b003b4a5d12033mr6148112wms.23.1664790228561;
        Mon, 03 Oct 2022 02:43:48 -0700 (PDT)
Received: from localhost.localdomain (bzq-219-42-90.isdn.bezeqint.net. [62.219.42.90])
        by smtp.gmail.com with ESMTPSA id bk14-20020a0560001d8e00b00228d67db06esm3545586wrb.21.2022.10.03.02.43.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Oct 2022 02:43:47 -0700 (PDT)
From:   Sagi Grimberg <sagi@grimberg.me>
To:     linux-nvme@lists.infradead.org
Cc:     Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>,
        Keith Busch <kbusch@kernel.org>,
        Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>,
        Hannes Reinecke <hare@suse.de>, linux-block@vger.kernel.org
Subject: [PATCH v2 1/2] nvme: introduce nvme_start_request
Date:   Mon,  3 Oct 2022 12:43:43 +0300
Message-Id: <20221003094344.242593-2-sagi@grimberg.me>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20221003094344.242593-1-sagi@grimberg.me>
References: <20221003094344.242593-1-sagi@grimberg.me>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

In preparation for nvme-multipath IO stats accounting, we want the
accounting to happen in a centralized place. The request completion
is already centralized, but we need a common helper to request I/O
start.

Signed-off-by: Sagi Grimberg <sagi@grimberg.me>
---
 drivers/nvme/host/apple.c  | 2 +-
 drivers/nvme/host/core.c   | 6 ++++++
 drivers/nvme/host/fc.c     | 2 +-
 drivers/nvme/host/nvme.h   | 1 +
 drivers/nvme/host/pci.c    | 2 +-
 drivers/nvme/host/rdma.c   | 2 +-
 drivers/nvme/host/tcp.c    | 2 +-
 drivers/nvme/target/loop.c | 2 +-
 8 files changed, 13 insertions(+), 6 deletions(-)

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
index 9bacfd014e3d..64fd772de817 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -419,6 +419,12 @@ void nvme_complete_rq(struct request *req)
 }
 EXPORT_SYMBOL_GPL(nvme_complete_rq);
 
+void nvme_start_request(struct request *rq)
+{
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
diff --git a/drivers/nvme/host/nvme.h b/drivers/nvme/host/nvme.h
index 2d5d44a73f26..c4d1a4e9b961 100644
--- a/drivers/nvme/host/nvme.h
+++ b/drivers/nvme/host/nvme.h
@@ -753,6 +753,7 @@ static inline enum req_op nvme_req_op(struct nvme_command *cmd)
 }
 
 #define NVME_QID_ANY -1
+void nvme_start_request(struct request *rq);
 void nvme_init_request(struct request *req, struct nvme_command *cmd);
 void nvme_cleanup_cmd(struct request *req);
 blk_status_t nvme_setup_cmd(struct nvme_ns *ns, struct request *req);
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

