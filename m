Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 15DD8C433EF
	for <linux-block@archiver.kernel.org>; Fri, 22 Jul 2022 10:38:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234298AbiGVKih (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 22 Jul 2022 06:38:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46766 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234497AbiGVKie (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 22 Jul 2022 06:38:34 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id C7777BA261
        for <linux-block@vger.kernel.org>; Fri, 22 Jul 2022 03:38:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1658486312;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=sjSWyHWO6jJVcJhU60ldSPRxnXEbptCP+9cQdj1Kz1o=;
        b=XB3vCGd+yJnWYenF+iIVu50ei2Zv29PpN5MSc4m75tyiPcV1vBJJzKnRqj7/jJzXjwk1DE
        NGMxk71hzVjiYZjezsV+bj/K3D2dQqs9s0IKO9EnFj2JvNG+KcaxctBb8rEVvDLxaJDraO
        /n2FVPJI29AuWWqtURHVQ29m3qM+0a4=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-381-E3L35-RRNH6U6a0DaK1ssA-1; Fri, 22 Jul 2022 06:38:28 -0400
X-MC-Unique: E3L35-RRNH6U6a0DaK1ssA-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.rdu2.redhat.com [10.11.54.8])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 0C49B802D2C;
        Fri, 22 Jul 2022 10:38:28 +0000 (UTC)
Received: from localhost (ovpn-8-18.pek2.redhat.com [10.72.8.18])
        by smtp.corp.redhat.com (Postfix) with ESMTP id EDF40C35979;
        Fri, 22 Jul 2022 10:38:26 +0000 (UTC)
From:   Ming Lei <ming.lei@redhat.com>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org,
        ZiyangZhang <ZiyangZhang@linux.alibaba.com>,
        Christoph Hellwig <hch@lst.de>, Ming Lei <ming.lei@redhat.com>
Subject: [PATCH V4 1/2] ublk_drv: fix error handling of ublk_add_dev
Date:   Fri, 22 Jul 2022 18:38:16 +0800
Message-Id: <20220722103817.631258-2-ming.lei@redhat.com>
In-Reply-To: <20220722103817.631258-1-ming.lei@redhat.com>
References: <20220722103817.631258-1-ming.lei@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.85 on 10.11.54.8
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

From: Christoph Hellwig <hch@lst.de>

__ublk_destroy_dev() is called for handling error in ublk_add_dev(),
but either tagset isn't allocated or mutex isn't initialized.

So fix the issue by letting replacing ublk_add_dev with a
ublk_add_tag_set function that is much more limited in scope and
instead unwind every single step directly in ublk_ctrl_add_dev.
To allow for this refactor the device freeing so that there is
a helper for freeing the device number instead of coupling that
with freeing the mutex and the memory.

Note that this now copies the dev_info to userspace before adding
the character device.  This not only simplifies the erro handling
in ublk_ctrl_add_dev, but also means that the character device
can only be seen by userspace if the device addition succeeded.

Based on a patch from Ming Lei.

Signed-off-by: Christoph Hellwig <hch@lst.de>
Signed-off-by: Ming Lei <ming.lei@redhat.com>
---
 drivers/block/ublk_drv.c | 100 +++++++++++++++++++--------------------
 1 file changed, 48 insertions(+), 52 deletions(-)

diff --git a/drivers/block/ublk_drv.c b/drivers/block/ublk_drv.c
index f058f40b639c..67f91a80a7ab 100644
--- a/drivers/block/ublk_drv.c
+++ b/drivers/block/ublk_drv.c
@@ -1005,7 +1005,7 @@ static int ublk_init_queues(struct ublk_device *ub)
 	return ret;
 }
 
-static int __ublk_alloc_dev_number(struct ublk_device *ub, int idx)
+static int ublk_alloc_dev_number(struct ublk_device *ub, int idx)
 {
 	int i = idx;
 	int err;
@@ -1027,16 +1027,12 @@ static int __ublk_alloc_dev_number(struct ublk_device *ub, int idx)
 	return err;
 }
 
-static void __ublk_destroy_dev(struct ublk_device *ub)
+static void ublk_free_dev_number(struct ublk_device *ub)
 {
 	spin_lock(&ublk_idr_lock);
 	idr_remove(&ublk_index_idr, ub->ub_number);
 	wake_up_all(&ublk_idr_wq);
 	spin_unlock(&ublk_idr_lock);
-
-	mutex_destroy(&ub->mutex);
-
-	kfree(ub);
 }
 
 static void ublk_cdev_rel(struct device *dev)
@@ -1045,8 +1041,9 @@ static void ublk_cdev_rel(struct device *dev)
 
 	blk_mq_free_tag_set(&ub->tag_set);
 	ublk_deinit_queues(ub);
-
-	__ublk_destroy_dev(ub);
+	ublk_free_dev_number(ub);
+	mutex_destroy(&ub->mutex);
+	kfree(ub);
 }
 
 static int ublk_add_chdev(struct ublk_device *ub)
