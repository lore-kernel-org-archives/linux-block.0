Return-Path: <SRS0=vpK8=6T=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9D45FC47254
	for <linux-block@archiver.kernel.org>; Tue,  5 May 2020 11:56:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7753B206B8
	for <linux-block@archiver.kernel.org>; Tue,  5 May 2020 11:56:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728713AbgEEL4G (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 5 May 2020 07:56:06 -0400
Received: from szxga05-in.huawei.com ([45.249.212.191]:3802 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728705AbgEEL4G (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Tue, 5 May 2020 07:56:06 -0400
Received: from DGGEMS414-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id CED93E741FB0B5C9C388;
        Tue,  5 May 2020 19:56:03 +0800 (CST)
Received: from DESKTOP-C3MD9UG.china.huawei.com (10.166.215.55) by
 DGGEMS414-HUB.china.huawei.com (10.3.19.214) with Microsoft SMTP Server id
 14.3.487.0; Tue, 5 May 2020 19:55:56 +0800
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
Subject: [PATCH 2/4] mm/swap: use SECTORS_PER_PAGE_SHIFT to clean up code
Date:   Tue, 5 May 2020 19:55:41 +0800
Message-ID: <20200505115543.1660-3-thunder.leizhen@huawei.com>
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

1. Replace "PAGE_SHIFT - 9" with SECTORS_PER_PAGE_SHIFT

Signed-off-by: Zhen Lei <thunder.leizhen@huawei.com>
---
 mm/page_io.c  |  4 ++--
 mm/swapfile.c | 12 ++++++------
 2 files changed, 8 insertions(+), 8 deletions(-)

diff --git a/mm/page_io.c b/mm/page_io.c
index b1d4f4558e6b..51f25238fd9a 100644
--- a/mm/page_io.c
+++ b/mm/page_io.c
@@ -38,7 +38,7 @@ static struct bio *get_swap_bio(gfp_t gfp_flags,
 
 		bio->bi_iter.bi_sector = map_swap_page(page, &bdev);
 		bio_set_dev(bio, bdev);
-		bio->bi_iter.bi_sector <<= PAGE_SHIFT - 9;
+		bio->bi_iter.bi_sector <<= SECTORS_PER_PAGE_SHIFT;
 		bio->bi_end_io = end_io;
 
 		bio_add_page(bio, page, PAGE_SIZE * hpage_nr_pages(page), 0);
@@ -266,7 +266,7 @@ int swap_writepage(struct page *page, struct writeback_control *wbc)
 
 static sector_t swap_page_sector(struct page *page)
 {
-	return (sector_t)__page_file_index(page) << (PAGE_SHIFT - 9);
+	return (sector_t)__page_file_index(page) << SECTORS_PER_PAGE_SHIFT;
 }
 
 static inline void count_swpout_vm_event(struct page *page)
diff --git a/mm/swapfile.c b/mm/swapfile.c
index 5871a2aa86a5..0871023c0166 100644
--- a/mm/swapfile.c
+++ b/mm/swapfile.c
@@ -177,8 +177,8 @@ static int discard_swap(struct swap_info_struct *si)
 
 	/* Do not discard the swap header page! */
 	se = first_se(si);
-	start_block = (se->start_block + 1) << (PAGE_SHIFT - 9);
-	nr_blocks = ((sector_t)se->nr_pages - 1) << (PAGE_SHIFT - 9);
+	start_block = (se->start_block + 1) << SECTORS_PER_PAGE_SHIFT;
+	nr_blocks = ((sector_t)se->nr_pages - 1) << SECTORS_PER_PAGE_SHIFT;
 	if (nr_blocks) {
 		err = blkdev_issue_discard(si->bdev, start_block,
 				nr_blocks, GFP_KERNEL, 0);
@@ -188,8 +188,8 @@ static int discard_swap(struct swap_info_struct *si)
 	}
 
 	for (se = next_se(se); se; se = next_se(se)) {
-		start_block = se->start_block << (PAGE_SHIFT - 9);
-		nr_blocks = (sector_t)se->nr_pages << (PAGE_SHIFT - 9);
+		start_block = se->start_block << SECTORS_PER_PAGE_SHIFT;
+		nr_blocks = (sector_t)se->nr_pages << SECTORS_PER_PAGE_SHIFT;
 
 		err = blkdev_issue_discard(si->bdev, start_block,
 				nr_blocks, GFP_KERNEL, 0);
@@ -240,8 +240,8 @@ static void discard_swap_cluster(struct swap_info_struct *si,
 		start_page += nr_blocks;
 		nr_pages -= nr_blocks;
 
-		start_block <<= PAGE_SHIFT - 9;
-		nr_blocks <<= PAGE_SHIFT - 9;
+		start_block <<= SECTORS_PER_PAGE_SHIFT;
+		nr_blocks <<= SECTORS_PER_PAGE_SHIFT;
 		if (blkdev_issue_discard(si->bdev, start_block,
 					nr_blocks, GFP_NOIO, 0))
 			break;
-- 
2.26.0.106.g9fadedd


