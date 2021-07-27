Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2D746C4320E
	for <linux-block@archiver.kernel.org>; Tue, 27 Jul 2021 06:21:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 15F2B610D2
	for <linux-block@archiver.kernel.org>; Tue, 27 Jul 2021 06:21:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235723AbhG0GVZ (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 27 Jul 2021 02:21:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49482 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235687AbhG0GVY (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 27 Jul 2021 02:21:24 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1D35EC061757;
        Mon, 26 Jul 2021 23:21:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description;
        bh=sXn6CESfDSf/BahsG4NV3slh6uN4B0wtJRs8tnEF8cc=; b=b6S5pZ8YZugLlKe23xpGWHEacK
        rJWFacoPQ3SENX6BdORb9E1EIGc3LOWsE4ye1Qz6Rgq8/Nm3MTBVab03nLghvWmodnV7qRD/VegZO
        Nc/IupSnMO3IfYbYzoZfwNNn6+yeGi8Y9YCGFlDZf0azTLuBnqAl1oQSpOrj0Sv6yVgM5lSwRDmY8
        CvuIBF+Gw8qXu+JOy3a1xNdamEzFlMT5ihM9JsuTIU4tNaPw6O1G0ro4vkSOVq80/VRw9U8bPwnD9
        ZoylSuD5dOIsCODz+KtfXbKyAbewoSj1qW04vbX289FEkjHB5VScjCZC0CcqgX3S4Rg5yJ//TUaz3
        0lXuV9kw==;
Received: from [2001:4bb8:184:87c5:b7fb:1299:a9e5:ff56] (helo=localhost)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1m8GP5-00EjY8-Up; Tue, 27 Jul 2021 06:18:08 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Jens Axboe <axboe@kernel.dk>, Thomas Gleixner <tglx@linutronix.de>
Cc:     Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        Andrew Morton <akpm@linux-foundation.org>,
        Geoff Levand <geoff@infradead.org>,
        Ilya Dryomov <idryomov@gmail.com>,
        Dongsheng Yang <dongsheng.yang@easystack.cn>,
        Mike Snitzer <snitzer@redhat.com>,
        "James E.J. Bottomley" <James.Bottomley@HansenPartnership.com>,
        Ira Weiny <ira.weiny@intel.com>, dm-devel@redhat.com,
        linux-mips@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-block@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        ceph-devel@vger.kernel.org, linux-arch@vger.kernel.org,
        "Martin K . Petersen" <martin.petersen@oracle.com>
Subject: [PATCH 13/15] block: use memcpy_from_bvec in __blk_queue_bounce
Date:   Tue, 27 Jul 2021 07:56:44 +0200
Message-Id: <20210727055646.118787-14-hch@lst.de>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210727055646.118787-1-hch@lst.de>
References: <20210727055646.118787-1-hch@lst.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by casper.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Rewrite the actual bounce buffering loop in __blk_queue_bounce to that
the memcpy_to_bvec helper can be used to perform the data copies.

Signed-off-by: Christoph Hellwig <hch@lst.de>
Reviewed-by: Martin K. Petersen <martin.petersen@oracle.com>
---
 block/bounce.c | 19 +++++++------------
 1 file changed, 7 insertions(+), 12 deletions(-)

diff --git a/block/bounce.c b/block/bounce.c
index 7e9e666c04dc..05fc7148489d 100644
--- a/block/bounce.c
+++ b/block/bounce.c
@@ -239,24 +239,19 @@ void __blk_queue_bounce(struct request_queue *q, struct bio **bio_orig)
 	 * because the 'bio' is single-page bvec.
 	 */
 	for (i = 0, to = bio->bi_io_vec; i < bio->bi_vcnt; to++, i++) {
-		struct page *page = to->bv_page;
+		struct page *bounce_page;
 
-		if (!PageHighMem(page))
+		if (!PageHighMem(to->bv_page))
 			continue;
 
-		to->bv_page = mempool_alloc(&page_pool, GFP_NOIO);
-		inc_zone_page_state(to->bv_page, NR_BOUNCE);
+		bounce_page = mempool_alloc(&page_pool, GFP_NOIO);
+		inc_zone_page_state(bounce_page, NR_BOUNCE);
 
 		if (rw == WRITE) {
-			char *vto, *vfrom;
-
-			flush_dcache_page(page);
-
-			vto = page_address(to->bv_page) + to->bv_offset;
-			vfrom = kmap_atomic(page) + to->bv_offset;
-			memcpy(vto, vfrom, to->bv_len);
-			kunmap_atomic(vfrom);
+			flush_dcache_page(to->bv_page);
+			memcpy_from_bvec(page_address(bounce_page), to);
 		}
+		to->bv_page = bounce_page;
 	}
 
 	trace_block_bio_bounce(*bio_orig);
-- 
2.30.2

