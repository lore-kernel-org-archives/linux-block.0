Return-Path: <SRS0=TF98=TN=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0B8A4C04AB1
	for <linux-block@archiver.kernel.org>; Mon, 13 May 2019 06:39:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CDA3820879
	for <linux-block@archiver.kernel.org>; Mon, 13 May 2019 06:39:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="uzOjiRgm"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727327AbfEMGjD (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 13 May 2019 02:39:03 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:36016 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726181AbfEMGjD (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 13 May 2019 02:39:03 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From
        :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=Q2pNw2OEvlZU2mjuLx4ovc/Bm3KmL0NHqCFYnfnd7Pw=; b=uzOjiRgmlR9AoCFhmyiCZnzjQr
        dPgZbOvQQmRcMzBHRIorW4MOHV4G7DtOt0C9CVauEkqjIv1ImUqpyCN/49IZa3ComeN5J4prxzZ0i
        JwAZFAZ9TNIfGR6amjPCUiR7SYGFbhQTsess9H/Ty4rJug3QmsK/glQTGx7LtKVB/XAIeOYw/SjZL
        2aFQMBJk2zjVWTFTKCzNPv9+3I0pAQCXZwzq+tWuMuePuAgQaHOyy0c6MFOjcBPyTyjaM6hfvzbZz
        KlsoubNGm8q3LSYrmv4e4qxEZUR/T6blIaJVqHokueX7/8ajqPv3hnXFD3YbJzfV/ZsOh9sv0omtk
        xijv3o5w==;
Received: from 089144210233.atnat0019.highway.a1.net ([89.144.210.233] helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1hQ4c0-0007RW-Io; Mon, 13 May 2019 06:39:00 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     axboe@fb.com
Cc:     ming.lei@redhat.com, Matias Bjorling <mb@lightnvm.io>,
        linux-block@vger.kernel.org
Subject: [PATCH 09/10] block: untangle the end of blk_bio_segment_split
Date:   Mon, 13 May 2019 08:37:53 +0200
Message-Id: <20190513063754.1520-10-hch@lst.de>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190513063754.1520-1-hch@lst.de>
References: <20190513063754.1520-1-hch@lst.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Now that we don't need to assign the front/back segment sizes, we can
duplicating the segs assignment for the split vs no-split case and
remove a whole chunk of boilerplate code.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 block/blk-merge.c | 14 +++-----------
 1 file changed, 3 insertions(+), 11 deletions(-)

diff --git a/block/blk-merge.c b/block/blk-merge.c
index 2ea21ffd5f72..ca45eb51c669 100644
--- a/block/blk-merge.c
+++ b/block/blk-merge.c
@@ -202,8 +202,6 @@ static struct bio *blk_bio_segment_split(struct request_queue *q,
 	struct bio_vec bv, bvprv, *bvprvp = NULL;
 	struct bvec_iter iter;
 	unsigned nsegs = 0, sectors = 0;
-	bool do_split = true;
-	struct bio *new = NULL;
 	const unsigned max_sectors = get_max_io_size(q, bio);
 	const unsigned max_segs = queue_max_segments(q);
 
@@ -245,17 +243,11 @@ static struct bio *blk_bio_segment_split(struct request_queue *q,
 		}
 	}
 
-	do_split = false;
+	*segs = nsegs;
+	return NULL;
 split:
 	*segs = nsegs;
-
-	if (do_split) {
-		new = bio_split(bio, sectors, GFP_NOIO, bs);
-		if (new)
-			bio = new;
-	}
-
-	return do_split ? new : NULL;
+	return bio_split(bio, sectors, GFP_NOIO, bs);
 }
 
 void __blk_queue_split(struct request_queue *q, struct bio **bio,
-- 
2.20.1

