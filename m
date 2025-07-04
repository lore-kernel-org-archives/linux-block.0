Received: from mail-pf1-f228.google.com (mail-pf1-f228.google.com [209.85.210.228])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7689F205E02
	for <linux-block@vger.kernel.org>; Fri,  4 Jul 2025 05:41:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.228
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751607677; cv=none; b=u9vwPcA/GAiF9SJH6EOLEzx6hhVFw8CRNAhwMWG3xSKWZ9yZZe9sLJTfOUrdC1TLwGVU7pRl/CDo4kfQecPaRRhSezmYSEiJeNFrMcVoYKNkSyXfqqaHRGAV+I+Z4ldjHn0uAtjA16vqPdq/SZBJDKFPylF4hSVoZL7suoBFMoI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751607677; c=relaxed/simple;
	bh=2Dd28795FUE8YHDc6682PsWrxXELhttu0Ozs3kI2PdQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=EtH6bUTc8JkbecaWeaDO/ed0E4gGzvBFx9CapxsKWmQpPEqMKcVoBnZri1aNpExqh/WiigoVk0WF9hBn2x8Z+Gyswr1ffZAQhGVYWpGmQpuvGx2co59ixWMdqlb9RQ7Pivi3zgG28FAYNuyer8XDwAWzIpTr1VKlV0nF0C+qVaA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=purestorage.com; spf=fail smtp.mailfrom=purestorage.com; dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b=XWcyVBVF; arc=none smtp.client-ip=209.85.210.228
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=purestorage.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=purestorage.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b="XWcyVBVF"
Received: by mail-pf1-f228.google.com with SMTP id d2e1a72fcca58-74b27c1481bso426791b3a.2
        for <linux-block@vger.kernel.org>; Thu, 03 Jul 2025 22:41:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=purestorage.com; s=google2022; t=1751607674; x=1752212474; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=LOFLRp9gWDwkX5ICgEE7QkHKMv3HtRkDH0i8aXPgtVk=;
        b=XWcyVBVFA2b4/LgmGAgfDKU998Ta2pW7R/EtfpomqEAeTNgjTqvlmfmEogwzlos1CY
         c/KQuK/G+HCFOlwnJFWNLhKBYFcnHJ5AhmmIkR6B4twaR5panAJ4ABX64U4f3bsW19Fs
         Bm0uPyV/PZRtdxDW4qisEnwKosHXdoashMUZGjaAR0nWbABfgBl3xgURF7pHVGMXcoGP
         WqUCeoQDUWaAQcuG/la1BwQjNwMoq9D4SgbBLcMAMKTcTTwkxK0toTeyV6gS2OB2a1r7
         RQEQ7opg56JmQyJWNZ/lHHA/dJwTQCcnznT8VJy1k0jlLyy5Obt2mX0i+BznqWgnNvXW
         rSSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751607674; x=1752212474;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=LOFLRp9gWDwkX5ICgEE7QkHKMv3HtRkDH0i8aXPgtVk=;
        b=p3oPL+rbpDPi0o06Yg5P+SjIeM6DpIxrB9XKJ9lY0akX3rXZr3u930qv5X2nKlYANe
         vEE4M7cjhfSZxdHnjhcbiUtLS7jTbxwXLcz/AlMsOT6epXUd9CfUdWjb+Ywl+pjBOrJM
         kMA28KGU7Ym75vN8K70D2fgvTnKo/xmaQZrDzn2El8CFXz3QtNyzzNK6YksmhO/OHyiW
         SwJhyYb9LVx69Exj8Khs/J3FD4RWZvvbJjBrWzeHHLxjUjrirUgTzl5Lu27nDLaJ1kL1
         nEAF2P/GrXx9bBjyoV2NRizJ4vZ0Xy7oXGSD1s0KsSjc4aS4fiKyNHWfoBu3NF0bt4ce
         CW1A==
