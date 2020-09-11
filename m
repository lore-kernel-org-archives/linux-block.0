Return-Path: <SRS0=ap3D=CU=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D2AE5C433E2
	for <linux-block@archiver.kernel.org>; Fri, 11 Sep 2020 09:45:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 73D1421D40
	for <linux-block@archiver.kernel.org>; Fri, 11 Sep 2020 09:45:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Er59G1Du"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725710AbgIKJpL (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 11 Sep 2020 05:45:11 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:25832 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1725554AbgIKJpK (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 11 Sep 2020 05:45:10 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1599817509;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=NqddnxdLvy7sSDr9O0Tc09AYl4o2yN5z3yG4wqceViY=;
        b=Er59G1DuO6Vu6Of67vXL2HPBkkrxk+nTrk+puHgyikpj00ACyn05tIrJhb8Lv0e9iCr5HI
        eCxmkprd9NlS2TleTB5PIi1dVjEILmUjw1Lm1nywq/6ThTBrNKLrQaOhmo4Y8NHuBNF6tr
        6kRjNi4grqjc7eGulPpziQhDp/pqJIg=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-596-v7At820LN6O0r06hihtswQ-1; Fri, 11 Sep 2020 05:45:07 -0400
X-MC-Unique: v7At820LN6O0r06hihtswQ-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 668F68030A2;
        Fri, 11 Sep 2020 09:45:06 +0000 (UTC)
Received: from localhost (ovpn-13-69.pek2.redhat.com [10.72.13.69])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 7B7AB7838A;
        Fri, 11 Sep 2020 09:45:02 +0000 (UTC)
From:   Ming Lei <ming.lei@redhat.com>
To:     Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
        linux-nvme@lists.infradead.org, Christoph Hellwig <hch@lst.de>
Cc:     Ming Lei <ming.lei@redhat.com>,
        David Milburn <dmilburn@redhat.com>,
        "Ewan D . Milne" <emilne@redhat.com>
Subject: [PATCH] blk-mq: always allow reserved allocation in hctx_may_queue
Date:   Fri, 11 Sep 2020 17:44:53 +0800
Message-Id: <20200911094453.160109-1-ming.lei@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

NVMe shares tagset between fabric queue and admin queue or between
connect_q and NS queue, so hctx_may_queue() can be called to allocate
request for these queues.

Tags can be reserved in these tagset. Before error recovery, there is
often lots of in-flight requests which can't be completed, and new
reserved request may be needed in error recovery path. However,
hctx_may_queue() can always return false because there is too many
in-flight requests which can't be completed during error handling.
Finally, everything can't move on.

Fix this issue by always allowing reserved tag allocation in
hctx_may_queue(). This ways is reasonable because reserved tag
suppose to be ready any time.

Cc: David Milburn <dmilburn@redhat.com>
Cc: Ewan D. Milne <emilne@redhat.com>
Signed-off-by: Ming Lei <ming.lei@redhat.com>
---
 block/blk-mq-tag.c | 3 ++-
 block/blk-mq.c     | 6 ++++--
 2 files changed, 6 insertions(+), 3 deletions(-)

diff --git a/block/blk-mq-tag.c b/block/blk-mq-tag.c
index c31c4a0478a5..aacf10decdbd 100644
--- a/block/blk-mq-tag.c
+++ b/block/blk-mq-tag.c
@@ -76,7 +76,8 @@ void __blk_mq_tag_idle(struct blk_mq_hw_ctx *hctx)
 static int __blk_mq_get_tag(struct blk_mq_alloc_data *data,
 			    struct sbitmap_queue *bt)
 {
-	if (!data->q->elevator && !hctx_may_queue(data->hctx, bt))
+	if (!data->q->elevator && !(data->flags & BLK_MQ_REQ_RESERVED) &&
+			!hctx_may_queue(data->hctx, bt))
 		return BLK_MQ_NO_TAG;
 
 	if (data->shallow_depth)
diff --git a/block/blk-mq.c b/block/blk-mq.c
index ccb500e38008..91cff275451d 100644
--- a/block/blk-mq.c
+++ b/block/blk-mq.c
@@ -1147,15 +1147,17 @@ static bool __blk_mq_get_driver_tag(struct request *rq)
 	struct sbitmap_queue *bt = rq->mq_hctx->tags->bitmap_tags;
 	unsigned int tag_offset = rq->mq_hctx->tags->nr_reserved_tags;
 	int tag;
+	bool reserved = blk_mq_tag_is_reserved(rq->mq_hctx->sched_tags,
+			rq->internal_tag);
 
 	blk_mq_tag_busy(rq->mq_hctx);
 
-	if (blk_mq_tag_is_reserved(rq->mq_hctx->sched_tags, rq->internal_tag)) {
+	if (reserved) {
 		bt = rq->mq_hctx->tags->breserved_tags;
 		tag_offset = 0;
 	}
 
-	if (!hctx_may_queue(rq->mq_hctx, bt))
+	if (!reserved && !hctx_may_queue(rq->mq_hctx, bt))
 		return false;
 	tag = __sbitmap_queue_get(bt);
 	if (tag == BLK_MQ_NO_TAG)
-- 
2.25.2

