Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.4 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 255A3C4338F
	for <linux-block@archiver.kernel.org>; Wed, 18 Aug 2021 01:09:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0B13860FD7
	for <linux-block@archiver.kernel.org>; Wed, 18 Aug 2021 01:09:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237398AbhHRBKY (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 17 Aug 2021 21:10:24 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:45127 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S237387AbhHRBKY (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 17 Aug 2021 21:10:24 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1629248990;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=RCCWvDjY3Q5IUVIs6QPft/4AsaIoSIpdIehWy1LmRPw=;
        b=KVIlxSHlxcIMo90i6tn1bknsi0b7R2emGgsTPjFMxQpxWC/+1fpPXthsx4rtlOk9WBJwsM
        iEq7lO7+NgYLpD+UOuZBDlItPioApbQhzD3GY9vnrp9GZtY0Q/mhIisg4a6lt0s5aMxM2X
        YigYfaHbA6An7Jg4vhXZB+UkOWE9Fy4=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-595-EplxXfUgPSybCuxqFm9pLA-1; Tue, 17 Aug 2021 21:09:46 -0400
X-MC-Unique: EplxXfUgPSybCuxqFm9pLA-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 4EFF5760C0;
        Wed, 18 Aug 2021 01:09:45 +0000 (UTC)
Received: from localhost (ovpn-8-28.pek2.redhat.com [10.72.8.28])
        by smtp.corp.redhat.com (Postfix) with ESMTP id DCFD91B46B;
        Wed, 18 Aug 2021 01:09:39 +0000 (UTC)
From:   Ming Lei <ming.lei@redhat.com>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org, Christoph Hellwig <hch@lst.de>,
        Bart Van Assche <bvanassche@acm.org>,
        John Garry <john.garry@huawei.com>,
        Ming Lei <ming.lei@redhat.com>,
        "Blank-Burian, Markus, Dr." <blankburian@uni-muenster.de>,
        Yufen Yu <yuyufen@huawei.com>
Subject: [PATCH] blk-mq: fix is_flush_rq
Date:   Wed, 18 Aug 2021 09:09:25 +0800
Message-Id: <20210818010925.607383-1-ming.lei@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

is_flush_rq() is called from bt_iter()/bt_tags_iter(), and runs the
following check:

	hctx->fq->flush_rq == req

but the passed hctx from bt_iter()/bt_tags_iter() may be NULL because:

1) memory re-order in blk_mq_rq_ctx_init():

	rq->mq_hctx = data->hctx;
	...
	refcount_set(&rq->ref, 1);

OR

2) tag re-use and ->rqs[] isn't updated with new request.

Fix the issue by re-writing is_flush_rq() as:

	return rq->end_io == flush_end_io;

which turns out simpler to follow and immune to data race since we have
ordered WRITE rq->end_io and refcount_set(&rq->ref, 1).

Fixes: 2e315dc07df0 ("blk-mq: grab rq->refcount before calling ->fn in
    blk_mq_tagset_busy_iter")
Cc: "Blank-Burian, Markus, Dr." <blankburian@uni-muenster.de>
Cc: Yufen Yu <yuyufen@huawei.com>
Signed-off-by: Ming Lei <ming.lei@redhat.com>
---
 block/blk-flush.c | 5 +++++
 block/blk-mq.c    | 2 +-
 block/blk.h       | 6 +-----
 3 files changed, 7 insertions(+), 6 deletions(-)

diff --git a/block/blk-flush.c b/block/blk-flush.c
index 4912c8dbb1d8..4201728bf3a5 100644
--- a/block/blk-flush.c
+++ b/block/blk-flush.c
@@ -262,6 +262,11 @@ static void flush_end_io(struct request *flush_rq, blk_status_t error)
 	spin_unlock_irqrestore(&fq->mq_flush_lock, flags);
 }
 
+bool is_flush_rq(struct request *rq)
+{
+	return rq->end_io == flush_end_io;
+}
+
 /**
  * blk_kick_flush - consider issuing flush request
  * @q: request_queue being kicked
diff --git a/block/blk-mq.c b/block/blk-mq.c
index b5237211ccb7..6d7395ad6d94 100644
--- a/block/blk-mq.c
+++ b/block/blk-mq.c
@@ -911,7 +911,7 @@ static bool blk_mq_req_expired(struct request *rq, unsigned long *next)
 
 void blk_mq_put_rq_ref(struct request *rq)
 {
-	if (is_flush_rq(rq, rq->mq_hctx))
+	if (is_flush_rq(rq))
 		rq->end_io(rq, 0);
 	else if (refcount_dec_and_test(&rq->ref))
 		__blk_mq_free_request(rq);
diff --git a/block/blk.h b/block/blk.h
index 56f33fbcde59..d4fb5b72d12b 100644
--- a/block/blk.h
+++ b/block/blk.h
@@ -44,11 +44,7 @@ static inline void __blk_get_queue(struct request_queue *q)
 	kobject_get(&q->kobj);
 }
 
-static inline bool
-is_flush_rq(struct request *req, struct blk_mq_hw_ctx *hctx)
-{
-	return hctx->fq->flush_rq == req;
-}
+bool is_flush_rq(struct request *req);
 
 struct blk_flush_queue *blk_alloc_flush_queue(int node, int cmd_size,
 					      gfp_t flags);
-- 
2.31.1

