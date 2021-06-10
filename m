Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-19.2 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 57E97C48BE5
	for <linux-block@archiver.kernel.org>; Thu, 10 Jun 2021 21:44:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 43ACC61431
	for <linux-block@archiver.kernel.org>; Thu, 10 Jun 2021 21:44:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230409AbhFJVqv (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 10 Jun 2021 17:46:51 -0400
Received: from mail.kernel.org ([198.145.29.99]:54014 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230396AbhFJVqv (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Thu, 10 Jun 2021 17:46:51 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 0FC6B6141E;
        Thu, 10 Jun 2021 21:44:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1623361494;
        bh=5NnqWgdUSmnhJ4VMWKmSo+mlPmzoI8B/UqaWYbWWaps=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=WvPTO7Mz0UF9UdLSO9BiLwCmtYGquZX98UyuoExZXQCDuss7WAnxaTg30VmwrXbrP
         +Qn0bIKLdlfACUFlckMLxsFvpCuSppm6cGAxgaWbwpf+rpwiEJl5rtkCef9zeEvH5a
         XgvieHa2WvwdRMo7v7+N4vE76FpwZrIpeInj4FW+ECYC7vRYD+V5MbkN6xmXr+nqx5
         fX/nr2rWG7tSfsdPRBSTxRQBXVAeLqe3NmOlWUBxpdCXTb48naSlGq1HrSTbzmA3W2
         UdGTOPGFi9V4f7HfcblvE8cIQvs2T1zatxPIBzAz+usit2OtzZeo1OIZDaudA8/Qcc
         FQXOm+By7c5+w==
From:   Keith Busch <kbusch@kernel.org>
To:     linux-nvme@lists.infradead.org, sagi@grimberg.me, hch@lst.de,
        linux-block@vger.kernel.org
Cc:     axboe@kernel.dk, Yuanyuan Zhong <yzhong@purestorage.com>,
        Casey Chen <cachen@purestorage.com>,
        Ming Lei <ming.lei@redhat.com>, Keith Busch <kbusch@kernel.org>
Subject: [PATCHv4 3/4] block: return errors from blk_execute_rq()
Date:   Thu, 10 Jun 2021 14:44:36 -0700
Message-Id: <20210610214437.641245-4-kbusch@kernel.org>
X-Mailer: git-send-email 2.25.4
In-Reply-To: <20210610214437.641245-1-kbusch@kernel.org>
References: <20210610214437.641245-1-kbusch@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

The synchronous blk_execute_rq() had not provided a way for its callers
to know if its request was successful or not. Return the blk_status_t
result of the request.

Reviewed-by: Christoph Hellwig <hch@lst.de>
Reviewed-by: Ming Lei <ming.lei@redhat.com>
Signed-off-by: Keith Busch <kbusch@kernel.org>
---
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
index d66d0da72529..1261e1fe88bd 100644
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

