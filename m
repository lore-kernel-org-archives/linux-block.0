Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DB679CA0FF3
	for <linux-block@archiver.kernel.org>; Tue,  5 Sep 2023 16:25:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348572AbjIEQZN (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 5 Sep 2023 12:25:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38526 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1354586AbjIEMrj (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Tue, 5 Sep 2023 08:47:39 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C438A1A6
        for <linux-block@vger.kernel.org>; Tue,  5 Sep 2023 05:47:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        MIME-Version:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
        Content-ID:Content-Description:In-Reply-To:References;
        bh=nmkgySJXef3i3b/Buj6bY+9d63/8+xCAx84ENpTUqcg=; b=w0vgxZjUF+pyK9XVBz4TedniJZ
        bvTPl3JW7vX5SvWn6tGAaUio+CCTXbMSEkF8MiXweX32ZcqrQf2YDJIIUJXu6Qgy5qoFxWV1PxQhN
        tK9/TePGLticwJtlGOc1D72x2D0l9YRS//V319OC13mWyASmrUITBy7ZuMvHFKypa4oVYhDLil5yC
        InahXdXknAJBkTVqrU1LJCw38tJYcaBKOmzdysuRVPuCx10baGKbofFIQwMlAhKI+MCSCXWJ7fVWV
        U1c3HxLZjqoqtYy77gf1BlT5Xr/iM7J6AfZJ6ibOZ13IhqlkELmgbQUoUOWqRBxffmI+nwjN86Cxh
        xQpGIcmg==;
Received: from 2a02-8389-2341-5b80-39d3-4735-9a3c-88d8.cable.dynamic.v6.surfer.at ([2a02:8389:2341:5b80:39d3:4735:9a3c:88d8] helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
        id 1qdVSx-0062y4-02;
        Tue, 05 Sep 2023 12:47:35 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     axboe@kernel.dk
Cc:     linux-block@vger.kernel.org
Subject: [PATCH] block: fix pin count management when merging same-page segments
Date:   Tue,  5 Sep 2023 14:47:31 +0200
Message-Id: <20230905124731.328255-1-hch@lst.de>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

There is no need to unpin the added page when adding it to the bio fails
as that is done by the loop below.  Instead we want to unpin it when adding
a single page to the bio more than once as bio_release_pages will only
unpin it once.

Fixes: d1916c86ccdc ("block: move same page handling from __bio_add_pc_page to the callers")
Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 block/blk-map.c | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/block/blk-map.c b/block/blk-map.c
index 44d74a30ddac04..8584babf3ea0ca 100644
--- a/block/blk-map.c
+++ b/block/blk-map.c
@@ -315,12 +315,11 @@ static int bio_map_user_iov(struct request *rq, struct iov_iter *iter,
 					n = bytes;
 
 				if (!bio_add_hw_page(rq->q, bio, page, n, offs,
-						     max_sectors, &same_page)) {
-					if (same_page)
-						bio_release_page(bio, page);
+						     max_sectors, &same_page))
 					break;
-				}
 
+				if (same_page)
+					bio_release_page(bio, page);
 				bytes -= n;
 				offs = 0;
 			}
-- 
2.39.2

