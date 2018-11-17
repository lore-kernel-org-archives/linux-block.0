Return-Path: <SRS0=MdGt=N4=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.5 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0833BC43441
	for <linux-block@archiver.kernel.org>; Sat, 17 Nov 2018 21:44:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BE96C2080D
	for <linux-block@archiver.kernel.org>; Sat, 17 Nov 2018 21:44:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="uS8p11PI"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BE96C2080D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-block-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726366AbeKRICO (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Sun, 18 Nov 2018 03:02:14 -0500
Received: from mail-pg1-f194.google.com ([209.85.215.194]:34270 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725743AbeKRICN (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Sun, 18 Nov 2018 03:02:13 -0500
Received: by mail-pg1-f194.google.com with SMTP id 17so11857902pgg.1
        for <linux-block@vger.kernel.org>; Sat, 17 Nov 2018 13:44:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=9NsRKs6YTwkhIZOzQWW1FUqIkBWvxAV2VRe60tl9dWk=;
        b=uS8p11PIgTsBZ2OVoHfntotuImPHHZev20fFS6DyS4ZdN4ObrkpTji4rj8yuLKz4dk
         lW+oXBxTJa2K6xB6ACw3rfyWRxrSXoyz9eL0ZLCrlrgkZuf5slEBV+BEkeTz8EoF3kuC
         8oYPvzoYFrMIYNsczI3x50LtdsSgwD/eqAQOe7rj6g76Gs+0cLHY8vkyb0iWJrXb8mNq
         6kjjo22E+c9/qqBDqMbRSL1lFQh5puK96/2fT0hXCLfSwt37fSBS1cGSPodKowuMwwaU
         11Lh3LcYOw/cuMCf2FpUoNHmMgxBgwrK8RHvswzS2ZHIAG8BDqPipz3ixMg5f6OaOMk1
         2czg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=9NsRKs6YTwkhIZOzQWW1FUqIkBWvxAV2VRe60tl9dWk=;
        b=Z+zQ90vIJvXiA4Ci5gy/yyQEGCLYR4YYFw7kBvEJ1wpwtZlwn4VDTdPDXKrg/c3W+j
         YjHP/ZKq3Sd6VEDkprtjcqdd6xbmvD1pGt8Up6k1niXzIBaBWrEp+HGMCUOaoTJIN3u/
         maIAuteReD+zBFqvrcgh8PlDEe60l+I3UhJrm/vdlwBcUXVU3tHXAmp/6kiqcLJxXNZz
         CF9YUeOWV3aHM4vR43DOvP40oItVVz4QkcH+fO+Wd0EBjryL18gXK3jfLWmUwtDXJ3Mj
         iiUtq3iRzl5uwUwh0MKJ2S+I7K4GcayqlXQbfw7K+OXN/yCP+NEcPpcMUxwKRjJ9wRu+
         HUPA==
X-Gm-Message-State: AGRZ1gLfd/ZomxiI2n3HMybq2EjJbGki+ish4nluhaHDjo2tpl+NkJTT
        BSt6g6aGidNNdXdjai52ZUoNHuWISQE=
X-Google-Smtp-Source: AJdET5frkBkXwysmnMi2dsF1C4K2bvFa3P6ONawyFXRbnF2DbCPdnJKfLENYbS1MbxntqmsvF8sZTQ==
X-Received: by 2002:a63:c141:: with SMTP id p1mr14802826pgi.424.1542491049457;
        Sat, 17 Nov 2018 13:44:09 -0800 (PST)
Received: from x1.localdomain (66.29.188.166.static.utbb.net. [66.29.188.166])
        by smtp.gmail.com with ESMTPSA id o84sm29006501pfi.172.2018.11.17.13.44.07
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 17 Nov 2018 13:44:08 -0800 (PST)
From:   Jens Axboe <axboe@kernel.dk>
To:     linux-block@vger.kernel.org, linux-nvme@lists.infradead.org
Cc:     Jens Axboe <axboe@kernel.dk>
Subject: [PATCH 5/7] blk-mq: remove 'tag' parameter from mq_ops->poll()
Date:   Sat, 17 Nov 2018 14:43:52 -0700
Message-Id: <20181117214354.822-6-axboe@kernel.dk>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20181117214354.822-1-axboe@kernel.dk>
References: <20181117214354.822-1-axboe@kernel.dk>
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

We always pass in -1 now and none of the callers use the tag value,
remove the parameter.

Signed-off-by: Jens Axboe <axboe@kernel.dk>
---
 block/blk-mq.c           | 2 +-
 drivers/nvme/host/pci.c  | 8 ++++----
 drivers/nvme/host/rdma.c | 2 +-
 include/linux/blk-mq.h   | 2 +-
 4 files changed, 7 insertions(+), 7 deletions(-)

diff --git a/block/blk-mq.c b/block/blk-mq.c
index 3ca00d712158..10a14baa04ff 100644
--- a/block/blk-mq.c
+++ b/block/blk-mq.c
@@ -3341,7 +3341,7 @@ static int __blk_mq_poll(struct blk_mq_hw_ctx *hctx)
 
 		hctx->poll_invoked++;
 
-		ret = q->mq_ops->poll(hctx, -1U);
+		ret = q->mq_ops->poll(hctx);
 		if (ret > 0) {
 			hctx->poll_success++;
 			__set_current_state(TASK_RUNNING);
diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c
index 1742c8ab8196..1280cc327096 100644
--- a/drivers/nvme/host/pci.c
+++ b/drivers/nvme/host/pci.c
@@ -1075,14 +1075,14 @@ static int __nvme_poll(struct nvme_queue *nvmeq, unsigned int tag)
 	return found;
 }
 
-static int nvme_poll(struct blk_mq_hw_ctx *hctx, unsigned int tag)
+static int nvme_poll(struct blk_mq_hw_ctx *hctx)
 {
 	struct nvme_queue *nvmeq = hctx->driver_data;
 
-	return __nvme_poll(nvmeq, tag);
+	return __nvme_poll(nvmeq, -1);
 }
 
-static int nvme_poll_noirq(struct blk_mq_hw_ctx *hctx, unsigned int tag)
+static int nvme_poll_noirq(struct blk_mq_hw_ctx *hctx)
 {
 	struct nvme_queue *nvmeq = hctx->driver_data;
 	u16 start, end;
@@ -1092,7 +1092,7 @@ static int nvme_poll_noirq(struct blk_mq_hw_ctx *hctx, unsigned int tag)
 		return 0;
 
 	spin_lock(&nvmeq->cq_lock);
-	found = nvme_process_cq(nvmeq, &start, &end, tag);
+	found = nvme_process_cq(nvmeq, &start, &end, -1);
 	spin_unlock(&nvmeq->cq_lock);
 
 	nvme_complete_cqes(nvmeq, start, end);
diff --git a/drivers/nvme/host/rdma.c b/drivers/nvme/host/rdma.c
index 53e44efc6d32..4b2ba563acdb 100644
--- a/drivers/nvme/host/rdma.c
+++ b/drivers/nvme/host/rdma.c
@@ -1741,7 +1741,7 @@ static blk_status_t nvme_rdma_queue_rq(struct blk_mq_hw_ctx *hctx,
 	return BLK_STS_IOERR;
 }
 
-static int nvme_rdma_poll(struct blk_mq_hw_ctx *hctx, unsigned int tag)
+static int nvme_rdma_poll(struct blk_mq_hw_ctx *hctx)
 {
 	struct nvme_rdma_queue *queue = hctx->driver_data;
 	struct ib_cq *cq = queue->ib_cq;
diff --git a/include/linux/blk-mq.h b/include/linux/blk-mq.h
index 929e8abc5535..ca0520ca6437 100644
--- a/include/linux/blk-mq.h
+++ b/include/linux/blk-mq.h
@@ -132,7 +132,7 @@ typedef void (exit_request_fn)(struct blk_mq_tag_set *set, struct request *,
 typedef bool (busy_iter_fn)(struct blk_mq_hw_ctx *, struct request *, void *,
 		bool);
 typedef bool (busy_tag_iter_fn)(struct request *, void *, bool);
-typedef int (poll_fn)(struct blk_mq_hw_ctx *, unsigned int);
+typedef int (poll_fn)(struct blk_mq_hw_ctx *);
 typedef int (map_queues_fn)(struct blk_mq_tag_set *set);
 typedef bool (busy_fn)(struct request_queue *);
 typedef void (complete_fn)(struct request *);
-- 
2.17.1

