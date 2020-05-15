Return-Path: <SRS0=qX1g=65=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C892FC433DF
	for <linux-block@archiver.kernel.org>; Fri, 15 May 2020 06:52:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A93C8206F1
	for <linux-block@archiver.kernel.org>; Fri, 15 May 2020 06:52:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726262AbgEOGwi (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 15 May 2020 02:52:38 -0400
Received: from szxga04-in.huawei.com ([45.249.212.190]:4846 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726371AbgEOGwh (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Fri, 15 May 2020 02:52:37 -0400
Received: from DGGEMS402-HUB.china.huawei.com (unknown [172.30.72.59])
        by Forcepoint Email with ESMTP id 3E1FC151D066A462048B;
        Fri, 15 May 2020 14:52:30 +0800 (CST)
Received: from [127.0.0.1] (10.166.215.55) by DGGEMS402-HUB.china.huawei.com
 (10.3.19.202) with Microsoft SMTP Server id 14.3.487.0; Fri, 15 May 2020
 14:52:28 +0800
Subject: Re: [PATCH v2 07/10] block: use sectors_to_npage() and PAGE_SECTORS
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
 <20200507075100.1779-8-thunder.leizhen@huawei.com>
 <20200515041916.GE16070@bombadil.infradead.org>
From:   "Leizhen (ThunderTown)" <thunder.leizhen@huawei.com>
Message-ID: <d3e9bebf-1fea-1497-6dd2-9354f9ca0d4b@huawei.com>
Date:   Fri, 15 May 2020 14:52:26 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <20200515041916.GE16070@bombadil.infradead.org>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.166.215.55]
X-CFilter-Loop: Reflected
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org



On 2020/5/15 12:19, Matthew Wilcox wrote:
> On Thu, May 07, 2020 at 03:50:57PM +0800, Zhen Lei wrote:
>> +++ b/block/blk-settings.c
>> @@ -150,7 +150,7 @@ void blk_queue_max_hw_sectors(struct request_queue *q, unsigned int max_hw_secto
>>  	unsigned int max_sectors;
>>  
>>  	if ((max_hw_sectors << 9) < PAGE_SIZE) {
>> -		max_hw_sectors = 1 << (PAGE_SHIFT - 9);
>> +		max_hw_sectors = PAGE_SECTORS;
> 
> Surely this should be:
> 
> 	if (max_hw_sectors < PAGE_SECTORS) {
> 		max_hw_sectors = PAGE_SECTORS;
> 
> ... no?

I've noticed this place before. "(max_hw_sectors << 9) < PAGE_SIZE" can also make sure
that max_hw_sectors is not too large, that means (max_hw_sectors << 9) may overflow.

> 
>> -	page = read_mapping_page(mapping,
>> -			(pgoff_t)(n >> (PAGE_SHIFT - 9)), NULL);
>> +	page = read_mapping_page(mapping, (pgoff_t)sectors_to_npage(n), NULL);
> 
> ... again, get the type right, and you won't need the cast.
OK, I'll consider it.

> 
> 
> .
> 

