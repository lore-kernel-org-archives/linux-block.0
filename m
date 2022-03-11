Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 89EB0C433EF
	for <linux-block@archiver.kernel.org>; Fri, 11 Mar 2022 15:29:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230378AbiCKPaO (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 11 Mar 2022 10:30:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45316 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346160AbiCKPaN (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 11 Mar 2022 10:30:13 -0500
Received: from mail-pj1-x102f.google.com (mail-pj1-x102f.google.com [IPv6:2607:f8b0:4864:20::102f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 27B801BBF75
        for <linux-block@vger.kernel.org>; Fri, 11 Mar 2022 07:29:10 -0800 (PST)
Received: by mail-pj1-x102f.google.com with SMTP id 15-20020a17090a098f00b001bef0376d5cso8408906pjo.5
        for <linux-block@vger.kernel.org>; Fri, 11 Mar 2022 07:29:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=57NOhTMpNENEvLVemQUZurVSM2I6aHGnxhej2brNtRI=;
        b=FAu6uKQE5G6MmcSSROEoqt+9QPjmxkh5GdR/bvhwqqev4iRtuKC5k2icz4MeOYtIaz
         p1v8b5PbvZAxbngmATbE2I8ijpEli956Al6WlTNBcggY8OYvzYLAdUbP2PL6KaP/+TzC
         5Y0Cwz2eIqlwOTZzX+ZH4PRB1wSBPn7eutFFVrvL4CcvhGRlDsUoqzRJLiOOL6HBnEU2
         qlm6l2Q4E59RD7qe5PaGVPxJXRLbYgI+joDrDINUO6IXxlzWZ9EtDfJkfa0IwdAxsSLw
         YIDx7iLsgSTxY3GUlmGVgpgASl12Xv2Ca0wTUZaB96NrZPxnWiYxFasUj8Np8Ah9cpYL
         l3mw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=57NOhTMpNENEvLVemQUZurVSM2I6aHGnxhej2brNtRI=;
        b=ovfcmGkZpGjcPY8NO/0v1AlUxi70JlSC8sFP4uCy2rQoT7dYHKfyEJWavqYr3zlstE
         HFMtePQvJHQwBc413VXOmUloDLuEQZuu4UQcWQ+LzxfQGCvTPOKUu37f7lrm/eGM4Zul
         eaVNkv0xzr7UlmxqNm2hAfJCi3am/EDd741zl/rVsJ1VzrWCtQ+g0Eagy7QFGFxmMJ1R
         PuhMHjfj00zoXsAFz8wDiaFDMTEIBuC9YDIDkTAoPIW51B1Wspi874Gvb5d/4I/7zOrM
         HH7DpXg3lPU+yaHgPCtO8wDHswLnz2TFamLpTy4NQYUMxOB4Tmhp+FKb/5mrze0Fs1+h
         bpTQ==
X-Gm-Message-State: AOAM530/Hbfk/ORhExCl74pW7W73TPeG/tJ9vO3PS30O3oWeYxdgYCtq
        ZMFk8XrJaIK1N12Z3G8nWeQ=
X-Google-Smtp-Source: ABdhPJw+V2CBB6NMo8X9qxQ+LTTdjSfoatrRQSEjftd4bFl/ggxKDwhEELu+fZ0m6QIwSPYCiahpkQ==
X-Received: by 2002:a17:902:e54c:b0:151:e2f3:9ee7 with SMTP id n12-20020a170902e54c00b00151e2f39ee7mr10969297plf.61.1647012549602;
        Fri, 11 Mar 2022 07:29:09 -0800 (PST)
Received: from localhost.localdomain ([114.200.4.15])
        by smtp.googlemail.com with ESMTPSA id lb4-20020a17090b4a4400b001b9b20eabc4sm10457663pjb.5.2022.03.11.07.29.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 11 Mar 2022 07:29:08 -0800 (PST)
From:   Suwan Kim <suwan.kim027@gmail.com>
To:     mst@redhat.com, jasowang@redhat.com, pbonzini@redhat.com,
        stefanha@redhat.com
Cc:     virtualization@lists.linux-foundation.org,
        linux-block@vger.kernel.org, Suwan Kim <suwan.kim027@gmail.com>
Subject: [PATCH] virtio-blk: support polling I/O
Date:   Sat, 12 Mar 2022 00:28:32 +0900
Message-Id: <20220311152832.17703-1-suwan.kim027@gmail.com>
X-Mailer: git-send-email 2.26.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

This patch supports polling I/O via virtio-blk driver. Polling
feature is enabled based on "VIRTIO_BLK_F_MQ" feature and the number
of polling queues can be set by QEMU virtio-blk-pci property
"num-poll-queues=N". This patch improves the polling I/O throughput
and latency.

The virtio-blk driver doesn't not have a poll function and a poll
queue and it has been operating in interrupt driven method even if
the polling function is called in the upper layer.

virtio-blk polling is implemented upon 'batched completion' of block
layer. virtblk_poll() queues completed request to io_comp_batch->req_list
and later, virtblk_complete_batch() calls unmap function and ends
the requests in batch.

virtio-blk reads the number of queues and poll queues from QEMU
virtio-blk-pci properties ("num-queues=N", "num-poll-queues=M").
It allocates N virtqueues to virtio_blk->vqs[N] and it uses [0..(N-M-1)]
as default queues and [(N-M)..(N-1)] as poll queues. Unlike the default
queues, the poll queues have no callback function.

Regarding HW-SW queue mapping, the default queue mapping uses the
existing method that condsiders MSI irq vector. But the poll queue
doesn't have an irq, so it uses the regular blk-mq cpu mapping.

To enable poll queues, "num-poll-queues=N" property of virtio-blk-pci
needs to be added to QEMU command line. For that, I temporarily
implemented the property on QEMU. Please refer to the git repository below.

	git : https://github.com/asfaca/qemu.git #on master branch commit

For verifying the improvement, I did Fio polling I/O performance test
with io_uring engine with the options below.
(io_uring, hipri, randread, direct=1, bs=512, iodepth=64 numjobs=N)
I set 4 vcpu and 4 virtio-blk queues - 2 default queues and 2 poll
queues for VM.
(-device virtio-blk-pci,num-queues=4,num-poll-queues=2)
As a result, IOPS and average latency improved about 10%.

Test result:

- Fio io_uring poll without virtio-blk poll support
	-- numjobs=1 : IOPS = 297K, avg latency = 214.59us
	-- numjobs=2 : IOPS = 360K, avg latency = 363.88us
	-- numjobs=4 : IOPS = 289K, avg latency = 885.42us

- Fio io_uring poll with virtio-blk poll support
	-- numjobs=1 : IOPS = 332K, avg latency = 192.61us
	-- numjobs=2 : IOPS = 371K, avg latency = 348.31us
	-- numjobs=4 : IOPS = 321K, avg latency = 795.93us

Signed-off-by: Suwan Kim <suwan.kim027@gmail.com>
---
 drivers/block/virtio_blk.c      | 98 +++++++++++++++++++++++++++++++--
 include/uapi/linux/virtio_blk.h |  3 +-
 2 files changed, 96 insertions(+), 5 deletions(-)

diff --git a/drivers/block/virtio_blk.c b/drivers/block/virtio_blk.c
index 8c415be86732..bfde7d97d528 100644
--- a/drivers/block/virtio_blk.c
+++ b/drivers/block/virtio_blk.c
@@ -81,6 +81,7 @@ struct virtio_blk {
 
 	/* num of vqs */
 	int num_vqs;
+	int io_queues[HCTX_MAX_TYPES];
 	struct virtio_blk_vq *vqs;
 };
 
@@ -548,6 +549,7 @@ static int init_vq(struct virtio_blk *vblk)
 	const char **names;
 	struct virtqueue **vqs;
 	unsigned short num_vqs;
+	unsigned short num_poll_vqs;
 	struct virtio_device *vdev = vblk->vdev;
 	struct irq_affinity desc = { 0, };
 
@@ -556,6 +558,13 @@ static int init_vq(struct virtio_blk *vblk)
 				   &num_vqs);
 	if (err)
 		num_vqs = 1;
+
+	err = virtio_cread_feature(vdev, VIRTIO_BLK_F_MQ,
+				struct virtio_blk_config, num_poll_queues,
+				&num_poll_vqs);
+	if (err)
+		num_poll_vqs = 0;
+
 	if (!err && !num_vqs) {
 		dev_err(&vdev->dev, "MQ advertised but zero queues reported\n");
 		return -EINVAL;
@@ -565,6 +574,13 @@ static int init_vq(struct virtio_blk *vblk)
 			min_not_zero(num_request_queues, nr_cpu_ids),
 			num_vqs);
 
+	num_poll_vqs = min_t(unsigned int, num_poll_vqs, num_vqs - 1);
+
+	memset(vblk->io_queues, 0, sizeof(int) * HCTX_MAX_TYPES);
+	vblk->io_queues[HCTX_TYPE_DEFAULT] = num_vqs - num_poll_vqs;
+	vblk->io_queues[HCTX_TYPE_READ] = 0;
+	vblk->io_queues[HCTX_TYPE_POLL] = num_poll_vqs;
+
 	vblk->vqs = kmalloc_array(num_vqs, sizeof(*vblk->vqs), GFP_KERNEL);
 	if (!vblk->vqs)
 		return -ENOMEM;
@@ -578,8 +594,13 @@ static int init_vq(struct virtio_blk *vblk)
 	}
 
 	for (i = 0; i < num_vqs; i++) {
-		callbacks[i] = virtblk_done;
-		snprintf(vblk->vqs[i].name, VQ_NAME_LEN, "req.%d", i);
+		if (i < num_vqs - num_poll_vqs) {
+			callbacks[i] = virtblk_done;
+			snprintf(vblk->vqs[i].name, VQ_NAME_LEN, "req.%d", i);
+		} else {
+			callbacks[i] = NULL;
+			snprintf(vblk->vqs[i].name, VQ_NAME_LEN, "req_poll.%d", i);
+		}
 		names[i] = vblk->vqs[i].name;
 	}
 
@@ -728,16 +749,82 @@ static const struct attribute_group *virtblk_attr_groups[] = {
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
+		if (i == HCTX_TYPE_DEFAULT)
+			blk_mq_virtio_map_queues(&set->map[i], vblk->vdev, 0);
+		else
+			blk_mq_map_queues(&set->map[i]);
+	}
+
+	return 0;
+}
+
+static void virtblk_complete_batch(struct io_comp_batch *iob)
+{
+	struct request *req;
+	struct virtblk_req *vbr;
 
-	return blk_mq_virtio_map_queues(&set->map[HCTX_TYPE_DEFAULT],
-					vblk->vdev, 0);
+	rq_list_for_each(&iob->req_list, req) {
+		vbr = blk_mq_rq_to_pdu(req);
+		virtblk_unmap_data(req, vbr);
+		virtblk_cleanup_cmd(req);
+	}
+	blk_mq_end_request_batch(iob);
+}
+
+static int virtblk_poll(struct blk_mq_hw_ctx *hctx, struct io_comp_batch *iob)
+{
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
+		if (!blk_mq_add_to_batch(req, iob, virtblk_result(vbr),
+						virtblk_complete_batch))
+			blk_mq_complete_request(req);
+	}
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
@@ -816,6 +903,9 @@ static int virtblk_probe(struct virtio_device *vdev)
 		sizeof(struct scatterlist) * VIRTIO_BLK_INLINE_SG_CNT;
 	vblk->tag_set.driver_data = vblk;
 	vblk->tag_set.nr_hw_queues = vblk->num_vqs;
+	vblk->tag_set.nr_maps = 1;
+	if (vblk->io_queues[HCTX_TYPE_POLL])
+		vblk->tag_set.nr_maps = 3;
 
 	err = blk_mq_alloc_tag_set(&vblk->tag_set);
 	if (err)
diff --git a/include/uapi/linux/virtio_blk.h b/include/uapi/linux/virtio_blk.h
index d888f013d9ff..3fcaf937afe1 100644
--- a/include/uapi/linux/virtio_blk.h
+++ b/include/uapi/linux/virtio_blk.h
@@ -119,8 +119,9 @@ struct virtio_blk_config {
 	 * deallocation of one or more of the sectors.
 	 */
 	__u8 write_zeroes_may_unmap;
+	__u8 unused1;
 
-	__u8 unused1[3];
+	__virtio16 num_poll_queues;
 } __attribute__((packed));
 
 /*
-- 
2.26.3

