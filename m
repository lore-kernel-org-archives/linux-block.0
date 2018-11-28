Return-Path: <SRS0=FxMo=OH=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1CF5DC43441
	for <linux-block@archiver.kernel.org>; Wed, 28 Nov 2018 13:35:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D741C2081B
	for <linux-block@archiver.kernel.org>; Wed, 28 Nov 2018 13:35:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="HyExy12R"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D741C2081B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-block-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728300AbeK2Ahc (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 28 Nov 2018 19:37:32 -0500
Received: from mail-pl1-f193.google.com ([209.85.214.193]:37847 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727802AbeK2Ahc (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 28 Nov 2018 19:37:32 -0500
Received: by mail-pl1-f193.google.com with SMTP id b5so17410783plr.4
        for <linux-block@vger.kernel.org>; Wed, 28 Nov 2018 05:35:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=ykJpBwnYl+jmo7wq3HEV7dIe+YAl1H1ZzQs2xs7xad4=;
        b=HyExy12RHHfgdMKpmiveqzB6yLlAO3heaEFJelnsBLc/jNODaROFnDuAXY+F7j+HQJ
         0wL5MDKNa5O+vjniqquf5ZSSNIc8isOnkfQ7nBC317oxNZGyqRDwNSNfOxPizySDeIx1
         6U2UDD1E+He2WXRf2mT1i1+phrGsBuqxGeqxJqHsoGGHXrIBq46Ficv156oqvsFHpRks
         Kqkz1WdULNjMruYm0aS678beNiY2epf/ONZH7s3VFLKIaZIR72WOLCFyqeshkmSJJqeO
         CnMrOZ5dv7XT5PumfSJD42cqOopwbqh9Ziu448iRnTOg4DwDbiqnDuO76ki6FngVS3ui
         Ww5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=ykJpBwnYl+jmo7wq3HEV7dIe+YAl1H1ZzQs2xs7xad4=;
        b=F096Xyhl2v9HIDUTk/VgymdfjRrqp0ARz15PIq3RmTv9mAFEs27C8z+USgnhFOMSYv
         V07k+6OYDr8LkoA4Zqg95qzg2pHMNjF8h6ykUVcGyzqOkmXhQgM211OWzJly9Dp5is9B
         SiUyzQZUQke9ITjmCC+xGqaFpS5nLwL6NQMFy652DD5cjPf4GWLRijsHYXB1/qkgT8Au
         H34hBzAIiB/ddNZpYs0mib56r5y0RgEz1SXhMMITKRM+3VEyOCrHbzYL/L8heTLZPICC
         7/ZvZlgoe1Qs64h/Ing3WI4YqpR1eL+T8Ae328DnPZe1K6AiYywTdOs1M0gJTJkgK4w0
         GjXg==
X-Gm-Message-State: AA+aEWauPAxGD5gBcUGOkBpv7cHRtQoggR9eNRh/sb0iMCZKrfZRwlFk
        LxhnA2UXvk2AA8PdlSRrV+YM4paZibw=
X-Google-Smtp-Source: AFSGD/VOiYldXgiEM6uNB3YmqqN0+mWrQgfdmV2lhpI7p+dzmG//A84zbX3GmpI9Ym2rly32jCK9Yg==
X-Received: by 2002:a17:902:20e9:: with SMTP id v38mr34177001plg.250.1543412150980;
        Wed, 28 Nov 2018 05:35:50 -0800 (PST)
Received: from x1.localdomain (66.29.188.166.static.utbb.net. [66.29.188.166])
        by smtp.gmail.com with ESMTPSA id q75sm4744925pfa.38.2018.11.28.05.35.49
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 28 Nov 2018 05:35:50 -0800 (PST)
From:   Jens Axboe <axboe@kernel.dk>
To:     linux-block@vger.kernel.org, linux-nvme@lists.infradead.org
Cc:     Jens Axboe <axboe@kernel.dk>
Subject: [PATCH 4/7] virtio_blk: implement mq_ops->commit_rqs() hook
Date:   Wed, 28 Nov 2018 06:35:35 -0700
Message-Id: <20181128133538.20329-5-axboe@kernel.dk>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20181128133538.20329-1-axboe@kernel.dk>
References: <20181128133538.20329-1-axboe@kernel.dk>
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

We need this for blk-mq to kick things into gear, if we told it that
we had more IO coming, but then failed to deliver on that promise.

Reviewed-by: Omar Sandoval <osandov@fb.com>
Acked-by: Michael S. Tsirkin <mst@redhat.com>
Reviewed-by: Christoph Hellwig <hch@lst.de>
Signed-off-by: Jens Axboe <axboe@kernel.dk>
---
 drivers/block/virtio_blk.c | 15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/drivers/block/virtio_blk.c b/drivers/block/virtio_blk.c
index 6e869d05f91e..912c4265e592 100644
--- a/drivers/block/virtio_blk.c
+++ b/drivers/block/virtio_blk.c
@@ -214,6 +214,20 @@ static void virtblk_done(struct virtqueue *vq)
 	spin_unlock_irqrestore(&vblk->vqs[qid].lock, flags);
 }
 
+static void virtio_commit_rqs(struct blk_mq_hw_ctx *hctx)
+{
+	struct virtio_blk *vblk = hctx->queue->queuedata;
+	struct virtio_blk_vq *vq = &vblk->vqs[hctx->queue_num];
+	bool kick;
+
+	spin_lock_irq(&vq->lock);
+	kick = virtqueue_kick_prepare(vq->vq);
+	spin_unlock_irq(&vq->lock);
+
+	if (kick)
+		virtqueue_notify(vq->vq);
+}
+
 static blk_status_t virtio_queue_rq(struct blk_mq_hw_ctx *hctx,
 			   const struct blk_mq_queue_data *bd)
 {
@@ -638,6 +652,7 @@ static void virtblk_initialize_rq(struct request *req)
 
 static const struct blk_mq_ops virtio_mq_ops = {
 	.queue_rq	= virtio_queue_rq,
+	.commit_rqs	= virtio_commit_rqs,
 	.complete	= virtblk_request_done,
 	.init_request	= virtblk_init_request,
 #ifdef CONFIG_VIRTIO_BLK_SCSI
-- 
2.17.1

