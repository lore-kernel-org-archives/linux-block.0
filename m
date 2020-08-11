Return-Path: <SRS0=2P2f=BV=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E06F3C433E0
	for <linux-block@archiver.kernel.org>; Tue, 11 Aug 2020 23:45:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A5E1120756
	for <linux-block@archiver.kernel.org>; Tue, 11 Aug 2020 23:45:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="PT7LAQgO"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726179AbgHKXpA (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 11 Aug 2020 19:45:00 -0400
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:26742 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726143AbgHKXpA (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 11 Aug 2020 19:45:00 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1597189499;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=8PfrhpBVlNqe3hz0fln6umwGqTH+TNmMWsIOFhHPDsc=;
        b=PT7LAQgOiOnjhujrAp89qHlwpOsSOaFk1YM4r1yR6dyZh0efxqo5X7hbSoWBkc7vM0jq1l
        yy8osR0wuS4vvI0DMY7RdQ6s1LIhXSeOcA+Xb9iyKf7TxIOJ4DFL9REFTCYyHKpEkyGJYW
        a7q8Rez46RK84B63wiWWlRrAgSUdUL0=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-147-kTqs6LuAPzeIhwOkdJDSRw-1; Tue, 11 Aug 2020 19:44:57 -0400
X-MC-Unique: kTqs6LuAPzeIhwOkdJDSRw-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 105321005504;
        Tue, 11 Aug 2020 23:44:56 +0000 (UTC)
Received: from localhost (ovpn-13-156.pek2.redhat.com [10.72.13.156])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 903066111F;
        Tue, 11 Aug 2020 23:44:52 +0000 (UTC)
From:   Ming Lei <ming.lei@redhat.com>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org, Ming Lei <ming.lei@redhat.com>,
        Christoph Hellwig <hch@lst.de>
Subject: [PATCH V2 3/3] block: rename blk_discard_mergable as blk_discard_support_multi_range
Date:   Wed, 12 Aug 2020 07:44:20 +0800
Message-Id: <20200811234420.2297137-4-ming.lei@redhat.com>
In-Reply-To: <20200811234420.2297137-1-ming.lei@redhat.com>
References: <20200811234420.2297137-1-ming.lei@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
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
index d18fb88ca8bd..23eb46a99c9d 100644
--- a/block/blk-merge.c
+++ b/block/blk-merge.c
@@ -692,8 +692,11 @@ static void blk_account_io_merge_request(struct request *req)
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
@@ -704,7 +707,7 @@ static inline bool blk_discard_mergable(struct request *req)
 static enum elv_merge blk_try_req_merge(struct request *req,
 					struct request *next)
 {
-	if (blk_discard_mergable(req))
+	if (blk_discard_support_multi_range(req))
 		return ELEVATOR_DISCARD_MERGE;
 	else if (blk_rq_pos(req) + blk_rq_sectors(req) == blk_rq_pos(next))
 		return ELEVATOR_BACK_MERGE;
@@ -790,7 +793,7 @@ static struct request *attempt_merge(struct request_queue *q,
 
 	req->__data_len += blk_rq_bytes(next);
 
-	if (!blk_discard_mergable(req))
+	if (!blk_discard_support_multi_range(req))
 		elv_merge_requests(q, req, next);
 
 	/*
@@ -886,7 +889,7 @@ bool blk_rq_merge_ok(struct request *rq, struct bio *bio)
 
 enum elv_merge blk_try_merge(struct request *rq, struct bio *bio)
 {
-	if (blk_discard_mergable(rq))
+	if (blk_discard_support_multi_range(rq))
 		return ELEVATOR_DISCARD_MERGE;
 	else if (blk_rq_pos(rq) + blk_rq_sectors(rq) == bio->bi_iter.bi_sector)
 		return ELEVATOR_BACK_MERGE;
-- 
2.25.2

