Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7D278C4332F
	for <linux-block@archiver.kernel.org>; Tue, 23 Nov 2021 10:32:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235321AbhKWKfI (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 23 Nov 2021 05:35:08 -0500
Received: from smtp-out2.suse.de ([195.135.220.29]:57456 "EHLO
        smtp-out2.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235161AbhKWKfH (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 23 Nov 2021 05:35:07 -0500
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out2.suse.de (Postfix) with ESMTP id 910F31FD58;
        Tue, 23 Nov 2021 10:31:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1637663518; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=o1uT5h4gJNrqrUpi4rykZ0zgzcKoL4KZYsnr/CLh4V0=;
        b=PAGfs/TteCWQl7SsyZFBNxRRLcUyaU1K5BEqdqrzbtcpMn2RJEOpQ8umnSbDcq7KAIbukD
        zYGugc/AayeV+eeG+Ao4vLiJdPIEUbGmpNeWBnzTBfAkqmWIPtYMUFpHNDihtbJFbBIwMv
        3mpTi67XQjQXcrGYvgS+85ww+QC7Ijc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1637663518;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=o1uT5h4gJNrqrUpi4rykZ0zgzcKoL4KZYsnr/CLh4V0=;
        b=wcE4hnDgiTAcWADVZ109nS/D1XqoLvGQ+vEcv8fPXxKbrOAmdYnqv0QUw0SnfJt3c+FaY3
        +5bFwqpdpNXehgDA==
Received: from quack2.suse.cz (unknown [10.100.200.198])
        by relay2.suse.de (Postfix) with ESMTP id 821BDA3B83;
        Tue, 23 Nov 2021 10:31:58 +0000 (UTC)
Received: by quack2.suse.cz (Postfix, from userid 1000)
        id 609AB1E11F3; Tue, 23 Nov 2021 11:31:58 +0100 (CET)
From:   Jan Kara <jack@suse.cz>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     <linux-block@vger.kernel.org>,
        Paolo Valente <paolo.valente@linaro.org>,
        Jan Kara <jack@suse.cz>
Subject: [PATCH 1/8] block: Provide icq in request allocation data
Date:   Tue, 23 Nov 2021 11:29:13 +0100
Message-Id: <20211123103158.17284-1-jack@suse.cz>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20211123101109.20879-1-jack@suse.cz>
References: <20211123101109.20879-1-jack@suse.cz>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=3555; h=from:subject; bh=1KiveMt0cTCKXr740nTli5j6YF/QaITfpTUGoLbvvuw=; b=owEBbQGS/pANAwAIAZydqgc/ZEDZAcsmYgBhnMJ5VdKxMoKRaFu7qEQR4ADw8pSQBRs5djrgR6kA SuiHhzCJATMEAAEIAB0WIQSrWdEr1p4yirVVKBycnaoHP2RA2QUCYZzCeQAKCRCcnaoHP2RA2f4YCA C9SYf91CNIFS7bPKrCbOn3F70rXibXcHbWJ3p1q35qCwUU9Vj99FLszuFBnzhQh2qdMNphFGxM1enR 4wiXqgaTKSRGyLfslBL4ZgeyFDku4C8zgdraJsNth2eF0ThFYYLPM3nRiFLXtAFiA6SAnQK+RhgMZB /3jzzfTV7IclIUpguEYIB3ZZD3rBEFbaBGXlV1OcvKi/wb8lnA4CFyIPd/nVtcjvUgLxfn/4/ZaMxz Z6Tho/SKfLxWoFyEOgiAm5fx7ad9Zh8BYNwg8CIauLCPof67bakOgk38tco7usxC2wkpvWZ+gHgc9t c2+UlaE+HTXveQMDFvDyAhwCPcaAI5
X-Developer-Key: i=jack@suse.cz; a=openpgp; fpr=93C6099A142276A28BBE35D815BC833443038D8C
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Currently we lookup ICQ only after the request is allocated. However BFQ
will want to decide how many scheduler tags it allows a given bfq queue
(effectively a process) to consume based on cgroup weight. So lookup ICQ
earlier and provide it in struct blk_mq_alloc_data so that BFQ can use
it.

Acked-by: Paolo Valente <paolo.valente@linaro.org>
Signed-off-by: Jan Kara <jack@suse.cz>
---
 block/blk-mq-sched.c | 18 ++++++++++--------
 block/blk-mq-sched.h |  3 ++-
 block/blk-mq.c       |  8 ++++----
 block/blk-mq.h       |  1 +
 4 files changed, 17 insertions(+), 13 deletions(-)

diff --git a/block/blk-mq-sched.c b/block/blk-mq-sched.c
index ba21449439cc..c4015b82a003 100644
--- a/block/blk-mq-sched.c
+++ b/block/blk-mq-sched.c
@@ -18,9 +18,8 @@
 #include "blk-mq-tag.h"
 #include "blk-wbt.h"
 
-void blk_mq_sched_assign_ioc(struct request *rq)
+struct io_cq *blk_mq_sched_lookup_icq(struct request_queue *q)
 {
-	struct request_queue *q = rq->q;
 	struct io_context *ioc;
 	struct io_cq *icq;
 
@@ -29,17 +28,20 @@ void blk_mq_sched_assign_ioc(struct request *rq)
 	 */
 	ioc = current->io_context;
 	if (!ioc)
-		return;
+		return NULL;
 
 	spin_lock_irq(&q->queue_lock);
 	icq = ioc_lookup_icq(ioc, q);
 	spin_unlock_irq(&q->queue_lock);
+	if (icq)
+		return icq;
+	return ioc_create_icq(ioc, q, GFP_ATOMIC);
+}
 
-	if (!icq) {
-		icq = ioc_create_icq(ioc, q, GFP_ATOMIC);
-		if (!icq)
-			return;
-	}
+void blk_mq_sched_assign_ioc(struct request *rq, struct io_cq *icq)
+{
+	if (!icq)
+		return;
 	get_io_context(icq->ioc);
 	rq->elv.icq = icq;
 }
diff --git a/block/blk-mq-sched.h b/block/blk-mq-sched.h
index 25d1034952b6..40be707f69d7 100644
--- a/block/blk-mq-sched.h
+++ b/block/blk-mq-sched.h
@@ -8,7 +8,8 @@
 
 #define MAX_SCHED_RQ (16 * BLKDEV_DEFAULT_RQ)
 
-void blk_mq_sched_assign_ioc(struct request *rq);
+struct io_cq *blk_mq_sched_lookup_icq(struct request_queue *q);
+void blk_mq_sched_assign_ioc(struct request *rq, struct io_cq *icq);
 
 bool blk_mq_sched_try_merge(struct request_queue *q, struct bio *bio,
 		unsigned int nr_segs, struct request **merged_request);
diff --git a/block/blk-mq.c b/block/blk-mq.c
index 8799fa73ef34..69b224c76d7c 100644
--- a/block/blk-mq.c
+++ b/block/blk-mq.c
@@ -388,9 +388,7 @@ static struct request *blk_mq_rq_ctx_init(struct blk_mq_alloc_data *data,
 
 		if (!op_is_flush(data->cmd_flags) &&
 		    e->type->ops.prepare_request) {
-			if (e->type->icq_cache)
-				blk_mq_sched_assign_ioc(rq);
-
+			blk_mq_sched_assign_ioc(rq, data->icq);
 			e->type->ops.prepare_request(rq);
 			rq->rq_flags |= RQF_ELVPRIV;
 		}
@@ -449,7 +447,9 @@ static struct request *__blk_mq_alloc_requests(struct blk_mq_alloc_data *data)
 		struct elevator_queue *e = q->elevator;
 
 		data->rq_flags |= RQF_ELV;
-
+		if (!op_is_flush(data->cmd_flags) && e->type->icq_cache &&
+		    e->type->ops.prepare_request)
+			data->icq = blk_mq_sched_lookup_icq(q);
 		/*
 		 * Flush/passthrough requests are special and go directly to the
 		 * dispatch list. Don't include reserved tags in the
diff --git a/block/blk-mq.h b/block/blk-mq.h
index afcf9931a489..4e9cf92ca587 100644
--- a/block/blk-mq.h
+++ b/block/blk-mq.h
@@ -152,6 +152,7 @@ static inline struct blk_mq_ctx *blk_mq_get_ctx(struct request_queue *q)
 struct blk_mq_alloc_data {
 	/* input parameter */
 	struct request_queue *q;
+	struct io_cq *icq;
 	blk_mq_req_flags_t flags;
 	unsigned int shallow_depth;
 	unsigned int cmd_flags;
-- 
2.26.2

