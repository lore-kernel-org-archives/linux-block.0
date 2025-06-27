Received: from mail-yw1-f227.google.com (mail-yw1-f227.google.com [209.85.128.227])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E75E61E1E0B
	for <linux-block@vger.kernel.org>; Fri, 27 Jun 2025 06:59:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.227
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751007601; cv=none; b=u2+SdcQlkN5IKz/qQoa3rE+8kQYeF/LfgZ+jHwHWcyuZheJQV7Yie01keCOEl6lDfxaybsF1Nsu+vFRqQYqnxgvjd3snnc3jZ4EuKdkRBGC1pnLzniWGl+e4mYD/El096FVOWlw1ddwVUiq4wdQuaA9FnJ42c28BAA7XEhaMikM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751007601; c=relaxed/simple;
	bh=igfJ9dcNy7yl+6M0DHoQAEqgAUXvSjiwxXAeRtjM1UU=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=DiHTY0n2HGig3XF1uw68e502SccIcimvmHrntwdCXU+8P5qW9WlIsZmq8li7YJ0Z+IjJ8Z5Tvcf8QiVAnc3Ptfxoz+kBSDBiaWwjDEKDPi5IERnEffg+V218bmfcYitxpm4eP+pXcluGBXXA2TfsR2KgNOpvHPfkJ2eo0+n3obs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=purestorage.com; spf=fail smtp.mailfrom=purestorage.com; dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b=HyYS1SAm; arc=none smtp.client-ip=209.85.128.227
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=purestorage.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=purestorage.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b="HyYS1SAm"
Received: by mail-yw1-f227.google.com with SMTP id 00721157ae682-710bbd7a9e2so18057347b3.0
        for <linux-block@vger.kernel.org>; Thu, 26 Jun 2025 23:59:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=purestorage.com; s=google2022; t=1751007598; x=1751612398; darn=vger.kernel.org;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=pnhLlzEyv+kz605EYROvtexx+qx2Y85pLkvfpuaKUrs=;
        b=HyYS1SAmb9lf3SHrko1n1Awo3u+bRP3HQF0hnVAISB/C7nVoMIK8VIbyDxjsV5aXFz
         SOlydhIMg5nfJIYxG3jhHCTKhXxl/MgVKE0k8keF9+v1+GArjQgHUsC0E+2v4PB/+OSD
         nliATsgWFI/0VeV90Nqf/96ecHxd/o9CH1sojRTueElVjlttHnDEmry1FFOtLGZMbm+O
         8lb4yaY1S9UpFTkNdR+Pzu6YnG11OzWfVKzDUhXK966285LAiFlgR5Fmtv9OPKFMLpjE
         kj5PKYIXz8xad7ME2vgVKUzhHM2zsdBwpfCEebkz3hyFtXAP390YMQbt9C5hdvITxmkH
         fHZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751007598; x=1751612398;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=pnhLlzEyv+kz605EYROvtexx+qx2Y85pLkvfpuaKUrs=;
        b=hBHn7NAApgJCALGKl8P18Tr8fWGIKQBIZXubmP7710ZlyhsEEYMCpnjTX9EJ/35PhD
         4wkoAEs1RvfP1tr3mArLjYkfSKrpYesNqp5EH2kdjr8RWaYpGuTfywhRz4WwivDofHCd
         yYQ4ShyTGk+TkKcMX2jP4cx5baF8QQ5KnbjH5QWMpkfu/Q99CSgYRByfAf0hUtnLcqiH
         pQ2jXfowRPhJOl9JS8dOF6n+z6kUTgCrDC2sHgyrdNguvYYp6Yr3bNwW4+ZtQBDjT35y
         DYJyNDzqIw6MYtneOS8RM30fm2MqTUmI0FqPs5M2HyXaLm/DFWv2orkbNpBy/K38mwW+
         vpdg==
X-Gm-Message-State: AOJu0Yzzodr6krb64xkhSxhY+zmWh0U7pH+tiDanx9+LudtL1daZmoSk
	cCn81OpMIdTS4Tw3I9vggFFQ/41zB7DIwCwraYlDrbcY0Nf69Y+xFV1JkNk7aBA6LLghmtKxrzN
	qR/pW5NfnUqnhqFpAz8GzN8Q8zJEe78Ub66gj
