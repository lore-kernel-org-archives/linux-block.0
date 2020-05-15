Return-Path: <SRS0=qX1g=65=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CD0DBC433DF
	for <linux-block@archiver.kernel.org>; Fri, 15 May 2020 06:28:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AE6AF20728
	for <linux-block@archiver.kernel.org>; Fri, 15 May 2020 06:28:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726215AbgEOG27 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 15 May 2020 02:28:59 -0400
Received: from szxga06-in.huawei.com ([45.249.212.32]:38334 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726205AbgEOG26 (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Fri, 15 May 2020 02:28:58 -0400
Received: from DGGEMS410-HUB.china.huawei.com (unknown [172.30.72.59])
        by Forcepoint Email with ESMTP id D74529857C06E2477F6F;
        Fri, 15 May 2020 14:28:56 +0800 (CST)
Received: from [127.0.0.1] (10.166.215.55) by DGGEMS410-HUB.china.huawei.com
 (10.3.19.210) with Microsoft SMTP Server id 14.3.487.0; Fri, 15 May 2020
 14:28:54 +0800
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
 <20200515040647.GC16070@bombadil.infradead.org>
From:   "Leizhen (ThunderTown)" <thunder.leizhen@huawei.com>
Message-ID: <766da107-bc67-ff99-a8c8-87f8f98c7cf6@huawei.com>
Date:   Fri, 15 May 2020 14:28:53 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <20200515040647.GC16070@bombadil.infradead.org>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.166.215.55]
X-CFilter-Loop: Reflected
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org



On 2020/5/15 12:06, Matthew Wilcox wrote:
> On Thu, May 07, 2020 at 03:50:56PM +0800, Zhen Lei wrote:
>> @@ -266,7 +266,7 @@ int swap_writepage(struct page *page, struct writeback_control *wbc)
>>  
>>  static sector_t swap_page_sector(struct page *page)
>>  {
>> -	return (sector_t)__page_file_index(page) << (PAGE_SHIFT - 9);
>> +	return npage_to_sectors((sector_t)__page_file_index(page));
> 
> If you make npage_to_sectors() a proper function instead of a macro,
> you can do the casting inside the function instead of in the callers
> (which is prone to bugs).

Oh, yes. __page_file_index(page) maybe called many times in marco, althouth currently
it is not. So that, not all are suitable for page_to_sector(). And for this example,
still need to use "<< PAGE_SECTORS_SHIFT".

> 
> Also, this is a great example of why page_to_sector() was a better name
> than npage_to_sectors().  This function doesn't return a count of sectors,
> it returns a sector number within the swap device.
OK, so I will change to page_to_sector()/sector_to_page().

> 
> 
> .
> 

