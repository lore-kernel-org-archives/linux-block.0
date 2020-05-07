Return-Path: <SRS0=Cb6v=6V=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 49D46C47247
	for <linux-block@archiver.kernel.org>; Thu,  7 May 2020 07:56:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 321AF2083B
	for <linux-block@archiver.kernel.org>; Thu,  7 May 2020 07:56:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726467AbgEGHz4 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 7 May 2020 03:55:56 -0400
Received: from szxga06-in.huawei.com ([45.249.212.32]:52492 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725841AbgEGHzz (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Thu, 7 May 2020 03:55:55 -0400
Received: from DGGEMS406-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id 67FFC5C86ABFCE12BA9B;
        Thu,  7 May 2020 15:55:53 +0800 (CST)
Received: from DESKTOP-C3MD9UG.china.huawei.com (10.166.215.55) by
 DGGEMS406-HUB.china.huawei.com (10.3.19.206) with Microsoft SMTP Server id
 14.3.487.0; Thu, 7 May 2020 15:55:44 +0800
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
Subject: [PATCH v2 00/10] clean up SECTOR related macros and sectors/pages conversions
Date:   Thu, 7 May 2020 15:50:50 +0800
Message-ID: <20200507075100.1779-1-thunder.leizhen@huawei.com>
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

v1 --> v2:
As Matthew Wilcox's suggestion, add sectors_to_npage()/npage_to_sectors()
helpers to eliminate SECTORS_PER_PAGE_SHIFT, because it's quite hard to read.
In further, I also eliminated PAGE_SECTORS_SHIFT.

I tried to eliminate all magic number "9" and "512", but it's too many, maybe
no one want to review it, so I gave up. In the process of searching, I found
the existing macro PAGE_SECTORS, it's equivalent to SECTORS_PER_PAGE. Because
PAGE_SECTORS was defined in include/linux/device-mapper.h, and SECTORS_PER_PAGE
was defined in drivers/block/zram/zram_drv.h, so I discarded SECTORS_PER_PAGE,
althrough I prefer it so much.

v1:
When I studied the code of mm/swap, I found "1 << (PAGE_SHIFT - 9)" appears
many times. So I try to clean up it.

1. Replace "1 << (PAGE_SHIFT - 9)" or similar with SECTORS_PER_PAGE
2. Replace "PAGE_SHIFT - 9" with SECTORS_PER_PAGE_SHIFT
3. Replace "9" with SECTOR_SHIFT
4. Replace "512" with SECTOR_SIZE

Zhen Lei (10):
  block: move PAGE_SECTORS definition into <linux/blkdev.h>
  zram: abolish macro SECTORS_PER_PAGE
  block: add sectors_to_npage()/npage_to_sectors() helpers
  zram: abolish macro SECTORS_PER_PAGE_SHIFT
  block: abolish macro PAGE_SECTORS_SHIFT
  mm/swap: use npage_to_sectors() and PAGE_SECTORS to clean up code
  block: use sectors_to_npage() and PAGE_SECTORS to clean up code
  md: use sectors_to_npage() and npage_to_sectors() to clean up code
  md: use existing definition RESYNC_SECTORS
  md: use PAGE_SECTORS to clean up code

 block/blk-settings.c          |  6 +++---
 block/partitions/core.c       |  5 ++---
 drivers/block/brd.c           |  7 ++-----
 drivers/block/null_blk_main.c | 10 ++++------
 drivers/block/zram/zram_drv.c |  8 ++++----
 drivers/block/zram/zram_drv.h |  2 --
 drivers/md/bcache/util.h      |  2 --
 drivers/md/dm-kcopyd.c        |  2 +-
 drivers/md/dm-table.c         |  2 +-
 drivers/md/md-bitmap.c        | 16 ++++++++--------
 drivers/md/md.c               |  6 +++---
 drivers/md/raid1.c            | 10 +++++-----
 drivers/md/raid10.c           | 28 ++++++++++++++--------------
 drivers/md/raid5-cache.c      | 11 +++++------
 drivers/md/raid5.c            |  4 ++--
 include/linux/blkdev.h        |  7 +++++--
 include/linux/device-mapper.h |  1 -
 mm/page_io.c                  |  4 ++--
 mm/swapfile.c                 | 12 ++++++------
 19 files changed, 67 insertions(+), 76 deletions(-)

-- 
2.26.0.106.g9fadedd


