Return-Path: <SRS0=vpK8=6T=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DC8C1C47258
	for <linux-block@archiver.kernel.org>; Tue,  5 May 2020 11:56:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BFC4B206A5
	for <linux-block@archiver.kernel.org>; Tue,  5 May 2020 11:56:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728849AbgEEL4J (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 5 May 2020 07:56:09 -0400
Received: from szxga05-in.huawei.com ([45.249.212.191]:3803 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728804AbgEEL4I (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Tue, 5 May 2020 07:56:08 -0400
Received: from DGGEMS414-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id D52B2ECE72F96FF1ABBA;
        Tue,  5 May 2020 19:56:03 +0800 (CST)
Received: from DESKTOP-C3MD9UG.china.huawei.com (10.166.215.55) by
 DGGEMS414-HUB.china.huawei.com (10.3.19.214) with Microsoft SMTP Server id
 14.3.487.0; Tue, 5 May 2020 19:55:54 +0800
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
Subject: [PATCH 0/4] eliminate SECTOR related magic numbers and duplicated conversions
Date:   Tue, 5 May 2020 19:55:39 +0800
Message-ID: <20200505115543.1660-1-thunder.leizhen@huawei.com>
X-Mailer: git-send-email 2.26.0.windows.1
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.166.215.55]
X-CFilter-Loop: Reflected
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

When I studied the code of mm/swap, I found "1 << (PAGE_SHIFT - 9)" appears
many times. So I try to clean up it.

1. Replace "1 << (PAGE_SHIFT - 9)" or similar with SECTORS_PER_PAGE
2. Replace "PAGE_SHIFT - 9" with SECTORS_PER_PAGE_SHIFT
3. Replace "9" with SECTOR_SHIFT
4. Replace "512" with SECTOR_SIZE

No functional change.

Zhen Lei (4):
  block: Move SECTORS_PER_PAGE and SECTORS_PER_PAGE_SHIFT definitions
    into <linux/blkdev.h>
  mm/swap: use SECTORS_PER_PAGE_SHIFT to clean up code
  block: use SECTORS_PER_PAGE_SHIFT and SECTORS_PER_PAGE to clean up
    code
  mtd: eliminate SECTOR related magic numbers

 block/blk-settings.c          |  8 ++++----
 block/partitions/core.c       |  4 ++--
 drivers/block/zram/zram_drv.h |  2 --
 drivers/md/dm-table.c         |  2 +-
 drivers/md/raid1.c            |  4 ++--
 drivers/md/raid10.c           | 10 +++++-----
 drivers/md/raid5-cache.c      | 10 +++++-----
 include/linux/blkdev.h        | 10 ++++++++--
 mm/page_io.c                  |  4 ++--
 mm/swapfile.c                 | 12 ++++++------
 10 files changed, 35 insertions(+), 31 deletions(-)

-- 
2.26.0.106.g9fadedd


