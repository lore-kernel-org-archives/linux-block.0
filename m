Return-Path: <SRS0=mde3=TQ=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 51A50C04AB4
	for <linux-block@archiver.kernel.org>; Thu, 16 May 2019 08:41:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 26264205C9
	for <linux-block@archiver.kernel.org>; Thu, 16 May 2019 08:41:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="PEOE4PqR"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726774AbfEPIlz (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 16 May 2019 04:41:55 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:33654 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726425AbfEPIlz (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 16 May 2019 04:41:55 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From
        :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=Oe/H9JHz00XRiGLgT/MgiYLbj7DLPRdlc0SJW2/f7xg=; b=PEOE4PqRvj3wzNzoniE5jossqz
        j4VCT2ypC5fSoJhr+WLtgIoPo7yUV4cS9vIsqvJV1L96GJ34WSRHu1aWH/wTpAHsMylOPilJsnelU
        fGD+dcokZiB9VRoxDm+jGOKRB+INFGf49LDPO+uKGjsrgJqGAVR5Aiw1YWG+G0EgvO17vESvDBhez
        bGsKOtIPx1Shv6DugrPj8yvw/zEUaeB6gnIdKPOjY19iZ/kj+ppco1MWVzrPrqi7kes/QiWpwBgId
        tURwjT2sITxWANYpNMFE+HHZu+7yO164ZnqdXG4k9z9rO6AbWMAyfMMS4nxN0jiqmBC0SMWS8Bi5r
        rCqd2sRA==;
Received: from 089144210233.atnat0019.highway.a1.net ([89.144.210.233] helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1hRBxZ-0005PT-Go; Thu, 16 May 2019 08:41:53 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     axboe@fb.com
Cc:     ming.lei@redhat.com, linux-block@vger.kernel.org
Subject: [PATCH 3/4] block: remove the segment size check in bio_will_gap
Date:   Thu, 16 May 2019 10:40:57 +0200
Message-Id: <20190516084058.20678-4-hch@lst.de>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190516084058.20678-1-hch@lst.de>
References: <20190516084058.20678-1-hch@lst.de>
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

