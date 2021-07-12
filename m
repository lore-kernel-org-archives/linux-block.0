Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2D219C11F67
	for <linux-block@archiver.kernel.org>; Mon, 12 Jul 2021 17:27:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1463C6124C
	for <linux-block@archiver.kernel.org>; Mon, 12 Jul 2021 17:27:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230033AbhGLRap (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 12 Jul 2021 13:30:45 -0400
Received: from smtp-out1.suse.de ([195.135.220.28]:38014 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235167AbhGLRao (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 12 Jul 2021 13:30:44 -0400
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out1.suse.de (Postfix) with ESMTP id 929CD2210D;
        Mon, 12 Jul 2021 17:27:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1626110875; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=3/tUVLi/1ehnmWuHgEgGk245sp/nozJ2MMa9O6HKxS0=;
        b=wFQlj4agPAQH3TQMLGDVSHAJW7SKkF05ySsCgZJr5E8MdZN7VazIkk22lJ4G+WYhTYGwAA
        LfybVKslljmRq9247glhR081hxXmQgotM0r7Lue2EtRuq9JC/vTuLJzeGwat39Oq1ue3t2
        4BJ6qf6Ec/ce5cignOZ747aM6++jKc8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1626110875;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=3/tUVLi/1ehnmWuHgEgGk245sp/nozJ2MMa9O6HKxS0=;
        b=oxi1RYM/5s3pr+8CRAr2bFgJcWhbdW1myMRst1t6eT+s5+DtL49+LDTjF5l2rIHh6GS7/U
        c9H861zisSatvgAg==
Received: from quack2.suse.cz (unknown [10.100.224.230])
        by relay2.suse.de (Postfix) with ESMTP id 854D1A3B84;
        Mon, 12 Jul 2021 17:27:55 +0000 (UTC)
Received: by quack2.suse.cz (Postfix, from userid 1000)
        id 632C01E0814; Mon, 12 Jul 2021 19:27:55 +0200 (CEST)
From:   Jan Kara <jack@suse.cz>
To:     <linux-block@vger.kernel.org>
Cc:     Paolo Valente <paolo.valente@linaro.org>,
        Jens Axboe <axboe@kernel.dk>, mkoutny@suse.cz,
        Jan Kara <jack@suse.cz>
Subject: [PATCH 1/3] block: Provide icq in request allocation data
Date:   Mon, 12 Jul 2021 19:27:37 +0200
Message-Id: <20210712172755.2414-1-jack@suse.cz>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20210712171146.12231-1-jack@suse.cz>
References: <20210712171146.12231-1-jack@suse.cz>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=3457; h=from:subject; bh=C9/rcXsJhybvwsy9P2BOMgpKKdd8LFIsH6x/qoBn5qE=; b=owEBbQGS/pANAwAIAZydqgc/ZEDZAcsmYgBg7HuJEv78bjRoD4TE+LDq/t91D9dk+MIUVgVsCKR3 N93t4vSJATMEAAEIAB0WIQSrWdEr1p4yirVVKBycnaoHP2RA2QUCYOx7iQAKCRCcnaoHP2RA2daaB/ 0RhK3qmPZ0GDjcYUqrQivuA+WUeWdPVDQ8UCwHb9wSDQm/HPXwr0IsePMS/2+ubOVTKewzU6wVb9eR Srry75Tb0QFkKI/ED+8rzaFIp6NzWMkL/SP8ZjBn6cn7hII//e/OZ9nsHBrEmX17xh2WbwOz0klkbt 3swcj5ROjuW75ZCj/Tjex1PiT5TwSpRTBK05Q7l6G19cxqbQV5iaUaH8Kdo/kiXcuTWF56Lay+7i/+ ZpI5UOsFqbFQHEDhc4HV5IgTQ4bLqnZrYlSXTUnFq6IwzUpbe7a9tp9G1gSnv35G0orLvv2chdn4iR ItwlVWY0mhmg4j+UPuTDGiMcgBYZmo
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
index c838d81ac058..3e34f5bb24ae 100644
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
index 2c4ac51e54eb..b9d83644158f 100644
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

