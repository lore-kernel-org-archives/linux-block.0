Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7B922C433F5
	for <linux-block@archiver.kernel.org>; Wed,  6 Oct 2021 17:32:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 66EF4610C8
	for <linux-block@archiver.kernel.org>; Wed,  6 Oct 2021 17:32:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238932AbhJFRd5 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 6 Oct 2021 13:33:57 -0400
Received: from smtp-out2.suse.de ([195.135.220.29]:41960 "EHLO
        smtp-out2.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238424AbhJFRdv (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Wed, 6 Oct 2021 13:33:51 -0400
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out2.suse.de (Postfix) with ESMTP id CF80C1FEE8;
        Wed,  6 Oct 2021 17:31:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1633541517; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Q47AY5VQrvEGE/dtkE+SbOD8ZnK0Nig+WIn3fo5CDsc=;
        b=0Q+0aB5nkDd4OIQR/NdffdXTgDNpqRu9a9Y11WLdMXWrmC0AiY/XA4s9eqpWyEP9PTxtm8
        usjmzP5msVQhFH/5rcuroIYV72WVKv7gYe7603hAXtcLLPqtfIX/zMLs9nyn7ZWHn7mhOs
        w9ZeyencsQINFwsOyhkHP3gUuCTrVug=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1633541517;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Q47AY5VQrvEGE/dtkE+SbOD8ZnK0Nig+WIn3fo5CDsc=;
        b=lGd5hUc5mt7u3TRJS3q+FuUYuGFrr4kXjAdC6bJOrhwariu3ctf7oDmpCUpcPCTf3BpKEI
        ddILi8MjEPP7v+CA==
Received: from quack2.suse.cz (unknown [10.163.28.18])
        by relay2.suse.de (Postfix) with ESMTP id B75E4A3B8B;
        Wed,  6 Oct 2021 17:31:57 +0000 (UTC)
Received: by quack2.suse.cz (Postfix, from userid 1000)
        id 5D7F01E0BEA; Wed,  6 Oct 2021 19:31:57 +0200 (CEST)
From:   Jan Kara <jack@suse.cz>
To:     Paolo Valente <paolo.valente@linaro.org>
Cc:     <linux-block@vger.kernel.org>, Jens Axboe <axboe@kernel.dk>,
        =?UTF-8?q?Michal=20Koutn=C3=BD?= <mkoutny@suse.com>,
        Jan Kara <jack@suse.cz>
Subject: [PATCH 1/8] block: Provide icq in request allocation data
Date:   Wed,  6 Oct 2021 19:31:40 +0200
Message-Id: <20211006173157.6906-1-jack@suse.cz>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20211006164110.10817-1-jack@suse.cz>
References: <20211006164110.10817-1-jack@suse.cz>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=3457; h=from:subject; bh=BYzZGv61PbCxlfaIVFX4SHKjjCdlJNJtgeK7qNnI2NI=; b=owEBbQGS/pANAwAIAZydqgc/ZEDZAcsmYgBhXd18lT2/RHsaVreMm4V3vtk5IUcUrST0OFYBRNfG Ih25lM+JATMEAAEIAB0WIQSrWdEr1p4yirVVKBycnaoHP2RA2QUCYV3dfAAKCRCcnaoHP2RA2avUB/ 4nWd9yBmbmj6eYXrcvjvAFyT/+EBqkQlTC9yFzN0x9VnWlpxqs/+1QVol7N+t/eOqNGxo37PzIrwn9 JjyzAOXGZIEErFKyQeQxVTD94ufB3TWjMGLhv9xkaISIS8TBHnTd81EgHVxO4qHptP4RbNpEX2n/z+ 2eXQL8/OfSI701nj4yVPkAke6LelZPDzQJjlZ0p/WIPVH2nDrO0Ga3b6d4BO6hze7WwoxqARKFGz5/ H/cJzxppNmYUz1IFCzpf7glQ2VIejIZdW68WKkUdr0j/SAaOBQw+0F2d2d4lT90Cs97XatipfIuFM0 pVdG8hDZWgsfMZjwRejlPBU52aE7tR
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

Signed-off-by: Jan Kara <jack@suse.cz>
---
 block/blk-mq-sched.c | 18 ++++++++++--------
 block/blk-mq-sched.h |  3 ++-
 block/blk-mq.c       |  7 ++++---
 block/blk-mq.h       |  1 +
 4 files changed, 17 insertions(+), 12 deletions(-)

diff --git a/block/blk-mq-sched.c b/block/blk-mq-sched.c
index 0f006cabfd91..bbb6a677fdde 100644
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
index 5246ae040704..4529991e55e6 100644
--- a/block/blk-mq-sched.h
+++ b/block/blk-mq-sched.h
@@ -7,7 +7,8 @@
 
 #define MAX_SCHED_RQ (16 * BLKDEV_MAX_RQ)
 
-void blk_mq_sched_assign_ioc(struct request *rq);
+struct io_cq *blk_mq_sched_lookup_icq(struct request_queue *q);
+void blk_mq_sched_assign_ioc(struct request *rq, struct io_cq *icq);
 
 bool blk_mq_sched_try_merge(struct request_queue *q, struct bio *bio,
 		unsigned int nr_segs, struct request **merged_request);
diff --git a/block/blk-mq.c b/block/blk-mq.c
index 108a352051be..bf7dfd36d327 100644
--- a/block/blk-mq.c
+++ b/block/blk-mq.c
@@ -333,9 +333,7 @@ static struct request *blk_mq_rq_ctx_init(struct blk_mq_alloc_data *data,
 
 		rq->elv.icq = NULL;
 		if (e && e->type->ops.prepare_request) {
-			if (e->type->icq_cache)
-				blk_mq_sched_assign_ioc(rq);
-
+			blk_mq_sched_assign_ioc(rq, data->icq);
 			e->type->ops.prepare_request(rq);
 			rq->rq_flags |= RQF_ELVPRIV;
 		}
@@ -360,6 +358,9 @@ static struct request *__blk_mq_alloc_request(struct blk_mq_alloc_data *data)
 		data->flags |= BLK_MQ_REQ_NOWAIT;
 
 	if (e) {
+		if (!op_is_flush(data->cmd_flags) && e->type->icq_cache &&
+		    e->type->ops.prepare_request)
+			data->icq = blk_mq_sched_lookup_icq(q);
 		/*
 		 * Flush/passthrough requests are special and go directly to the
 		 * dispatch list. Don't include reserved tags in the
diff --git a/block/blk-mq.h b/block/blk-mq.h
index d08779f77a26..c502232384c6 100644
--- a/block/blk-mq.h
+++ b/block/blk-mq.h
@@ -151,6 +151,7 @@ static inline struct blk_mq_ctx *blk_mq_get_ctx(struct request_queue *q)
 struct blk_mq_alloc_data {
 	/* input parameter */
 	struct request_queue *q;
+	struct io_cq *icq;
 	blk_mq_req_flags_t flags;
 	unsigned int shallow_depth;
 	unsigned int cmd_flags;
-- 
2.26.2

