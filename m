Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 586B9FA3740
	for <linux-block@archiver.kernel.org>; Tue, 25 Oct 2022 14:40:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232236AbiJYOkg (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 25 Oct 2022 10:40:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53222 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231801AbiJYOkf (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 25 Oct 2022 10:40:35 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5DD697655C
        for <linux-block@vger.kernel.org>; Tue, 25 Oct 2022 07:40:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description;
        bh=NA5+uh0/BsRr4AERc3fw9+nH2mEyqiksc8u6ukbTCMs=; b=TKWmAFSRv8RLsq8IwuP8IS+sHm
        EMZdkDQ9C6c6deI0aH/yeXSQ18rxo1xOku9cDsF07/nh8hnOeBflIvFTFgT5uyWkLrEUcQus5z+Ka
        5iUIDBi8LxrR5xVnGY46n7ZhjE2nBG5Suo/0zrBz02njfevRXal8IEoIvvIlpC+80NVgQ0ooSFeXF
        luirVlyrcrkQlF1yMY+utW1ZAFatWH6dAZKHYF+Sg727Su8l1/lgjgTGbn0Tk0fuw4DABnndh69yx
        5c0qKHrCZYUE4NZOeYxYIiEEaWkIqDKwUZKHoulIXEA068NMt8aFcpQ6C+X5OA/SxQ7LdDyf9cCTN
        op/NKwaQ==;
Received: from [12.47.128.130] (helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1onL6K-005pm0-Su; Tue, 25 Oct 2022 14:40:20 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Jens Axboe <axboe@kernel.dk>, Keith Busch <kbusch@kernel.org>,
        Sagi Grimberg <sagi@grimberg.me>,
        Chao Leng <lengchao@huawei.com>
Cc:     Ming Lei <ming.lei@redhat.com>, linux-nvme@lists.infradead.org,
        linux-block@vger.kernel.org
Subject: [PATCH 01/17] block: set the disk capacity to 0 in blk_mark_disk_dead
Date:   Tue, 25 Oct 2022 07:40:04 -0700
Message-Id: <20221025144020.260458-2-hch@lst.de>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20221025144020.260458-1-hch@lst.de>
References: <20221025144020.260458-1-hch@lst.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

nvme and xen-blkfront are already doing this to stop buffered writes from
creating dirty pages that can't be written out later.  Move it to the
common code.

This also removes the comment about the ordering from nvme, as bd_mutex
not only is gone entirely, but also hasn't been used for locking updates
to the disk size long before that, and thus the ordering requirement
documented there doesn't apply any more.

Signed-off-by: Christoph Hellwig <hch@lst.de>
Reviewed-by: Keith Busch <kbusch@kernel.org>
Reviewed-by: Sagi Grimberg <sagi@grimberg.me>
Reviewed-by: Ming Lei <ming.lei@redhat.com>
Reviewed-by: Chao Leng <lengchao@huawei.com>
---
 block/genhd.c                | 5 +++++
 drivers/block/xen-blkfront.c | 1 -
 drivers/nvme/host/core.c     | 7 +------
 3 files changed, 6 insertions(+), 7 deletions(-)

diff --git a/block/genhd.c b/block/genhd.c
index 17b33c62423df..70a25e8a64466 100644
--- a/block/genhd.c
+++ b/block/genhd.c
@@ -555,6 +555,11 @@ void blk_mark_disk_dead(struct gendisk *disk)
 {
 	set_bit(GD_DEAD, &disk->state);
 	blk_queue_start_drain(disk->queue);
+
+	/*
+	 * Stop buffered writers from dirtying pages that can't be written out.
+	 */
+	set_capacity_and_notify(disk, 0);
 }
 EXPORT_SYMBOL_GPL(blk_mark_disk_dead);
 
diff --git a/drivers/block/xen-blkfront.c b/drivers/block/xen-blkfront.c
index 35b9bcad9db90..b28489290323f 100644
--- a/drivers/block/xen-blkfront.c
+++ b/drivers/block/xen-blkfront.c
@@ -2129,7 +2129,6 @@ static void blkfront_closing(struct blkfront_info *info)
 	if (info->rq && info->gd) {
 		blk_mq_stop_hw_queues(info->rq);
 		blk_mark_disk_dead(info->gd);
-		set_capacity(info->gd, 0);
 	}
 
 	for_each_rinfo(info, rinfo, i) {
diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index dc42206005855..a92d07137cbd8 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -5110,10 +5110,7 @@ static void nvme_stop_ns_queue(struct nvme_ns *ns)
 /*
  * Prepare a queue for teardown.
  *
- * This must forcibly unquiesce queues to avoid blocking dispatch, and only set
- * the capacity to 0 after that to avoid blocking dispatchers that may be
- * holding bd_butex.  This will end buffered writers dirtying pages that can't
- * be synced.
+ * This must forcibly unquiesce queues to avoid blocking dispatch.
  */
 static void nvme_set_queue_dying(struct nvme_ns *ns)
 {
@@ -5122,8 +5119,6 @@ static void nvme_set_queue_dying(struct nvme_ns *ns)
 
 	blk_mark_disk_dead(ns->disk);
 	nvme_start_ns_queue(ns);
-
-	set_capacity_and_notify(ns->disk, 0);
 }
 
 /**
-- 
2.30.2

