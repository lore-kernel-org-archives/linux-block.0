Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2D13EC04A6A
	for <linux-block@archiver.kernel.org>; Mon, 24 Jul 2023 16:54:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231251AbjGXQyh (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 24 Jul 2023 12:54:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44106 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231221AbjGXQyg (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 24 Jul 2023 12:54:36 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C1C8410F8
        for <linux-block@vger.kernel.org>; Mon, 24 Jul 2023 09:54:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description;
        bh=/L4Vf6XgX1i8Sa3+yr/s3kpmCh1ZQ3gtttexj4gOiSA=; b=if925Q/XjllAAUlGwWCFx9Bepm
        H8yI+sClIxfqCTajsyyicRcuZb5IVPSLmT+Lt19eNw1Pd79ftNTAHxctpymfEvrho2YNMIfRadJZ2
        gvtqyHsRh+Vs0LkPzApeC3YxZWD/gHH8bbX1eimpw4Xt0rKUxmvO63dPHj0AgtImp05J+7AuJwPgW
        BwDyZWbB+kRQ+LywIi761lpnfjboLKhWFgz4/g3Ro3ia+naKkwolBybGn8XRmPK6sC3kn81QvwXhs
        rple+7tvKM07c3JBC8ioIf0J6/PLGe+OedRaYrz+PPy5zx6sK4i9STJdZ7HHfRM7fZ/pIckI33gzC
        bMgoh2bg==;
Received: from 67-207-104-238.static.wiline.com ([67.207.104.238] helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
        id 1qNypN-004vtx-1q;
        Mon, 24 Jul 2023 16:54:33 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     Jinyoung Choi <j-young.choi@samsung.com>,
        linux-block@vger.kernel.org
Subject: [PATCH 1/8] block: tidy up the bio full checks in bio_add_hw_page
Date:   Mon, 24 Jul 2023 09:54:26 -0700
Message-Id: <20230724165433.117645-2-hch@lst.de>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230724165433.117645-1-hch@lst.de>
References: <20230724165433.117645-1-hch@lst.de>
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
index 8672179213b939..72488ecea47acf 100644
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

