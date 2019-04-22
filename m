Return-Path: <SRS0=Rcoh=SY=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 290D8C10F11
	for <linux-block@archiver.kernel.org>; Mon, 22 Apr 2019 13:19:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EF04420693
	for <linux-block@archiver.kernel.org>; Mon, 22 Apr 2019 13:19:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726421AbfDVNTM (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 22 Apr 2019 09:19:12 -0400
Received: from szxga04-in.huawei.com ([45.249.212.190]:6672 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726407AbfDVNTM (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Mon, 22 Apr 2019 09:19:12 -0400
Received: from DGGEMS401-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id B29262D0E41B3BC73902;
        Mon, 22 Apr 2019 21:18:58 +0800 (CST)
Received: from huawei.com (10.90.53.225) by DGGEMS401-HUB.china.huawei.com
 (10.3.19.201) with Microsoft SMTP Server id 14.3.439.0; Mon, 22 Apr 2019
 21:18:54 +0800
From:   Hou Tao <houtao1@huawei.com>
To:     <linux-block@vger.kernel.org>, <axboe@kernel.dk>,
        <dan.j.williams@intel.com>
CC:     <linux-kernel@vger.kernel.org>
Subject: [PATCH] brd: re-enable __GFP_HIGHMEM in brd_insert_page()
Date:   Mon, 22 Apr 2019 21:23:21 +0800
Message-ID: <20190422132321.100156-1-houtao1@huawei.com>
X-Mailer: git-send-email 2.16.2.dirty
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.90.53.225]
X-CFilter-Loop: Reflected
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

__GFP_HIGHMEM is disabled if dax is enabled on brd, however
dax support for brd has been removed since commit (7a862fbbdec6
"brd: remove dax support"), so restore __GFP_HIGHMEM in
brd_insert_page().

Also remove the no longer applicable comments about DAX and highmem.

Cc: stable@vger.kernel.org
Fixes: 7a862fbbdec6 ("brd: remove dax support")
Signed-off-by: Hou Tao <houtao1@huawei.com>
---
 drivers/block/brd.c | 7 +------
 1 file changed, 1 insertion(+), 6 deletions(-)

diff --git a/drivers/block/brd.c b/drivers/block/brd.c
index c18586fccb6f..17defbf4f332 100644
--- a/drivers/block/brd.c
+++ b/drivers/block/brd.c
@@ -96,13 +96,8 @@ static struct page *brd_insert_page(struct brd_device *brd, sector_t sector)
 	/*
 	 * Must use NOIO because we don't want to recurse back into the
 	 * block or filesystem layers from page reclaim.
-	 *
-	 * Cannot support DAX and highmem, because our ->direct_access
-	 * routine for DAX must return memory that is always addressable.
-	 * If DAX was reworked to use pfns and kmap throughout, this
-	 * restriction might be able to be lifted.
 	 */
-	gfp_flags = GFP_NOIO | __GFP_ZERO;
+	gfp_flags = GFP_NOIO | __GFP_ZERO | __GFP_HIGHMEM;
 	page = alloc_page(gfp_flags);
 	if (!page)
 		return NULL;
-- 
2.16.2.dirty