X-Gm-Message-State: AOJu0YxWjsPk+fkcFzmGELbthS2aiK0OmytwtPr0izHDAiN/n3dii95u
	ejkOz6GhfZGvsm3odvVK6CMCki6w+TnUlTMaj/dC2i19HTONtTnmmhW4DzQltlgLfWA/oxKjIO4
	EqNCgESvkojFsPU4BENG+nG9tCJtcWTDatC5g
X-Gm-Gg: ASbGncu7goGDRj9EPj/Jb8+URxIHlD0cy/LnkVGBynRrM2LU99cnxjO4xMoU2OA5n87
	y2hF0v8W9gZV25/qqVU9PLMXJH5BmmZtti2amno279y2Gdl1BsYHHxdjwteQWvIjIyZYwbd+hhV
	SY2rsN7L77xGNSs6S2WmYZtEOURELWATXZqdylIYcPKgiPTFjYGKfRZ7bWl8/mE3D6momzSQNpi
	yWnNGq/FYCA//J8HAhYwzO3UUxAXy4uv6+n64N/+ISNa2FPYFM7nmem2Ui003Fg6tiMWmRbky/T
	4F2sdrZswyOY7K6NXMD4xbEzXrOFCtzj378lGdh/k8vrTbVKMhmmm8PH
X-Google-Smtp-Source: AGHT+IGvh+hhyx3YrLTjXO0kl6WrXnMCCbHLDd8OiaxnWPAXRLO1v1N/MfVYOa1AZ+Q6Qa65HUXdYeGEYmQn
X-Received: by 2002:a05:6a21:6b05:b0:220:9838:32ca with SMTP id adf61e73a8af0-225bec07be4mr2348550637.14.1751607674599;
        Thu, 03 Jul 2025 22:41:14 -0700 (PDT)
Received: from c7-smtp-2023.dev.purestorage.com ([208.88.159.128])
        by smtp-relay.gmail.com with ESMTPS id d2e1a72fcca58-74ce32f3748sm64958b3a.4.2025.07.03.22.41.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Jul 2025 22:41:14 -0700 (PDT)
X-Relaying-Domain: purestorage.com
Received: from dev-ushankar.dev.purestorage.com (dev-ushankar.dev.purestorage.com [10.7.70.36])
	by c7-smtp-2023.dev.purestorage.com (Postfix) with ESMTP id DF640340159;
	Thu,  3 Jul 2025 23:41:13 -0600 (MDT)
Received: by dev-ushankar.dev.purestorage.com (Postfix, from userid 1557716368)
	id 7FF2FE40F10; Thu,  3 Jul 2025 23:41:13 -0600 (MDT)
From: Uday Shankar <ushankar@purestorage.com>
Date: Thu, 03 Jul 2025 23:41:07 -0600
Subject: [PATCH v2 1/2] ublk: speed up ublk server exit handling
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250703-ublk_too_many_quiesce-v2-1-3527b5339eeb@purestorage.com>
References: <20250703-ublk_too_many_quiesce-v2-0-3527b5339eeb@purestorage.com>
In-Reply-To: <20250703-ublk_too_many_quiesce-v2-0-3527b5339eeb@purestorage.com>
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
server exit. This per-device canceling flag is then checked under a
(new) lock (addressing the data race (2) above), and the queue is only
quiesced if it is cleared (addressing (1) above). The result is just one
call to blk_mq_quiesce_queue per ublk device.

To minimize the number of cache lines that are accessed in the hot path,
the per-queue canceling flag is kept. The values of the per-device
canceling flag and all per-queue canceling flags should always match.

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
 drivers/block/ublk_drv.c | 36 +++++++++++++++++++++---------------
 1 file changed, 21 insertions(+), 15 deletions(-)

diff --git a/drivers/block/ublk_drv.c b/drivers/block/ublk_drv.c
index e52c2d1cb8383f8fe171553880c66483984da522..870d57a853a481c2443337717c50d39355804f66 100644
--- a/drivers/block/ublk_drv.c
+++ b/drivers/block/ublk_drv.c
@@ -235,6 +235,8 @@ struct ublk_device {
 	struct completion	completion;
 	unsigned int		nr_queues_ready;
 	unsigned int		nr_privileged_daemon;
+	struct mutex cancel_mutex;
+	bool canceling;
 };
 
 /* header of ublk_params */
