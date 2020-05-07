Return-Path: <SRS0=Cb6v=6V=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DB0FCC47247
	for <linux-block@archiver.kernel.org>; Thu,  7 May 2020 07:56:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C11E62084D
	for <linux-block@archiver.kernel.org>; Thu,  7 May 2020 07:56:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726393AbgEGHz4 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 7 May 2020 03:55:56 -0400
Received: from szxga06-in.huawei.com ([45.249.212.32]:52512 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725849AbgEGHzz (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Thu, 7 May 2020 03:55:55 -0400
Received: from DGGEMS406-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id 708B77979A8DA881C073;
        Thu,  7 May 2020 15:55:53 +0800 (CST)
Received: from DESKTOP-C3MD9UG.china.huawei.com (10.166.215.55) by
 DGGEMS406-HUB.china.huawei.com (10.3.19.206) with Microsoft SMTP Server id
 14.3.487.0; Thu, 7 May 2020 15:55:46 +0800
From:   Zhen Lei <thunder.leizhen@huawei.com>
To:     Minchan Kim <minchan@kernel.org>, Nitin Gupta <ngupta@vflare.org>,
        "Sergey Senozhatsky" <sergey.senozhatsky.work@gmail.com>,
        Matthew Wilcox <willy@infradead.org>,
        Jens Axboe <axboe@kernel.dk>, Coly Li <colyli@suse.de>,
        Kent Overstreet <kent.overstreet@gmail.com>,
        "Alasdair Kergon" <agk@redhat.com>,
        Mike Snitzer <snitzer@redhat.com>,
        linux-block <linux-block@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-mm <linux-mm@kvack.org>, dm-devel <dm-devel@redhat.com>,
        Song Liu <song@kernel.org>,
        linux-raid <linux-raid@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
CC:     Zhen Lei <thunder.leizhen@huawei.com>
Subject: [PATCH v2 02/10] zram: abolish macro SECTORS_PER_PAGE
Date:   Thu, 7 May 2020 15:50:52 +0800
Message-ID: <20200507075100.1779-3-thunder.leizhen@huawei.com>
X-Mailer: git-send-email 2.26.0.windows.1
In-Reply-To: <20200507075100.1779-1-thunder.leizhen@huawei.com>
References: <20200507075100.1779-1-thunder.leizhen@huawei.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.166.215.55]
X-CFilter-Loop: Reflected
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

SECTORS_PER_PAGE is equivalent to PAGE_SECTORS.

Although I prefer SECTORS_PER_PAGE better than PAGE_SECTORS, the former
is more clearer, I think. But the latter was defined in
<linux/device-mapper.h> before, rename it may impact users.

Signed-off-by: Zhen Lei <thunder.leizhen@huawei.com>
---
 drivers/block/zram/zram_drv.c | 4 ++--
 drivers/block/zram/zram_drv.h | 1 -
 2 files changed, 2 insertions(+), 3 deletions(-)

diff --git a/drivers/block/zram/zram_drv.c b/drivers/block/zram/zram_drv.c
index ebb234f36909..e2fbf7a847e7 100644
--- a/drivers/block/zram/zram_drv.c
+++ b/drivers/block/zram/zram_drv.c
@@ -1551,7 +1551,7 @@ static void __zram_make_request(struct zram *zram, struct bio *bio)
 
 	index = bio->bi_iter.bi_sector >> SECTORS_PER_PAGE_SHIFT;
 	offset = (bio->bi_iter.bi_sector &
-		  (SECTORS_PER_PAGE - 1)) << SECTOR_SHIFT;
+		  (PAGE_SECTORS - 1)) << SECTOR_SHIFT;
 
 	switch (bio_op(bio)) {
 	case REQ_OP_DISCARD:
@@ -1645,7 +1645,7 @@ static int zram_rw_page(struct block_device *bdev, sector_t sector,
 	}
 
 	index = sector >> SECTORS_PER_PAGE_SHIFT;
-	offset = (sector & (SECTORS_PER_PAGE - 1)) << SECTOR_SHIFT;
+	offset = (sector & (PAGE_SECTORS - 1)) << SECTOR_SHIFT;
 
 	bv.bv_page = page;
 	bv.bv_len = PAGE_SIZE;
diff --git a/drivers/block/zram/zram_drv.h b/drivers/block/zram/zram_drv.h
index f2fd46daa760..10fdf413dd6e 100644
--- a/drivers/block/zram/zram_drv.h
+++ b/drivers/block/zram/zram_drv.h
@@ -22,7 +22,6 @@
 #include "zcomp.h"
 
 #define SECTORS_PER_PAGE_SHIFT	(PAGE_SHIFT - SECTOR_SHIFT)
-#define SECTORS_PER_PAGE	(1 << SECTORS_PER_PAGE_SHIFT)
 #define ZRAM_LOGICAL_BLOCK_SHIFT 12
 #define ZRAM_LOGICAL_BLOCK_SIZE	(1 << ZRAM_LOGICAL_BLOCK_SHIFT)
 #define ZRAM_SECTOR_PER_LOGICAL_BLOCK	\
-- 
2.26.0.106.g9fadedd


