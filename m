Return-Path: <SRS0=Zyuh=RU=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9B0D3C43381
	for <linux-block@archiver.kernel.org>; Sun, 17 Mar 2019 10:02:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6B8602085A
	for <linux-block@archiver.kernel.org>; Sun, 17 Mar 2019 10:02:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726767AbfCQKCI (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Sun, 17 Mar 2019 06:02:08 -0400
Received: from mx1.redhat.com ([209.132.183.28]:51588 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725903AbfCQKCH (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Sun, 17 Mar 2019 06:02:07 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id D1DF73082AFA;
        Sun, 17 Mar 2019 10:02:07 +0000 (UTC)
Received: from localhost (ovpn-8-17.pek2.redhat.com [10.72.8.17])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 9552157984;
        Sun, 17 Mar 2019 10:02:04 +0000 (UTC)
From:   Ming Lei <ming.lei@redhat.com>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org, Ming Lei <ming.lei@redhat.com>,
        Omar Sandoval <osandov@fb.com>, Christoph Hellwig <hch@lst.de>
Subject: [PATCH V2 08/10] block: remove argument of 'request_queue' from __blk_bvec_map_sg
Date:   Sun, 17 Mar 2019 18:01:10 +0800
Message-Id: <20190317100112.8106-9-ming.lei@redhat.com>
In-Reply-To: <20190317100112.8106-1-ming.lei@redhat.com>
References: <20190317100112.8106-1-ming.lei@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.45]); Sun, 17 Mar 2019 10:02:07 +0000 (UTC)
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

The argument of 'request_queue' isn't used by __blk_bvec_map_sg(),
so remove it.

Cc: Omar Sandoval <osandov@fb.com>
Cc: Christoph Hellwig <hch@lst.de>
Signed-off-by: Ming Lei <ming.lei@redhat.com>
---
 block/blk-merge.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/block/blk-merge.c b/block/blk-merge.c
index aa9164eb7187..9ec704bb58ec 100644
--- a/block/blk-merge.c
+++ b/block/blk-merge.c
@@ -520,7 +520,7 @@ __blk_segment_map_sg(struct request_queue *q, struct bio_vec *bvec,
 	*bvprv = *bvec;
 }
 
-static inline int __blk_bvec_map_sg(struct request_queue *q, struct bio_vec bv,
+static inline int __blk_bvec_map_sg(struct bio_vec bv,
 		struct scatterlist *sglist, struct scatterlist **sg)
 {
 	*sg = sglist;
@@ -555,9 +555,9 @@ int blk_rq_map_sg(struct request_queue *q, struct request *rq,
 	int nsegs = 0;
 
 	if (rq->rq_flags & RQF_SPECIAL_PAYLOAD)
-		nsegs = __blk_bvec_map_sg(q, rq->special_vec, sglist, &sg);
+		nsegs = __blk_bvec_map_sg(rq->special_vec, sglist, &sg);
 	else if (rq->bio && bio_op(rq->bio) == REQ_OP_WRITE_SAME)
-		nsegs = __blk_bvec_map_sg(q, bio_iovec(rq->bio), sglist, &sg);
+		nsegs = __blk_bvec_map_sg(bio_iovec(rq->bio), sglist, &sg);
 	else if (rq->bio)
 		nsegs = __blk_bios_map_sg(q, rq->bio, sglist, &sg);
 
-- 
2.9.5