@@ -1589,6 +1591,7 @@ static int ublk_ch_release(struct inode *inode, struct file *filp)
 	 * All requests may be inflight, so ->canceling may not be set, set
 	 * it now.
 	 */
+	ub->canceling = true;
 	for (i = 0; i < ub->dev_info.nr_hw_queues; i++) {
 		struct ublk_queue *ubq = ublk_get_queue(ub, i);
 
@@ -1717,23 +1720,18 @@ static void ublk_abort_queue(struct ublk_device *ub, struct ublk_queue *ubq)
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
+	int i;
 
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
@@ -1742,8 +1740,12 @@ static void ublk_start_cancel(struct ublk_queue *ubq)
 	 * touch completed uring_cmd
 	 */
 	blk_mq_quiesce_queue(disk->queue);
-	ublk_mark_queue_canceling(ubq);
+	ub->canceling = true;
+	for (i = 0; i < ub->dev_info.nr_hw_queues; i++)
+		ublk_get_queue(ub, i)->canceling = true;
 	blk_mq_unquiesce_queue(disk->queue);
+out:
+	mutex_unlock(&ub->cancel_mutex);
 	ublk_put_disk(disk);
 }
 
@@ -1816,8 +1818,7 @@ static void ublk_uring_cmd_cancel_fn(struct io_uring_cmd *cmd,
 	if (WARN_ON_ONCE(task && task != io->task))
 		return;
 
-	if (!ubq->canceling)
-		ublk_start_cancel(ubq);
+	ublk_start_cancel(ubq->dev);
 
 	WARN_ON_ONCE(io->cmd != cmd);
 	ublk_cancel_cmd(ubq, pdu->tag, issue_flags);
@@ -1944,6 +1945,7 @@ static void ublk_reset_io_flags(struct ublk_device *ub)
 		ubq->canceling = false;
 		ubq->fail_io = false;
 	}
+	ub->canceling = false;
 }
 
 /* device can only be started after all IOs are ready */
@@ -2652,6 +2654,7 @@ static void ublk_cdev_rel(struct device *dev)
 	ublk_deinit_queues(ub);
 	ublk_free_dev_number(ub);
 	mutex_destroy(&ub->mutex);
+	mutex_destroy(&ub->cancel_mutex);
 	kfree(ub);
 }
 
@@ -3004,6 +3007,7 @@ static int ublk_ctrl_add_dev(const struct ublksrv_ctrl_cmd *header)
 		goto out_unlock;
 	mutex_init(&ub->mutex);
 	spin_lock_init(&ub->lock);
+	mutex_init(&ub->cancel_mutex);
 
 	ret = ublk_alloc_dev_number(ub, header->dev_id);
 	if (ret < 0)
@@ -3075,6 +3079,7 @@ static int ublk_ctrl_add_dev(const struct ublksrv_ctrl_cmd *header)
 	ublk_free_dev_number(ub);
 out_free_ub:
 	mutex_destroy(&ub->mutex);
+	mutex_destroy(&ub->cancel_mutex);
 	kfree(ub);
 out_unlock:
 	mutex_unlock(&ublk_ctl_mutex);
@@ -3429,8 +3434,9 @@ static int ublk_ctrl_quiesce_dev(struct ublk_device *ub,
 	if (ub->dev_info.state != UBLK_S_DEV_LIVE)
 		goto put_disk;
 
-	/* Mark all queues as canceling */
+	/* Mark the device as canceling */
 	blk_mq_quiesce_queue(disk->queue);
+	ub->canceling = true;
 	for (i = 0; i < ub->dev_info.nr_hw_queues; i++) {
 		struct ublk_queue *ubq = ublk_get_queue(ub, i);
 

-- 
2.34.1

