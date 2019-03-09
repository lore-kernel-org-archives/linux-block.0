Return-Path: <SRS0=TT20=RM=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8298CC43381
	for <linux-block@archiver.kernel.org>; Sat,  9 Mar 2019 01:38:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5139D20857
	for <linux-block@archiver.kernel.org>; Sat,  9 Mar 2019 01:38:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726355AbfCIBh7 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 8 Mar 2019 20:37:59 -0500
Received: from mx1.redhat.com ([209.132.183.28]:56026 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726338AbfCIBh7 (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Fri, 8 Mar 2019 20:37:59 -0500
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id A4B8136893;
        Sat,  9 Mar 2019 01:37:59 +0000 (UTC)
Received: from localhost (ovpn-8-20.pek2.redhat.com [10.72.8.20])
        by smtp.corp.redhat.com (Postfix) with ESMTP id E7B051018A0A;
        Sat,  9 Mar 2019 01:37:54 +0000 (UTC)
From:   Ming Lei <ming.lei@redhat.com>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org, Ming Lei <ming.lei@redhat.com>,
        ris Ostrovsky <boris.ostrovsky@oracle.com>,
        Juergen Gross <jgross@suse.com>,
        xen-devel@lists.xenproject.org, Omar Sandoval <osandov@fb.com>,
        Christoph Hellwig <hch@lst.de>
Subject: [PATCH 2/6] block: don't merge adjacent bvecs to one segment in bio blk_queue_split
Date:   Sat,  9 Mar 2019 09:37:33 +0800
Message-Id: <20190309013737.27741-3-ming.lei@redhat.com>
In-Reply-To: <20190309013737.27741-1-ming.lei@redhat.com>
References: <20190309013737.27741-1-ming.lei@redhat.com>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.30]); Sat, 09 Mar 2019 01:37:59 +0000 (UTC)
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

For normal filesystem IO, each page is added via blk_add_page(),
in which bvec(page) merge has been handled already, and basically
not possible to merge two adjacent bvecs in one bio.

So not try to merge two adjacent bvecs in blk_queue_split(), also add
check if one page is mergeable to current bvec in bio_add_page() for
avoiding to break XEN.

Cc: ris Ostrovsky <boris.ostrovsky@oracle.com>
Cc: Juergen Gross <jgross@suse.com>
Cc: xen-devel@lists.xenproject.org
Cc: Omar Sandoval <osandov@fb.com>
Cc: Christoph Hellwig <hch@lst.de>
Signed-off-by: Ming Lei <ming.lei@redhat.com>
---
 block/bio.c       |  2 ++
 block/blk-merge.c | 17 -----------------
 2 files changed, 2 insertions(+), 17 deletions(-)

diff --git a/block/bio.c b/block/bio.c
index 71a78d9fb8b7..d8f48188937c 100644
--- a/block/bio.c
+++ b/block/bio.c
@@ -776,6 +776,8 @@ bool __bio_try_merge_page(struct bio *bio, struct page *page,
 
 		if (vec_end_addr + 1 != page_addr + off)
 			return false;
+		if (xen_domain() && !xen_biovec_phys_mergeable(bv, page))
+			return false;
 		if (same_page && (vec_end_addr & PAGE_MASK) != page_addr)
 			return false;
 
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