X-Gm-Gg: ASbGncsPjiRmXUWiszNTELr+w3cE97wHlVccCF+wg8j2Epss+7fMNPWtgB+w5WwrX9r
	zaGOHvxSJwL8LgR6fTlpbJZzNlw67TJ7NlW1bFXetHRUUsUUO/uB4mELjENAJp2ZzlBw9G7T6UG
	0VW3G7CEzRrY9fKWo2jyQLbruNuiQWmBWQv+sHoWPzI3GpO62JUGm6SgTIOFZ/CvOfXIfRg2PA0
	RWNSF84NkJxlc8X/5tcfpxeHGn/lBIbEemfhJQGN/iBFKVVNCfGaFzBLDu9bOne0LAgjS6DhTFq
	AL1oM4eujqzMVwAeDlvZVcwZTMkcz+XqivOW5bsm7Cv75/QuCCxzqNf3
X-Google-Smtp-Source: AGHT+IHEKTtooYBK9qKZ+5oTJpS8gwlX0JD0y7a1Gs2e3vKQWrZUWFRQ3anfzvQp4gs4iquMuuFIm8WAuZMb
X-Received: by 2002:a05:690c:318:b0:712:cc11:aed with SMTP id 00721157ae682-715171383e0mr34689757b3.2.1751007597912;
        Thu, 26 Jun 2025 23:59:57 -0700 (PDT)
Received: from c7-smtp-2023.dev.purestorage.com ([208.88.159.129])
        by smtp-relay.gmail.com with ESMTPS id 00721157ae682-71515cd2453sm588637b3.52.2025.06.26.23.59.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 Jun 2025 23:59:57 -0700 (PDT)
X-Relaying-Domain: purestorage.com
Received: from dev-ushankar.dev.purestorage.com (dev-ushankar.dev.purestorage.com [IPv6:2620:125:9007:640:7:70:36:0])
	by c7-smtp-2023.dev.purestorage.com (Postfix) with ESMTP id 4C168340344;
	Fri, 27 Jun 2025 00:59:56 -0600 (MDT)
Received: by dev-ushankar.dev.purestorage.com (Postfix, from userid 1557716368)
	id 56608E41349; Fri, 27 Jun 2025 00:59:56 -0600 (MDT)
From: Uday Shankar <ushankar@purestorage.com>
Date: Fri, 27 Jun 2025 00:59:47 -0600
Subject: [PATCH] ublk: speed up ublk server exit handling
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250627-ublk_too_many_quiesce-v1-1-55ef9d80a6af@purestorage.com>
X-B4-Tracking: v=1; b=H4sIAGJBXmgC/x3MQQ5AMBBA0avIrDWhqHAVkYYaTNDSIkTcXWP5F
 +8/4NASOiiDByye5MhoH3EYgBobPSCjzjfwiGeR4Dk72nmSuzFyafQtt8NjhaxI8k6oRChMBXi
 7Wuzp+r9V/b4ffnV5XmcAAAA=
X-Change-ID: 20250627-ublk_too_many_quiesce-937d6c36ce46
To: Ming Lei <ming.lei@redhat.com>, Jens Axboe <axboe@kernel.dk>, 
 Caleb Sander Mateos <csander@purestorage.com>
Cc: linux-block@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Uday Shankar <ushankar@purestorage.com>
X-Mailer: b4 0.14.2

Recently, we've observed a few cases where a ublk server is able to
complete restart more quickly than the driver can process the exit of
the previous ublk server. The new ublk server comes up, attempts
recovery of the preexisting ublk devices, and observes them still in
state UBLK_S_DEV_LIVE. While this is possible due to the asynchronous
nature of io_uring cleanup and should therefore be handled properly in
the ublk server, it is still preferable to make ublk server exit
handling faster if possible, as we should strive for it to not be a
limiting factor in how fast a ublk server can restart and provide
service again.

Analysis of the issue showed that the vast majority of the time spent in
handling the ublk server exit was in calls to blk_mq_quiesce_queue,
which is essentially just a (relatively expensive) call to
synchronize_rcu. The ublk server exit path currently issues an
unnecessarily large number of calls to blk_mq_quiesce_queue, for two
reasons:

1. It tries to call blk_mq_quiesce_queue once per ublk_queue. However,
   blk_mq_quiesce_queue targets the request_queue of the underlying ublk
   device, of which there is only one. So the number of calls is larger
   than necessary by a factor of nr_hw_queues.
2. In practice, it calls blk_mq_quiesce_queue _more_ than once per
   ublk_queue. This is because of a data race where we read
   ubq->canceling without any locking when deciding if we should call
   ublk_start_cancel. It is thus possible for two calls to
   ublk_uring_cmd_cancel_fn against the same ublk_queue to both call
   ublk_start_cancel against the same ublk_queue.

