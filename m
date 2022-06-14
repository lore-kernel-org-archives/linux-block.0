Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3E627C43334
	for <linux-block@archiver.kernel.org>; Tue, 14 Jun 2022 07:48:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353596AbiFNHso (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 14 Jun 2022 03:48:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37820 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1353011AbiFNHsn (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 14 Jun 2022 03:48:43 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 10B123E5C6
        for <linux-block@vger.kernel.org>; Tue, 14 Jun 2022 00:48:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description;
        bh=xInmvjxxJ114Iq1kQSE1PKAcklYdQt8WQ+FdVcWSe2Q=; b=eTUhrd3L6FWZooMWQxWirYs/rC
        r4ihGD1+lVY//hSbrmjYTIs11WNlExGooYNmWFb9pqbwTtsEEb9hs2K6je51H5SvUtIfode9xebZc
        t29Y25c9G6suFd37Kakv/z/GGvX+D+TM8OugRCrcV644aFc030GATkM8fz4y0y4+JDh8FoCRV0KyZ
        Sy34ZX4KX47D7a331xubLszCGkzDEKieLwAlArbfTMXgaHjGzq4LEsGQnYrCJXrm/16TSdRTmhKRp
        G5jTx2dI1KIZVlg6SDUT3SpKII2m3MbbdYtP4nckZK/lbUv+/A83JDNMnOJNn4uYaaqv0/mHE6x+z
        bpFbjQCQ==;
Received: from [2001:4bb8:180:36f6:1fed:6d48:cf16:d13c] (helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1o11Ht-0082ie-PF; Tue, 14 Jun 2022 07:48:34 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     axboe@kernel.dk
Cc:     shinichiro.kawasaki@wdc.com, dan.j.williams@intel.com,
        yukuai3@huawei.com, ming.lei@redhat.com,
        linux-block@vger.kernel.org,
        syzbot+3e3f419f4a7816471838@syzkaller.appspotmail.com
Subject: [PATCH 1/4] block: disable the elevator int del_gendisk
Date:   Tue, 14 Jun 2022 09:48:24 +0200
Message-Id: <20220614074827.458955-2-hch@lst.de>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220614074827.458955-1-hch@lst.de>
References: <20220614074827.458955-1-hch@lst.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

The elevator is only used for file system requests, which are stopped in
del_gendisk.  Move disabling the elevator and freeing the scheduler tags
to the end of del_gendisk instead of doing that work in disk_release and
blk_cleanup_queue to avoid a use after free on q->tag_set from
disk_release as the tag_set might not be alive at that point.

Move the blk_qos_exit call as well, as it just depends on the elevator
exit and would be the only reason to keep the not exactly cheap queue
freeze in disk_release.

Fixes: e155b0c238b2 ("blk-mq: Use shared tags for shared sbitmap support")
Reported-by: syzbot+3e3f419f4a7816471838@syzkaller.appspotmail.com
Signed-off-by: Christoph Hellwig <hch@lst.de>
Tested-by: syzbot+3e3f419f4a7816471838@syzkaller.appspotmail.com
---
 block/blk-core.c | 13 -------------
 block/genhd.c    | 39 +++++++++++----------------------------
 2 files changed, 11 insertions(+), 41 deletions(-)

diff --git a/block/blk-core.c b/block/blk-core.c
index 06ff5bbfe8f66..27fb1357ad4b8 100644
--- a/block/blk-core.c
+++ b/block/blk-core.c
@@ -322,19 +322,6 @@ void blk_cleanup_queue(struct request_queue *q)
 		blk_mq_exit_queue(q);
 	}
 
-	/*
-	 * In theory, request pool of sched_tags belongs to request queue.
-	 * However, the current implementation requires tag_set for freeing
-	 * requests, so free the pool now.
-	 *
-	 * Queue has become frozen, there can't be any in-queue requests, so
-	 * it is safe to free requests now.
-	 */
-	mutex_lock(&q->sysfs_lock);
-	if (q->elevator)
-		blk_mq_sched_free_rqs(q);
-	mutex_unlock(&q->sysfs_lock);
-
 	/* @q is and will stay empty, shutdown and put */
 	blk_put_queue(q);
 }
diff --git a/block/genhd.c b/block/genhd.c
index 27205ae47d593..e0675772178b0 100644
--- a/block/genhd.c
+++ b/block/genhd.c
@@ -652,6 +652,17 @@ void del_gendisk(struct gendisk *disk)
 
 	blk_sync_queue(q);
 	blk_flush_integrity();
+	blk_mq_cancel_work_sync(q);
+
+	blk_mq_quiesce_queue(q);
+	if (q->elevator) {
+		mutex_lock(&q->sysfs_lock);
+		elevator_exit(q);
+		mutex_unlock(&q->sysfs_lock);
+	}
+	rq_qos_exit(q);
+	blk_mq_unquiesce_queue(q);
+
 	/*
 	 * Allow using passthrough request again after the queue is torn down.
 	 */
@@ -1120,31 +1131,6 @@ static const struct attribute_group *disk_attr_groups[] = {
 	NULL
 };
 
-static void disk_release_mq(struct request_queue *q)
-{
-	blk_mq_cancel_work_sync(q);
-
-	/*
-	 * There can't be any non non-passthrough bios in flight here, but
-	 * requests stay around longer, including passthrough ones so we
-	 * still need to freeze the queue here.
-	 */
-	blk_mq_freeze_queue(q);
-
-	/*
-	 * Since the I/O scheduler exit code may access cgroup information,
-	 * perform I/O scheduler exit before disassociating from the block
-	 * cgroup controller.
-	 */
-	if (q->elevator) {
-		mutex_lock(&q->sysfs_lock);
-		elevator_exit(q);
-		mutex_unlock(&q->sysfs_lock);
-	}
-	rq_qos_exit(q);
-	__blk_mq_unfreeze_queue(q, true);
-}
-
 /**
  * disk_release - releases all allocated resources of the gendisk
  * @dev: the device representing this disk
@@ -1166,9 +1152,6 @@ static void disk_release(struct device *dev)
 	might_sleep();
 	WARN_ON_ONCE(disk_live(disk));
 
-	if (queue_is_mq(disk->queue))
-		disk_release_mq(disk->queue);
-
 	blkcg_exit_queue(disk->queue);
 
 	disk_release_events(disk);
-- 
2.30.2

