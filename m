Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 55BCAC433EF
	for <linux-block@archiver.kernel.org>; Tue, 31 May 2022 16:05:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346009AbiEaQFr (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 31 May 2022 12:05:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49364 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344923AbiEaQFl (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 31 May 2022 12:05:41 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7ED7B8FD48
        for <linux-block@vger.kernel.org>; Tue, 31 May 2022 09:05:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        MIME-Version:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
        Content-ID:Content-Description:In-Reply-To:References;
        bh=Y45Bjt0iaelCqNFtJ/Weh2tQUFqwmNIZfsMxlMbDJ7A=; b=HYPH6sfL6bOMfBH1w40AMX1t70
        /V0qpjzpTivZD6rgqsHTbzVCKvBFzwRWlGu2/YvPqDtBVExOXmQ0zzH4xuEjmfNhrQ7wRfzxyOH/v
        /b1EjRqvL0dLSZhM36yKtP7H1tCj5hBoeKWz/9aHsuSZfWy3bbd7sGFrYWV2KhOxga3nEnV/bBkEc
        QPesX1KKmRiqnnFEBkPlX46zLZgELh/zaQHEUDmlRxE8fjS/qBfFHpx2cYTqj+UmuFS3mZePGzo6h
        H6fwzEPElS2lgFH/X1MbuJOeYdLqsCUJJmWq7h6VVbFYIbsHPL9AG2IvO81Op01e9MsXz4uq7kAHk
        UfUPg9Tg==;
Received: from [2001:4bb8:185:a81e:d2c3:ee3a:c8da:fd86] (helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nw4NG-00BiFa-Kv; Tue, 31 May 2022 16:05:39 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     axboe@kernel.dk
Cc:     ming.lei@redhat.com, linux-block@vger.kernel.org,
        syzbot+3e3f419f4a7816471838@syzkaller.appspotmail.com
Subject: [PATCH] block: disable the elevator int del_gendisk
Date:   Tue, 31 May 2022 18:05:35 +0200
Message-Id: <20220531160535.3444915-1-hch@lst.de>
X-Mailer: git-send-email 2.30.2
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
 block/genhd.c    | 38 ++++++++++----------------------------
 2 files changed, 10 insertions(+), 41 deletions(-)

diff --git a/block/blk-core.c b/block/blk-core.c
index 80fa73c419a99..19cfa71e33728 100644
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
index 8ff5b187791af..9914d0f24fecd 100644
--- a/block/genhd.c
+++ b/block/genhd.c
@@ -649,6 +649,16 @@ void del_gendisk(struct gendisk *disk)
 
 	blk_sync_queue(q);
 	blk_flush_integrity();
+	blk_mq_cancel_work_sync(q);
+
+	if (q->elevator) {
+		mutex_lock(&q->sysfs_lock);
+		elevator_exit(q);
+		mutex_unlock(&q->sysfs_lock);
+	}
+
+	rq_qos_exit(q);
+
 	/*
 	 * Allow using passthrough request again after the queue is torn down.
 	 */
@@ -1117,31 +1127,6 @@ static const struct attribute_group *disk_attr_groups[] = {
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
@@ -1163,9 +1148,6 @@ static void disk_release(struct device *dev)
 	might_sleep();
 	WARN_ON_ONCE(disk_live(disk));
 
-	if (queue_is_mq(disk->queue))
-		disk_release_mq(disk->queue);
-
 	blkcg_exit_queue(disk->queue);
 
 	disk_release_events(disk);
-- 
2.30.2

