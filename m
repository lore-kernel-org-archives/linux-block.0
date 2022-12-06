Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 991E5C352A1
	for <linux-block@archiver.kernel.org>; Tue,  6 Dec 2022 14:12:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234765AbiLFOMV (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 6 Dec 2022 09:12:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57158 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234758AbiLFOMU (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Tue, 6 Dec 2022 09:12:20 -0500
Received: from mail-pj1-x1029.google.com (mail-pj1-x1029.google.com [IPv6:2607:f8b0:4864:20::1029])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E2C502CE18
        for <linux-block@vger.kernel.org>; Tue,  6 Dec 2022 06:12:17 -0800 (PST)
Received: by mail-pj1-x1029.google.com with SMTP id q17-20020a17090aa01100b002194cba32e9so18155675pjp.1
        for <linux-block@vger.kernel.org>; Tue, 06 Dec 2022 06:12:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=EEhiuW2gArhGYCSskmAetNey/HHBVPNeAnM+tUNOGWM=;
        b=YAzn0NHmdbqwon7yA6Fo1RYOBgm2BTRRm6EJWFdOL1W5dB2EdmrH5UkeX7ZhsbyR1E
         DAtAuU1OCDOimtKrdpRSZrvTv9xSNl0AIa00uMhiPXihv4wDh9LYA2N1yd3R3izb3QVr
         n7hpJr+N0xihNpDIyGTmBzKptBmNl07IKJl9XmPM574D07Akdswkhge590FfPY71sisH
         goBFCm+wdGik6Qule0/XAznpf47x3okrTO3fT3LACABsgolJTPoGtosD5mgU9Odw+c+E
         W1sB4Lq8sxzFTnbxNMWx32GPu2x9xfmDtapwYsBdlOqCdx7tI9y1Dlmx9tD32t3Zj3Ml
         jQcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=EEhiuW2gArhGYCSskmAetNey/HHBVPNeAnM+tUNOGWM=;
        b=6P5hm0tf+hP8CIM7qleU/EIev7agKdsIRw106J+vEe5zfe7RlTTOjVKGeL3q8/EbS3
         3NZcfYNxTzGndwYnFuV2hUWT8QF6Zec94rfVgx/eobEcMXg901ZY+5aWBdec666oyqtR
         RZMxKCR3O9+V3Hq/NSFVBcFlO5Tt0Flj68jLWKIxlB5sK16Pyv0QEs2us106DwdXN6cS
         L0AkiEgyWFFtbh33H9H0/bIIMizRTYy9In9upyDjOiH6Yj3FBfYKm4yROUeXJmHcNJz3
         rH2ECFhqZHZjta2hrkjYAjDhjwXqRpYT8BmlaKJa7+eBi7nI66MCYurBEhJOya1t+x9J
         sA2Q==
X-Gm-Message-State: ANoB5pmzubrgMkzEyaPaMqjKZ18wLmbG9k5vcroMt7gGLg5uRKuWw3gN
        hXKmxBXqiiNwjkA0Mc+nCho=
X-Google-Smtp-Source: AA0mqf5ifQnIEWDTnItBjrVO3oTIfJn3X/DJofogVO7Y5EaU0HvuxDZsPjGYiGxYc5wCBxyE415Sbg==
X-Received: by 2002:a17:90b:4d0b:b0:214:1329:dec7 with SMTP id mw11-20020a17090b4d0b00b002141329dec7mr101284953pjb.91.1670335937419;
        Tue, 06 Dec 2022 06:12:17 -0800 (PST)
Received: from localhost.localdomain ([114.200.4.15])
        by smtp.googlemail.com with ESMTPSA id nn6-20020a17090b38c600b001df264610c4sm2282978pjb.0.2022.12.06.06.12.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 06 Dec 2022 06:12:16 -0800 (PST)
From:   Suwan Kim <suwan.kim027@gmail.com>
To:     mst@redhat.com, jasowang@redhat.com, stefanha@redhat.com,
        pbonzini@redhat.com, hch@infradead.org, axboe@kernel.dk
Cc:     virtualization@lists.linux-foundation.org,
        linux-block@vger.kernel.org, Suwan Kim <suwan.kim027@gmail.com>
Subject: [PATCH 2/2] virtio-blk: support completion batching for the IRQ path
Date:   Tue,  6 Dec 2022 23:11:25 +0900
Message-Id: <20221206141125.93055-2-suwan.kim027@gmail.com>
X-Mailer: git-send-email 2.26.3
In-Reply-To: <20221206141125.93055-1-suwan.kim027@gmail.com>
References: <20221206141125.93055-1-suwan.kim027@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

This patch adds completion batching to the IRQ path. It reuses batch
completion code of virtblk_poll(). It collects requests to io_comp_batch
and processes them all at once. It can boost up the performance by 2%.

To validate the performance improvement and stabilty, I did fio test with
4 vCPU VM and 12 vCPU VM respectively. Both VMs have 8GB ram and the same
number of HW queues as vCPU.
The fio cammad is as follows and I ran the fio 5 times and got IOPS average.
(io_uring, randread, direct=1, bs=512, iodepth=64 numjobs=2,4)

Test result shows about 2% improvement.

           4 vcpu VM       |   numjobs=2   |   numjobs=4
      -----------------------------------------------------------
        fio without patch  |  367.2K IOPS  |   397.6K IOPS
      -----------------------------------------------------------
        fio with patch     |  372.8K IOPS  |   407.7K IOPS

           12 vcpu VM      |   numjobs=2   |   numjobs=4
      -----------------------------------------------------------
        fio without patch  |  363.6K IOPS  |   374.8K IOPS
      -----------------------------------------------------------
        fio with patch     |  373.8K IOPS  |   385.3K IOPS

Signed-off-by: Suwan Kim <suwan.kim027@gmail.com>
---
 drivers/block/virtio_blk.c | 38 +++++++++++++++++++++++---------------
 1 file changed, 23 insertions(+), 15 deletions(-)

diff --git a/drivers/block/virtio_blk.c b/drivers/block/virtio_blk.c
index cf64d256787e..48fcf745f007 100644
--- a/drivers/block/virtio_blk.c
+++ b/drivers/block/virtio_blk.c
@@ -272,6 +272,18 @@ static inline void virtblk_request_done(struct request *req)
 	blk_mq_end_request(req, virtblk_result(vbr));
 }
 
+static void virtblk_complete_batch(struct io_comp_batch *iob)
+{
+	struct request *req;
+
+	rq_list_for_each(&iob->req_list, req) {
+		virtblk_unmap_data(req, blk_mq_rq_to_pdu(req));
+		virtblk_cleanup_cmd(req);
+		blk_mq_set_request_complete(req);
+	}
+	blk_mq_end_request_batch(iob);
+}
+
 static void virtblk_done(struct virtqueue *vq)
 {
 	struct virtio_blk *vblk = vq->vdev->priv;
@@ -280,6 +292,7 @@ static void virtblk_done(struct virtqueue *vq)
 	struct virtblk_req *vbr;
 	unsigned long flags;
 	unsigned int len;
+	DEFINE_IO_COMP_BATCH(iob);
 
 	spin_lock_irqsave(&vblk->vqs[qid].lock, flags);
 	do {
@@ -287,7 +300,9 @@ static void virtblk_done(struct virtqueue *vq)
 		while ((vbr = virtqueue_get_buf(vblk->vqs[qid].vq, &len)) != NULL) {
 			struct request *req = blk_mq_rq_from_pdu(vbr);
 
-			if (likely(!blk_should_fake_timeout(req->q)))
+			if (likely(!blk_should_fake_timeout(req->q)) &&
+				!blk_mq_add_to_batch(req, &iob, vbr->status,
+							virtblk_complete_batch))
 				blk_mq_complete_request(req);
 			req_done = true;
 		}
@@ -295,9 +310,14 @@ static void virtblk_done(struct virtqueue *vq)
 			break;
 	} while (!virtqueue_enable_cb(vq));
 
-	/* In case queue is stopped waiting for more buffers. */
-	if (req_done)
+	if (req_done) {
+		if (!rq_list_empty(iob.req_list))
+			virtblk_complete_batch(&iob);
+
+		/* In case queue is stopped waiting for more buffers. */
 		blk_mq_start_stopped_hw_queues(vblk->disk->queue, true);
+	}
+
 	spin_unlock_irqrestore(&vblk->vqs[qid].lock, flags);
 }
 
@@ -832,18 +852,6 @@ static void virtblk_map_queues(struct blk_mq_tag_set *set)
 	}
 }
 
-static void virtblk_complete_batch(struct io_comp_batch *iob)
-{
-	struct request *req;
-
-	rq_list_for_each(&iob->req_list, req) {
-		virtblk_unmap_data(req, blk_mq_rq_to_pdu(req));
-		virtblk_cleanup_cmd(req);
-		blk_mq_set_request_complete(req);
-	}
-	blk_mq_end_request_batch(iob);
-}
-
 static int virtblk_poll(struct blk_mq_hw_ctx *hctx, struct io_comp_batch *iob)
 {
 	struct virtio_blk *vblk = hctx->queue->queuedata;
-- 
2.26.3

