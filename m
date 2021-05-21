Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-19.4 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4EE27C04FF3
	for <linux-block@archiver.kernel.org>; Fri, 21 May 2021 20:21:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2ECF361004
	for <linux-block@archiver.kernel.org>; Fri, 21 May 2021 20:21:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229956AbhEUUXQ (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 21 May 2021 16:23:16 -0400
Received: from mail.kernel.org ([198.145.29.99]:52776 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230232AbhEUUXN (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Fri, 21 May 2021 16:23:13 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 47FE5613E1;
        Fri, 21 May 2021 20:21:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1621628509;
        bh=v3hdv3iu9HLCg2cedhbPjMkbdA9FOAxbHYeM5WwndgQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=PUzIS+ONKMYdkLxeXjeuSDUDiFqQ9F71W3lNP/8av7Nt5tsUxHODAXe11Ie/SkOvW
         3JpQS8iojO1quACYhIlPrP0Wq6qn0OMr42+GYaQzLCxv3a8SnjjyGuepDdFcQEcE8D
         ST1V/sQGwD3oXppkuSeekDZeLpzbwPJUspZWpFDkE7d4CehyYa5eocEYMUcjnV/bg2
         4M4s/iM64+P/oMcxlEkvi/Q6IjH/C6a5yFsnLXgZffKxHsH5M62Co5GW0FcCtVNAGT
         k+c9/W3i3ceSl75pdQ9rfJ5bArnaU0lw/PULB89rOuD7m1q+YY/F0zaE9tpjnvbciQ
         DShdCLWcqNLqQ==
From:   Keith Busch <kbusch@kernel.org>
To:     linux-nvme@lists.infradead.org, sagi@grimberg.me, hch@lst.de,
        axboe@kernel.dk, linux-block@vger.kernel.org
Cc:     Yuanyuan Zhong <yzhong@purestorage.com>,
        Casey Chen <cachen@purestorage.com>,
        Ming Lei <ming.lei@redhat.com>, Keith Busch <kbusch@kernel.org>
Subject: [PATCHv3 3/4] block: return errors from blk_execute_rq()
Date:   Fri, 21 May 2021 13:21:44 -0700
Message-Id: <20210521202145.3674904-4-kbusch@kernel.org>
X-Mailer: git-send-email 2.25.4
In-Reply-To: <20210521202145.3674904-1-kbusch@kernel.org>
References: <20210521202145.3674904-1-kbusch@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

The synchronous blk_execute_rq() had not provided a way for its callers
to know if its request was successful or not. Return the blk_status_t
result of the request.

Signed-off-by: Keith Busch <kbusch@kernel.org>
---
v2->v3:

  Return blk_status_t instead of errno.

  Removed "extern" header declaration, and named the parameters.

 block/blk-exec.c       | 7 +++++--
 include/linux/blkdev.h | 4 +++-
 2 files changed, 8 insertions(+), 3 deletions(-)

diff --git a/block/blk-exec.c b/block/blk-exec.c
index 38f88552aa31..d6cd501c0d34 100644
--- a/block/blk-exec.c
+++ b/block/blk-exec.c
@@ -21,7 +21,7 @@ static void blk_end_sync_rq(struct request *rq, blk_status_t error)
 {
 	struct completion *waiting = rq->end_io_data;
 
-	rq->end_io_data = NULL;
+	rq->end_io_data = (void *)(uintptr_t)error;
 
 	/*
 	 * complete last, if this is a stack request the process (and thus
@@ -85,8 +85,9 @@ static void blk_rq_poll_completion(struct request *rq, struct completion *wait)
  * Description:
  *    Insert a fully prepared request at the back of the I/O scheduler queue
  *    for execution and wait for completion.
+ * Return: The blk_status_t result provided to blk_mq_end_request().
  */
-void blk_execute_rq(struct gendisk *bd_disk, struct request *rq, int at_head)
+blk_status_t blk_execute_rq(struct gendisk *bd_disk, struct request *rq, int at_head)
 {
 	DECLARE_COMPLETION_ONSTACK(wait);
 	unsigned long hang_check;
@@ -103,5 +104,7 @@ void blk_execute_rq(struct gendisk *bd_disk, struct request *rq, int at_head)
 		while (!wait_for_completion_io_timeout(&wait, hang_check * (HZ/2)));
 	else
 		wait_for_completion_io(&wait);
+
+	return (blk_status_t)(uintptr_t)rq->end_io_data;
 }
 EXPORT_SYMBOL(blk_execute_rq);
diff --git a/include/linux/blkdev.h b/include/linux/blkdev.h
index 2c28577b50f4..2d2b477241ba 100644
--- a/include/linux/blkdev.h
+++ b/include/linux/blkdev.h
@@ -936,10 +936,12 @@ extern int blk_rq_map_kern(struct request_queue *, struct request *, void *, uns
 extern int blk_rq_map_user_iov(struct request_queue *, struct request *,
 			       struct rq_map_data *, const struct iov_iter *,
 			       gfp_t);
-extern void blk_execute_rq(struct gendisk *, struct request *, int);
 extern void blk_execute_rq_nowait(struct gendisk *,
 				  struct request *, int, rq_end_io_fn *);
 
+blk_status_t blk_execute_rq(struct gendisk *bd_disk, struct request *rq,
+			    int at_head);
+
 /* Helper to convert REQ_OP_XXX to its string format XXX */
 extern const char *blk_op_str(unsigned int op);
 
-- 
2.25.4

