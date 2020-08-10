Return-Path: <SRS0=DoUd=BU=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0B8E7C433E0
	for <linux-block@archiver.kernel.org>; Mon, 10 Aug 2020 04:00:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DC0C82073E
	for <linux-block@archiver.kernel.org>; Mon, 10 Aug 2020 04:00:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="V4fe1jau"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725773AbgHJEAM (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 10 Aug 2020 00:00:12 -0400
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:44587 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725536AbgHJEAM (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 10 Aug 2020 00:00:12 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1597032010;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=/t7jFdmrTOuktoYYoxaAgQx/QpmEF0ZZo+hK9Vpgbgg=;
        b=V4fe1jauoEUntc5Wct0pqZfk9lLuknz/auZTamm3FeV/87yxfzVeYOkk4P1yugzRu6ueq9
        ZvmlJvQoOqDPUbL8ruZDzi4LPqRqiOzfKiHFoTt8HVp4dkRac6Rf42XkOcfoA1ZFQ9wHGe
        EpNPTQzBDgItXhbrIamSkIgSQbhlIlY=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-93-ebXNh4qgNV-IuHKBiIc2RA-1; Mon, 10 Aug 2020 00:00:04 -0400
X-MC-Unique: ebXNh4qgNV-IuHKBiIc2RA-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 6749880572B;
        Mon, 10 Aug 2020 04:00:03 +0000 (UTC)
Received: from localhost (ovpn-13-99.pek2.redhat.com [10.72.13.99])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 7AA0A8FF9F;
        Mon, 10 Aug 2020 03:59:59 +0000 (UTC)
From:   Ming Lei <ming.lei@redhat.com>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org, Ming Lei <ming.lei@redhat.com>,
        Matthew Wilcox <willy@infradead.org>,
        Christoph Hellwig <hch@infradead.org>
Subject: [PATCH] block: fix double account of flush request's driver tag
Date:   Mon, 10 Aug 2020 11:59:50 +0800
Message-Id: <20200810035950.2211549-1-ming.lei@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

In case of none scheduler, we share data request's driver tag for
flush request, so have to mark the flush request as INFLIGHT for
avoiding double account of this driver tag.

Signed-off-by: Ming Lei <ming.lei@redhat.com>
Fixes: 568f27006577 ("blk-mq: centralise related handling into blk_mq_get_driver_tag")
Reported-by: Matthew Wilcox <willy@infradead.org>
Tested-by: Matthew Wilcox <willy@infradead.org>
Cc: Christoph Hellwig <hch@infradead.org>
---
 block/blk-flush.c | 11 +++++++++--
 1 file changed, 9 insertions(+), 2 deletions(-)

diff --git a/block/blk-flush.c b/block/blk-flush.c
index 6e1543c10493..53abb5c73d99 100644
--- a/block/blk-flush.c
+++ b/block/blk-flush.c
@@ -308,9 +308,16 @@ static void blk_kick_flush(struct request_queue *q, struct blk_flush_queue *fq,
 	flush_rq->mq_ctx = first_rq->mq_ctx;
 	flush_rq->mq_hctx = first_rq->mq_hctx;
 
-	if (!q->elevator)
+	if (!q->elevator) {
 		flush_rq->tag = first_rq->tag;
-	else
+
+		/*
+		 * We borrow data request's driver tag, so have to mark
+		 * this flush request as INFLIGHT for avoiding double
+		 * account of this driver tag
+		 */
+		flush_rq->rq_flags |= RQF_MQ_INFLIGHT;
+	} else
 		flush_rq->internal_tag = first_rq->internal_tag;
 
 	flush_rq->cmd_flags = REQ_OP_FLUSH | REQ_PREFLUSH;
-- 
2.25.2

