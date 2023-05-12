Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AC3EEC77B75
	for <linux-block@archiver.kernel.org>; Fri, 12 May 2023 13:39:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241312AbjELNjR (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 12 May 2023 09:39:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52692 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241143AbjELNjP (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 12 May 2023 09:39:15 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DC526132B7
        for <linux-block@vger.kernel.org>; Fri, 12 May 2023 06:39:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description;
        bh=LIiB/VbCyFbq40WUPLTMMhOjz0fmCLpHrEi8nqJDHGk=; b=tCcwNGw0kgZh6NLbC4x7C3gDc3
        W8aMZtJ3HxetCsp8izeObsZmrzVa5uBqd9akvTlE3OFXeTUwaTALTXjqMP1A/3YmflbcLYVDCgMPh
        8njkp25BqoMFycm3JH9mGWkJh8/3PKtJrnhW29LJM+9QifftmOAdcOa+KA8JXTspXX2Ko1zIUe+EZ
        lK05iYvvKPBEevKNFIeEfQKFaXPuUFCSFGUUgAoosvnlEw1DJulTLHgPyW8ZjBwBt07W7xJ3QRwPK
        lh0/JfX0SVRfERP2oAY8ZAvYTGp+KcDJth4lTRCEDBrz0ai5Su6mXSVL+ZeI1MVPFTTcXWf4BOgpV
        hqy5/OrA==;
Received: from [204.239.251.3] (helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
        id 1pxSzJ-00C2hc-0S;
        Fri, 12 May 2023 13:39:13 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     Jinyoung Choi <j-young.choi@samsung.com>,
        linux-block@vger.kernel.org
Subject: [PATCH 1/8] block: tidy up the bio full checks in bio_add_hw_page
Date:   Fri, 12 May 2023 06:38:54 -0700
Message-Id: <20230512133901.1053543-2-hch@lst.de>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230512133901.1053543-1-hch@lst.de>
References: <20230512133901.1053543-1-hch@lst.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

bio_add_hw_page already checks if the number of bytes trying to be added
even fit into max_hw_sectors limit of the queue.   Remove the call to
bio_full and just do a check for the smaller of the number of segments
in the bio and the queue max segments limit, and do this cheap check
before the more expensive gap to previous check.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 block/bio.c | 10 ++++------
 1 file changed, 4 insertions(+), 6 deletions(-)

diff --git a/block/bio.c b/block/bio.c
index 043944fd46ebbc..1528ca0f3df6dc 100644
--- a/block/bio.c
+++ b/block/bio.c
@@ -1014,6 +1014,10 @@ int bio_add_hw_page(struct request_queue *q, struct bio *bio,
 		if (bio_try_merge_hw_seg(q, bio, page, len, offset, same_page))
 			return len;
 
+		if (bio->bi_vcnt >=
+		    min(bio->bi_max_vecs, queue_max_segments(q)))
+			return 0;
+
 		/*
 		 * If the queue doesn't support SG gaps and adding this segment
 		 * would create a gap, disallow it.
@@ -1023,12 +1027,6 @@ int bio_add_hw_page(struct request_queue *q, struct bio *bio,
 			return 0;
 	}
 
-	if (bio_full(bio, len))
-		return 0;
-
-	if (bio->bi_vcnt >= queue_max_segments(q))
-		return 0;
-
 	bvec_set_page(&bio->bi_io_vec[bio->bi_vcnt], page, len, offset);
 	bio->bi_vcnt++;
 	bio->bi_iter.bi_size += len;
-- 
2.39.2

