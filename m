Return-Path: <SRS0=pPwc=SA=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9B3C5C43381
	for <linux-block@archiver.kernel.org>; Fri, 29 Mar 2019 07:09:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 677A7206B6
	for <linux-block@archiver.kernel.org>; Fri, 29 Mar 2019 07:09:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728866AbfC2HJA (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 29 Mar 2019 03:09:00 -0400
Received: from mx1.redhat.com ([209.132.183.28]:54144 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728651AbfC2HI7 (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Fri, 29 Mar 2019 03:08:59 -0400
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id C587A70D70;
        Fri, 29 Mar 2019 07:08:59 +0000 (UTC)
Received: from localhost (ovpn-8-16.pek2.redhat.com [10.72.8.16])
        by smtp.corp.redhat.com (Postfix) with ESMTP id B5FBD619BE;
        Fri, 29 Mar 2019 07:08:56 +0000 (UTC)
From:   Ming Lei <ming.lei@redhat.com>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org, Ming Lei <ming.lei@redhat.com>,
        Omar Sandoval <osandov@fb.com>, Christoph Hellwig <hch@lst.de>
Subject: [PATCH V3 08/10] block: remove argument of 'request_queue' from __blk_bvec_map_sg
Date:   Fri, 29 Mar 2019 15:08:01 +0800
Message-Id: <20190329070803.10958-9-ming.lei@redhat.com>
In-Reply-To: <20190329070803.10958-1-ming.lei@redhat.com>
References: <20190329070803.10958-1-ming.lei@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.28]); Fri, 29 Mar 2019 07:08:59 +0000 (UTC)
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

