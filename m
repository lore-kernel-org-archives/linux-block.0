Return-Path: <SRS0=qX1g=65=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A7F24C433DF
	for <linux-block@archiver.kernel.org>; Fri, 15 May 2020 06:42:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8160C20760
	for <linux-block@archiver.kernel.org>; Fri, 15 May 2020 06:42:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726646AbgEOGmw (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 15 May 2020 02:42:52 -0400
Received: from szxga07-in.huawei.com ([45.249.212.35]:47166 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726215AbgEOGmv (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Fri, 15 May 2020 02:42:51 -0400
Received: from DGGEMS401-HUB.china.huawei.com (unknown [172.30.72.59])
        by Forcepoint Email with ESMTP id 443D0F559CF58DF50670;
        Fri, 15 May 2020 14:42:48 +0800 (CST)
Received: from [127.0.0.1] (10.166.215.55) by DGGEMS401-HUB.china.huawei.com
 (10.3.19.201) with Microsoft SMTP Server id 14.3.487.0; Fri, 15 May 2020
 14:42:46 +0800
Subject: Re: [PATCH v2 06/10] mm/swap: use npage_to_sectors() and PAGE_SECTORS
 to clean up code
To:     Matthew Wilcox <willy@infradead.org>
CC:     Minchan Kim <minchan@kernel.org>, Nitin Gupta <ngupta@vflare.org>,
        "Sergey Senozhatsky" <sergey.senozhatsky.work@gmail.com>,
        Jens Axboe <axboe@kernel.dk>, Coly Li <colyli@suse.de>,
        Kent Overstreet <kent.overstreet@gmail.com>,
        Alasdair Kergon <agk@redhat.com>,
        Mike Snitzer <snitzer@redhat.com>,
        linux-block <linux-block@vger.kernel.org>,
        "Andrew Morton" <akpm@linux-foundation.org>,
        linux-mm <linux-mm@kvack.org>, dm-devel <dm-devel@redhat.com>,
        Song Liu <song@kernel.org>,
        linux-raid <linux-raid@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
References: <20200507075100.1779-1-thunder.leizhen@huawei.com>
 <20200507075100.1779-7-thunder.leizhen@huawei.com>
 <20200515041456.GD16070@bombadil.infradead.org>
From:   "Leizhen (ThunderTown)" <thunder.leizhen@huawei.com>
Message-ID: <85ea7c5e-9879-8aa4-c0f4-c60f107d63e3@huawei.com>
Date:   Fri, 15 May 2020 14:42:44 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <20200515041456.GD16070@bombadil.infradead.org>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.166.215.55]
X-CFilter-Loop: Reflected
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org



On 2020/5/15 12:14, Matthew Wilcox wrote:
> On Thu, May 07, 2020 at 03:50:56PM +0800, Zhen Lei wrote:
>> +++ b/mm/page_io.c
>> @@ -38,7 +38,7 @@ static struct bio *get_swap_bio(gfp_t gfp_flags,
>>  
>>  		bio->bi_iter.bi_sector = map_swap_page(page, &bdev);
>>  		bio_set_dev(bio, bdev);
>> -		bio->bi_iter.bi_sector <<= PAGE_SHIFT - 9;
>> +		bio->bi_iter.bi_sector *= PAGE_SECTORS;
>>  		bio->bi_end_io = end_io;
> 
> This just doesn't look right.  Why is map_swap_page() returning a sector_t
> which isn't actually a sector_t?

I try to understand map_swap_page(). Here maybe a bug. Otherwise, it would be
better to add a temporary variable to cache the return value of map_swap_page(page, &bdev).

> 
> 
> .
> 

