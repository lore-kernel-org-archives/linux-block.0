Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3668EC433EF
	for <linux-block@archiver.kernel.org>; Thu, 13 Jan 2022 05:47:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229798AbiAMFrp (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 13 Jan 2022 00:47:45 -0500
Received: from mga17.intel.com ([192.55.52.151]:19865 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229764AbiAMFrp (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Thu, 13 Jan 2022 00:47:45 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1642052864; x=1673588864;
  h=from:to:cc:subject:references:date:in-reply-to:
   message-id:mime-version;
  bh=AzTsk6++VNpW9AnxKpfUAG5E06dkEV0XznLYERQRvQs=;
  b=BdtwXPMKyUxddcBY3nDUuGcdRulWhQRS7Rtrr5iTfzrfRzttk8H8dX7o
   1zSC5XQzKquLS4+vtcDV4u36pWTpY4K6bzeB8RVxP5ugys/z9GkQFGZhr
   thP9XGCu6r9174wRi//uJuEBxT2s9YIcHuvFeb6c5D7po8i3v4OjUaDIl
   DORpnO3+0GOw2SsBCtlmBRA9gcz9Sf0BykCkiDMxh8xhAosEEiF5hf22H
   uv2C9DfxK/D3seTaKPEEhlVA9fyArK5J66x+5j0xrhpUvOuBNCZvCXtcx
   qx7nJoXYNkCTjrWfe7p12rnsZtenSZYycJ9xjawoz0d/2g8oIWO/T5WLN
   w==;
X-IronPort-AV: E=McAfee;i="6200,9189,10225"; a="224628449"
X-IronPort-AV: E=Sophos;i="5.88,284,1635231600"; 
   d="scan'208";a="224628449"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Jan 2022 21:47:44 -0800
X-IronPort-AV: E=Sophos;i="5.88,284,1635231600"; 
   d="scan'208";a="529527197"
Received: from yhuang6-desk2.sh.intel.com (HELO yhuang6-desk2.ccr.corp.intel.com) ([10.239.13.11])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Jan 2022 21:47:42 -0800
From:   "Huang, Ying" <ying.huang@intel.com>
To:     Minchan Kim <minchan@kernel.org>
Cc:     Yu Zhao <yuzhao@google.com>,
        Mauricio Faria de Oliveira <mfo@canonical.com>,
        Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        linux-block@vger.kernel.org, Miaohe Lin <linmiaohe@huawei.com>,
        Yang Shi <shy828301@gmail.com>
Subject: Re: [PATCH v2] mm: fix race between MADV_FREE reclaim and blkdev
 direct IO read
References: <20220105233440.63361-1-mfo@canonical.com>
        <Yd0oLWtVAyAexyQc@google.com>
        <87v8ypybdc.fsf@yhuang6-desk2.ccr.corp.intel.com>
        <Yd8Q7Cplp5xLTYlV@google.com>
Date:   Thu, 13 Jan 2022 13:47:40 +0800
In-Reply-To: <Yd8Q7Cplp5xLTYlV@google.com> (Minchan Kim's message of "Wed, 12
        Jan 2022 09:33:32 -0800")
Message-ID: <87zgo0uqyr.fsf@yhuang6-desk2.ccr.corp.intel.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=ascii
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Minchan Kim <minchan@kernel.org> writes:

> On Wed, Jan 12, 2022 at 09:46:23AM +0800, Huang, Ying wrote:
>> Yu Zhao <yuzhao@google.com> writes:
>> 
>> > On Wed, Jan 05, 2022 at 08:34:40PM -0300, Mauricio Faria de Oliveira wrote:
>> >> diff --git a/mm/rmap.c b/mm/rmap.c
>> >> index 163ac4e6bcee..8671de473c25 100644
>> >> --- a/mm/rmap.c
>> >> +++ b/mm/rmap.c
>> >> @@ -1570,7 +1570,20 @@ static bool try_to_unmap_one(struct page *page, struct vm_area_struct *vma,
>> >>  
>> >>  			/* MADV_FREE page check */
>> >>  			if (!PageSwapBacked(page)) {
>> >> -				if (!PageDirty(page)) {
>> >> +				int ref_count = page_ref_count(page);
>> >> +				int map_count = page_mapcount(page);
>> >> +
>> >> +				/*
>> >> +				 * The only page refs must be from the isolation
>> >> +				 * (checked by the caller shrink_page_list() too)
>> >> +				 * and one or more rmap's (dropped by discard:).
>> >> +				 *
>> >> +				 * Check the reference count before dirty flag
>> >> +				 * with memory barrier; see __remove_mapping().
>> >> +				 */
>> >> +				smp_rmb();
>> >> +				if ((ref_count - 1 == map_count) &&
>> >> +				    !PageDirty(page)) {
>> >>  					/* Invalidate as we cleared the pte */
>> >>  					mmu_notifier_invalidate_range(mm,
>> >>  						address, address + PAGE_SIZE);
>> >
>> > Out of curiosity, how does it work with COW in terms of reordering?
>> > Specifically, it seems to me get_page() and page_dup_rmap() in
>> > copy_present_pte() can happen in any order, and if page_dup_rmap()
>> > is seen first, and direct io is holding a refcnt, this check can still
>> > pass?
>> 
>> I think that you are correct.
>> 
>> After more thoughts, it appears very tricky to compare page count and
>> map count.  Even if we have added smp_rmb() between page_ref_count() and
>> page_mapcount(), an interrupt may happen between them.  During the
>> interrupt, the page count and map count may be changed, for example,
>> unmapped, or do_swap_page().
>
> Yeah, it happens but what specific problem are you concerning from the
> count change under race? The fork case Yu pointed out was already known
> for breaking DIO so user should take care not to fork under DIO(Please
> look at O_DIRECT section in man 2 open). If you could give a specific
> example, it would be great to think over the issue.

Whether is the following race possible?

CPU0/Process A                  CPU1/Process B
--------------                  --------------
try_to_unmap_one
  page_mapcount()
                                zap_pte_range()
                                  page_remove_rmap()
                                    atomic_add_negative(-1, &page->_mapcount)
                                  tlb_flush_mmu()
                                    ...
                                      put_page_testzero()
  page_count()

Previously I thought that there's similar race in do_swap_page().  But
after more thoughts, I found that the page is locked in do_swap_page().
So do_swap_page() is safe.  Per my understanding, except during fork()
as Yu pointed out, the anonymous page must be locked before increasing
its mapcount.

So, if the above race is possible, we need to guarantee to read
page_count() before page_mapcount().  That is, something as follows,

        count = page_count();
        smp_rmb();
        mapcount = page_mapcount();
        if (!PageDirty(page) && mapcount + 1 == count) {
                ...
        }

Best Regards,
Huang, Ying

> I agree it's little tricky but it seems to be way other place has used
> for a long time(Please look at write_protect_page in ksm.c).
> So, here what we missing is tlb flush before the checking.
>
> Something like this.
>
> diff --git a/mm/rmap.c b/mm/rmap.c
> index b0fd9dc19eba..b4ad9faa17b2 100644
> --- a/mm/rmap.c
> +++ b/mm/rmap.c
> @@ -1599,18 +1599,8 @@ static bool try_to_unmap_one(struct page *page, struct vm_area_struct *vma,
>
>                         /* MADV_FREE page check */
>                         if (!PageSwapBacked(page)) {
> -                               int refcount = page_ref_count(page);
> -
> -                               /*
> -                                * The only page refs must be from the isolation
> -                                * (checked by the caller shrink_page_list() too)
> -                                * and the (single) rmap (dropped by discard:).
> -                                *
> -                                * Check the reference count before dirty flag
> -                                * with memory barrier; see __remove_mapping().
> -                                */
> -                               smp_rmb();
> -                               if (refcount == 2 && !PageDirty(page)) {
> +                               if (!PageDirty(page) &&
> +                                       page_mapcount(page) + 1 == page_count(page)) {
>                                         /* Invalidate as we cleared the pte */
>                                         mmu_notifier_invalidate_range(mm,
>                                                 address, address + PAGE_SIZE);
> diff --git a/mm/vmscan.c b/mm/vmscan.c
> index f3162a5724de..6454ff5c576f 100644
> --- a/mm/vmscan.c
> +++ b/mm/vmscan.c
> @@ -1754,6 +1754,9 @@ static unsigned int shrink_page_list(struct list_head *page_list,
>                         enum ttu_flags flags = TTU_BATCH_FLUSH;
>                         bool was_swapbacked = PageSwapBacked(page);
>
> +                       if (!was_swapbacked && PageAnon(page))
> +                               flags &= ~TTU_BATCH_FLUSH;
> +
>                         if (unlikely(PageTransHuge(page)))
>                                 flags |= TTU_SPLIT_HUGE_PMD;
