Return-Path: <SRS0=Zyuh=RU=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 67571C43381
	for <linux-block@archiver.kernel.org>; Sun, 17 Mar 2019 10:01:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 362A72085A
	for <linux-block@archiver.kernel.org>; Sun, 17 Mar 2019 10:01:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726831AbfCQKBh (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Sun, 17 Mar 2019 06:01:37 -0400
Received: from mx1.redhat.com ([209.132.183.28]:33914 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725903AbfCQKBh (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Sun, 17 Mar 2019 06:01:37 -0400
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 91FD0750DC;
        Sun, 17 Mar 2019 10:01:37 +0000 (UTC)
Received: from localhost (ovpn-8-17.pek2.redhat.com [10.72.8.17])
        by smtp.corp.redhat.com (Postfix) with ESMTP id A5A88600C7;
        Sun, 17 Mar 2019 10:01:34 +0000 (UTC)
From:   Ming Lei <ming.lei@redhat.com>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org, Ming Lei <ming.lei@redhat.com>,
        Omar Sandoval <osandov@fb.com>, Christoph Hellwig <hch@lst.de>
Subject: [PATCH V2 03/10] block: don't merge adjacent bvecs to one segment in bio blk_queue_split
Date:   Sun, 17 Mar 2019 18:01:05 +0800
Message-Id: <20190317100112.8106-4-ming.lei@redhat.com>
In-Reply-To: <20190317100112.8106-1-ming.lei@redhat.com>
References: <20190317100112.8106-1-ming.lei@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.39]); Sun, 17 Mar 2019 10:01:37 +0000 (UTC)
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

For normal filesystem IO, each page is added via blk_add_page(),
in which bvec(page) merge has been handled already, and basically
not possible to merge two adjacent bvecs in one bio.

So not try to merge two adjacent bvecs in blk_queue_split().

Cc: Omar Sandoval <osandov@fb.com>
Cc: Christoph Hellwig <hch@lst.de>
Reviewed-by: Boris Ostrovsky <boris.ostrovsky@oracle.com>
Signed-off-by: Ming Lei <ming.lei@redhat.com>
---
 block/blk-merge.c | 17 -----------------
 1 file changed, 17 deletions(-)

diff --git a/block/blk-merge.c b/block/blk-merge.c
index 1c9d4f0f96ea..aa9164eb7187 100644
--- a/block/blk-merge.c
+++ b/block/blk-merge.c
@@ -267,23 +267,6 @@ static struct bio *blk_bio_segment_split(struct request_queue *q,
 			goto split;
 		}
 
-		if (bvprvp) {
-			if (seg_size + bv.bv_len > queue_max_segment_size(q))
-				goto new_segment;
-			if (!biovec_phys_mergeable(q, bvprvp, &bv))
-				goto new_segment;
-
-			seg_size += bv.bv_len;
-			bvprv = bv;
-			bvprvp = &bvprv;
-			sectors += bv.bv_len >> 9;
-
-			if (nsegs == 1 && seg_size > front_seg_size)
-				front_seg_size = seg_size;
-
-			continue;
-		}
-new_segment:
 		if (nsegs == max_segs)
 			goto split;
 
-- 
2.9.5

