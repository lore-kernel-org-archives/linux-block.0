Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1C9D9C43217
	for <linux-block@archiver.kernel.org>; Wed,  4 May 2022 14:34:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351341AbiEDOhf (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 4 May 2022 10:37:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48944 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1351347AbiEDOhb (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Wed, 4 May 2022 10:37:31 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E576E40E47
        for <linux-block@vger.kernel.org>; Wed,  4 May 2022 07:33:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        MIME-Version:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
        Content-ID:Content-Description:In-Reply-To:References;
        bh=+kuM4pxVr9aTuSdI6sUocK62aJKA0/y6+JL8PB0l0Qk=; b=KKlmJVsWO+vrGQ9wd5fg8HN0T0
        R3h9B8lUKvyubUVYhYsrRtArqI2YxAgrRC32hrfAmoVptqUrsIdXqAOF+5vExJOfRPtrma9lCgq+K
        APjXjdc+u2KHtd5zEhjpcKBMVQe+d1+ux2gS8CmGodr3w46oVZWSdzlD4zPENQHQpUVOH0KlAg0XL
        U5+3aMu3VZffIx0I752UH3FDE6Lj0ojAuYCBzywzs0ylRRgfT+BQHisdpP4v1YIsFi+DDfxFDldnk
        mWXlCEgihAmXC3X/VzOmy+CE8vKwQIjJu9bm0dcfhjVtVejEe52FTiKgo4hxOB0pySshIGL72nBcD
        kxWeOvmA==;
Received: from [8.34.116.185] (helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nmG4h-00BH14-FV; Wed, 04 May 2022 14:33:55 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     axboe@kernel.dk
Cc:     linux-block@vger.kernel.org
Subject: [PATCH] block: improve the error message from bio_check_eod
Date:   Wed,  4 May 2022 07:33:55 -0700
Message-Id: <20220504143355.568660-1-hch@lst.de>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Print the start sector and length separately instead of the combined
value to help with debugging.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 block/blk-core.c | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/block/blk-core.c b/block/blk-core.c
index 937bb6b863317..10b32a1cc42b7 100644
--- a/block/blk-core.c
+++ b/block/blk-core.c
@@ -592,10 +592,9 @@ static inline int bio_check_eod(struct bio *bio)
 	    (nr_sectors > maxsector ||
 	     bio->bi_iter.bi_sector > maxsector - nr_sectors)) {
 		pr_info_ratelimited("%s: attempt to access beyond end of device\n"
-				    "%pg: rw=%d, want=%llu, limit=%llu\n",
-				    current->comm,
-				    bio->bi_bdev, bio->bi_opf,
-				    bio_end_sector(bio), maxsector);
+				    "%pg: rw=%d, sector=%llu, nr_sectors = %u limit=%llu\n",
+				    current->comm, bio->bi_bdev, bio->bi_opf,
+				    bio->bi_iter.bi_sector, nr_sectors, maxsector);
 		return -EIO;
 	}
 	return 0;
-- 
2.30.2

