Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E6FA9C433FE
	for <linux-block@archiver.kernel.org>; Tue, 19 Oct 2021 13:39:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C72C26137B
	for <linux-block@archiver.kernel.org>; Tue, 19 Oct 2021 13:39:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235739AbhJSNmH (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 19 Oct 2021 09:42:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53290 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235804AbhJSNmG (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 19 Oct 2021 09:42:06 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 246ECC06161C
        for <linux-block@vger.kernel.org>; Tue, 19 Oct 2021 06:39:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description;
        bh=FpEwROWHkTbPXaCNWSKg553Xi8VarHybLfyPgBJgOz0=; b=joMa08lRiVIyfKYhp5D5F53hlR
        DPzv7ya4QdmTNhtJxGmSONyYLx6OnnQo2SCCiHS7InL4gHtd4F4JrRtVtRtaNNh1+geJlwTb7sYs9
        ArbxARTQ5TELx6r3k7foV+497+FstC19Uhi28cxg5wGcn+s0LGM5fb6D67fVC38o6ZEB0e5pGjteo
        dHv18OfkNC/EoV2QbTCQ3fL4cBSTV0gbjckIBd151L/MHHWkU9f8a+AnUHlc84Jq6hCCmpmZbZF94
        7QeZL9jpH+yAHEoLAvtB/AdhYQPhom7Mqa4i4sKAX+DBlgMwt/FJArlM8Ee4IKbRMW2dJ0anUnTFi
        O9Qoaenw==;
Received: from [2001:4bb8:180:8777:c70:4a89:bc61:2] (helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1mcpLN-001RpP-DS; Tue, 19 Oct 2021 13:39:53 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org
Subject: [PATCH 2/2] blk-mq: remove RQF_ELVPRIV
Date:   Tue, 19 Oct 2021 15:39:44 +0200
Message-Id: <20211019133944.2500822-3-hch@lst.de>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20211019133944.2500822-1-hch@lst.de>
References: <20211019133944.2500822-1-hch@lst.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

RQF_ELVPRIV is set for all non-flush requests that have an I/O scheduler
with a prepare_request method, and it is checked in a single place where
we already know that the request was initialized and has an I/O
scheduler.  Given that there is no I/O scheduler that has a
requeue_request method but not prepare_request method there is no need
for this extra flag.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 block/blk-mq-debugfs.c | 1 -
 block/blk-mq-sched.h   | 5 ++---
 block/blk-mq.c         | 1 -
 include/linux/blk-mq.h | 2 --
 4 files changed, 2 insertions(+), 7 deletions(-)

diff --git a/block/blk-mq-debugfs.c b/block/blk-mq-debugfs.c
index a317f05de466a..efd48992bda09 100644
--- a/block/blk-mq-debugfs.c
+++ b/block/blk-mq-debugfs.c
@@ -300,7 +300,6 @@ static const char *const rqf_name[] = {
 	RQF_NAME(DONTPREP),
 	RQF_NAME(FAILED),
 	RQF_NAME(QUIET),
-	RQF_NAME(ELVPRIV),
 	RQF_NAME(IO_STAT),
 	RQF_NAME(PM),
 	RQF_NAME(HASHED),
diff --git a/block/blk-mq-sched.h b/block/blk-mq-sched.h
index 98836106b25fc..6de63222c16d1 100644
--- a/block/blk-mq-sched.h
+++ b/block/blk-mq-sched.h
@@ -78,10 +78,9 @@ static inline void blk_mq_sched_completed_request(struct request *rq, u64 now)
 static inline void blk_mq_sched_requeue_request(struct request *rq)
 {
 	if (rq->rq_flags & RQF_ELV) {
-		struct request_queue *q = rq->q;
-		struct elevator_queue *e = q->elevator;
+		struct elevator_queue *e = rq->q->elevator;
 
-		if ((rq->rq_flags & RQF_ELVPRIV) && e->type->ops.requeue_request)
+		if (!op_is_flush(rq->cmd_flags) && e->type->ops.requeue_request)
 			e->type->ops.requeue_request(rq);
 	}
 }
diff --git a/block/blk-mq.c b/block/blk-mq.c
index 34392c439d2a8..d2dad19d5b85c 100644
--- a/block/blk-mq.c
+++ b/block/blk-mq.c
@@ -369,7 +369,6 @@ static struct request *blk_mq_rq_ctx_init(struct blk_mq_alloc_data *data,
 				blk_mq_sched_assign_ioc(rq);
 
 			e->type->ops.prepare_request(rq);
-			rq->rq_flags |= RQF_ELVPRIV;
 		}
 	}
 
diff --git a/include/linux/blk-mq.h b/include/linux/blk-mq.h
index 649be3f21d740..ad810e1be8f29 100644
--- a/include/linux/blk-mq.h
+++ b/include/linux/blk-mq.h
@@ -37,8 +37,6 @@ typedef __u32 __bitwise req_flags_t;
 /* don't warn about errors */
 #define RQF_QUIET		((__force req_flags_t)(1 << 11))
 /* elevator private data attached */
-#define RQF_ELVPRIV		((__force req_flags_t)(1 << 12))
-/* account into disk and partition IO statistics */
 #define RQF_IO_STAT		((__force req_flags_t)(1 << 13))
 /* runtime pm request */
 #define RQF_PM			((__force req_flags_t)(1 << 15))
-- 
2.30.2

