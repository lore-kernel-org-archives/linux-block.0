Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 57035C433F5
	for <linux-block@archiver.kernel.org>; Wed,  6 Apr 2022 17:28:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239243AbiDFRaN (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 6 Apr 2022 13:30:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37476 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239177AbiDFR37 (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Wed, 6 Apr 2022 13:29:59 -0400
Received: from mail-pf1-x430.google.com (mail-pf1-x430.google.com [IPv6:2607:f8b0:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EDCBB6377
        for <linux-block@vger.kernel.org>; Wed,  6 Apr 2022 08:32:59 -0700 (PDT)
Received: by mail-pf1-x430.google.com with SMTP id s8so2746564pfk.12
        for <linux-block@vger.kernel.org>; Wed, 06 Apr 2022 08:32:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=QUWEtqdcs6FvknA2cur3eZm3P9mBxM8axKf5gzGdnMg=;
        b=LUeQ9OYBL0Z2v3DhtaxJaz4oaaf4bdyZcBECl0nfDraADBw3KtJeGPRDCl0OwzOkN3
         G2Y9rBB1eyQ2GKCjpS0U6ew5Wzq4xOtmxjXdBmp8YNzdPFS5YGVcnlUjS6ompLkzvmV0
         gQhSupzZyB4zfu8StdkBFCM4rSk8p/yLmPL9tm6m2ganYTFHDL7rZ4PFBDsVbIvzxK1A
         lX6ksQqICCzb5FJYHvgxufQPthuheCiU7anydOiMYpSpuaeHojDhy8splNLSNgY0JDhr
         hmbXJdmOR22C+aBrUhA/dIyDcVzUtJZssMWqFaNXHLXKi22yfAs+XZpuDmTpRuKRolum
         YjOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=QUWEtqdcs6FvknA2cur3eZm3P9mBxM8axKf5gzGdnMg=;
        b=djGzzyeuvb2E396d633rdOQk+jviRzhTTQJc/y1aajR4x89UApPT3yosWIVrHSX3Ld
         gNdTHjRuSd83qlCzlerIfU2AWdBmFhde8EuCGfu8rxR91KlbnZzRmC2gQphAkcGQ7Qh5
         a7ddZJag8E6eV0Tum77NhkogedWOpIczxLO7if6DhZXj09hdsOCHzDKvyvD2XrDtXveW
         E5UYAz+J/me0wpclTcbVgQqMVFr2ctVuoB1EfG4ZorA98mH3XvX1/L+Lj8QLY2gNRTMv
         ETZCpdUVx//tSkFoJrX8VpVBlJTIZF6fOG/LqVas05auer4PutD7Y6PVJrXbH33wk9iB
         0ZAQ==
X-Gm-Message-State: AOAM533mQ/2/Hetp4GxFWQcsH0ZmHXL8Vgf8VHZPlKG9beu/ElhNAKUO
        10aFLGQkGcK+pmYkyZRgBEg=
X-Google-Smtp-Source: ABdhPJywoNHApXu0f+gXiyPKYqHCxiJrSe2lvaLbTGseuTPrQ/J7vZlwUP3sFtQ5VZt1OOnfZZu7vQ==
X-Received: by 2002:a05:6a00:22d2:b0:4fa:9d26:bc5d with SMTP id f18-20020a056a0022d200b004fa9d26bc5dmr9464501pfj.79.1649259179418;
        Wed, 06 Apr 2022 08:32:59 -0700 (PDT)
Received: from localhost.localdomain ([114.200.4.15])
        by smtp.googlemail.com with ESMTPSA id f31-20020a17090a702200b001ca996866b5sm6024037pjk.12.2022.04.06.08.32.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 Apr 2022 08:32:58 -0700 (PDT)
From:   Suwan Kim <suwan.kim027@gmail.com>
To:     mst@redhat.com, jasowang@redhat.com, stefanha@redhat.com,
        pbonzini@redhat.com, mgurtovoy@nvidia.com, dongli.zhang@oracle.com,
        hch@infradead.org, elliott@hpe.com
Cc:     virtualization@lists.linux-foundation.org,
        linux-block@vger.kernel.org, Suwan Kim <suwan.kim027@gmail.com>,
        Christoph Hellwig <hch@lst.de>
Subject: [PATCH v6 1/2] virtio-blk: support polling I/O
Date:   Thu,  7 Apr 2022 00:32:06 +0900
Message-Id: <20220406153207.163134-2-suwan.kim027@gmail.com>
X-Mailer: git-send-email 2.26.3
In-Reply-To: <20220406153207.163134-1-suwan.kim027@gmail.com>
References: <20220406153207.163134-1-suwan.kim027@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

This patch supports polling I/O via virtio-blk driver. Polling
feature is enabled by module parameter "poll_queues" and it sets
dedicated polling queues for virtio-blk. This patch improves the
polling I/O throughput and latency.

The virtio-blk driver doesn't not have a poll function and a poll
queue and it has been operating in interrupt driven method even if
the polling function is called in the upper layer.

virtio-blk polling is implemented upon 'batched completion' of block
layer. virtblk_poll() queues completed request to io_comp_batch->req_list
and later, virtblk_complete_batch() calls unmap function and ends
the requests in batch.

virtio-blk reads the number of poll queues from module parameter
"poll_queues". If VM sets queue parameter as below,
("num-queues=N" [QEMU property], "poll_queues=M" [module parameter])
It allocates N virtqueues to virtio_blk->vqs[N] and it uses [0..(N-M-1)]
as default queues and [(N-M)..(N-1)] as poll queues. Unlike the default
queues, the poll queues have no callback function.

Regarding HW-SW queue mapping, the default queue mapping uses the
existing method that condsiders MSI irq vector. But the poll queue
doesn't have an irq, so it uses the regular blk-mq cpu mapping.

For verifying the improvement, I did Fio polling I/O performance test
with io_uring engine with the options below.
(io_uring, hipri, randread, direct=1, bs=512, iodepth=64 numjobs=N)
I set 4 vcpu and 4 virtio-blk queues - 2 default queues and 2 poll
queues for VM.

As a result, IOPS and average latency improved about 10%.

Test result:

- Fio io_uring poll without virtio-blk poll support
	-- numjobs=1 : IOPS = 339K, avg latency = 188.33us
	-- numjobs=2 : IOPS = 367K, avg latency = 347.33us
	-- numjobs=4 : IOPS = 383K, avg latency = 682.06us

- Fio io_uring poll with virtio-blk poll support
	-- numjobs=1 : IOPS = 385K, avg latency = 165.94us
	-- numjobs=2 : IOPS = 408K, avg latency = 313.28us
	-- numjobs=4 : IOPS = 424K, avg latency = 613.05us

Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>
Reviewed-by: Christoph Hellwig <hch@lst.de>
Reviewed-by: Max Gurtovoy <mgurtovoy@nvidia.com>
Signed-off-by: Suwan Kim <suwan.kim027@gmail.com>
---
 drivers/block/virtio_blk.c | 106 +++++++++++++++++++++++++++++++++++--
 1 file changed, 103 insertions(+), 3 deletions(-)

diff --git a/drivers/block/virtio_blk.c b/drivers/block/virtio_blk.c
index a8bcf3f664af..957e15b87651 100644
--- a/drivers/block/virtio_blk.c
+++ b/drivers/block/virtio_blk.c
@@ -37,6 +37,10 @@ MODULE_PARM_DESC(num_request_queues,
 		 "0 for no limit. "
 		 "Values > nr_cpu_ids truncated to nr_cpu_ids.");
 
+static unsigned int poll_queues;
+module_param(poll_queues, uint, 0644);
+MODULE_PARM_DESC(poll_queues, "The number of dedicated virtqueues for polling I/O");
+
 static int major;
 static DEFINE_IDA(vd_index_ida);
 
@@ -74,6 +78,7 @@ struct virtio_blk {
 
 	/* num of vqs */
 	int num_vqs;
+	int io_queues[HCTX_MAX_TYPES];
 	struct virtio_blk_vq *vqs;
 };
 
@@ -512,6 +517,7 @@ static int init_vq(struct virtio_blk *vblk)
 	const char **names;
 	struct virtqueue **vqs;
 	unsigned short num_vqs;
+	unsigned int num_poll_vqs;
 	struct virtio_device *vdev = vblk->vdev;
 	struct irq_affinity desc = { 0, };
 
@@ -520,6 +526,7 @@ static int init_vq(struct virtio_blk *vblk)
 				   &num_vqs);
 	if (err)
 		num_vqs = 1;
+
 	if (!err && !num_vqs) {
 		dev_err(&vdev->dev, "MQ advertised but zero queues reported\n");
 		return -EINVAL;
@@ -529,6 +536,17 @@ static int init_vq(struct virtio_blk *vblk)
 			min_not_zero(num_request_queues, nr_cpu_ids),
 			num_vqs);
 
+	num_poll_vqs = min_t(unsigned int, poll_queues, num_vqs - 1);
+
+	vblk->io_queues[HCTX_TYPE_DEFAULT] = num_vqs - num_poll_vqs;
+	vblk->io_queues[HCTX_TYPE_READ] = 0;
+	vblk->io_queues[HCTX_TYPE_POLL] = num_poll_vqs;
+
+	dev_info(&vdev->dev, "%d/%d/%d default/read/poll queues\n",
+				vblk->io_queues[HCTX_TYPE_DEFAULT],
+				vblk->io_queues[HCTX_TYPE_READ],
+				vblk->io_queues[HCTX_TYPE_POLL]);
+
 	vblk->vqs = kmalloc_array(num_vqs, sizeof(*vblk->vqs), GFP_KERNEL);
 	if (!vblk->vqs)
 		return -ENOMEM;
@@ -541,12 +559,18 @@ static int init_vq(struct virtio_blk *vblk)
 		goto out;
 	}
 
-	for (i = 0; i < num_vqs; i++) {
+	for (i = 0; i < num_vqs - num_poll_vqs; i++) {
 		callbacks[i] = virtblk_done;
 		snprintf(vblk->vqs[i].name, VQ_NAME_LEN, "req.%d", i);
 		names[i] = vblk->vqs[i].name;
 	}
 
+	for (; i < num_vqs; i++) {
+		callbacks[i] = NULL;
+		snprintf(vblk->vqs[i].name, VQ_NAME_LEN, "req_poll.%d", i);
+		names[i] = vblk->vqs[i].name;
+	}
+
 	/* Discover virtqueues and write information to configuration.  */
 	err = virtio_find_vqs(vdev, num_vqs, vqs, callbacks, names, &desc);
 	if (err)
@@ -692,16 +716,89 @@ static const struct attribute_group *virtblk_attr_groups[] = {
 static int virtblk_map_queues(struct blk_mq_tag_set *set)
 {
 	struct virtio_blk *vblk = set->driver_data;
+	int i, qoff;
+
+	for (i = 0, qoff = 0; i < set->nr_maps; i++) {
+		struct blk_mq_queue_map *map = &set->map[i];
+
+		map->nr_queues = vblk->io_queues[i];
+		map->queue_offset = qoff;
+		qoff += map->nr_queues;
+
+		if (map->nr_queues == 0)
+			continue;
+
+		/*
+		 * Regular queues have interrupts and hence CPU affinity is
+		 * defined by the core virtio code, but polling queues have
+		 * no interrupts so we let the block layer assign CPU affinity.
+		 */
+		if (i == HCTX_TYPE_POLL)
+			blk_mq_map_queues(&set->map[i]);
+		else
+			blk_mq_virtio_map_queues(&set->map[i], vblk->vdev, 0);
+	}
+
+	return 0;
+}
+
+static void virtblk_complete_batch(struct io_comp_batch *iob)
+{
+	struct request *req;
 
-	return blk_mq_virtio_map_queues(&set->map[HCTX_TYPE_DEFAULT],
-					vblk->vdev, 0);
+	rq_list_for_each(&iob->req_list, req) {
+		virtblk_unmap_data(req, blk_mq_rq_to_pdu(req));
+		virtblk_cleanup_cmd(req);
+	}
+	blk_mq_end_request_batch(iob);
+}
+
+static int virtblk_poll(struct blk_mq_hw_ctx *hctx, struct io_comp_batch *iob)
+{
+	struct virtio_blk *vblk = hctx->queue->queuedata;
+	struct virtio_blk_vq *vq = hctx->driver_data;
+	struct virtblk_req *vbr;
+	unsigned long flags;
+	unsigned int len;
+	int found = 0;
+
+	spin_lock_irqsave(&vq->lock, flags);
+
+	while ((vbr = virtqueue_get_buf(vq->vq, &len)) != NULL) {
+		struct request *req = blk_mq_rq_from_pdu(vbr);
+
+		found++;
+		if (!blk_mq_add_to_batch(req, iob, vbr->status,
+						virtblk_complete_batch))
+			blk_mq_complete_request(req);
+	}
+
+	if (found)
+		blk_mq_start_stopped_hw_queues(vblk->disk->queue, true);
+
+	spin_unlock_irqrestore(&vq->lock, flags);
+
+	return found;
+}
+
+static int virtblk_init_hctx(struct blk_mq_hw_ctx *hctx, void *data,
+			  unsigned int hctx_idx)
+{
+	struct virtio_blk *vblk = data;
+	struct virtio_blk_vq *vq = &vblk->vqs[hctx_idx];
+
+	WARN_ON(vblk->tag_set.tags[hctx_idx] != hctx->tags);
+	hctx->driver_data = vq;
+	return 0;
 }
 
 static const struct blk_mq_ops virtio_mq_ops = {
 	.queue_rq	= virtio_queue_rq,
 	.commit_rqs	= virtio_commit_rqs,
+	.init_hctx	= virtblk_init_hctx,
 	.complete	= virtblk_request_done,
 	.map_queues	= virtblk_map_queues,
+	.poll		= virtblk_poll,
 };
 
 static unsigned int virtblk_queue_depth;
@@ -778,6 +875,9 @@ static int virtblk_probe(struct virtio_device *vdev)
 		sizeof(struct scatterlist) * VIRTIO_BLK_INLINE_SG_CNT;
 	vblk->tag_set.driver_data = vblk;
 	vblk->tag_set.nr_hw_queues = vblk->num_vqs;
+	vblk->tag_set.nr_maps = 1;
+	if (vblk->io_queues[HCTX_TYPE_POLL])
+		vblk->tag_set.nr_maps = 3;
 
 	err = blk_mq_alloc_tag_set(&vblk->tag_set);
 	if (err)
-- 
2.26.3

