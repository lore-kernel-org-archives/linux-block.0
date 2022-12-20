Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C7282C10F1E
	for <linux-block@archiver.kernel.org>; Tue, 20 Dec 2022 15:36:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229958AbiLTPgw (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 20 Dec 2022 10:36:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36778 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229638AbiLTPgv (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 20 Dec 2022 10:36:51 -0500
Received: from mail-pl1-x634.google.com (mail-pl1-x634.google.com [IPv6:2607:f8b0:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CB3A3E0
        for <linux-block@vger.kernel.org>; Tue, 20 Dec 2022 07:36:50 -0800 (PST)
Received: by mail-pl1-x634.google.com with SMTP id t2so12648971ply.2
        for <linux-block@vger.kernel.org>; Tue, 20 Dec 2022 07:36:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1MLXjes3JIAsgel+SrJ2/UmVYh62VOMAS31r3eQD11A=;
        b=iZom9Gv4ORvlSBwhoRZrd911HG9u0AbGSjbV+VqTAVv9Gi8N1c87+aUOrKfv28kxQe
         XzB0k2i4sp2YehVmTlY25s+FybtU7nCUU9gCEB8XYWusd+dljiFDQL9HzdA2ae9/+6XP
         H17VU+l/wjdZH7Q2W7YvaStltfstbv6HOy4wK4NNGx4pJLeufauq3siSIP5uDHJk0HkY
         zOlpSUwktSE9pHld+mKBn6fENOqpXXzPwii+b/W+n/+jVmgWrUwxrOOYnOlUINwcQjFi
         /hnvMP1Lhn78YIT1rZK5yey6cQPJVFJvprSTSb5KkTJi0CuebOdEfCPW+lLAHJ+OfV1/
         tbrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=1MLXjes3JIAsgel+SrJ2/UmVYh62VOMAS31r3eQD11A=;
        b=KqSRhfVqbYJRs/msEHScZjGgHHl38GPu4vHxSazI3nB3WZkMVsZTpntO6KxXaJow5b
         HuCvk0NOBFwh4rZhfCTnjMO7mCH50YkD7HJXYzMCD1UKzeHJt+Gbov64iKS3BmiHc2TO
         su3lu37CejDnXsVssNiFJaKcRzRNFTrxxjkyd4O5hEEd16IgQJU6HPCvkVVPPYVm0Ikf
         Hgq9AnREUv8ot68uBFdBe1tJNQsWi4qdE+e0j7dLbwZKkeWT9a4yR6mGQD4ZXgqd+4Lq
         IR7YTYJQdsrJXGzj7Q3ETtHhXvhvBtV+aBW72py/UQqIVEoWG6cDaTK5ZwIC/2gzUMS8
         WPeg==
X-Gm-Message-State: AFqh2kriUH72lYONkY4lsniLQKPt+E1kw0dkjDAPWJw4azOc8lKVkHX1
        H88US9/wdzCLZwhxj17oj5E=
X-Google-Smtp-Source: AMrXdXv4u4fH7pb3YL7OCQ2NYIkJ/2HZJXgFFkNKYNp6hzR8eVJuwrhpuMr4PaneH1vXl+iVbjhppQ==
X-Received: by 2002:a17:902:f301:b0:191:1a7c:ef9d with SMTP id c1-20020a170902f30100b001911a7cef9dmr8995899ple.56.1671550610273;
        Tue, 20 Dec 2022 07:36:50 -0800 (PST)
Received: from localhost.localdomain ([114.200.4.15])
        by smtp.googlemail.com with ESMTPSA id jf3-20020a170903268300b001811a197797sm9558084plb.194.2022.12.20.07.36.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Dec 2022 07:36:49 -0800 (PST)
From:   Suwan Kim <suwan.kim027@gmail.com>
To:     mst@redhat.com, jasowang@redhat.com, stefanha@redhat.com,
        pbonzini@redhat.com, hch@infradead.org, axboe@kernel.dk
Cc:     virtualization@lists.linux-foundation.org,
        linux-block@vger.kernel.org, Suwan Kim <suwan.kim027@gmail.com>
Subject: [PATCH v2 2/2] virtio-blk: support completion batching for the IRQ path
Date:   Wed, 21 Dec 2022 00:36:13 +0900
Message-Id: <20221220153613.21675-3-suwan.kim027@gmail.com>
X-Mailer: git-send-email 2.26.3
In-Reply-To: <20221220153613.21675-1-suwan.kim027@gmail.com>
References: <20221220153613.21675-1-suwan.kim027@gmail.com>
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
 drivers/block/virtio_blk.c | 82 +++++++++++++++++++++-----------------
 1 file changed, 45 insertions(+), 37 deletions(-)

diff --git a/drivers/block/virtio_blk.c b/drivers/block/virtio_blk.c
index 75ee51aba964..0ac7b570300c 100644
--- a/drivers/block/virtio_blk.c
+++ b/drivers/block/virtio_blk.c
@@ -272,33 +272,63 @@ static inline void virtblk_request_done(struct request *req)
 	blk_mq_end_request(req, virtblk_result(vbr));
 }
 
+static void virtblk_complete_batch(struct io_comp_batch *iob)
+{
+	struct request *req;
+
+	rq_list_for_each(&iob->req_list, req) {
+		virtblk_unmap_data(req, blk_mq_rq_to_pdu(req));
+		virtblk_cleanup_cmd(req);
+	}
+	blk_mq_end_request_batch(iob);
+}
+
+static int virtblk_handle_req(struct virtio_blk_vq *vq,
+				struct io_comp_batch *iob)
+{
+	struct virtblk_req *vbr;
+	int req_done = 0;
+	unsigned int len;
+
+	while ((vbr = virtqueue_get_buf(vq->vq, &len)) != NULL) {
+		struct request *req = blk_mq_rq_from_pdu(vbr);
+
+		if (likely(!blk_should_fake_timeout(req->q)) &&
+			!blk_mq_complete_request_remote(req) &&
+			!blk_mq_add_to_batch(req, iob, vbr->status,
+						virtblk_complete_batch))
+			virtblk_request_done(req);
+		req_done++;
+	}
+
+	return req_done;
+}
+
 static void virtblk_done(struct virtqueue *vq)
 {
 	struct virtio_blk *vblk = vq->vdev->priv;
-	bool req_done = false;
-	int qid = vq->index;
-	struct virtblk_req *vbr;
+	struct virtio_blk_vq *vblk_vq = &vblk->vqs[vq->index];
+	int req_done = 0;
 	unsigned long flags;
-	unsigned int len;
+	DEFINE_IO_COMP_BATCH(iob);
 
-	spin_lock_irqsave(&vblk->vqs[qid].lock, flags);
+	spin_lock_irqsave(&vblk_vq->lock, flags);
 	do {
 		virtqueue_disable_cb(vq);
-		while ((vbr = virtqueue_get_buf(vblk->vqs[qid].vq, &len)) != NULL) {
-			struct request *req = blk_mq_rq_from_pdu(vbr);
+		req_done += virtblk_handle_req(vblk_vq, &iob);
 
-			if (likely(!blk_should_fake_timeout(req->q)))
-				blk_mq_complete_request(req);
-			req_done = true;
-		}
 		if (unlikely(virtqueue_is_broken(vq)))
 			break;
 	} while (!virtqueue_enable_cb(vq));
 
-	/* In case queue is stopped waiting for more buffers. */
-	if (req_done)
+	if (req_done) {
+		if (!rq_list_empty(iob.req_list))
+			iob.complete(&iob);
+
+		/* In case queue is stopped waiting for more buffers. */
 		blk_mq_start_stopped_hw_queues(vblk->disk->queue, true);
-	spin_unlock_irqrestore(&vblk->vqs[qid].lock, flags);
+	}
+	spin_unlock_irqrestore(&vblk_vq->lock, flags);
 }
 
 static void virtio_commit_rqs(struct blk_mq_hw_ctx *hctx)
@@ -832,37 +862,15 @@ static void virtblk_map_queues(struct blk_mq_tag_set *set)
 	}
 }
 
-static void virtblk_complete_batch(struct io_comp_batch *iob)
-{
-	struct request *req;
-
-	rq_list_for_each(&iob->req_list, req) {
-		virtblk_unmap_data(req, blk_mq_rq_to_pdu(req));
-		virtblk_cleanup_cmd(req);
-	}
-	blk_mq_end_request_batch(iob);
-}
-
 static int virtblk_poll(struct blk_mq_hw_ctx *hctx, struct io_comp_batch *iob)
 {
 	struct virtio_blk *vblk = hctx->queue->queuedata;
 	struct virtio_blk_vq *vq = get_virtio_blk_vq(hctx);
-	struct virtblk_req *vbr;
 	unsigned long flags;
-	unsigned int len;
 	int found = 0;
 
 	spin_lock_irqsave(&vq->lock, flags);
-
-	while ((vbr = virtqueue_get_buf(vq->vq, &len)) != NULL) {
-		struct request *req = blk_mq_rq_from_pdu(vbr);
-
-		found++;
-		if (!blk_mq_complete_request_remote(req) &&
-		    !blk_mq_add_to_batch(req, iob, vbr->status,
-						virtblk_complete_batch))
-			virtblk_request_done(req);
-	}
+	found = virtblk_handle_req(vq, iob);
 
 	if (found)
 		blk_mq_start_stopped_hw_queues(vblk->disk->queue, true);
-- 
2.26.3

