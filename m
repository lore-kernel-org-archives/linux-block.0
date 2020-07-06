Return-Path: <SRS0=7JbN=AR=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0454CC433DF
	for <linux-block@archiver.kernel.org>; Mon,  6 Jul 2020 14:41:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C57F02070C
	for <linux-block@archiver.kernel.org>; Mon,  6 Jul 2020 14:41:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="C9yWL8pp"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729186AbgGFOlJ (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 6 Jul 2020 10:41:09 -0400
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:46879 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1729140AbgGFOlJ (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 6 Jul 2020 10:41:09 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1594046467;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=RZLz2TvGlNW4VHfZVnuCtBVhDNr1EiCSgDVb01qC8Bg=;
        b=C9yWL8ppX50NTumrWfyYdl51n2ZFLm617hGil3cCiYuplftm1tmjk9+YRN7UZBp5uwjEvp
        +OPbktSmzDBtbQlDKbj8kOSZSi9xVqzZHb9h2UVbWY+t/ufzYM01hpJWdbo/B9NKMfbHhn
        ufjEPC37LPbImjbjTMuhGW5wk6tUBNI=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-226-_0s0Qc81OyCgK6DGU4malA-1; Mon, 06 Jul 2020 10:41:05 -0400
X-MC-Unique: _0s0Qc81OyCgK6DGU4malA-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id B6B85100CCC0;
        Mon,  6 Jul 2020 14:41:04 +0000 (UTC)
Received: from localhost (ovpn-12-99.pek2.redhat.com [10.72.12.99])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 29DCA60BF3;
        Mon,  6 Jul 2020 14:41:00 +0000 (UTC)
From:   Ming Lei <ming.lei@redhat.com>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org, Ming Lei <ming.lei@redhat.com>,
        Christoph Hellwig <hch@lst.de>
Subject: [PATCH] blk-mq: put driver tag when this request is completed
Date:   Mon,  6 Jul 2020 22:40:54 +0800
Message-Id: <20200706144054.3260791-1-ming.lei@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

It is natural to release driver tag when this request is completed by
LLD or device since its purpose is for LLD use.

One big benefit is that the released tag can be re-used quicker since
bio_endio() may take too long.

.complete() is usually called for notifying block layer that this request
is completed from LLD, and it is often the last thing done wrt. completion
from LLD viewpoint. Not see rq->tag is used in driver's complete() too.

Remove the warn in flush code because the driver tag should be released
in normal completion path, however we can't kill it because request may
be done directly via blk_mq_end_request(). Meantime not necessary to
check q->elevator cause blk_mq_put_driver_tag() has run the same check
already.

Cc: Christoph Hellwig <hch@lst.de>
Signed-off-by: Ming Lei <ming.lei@redhat.com>
---
 block/blk-flush.c | 5 +----
 block/blk-mq.c    | 2 ++
 2 files changed, 3 insertions(+), 4 deletions(-)

diff --git a/block/blk-flush.c b/block/blk-flush.c
index 15ae0155ec07..86a8b6e747df 100644
--- a/block/blk-flush.c
+++ b/block/blk-flush.c
@@ -341,10 +341,7 @@ static void mq_flush_data_end_io(struct request *rq, blk_status_t error)
 	unsigned long flags;
 	struct blk_flush_queue *fq = blk_get_flush_queue(q, ctx);
 
-	if (q->elevator) {
-		WARN_ON(rq->tag < 0);
-		blk_mq_put_driver_tag(rq);
-	}
+	blk_mq_put_driver_tag(rq);
 
 	/*
 	 * After populating an empty queue, kick it to avoid stall.  Read
diff --git a/block/blk-mq.c b/block/blk-mq.c
index abcf590f6238..117dec9abace 100644
--- a/block/blk-mq.c
+++ b/block/blk-mq.c
@@ -670,6 +670,8 @@ bool blk_mq_complete_request_remote(struct request *rq)
 {
 	WRITE_ONCE(rq->state, MQ_RQ_COMPLETE);
 
+	blk_mq_put_driver_tag(rq);
+
 	/*
 	 * For a polled request, always complete locallly, it's pointless
 	 * to redirect the completion.
-- 
2.25.2

