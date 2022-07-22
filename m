Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8D1B9C433EF
	for <linux-block@archiver.kernel.org>; Fri, 22 Jul 2022 06:17:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230514AbiGVGRW (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 22 Jul 2022 02:17:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57692 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229538AbiGVGRW (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 22 Jul 2022 02:17:22 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 49BAD6391D
        for <linux-block@vger.kernel.org>; Thu, 21 Jul 2022 23:17:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=6dBDypg3+YVaUX8h/ahmtj8KrCUiRJPgcMGvkslV7Y4=; b=ueViznaaRg+ib1C+KnLo2Uppvq
        iHoM9JQdGBjTVsvBkTmYkXy5beGkz79XYHy2Mg6Zr6cI85AmSIArrxpfgiHqf6/Kwe0wnKkAbNH49
        QXJZzHxzfauDiaXUtlOw2tQkb/vVw3DgpXeBlYrUpgjSyIgkjAHKAP78PxAbnnXbex4IA0QCIWMZB
        fww3VvsjkDVM08dnURUPWTwExcrb4LpV291zqufj+X7tgwpSbHBANCN+gjCUknJimhgW6ZRTwSuJH
        AvZqAdozjt9Ft7TqaQu5rfjGb4xiSZLCAlXYF7tves+7zFf/lrD65drl9FwNcIdEzJjr7RkTAeJmQ
        jNS2ciGA==;
Received: from hch by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1oElyR-000IuN-EP; Fri, 22 Jul 2022 06:17:19 +0000
Date:   Thu, 21 Jul 2022 23:17:19 -0700
From:   Christoph Hellwig <hch@infradead.org>
To:     Ming Lei <ming.lei@redhat.com>
Cc:     Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
        ZiyangZhang <ZiyangZhang@linux.alibaba.com>
Subject: Re: [PATCH V2 1/2] ublk_drv: fix error handling of ublk_add_dev
Message-ID: <YtpA70BmGMDrdnsU@infradead.org>
References: <20220722050930.611232-1-ming.lei@redhat.com>
 <20220722050930.611232-2-ming.lei@redhat.com>
 <Yto6FyKmdCvx0Iym@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Yto6FyKmdCvx0Iym@infradead.org>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Thu, Jul 21, 2022 at 10:48:07PM -0700, Christoph Hellwig wrote:
> I think __ublk_destroy_dev just needs to go away in that form.
> Also I'd much rather do the copy_to_user before the ublk_add_chdev
> as that means we never remove a devic already marked life due to a
> failure.  Something like the patch below, which will need testing first
> before I'd dare to submit it:

Improved and tested version:

---
From 49ba6d0c5788ea9d3a6ef88d910b702152f5d75a Mon Sep 17 00:00:00 2001
From: Christoph Hellwig <hch@lst.de>
Date: Fri, 22 Jul 2022 07:38:59 +0200
Subject: ublk_drv: fix error handling of ublk_add_dev

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
---
 drivers/block/ublk_drv.c | 100 +++++++++++++++++++--------------------
 1 file changed, 48 insertions(+), 52 deletions(-)

diff --git a/drivers/block/ublk_drv.c b/drivers/block/ublk_drv.c
index f058f40b639c3..67f91a80a7aba 100644
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
2.30.2

