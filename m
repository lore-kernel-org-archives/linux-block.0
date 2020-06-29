Return-Path: <SRS0=rGXo=AK=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1CCAFC433E3
	for <linux-block@archiver.kernel.org>; Mon, 29 Jun 2020 18:49:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 01D832065D
	for <linux-block@archiver.kernel.org>; Mon, 29 Jun 2020 18:49:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="XiybcLvg"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728087AbgF2Stq (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 29 Jun 2020 14:49:46 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:55642 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1729445AbgF2Stp (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 29 Jun 2020 14:49:45 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1593456584;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=64AYWSEYnEvzLO9xmX08y6jDYpudaey6r+JVc+MDhnQ=;
        b=XiybcLvgWPuIOzKy6Im4X92ZCBcSP9BtSOIa4JI/6zfzLEiutQGqALTVOjG5gE3AMyxXLv
        ZY74XpxBY9+gN/HRJa0NpM0CReuobL6yIcg4HwKBwz7jWLFkXmW9mkmqnB7F/gqqXTEJ7Y
        5Mt9twfLC1On1rb6VsgixdskMMyhWQA=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-109-yUkdc4hhNOiRV7z_-zuKgg-1; Mon, 29 Jun 2020 05:48:10 -0400
X-MC-Unique: yUkdc4hhNOiRV7z_-zuKgg-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 068B3C7442;
        Mon, 29 Jun 2020 09:48:09 +0000 (UTC)
Received: from localhost (ovpn-13-98.pek2.redhat.com [10.72.13.98])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 34D872B470;
        Mon, 29 Jun 2020 09:48:02 +0000 (UTC)
From:   Ming Lei <ming.lei@redhat.com>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org, Ming Lei <ming.lei@redhat.com>,
        Christoph Hellwig <hch@lst.de>
Subject: [PATCH] blk-mq: put driver tag when this request is completed
Date:   Mon, 29 Jun 2020 17:47:59 +0800
Message-Id: <20200629094759.2002708-1-ming.lei@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

It is natural to release driver tag when this request is completed by
LLD or device since its purpose is for LLD use.

One big benefit is that the released tag can be re-used quicker since
bio_endio() may take too long.

Meantime we don't need to release driver tag for flush request.

Cc: Christoph Hellwig <hch@lst.de>
Signed-off-by: Ming Lei <ming.lei@redhat.com>
---
 block/blk-flush.c | 6 ------
 block/blk-mq.c    | 2 ++
 2 files changed, 2 insertions(+), 6 deletions(-)

diff --git a/block/blk-flush.c b/block/blk-flush.c
index 15ae0155ec07..21108a550fbf 100644
--- a/block/blk-flush.c
+++ b/block/blk-flush.c
@@ -240,7 +240,6 @@ static void flush_end_io(struct request *flush_rq, blk_status_t error)
 		blk_mq_tag_set_rq(hctx, flush_rq->tag, fq->orig_rq);
 		flush_rq->tag = -1;
 	} else {
-		blk_mq_put_driver_tag(flush_rq);
 		flush_rq->internal_tag = -1;
 	}
 
@@ -341,11 +340,6 @@ static void mq_flush_data_end_io(struct request *rq, blk_status_t error)
 	unsigned long flags;
 	struct blk_flush_queue *fq = blk_get_flush_queue(q, ctx);
 
-	if (q->elevator) {
-		WARN_ON(rq->tag < 0);
-		blk_mq_put_driver_tag(rq);
-	}
-
 	/*
 	 * After populating an empty queue, kick it to avoid stall.  Read
 	 * the comment in flush_end_io().
diff --git a/block/blk-mq.c b/block/blk-mq.c
index b8738b3c6d06..d07e55455726 100644
--- a/block/blk-mq.c
+++ b/block/blk-mq.c
@@ -674,6 +674,8 @@ bool blk_mq_complete_request_remote(struct request *rq)
 {
 	WRITE_ONCE(rq->state, MQ_RQ_COMPLETE);
 
+	blk_mq_put_driver_tag(rq);
+
 	/*
 	 * For a polled request, always complete locallly, it's pointless
 	 * to redirect the completion.
-- 
2.25.2

