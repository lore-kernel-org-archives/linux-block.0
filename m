Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C0072C433FE
	for <linux-block@archiver.kernel.org>; Thu, 13 Jan 2022 06:38:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229763AbiAMGh7 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 13 Jan 2022 01:37:59 -0500
Received: from szxga03-in.huawei.com ([45.249.212.189]:31157 "EHLO
        szxga03-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231657AbiAMGh6 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 13 Jan 2022 01:37:58 -0500
Received: from canpemm500002.china.huawei.com (unknown [172.30.72.54])
        by szxga03-in.huawei.com (SkyGuard) with ESMTP id 4JZF6T069Yz8wKH;
        Thu, 13 Jan 2022 14:35:13 +0800 (CST)
Received: from [10.174.177.76] (10.174.177.76) by
 canpemm500002.china.huawei.com (7.192.104.244) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.20; Thu, 13 Jan 2022 14:37:55 +0800
Subject: Re: [PATCH v2] mm: fix race between MADV_FREE reclaim and blkdev
 direct IO read
To:     "Huang, Ying" <ying.huang@intel.com>
CC:     Yu Zhao <yuzhao@google.com>,
        Mauricio Faria de Oliveira <mfo@canonical.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        <linux-mm@kvack.org>, <linux-block@vger.kernel.org>,
        Yang Shi <shy828301@gmail.com>,
        Minchan Kim <minchan@kernel.org>
References: <20220105233440.63361-1-mfo@canonical.com>
 <Yd0oLWtVAyAexyQc@google.com>
 <87v8ypybdc.fsf@yhuang6-desk2.ccr.corp.intel.com>
 <Yd8Q7Cplp5xLTYlV@google.com>
 <87zgo0uqyr.fsf@yhuang6-desk2.ccr.corp.intel.com>
From:   Miaohe Lin <linmiaohe@huawei.com>
Message-ID: <c7c7c839-f8b9-4864-33ea-37b95d935fe8@huawei.com>
Date:   Thu, 13 Jan 2022 14:37:15 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.0
MIME-Version: 1.0
In-Reply-To: <87zgo0uqyr.fsf@yhuang6-desk2.ccr.corp.intel.com>
Content-Type: text/plain; charset="windows-1252"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.174.177.76]
X-ClientProxiedBy: dggems702-chm.china.huawei.com (10.3.19.179) To
 canpemm500002.china.huawei.com (7.192.104.244)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 2022/1/13 13:47, Huang, Ying wrote:
> Minchan Kim <minchan@kernel.org> writes:
> 
>> On Wed, Jan 12, 2022 at 09:46:23AM +0800, Huang, Ying wrote:
>>> Yu Zhao <yuzhao@google.com> writes:
>>>
>>>> On Wed, Jan 05, 2022 at 08:34:40PM -0300, Mauricio Faria de Oliveira wrote:
>>>>> diff --git a/mm/rmap.c b/mm/rmap.c
>>>>> index 163ac4e6bcee..8671de473c25 100644
>>>>> --- a/mm/rmap.c
>>>>> +++ b/mm/rmap.c
>>>>> @@ -1570,7 +1570,20 @@ static bool try_to_unmap_one(struct page *page, struct vm_area_struct *vma,
>>>>>  
>>>>>  			/* MADV_FREE page check */
>>>>>  			if (!PageSwapBacked(page)) {
>>>>> -				if (!PageDirty(page)) {
>>>>> +				int ref_count = page_ref_count(page);
>>>>> +				int map_count = page_mapcount(page);
>>>>> +
>>>>> +				/*
>>>>> +				 * The only page refs must be from the isolation
>>>>> +				 * (checked by the caller shrink_page_list() too)
>>>>> +				 * and one or more rmap's (dropped by discard:).
>>>>> +				 *
>>>>> +				 * Check the reference count before dirty flag
>>>>> +				 * with memory barrier; see __remove_mapping().
>>>>> +				 */
>>>>> +				smp_rmb();
>>>>> +				if ((ref_count - 1 == map_count) &&
>>>>> +				    !PageDirty(page)) {
>>>>>  					/* Invalidate as we cleared the pte */
>>>>>  					mmu_notifier_invalidate_range(mm,
>>>>>  						address, address + PAGE_SIZE);
>>>>
>>>> Out of curiosity, how does it work with COW in terms of reordering?
>>>> Specifically, it seems to me get_page() and page_dup_rmap() in
>>>> copy_present_pte() can happen in any order, and if page_dup_rmap()
>>>> is seen first, and direct io is holding a refcnt, this check can still
>>>> pass?
>>>
>>> I think that you are correct.
>>>
>>> After more thoughts, it appears very tricky to compare page count and
>>> map count.  Even if we have added smp_rmb() between page_ref_count() and
>>> page_mapcount(), an interrupt may happen between them.  During the
>>> interrupt, the page count and map count may be changed, for example,
>>> unmapped, or do_swap_page().
>>
>> Yeah, it happens but what specific problem are you concerning from the
>> count change under race? The fork case Yu pointed out was already known
>> for breaking DIO so user should take care not to fork under DIO(Please
>> look at O_DIRECT section in man 2 open). If you could give a specific
>> example, it would be great to think over the issue.
> 
> Whether is the following race possible?
> 
> CPU0/Process A                  CPU1/Process B
> --------------                  --------------
> try_to_unmap_one
>   page_mapcount()
>                                 zap_pte_range()
>                                   page_remove_rmap()
>                                     atomic_add_negative(-1, &page->_mapcount)
>                                   tlb_flush_mmu()
>                                     ...
>                                       put_page_testzero()
>   page_count()
> 

It seems they're under the same page table Lock.

Thanks.

> Previously I thought that there's similar race in do_swap_page().  But
> after more thoughts, I found that the page is locked in do_swap_page().
> So do_swap_page() is safe.  Per my understanding, except during fork()
> as Yu pointed out, the anonymous page must be locked before increasing
> its mapcount.
> 
> So, if the above race is possible, we need to guarantee to read
> page_count() before page_mapcount().  That is, something as follows,
> 
>         count = page_count();
>         smp_rmb();
>         mapcount = page_mapcount();
>         if (!PageDirty(page) && mapcount + 1 == count) {
>                 ...
>         }
> 
> Best Regards,
> Huang, Ying
> 
>> I agree it's little tricky but it seems to be way other place has used
>> for a long time(Please look at write_protect_page in ksm.c).
>> So, here what we missing is tlb flush before the checking.
>>
>> Something like this.
>>
>> diff --git a/mm/rmap.c b/mm/rmap.c
>> index b0fd9dc19eba..b4ad9faa17b2 100644
>> --- a/mm/rmap.c
>> +++ b/mm/rmap.c
>> @@ -1599,18 +1599,8 @@ static bool try_to_unmap_one(struct page *page, struct vm_area_struct *vma,
>>
>>                         /* MADV_FREE page check */
>>                         if (!PageSwapBacked(page)) {
>> -                               int refcount = page_ref_count(page);
>> -
>> -                               /*
>> -                                * The only page refs must be from the isolation
>> -                                * (checked by the caller shrink_page_list() too)
>> -                                * and the (single) rmap (dropped by discard:).
>> -                                *
>> -                                * Check the reference count before dirty flag
>> -                                * with memory barrier; see __remove_mapping().
>> -                                */
>> -                               smp_rmb();
>> -                               if (refcount == 2 && !PageDirty(page)) {
>> +                               if (!PageDirty(page) &&
>> +                                       page_mapcount(page) + 1 == page_count(page)) {
>>                                         /* Invalidate as we cleared the pte */
>>                                         mmu_notifier_invalidate_range(mm,
>>                                                 address, address + PAGE_SIZE);
>> diff --git a/mm/vmscan.c b/mm/vmscan.c
>> index f3162a5724de..6454ff5c576f 100644
>> --- a/mm/vmscan.c
>> +++ b/mm/vmscan.c
>> @@ -1754,6 +1754,9 @@ static unsigned int shrink_page_list(struct list_head *page_list,
>>                         enum ttu_flags flags = TTU_BATCH_FLUSH;
>>                         bool was_swapbacked = PageSwapBacked(page);
>>
>> +                       if (!was_swapbacked && PageAnon(page))
>> +                               flags &= ~TTU_BATCH_FLUSH;
>> +
>>                         if (unlikely(PageTransHuge(page)))
>>                                 flags |= TTU_SPLIT_HUGE_PMD;
> .
> 

