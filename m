Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-19.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D1BAAC433B4
	for <linux-block@archiver.kernel.org>; Fri, 16 Apr 2021 16:54:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B457F613BB
	for <linux-block@archiver.kernel.org>; Fri, 16 Apr 2021 16:54:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235608AbhDPQy1 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 16 Apr 2021 12:54:27 -0400
Received: from mail.kernel.org ([198.145.29.99]:49788 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234774AbhDPQy0 (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Fri, 16 Apr 2021 12:54:26 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 39CE5611BF;
        Fri, 16 Apr 2021 16:54:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1618592041;
        bh=eNRCFt6SI/oWgzlTLt9gANdNPhtqg4xLovQCFl45UpI=;
        h=From:To:Cc:Subject:Date:From;
        b=tX4ivfzNNcnY4xWTzZo14H4EnZa5b9dP3WT4C91gXJqHAGoxk9Ztm5jnY51UCOYv2
         R1M5yjQ8WNc8wTzZixfsW9G+p6mJ3BMGatNNRtSzCuHjAaov4EZl/teUuOiklmKgv+
         ErzlHAZwobkL8Yeyl9ppcPkuuCZNDSZwA40PblPtJCMfC9MVDxc8nU9vC3G1VWmjGZ
         DGoPLUuvMu+GQ62HU30Z9r54WKe84ecjH0lEloPV+oXuUfofcB+wqNjCexWSgjFwtq
         KcF6DhEJJgIiROZlkwu20ckGQ4ZiNeJznqICjcpExY690zhit2AVgKvUwbXeZUSpqw
         gE2QGv5mzd12Q==
From:   Keith Busch <kbusch@kernel.org>
To:     linux-nvme@lists.infradead.org, sagi@grimberg.me, hch@lst.de,
        axboe@kernel.dk, linux-block@vger.kernel.org
Cc:     Keith Busch <kbusch@kernel.org>,
        Yuanyuan Zhong <yzhong@purestorage.com>
Subject: [PATCH 1/2] block: return errors from blk_execute_rq()
Date:   Fri, 16 Apr 2021 09:53:52 -0700
Message-Id: <20210416165353.3088547-1-kbusch@kernel.org>
X-Mailer: git-send-email 2.25.4
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

The synchronous blk_execute_rq() had not provided a way for its callers
to know if its request was successful or not. Return the errno from the
completion status.

Reported-by: Yuanyuan Zhong <yzhong@purestorage.com>
Signed-off-by: Keith Busch <kbusch@kernel.org>
---
 block/blk-exec.c       | 6 ++++--
 include/linux/blkdev.h | 2 +-
 2 files changed, 5 insertions(+), 3 deletions(-)

diff --git a/block/blk-exec.c b/block/blk-exec.c
index beae70a0e5e5..3877a2677dd4 100644
--- a/block/blk-exec.c
+++ b/block/blk-exec.c
@@ -21,7 +21,7 @@ static void blk_end_sync_rq(struct request *rq, blk_status_t error)
 {
 	struct completion *waiting = rq->end_io_data;
 
-	rq->end_io_data = NULL;
+	rq->end_io_data = ERR_PTR(blk_status_to_errno(error));
 
 	/*
 	 * complete last, if this is a stack request the process (and thus
@@ -72,8 +72,9 @@ EXPORT_SYMBOL_GPL(blk_execute_rq_nowait);
  * Description:
  *    Insert a fully prepared request at the back of the I/O scheduler queue
  *    for execution and wait for completion.
+ * Return: The errno value of the blk_status_t provided to blk_mq_end_request().
  */
-void blk_execute_rq(struct gendisk *bd_disk, struct request *rq, int at_head)
+int blk_execute_rq(struct gendisk *bd_disk, struct request *rq, int at_head)
 {
 	DECLARE_COMPLETION_ONSTACK(wait);
 	unsigned long hang_check;
@@ -87,5 +88,6 @@ void blk_execute_rq(struct gendisk *bd_disk, struct request *rq, int at_head)
 		while (!wait_for_completion_io_timeout(&wait, hang_check * (HZ/2)));
 	else
 		wait_for_completion_io(&wait);
+	return PTR_ERR_OR_ZERO(rq->end_io_data);
 }
 EXPORT_SYMBOL(blk_execute_rq);
diff --git a/include/linux/blkdev.h b/include/linux/blkdev.h
index b91ba6207365..15e4ffac33af 100644
--- a/include/linux/blkdev.h
+++ b/include/linux/blkdev.h
@@ -938,7 +938,7 @@ extern int blk_rq_map_kern(struct request_queue *, struct request *, void *, uns
 extern int blk_rq_map_user_iov(struct request_queue *, struct request *,
 			       struct rq_map_data *, const struct iov_iter *,
 			       gfp_t);
-extern void blk_execute_rq(struct gendisk *, struct request *, int);
+extern int blk_execute_rq(struct gendisk *, struct request *, int);
 extern void blk_execute_rq_nowait(struct gendisk *,
 				  struct request *, int, rq_end_io_fn *);
 
-- 
2.25.4

