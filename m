Return-Path: <SRS0=Cb6v=6V=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EE434C47257
	for <linux-block@archiver.kernel.org>; Thu,  7 May 2020 07:56:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CE8382083B
	for <linux-block@archiver.kernel.org>; Thu,  7 May 2020 07:56:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726641AbgEGH4B (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 7 May 2020 03:56:01 -0400
Received: from szxga06-in.huawei.com ([45.249.212.32]:52778 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726555AbgEGH4A (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Thu, 7 May 2020 03:56:00 -0400
Received: from DGGEMS406-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id 9EE03EA0C306B46DD563;
        Thu,  7 May 2020 15:55:58 +0800 (CST)
Received: from DESKTOP-C3MD9UG.china.huawei.com (10.166.215.55) by
 DGGEMS406-HUB.china.huawei.com (10.3.19.206) with Microsoft SMTP Server id
 14.3.487.0; Thu, 7 May 2020 15:55:50 +0800
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
Subject: [PATCH v2 07/10] block: use sectors_to_npage() and PAGE_SECTORS to clean up code
Date:   Thu, 7 May 2020 15:50:57 +0800
Message-ID: <20200507075100.1779-8-thunder.leizhen@huawei.com>
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

1. Replace "1 << (PAGE_SHIFT - 9)" with PAGE_SECTORS
2. Replace ">> (PAGE_SHIFT - 9)" with sectors_to_npage()

Suggested-by: Matthew Wilcox <willy@infradead.org>
Signed-off-by: Zhen Lei <thunder.leizhen@huawei.com>
---
 block/blk-settings.c    | 6 +++---
 block/partitions/core.c | 5 ++---
 2 files changed, 5 insertions(+), 6 deletions(-)

diff --git a/block/blk-settings.c b/block/blk-settings.c
index 14397b4c4b53..171665ed8318 100644
--- a/block/blk-settings.c
+++ b/block/blk-settings.c
@@ -150,7 +150,7 @@ void blk_queue_max_hw_sectors(struct request_queue *q, unsigned int max_hw_secto
 	unsigned int max_sectors;
 
 	if ((max_hw_sectors << 9) < PAGE_SIZE) {
-		max_hw_sectors = 1 << (PAGE_SHIFT - 9);
+		max_hw_sectors = PAGE_SECTORS;
 		printk(KERN_INFO "%s: set to minimum %d\n",
 		       __func__, max_hw_sectors);
 	}
@@ -159,7 +159,7 @@ void blk_queue_max_hw_sectors(struct request_queue *q, unsigned int max_hw_secto
 	max_sectors = min_not_zero(max_hw_sectors, limits->max_dev_sectors);
 	max_sectors = min_t(unsigned int, max_sectors, BLK_DEF_MAX_SECTORS);
 	limits->max_sectors = max_sectors;
-	q->backing_dev_info->io_pages = max_sectors >> (PAGE_SHIFT - 9);
+	q->backing_dev_info->io_pages = sectors_to_npage(max_sectors);
 }
 EXPORT_SYMBOL(blk_queue_max_hw_sectors);
 
@@ -630,7 +630,7 @@ void disk_stack_limits(struct gendisk *disk, struct block_device *bdev,
 	}
 
 	t->backing_dev_info->io_pages =
-		t->limits.max_sectors >> (PAGE_SHIFT - 9);
+		sectors_to_npage(t->limits.max_sectors);
 }
 EXPORT_SYMBOL(disk_stack_limits);
 
diff --git a/block/partitions/core.c b/block/partitions/core.c
index 9ef48a8cff86..4859739a2414 100644
--- a/block/partitions/core.c
+++ b/block/partitions/core.c
@@ -640,8 +640,7 @@ void *read_part_sector(struct parsed_partitions *state, sector_t n, Sector *p)
 		return NULL;
 	}
 
-	page = read_mapping_page(mapping,
-			(pgoff_t)(n >> (PAGE_SHIFT - 9)), NULL);
+	page = read_mapping_page(mapping, (pgoff_t)sectors_to_npage(n), NULL);
 	if (IS_ERR(page))
 		goto out;
 	if (PageError(page))
@@ -649,7 +648,7 @@ void *read_part_sector(struct parsed_partitions *state, sector_t n, Sector *p)
 
 	p->v = page;
 	return (unsigned char *)page_address(page) +
-			((n & ((1 << (PAGE_SHIFT - 9)) - 1)) << SECTOR_SHIFT);
+			((n & (PAGE_SECTORS - 1)) << SECTOR_SHIFT);
 out_put_page:
 	put_page(page);
 out:
-- 
2.26.0.106.g9fadedd


