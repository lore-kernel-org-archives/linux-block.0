Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E3400C43217
	for <linux-block@archiver.kernel.org>; Wed, 17 Nov 2021 03:38:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C2F7F61C4F
	for <linux-block@archiver.kernel.org>; Wed, 17 Nov 2021 03:38:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231650AbhKQDlL (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 16 Nov 2021 22:41:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49726 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231424AbhKQDlL (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 16 Nov 2021 22:41:11 -0500
Received: from mail-il1-x136.google.com (mail-il1-x136.google.com [IPv6:2607:f8b0:4864:20::136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BB3E1C061570
        for <linux-block@vger.kernel.org>; Tue, 16 Nov 2021 19:38:13 -0800 (PST)
Received: by mail-il1-x136.google.com with SMTP id i11so1268144ilv.13
        for <linux-block@vger.kernel.org>; Tue, 16 Nov 2021 19:38:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=wnQo7FoyxT08km9ibGsa/nVYEJXXJ3lPgVFWk+SC5qk=;
        b=X1hCAMaJK/jZFrXfeIHAwJoTRcDXMJycF9FC7aciJQWq53cV9u4hJEbYU4rIvg/bK6
         uWknRdYsRZXw46+FI82bQMXQ/RrM/KVioIoOicGrFR4vJNC/Vi2yrD+6d3lJuhu9HQvz
         gi/zTOneYpaqn8zNa0MwtNKU5yokDrOPk8+KVWXnXRzvDFhYMPMZEKHknGWFRYFv6zrF
         IGe3vdH6CXsCx2j0v+dSu1kWPqhQf+xeYsJRdMl7thH5/1ggVuyKG44bW2NDn4Z0Kp6L
         Q+k65auAOzWMRsYHdzlVWiWB9YJfBk430ELr61rQBlt+lraIFpj1aqRW0dYaLAjpSzBC
         jKvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=wnQo7FoyxT08km9ibGsa/nVYEJXXJ3lPgVFWk+SC5qk=;
        b=njmiqSNHXMgagVsc0fp4kD9dAttA+iES/CxIkKIyG9AtY5UZL7KkBEVQeOZeAn/MEV
         52O/VWNdaHHLgqlihDNrZhB1yCSsnOdhMmwXYTh26rZAvPPS/JBV4MlvuZqEDnqQuc8j
         qN/7Nop1FSjmj5iAZd3Hn4SFRlfq2lS4gnZ+s0l86uv3jCCOkn8V6LJS2MoxfRABsHMM
         HchI2XdgzLuL/isHcB/GpSGpPBocyyO/ALnNqs+x2q99YuZBot9vtXHgfHloZV8hDO1R
         OiXhUHdCKk0nbWdMrsb6daEmiOfzBTyQ3cCg2df8Hb7WRh8u4ROP68tTQitIH4P+yTi7
         5hxg==
X-Gm-Message-State: AOAM532pFyIyxms9R66kpri5ym6/0NgSXXww1nZNOiupl8i181ZgoO2N
        9fUTeMyA7c4GvjMdS7F6sA+RLCgrjPQ41usC
X-Google-Smtp-Source: ABdhPJyAw5H1VGO8WdFAje6FkWnhl+anX7sh0EotttHPQAkHXXZsRfjMTUP46Q4wwPYskDvCd2J5jg==
X-Received: by 2002:a92:c0cb:: with SMTP id t11mr7972957ilf.154.1637120292944;
        Tue, 16 Nov 2021 19:38:12 -0800 (PST)
Received: from localhost.localdomain ([66.219.217.159])
        by smtp.gmail.com with ESMTPSA id l13sm12563693ios.49.2021.11.16.19.38.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Nov 2021 19:38:12 -0800 (PST)
From:   Jens Axboe <axboe@kernel.dk>
To:     linux-block@vger.kernel.org
Cc:     hch@infradead.org, Jens Axboe <axboe@kernel.dk>
Subject: [PATCH 4/4] nvme: add support for mq_ops->queue_rqs()
Date:   Tue, 16 Nov 2021 20:38:07 -0700
Message-Id: <20211117033807.185715-5-axboe@kernel.dk>
X-Mailer: git-send-email 2.33.1
In-Reply-To: <20211117033807.185715-1-axboe@kernel.dk>
References: <20211117033807.185715-1-axboe@kernel.dk>
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
 drivers/nvme/host/pci.c | 67 +++++++++++++++++++++++++++++++++++++++++
 1 file changed, 67 insertions(+)

diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c
index d2b654fc3603..2eedd04b1f90 100644
--- a/drivers/nvme/host/pci.c
+++ b/drivers/nvme/host/pci.c
@@ -1004,6 +1004,72 @@ static blk_status_t nvme_queue_rq(struct blk_mq_hw_ctx *hctx,
 	return ret;
 }
 
+static void nvme_submit_cmds(struct nvme_queue *nvmeq, struct request **rqlist)
+{
+	spin_lock(&nvmeq->sq_lock);
+	while (!rq_list_empty(*rqlist)) {
+		struct request *req = rq_list_pop(rqlist);
+		struct nvme_iod *iod = blk_mq_rq_to_pdu(req);
+
+		nvme_copy_cmd(nvmeq, absolute_pointer(&iod->cmd));
+	}
+	nvme_write_sq_db(nvmeq, true);
+	spin_unlock(&nvmeq->sq_lock);
+}
+
+static void nvme_queue_rqs(struct request **rqlist)
+{
+	struct request *requeue_list = NULL, *req, *prev = NULL;
+	struct blk_mq_hw_ctx *hctx;
+	struct nvme_queue *nvmeq;
+	struct nvme_ns *ns;
+
+restart:
+	req = rq_list_peek(rqlist);
+	hctx = req->mq_hctx;
+	nvmeq = hctx->driver_data;
+	ns = hctx->queue->queuedata;
+
+	/*
+	 * We should not need to do this, but we're still using this to
+	 * ensure we can drain requests on a dying queue.
+	 */
+	if (unlikely(!test_bit(NVMEQ_ENABLED, &nvmeq->flags)))
+		return;
+
+	rq_list_for_each(rqlist, req) {
+		struct nvme_iod *iod = blk_mq_rq_to_pdu(req);
+		blk_status_t ret;
+
+		if (unlikely(!nvme_check_ready(&nvmeq->dev->ctrl, req, true)))
+			goto requeue;
+
+		if (req->mq_hctx != hctx) {
+			/* detach rest of list, and submit */
+			prev->rq_next = NULL;
+			nvme_submit_cmds(nvmeq, rqlist);
+			/* req now start of new list for this hw queue */
+			*rqlist = req;
+			goto restart;
+		}
+
+		hctx->tags->rqs[req->tag] = req;
+		ret = nvme_prep_rq(nvmeq->dev, ns, req, &iod->cmd);
+		if (ret == BLK_STS_OK) {
+			prev = req;
+			continue;
+		}
+requeue:
+		/* detach 'req' and add to remainder list */
+		if (prev)
+			prev->rq_next = req->rq_next;
+		rq_list_add(&requeue_list, req);
+	}
+
+	nvme_submit_cmds(nvmeq, rqlist);
+	*rqlist = requeue_list;
+}
+
 static __always_inline void nvme_pci_unmap_rq(struct request *req)
 {
 	struct nvme_iod *iod = blk_mq_rq_to_pdu(req);
@@ -1741,6 +1807,7 @@ static const struct blk_mq_ops nvme_mq_admin_ops = {
 
 static const struct blk_mq_ops nvme_mq_ops = {
 	.queue_rq	= nvme_queue_rq,
+	.queue_rqs	= nvme_queue_rqs,
 	.complete	= nvme_pci_complete_rq,
 	.commit_rqs	= nvme_commit_rqs,
 	.init_hctx	= nvme_init_hctx,
-- 
2.33.1

