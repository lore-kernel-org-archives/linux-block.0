Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.4 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 618B7C48BC2
	for <linux-block@archiver.kernel.org>; Mon, 28 Jun 2021 02:33:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3AB57619C5
	for <linux-block@archiver.kernel.org>; Mon, 28 Jun 2021 02:33:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231815AbhF1Cf6 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Sun, 27 Jun 2021 22:35:58 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:58844 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231678AbhF1Cf6 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Sun, 27 Jun 2021 22:35:58 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1624847612;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=7GWvzvD1JEXD7+pKSQ74zgFabbZQXl5ATXDOyRF9TmY=;
        b=TMi7H3jgV2+tHXEvokoXcUDm2YYsAjqQcMWw6rUtWiDpm3SnE57ffN8fnTKQyCbqdS+cHA
        nSHkUQyaxG4MB6lYOqFDzfhprVSL343WLcj8fIwaikREHOXenrPIcmIUtW8wj8ag+KfHOh
        qTeyXKiU1PnfbCbdLDiIPoGVT8ysLz8=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-465-d-kgWVbhOK-ILkwd51NaJA-1; Sun, 27 Jun 2021 22:33:28 -0400
X-MC-Unique: d-kgWVbhOK-ILkwd51NaJA-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 9F195100CF72;
        Mon, 28 Jun 2021 02:33:27 +0000 (UTC)
Received: from localhost (ovpn-12-212.pek2.redhat.com [10.72.12.212])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 526AD5C1CF;
        Mon, 28 Jun 2021 02:33:23 +0000 (UTC)
From:   Ming Lei <ming.lei@redhat.com>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org, Ming Lei <ming.lei@redhat.com>,
        Christoph Hellwig <hch@lst.de>,
        Wang Shanker <shankerwangmiao@gmail.com>
Subject: [PATCH RESEND] block: fix discard request merge
Date:   Mon, 28 Jun 2021 10:33:12 +0800
Message-Id: <20210628023312.1903255-1-ming.lei@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

ll_new_hw_segment() is reached only in case of single range discard
merge, and we don't have max discard segment size limit actually, so
it is wrong to run the following check:

if (req->nr_phys_segments + nr_phys_segs > blk_rq_get_max_segments(req))

it may be always false since req->nr_phys_segments is initialized as
one, and bio's segment count is still 1, blk_rq_get_max_segments(reg)
is 1 too.

Fix the issue by not doing the check and bypassing the calculation of
discard request's nr_phys_segments.

Based on analysis from Wang Shanker.

Cc: Christoph Hellwig <hch@lst.de>
Reported-by: Wang Shanker <shankerwangmiao@gmail.com>
Signed-off-by: Ming Lei <ming.lei@redhat.com>
---
 block/blk-merge.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/block/blk-merge.c b/block/blk-merge.c
index 5c9d2a4ece86..a4afa488298e 100644
--- a/block/blk-merge.c
+++ b/block/blk-merge.c
@@ -559,10 +559,14 @@ static inline unsigned int blk_rq_get_max_segments(struct request *rq)
 static inline int ll_new_hw_segment(struct request *req, struct bio *bio,
 		unsigned int nr_phys_segs)
 {
-	if (req->nr_phys_segments + nr_phys_segs > blk_rq_get_max_segments(req))
+	if (blk_integrity_merge_bio(req->q, req, bio) == false)
 		goto no_merge;
 
-	if (blk_integrity_merge_bio(req->q, req, bio) == false)
+	/* discard request merge won't add new segment */
+	if (req_op(req) == REQ_OP_DISCARD)
+		return 1;
+
+	if (req->nr_phys_segments + nr_phys_segs > blk_rq_get_max_segments(req))
 		goto no_merge;
 
 	/*
-- 
2.31.1

