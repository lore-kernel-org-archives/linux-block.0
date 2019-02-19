Return-Path: <SRS0=aQmj=Q2=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C7A96C43381
	for <linux-block@archiver.kernel.org>; Tue, 19 Feb 2019 03:08:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9EB962177E
	for <linux-block@archiver.kernel.org>; Tue, 19 Feb 2019 03:08:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725774AbfBSDI2 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 18 Feb 2019 22:08:28 -0500
Received: from mx1.redhat.com ([209.132.183.28]:52504 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725770AbfBSDI2 (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Mon, 18 Feb 2019 22:08:28 -0500
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id ACED4C04B939;
        Tue, 19 Feb 2019 03:08:28 +0000 (UTC)
Received: from localhost (ovpn-8-18.pek2.redhat.com [10.72.8.18])
        by smtp.corp.redhat.com (Postfix) with ESMTP id DF031608C1;
        Tue, 19 Feb 2019 03:08:24 +0000 (UTC)
From:   Ming Lei <ming.lei@redhat.com>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org, Ming Lei <ming.lei@redhat.com>,
        Bart Van Assche <bvanassche@acm.org>
Subject: [PATCH] block: avoid to READ fields of null bio
Date:   Tue, 19 Feb 2019 11:08:19 +0800
Message-Id: <20190219030819.16578-1-ming.lei@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.31]); Tue, 19 Feb 2019 03:08:28 +0000 (UTC)
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

rq->bio can be NULL sometimes, such as flush request, so don't
read bio->bi_seg_front_size until this 'bio' is checked as valid.

Cc: Bart Van Assche <bvanassche@acm.org>
Reported-by: Bart Van Assche <bvanassche@acm.org>
Fixes: dcebd755926b0f39dd1e ("block: use bio_for_each_bvec() to compute multi-page bvec count")
Signed-off-by: Ming Lei <ming.lei@redhat.com>
---
 block/blk-merge.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/block/blk-merge.c b/block/blk-merge.c
index bed065904677..066b66430523 100644
--- a/block/blk-merge.c
+++ b/block/blk-merge.c
@@ -363,13 +363,15 @@ static unsigned int __blk_recalc_rq_segments(struct request_queue *q,
 	struct bio_vec bv, bvprv = { NULL };
 	int prev = 0;
 	unsigned int seg_size, nr_phys_segs;
-	unsigned front_seg_size = bio->bi_seg_front_size;
+	unsigned front_seg_size;
 	struct bio *fbio, *bbio;
 	struct bvec_iter iter;
 
 	if (!bio)
 		return 0;
 
+	front_seg_size = bio->bi_seg_front_size;
+
 	switch (bio_op(bio)) {
 	case REQ_OP_DISCARD:
 	case REQ_OP_SECURE_ERASE:
-- 
2.9.5

