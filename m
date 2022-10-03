Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C8540C433F5
	for <linux-block@archiver.kernel.org>; Mon,  3 Oct 2022 09:47:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229699AbiJCJrD (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 3 Oct 2022 05:47:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46048 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230380AbiJCJqi (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Mon, 3 Oct 2022 05:46:38 -0400
Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3E9D05B05C
        for <linux-block@vger.kernel.org>; Mon,  3 Oct 2022 02:43:51 -0700 (PDT)
Received: by mail-wm1-f42.google.com with SMTP id e18so6631100wmq.3
        for <linux-block@vger.kernel.org>; Mon, 03 Oct 2022 02:43:51 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date;
        bh=Rj3IeSjvL1BcaM1/d8KSXuYF1AHpxgmhfYutHEuRucI=;
        b=aCyJd3BhczMEMT7H5Whge4hkYZq7/mdLNE5o3afoFWRWIYBTO0gquCsoweLxJxPztq
         y813WUF3I3zistHzaR2KP6kgFF4o6lTUvYjiUUdMQ1RN1QOtTemKke0cPUhL4tWollct
         uK7QVFcsFUJ0WUqt5HphWST0Ry46/O3GBoBl4Gxtvm/7J5V9xssgtW2Z+cn4aXPg+qf3
         WqQpVp47bqrKZ7XaLWkFGES1qb5kD81dA1roWyQiGynP1qnAFOtOgBldLRvAV/0h1Sw4
         ykprvHSdUksOCKU9ef3ypAc586PiwYqaWxWFsacB423S3MMU/WjMcLC7p29amHGG9u9a
         Ss0g==
X-Gm-Message-State: ACrzQf2hqN1CaB92bSFmPjAzRVgIrtpdvATT0o32vlYK5xuvLidPOoUc
        klbR+MLjH6yVecL2E610GoI=
X-Google-Smtp-Source: AMsMyM57jh/ysz9T9G/R3I/aX6E4Z+7FJQCKlQlHbC+DUcMfXe4ipz6+1otTmnL136pKIn6G00E22A==
X-Received: by 2002:a05:600c:4fd1:b0:3b4:c00d:230a with SMTP id o17-20020a05600c4fd100b003b4c00d230amr6112464wmq.62.1664790229816;
        Mon, 03 Oct 2022 02:43:49 -0700 (PDT)
Received: from localhost.localdomain (bzq-219-42-90.isdn.bezeqint.net. [62.219.42.90])
        by smtp.gmail.com with ESMTPSA id bk14-20020a0560001d8e00b00228d67db06esm3545586wrb.21.2022.10.03.02.43.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Oct 2022 02:43:49 -0700 (PDT)
From:   Sagi Grimberg <sagi@grimberg.me>
To:     linux-nvme@lists.infradead.org
Cc:     Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>,
        Keith Busch <kbusch@kernel.org>,
        Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>,
        Hannes Reinecke <hare@suse.de>, linux-block@vger.kernel.org
Subject: [PATCH v2 2/2] nvme: support io stats on the mpath device
Date:   Mon,  3 Oct 2022 12:43:44 +0300
Message-Id: <20221003094344.242593-3-sagi@grimberg.me>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20221003094344.242593-1-sagi@grimberg.me>
References: <20221003094344.242593-1-sagi@grimberg.me>
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
to the approach taken in nvme_trace_bio_complete).

When the IO starts, we account the request for multipath IO stats using
REQ_NVME_MPATH_IO_STATS nvme_request flag to avoid queue io stats disable
in the middle of the request.

Signed-off-by: Sagi Grimberg <sagi@grimberg.me>
---
 drivers/nvme/host/core.c      |  4 ++++
 drivers/nvme/host/multipath.c | 25 +++++++++++++++++++++++++
 drivers/nvme/host/nvme.h      | 12 ++++++++++++
 3 files changed, 41 insertions(+)

diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index 64fd772de817..d5a54ddf73f2 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -384,6 +384,8 @@ static inline void nvme_end_req(struct request *req)
 		nvme_log_error(req);
 	nvme_end_req_zoned(req);
 	nvme_trace_bio_complete(req);
+	if (req->cmd_flags & REQ_NVME_MPATH)
+		nvme_mpath_end_request(req);
 	blk_mq_end_request(req, status);
 }
 
