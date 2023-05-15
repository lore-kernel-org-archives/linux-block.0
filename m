Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2F814C7EE23
	for <linux-block@archiver.kernel.org>; Mon, 15 May 2023 14:49:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230052AbjEOOtK (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 15 May 2023 10:49:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39142 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235256AbjEOOtF (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 15 May 2023 10:49:05 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5EC191706
        for <linux-block@vger.kernel.org>; Mon, 15 May 2023 07:48:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1684162094;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=LKzOxUXNRXYGHNpkXcN+NrGDq0YHckYytoFpQi9yf/s=;
        b=I/KEPJz0iByh8P3Kzmi8SSvXNvmz/MtP9b3InmvZI3+tOZU6lnSCfCjBqnTth67GX3uX+T
        ZYbhoEz7bFBZ0JGm0zLKHN+5y6CHcQaYjvH9wSopCyoOGgMtLwIyS5WlpuaEa4y/3UsROj
        kEGg+oPjaMt2uYriAzFcIl23L5+y9o4=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-303-HsyYXzKrMUOMHNjc8jQ60A-1; Mon, 15 May 2023 10:48:10 -0400
X-MC-Unique: HsyYXzKrMUOMHNjc8jQ60A-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com [10.11.54.6])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 04DCD3847088;
        Mon, 15 May 2023 14:48:10 +0000 (UTC)
Received: from localhost (ovpn-8-26.pek2.redhat.com [10.72.8.26])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 2E1FE2166B26;
        Mon, 15 May 2023 14:48:08 +0000 (UTC)
From:   Ming Lei <ming.lei@redhat.com>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org, Christoph Hellwig <hch@lst.de>,
        Ming Lei <ming.lei@redhat.com>
Subject: [PATCH V2 2/2] blk-mq: make sure elevator callbacks aren't called for passthrough request
Date:   Mon, 15 May 2023 22:46:01 +0800
Message-Id: <20230515144601.52811-3-ming.lei@redhat.com>
In-Reply-To: <20230515144601.52811-1-ming.lei@redhat.com>
References: <20230515144601.52811-1-ming.lei@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.6
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

In case of q->elevator, passthrought request can still be marked as RQF_ELV,
so some elevator callbacks will be called for passthrough request.

Add helper of blk_mq_bypass_sched(), so that we can bypass elevator
callbacks for both flush and passthrough request.

Suggested-by: Christoph Hellwig <hch@lst.de>
Signed-off-by: Ming Lei <ming.lei@redhat.com>
---
 block/blk-mq-sched.h | 9 +++++++--
 block/blk-mq.c       | 5 ++---
 2 files changed, 9 insertions(+), 5 deletions(-)

diff --git a/block/blk-mq-sched.h b/block/blk-mq-sched.h
index 7c3cbad17f30..4aa879749843 100644
--- a/block/blk-mq-sched.h
+++ b/block/blk-mq-sched.h
@@ -22,6 +22,11 @@ int blk_mq_init_sched(struct request_queue *q, struct elevator_type *e);
 void blk_mq_exit_sched(struct request_queue *q, struct elevator_queue *e);
 void blk_mq_sched_free_rqs(struct request_queue *q);
 
+static inline bool blk_mq_bypass_sched(blk_opf_t cmd_flags)
+{
+	return op_is_flush(cmd_flags) || blk_op_is_passthrough(cmd_flags);
+}
+
 static inline void blk_mq_sched_restart(struct blk_mq_hw_ctx *hctx)
 {
 	if (test_bit(BLK_MQ_S_SCHED_RESTART, &hctx->state))
@@ -48,7 +53,7 @@ blk_mq_sched_allow_merge(struct request_queue *q, struct request *rq,
 
 static inline void blk_mq_sched_completed_request(struct request *rq, u64 now)
 {
-	if (rq->rq_flags & RQF_ELV) {
+	if ((rq->rq_flags & RQF_ELV) && !blk_mq_bypass_sched(rq->cmd_flags)) {
 		struct elevator_queue *e = rq->q->elevator;
 
 		if (e->type->ops.completed_request)
@@ -58,7 +63,7 @@ static inline void blk_mq_sched_completed_request(struct request *rq, u64 now)
 
 static inline void blk_mq_sched_requeue_request(struct request *rq)
 {
-	if (rq->rq_flags & RQF_ELV) {
+	if ((rq->rq_flags & RQF_ELV) && !blk_mq_bypass_sched(rq->cmd_flags)) {
 		struct request_queue *q = rq->q;
 		struct elevator_queue *e = q->elevator;
 
diff --git a/block/blk-mq.c b/block/blk-mq.c
index b4aaf42f1125..bd80fe3aa0c3 100644
--- a/block/blk-mq.c
+++ b/block/blk-mq.c
@@ -392,7 +392,7 @@ static struct request *blk_mq_rq_ctx_init(struct blk_mq_alloc_data *data,
 		INIT_HLIST_NODE(&rq->hash);
 		RB_CLEAR_NODE(&rq->rb_node);
 
-		if (!op_is_flush(data->cmd_flags) &&
+		if (!blk_mq_bypass_sched(data->cmd_flags) &&
 		    e->type->ops.prepare_request) {
 			e->type->ops.prepare_request(rq);
 			rq->rq_flags |= RQF_ELVPRIV;
@@ -458,8 +458,7 @@ static struct request *__blk_mq_alloc_requests(struct blk_mq_alloc_data *data)
 		 * dispatch list. Don't include reserved tags in the
 		 * limiting, as it isn't useful.
 		 */
-		if (!op_is_flush(data->cmd_flags) &&
-		    !blk_op_is_passthrough(data->cmd_flags) &&
+		if (!blk_mq_bypass_sched(data->cmd_flags) &&
 		    e->type->ops.limit_depth &&
 		    !(data->flags & BLK_MQ_REQ_RESERVED))
 			e->type->ops.limit_depth(data->cmd_flags, data);
-- 
2.40.1

