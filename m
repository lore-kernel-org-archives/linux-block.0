Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 72F55C4743E
	for <linux-block@archiver.kernel.org>; Tue,  8 Jun 2021 16:08:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 617FA61360
	for <linux-block@archiver.kernel.org>; Tue,  8 Jun 2021 16:08:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234078AbhFHQKT (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 8 Jun 2021 12:10:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53162 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233880AbhFHQJF (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Tue, 8 Jun 2021 12:09:05 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 544FDC0611C0;
        Tue,  8 Jun 2021 09:07:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description;
        bh=MyECqL7omrkh9N+zg6dzXAPF0qAslqNXJGlcR34EKvY=; b=b4Ja1PJtReL64inLe6q6cCHK2j
        QtsAsUGVqoXMk0uXRjtZKKxZ1KcDPFQ/2E3g7QVHWcya9I0qbV0cZ5SR6kwGsWdFU8pVgJkrBquar
        YxBxkAuHdDeCnhSV/aNvk9DoZDnXfzyOxprW2nqGWTXUdNdrJMmEsIP+Zgda00i5siUaPwCB1GzQY
        HGZo+IiuzOhYzTOjOzinhBZg2wu3GuX+/uVu52zf3xUxqxm/RYdi7Poxkf3mu42ry3kQqBBfvOmgt
        D9NnR40fuODEKp23cRsjGb3lOrICZfro2Zap+kPgitNZaEtEcqM5SUhVJZcVvRhvUJJ9BFQIZlJAi
        Ex1/l4NQ==;
Received: from [2001:4bb8:192:ff5f:74ed:7c4f:a5ee:8dcb] (helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1lqeFh-009RlV-DI; Tue, 08 Jun 2021 16:06:54 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        Geoff Levand <geoff@infradead.org>,
        Ilya Dryomov <idryomov@gmail.com>,
        Dongsheng Yang <dongsheng.yang@easystack.cn>,
        Mike Snitzer <snitzer@redhat.com>,
        Ira Weiny <ira.weiny@intel.com>, dm-devel@redhat.com,
        linux-mips@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-block@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        ceph-devel@vger.kernel.org
Subject: [PATCH 14/16] block: use memcpy_from_bvec in __blk_queue_bounce
Date:   Tue,  8 Jun 2021 18:06:01 +0200
Message-Id: <20210608160603.1535935-15-hch@lst.de>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210608160603.1535935-1-hch@lst.de>
References: <20210608160603.1535935-1-hch@lst.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Rewrite the actual bounce buffering loop in __blk_queue_bounce to that
the memcpy_to_bvec helper can be used to perform the data copies.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 block/bounce.c | 21 +++++++--------------
 1 file changed, 7 insertions(+), 14 deletions(-)

diff --git a/block/bounce.c b/block/bounce.c
index a2fc6326b6c9..b5ad09e07bcf 100644
--- a/block/bounce.c
+++ b/block/bounce.c
@@ -243,24 +243,17 @@ void __blk_queue_bounce(struct request_queue *q, struct bio **bio_orig)
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
 
-		if (rw == WRITE) {
-			char *vto, *vfrom;
-
-			flush_dcache_page(page);
-
-			vto = page_address(to->bv_page) + to->bv_offset;
-			vfrom = kmap_atomic(page) + to->bv_offset;
-			memcpy(vto, vfrom, to->bv_len);
-			kunmap_atomic(vfrom);
-		}
+		if (rw == WRITE)
+			memcpy_from_bvec(page_address(bounce_page), to);
+		to->bv_page = bounce_page;
 	}
 
 	trace_block_bio_bounce(*bio_orig);
-- 
2.30.2

