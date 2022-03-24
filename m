Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 264FFC433F5
	for <linux-block@archiver.kernel.org>; Thu, 24 Mar 2022 14:05:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344334AbiCXOHK (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 24 Mar 2022 10:07:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55160 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231871AbiCXOHJ (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 24 Mar 2022 10:07:09 -0400
Received: from mail-pl1-x635.google.com (mail-pl1-x635.google.com [IPv6:2607:f8b0:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1E0F86CA63
        for <linux-block@vger.kernel.org>; Thu, 24 Mar 2022 07:05:37 -0700 (PDT)
Received: by mail-pl1-x635.google.com with SMTP id y6so2248990plg.2
        for <linux-block@vger.kernel.org>; Thu, 24 Mar 2022 07:05:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=u9NKBaWZds0RIS9nv+EyJu20fE5vPp3DVac/rH4x2sU=;
        b=KBNiUWKmOhhW+kSkvmVauw2dPX8HY7bYI+QcYNaakM9XaRMRlr+RpemsSJQ1l0+UFG
         biSY6TOrmNe0gBSMDPHM5fseqHUbTQnOS2YFxNoGbKPh2NUEJEu1yZWrYgj3oTqiPOOV
         25oCkWPCF9+4YaiHb4GsbarLWizLyABT+ur8hY4ISK5jTCtPAekp598c+Bzbg65K9d8i
         H2A5u4QDul9TKbCRvNg6Ntedq8dWK3R/zIywTdo7VjRbRmaTgAwaUBSXs4suwZdeeMFw
         aRyoZpfCOhXH45sSqJ+IEGMh7isRabFSdYCwg8O46AxtGcZ99qSFDpfPgdfX2/W5ijIl
         cQ7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=u9NKBaWZds0RIS9nv+EyJu20fE5vPp3DVac/rH4x2sU=;
        b=lcE9+DWVDj2LLi4RizjmBbZoS8hFF1Uq+ueShvXVBpMC72lDrfhFafTgodej5CgfPL
         7KNTlCKSr8aP91lsauksThBtNbfapN1XJpzmHgCrfZua0Dqxc5VgkSPZAHW8XAz4DmA6
         7ePFAwZcr9WL7q/RadBd5yXzAlh6fjzaUelawmLMOzzGzQIpzRHpnwaTRRBFRiy463z1
         TNSIXh4QVY7MOkVHA8gXCtNch+Sg4jye6MFjBwMU4PpwboWbBtYAUydBjKkUD7Li1tm8
         NsT4pcKV3+4Dtl8MRu1nE2Qajb3FdWvhU+WZ84bIpuACtLQnkJLrm93KDfAEo1ZGT85H
         YGXQ==
X-Gm-Message-State: AOAM533K2ZqhtTSkfwS0wKWPvWrXQ5LnhPFHT8xXxYpKP++zjFmB8UwA
        U22VcjAwqqU05zDephSvSvBEDc2lSHwQnw==
X-Google-Smtp-Source: ABdhPJw3Ni+KJ63WvOlcO5Yx5kJqLa5aQDXyvXny86PZU6L9FfkZxfuKx2A7aWzMyIbTy6bnQ8Z8mQ==
X-Received: by 2002:a17:902:ba8c:b0:14f:d9b7:ab4 with SMTP id k12-20020a170902ba8c00b0014fd9b70ab4mr6109036pls.23.1648130736552;
        Thu, 24 Mar 2022 07:05:36 -0700 (PDT)
Received: from localhost.localdomain ([114.200.4.15])
        by smtp.googlemail.com with ESMTPSA id u12-20020a17090a890c00b001b8efcf8e48sm9441845pjn.14.2022.03.24.07.05.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Mar 2022 07:05:35 -0700 (PDT)
From:   Suwan Kim <suwan.kim027@gmail.com>
To:     mst@redhat.com, jasowang@redhat.com, stefanha@redhat.com,
        pbonzini@redhat.com, mgurtovoy@nvidia.com
Cc:     virtualization@lists.linux-foundation.org,
        linux-block@vger.kernel.org, Suwan Kim <suwan.kim027@gmail.com>,
        kernel test robot <lkp@intel.com>
Subject: [PATCH v3 1/2] virtio-blk: support polling I/O
Date:   Thu, 24 Mar 2022 23:04:49 +0900
Message-Id: <20220324140450.33148-2-suwan.kim027@gmail.com>
X-Mailer: git-send-email 2.26.3
In-Reply-To: <20220324140450.33148-1-suwan.kim027@gmail.com>
References: <20220324140450.33148-1-suwan.kim027@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

This patch supports polling I/O via virtio-blk driver. Polling
feature is enabled by module parameter "num_poll_queues" and it
sets dedicated polling queues for virtio-blk. This patch improves
the polling I/O throughput and latency.

The virtio-blk driver doesn't not have a poll function and a poll
queue and it has been operating in interrupt driven method even if
the polling function is called in the upper layer.

virtio-blk polling is implemented upon 'batched completion' of block
layer. virtblk_poll() queues completed request to io_comp_batch->req_list
and later, virtblk_complete_batch() calls unmap function and ends
the requests in batch.

virtio-blk reads the number of poll queues from module parameter
"num_poll_queues". If VM sets queue parameter as below,
("num-queues=N" [QEMU property], "num_poll_queues=M" [module parameter])
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
	-- numjobs=1 : IOPS = 380K, avg latency = 167.87us
	-- numjobs=2 : IOPS = 409K, avg latency = 312.6us
	-- numjobs=4 : IOPS = 413K, avg latency = 619.72us

Reported-by: kernel test robot <lkp@intel.com>
Signed-off-by: Suwan Kim <suwan.kim027@gmail.com>
---
 drivers/block/virtio_blk.c | 101 +++++++++++++++++++++++++++++++++++--
 1 file changed, 97 insertions(+), 4 deletions(-)

diff --git a/drivers/block/virtio_blk.c b/drivers/block/virtio_blk.c
index 8c415be86732..3d16f8b753e7 100644
--- a/drivers/block/virtio_blk.c
+++ b/drivers/block/virtio_blk.c
@@ -37,6 +37,10 @@ MODULE_PARM_DESC(num_request_queues,
 		 "0 for no limit. "
 		 "Values > nr_cpu_ids truncated to nr_cpu_ids.");
 
+static unsigned int num_poll_queues;
+module_param(num_poll_queues, uint, 0644);
+MODULE_PARM_DESC(num_poll_queues, "The number of dedicated virtqueues for polling I/O");
+
 static int major;
 static DEFINE_IDA(vd_index_ida);
 
@@ -81,6 +85,7 @@ struct virtio_blk {
 
 	/* num of vqs */
 	int num_vqs;
+	int io_queues[HCTX_MAX_TYPES];
 	struct virtio_blk_vq *vqs;
 };
 
@@ -548,6 +553,7 @@ static int init_vq(struct virtio_blk *vblk)
 	const char **names;
 	struct virtqueue **vqs;
 	unsigned short num_vqs;
+	unsigned int num_poll_vqs;
 	struct virtio_device *vdev = vblk->vdev;
 	struct irq_affinity desc = { 0, };
 
@@ -556,6 +562,7 @@ static int init_vq(struct virtio_blk *vblk)
 				   &num_vqs);
 	if (err)
 		num_vqs = 1;
+
 	if (!err && !num_vqs) {
 		dev_err(&vdev->dev, "MQ advertised but zero queues reported\n");
 		return -EINVAL;
@@ -565,6 +572,13 @@ static int init_vq(struct virtio_blk *vblk)
 			min_not_zero(num_request_queues, nr_cpu_ids),
 			num_vqs);
 
+	num_poll_vqs = min_t(unsigned int, num_poll_queues, num_vqs - 1);
+
+	memset(vblk->io_queues, 0, sizeof(int) * HCTX_MAX_TYPES);
+	vblk->io_queues[HCTX_TYPE_DEFAULT] = num_vqs - num_poll_vqs;
+	vblk->io_queues[HCTX_TYPE_READ] = 0;
+	vblk->io_queues[HCTX_TYPE_POLL] = num_poll_vqs;
+
 	vblk->vqs = kmalloc_array(num_vqs, sizeof(*vblk->vqs), GFP_KERNEL);
 	if (!vblk->vqs)
 		return -ENOMEM;
@@ -578,8 +592,13 @@ static int init_vq(struct virtio_blk *vblk)
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
 
@@ -728,16 +747,87 @@ static const struct attribute_group *virtblk_attr_groups[] = {
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
+		if (!blk_mq_add_to_batch(req, iob, vbr->status,
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
@@ -816,6 +906,9 @@ static int virtblk_probe(struct virtio_device *vdev)
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

