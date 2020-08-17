Return-Path: <SRS0=fuqo=B3=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 980C6C433E1
	for <linux-block@archiver.kernel.org>; Mon, 17 Aug 2020 09:53:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6F2B7206FA
	for <linux-block@archiver.kernel.org>; Mon, 17 Aug 2020 09:53:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="gPU4WZrX"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726974AbgHQJxc (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 17 Aug 2020 05:53:32 -0400
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:60684 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726963AbgHQJxb (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 17 Aug 2020 05:53:31 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1597658010;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=83XMDhrO4phOKCyrFncyjt6GQdeLY4uo+qVrXr0DmYQ=;
        b=gPU4WZrXakh7f5S9Qx6I5QpnC834s1U/TiTCv6gmpwNePL6p6mO2PkpYlejuu/OrGvWR5h
        iHYGkBNzs/EtusZVYWgxst7eP4wSO14LzQLksX58YWJ1GKukeqmnZZzT17hurLHH4P5SxU
        fRLLBbsNocCi85+s7OC2nPCyEmvgMfI=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-549-sCwK4s72OR6Q4y93VkLSQg-1; Mon, 17 Aug 2020 05:53:27 -0400
X-MC-Unique: sCwK4s72OR6Q4y93VkLSQg-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id DA9A281F00A;
        Mon, 17 Aug 2020 09:53:26 +0000 (UTC)
Received: from localhost (ovpn-13-146.pek2.redhat.com [10.72.13.146])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 2E0725D9E2;
        Mon, 17 Aug 2020 09:53:22 +0000 (UTC)
From:   Ming Lei <ming.lei@redhat.com>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org, Ming Lei <ming.lei@redhat.com>,
        Christoph Hellwig <hch@lst.de>
Subject: [PATCH V3 3/3] block: rename blk_discard_mergable as blk_discard_support_multi_range
Date:   Mon, 17 Aug 2020 17:52:41 +0800
Message-Id: <20200817095241.2494763-4-ming.lei@redhat.com>
In-Reply-To: <20200817095241.2494763-1-ming.lei@redhat.com>
References: <20200817095241.2494763-1-ming.lei@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Name of blk_discard_mergable() is very confusing, and this function
actually means if the queue supports multi_range discard. Also there
are two kinds of discard merge:

1) multi range discard, bios in one request won't have to be contiguous,
and actually each bio is thought as one range

2) single range discard, all bios in one request have to be contiguous
just like normal RW request's merge

Rename blk_discard_mergable() for not confusing people, and avoiding
to introduce bugs in future.

Cc: Christoph Hellwig <hch@lst.de>
Signed-off-by: Ming Lei <ming.lei@redhat.com>
---
 block/blk-merge.c | 11 +++++++----
 1 file changed, 7 insertions(+), 4 deletions(-)

diff --git a/block/blk-merge.c b/block/blk-merge.c
index 7af1f3668a91..47a03d2eed24 100644
--- a/block/blk-merge.c
+++ b/block/blk-merge.c
@@ -693,8 +693,11 @@ static void blk_account_io_merge_request(struct request *req)
  * needn't to be contiguous.
  * Otherwise, the bios/requests will be handled as same as
  * others which should be contiguous.
+ *
+ * queue_max_discard_segments() is > 1, the queue supports multi range
+ * discard.
  */
-static inline bool blk_discard_mergable(struct request *req)
+static inline bool blk_discard_support_multi_range(struct request *req)
 {
 	if (req_op(req) == REQ_OP_DISCARD &&
 	    queue_max_discard_segments(req->q) > 1)
@@ -705,7 +708,7 @@ static inline bool blk_discard_mergable(struct request *req)
 static enum elv_merge blk_try_req_merge(struct request *req,
 					struct request *next)
 {
-	if (blk_discard_mergable(req))
+	if (blk_discard_support_multi_range(req))
 		return ELEVATOR_DISCARD_MERGE;
 	else if (blk_rq_pos(req) + blk_rq_sectors(req) == blk_rq_pos(next))
 		return ELEVATOR_BACK_MERGE;
@@ -791,7 +794,7 @@ static struct request *attempt_merge(struct request_queue *q,
 
 	req->__data_len += blk_rq_bytes(next);
 
-	if (!blk_discard_mergable(req))
+	if (!blk_discard_support_multi_range(req))
 		elv_merge_requests(q, req, next);
 
 	/*
@@ -887,7 +890,7 @@ bool blk_rq_merge_ok(struct request *rq, struct bio *bio)
 
 enum elv_merge blk_try_merge(struct request *rq, struct bio *bio)
 {
-	if (blk_discard_mergable(rq))
+	if (blk_discard_support_multi_range(rq))
 		return ELEVATOR_DISCARD_MERGE;
 	else if (blk_rq_pos(rq) + blk_rq_sectors(rq) == bio->bi_iter.bi_sector)
 		return ELEVATOR_BACK_MERGE;
-- 
2.25.2

