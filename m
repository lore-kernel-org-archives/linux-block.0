Return-Path: <SRS0=Cb6v=6V=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0A0DFC54E49
	for <linux-block@archiver.kernel.org>; Thu,  7 May 2020 07:56:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E9A1A2083B
	for <linux-block@archiver.kernel.org>; Thu,  7 May 2020 07:56:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725910AbgEGHz4 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 7 May 2020 03:55:56 -0400
Received: from szxga06-in.huawei.com ([45.249.212.32]:52454 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725834AbgEGHzz (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Thu, 7 May 2020 03:55:55 -0400
Received: from DGGEMS406-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id 5F976B5F71AE7B2ED715;
        Thu,  7 May 2020 15:55:53 +0800 (CST)
Received: from DESKTOP-C3MD9UG.china.huawei.com (10.166.215.55) by
 DGGEMS406-HUB.china.huawei.com (10.3.19.206) with Microsoft SMTP Server id
 14.3.487.0; Thu, 7 May 2020 15:55:45 +0800
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
Subject: [PATCH v2 01/10] block: move PAGE_SECTORS definition into <linux/blkdev.h>
Date:   Thu, 7 May 2020 15:50:51 +0800
Message-ID: <20200507075100.1779-2-thunder.leizhen@huawei.com>
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

Too many duplicated PAGE_SECTORS definitions, eliminate it.

Signed-off-by: Zhen Lei <thunder.leizhen@huawei.com>
---
 drivers/block/brd.c           | 1 -
 drivers/block/null_blk_main.c | 1 -
 drivers/md/bcache/util.h      | 2 --
 include/linux/blkdev.h        | 5 +++--
 include/linux/device-mapper.h | 1 -
 5 files changed, 3 insertions(+), 7 deletions(-)

diff --git a/drivers/block/brd.c b/drivers/block/brd.c
index 2fb25c348d53..30df6daa9dbc 100644
--- a/drivers/block/brd.c
+++ b/drivers/block/brd.c
@@ -26,7 +26,6 @@
 #include <linux/uaccess.h>
 
 #define PAGE_SECTORS_SHIFT	(PAGE_SHIFT - SECTOR_SHIFT)
-#define PAGE_SECTORS		(1 << PAGE_SECTORS_SHIFT)
 
 /*
  * Each block ramdisk device has a radix_tree brd_pages of pages that stores
diff --git a/drivers/block/null_blk_main.c b/drivers/block/null_blk_main.c
index 8efd8778e209..25048ff15858 100644
--- a/drivers/block/null_blk_main.c
+++ b/drivers/block/null_blk_main.c
@@ -12,7 +12,6 @@
 #include "null_blk.h"
 
 #define PAGE_SECTORS_SHIFT	(PAGE_SHIFT - SECTOR_SHIFT)
-#define PAGE_SECTORS		(1 << PAGE_SECTORS_SHIFT)
 #define SECTOR_MASK		(PAGE_SECTORS - 1)
 
 #define FREE_BATCH		16
diff --git a/drivers/md/bcache/util.h b/drivers/md/bcache/util.h
index c029f7443190..55196e0f37c3 100644
--- a/drivers/md/bcache/util.h
+++ b/drivers/md/bcache/util.h
@@ -15,8 +15,6 @@
 
 #include "closure.h"
 
-#define PAGE_SECTORS		(PAGE_SIZE / 512)
-
 struct closure;
 
 #ifdef CONFIG_BCACHE_DEBUG
diff --git a/include/linux/blkdev.h b/include/linux/blkdev.h
index 32868fbedc9e..934f31fc15cd 100644
--- a/include/linux/blkdev.h
+++ b/include/linux/blkdev.h
@@ -904,11 +904,12 @@ static inline struct request_queue *bdev_get_queue(struct block_device *bdev)
  * multiple of 512 bytes. Hence these two constants.
  */
 #ifndef SECTOR_SHIFT
-#define SECTOR_SHIFT 9
+#define SECTOR_SHIFT		9
 #endif
 #ifndef SECTOR_SIZE
-#define SECTOR_SIZE (1 << SECTOR_SHIFT)
+#define SECTOR_SIZE		(1 << SECTOR_SHIFT)
 #endif
+#define PAGE_SECTORS		(PAGE_SIZE / SECTOR_SIZE)
 
 /*
  * blk_rq_pos()			: the current sector
diff --git a/include/linux/device-mapper.h b/include/linux/device-mapper.h
index af48d9da3916..83e018ed8c21 100644
--- a/include/linux/device-mapper.h
+++ b/include/linux/device-mapper.h
@@ -143,7 +143,6 @@ typedef size_t (*dm_dax_copy_iter_fn)(struct dm_target *ti, pgoff_t pgoff,
 		void *addr, size_t bytes, struct iov_iter *i);
 typedef int (*dm_dax_zero_page_range_fn)(struct dm_target *ti, pgoff_t pgoff,
 		size_t nr_pages);
-#define PAGE_SECTORS (PAGE_SIZE / 512)
 
 void dm_error(const char *message);
 
-- 
2.26.0.106.g9fadedd


