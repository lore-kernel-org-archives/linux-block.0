Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.4 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4E752C4338F
	for <linux-block@archiver.kernel.org>; Wed, 11 Aug 2021 14:26:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 22B0960F55
	for <linux-block@archiver.kernel.org>; Wed, 11 Aug 2021 14:26:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232224AbhHKO1M (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 11 Aug 2021 10:27:12 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:42985 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232137AbhHKO1K (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 11 Aug 2021 10:27:10 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1628692003;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=29H5JPDC+lOAV6Uwe5SCtsuESLD+98S9yPX9lp3tM1w=;
        b=SbIoUL7g6aeKXuIXyxioqLmG0PhJ8M3a86D+Y/8oVuMier30fHFKSbKLImMX1rWDM/0JQv
        ufLPl9yFpwFuI2jHPzKVy42kjT4ac12Ome+U9+OkAGEgVfJ3jRhTJoH05nFmNjsccopn9d
        9rNskQX5blsW1uqNvs8HQgSbBTrpp5c=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-196-yfCZ1c9PPG2kV7BG7lr9Ug-1; Wed, 11 Aug 2021 10:26:42 -0400
X-MC-Unique: yfCZ1c9PPG2kV7BG7lr9Ug-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id B62A093920;
        Wed, 11 Aug 2021 14:26:41 +0000 (UTC)
Received: from localhost (ovpn-12-52.pek2.redhat.com [10.72.12.52])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 4E5D719D9D;
        Wed, 11 Aug 2021 14:26:36 +0000 (UTC)
From:   Ming Lei <ming.lei@redhat.com>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org, Bart Van Assche <bvanassche@acm.org>,
        Christoph Hellwig <hch@lst.de>,
        John Garry <john.garry@huawei.com>,
        Ming Lei <ming.lei@redhat.com>,
        "Blank-Burian, Markus, Dr." <blankburian@uni-muenster.de>
Subject: [PATCH] blk-mq: fix kernel panic during iterating over flush request
Date:   Wed, 11 Aug 2021 22:26:24 +0800
Message-Id: <20210811142624.618598-1-ming.lei@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

For fixing use-after-free during iterating over requests, we grabbed
request's refcount before calling ->fn in commit 2e315dc07df0 ("blk-mq:
grab rq->refcount before calling ->fn in blk_mq_tagset_busy_iter").
Turns out this way may cause kernel panic when iterating over one flush
request:

1) old flush request's tag is just released, and this tag is reused by
one new request, but ->rqs[] isn't updated yet

2) the flush request can be re-used for submitting one new flush command,
so blk_rq_init() is called at the same time

3) meantime blk_mq_queue_tag_busy_iter() is called, and old flush request
is retrieved from ->rqs[tag]; when blk_mq_put_rq_ref() is called,
flush_rq->end_io may not be updated yet, so NULL pointer dereference
is triggered in blk_mq_put_rq_ref().

Fix the issue by calling refcount_set(&flush_rq->ref, 1) after
flush_rq->end_io is set. So far the only other caller of blk_rq_init() is
scsi_ioctl_reset() in which the request doesn't enter block IO stack and
the request reference count isn't used, so the change is safe.

Fixes: 2e315dc07df0 ("blk-mq: grab rq->refcount before calling ->fn in
blk_mq_tagset_busy_iter")
Reported-by: "Blank-Burian, Markus, Dr." <blankburian@uni-muenster.de>
Tested-by: "Blank-Burian, Markus, Dr." <blankburian@uni-muenster.de>
Signed-off-by: Ming Lei <ming.lei@redhat.com>
---
 block/blk-core.c  | 1 -
 block/blk-flush.c | 8 ++++++++
 2 files changed, 8 insertions(+), 1 deletion(-)

diff --git a/block/blk-core.c b/block/blk-core.c
index 0874bc2fcdb4..b5098739f72a 100644
--- a/block/blk-core.c
+++ b/block/blk-core.c
@@ -121,7 +121,6 @@ void blk_rq_init(struct request_queue *q, struct request *rq)
 	rq->internal_tag = BLK_MQ_NO_TAG;
 	rq->start_time_ns = ktime_get_ns();
 	rq->part = NULL;
-	refcount_set(&rq->ref, 1);
 	blk_crypto_rq_set_defaults(rq);
 }
 EXPORT_SYMBOL(blk_rq_init);
diff --git a/block/blk-flush.c b/block/blk-flush.c
index 1002f6c58181..4912c8dbb1d8 100644
--- a/block/blk-flush.c
+++ b/block/blk-flush.c
@@ -329,6 +329,14 @@ static void blk_kick_flush(struct request_queue *q, struct blk_flush_queue *fq,
 	flush_rq->rq_flags |= RQF_FLUSH_SEQ;
 	flush_rq->rq_disk = first_rq->rq_disk;
 	flush_rq->end_io = flush_end_io;
+	/*
+	 * Order WRITE ->end_io and WRITE rq->ref, and its pair is the one
+	 * implied in refcount_inc_not_zero() called from
+	 * blk_mq_find_and_get_req(), which orders WRITE/READ flush_rq->ref
+	 * and READ flush_rq->end_io
+	 */
+	smp_wmb();
+	refcount_set(&flush_rq->ref, 1);
 
 	blk_flush_queue_rq(flush_rq, false);
 }
-- 
2.31.1