Fix this by making the "canceling" flag a per-device state. This
actually matches the existing code better, as there are several places
where the flag is set or cleared for all queues simultaneously, and
there is the general expectation that cancellation corresponds with ublk
server exit. This also has negligible performance impact since the flag
is readonly and always false in the hot path. This per-device canceling
flag is then checked under a (new) lock (addressing the data race (2)
above), and the queue is only quiesced if it is cleared (addressing (1)
above). The result is just one call to blk_mq_quiesce_queue per ublk
device.

In our setup, where one ublk server handles I/O for 128 ublk devices,
each having 24 hardware queues of depth 4096, here are the results
before and after this patch, where teardown time is measured from the
first call to io_ring_ctx_wait_and_kill to the return from the last
ublk_ch_release:

						before		after
number of calls to blk_mq_quiesce_queue:	6469		256
teardown time:					11.14s		2.44s

There are still some potential optimizations here, but this takes care
of a big chunk of the ublk server exit handling delay.

Signed-off-by: Uday Shankar <ushankar@purestorage.com>
---
 drivers/block/ublk_drv.c | 54 +++++++++++++++++++++---------------------------
 1 file changed, 23 insertions(+), 31 deletions(-)

diff --git a/drivers/block/ublk_drv.c b/drivers/block/ublk_drv.c
index 740141c63a93797c45ee8514ef779ab3ff06939f..f6635553d9a3fb309f4c1fb64503736c292f2f3e 100644
--- a/drivers/block/ublk_drv.c
+++ b/drivers/block/ublk_drv.c
@@ -198,7 +198,6 @@ struct ublk_queue {
 	struct ublksrv_io_desc *io_cmd_buf;
 
 	bool force_abort;
-	bool canceling;
 	bool fail_io; /* copy of dev->state == UBLK_S_DEV_FAIL_IO */
 	unsigned short nr_io_ready;	/* how many ios setup */
 	spinlock_t		cancel_lock;
@@ -235,6 +234,8 @@ struct ublk_device {
 	struct completion	completion;
 	unsigned int		nr_queues_ready;
 	unsigned int		nr_privileged_daemon;
+	struct mutex cancel_mutex;
+	bool canceling;
 };
 
 /* header of ublk_params */
@@ -1388,7 +1389,7 @@ static blk_status_t ublk_prep_req(struct ublk_queue *ubq, struct request *rq,
 	if (ublk_nosrv_should_queue_io(ubq) && unlikely(ubq->force_abort))
 		return BLK_STS_IOERR;
 
-	if (check_cancel && unlikely(ubq->canceling))
+	if (check_cancel && unlikely(ubq->dev->canceling))
 		return BLK_STS_IOERR;
 
 	/* fill iod to slot in io cmd buffer */
@@ -1416,7 +1417,7 @@ static blk_status_t ublk_queue_rq(struct blk_mq_hw_ctx *hctx,
 	 * is dealt with, otherwise this request may not be failed in case
 	 * of recovery, and cause hang when deleting disk
 	 */
-	if (unlikely(ubq->canceling)) {
+	if (unlikely(ubq->dev->canceling)) {
 		__ublk_abort_rq(ubq, rq);
 		return BLK_STS_OK;
 	}
@@ -1573,12 +1574,9 @@ static int ublk_ch_release(struct inode *inode, struct file *filp)
 	 * All requests may be inflight, so ->canceling may not be set, set
 	 * it now.
 	 */
-	for (i = 0; i < ub->dev_info.nr_hw_queues; i++) {
-		struct ublk_queue *ubq = ublk_get_queue(ub, i);
-
-		ubq->canceling = true;
-		ublk_abort_queue(ub, ubq);
-	}
+	ub->canceling = true;
+	for (i = 0; i < ub->dev_info.nr_hw_queues; i++)
+		ublk_abort_queue(ub, ublk_get_queue(ub, i));
 	blk_mq_kick_requeue_list(disk->queue);
 
 	/*
@@ -1701,23 +1699,17 @@ static void ublk_abort_queue(struct ublk_device *ub, struct ublk_queue *ubq)
 	}
 }
 
-/* Must be called when queue is frozen */
-static void ublk_mark_queue_canceling(struct ublk_queue *ubq)
-{
-	spin_lock(&ubq->cancel_lock);
-	if (!ubq->canceling)
-		ubq->canceling = true;
-	spin_unlock(&ubq->cancel_lock);
-}
-
-static void ublk_start_cancel(struct ublk_queue *ubq)
+static void ublk_start_cancel(struct ublk_device *ub)
 {
-	struct ublk_device *ub = ubq->dev;
 	struct gendisk *disk = ublk_get_disk(ub);
 
 	/* Our disk has been dead */
 	if (!disk)
 		return;
+
+	mutex_lock(&ub->cancel_mutex);
+	if (ub->canceling)
+		goto out;
 	/*
 	 * Now we are serialized with ublk_queue_rq()
 	 *
@@ -1726,8 +1718,10 @@ static void ublk_start_cancel(struct ublk_queue *ubq)
 	 * touch completed uring_cmd
 	 */
 	blk_mq_quiesce_queue(disk->queue);
-	ublk_mark_queue_canceling(ubq);
+	ub->canceling = true;
 	blk_mq_unquiesce_queue(disk->queue);
+out:
+	mutex_unlock(&ub->cancel_mutex);
 	ublk_put_disk(disk);
 }
 
@@ -1800,8 +1794,7 @@ static void ublk_uring_cmd_cancel_fn(struct io_uring_cmd *cmd,
 	if (WARN_ON_ONCE(task && task != io->task))
 		return;
 
-	if (!ubq->canceling)
-		ublk_start_cancel(ubq);
+	ublk_start_cancel(ubq->dev);
 
 	WARN_ON_ONCE(io->cmd != cmd);
 	ublk_cancel_cmd(ubq, pdu->tag, issue_flags);
@@ -1925,9 +1918,9 @@ static void ublk_reset_io_flags(struct ublk_device *ub)
 		for (j = 0; j < ubq->q_depth; j++)
 			ubq->ios[j].flags &= ~UBLK_IO_FLAG_CANCELED;
 		spin_unlock(&ubq->cancel_lock);
-		ubq->canceling = false;
 		ubq->fail_io = false;
 	}
+	ub->canceling = false;
 }
 
 /* device can only be started after all IOs are ready */
@@ -2626,6 +2619,7 @@ static void ublk_cdev_rel(struct device *dev)
 	ublk_deinit_queues(ub);
 	ublk_free_dev_number(ub);
 	mutex_destroy(&ub->mutex);
+	mutex_destroy(&ub->cancel_mutex);
 	kfree(ub);
 }
 
@@ -2977,6 +2971,7 @@ static int ublk_ctrl_add_dev(const struct ublksrv_ctrl_cmd *header)
 		goto out_unlock;
 	mutex_init(&ub->mutex);
 	spin_lock_init(&ub->lock);
+	mutex_init(&ub->cancel_mutex);
 
 	ret = ublk_alloc_dev_number(ub, header->dev_id);
 	if (ret < 0)
@@ -3048,6 +3043,7 @@ static int ublk_ctrl_add_dev(const struct ublksrv_ctrl_cmd *header)
 	ublk_free_dev_number(ub);
 out_free_ub:
 	mutex_destroy(&ub->mutex);
+	mutex_destroy(&ub->cancel_mutex);
 	kfree(ub);
 out_unlock:
 	mutex_unlock(&ublk_ctl_mutex);
@@ -3385,7 +3381,7 @@ static int ublk_ctrl_quiesce_dev(struct ublk_device *ub,
 	/* zero means wait forever */
 	u64 timeout_ms = header->data[0];
 	struct gendisk *disk;
-	int i, ret = -ENODEV;
+	int ret = -ENODEV;
 
 	if (!(ub->dev_info.flags & UBLK_F_QUIESCE))
 		return -EOPNOTSUPP;
@@ -3402,13 +3398,9 @@ static int ublk_ctrl_quiesce_dev(struct ublk_device *ub,
 	if (ub->dev_info.state != UBLK_S_DEV_LIVE)
 		goto put_disk;
 
-	/* Mark all queues as canceling */
+	/* Mark the device as canceling */
 	blk_mq_quiesce_queue(disk->queue);
-	for (i = 0; i < ub->dev_info.nr_hw_queues; i++) {
-		struct ublk_queue *ubq = ublk_get_queue(ub, i);
-
-		ubq->canceling = true;
-	}
+	ub->canceling = true;
 	blk_mq_unquiesce_queue(disk->queue);
 
 	if (!timeout_ms)

---
base-commit: 456ef6804f232f3b2f60147046e05500147b0099
change-id: 20250627-ublk_too_many_quiesce-937d6c36ce46

Best regards,
-- 
Uday Shankar <ushankar@purestorage.com>

