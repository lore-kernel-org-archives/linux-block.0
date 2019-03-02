Return-Path: <SRS0=DpIa=RF=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F2606C4360F
	for <linux-block@archiver.kernel.org>; Sat,  2 Mar 2019 08:43:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BBD8F20863
	for <linux-block@archiver.kernel.org>; Sat,  2 Mar 2019 08:43:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726307AbfCBIn5 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Sat, 2 Mar 2019 03:43:57 -0500
Received: from mx1.redhat.com ([209.132.183.28]:54904 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726242AbfCBIn5 (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Sat, 2 Mar 2019 03:43:57 -0500
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 30C6A88306;
        Sat,  2 Mar 2019 08:43:57 +0000 (UTC)
Received: from localhost (ovpn-8-16.pek2.redhat.com [10.72.8.16])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 317FB5D9C8;
        Sat,  2 Mar 2019 08:43:53 +0000 (UTC)
From:   Ming Lei <ming.lei@redhat.com>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org, Ming Lei <ming.lei@redhat.com>,
        Christoph Hellwig <hch@lst.de>, Omar Sandoval <osandov@fb.com>
Subject: [PATCH] block: fix updating bio's front segment size
Date:   Sat,  2 Mar 2019 16:43:44 +0800
Message-Id: <20190302084344.31962-1-ming.lei@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.28]); Sat, 02 Mar 2019 08:43:57 +0000 (UTC)
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

When the current bvec can be merged to the 1st segment, the bio's front
segment size has to be updated.

However, dcebd755926b doesn't consider that case, then bio's front
segment size may not be correct.

This patch fixes this issue.

Cc: Christoph Hellwig <hch@lst.de>
Cc: Omar Sandoval <osandov@fb.com>
Fixes: dcebd755926b ("block: use bio_for_each_bvec() to compute multi-page bvec count")
Signed-off-by: Ming Lei <ming.lei@redhat.com>
---
 block/blk-merge.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/block/blk-merge.c b/block/blk-merge.c
index 9402a7c3ba22..22467f475ab4 100644
--- a/block/blk-merge.c
+++ b/block/blk-merge.c
@@ -277,6 +277,9 @@ static struct bio *blk_bio_segment_split(struct request_queue *q,
 			bvprvp = &bvprv;
 			sectors += bv.bv_len >> 9;
 
+			if (nsegs == 1 && seg_size > front_seg_size)
+				front_seg_size = seg_size;
+
 			continue;
 		}
 new_segment:
@@ -401,6 +404,11 @@ static unsigned int __blk_recalc_rq_segments(struct request_queue *q,
 
 				seg_size += bv.bv_len;
 				bvprv = bv;
+
+				if (nr_phys_segs == 1 && seg_size >
+						front_seg_size)
+					front_seg_size = seg_size;
+
 				continue;
 			}
 new_segment:
-- 
2.9.5

