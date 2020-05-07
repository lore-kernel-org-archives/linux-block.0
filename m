Return-Path: <SRS0=Cb6v=6V=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 40521C47247
	for <linux-block@archiver.kernel.org>; Thu,  7 May 2020 07:56:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1CA882083B
	for <linux-block@archiver.kernel.org>; Thu,  7 May 2020 07:56:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726951AbgEGH4b (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 7 May 2020 03:56:31 -0400
Received: from szxga06-in.huawei.com ([45.249.212.32]:52792 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726610AbgEGH4B (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Thu, 7 May 2020 03:56:01 -0400
Received: from DGGEMS406-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id A7051CED3291C742681E;
        Thu,  7 May 2020 15:55:58 +0800 (CST)
Received: from DESKTOP-C3MD9UG.china.huawei.com (10.166.215.55) by
 DGGEMS406-HUB.china.huawei.com (10.3.19.206) with Microsoft SMTP Server id
 14.3.487.0; Thu, 7 May 2020 15:55:48 +0800
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
Subject: [PATCH v2 05/10] block: abolish macro PAGE_SECTORS_SHIFT
Date:   Thu, 7 May 2020 15:50:55 +0800
Message-ID: <20200507075100.1779-6-thunder.leizhen@huawei.com>
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

The name of PAGE_SECTORS_SHIFT is quite hard to read.
1. use sectors_to_npage() to replace ">> PAGE_SECTORS_SHIFT"
2. use npage_to_sectors() to replace "<< PAGE_SECTORS_SHIFT"

Suggested-by: Matthew Wilcox <willy@infradead.org>
Signed-off-by: Zhen Lei <thunder.leizhen@huawei.com>
---
 drivers/block/brd.c           | 6 ++----
 drivers/block/null_blk_main.c | 9 ++++-----
 2 files changed, 6 insertions(+), 9 deletions(-)

diff --git a/drivers/block/brd.c b/drivers/block/brd.c
index 30df6daa9dbc..051c5a50497f 100644
--- a/drivers/block/brd.c
+++ b/drivers/block/brd.c
@@ -25,8 +25,6 @@
 
 #include <linux/uaccess.h>
 
-#define PAGE_SECTORS_SHIFT	(PAGE_SHIFT - SECTOR_SHIFT)
-
 /*
  * Each block ramdisk device has a radix_tree brd_pages of pages that stores
  * the pages containing the block device's contents. A brd page's ->index is
@@ -69,7 +67,7 @@ static struct page *brd_lookup_page(struct brd_device *brd, sector_t sector)
 	 * here, only deletes).
 	 */
 	rcu_read_lock();
-	idx = sector >> PAGE_SECTORS_SHIFT; /* sector to page index */
+	idx = sectors_to_npage(sector);
 	page = radix_tree_lookup(&brd->brd_pages, idx);
 	rcu_read_unlock();
 
@@ -108,7 +106,7 @@ static struct page *brd_insert_page(struct brd_device *brd, sector_t sector)
 	}
 
 	spin_lock(&brd->brd_lock);
-	idx = sector >> PAGE_SECTORS_SHIFT;
+	idx = sectors_to_npage(sector);
 	page->index = idx;
 	if (radix_tree_insert(&brd->brd_pages, idx, page)) {
 		__free_page(page);
diff --git a/drivers/block/null_blk_main.c b/drivers/block/null_blk_main.c
index 25048ff15858..81485f47dcf0 100644
--- a/drivers/block/null_blk_main.c
+++ b/drivers/block/null_blk_main.c
@@ -11,7 +11,6 @@
 #include <linux/init.h>
 #include "null_blk.h"
 
-#define PAGE_SECTORS_SHIFT	(PAGE_SHIFT - SECTOR_SHIFT)
 #define SECTOR_MASK		(PAGE_SECTORS - 1)
 
 #define FREE_BATCH		16
@@ -737,7 +736,7 @@ static void null_free_sector(struct nullb *nullb, sector_t sector,
 	struct radix_tree_root *root;
 
 	root = is_cache ? &nullb->dev->cache : &nullb->dev->data;
-	idx = sector >> PAGE_SECTORS_SHIFT;
+	idx = sectors_to_npage(sector);
 	sector_bit = (sector & SECTOR_MASK);
 
 	t_page = radix_tree_lookup(root, idx);
@@ -808,7 +807,7 @@ static struct nullb_page *__null_lookup_page(struct nullb *nullb,
 	struct nullb_page *t_page;
 	struct radix_tree_root *root;
 
-	idx = sector >> PAGE_SECTORS_SHIFT;
+	idx = sectors_to_npage(sector);
 	sector_bit = (sector & SECTOR_MASK);
 
 	root = is_cache ? &nullb->dev->cache : &nullb->dev->data;
@@ -855,7 +854,7 @@ static struct nullb_page *null_insert_page(struct nullb *nullb,
 		goto out_freepage;
 
 	spin_lock_irq(&nullb->lock);
-	idx = sector >> PAGE_SECTORS_SHIFT;
+	idx = sectors_to_npage(sector);
 	t_page->page->index = idx;
 	t_page = null_radix_tree_insert(nullb, idx, t_page, !ignore_cache);
 	radix_tree_preload_end();
@@ -878,7 +877,7 @@ static int null_flush_cache_page(struct nullb *nullb, struct nullb_page *c_page)
 
 	idx = c_page->page->index;
 
-	t_page = null_insert_page(nullb, idx << PAGE_SECTORS_SHIFT, true);
+	t_page = null_insert_page(nullb, npage_to_sectors(idx), true);
 
 	__clear_bit(NULLB_PAGE_LOCK, c_page->bitmap);
 	if (test_bit(NULLB_PAGE_FREE, c_page->bitmap)) {
-- 
2.26.0.106.g9fadedd


