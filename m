Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mail-qk0-f196.google.com ([209.85.220.196]:36740 "EHLO
        mail-qk0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754234AbdC1Uhz (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 28 Mar 2017 16:37:55 -0400
Received: by mail-qk0-f196.google.com with SMTP id r142so10359449qke.3
        for <linux-block@vger.kernel.org>; Tue, 28 Mar 2017 13:37:54 -0700 (PDT)
From: Josef Bacik <josef@toxicpanda.com>
To: linux-block@vger.kernel.org, kernel-team@fb.com
Subject: [PATCH] block-mq: don't re-queue if we get a queue error
Date: Tue, 28 Mar 2017 16:37:52 -0400
Message-Id: <1490733472-3088-1-git-send-email-jbacik@fb.com>
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

When try to issue a request directly and we fail we will requeue the
request, but call blk_mq_end_request() as well.  This leads to the
completed request being on a queuelist and getting ended twice, which
causes list corruption in schedulers and other shenanigans.

Signed-off-by: Josef Bacik <jbacik@fb.com>
---
 block/blk-mq.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/block/blk-mq.c b/block/blk-mq.c
index 08a49c6..c5a6985 100644
--- a/block/blk-mq.c
+++ b/block/blk-mq.c
@@ -1457,8 +1457,6 @@ static void blk_mq_try_issue_directly(struct request *rq, blk_qc_t *cookie,
 		return;
 	}
 
-	__blk_mq_requeue_request(rq);
-
 	if (ret == BLK_MQ_RQ_QUEUE_ERROR) {
 		*cookie = BLK_QC_T_NONE;
 		rq->errors = -EIO;
@@ -1466,6 +1464,7 @@ static void blk_mq_try_issue_directly(struct request *rq, blk_qc_t *cookie,
 		return;
 	}
 
+	__blk_mq_requeue_request(rq);
 insert:
 	blk_mq_sched_insert_request(rq, false, true, false, may_sleep);
 }
-- 
2.7.4
