Return-Path: <SRS0=vpK8=6T=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 237A2C4725A
	for <linux-block@archiver.kernel.org>; Tue,  5 May 2020 11:56:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0CF8E206B8
	for <linux-block@archiver.kernel.org>; Tue,  5 May 2020 11:56:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728898AbgEEL4T (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 5 May 2020 07:56:19 -0400
Received: from szxga05-in.huawei.com ([45.249.212.191]:3801 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728351AbgEEL4H (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Tue, 5 May 2020 07:56:07 -0400
Received: from DGGEMS414-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id C87C3311B16D4642CC9A;
        Tue,  5 May 2020 19:56:03 +0800 (CST)
Received: from DESKTOP-C3MD9UG.china.huawei.com (10.166.215.55) by
 DGGEMS414-HUB.china.huawei.com (10.3.19.214) with Microsoft SMTP Server id
 14.3.487.0; Tue, 5 May 2020 19:55:57 +0800
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
Subject: [PATCH 3/4] block: use SECTORS_PER_PAGE_SHIFT and SECTORS_PER_PAGE to clean up code
Date:   Tue, 5 May 2020 19:55:42 +0800
Message-ID: <20200505115543.1660-4-thunder.leizhen@huawei.com>
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

1. Replace "1 << (PAGE_SHIFT - 9)" with SECTORS_PER_PAGE
2. Replace "PAGE_SHIFT - 9" with SECTORS_PER_PAGE_SHIFT
3. Replace "9" with SECTOR_SHIFT

Signed-off-by: Zhen Lei <thunder.leizhen@huawei.com>
---
 block/blk-settings.c    | 8 ++++----
 block/partitions/core.c | 4 ++--
 2 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/block/blk-settings.c b/block/blk-settings.c
index 14397b4c4b53..a62037a7ff0f 100644
--- a/block/blk-settings.c
+++ b/block/blk-settings.c
@@ -149,8 +149,8 @@ void blk_queue_max_hw_sectors(struct request_queue *q, unsigned int max_hw_secto
 	struct queue_limits *limits = &q->limits;
 	unsigned int max_sectors;
 
-	if ((max_hw_sectors << 9) < PAGE_SIZE) {
-		max_hw_sectors = 1 << (PAGE_SHIFT - 9);
+	if ((max_hw_sectors << SECTOR_SHIFT) < PAGE_SIZE) {
+		max_hw_sectors = SECTORS_PER_PAGE;
 		printk(KERN_INFO "%s: set to minimum %d\n",
 		       __func__, max_hw_sectors);
 	}
@@ -159,7 +159,7 @@ void blk_queue_max_hw_sectors(struct request_queue *q, unsigned int max_hw_secto
 	max_sectors = min_not_zero(max_hw_sectors, limits->max_dev_sectors);
 	max_sectors = min_t(unsigned int, max_sectors, BLK_DEF_MAX_SECTORS);
 	limits->max_sectors = max_sectors;
-	q->backing_dev_info->io_pages = max_sectors >> (PAGE_SHIFT - 9);
+	q->backing_dev_info->io_pages = max_sectors >> SECTORS_PER_PAGE_SHIFT;
 }
 EXPORT_SYMBOL(blk_queue_max_hw_sectors);
 
@@ -630,7 +630,7 @@ void disk_stack_limits(struct gendisk *disk, struct block_device *bdev,
 	}
 
 	t->backing_dev_info->io_pages =
-		t->limits.max_sectors >> (PAGE_SHIFT - 9);
+		t->limits.max_sectors >> SECTORS_PER_PAGE_SHIFT;
 }
 EXPORT_SYMBOL(disk_stack_limits);
 
diff --git a/block/partitions/core.c b/block/partitions/core.c
index 9ef48a8cff86..6e44ac840ca0 100644
--- a/block/partitions/core.c
+++ b/block/partitions/core.c
@@ -641,7 +641,7 @@ void *read_part_sector(struct parsed_partitions *state, sector_t n, Sector *p)
 	}
 
 	page = read_mapping_page(mapping,
-			(pgoff_t)(n >> (PAGE_SHIFT - 9)), NULL);
+			(pgoff_t)(n >> SECTORS_PER_PAGE_SHIFT), NULL);
 	if (IS_ERR(page))
 		goto out;
 	if (PageError(page))
@@ -649,7 +649,7 @@ void *read_part_sector(struct parsed_partitions *state, sector_t n, Sector *p)
 
 	p->v = page;
 	return (unsigned char *)page_address(page) +
-			((n & ((1 << (PAGE_SHIFT - 9)) - 1)) << SECTOR_SHIFT);
+			((n & (SECTORS_PER_PAGE - 1)) << SECTOR_SHIFT);
 out_put_page:
 	put_page(page);
 out:
-- 
2.26.0.106.g9fadedd


