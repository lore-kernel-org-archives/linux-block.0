Return-Path: <SRS0=Lvn3=OC=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.5 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A7EEEC43441
	for <linux-block@archiver.kernel.org>; Fri, 23 Nov 2018 18:34:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 72BBE20824
	for <linux-block@archiver.kernel.org>; Fri, 23 Nov 2018 18:34:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="qSXeMJPF"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 72BBE20824
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-block-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726368AbeKXFTo (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Sat, 24 Nov 2018 00:19:44 -0500
Received: from mail-pg1-f194.google.com ([209.85.215.194]:42650 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389262AbeKXFTn (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Sat, 24 Nov 2018 00:19:43 -0500
Received: by mail-pg1-f194.google.com with SMTP id d72so3365946pga.9
        for <linux-block@vger.kernel.org>; Fri, 23 Nov 2018 10:34:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=qbf7THVfKfKXHautth08FWEWMofN2ha8Jnuk3gPYbfc=;
        b=qSXeMJPFL9gsW4gIHe46rwtOsvgaVomkTl1t3ylO5XG2fgYqWsgBZ1839dQBlyJFNK
         1GrXwQ75FEPaO8STano21k2yPxjvr1Ksl/CRRtPPD/soDRwvlrJx4cx7ijZaDDaqFUaf
         E9Qh3YMAwTPqe8hHpzqB8bw8FMiMdgTWXUeSAccUX+jN/29J/75gCe8gM1Knt7/LHFt0
         0KOEon/6/KiNjN2pGTY+eetoSQ0T2rdgdLgN9iB0v9XcMGSLjCmVzA0ZRm701Y1jK1Y/
         TMyEwgW7DWj8mLX5NJMklsU0i84YPa1XIJzGzpbySZ7icMmY1hSjCuomF4CNohScQ3ND
         UNmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=qbf7THVfKfKXHautth08FWEWMofN2ha8Jnuk3gPYbfc=;
        b=lyS5w/RKq6hIUNOgd2qGfRSbkzK7HUZmHAnpvgxBX/7bAxFKKxhKHVnSHiC1F4x6Sz
         skKrdlfv0K0qmprLOOI9a+rLMtKRbnVPeSxbipnCzuJZSF94uwrjpnQP2I024JAqECU/
         xQV0Jc98cVwh/umLw4aE+aeNl/U2dRRYAQGZcUJW5XFW4JKLM1oCGgrpRMVEfeHL7G0k
         Qx2Et7vUC2WhLL8VbzgWsjSHIo7ocJbSCttX+zs3iHbrpUTh7cGhWH2b8bPQTnr/6oV2
         NBzwWiSUcWb6EXcNCJHNz1kK+AxZIqEWTMgWJ3uunSxOg3yt4FwjNVP89Sy1nbP+lnc0
         fdPw==
X-Gm-Message-State: AGRZ1gKO+oAqsJayAExPRirPuYrvzv6YMUFERDbJY5eiz2VVEpDLbPPg
        ZYdCTDPGbjdAE+DB3gZ5UY5aTsC4FFE=
X-Google-Smtp-Source: AJdET5egHqJvGclTe+5PKMxVSrabW/6ejRfiBWLPsL59bifod8/6U9ln4tpw3zD/fUw1JMH/HOq7+g==
X-Received: by 2002:a62:5dd1:: with SMTP id n78mr16805683pfj.58.1542998058730;
        Fri, 23 Nov 2018 10:34:18 -0800 (PST)
Received: from x1.thefacebook.com (66.29.188.166.static.utbb.net. [66.29.188.166])
        by smtp.gmail.com with ESMTPSA id s37sm52294260pgm.19.2018.11.23.10.34.17
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 23 Nov 2018 10:34:17 -0800 (PST)
From:   Jens Axboe <axboe@kernel.dk>
To:     linux-block@vger.kernel.org
Cc:     Jens Axboe <axboe@kernel.dk>
Subject: [PATCH 2/6] blk-mq: remove 'tag' parameter from mq_ops->poll()
Date:   Fri, 23 Nov 2018 11:34:07 -0700
Message-Id: <20181123183411.8708-3-axboe@kernel.dk>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20181123183411.8708-1-axboe@kernel.dk>
References: <20181123183411.8708-1-axboe@kernel.dk>
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

We always pass in -1 now and none of the callers use the tag value,
remove the parameter.

Reviewed-by: Christoph Hellwig <hch@lst.de>
Signed-off-by: Jens Axboe <axboe@kernel.dk>
---
 block/blk-mq.c           | 2 +-
 drivers/nvme/host/pci.c  | 8 ++++----
 drivers/nvme/host/rdma.c | 2 +-
 include/linux/blk-mq.h   | 2 +-
 4 files changed, 7 insertions(+), 7 deletions(-)

diff --git a/block/blk-mq.c b/block/blk-mq.c
index ec6c79578332..b66cca3ce1e5 100644
--- a/block/blk-mq.c
+++ b/block/blk-mq.c
@@ -3380,7 +3380,7 @@ static int blk_mq_poll(struct request_queue *q, blk_qc_t cookie)
 
 		hctx->poll_invoked++;
 
-		ret = q->mq_ops->poll(hctx, -1U);
+		ret = q->mq_ops->poll(hctx);
 		if (ret > 0) {
 			hctx->poll_success++;
 			__set_current_state(TASK_RUNNING);
diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c
index de50d80ecc84..73effe586e5f 100644
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
index c2c3e1a5b7af..ccfde6c7c0a5 100644
--- a/drivers/nvme/host/rdma.c
+++ b/drivers/nvme/host/rdma.c
@@ -1736,7 +1736,7 @@ static blk_status_t nvme_rdma_queue_rq(struct blk_mq_hw_ctx *hctx,
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