@@ -1092,24 +1089,8 @@ static void ublk_align_max_io_size(struct ublk_device *ub)
 		round_down(max_rq_bytes, PAGE_SIZE) >> ub->bs_shift;
 }
 
-/* add tag_set & cdev, cleanup everything in case of failure */
-static int ublk_add_dev(struct ublk_device *ub)
+static int ublk_add_tag_set(struct ublk_device *ub)
 {
-	int err = -ENOMEM;
-
-	/* We are not ready to support zero copy */
-	ub->dev_info.flags[0] &= ~UBLK_F_SUPPORT_ZERO_COPY;
-
-	ub->bs_shift = ilog2(ub->dev_info.block_size);
-	ub->dev_info.nr_hw_queues = min_t(unsigned int,
-			ub->dev_info.nr_hw_queues, nr_cpu_ids);
-
-	INIT_WORK(&ub->stop_work, ublk_stop_work_fn);
-	INIT_DELAYED_WORK(&ub->monitor_work, ublk_daemon_monitor_work);
-
-	if (ublk_init_queues(ub))
-		goto out_destroy_dev;
-
 	ub->tag_set.ops = &ublk_mq_ops;
 	ub->tag_set.nr_hw_queues = ub->dev_info.nr_hw_queues;
 	ub->tag_set.queue_depth = ub->dev_info.queue_depth;
@@ -1117,22 +1098,7 @@ static int ublk_add_dev(struct ublk_device *ub)
 	ub->tag_set.cmd_size = sizeof(struct ublk_rq_data);
 	ub->tag_set.flags = BLK_MQ_F_SHOULD_MERGE;
 	ub->tag_set.driver_data = ub;
-	err = blk_mq_alloc_tag_set(&ub->tag_set);
-	if (err)
-		goto out_deinit_queues;
-
-	ublk_align_max_io_size(ub);
-	mutex_init(&ub->mutex);
-	spin_lock_init(&ub->mm_lock);
-
-	/* add char dev so that ublksrv daemon can be setup */
-	return ublk_add_chdev(ub);
-
-out_deinit_queues:
-	ublk_deinit_queues(ub);
-out_destroy_dev:
-	__ublk_destroy_dev(ub);
-	return err;
+	return blk_mq_alloc_tag_set(&ub->tag_set);
 }
 
 static void ublk_remove(struct ublk_device *ub)
@@ -1318,26 +1284,56 @@ static int ublk_ctrl_add_dev(struct io_uring_cmd *cmd)
 	ub = kzalloc(sizeof(*ub), GFP_KERNEL);
 	if (!ub)
 		goto out_unlock;
+	mutex_init(&ub->mutex);
+	spin_lock_init(&ub->mm_lock);
+	INIT_WORK(&ub->stop_work, ublk_stop_work_fn);
+	INIT_DELAYED_WORK(&ub->monitor_work, ublk_daemon_monitor_work);
 
-	ret = __ublk_alloc_dev_number(ub, header->dev_id);
-	if (ret < 0) {
-		kfree(ub);
-		goto out_unlock;
-	}
+	ret = ublk_alloc_dev_number(ub, header->dev_id);
+	if (ret < 0)
+		goto out_free_ub;
 
 	memcpy(&ub->dev_info, &info, sizeof(info));
 
 	/* update device id */
 	ub->dev_info.dev_id = ub->ub_number;
 
-	ret = ublk_add_dev(ub);
+	/* We are not ready to support zero copy */
+	ub->dev_info.flags[0] &= ~UBLK_F_SUPPORT_ZERO_COPY;
+
+	ub->bs_shift = ilog2(ub->dev_info.block_size);
+	ub->dev_info.nr_hw_queues = min_t(unsigned int,
+			ub->dev_info.nr_hw_queues, nr_cpu_ids);
+	ublk_align_max_io_size(ub);
+
+	ret = ublk_init_queues(ub);
 	if (ret)
-		goto out_unlock;
+		goto out_free_dev_number;
 
-	if (copy_to_user(argp, &ub->dev_info, sizeof(info))) {
-		ublk_remove(ub);
-		ret = -EFAULT;
-	}
+	ret = ublk_add_tag_set(ub);
+	if (ret)
+		goto out_deinit_queues;
+
+	ret = -EFAULT;
+	if (copy_to_user(argp, &ub->dev_info, sizeof(info)))
+		goto out_free_tag_set;
+
+	/*
+	 * Add the char dev so that ublksrv daemon can be setup.
+	 * ublk_add_chdev() will cleanup everything if it fails.
+	 */
+	ret = ublk_add_chdev(ub);
+	goto out_unlock;
+
+out_free_tag_set:
+	blk_mq_free_tag_set(&ub->tag_set);
+out_deinit_queues:
+	ublk_deinit_queues(ub);
+out_free_dev_number:
+	ublk_free_dev_number(ub);
+out_free_ub:
+	mutex_destroy(&ub->mutex);
+	kfree(ub);
 out_unlock:
 	mutex_unlock(&ublk_ctl_mutex);
 	return ret;
-- 
2.31.1

