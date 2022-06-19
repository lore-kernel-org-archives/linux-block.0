Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CBB54CCA47F
	for <linux-block@archiver.kernel.org>; Sun, 19 Jun 2022 06:06:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233870AbiFSGGF (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Sun, 19 Jun 2022 02:06:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40000 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233258AbiFSGGE (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Sun, 19 Jun 2022 02:06:04 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 49E5EEE2D
        for <linux-block@vger.kernel.org>; Sat, 18 Jun 2022 23:06:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description;
        bh=fTu1QFVriViDkW8ZtaDZl1mirxBflqloEqI3idyXIXU=; b=RWRqNmHZk/yfPt3ea4jymO5yVH
        LF947Tx1cAgYcVamJhdchcmbj5XfubyGMHdupHTFsUSuuthwA1d7hQ7ulmi4wMBSWH3DAXWUFjg8j
        kY6mugFx1uuYjo1XLR3Cl7IwMOMUr1+ykvlTl8javnhOfFaI7DLLwG8IM1znhOCpBAvn69IOdTHZp
        jwShS5j7xz6GAxnsXB/XzqKaqnMb5pAVRES2KagvjLs0IRXr1dre8qQrwMe0hSrhX3k606quQB7qd
        6UGFLvWmWPzpveZuFghK0pfv7fMSJzknNiY1fsbL2804MOn5/0YhIQYD7RmpCaulf4nB67tT73cKg
        Pux3Id5g==;
Received: from [2001:4bb8:189:7251:513c:d533:c6f1:1e56] (helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1o2o4Q-00DJml-Sr; Sun, 19 Jun 2022 06:06:03 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     Ming Lei <ming.lei@redhat.com>, linux-block@vger.kernel.org
Subject: [PATCH 3/6] block: remove QUEUE_FLAG_DEAD
Date:   Sun, 19 Jun 2022 08:05:49 +0200
Message-Id: <20220619060552.1850436-4-hch@lst.de>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220619060552.1850436-1-hch@lst.de>
References: <20220619060552.1850436-1-hch@lst.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Disallow setting the blk-mq state on any queue that is already dying as
setting the state even then is a bad idea, and remove the now unused
QUEUE_FLAG_DEAD flag.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 block/blk-core.c       | 3 ---
 block/blk-mq-debugfs.c | 8 +++-----
 include/linux/blkdev.h | 2 --
 3 files changed, 3 insertions(+), 10 deletions(-)

diff --git a/block/blk-core.c b/block/blk-core.c
index 27fb1357ad4b8..088332984cd1b 100644
--- a/block/blk-core.c
+++ b/block/blk-core.c
@@ -313,9 +313,6 @@ void blk_cleanup_queue(struct request_queue *q)
 	 * after draining finished.
 	 */
 	blk_freeze_queue(q);
-
-	blk_queue_flag_set(QUEUE_FLAG_DEAD, q);
-
 	blk_sync_queue(q);
 	if (queue_is_mq(q)) {
 		blk_mq_cancel_work_sync(q);
diff --git a/block/blk-mq-debugfs.c b/block/blk-mq-debugfs.c
index 4d1ce9ef43187..b80fae7ab1d95 100644
--- a/block/blk-mq-debugfs.c
+++ b/block/blk-mq-debugfs.c
@@ -116,7 +116,6 @@ static const char *const blk_queue_flag_name[] = {
 	QUEUE_FLAG_NAME(NOXMERGES),
 	QUEUE_FLAG_NAME(ADD_RANDOM),
 	QUEUE_FLAG_NAME(SAME_FORCE),
-	QUEUE_FLAG_NAME(DEAD),
 	QUEUE_FLAG_NAME(INIT_DONE),
 	QUEUE_FLAG_NAME(STABLE_WRITES),
 	QUEUE_FLAG_NAME(POLL),
@@ -151,11 +150,10 @@ static ssize_t queue_state_write(void *data, const char __user *buf,
 	char opbuf[16] = { }, *op;
 
 	/*
-	 * The "state" attribute is removed after blk_cleanup_queue() has called
-	 * blk_mq_free_queue(). Return if QUEUE_FLAG_DEAD has been set to avoid
-	 * triggering a use-after-free.
+	 * The "state" attribute is removed when the queue is removed.  Don't
+	 * allow setting the state on a dying queue to avoid a use-after-free.
 	 */
-	if (blk_queue_dead(q))
+	if (blk_queue_dying(q))
 		return -ENOENT;
 
 	if (count >= sizeof(opbuf)) {
diff --git a/include/linux/blkdev.h b/include/linux/blkdev.h
index 73c886eba8e19..c77ed4dcf561b 100644
--- a/include/linux/blkdev.h
+++ b/include/linux/blkdev.h
@@ -560,7 +560,6 @@ struct request_queue {
 #define QUEUE_FLAG_NOXMERGES	9	/* No extended merges */
 #define QUEUE_FLAG_ADD_RANDOM	10	/* Contributes to random pool */
 #define QUEUE_FLAG_SAME_FORCE	12	/* force complete on same CPU */
-#define QUEUE_FLAG_DEAD		13	/* queue tear-down finished */
 #define QUEUE_FLAG_INIT_DONE	14	/* queue is initialized */
 #define QUEUE_FLAG_STABLE_WRITES 15	/* don't modify blks until WB is done */
 #define QUEUE_FLAG_POLL		16	/* IO polling enabled if set */
@@ -588,7 +587,6 @@ bool blk_queue_flag_test_and_set(unsigned int flag, struct request_queue *q);
 #define blk_queue_stopped(q)	test_bit(QUEUE_FLAG_STOPPED, &(q)->queue_flags)
 #define blk_queue_dying(q)	test_bit(QUEUE_FLAG_DYING, &(q)->queue_flags)
 #define blk_queue_has_srcu(q)	test_bit(QUEUE_FLAG_HAS_SRCU, &(q)->queue_flags)
-#define blk_queue_dead(q)	test_bit(QUEUE_FLAG_DEAD, &(q)->queue_flags)
 #define blk_queue_init_done(q)	test_bit(QUEUE_FLAG_INIT_DONE, &(q)->queue_flags)
 #define blk_queue_nomerges(q)	test_bit(QUEUE_FLAG_NOMERGES, &(q)->queue_flags)
 #define blk_queue_noxmerges(q)	\
-- 
2.30.2

