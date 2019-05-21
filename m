Return-Path: <SRS0=jUAw=TV=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9003FC04AAF
	for <linux-block@archiver.kernel.org>; Tue, 21 May 2019 07:02:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 653E221019
	for <linux-block@archiver.kernel.org>; Tue, 21 May 2019 07:02:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="HUYBnmWe"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725809AbfEUHCC (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 21 May 2019 03:02:02 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:38208 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726338AbfEUHCB (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 21 May 2019 03:02:01 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From
        :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=EnrD/u5tr2NH/JuMBaegGddcrLvuzl9DB0zeS+rnxEM=; b=HUYBnmWeh9tGk5L79m7w1JC3PY
        Ca803cy+hKJV748Vqxl4GNtDByIHUk4jclMD9SsXL9YhawwFD/NgnK5ytMT0v0iiWkYXbJB/ZfYmJ
        YDKX5bOm3OS9Fq0qdX7YAsWSYha18BAiwUQI12Pf/w36vVVzxlPsX1S/XKq3oqaxEek9MTKLNFs+c
        Fshh6c/TCpnZRwgIb0SVtBQEVt97Cduo59lYSHHSwADgX8bXky725e5PbHeYKKwQ7f/EzTR6pBOIs
        KC9UFrMrsji4IITtn1/Ok6EtR8NL8YF1Wfs55Da5cG6rS5AmILZVmPyglJsunJdLLVAChMnEx3GIQ
        LAVlgXig==;
Received: from 089144206147.atnat0015.highway.bob.at ([89.144.206.147] helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1hSymd-0000Zh-W2; Tue, 21 May 2019 07:02:00 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     axboe@fb.com
Cc:     ming.lei@redhat.com, linux-block@vger.kernel.org,
        Hannes Reinecke <hare@suse.com>
Subject: [PATCH 3/4] block: remove the segment size check in bio_will_gap
Date:   Tue, 21 May 2019 09:01:42 +0200
Message-Id: <20190521070143.22631-4-hch@lst.de>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190521070143.22631-1-hch@lst.de>
References: <20190521070143.22631-1-hch@lst.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

We fundamentally do not have a maximum segement size for devices with a
virt boundary.  So don't bother checking it, especially given that the
existing checks didn't properly work to start with as we never fully
update the front/back segment size and miss the bi_seg_front_size that
wuld have been required for some cases.

Signed-off-by: Christoph Hellwig <hch@lst.de>
Reviewed-by: Ming Lei <ming.lei@redhat.com>
Reviewed-by: Hannes Reinecke <hare@suse.com>
---
 block/blk-merge.c | 19 +------------------
 1 file changed, 1 insertion(+), 18 deletions(-)

diff --git a/block/blk-merge.c b/block/blk-merge.c
index 80a5a0facb87..eee2c02c50ce 100644
--- a/block/blk-merge.c
+++ b/block/blk-merge.c
@@ -12,23 +12,6 @@
 
 #include "blk.h"
 
-/*
- * Check if the two bvecs from two bios can be merged to one segment.  If yes,
- * no need to check gap between the two bios since the 1st bio and the 1st bvec
- * in the 2nd bio can be handled in one segment.
- */
-static inline bool bios_segs_mergeable(struct request_queue *q,
-		struct bio *prev, struct bio_vec *prev_last_bv,
-		struct bio_vec *next_first_bv)
-{
-	if (!biovec_phys_mergeable(q, prev_last_bv, next_first_bv))
-		return false;
-	if (prev->bi_seg_back_size + next_first_bv->bv_len >
-			queue_max_segment_size(q))
-		return false;
-	return true;
-}
-
 static inline bool bio_will_gap(struct request_queue *q,
 		struct request *prev_rq, struct bio *prev, struct bio *next)
 {
@@ -60,7 +43,7 @@ static inline bool bio_will_gap(struct request_queue *q,
 	 */
 	bio_get_last_bvec(prev, &pb);
 	bio_get_first_bvec(next, &nb);
-	if (bios_segs_mergeable(q, prev, &pb, &nb))
+	if (biovec_phys_mergeable(q, &pb, &nb))
 		return false;
 	return __bvec_gap_to_prev(q, &pb, nb.bv_offset);
 }
-- 
2.20.1