@@ -421,6 +423,8 @@ EXPORT_SYMBOL_GPL(nvme_complete_rq);
 
 void nvme_start_request(struct request *rq)
 {
+	if (rq->cmd_flags & REQ_NVME_MPATH)
+		nvme_mpath_start_request(rq);
 	blk_mq_start_request(rq);
 }
 EXPORT_SYMBOL_GPL(nvme_start_request);
diff --git a/drivers/nvme/host/multipath.c b/drivers/nvme/host/multipath.c
index b9cf17cbbbd5..5ef43f54aab6 100644
--- a/drivers/nvme/host/multipath.c
+++ b/drivers/nvme/host/multipath.c
@@ -114,6 +114,30 @@ void nvme_failover_req(struct request *req)
 	kblockd_schedule_work(&ns->head->requeue_work);
 }
 
+void nvme_mpath_start_request(struct request *rq)
+{
+	struct nvme_ns *ns = rq->q->queuedata;
+	struct gendisk *disk = ns->head->disk;
+
+	if (!blk_queue_io_stat(disk->queue) || blk_rq_is_passthrough(rq))
+		return;
+
+	nvme_req(rq)->flags |= NVME_MPATH_IO_STATS;
+	nvme_req(rq)->start_time = bdev_start_io_acct(disk->part0,
+					blk_rq_bytes(rq) >> SECTOR_SHIFT,
+					req_op(rq), jiffies);
+}
+
+void nvme_mpath_end_request(struct request *rq)
+{
+	struct nvme_ns *ns = rq->q->queuedata;
+
+	if (!(nvme_req(rq)->flags & NVME_MPATH_IO_STATS))
+		return;
+	bdev_end_io_acct(ns->head->disk->part0, req_op(rq),
+		nvme_req(rq)->start_time);
+}
+
 void nvme_kick_requeue_lists(struct nvme_ctrl *ctrl)
 {
 	struct nvme_ns *ns;
@@ -502,6 +526,7 @@ int nvme_mpath_alloc_disk(struct nvme_ctrl *ctrl, struct nvme_ns_head *head)
 
 	blk_queue_flag_set(QUEUE_FLAG_NONROT, head->disk->queue);
 	blk_queue_flag_set(QUEUE_FLAG_NOWAIT, head->disk->queue);
+	blk_queue_flag_set(QUEUE_FLAG_IO_STAT, head->disk->queue);
 	/*
 	 * This assumes all controllers that refer to a namespace either
 	 * support poll queues or not.  That is not a strict guarantee,
diff --git a/drivers/nvme/host/nvme.h b/drivers/nvme/host/nvme.h
index c4d1a4e9b961..c4edc91b1358 100644
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
 
@@ -173,6 +176,7 @@ struct nvme_request {
 enum {
 	NVME_REQ_CANCELLED		= (1 << 0),
 	NVME_REQ_USERCMD		= (1 << 1),
+	NVME_MPATH_IO_STATS		= (1 << 2),
 };
 
 static inline struct nvme_request *nvme_req(struct request *req)
@@ -862,6 +866,8 @@ bool nvme_mpath_clear_current_path(struct nvme_ns *ns);
 void nvme_mpath_revalidate_paths(struct nvme_ns *ns);
 void nvme_mpath_clear_ctrl_paths(struct nvme_ctrl *ctrl);
 void nvme_mpath_shutdown_disk(struct nvme_ns_head *head);
+void nvme_mpath_start_request(struct request *rq);
+void nvme_mpath_end_request(struct request *rq);
 
 static inline void nvme_trace_bio_complete(struct request *req)
 {
@@ -947,6 +953,12 @@ static inline void nvme_mpath_start_freeze(struct nvme_subsystem *subsys)
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
-- 
2.34.1

