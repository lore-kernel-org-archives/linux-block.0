Return-Path: <SRS0=vpK8=6T=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EABEAC47247
	for <linux-block@archiver.kernel.org>; Tue,  5 May 2020 11:56:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CF4DC206A5
	for <linux-block@archiver.kernel.org>; Tue,  5 May 2020 11:56:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728873AbgEEL4N (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 5 May 2020 07:56:13 -0400
Received: from szxga05-in.huawei.com ([45.249.212.191]:3804 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728793AbgEEL4I (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Tue, 5 May 2020 07:56:08 -0400
Received: from DGGEMS414-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id DB54372B6C5ABD53585B;
        Tue,  5 May 2020 19:56:03 +0800 (CST)
Received: from DESKTOP-C3MD9UG.china.huawei.com (10.166.215.55) by
 DGGEMS414-HUB.china.huawei.com (10.3.19.214) with Microsoft SMTP Server id
 14.3.487.0; Tue, 5 May 2020 19:55:55 +0800
From:   Zhen Lei <thunder.leizhen@huawei.com>
To:     Minchan Kim <minchan@kernel.org>, Nitin Gupta <ngupta@vflare.org>,
        "Sergey Senozhatsky" <sergey.senozhatsky.work@gmail.com>,
        Jens Axboe <axboe@kernel.dk>,
        linux-block <linux-block@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-mm <linux-mm@kvack.org>, Alasdair Kergon <agk@redhat.com>,
        Mike Snitzer <snitzer@redhat.com>,
        dm-devel <dm-devel@redhat.com>, Song Liu <song@kernel.org>,
        linux-raid <linux-raid@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
CC:     Zhen Lei <thunder.leizhen@huawei.com>
Subject: [PATCH 1/4] block: Move SECTORS_PER_PAGE and SECTORS_PER_PAGE_SHIFT definitions into <linux/blkdev.h>
Date:   Tue, 5 May 2020 19:55:40 +0800
Message-ID: <20200505115543.1660-2-thunder.leizhen@huawei.com>
X-Mailer: git-send-email 2.26.0.windows.1
In-Reply-To: <20200505115543.1660-1-thunder.leizhen@huawei.com>
References: <20200505115543.1660-1-thunder.leizhen@huawei.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.166.215.55]
X-CFilter-Loop: Reflected
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

This is similar to commit 233bde21a ("block: Move SECTOR_SIZE and
SECTOR_SHIFT definitions into <linux/blkdev.h>"), prepare to clear dozens
of duplicated codes.

Signed-off-by: Zhen Lei <thunder.leizhen@huawei.com>
---
 drivers/block/zram/zram_drv.h |  2 --
 include/linux/blkdev.h        | 10 ++++++++--
 2 files changed, 8 insertions(+), 4 deletions(-)

diff --git a/drivers/block/zram/zram_drv.h b/drivers/block/zram/zram_drv.h
index f2fd46daa760..12309175d55e 100644
--- a/drivers/block/zram/zram_drv.h
+++ b/drivers/block/zram/zram_drv.h
@@ -21,8 +21,6 @@
 
 #include "zcomp.h"
 
-#define SECTORS_PER_PAGE_SHIFT	(PAGE_SHIFT - SECTOR_SHIFT)
-#define SECTORS_PER_PAGE	(1 << SECTORS_PER_PAGE_SHIFT)
 #define ZRAM_LOGICAL_BLOCK_SHIFT 12
 #define ZRAM_LOGICAL_BLOCK_SIZE	(1 << ZRAM_LOGICAL_BLOCK_SHIFT)
 #define ZRAM_SECTOR_PER_LOGICAL_BLOCK	\
diff --git a/include/linux/blkdev.h b/include/linux/blkdev.h
index 32868fbedc9e..a752e1c80bf0 100644
--- a/include/linux/blkdev.h
+++ b/include/linux/blkdev.h
@@ -904,10 +904,16 @@ static inline struct request_queue *bdev_get_queue(struct block_device *bdev)
  * multiple of 512 bytes. Hence these two constants.
  */
 #ifndef SECTOR_SHIFT
-#define SECTOR_SHIFT 9
+#define SECTOR_SHIFT		9
 #endif
 #ifndef SECTOR_SIZE
-#define SECTOR_SIZE (1 << SECTOR_SHIFT)
+#define SECTOR_SIZE		(1 << SECTOR_SHIFT)
+#endif
+#ifndef SECTORS_PER_PAGE_SHIFT
+#define SECTORS_PER_PAGE_SHIFT	(PAGE_SHIFT - SECTOR_SHIFT)
+#endif
+#ifndef SECTORS_PER_PAGE
+#define SECTORS_PER_PAGE	(1 << SECTORS_PER_PAGE_SHIFT)
 #endif
 
 /*
-- 
2.26.0.106.g9fadedd


