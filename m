Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E9BFAC433F5
	for <linux-block@archiver.kernel.org>; Fri,  3 Dec 2021 21:45:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1383271AbhLCVtW (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 3 Dec 2021 16:49:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40562 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236204AbhLCVtW (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Fri, 3 Dec 2021 16:49:22 -0500
Received: from mail-pl1-x632.google.com (mail-pl1-x632.google.com [IPv6:2607:f8b0:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ADDFFC061751
        for <linux-block@vger.kernel.org>; Fri,  3 Dec 2021 13:45:57 -0800 (PST)
Received: by mail-pl1-x632.google.com with SMTP id q17so2979341plr.11
        for <linux-block@vger.kernel.org>; Fri, 03 Dec 2021 13:45:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=o9zV3AsUZv3pbYT8ZjfgRU03aeoO//Fo4QIP9poWU10=;
        b=O9dRHmm+b/fSAJP61fkqyLIKKrC932Ckx8rkC8pOe2OdQfHAn1+hnqLbjSdP9HvSLU
         VtEa9hdPdc8JiuZNf/aSdpn25KLqOTvEgOgAnznvWgmwbvk5te1OgglAmnuGf8UDBeFL
         2CgcPcLYAC3oXQU9jQIjSRe9KEBwZk0ZZ0gDlDAvj8LNQ8eJhecOS2A7TbexTanGNw2R
         3LLH56MBqaEe6KLl7icZXXzWMtpcsfSFJoW4IgRlphYjmz4RjuZ21B/zDNljczxuy66k
         QRPGmS8ffOfguC4hLvFMkCqi4g9UU/J0oyPp10RD3WgLZZ+5uUB1hAVPYr9YsBclzTP3
         +OJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=o9zV3AsUZv3pbYT8ZjfgRU03aeoO//Fo4QIP9poWU10=;
        b=OYFvJhKPOAW8qaBwq6Q0vEZIMYYIoyyNp5O2IAgHAU4QoAAWY5DVtdqWpwOa5Vu+U5
         eXeA7QvaemBq721gqfuGrvq9CPodBixBuVdiSRh8FopyodJ0NzKmepCYD/LqsUaKZwOq
         452xZQHJSjN0L/bI2lcaxWbEWqRxunLHg0/ezoMUxmFhEHS2Fd6rIhCCW4upwTrJZqvs
         mPthcKgJ5/FjLLiR1F4IXK2VNV/Iv/qAv1NZNLqb6lf1e4oW3NCZdGpotTo7YM3QsOlo
         4RjjWkcUqvKEw8UdjEJqhywM+3JHtSj7k58aLRZHBe7WyKrCZ4FmN5mLs74HVLtz2KuN
         qU+A==
X-Gm-Message-State: AOAM533obwUwvE8x1eHzwlz7TnpOTUjtOUVmEIcj5wpVsShb9bKBjls4
        NfR97O1kQc7/liu3JW5teNSXAzxFNC2tCieV
X-Google-Smtp-Source: ABdhPJwm5/Pin5+Uog1HvCngT5V4+Ahn+yrA4GFB6w1uHITyV+zEh9CiOMWTmUiW7fh94H39ZzWsVA==
X-Received: by 2002:a17:903:24d:b0:143:beb5:b6b1 with SMTP id j13-20020a170903024d00b00143beb5b6b1mr25758780plh.54.1638567956943;
        Fri, 03 Dec 2021 13:45:56 -0800 (PST)
Received: from localhost.localdomain ([66.219.217.159])
        by smtp.gmail.com with ESMTPSA id f4sm4436225pfj.61.2021.12.03.13.45.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 Dec 2021 13:45:56 -0800 (PST)
From:   Jens Axboe <axboe@kernel.dk>
To:     linux-block@vger.kernel.org, linux-nvme@lists.infradead.org
Cc:     Jens Axboe <axboe@kernel.dk>
Subject: [PATCH 4/4] nvme: add support for mq_ops->queue_rqs()
Date:   Fri,  3 Dec 2021 14:45:44 -0700
Message-Id: <20211203214544.343460-5-axboe@kernel.dk>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20211203214544.343460-1-axboe@kernel.dk>
References: <20211203214544.343460-1-axboe@kernel.dk>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

This enables the block layer to send us a full plug list of requests
that need submitting. The block layer guarantees that they all belong
to the same queue, but we do have to check the hardware queue mapping
for each request.

If errors are encountered, leave them in the passed in list. Then the
block layer will handle them individually.

This is good for about a 4% improvement in peak performance, taking us
from 9.6M to 10M IOPS/core.

Signed-off-by: Jens Axboe <axboe@kernel.dk>
---
 drivers/nvme/host/pci.c | 61 +++++++++++++++++++++++++++++++++++++++++
 1 file changed, 61 insertions(+)

diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c
index 6be6b1ab4285..197aa45ef7ef 100644
--- a/drivers/nvme/host/pci.c
+++ b/drivers/nvme/host/pci.c
@@ -981,6 +981,66 @@ static blk_status_t nvme_queue_rq(struct blk_mq_hw_ctx *hctx,
 	return BLK_STS_OK;
 }
 
+static void nvme_submit_cmds(struct nvme_queue *nvmeq, struct request **rqlist)
+{
+	spin_lock(&nvmeq->sq_lock);
+	while (!rq_list_empty(*rqlist)) {
+		struct request *req = rq_list_pop(rqlist);
+		struct nvme_iod *iod = blk_mq_rq_to_pdu(req);
+
+		memcpy(nvmeq->sq_cmds + (nvmeq->sq_tail << nvmeq->sqes),
+				absolute_pointer(&iod->cmd), sizeof(iod->cmd));
+		if (++nvmeq->sq_tail == nvmeq->q_depth)
+			nvmeq->sq_tail = 0;
+	}
+	nvme_write_sq_db(nvmeq, true);
+	spin_unlock(&nvmeq->sq_lock);
+}
+
+static bool nvme_prep_rq_batch(struct nvme_queue *nvmeq, struct request *req)
+{
+	/*
+	 * We should not need to do this, but we're still using this to
+	 * ensure we can drain requests on a dying queue.
+	 */
+	if (unlikely(!test_bit(NVMEQ_ENABLED, &nvmeq->flags)))
+		return false;
+	if (unlikely(!nvme_check_ready(&nvmeq->dev->ctrl, req, true)))
+		return false;
+
+	req->mq_hctx->tags->rqs[req->tag] = req;
+	return nvme_prep_rq(nvmeq->dev, req) == BLK_STS_OK;
+}
+
+static void nvme_queue_rqs(struct request **rqlist)
+{
+	struct request *req = rq_list_peek(rqlist), *prev = NULL;
+	struct request *requeue_list = NULL;
+
+	do {
+		struct nvme_queue *nvmeq = req->mq_hctx->driver_data;
+
+		if (!nvme_prep_rq_batch(nvmeq, req)) {
+			/* detach 'req' and add to remainder list */
+			if (prev)
+				prev->rq_next = req->rq_next;
+			rq_list_add(&requeue_list, req);
+		} else {
+			prev = req;
+		}
+
+		req = rq_list_next(req);
+		if (!req || (prev && req->mq_hctx != prev->mq_hctx)) {
+			/* detach rest of list, and submit */
+			prev->rq_next = NULL;
+			nvme_submit_cmds(nvmeq, rqlist);
+			*rqlist = req;
+		}
+	} while (req);
+
+	*rqlist = requeue_list;
+}
+
 static __always_inline void nvme_pci_unmap_rq(struct request *req)
 {
 	struct nvme_iod *iod = blk_mq_rq_to_pdu(req);
@@ -1678,6 +1738,7 @@ static const struct blk_mq_ops nvme_mq_admin_ops = {
 
 static const struct blk_mq_ops nvme_mq_ops = {
 	.queue_rq	= nvme_queue_rq,
+	.queue_rqs	= nvme_queue_rqs,
 	.complete	= nvme_pci_complete_rq,
 	.commit_rqs	= nvme_commit_rqs,
 	.init_hctx	= nvme_init_hctx,
-- 
2.34.1

