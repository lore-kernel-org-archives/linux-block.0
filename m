Return-Path: <SRS0=fuqo=B3=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A0C1FC433E1
	for <linux-block@archiver.kernel.org>; Mon, 17 Aug 2020 09:53:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 823D220738
	for <linux-block@archiver.kernel.org>; Mon, 17 Aug 2020 09:53:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="K1zp85He"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726772AbgHQJxK (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 17 Aug 2020 05:53:10 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:38026 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726575AbgHQJxK (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 17 Aug 2020 05:53:10 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1597657988;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=S4Pe5JrqqmVYwC25/4UqSy3AC9ciVIeUyq1vd5ovVoo=;
        b=K1zp85HeDWy6dwrzMX6qTMBsUpvHpaGP9rXmlC0D1pcOQOOoiM8uMnP4RPQCFjmgDS/E3u
        W5cUHwCQ+dLLssrqXxsjntNnuGaIWs+qUCZOTxKX5QeBoZcyL+YDyfGVBleBh2coqWKwPS
        23RyEpq4KV3sgLZz7Ql0kBPA66mjqiM=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-523-H2ej7HgvPCar6Vm7OqdKdA-1; Mon, 17 Aug 2020 05:53:06 -0400
X-MC-Unique: H2ej7HgvPCar6Vm7OqdKdA-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id ACE6F100CF64;
        Mon, 17 Aug 2020 09:53:05 +0000 (UTC)
Received: from localhost (ovpn-13-146.pek2.redhat.com [10.72.13.146])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 48E575BAC3;
        Mon, 17 Aug 2020 09:53:01 +0000 (UTC)
From:   Ming Lei <ming.lei@redhat.com>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org, Ming Lei <ming.lei@redhat.com>,
        Christoph Hellwig <hch@lst.de>,
        Stefano Garzarella <sgarzare@redhat.com>
Subject: [PATCH V3 1/3] block: respect queue limit of max discard segment
Date:   Mon, 17 Aug 2020 17:52:39 +0800
Message-Id: <20200817095241.2494763-2-ming.lei@redhat.com>
In-Reply-To: <20200817095241.2494763-1-ming.lei@redhat.com>
References: <20200817095241.2494763-1-ming.lei@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

When queue_max_discard_segments(q) is 1, blk_discard_mergable() will
return false for discard request, then normal request merge is applied.
However, only queue_max_segments() is checked, so max discard segment
limit isn't respected.

Check max discard segment limit in the request merge code for fixing
the issue.

Discard request failure of virtio_blk is fixed.

Signed-off-by: Ming Lei <ming.lei@redhat.com>
Fixes: 69840466086d ("block: fix the DISCARD request merge")
Reviewed-by: Christoph Hellwig <hch@lst.de>
Cc: Stefano Garzarella <sgarzare@redhat.com>
---
 block/blk-merge.c | 11 +++++++++--
 1 file changed, 9 insertions(+), 2 deletions(-)

diff --git a/block/blk-merge.c b/block/blk-merge.c
index 6529e3aab001..7af1f3668a91 100644
--- a/block/blk-merge.c
+++ b/block/blk-merge.c
@@ -533,10 +533,17 @@ int __blk_rq_map_sg(struct request_queue *q, struct request *rq,
 }
 EXPORT_SYMBOL(__blk_rq_map_sg);
 
+static inline unsigned int blk_rq_get_max_segments(struct request *rq)
+{
+	if (req_op(rq) == REQ_OP_DISCARD)
+		return queue_max_discard_segments(rq->q);
+	return queue_max_segments(rq->q);
+}
+
 static inline int ll_new_hw_segment(struct request *req, struct bio *bio,
 		unsigned int nr_phys_segs)
 {
-	if (req->nr_phys_segments + nr_phys_segs > queue_max_segments(req->q))
+	if (req->nr_phys_segments + nr_phys_segs > blk_rq_get_max_segments(req))
 		goto no_merge;
 
 	if (blk_integrity_merge_bio(req->q, req, bio) == false)
@@ -624,7 +631,7 @@ static int ll_merge_requests_fn(struct request_queue *q, struct request *req,
 		return 0;
 
 	total_phys_segments = req->nr_phys_segments + next->nr_phys_segments;
-	if (total_phys_segments > queue_max_segments(q))
+	if (total_phys_segments > blk_rq_get_max_segments(req))
 		return 0;
 
 	if (blk_integrity_merge_rq(q, req, next) == false)
-- 
2.25.2

