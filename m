Return-Path: <SRS0=ToMJ=6U=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5A885C47254
	for <linux-block@archiver.kernel.org>; Wed,  6 May 2020 01:33:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 44AD120752
	for <linux-block@archiver.kernel.org>; Wed,  6 May 2020 01:33:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728609AbgEFBd6 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 5 May 2020 21:33:58 -0400
Received: from szxga04-in.huawei.com ([45.249.212.190]:3849 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727989AbgEFBd6 (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Tue, 5 May 2020 21:33:58 -0400
Received: from DGGEMS413-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id 44882CD09A619D1254D8;
        Wed,  6 May 2020 09:33:53 +0800 (CST)
Received: from [127.0.0.1] (10.166.215.55) by DGGEMS413-HUB.china.huawei.com
 (10.3.19.213) with Microsoft SMTP Server id 14.3.487.0; Wed, 6 May 2020
 09:33:52 +0800
Subject: Re: [PATCH 2/4] mm/swap: use SECTORS_PER_PAGE_SHIFT to clean up code
To:     Matthew Wilcox <willy@infradead.org>
CC:     Minchan Kim <minchan@kernel.org>, Nitin Gupta <ngupta@vflare.org>,
        "Sergey Senozhatsky" <sergey.senozhatsky.work@gmail.com>,
        Jens Axboe <axboe@kernel.dk>,
        linux-block <linux-block@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-mm <linux-mm@kvack.org>, Alasdair Kergon <agk@redhat.com>,
        Mike Snitzer <snitzer@redhat.com>,
        dm-devel <dm-devel@redhat.com>, Song Liu <song@kernel.org>,
        linux-raid <linux-raid@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
References: <20200505115543.1660-1-thunder.leizhen@huawei.com>
 <20200505115543.1660-3-thunder.leizhen@huawei.com>
 <20200505172520.GI16070@bombadil.infradead.org>
From:   "Leizhen (ThunderTown)" <thunder.leizhen@huawei.com>
Message-ID: <32ba9907-60ad-27c0-c565-e7b5c80ab03c@huawei.com>
Date:   Wed, 6 May 2020 09:33:50 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <20200505172520.GI16070@bombadil.infradead.org>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.166.215.55]
X-CFilter-Loop: Reflected
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org



On 2020/5/6 1:25, Matthew Wilcox wrote:
> On Tue, May 05, 2020 at 07:55:41PM +0800, Zhen Lei wrote:
>> +++ b/mm/swapfile.c
>> @@ -177,8 +177,8 @@ static int discard_swap(struct swap_info_struct *si)
>>  
>>  	/* Do not discard the swap header page! */
>>  	se = first_se(si);
>> -	start_block = (se->start_block + 1) << (PAGE_SHIFT - 9);
>> -	nr_blocks = ((sector_t)se->nr_pages - 1) << (PAGE_SHIFT - 9);
>> +	start_block = (se->start_block + 1) << SECTORS_PER_PAGE_SHIFT;
>> +	nr_blocks = ((sector_t)se->nr_pages - 1) << SECTORS_PER_PAGE_SHIFT;
> 
> Thinking about this some more, wouldn't this look better?
> 
> 	start_block = page_sectors(se->start_block + 1);
> 	nr_block = page_sectors(se->nr_pages - 1);
> 

OK，That's fine, it's clearer. And in this way, there won't be more than 80 columns.

> 
> .
> 

