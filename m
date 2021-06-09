Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1C3E8C4743D
	for <linux-block@archiver.kernel.org>; Wed,  9 Jun 2021 00:46:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 06A76613C0
	for <linux-block@archiver.kernel.org>; Wed,  9 Jun 2021 00:46:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235236AbhFIAsN (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 8 Jun 2021 20:48:13 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:28027 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S235047AbhFIAsM (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 8 Jun 2021 20:48:12 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1623199578;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=fNnvH0oent1+8RO6vfvbEqxlu26fyTCVEJQaO+9bvX8=;
        b=Qjow2d3nTloynOr5xoqb9VETIiGEoXowOJ2zCBEIiGBGdWKTjJkV/0PLAliflhDER/Faew
        WdnWjjg2hNygWY9uROdgiUZALyf6y0LGSDrjGV1J1duNuZKOTaaXrduSZMmve1Iiy0BPi3
        hwX/M3kKiePTcnSLwDGH7aNMX4iA7/g=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-396-81BbzXcaMqapF8yPpehI6Q-1; Tue, 08 Jun 2021 20:46:16 -0400
X-MC-Unique: 81BbzXcaMqapF8yPpehI6Q-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id F01535120;
        Wed,  9 Jun 2021 00:46:15 +0000 (UTC)
Received: from localhost (ovpn-12-143.pek2.redhat.com [10.72.12.143])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 2B5F319814;
        Wed,  9 Jun 2021 00:46:11 +0000 (UTC)
From:   Ming Lei <ming.lei@redhat.com>
To:     Jens Axboe <axboe@kernel.dk>, Christoph Hellwig <hch@lst.de>
Cc:     linux-block@vger.kernel.org, Ming Lei <ming.lei@redhat.com>,
        Wang Shanker <shankerwangmiao@gmail.com>
Subject: [PATCH 1/2] block: fix discard request merge
Date:   Wed,  9 Jun 2021 08:45:55 +0800
Message-Id: <20210609004556.46928-2-ming.lei@redhat.com>
In-Reply-To: <20210609004556.46928-1-ming.lei@redhat.com>
References: <20210609004556.46928-1-ming.lei@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
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

Reported-by: Wang Shanker <shankerwangmiao@gmail.com>
Signed-off-by: Ming Lei <ming.lei@redhat.com>
---
 block/blk-merge.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/block/blk-merge.c b/block/blk-merge.c
index 4d97fb6dd226..bcdff1879c34 100644
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

