Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 09EE0C433EF
	for <linux-block@archiver.kernel.org>; Thu, 27 Jan 2022 07:05:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237087AbiA0HFy (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 27 Jan 2022 02:05:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58250 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229823AbiA0HFw (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 27 Jan 2022 02:05:52 -0500
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9A495C061714
        for <linux-block@vger.kernel.org>; Wed, 26 Jan 2022 23:05:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        MIME-Version:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
        Content-ID:Content-Description:In-Reply-To:References;
        bh=U7nNjzqKCwfJ6+4+0/uSBNIE6sor/l2RUAVLcBqJ+Pk=; b=OtiZxoa7PZ7GXVnVWcorALvcbY
        OPxARfLUAuYlRCxXRr1j9ODeVkag6oSOk5HiSx375JujXrHXk9P70e87djmfRJFAZSbydvuWkjhSb
        meH84gUs994VMHwaA6npoTTvUT9OAZOpFBrOqAsU986bZOc6J9mt/YA7iFQ9EmR9WtiyIGTLeLk47
        hrF0VEzBqdc9SWqE2gkzCAQ4I7acskF3FzibSTN700Z9iOIifQnDlw8ycpZAW93tkf14BJqTO2Omi
        88ZbbdYZrtoqO5EKJzymNMFAZO+HhldIdodlw3/FRjFmlLtOYvMQ1hZ0/lwgH+3VSCpRBQw7XrMvt
        UcIQ3jGg==;
Received: from 213-225-10-69.nat.highway.a1.net ([213.225.10.69] helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nCyqt-00EbdY-Iu; Thu, 27 Jan 2022 07:05:52 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     axboe@kernel.dk
Cc:     linux-block@vger.kernel.org
Subject: [PATCH 1/2] block: remove blk_needs_flush_plug
Date:   Thu, 27 Jan 2022 08:05:48 +0100
Message-Id: <20220127070549.1377856-1-hch@lst.de>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

blk_needs_flush_plug fails to account for the cb_list, which needs
flushing as well.  Remove it and just check if there is a plug instead
of poking into the internals of the plug structure.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 fs/fs-writeback.c      |  2 +-
 include/linux/blkdev.h | 13 -------------
 kernel/exit.c          |  2 +-
 kernel/sched/core.c    |  2 +-
 4 files changed, 3 insertions(+), 16 deletions(-)

diff --git a/fs/fs-writeback.c b/fs/fs-writeback.c
index f8d7fe6db989e..f4ce38f6fc31c 100644
--- a/fs/fs-writeback.c
+++ b/fs/fs-writeback.c
@@ -2301,7 +2301,7 @@ void wakeup_flusher_threads(enum wb_reason reason)
 	/*
 	 * If we are expecting writeback progress we must submit plugged IO.
 	 */
-	if (blk_needs_flush_plug(current))
+	if (current->plug)
 		blk_flush_plug(current->plug, true);
 
 	rcu_read_lock();
diff --git a/include/linux/blkdev.h b/include/linux/blkdev.h
index 85c38c3a89c35..95176802ccc92 100644
--- a/include/linux/blkdev.h
+++ b/include/linux/blkdev.h
@@ -1055,14 +1055,6 @@ extern void blk_finish_plug(struct blk_plug *);
 
 void blk_flush_plug(struct blk_plug *plug, bool from_schedule);
 
-static inline bool blk_needs_flush_plug(struct task_struct *tsk)
-{
-	struct blk_plug *plug = tsk->plug;
-
-	return plug &&
-		 (plug->mq_list || !list_empty(&plug->cb_list));
-}
-
 int blkdev_issue_flush(struct block_device *bdev);
 long nr_blockdev_pages(void);
 #else /* CONFIG_BLOCK */
@@ -1086,11 +1078,6 @@ static inline void blk_flush_plug(struct blk_plug *plug, bool async)
 {
 }
 
-static inline bool blk_needs_flush_plug(struct task_struct *tsk)
-{
-	return false;
-}
-
 static inline int blkdev_issue_flush(struct block_device *bdev)
 {
 	return 0;
diff --git a/kernel/exit.c b/kernel/exit.c
index b00a25bb4ab93..11fc6c9df9f28 100644
--- a/kernel/exit.c
+++ b/kernel/exit.c
@@ -735,7 +735,7 @@ void __noreturn do_exit(long code)
 	struct task_struct *tsk = current;
 	int group_dead;
 
-	WARN_ON(blk_needs_flush_plug(tsk));
+	WARN_ON(tsk->plug);
 
 	/*
 	 * If do_dead is called because this processes oopsed, it's possible
diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index 2e4ae00e52d14..ccaa17e5a8306 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -6345,7 +6345,7 @@ static inline void sched_submit_work(struct task_struct *tsk)
 	 * If we are going to sleep and we have plugged IO queued,
 	 * make sure to submit it to avoid deadlocks.
 	 */
-	if (blk_needs_flush_plug(tsk))
+	if (tsk->plug)
 		blk_flush_plug(tsk->plug, true);
 }
 
-- 
2.30.2

