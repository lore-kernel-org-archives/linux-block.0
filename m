Return-Path: <SRS0=/l1b=OF=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EB93BC43441
	for <linux-block@archiver.kernel.org>; Mon, 26 Nov 2018 16:36:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 986B320659
	for <linux-block@archiver.kernel.org>; Mon, 26 Nov 2018 16:36:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="EhJkWjQI"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 986B320659
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-block-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726634AbeK0Dat (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 26 Nov 2018 22:30:49 -0500
Received: from mail-it1-f196.google.com ([209.85.166.196]:51809 "EHLO
        mail-it1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726253AbeK0Dat (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 26 Nov 2018 22:30:49 -0500
Received: by mail-it1-f196.google.com with SMTP id x19so29251760itl.1
        for <linux-block@vger.kernel.org>; Mon, 26 Nov 2018 08:36:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=Dg+etYC2drYnfrLWClPG4P6hpiYhQ/56nszkzahxJB8=;
        b=EhJkWjQI2JP92wWMckYenWDZben7TEVnaTCmcoMvxAnGgskAEZFkeP84PdAuilkSce
         oIofQpUBmVmpJV5Y1Y3/CwCpK++S5GiRTy/UbHSbZsDAYI48Om1nxk+hnRlTwyldAl7l
         nJQZ3pbUYGPLR6clzQ2FrTndxIPXKzuNNNlkoZqDAaZ8WmB3TIx2AdDqUGYfo+4qGwch
         aCIWP/QoNQHMnnnhnpr5SPN86y+XdF6fJ3r0T807+le+lUywKIX84JpZouBXRjd1xunw
         tlkWcIyboX1sM1eZICFLv3Ds3fhaAYuBmpBfO6my+nuFFzizsL25uKSf6tBXYR4NSKlp
         90JQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=Dg+etYC2drYnfrLWClPG4P6hpiYhQ/56nszkzahxJB8=;
        b=h67J7u9l5IFa8QB203diAcII8XRq4Wv7m0tqjczTjD0j5r7MFTSUquZ5RX/gUUE58o
         vN6H5iEIN6mu6h3qTymyEcGdMB/wUtDI/xPBAzI4XWBwPyUpu/ywhgelmjsm4LYSQRtj
         bkk+bS29quGdfwUekRh+dcR4k+2qZ38hpjBuF1zsQrO1qcOHP94oV1avYwwOKSuw8aoO
         RhiTiVROnTSV3ZSaJyZxDw1xDmokL9fN+HyFrk3bKGAIyJJcGB68VJzhhTVVnFqF+Q5w
         x0CtWrtbp4PdBeye6ij8TR0FfPrixeWHVdDpLqIcsO+pxJPYH4mE7h1ItdVqKz6TXdP9
         6F0Q==
X-Gm-Message-State: AA+aEWZ3qcHTZn8mQpU0S4qVn5/a5rQ5Yo4m/rE8jHBj1uNvCcAafqUU
        aAKhA+CWPIZ4VaK6jagq3PMhtSdxBmc=
X-Google-Smtp-Source: AJdET5fKZfS1T0DGCM+D8/+UpX+tglfd9Li+rspSnSa1OaYX1Kk9ez99fq8dXt9fh5oxLOD7pFRgxA==
X-Received: by 2002:a24:5989:: with SMTP id p131-v6mr22798269itb.0.1543250171582;
        Mon, 26 Nov 2018 08:36:11 -0800 (PST)
Received: from localhost.localdomain ([216.160.245.98])
        by smtp.gmail.com with ESMTPSA id r11sm263717iog.46.2018.11.26.08.36.08
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 26 Nov 2018 08:36:10 -0800 (PST)
From:   Jens Axboe <axboe@kernel.dk>
To:     linux-block@vger.kernel.org, linux-nvme@lists.infradead.org
Cc:     Jens Axboe <axboe@kernel.dk>
Subject: [PATCH 5/8] virtio_blk: implement mq_ops->commit_rqs() hook
Date:   Mon, 26 Nov 2018 09:35:53 -0700
Message-Id: <20181126163556.5181-6-axboe@kernel.dk>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20181126163556.5181-1-axboe@kernel.dk>
References: <20181126163556.5181-1-axboe@kernel.dk>
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

We need this for blk-mq to kick things into gear, if we told it that
we had more IO coming, but then failed to deliver on that promise.

Signed-off-by: Jens Axboe <axboe@kernel.dk>
---
 drivers/block/virtio_blk.c | 15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/drivers/block/virtio_blk.c b/drivers/block/virtio_blk.c
index 6e869d05f91e..b49c57e77780 100644
--- a/drivers/block/virtio_blk.c
+++ b/drivers/block/virtio_blk.c
@@ -214,6 +214,20 @@ static void virtblk_done(struct virtqueue *vq)
 	spin_unlock_irqrestore(&vblk->vqs[qid].lock, flags);
 }
 
+static void virtio_commit_rqs(struct blk_mq_hw_ctx *hctx)
+{
+	struct virtio_blk *vblk = hctx->queue->queuedata;
+	int qid = hctx->queue_num;
+	bool kick;
+
+	spin_lock_irq(&vblk->vqs[qid].lock);
+	kick = virtqueue_kick_prepare(vblk->vqs[qid].vq);
+	spin_unlock_irq(&vblk->vqs[qid].lock);
+
+	if (kick)
+		virtqueue_notify(vblk->vqs[qid].vq);
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

