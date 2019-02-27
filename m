Return-Path: <SRS0=Mgfj=RC=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E5D5BC43381
	for <linux-block@archiver.kernel.org>; Wed, 27 Feb 2019 12:40:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B3BA22133D
	for <linux-block@archiver.kernel.org>; Wed, 27 Feb 2019 12:40:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730177AbfB0Mkk (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 27 Feb 2019 07:40:40 -0500
Received: from mx1.redhat.com ([209.132.183.28]:48222 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726419AbfB0Mkk (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Wed, 27 Feb 2019 07:40:40 -0500
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 186E730BEF1D;
        Wed, 27 Feb 2019 12:40:40 +0000 (UTC)
Received: from localhost (ovpn-8-19.pek2.redhat.com [10.72.8.19])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 2BF37183EF;
        Wed, 27 Feb 2019 12:40:35 +0000 (UTC)
From:   Ming Lei <ming.lei@redhat.com>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org, Ming Lei <ming.lei@redhat.com>
Subject: [PATCH 2/4] block: optimize __blk_segment_map_sg() for single-page bvec
Date:   Wed, 27 Feb 2019 20:40:11 +0800
Message-Id: <20190227124013.4828-3-ming.lei@redhat.com>
In-Reply-To: <20190227124013.4828-1-ming.lei@redhat.com>
References: <20190227124013.4828-1-ming.lei@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.46]); Wed, 27 Feb 2019 12:40:40 +0000 (UTC)
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Introduce a fast path for single-page bvec IO, then blk_bvec_map_sg()
can be avoided.

Signed-off-by: Ming Lei <ming.lei@redhat.com>
---
 block/blk-merge.c | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/block/blk-merge.c b/block/blk-merge.c
index c7e8a8273460..c1ad8abbd9d6 100644
--- a/block/blk-merge.c
+++ b/block/blk-merge.c
@@ -447,7 +447,7 @@ static int blk_phys_contig_segment(struct request_queue *q, struct bio *bio,
 	return biovec_phys_mergeable(q, &end_bv, &nxt_bv);
 }
 
-static struct scatterlist *blk_next_sg(struct scatterlist **sg,
+static inline struct scatterlist *blk_next_sg(struct scatterlist **sg,
 		struct scatterlist *sglist)
 {
 	if (!*sg)
@@ -512,7 +512,12 @@ __blk_segment_map_sg(struct request_queue *q, struct bio_vec *bvec,
 		(*sg)->length += nbytes;
 	} else {
 new_segment:
-		(*nsegs) += blk_bvec_map_sg(q, bvec, sglist, sg);
+		if (bvec->bv_offset + bvec->bv_len <= PAGE_SIZE) {
+			*sg = blk_next_sg(sg, sglist);
+			sg_set_page(*sg, bvec->bv_page, nbytes, bvec->bv_offset);
+			(*nsegs) += 1;
+		} else
+			(*nsegs) += blk_bvec_map_sg(q, bvec, sglist, sg);
 	}
 	*bvprv = *bvec;
 }
-- 
2.9.5

