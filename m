Return-Path: <SRS0=qX1g=65=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 585EEC433DF
	for <linux-block@archiver.kernel.org>; Fri, 15 May 2020 02:05:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 401AE20671
	for <linux-block@archiver.kernel.org>; Fri, 15 May 2020 02:05:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726907AbgEOCFK (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 14 May 2020 22:05:10 -0400
Received: from szxga04-in.huawei.com ([45.249.212.190]:4843 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726100AbgEOCFK (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Thu, 14 May 2020 22:05:10 -0400
Received: from DGGEMS411-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id 88013B5C8678E9F93395;
        Fri, 15 May 2020 10:05:05 +0800 (CST)
Received: from [127.0.0.1] (10.166.215.55) by DGGEMS411-HUB.china.huawei.com
 (10.3.19.211) with Microsoft SMTP Server id 14.3.487.0; Fri, 15 May 2020
 10:05:04 +0800
Subject: Re: [PATCH v2 00/10] clean up SECTOR related macros and sectors/pages
 conversions
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
References: <20200507075100.1779-1-thunder.leizhen@huawei.com>
From:   "Leizhen (ThunderTown)" <thunder.leizhen@huawei.com>
Message-ID: <34fa4c00-9860-ca09-da4d-c5b20aad81b7@huawei.com>
Date:   Fri, 15 May 2020 10:05:02 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <20200507075100.1779-1-thunder.leizhen@huawei.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.166.215.55]
X-CFilter-Loop: Reflected
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Hi, all:
   It seems no one take care about these patches. But I think patch 1 is need. And
the main discussion points of others is whether we should add
sectors_to_npage()/npage_to_sectors() or keep PAGE_SECTORS_SHIFT. And which marco
name do we prefer: PAGE_SECTORS vs SECTORS_PER_PAGE, PAGE_SECTORS_SHIFT vs
SECTORS_PER_PAGE_SHIFT.

Hi, Jens Axboe, Coly Li, Kent Overstreet,Alasdair Kergon. Mike Snitzer:
   Can you take a look at patch 1?

On 2020/5/7 15:50, Zhen Lei wrote:
> v1 --> v2:
> As Matthew Wilcox's suggestion, add sectors_to_npage()/npage_to_sectors()
> helpers to eliminate SECTORS_PER_PAGE_SHIFT, because it's quite hard to read.
> In further, I also eliminated PAGE_SECTORS_SHIFT.
> 
> I tried to eliminate all magic number "9" and "512", but it's too many, maybe
> no one want to review it, so I gave up. In the process of searching, I found
> the existing macro PAGE_SECTORS, it's equivalent to SECTORS_PER_PAGE. Because
> PAGE_SECTORS was defined in include/linux/device-mapper.h, and SECTORS_PER_PAGE
> was defined in drivers/block/zram/zram_drv.h, so I discarded SECTORS_PER_PAGE,
> althrough I prefer it so much.
> 
> v1:
> When I studied the code of mm/swap, I found "1 << (PAGE_SHIFT - 9)" appears
> many times. So I try to clean up it.
> 
> 1. Replace "1 << (PAGE_SHIFT - 9)" or similar with SECTORS_PER_PAGE
> 2. Replace "PAGE_SHIFT - 9" with SECTORS_PER_PAGE_SHIFT
> 3. Replace "9" with SECTOR_SHIFT
> 4. Replace "512" with SECTOR_SIZE
> 
> Zhen Lei (10):
>   block: move PAGE_SECTORS definition into <linux/blkdev.h>
>   zram: abolish macro SECTORS_PER_PAGE
>   block: add sectors_to_npage()/npage_to_sectors() helpers
>   zram: abolish macro SECTORS_PER_PAGE_SHIFT
>   block: abolish macro PAGE_SECTORS_SHIFT
>   mm/swap: use npage_to_sectors() and PAGE_SECTORS to clean up code
>   block: use sectors_to_npage() and PAGE_SECTORS to clean up code
>   md: use sectors_to_npage() and npage_to_sectors() to clean up code
>   md: use existing definition RESYNC_SECTORS
>   md: use PAGE_SECTORS to clean up code
> 
>  block/blk-settings.c          |  6 +++---
>  block/partitions/core.c       |  5 ++---
>  drivers/block/brd.c           |  7 ++-----
>  drivers/block/null_blk_main.c | 10 ++++------
>  drivers/block/zram/zram_drv.c |  8 ++++----
>  drivers/block/zram/zram_drv.h |  2 --
>  drivers/md/bcache/util.h      |  2 --
>  drivers/md/dm-kcopyd.c        |  2 +-
>  drivers/md/dm-table.c         |  2 +-
>  drivers/md/md-bitmap.c        | 16 ++++++++--------
>  drivers/md/md.c               |  6 +++---
>  drivers/md/raid1.c            | 10 +++++-----
>  drivers/md/raid10.c           | 28 ++++++++++++++--------------
>  drivers/md/raid5-cache.c      | 11 +++++------
>  drivers/md/raid5.c            |  4 ++--
>  include/linux/blkdev.h        |  7 +++++--
>  include/linux/device-mapper.h |  1 -
>  mm/page_io.c                  |  4 ++--
>  mm/swapfile.c                 | 12 ++++++------
>  19 files changed, 67 insertions(+), 76 deletions(-)
> 

