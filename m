Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 18C60C77B7D
	for <linux-block@archiver.kernel.org>; Thu, 18 May 2023 05:31:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229821AbjERFbO (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 18 May 2023 01:31:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55330 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229924AbjERFbO (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 18 May 2023 01:31:14 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7BB69F4
        for <linux-block@vger.kernel.org>; Wed, 17 May 2023 22:31:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description;
        bh=b+NyJ6ne5IQAlxXpMm0XosqQkAExWBAz2oSK5w0sKh8=; b=qiV3qQMOPAzV331kbd8XvN8kum
        cIBjSL38oXydvEjwm24/UrRH2uHzaLTGo0X/y32q/4hzhxyDne4UDaJw99Q4tL6DTZt2EcZkFHqpd
        A7EDMA7AqQYg9byVsizGHvl2V41ITO6Fvj3nVJrrOh3BGJzvU0AYM602Vl9u3t6YJI8hE/BP07J+e
        OuLvGBMDRvDVtfuXcL/tqBL6bXp0wGVUJEHHWWLHj1YcnkeNHymws08Gp/7evHbqZXqdRKJfmuLoG
        iWCH1BVvFZs5dh303I+spM1TXbdVo+QgsqglSvS4tZ0su6xLHR8HdgljUTjOZhivI9c98fjwV8ejq
        +xgIvfqg==;
Received: from [2001:4bb8:188:3dd5:c90:b13:29fb:f2b9] (helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
        id 1pzWEH-00BwdX-17;
        Thu, 18 May 2023 05:31:09 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Jens Axboe <axboe@kernel.dk>, Ming Lei <ming.lei@redhat.com>
Cc:     linux-block@vger.kernel.org
Subject: [PATCH 2/3] blk-mq: remove RQF_ELVPRIV
Date:   Thu, 18 May 2023 07:31:00 +0200
Message-Id: <20230518053101.760632-3-hch@lst.de>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230518053101.760632-1-hch@lst.de>
References: <20230518053101.760632-1-hch@lst.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

RQF_ELVPRIV is set for all non-flush requests that have RQF_ELV set.
Expand this condition in the two users of the flag and remove it.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 block/blk-mq-debugfs.c | 1 -
 block/blk-mq-sched.h   | 4 ++--
 block/blk-mq.c         | 6 ++----
 include/linux/blk-mq.h | 2 --
 4 files changed, 4 insertions(+), 9 deletions(-)

diff --git a/block/blk-mq-debugfs.c b/block/blk-mq-debugfs.c
index d23a8554ec4aeb..588b7048342bee 100644
--- a/block/blk-mq-debugfs.c
+++ b/block/blk-mq-debugfs.c
@@ -248,7 +248,6 @@ static const char *const rqf_name[] = {
 	RQF_NAME(DONTPREP),
 	RQF_NAME(FAILED),
 	RQF_NAME(QUIET),
-	RQF_NAME(ELVPRIV),
 	RQF_NAME(IO_STAT),
 	RQF_NAME(PM),
 	RQF_NAME(HASHED),
diff --git a/block/blk-mq-sched.h b/block/blk-mq-sched.h
index 7c3cbad17f3052..4d8d2cd3b47396 100644
--- a/block/blk-mq-sched.h
+++ b/block/blk-mq-sched.h
@@ -58,11 +58,11 @@ static inline void blk_mq_sched_completed_request(struct request *rq, u64 now)
 
 static inline void blk_mq_sched_requeue_request(struct request *rq)
 {
-	if (rq->rq_flags & RQF_ELV) {
+	if ((rq->rq_flags & RQF_ELV) && !op_is_flush(rq->cmd_flags)) {
 		struct request_queue *q = rq->q;
 		struct elevator_queue *e = q->elevator;
 
-		if ((rq->rq_flags & RQF_ELVPRIV) && e->type->ops.requeue_request)
+		if (e->type->ops.requeue_request)
 			e->type->ops.requeue_request(rq);
 	}
 }
diff --git a/block/blk-mq.c b/block/blk-mq.c
index 8b7e4daaa5b70d..7470c6636dc4f7 100644
--- a/block/blk-mq.c
+++ b/block/blk-mq.c
@@ -393,10 +393,8 @@ static struct request *blk_mq_rq_ctx_init(struct blk_mq_alloc_data *data,
 		RB_CLEAR_NODE(&rq->rb_node);
 
 		if (!op_is_flush(data->cmd_flags) &&
-		    e->type->ops.prepare_request) {
+		    e->type->ops.prepare_request)
 			e->type->ops.prepare_request(rq);
-			rq->rq_flags |= RQF_ELVPRIV;
-		}
 	}
 
 	return rq;
@@ -696,7 +694,7 @@ void blk_mq_free_request(struct request *rq)
 	struct request_queue *q = rq->q;
 	struct blk_mq_hw_ctx *hctx = rq->mq_hctx;
 
-	if ((rq->rq_flags & RQF_ELVPRIV) &&
+	if ((rq->rq_flags & RQF_ELV) && !op_is_flush(rq->cmd_flags) &&
 	    q->elevator->type->ops.finish_request)
 		q->elevator->type->ops.finish_request(rq);
 
diff --git a/include/linux/blk-mq.h b/include/linux/blk-mq.h
index 06caacd77ed668..5529e7d28ae6bb 100644
--- a/include/linux/blk-mq.h
+++ b/include/linux/blk-mq.h
@@ -42,8 +42,6 @@ typedef __u32 __bitwise req_flags_t;
 #define RQF_FAILED		((__force req_flags_t)(1 << 10))
 /* don't warn about errors */
 #define RQF_QUIET		((__force req_flags_t)(1 << 11))
-/* elevator private data attached */
-#define RQF_ELVPRIV		((__force req_flags_t)(1 << 12))
 /* account into disk and partition IO statistics */
 #define RQF_IO_STAT		((__force req_flags_t)(1 << 13))
 /* runtime pm request */
-- 
2.39.2

