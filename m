Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4C75AC433FE
	for <linux-block@archiver.kernel.org>; Thu, 13 Jan 2022 12:30:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232381AbiAMMa5 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 13 Jan 2022 07:30:57 -0500
Received: from mga05.intel.com ([192.55.52.43]:47336 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232361AbiAMMa5 (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Thu, 13 Jan 2022 07:30:57 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1642077057; x=1673613057;
  h=from:to:cc:subject:references:date:in-reply-to:
   message-id:mime-version;
  bh=DVLyz0gDJyBOax0Gor6irppWaDxw7h7zYzscOlXhtJQ=;
  b=ErYOC4WbW4vunUKv/imWfpu2fRhlGmp/XnQKbUYTS8R98roiC2xXv2Ts
   tAFs/vj/CY7xVsbA7atdnPh+tGp8GCG457qjKfzw1JghgIbl9trt3AxOt
   Q62z7l1pba4lw4z6TjmPqQOdx5mCItqAsW3R0Y5qchH6y92aEEL2/fdnC
   vd2fwepZNxmKoKnti3s4BO3nZksJmatXAnTX3buCCxMxmMbb0tgKjjKXh
   7u6s8v5G8URvuL/JVloXaEnMrxgsSmhtlYCY+Zuz6MFRnIb0zYe1IAJI6
   w712f6lpT9Y4ljRFmvz3/YNTtPnKFpmF/2gt+veBes10OvBACiOp9nhlO
   w==;
X-IronPort-AV: E=McAfee;i="6200,9189,10225"; a="330345764"
X-IronPort-AV: E=Sophos;i="5.88,286,1635231600"; 
   d="scan'208";a="330345764"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Jan 2022 04:30:54 -0800
X-IronPort-AV: E=Sophos;i="5.88,286,1635231600"; 
   d="scan'208";a="473202306"
Received: from yhuang6-desk2.sh.intel.com (HELO yhuang6-desk2.ccr.corp.intel.com) ([10.239.13.11])
  by orsmga003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Jan 2022 04:30:51 -0800
From:   "Huang, Ying" <ying.huang@intel.com>
To:     Minchan Kim <minchan@kernel.org>
Cc:     Mauricio Faria de Oliveira <mfo@canonical.com>,
        Yu Zhao <yuzhao@google.com>,
        Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        linux-block@vger.kernel.org, Miaohe Lin <linmiaohe@huawei.com>,
        Yang Shi <shy828301@gmail.com>
Subject: Re: [PATCH v2] mm: fix race between MADV_FREE reclaim and blkdev
 direct IO read
References: <20220105233440.63361-1-mfo@canonical.com>
        <Yd0oLWtVAyAexyQc@google.com>
        <87v8ypybdc.fsf@yhuang6-desk2.ccr.corp.intel.com>
        <Yd8Q7Cplp5xLTYlV@google.com>
        <CAO9xwp3cgdXRmogRReJW+_AKktWhYL74kzphKpz_8wh12BVzGA@mail.gmail.com>
        <Yd9YIGLWEeYBkTge@google.com>
        <87zgo0t3qz.fsf@yhuang6-desk2.ccr.corp.intel.com>
Date:   Thu, 13 Jan 2022 20:30:49 +0800
In-Reply-To: <87zgo0t3qz.fsf@yhuang6-desk2.ccr.corp.intel.com> (Ying Huang's
        message of "Thu, 13 Jan 2022 16:54:28 +0800")
Message-ID: <87ilunu8au.fsf@yhuang6-desk2.ccr.corp.intel.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=ascii
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

"Huang, Ying" <ying.huang@intel.com> writes:

> Minchan Kim <minchan@kernel.org> writes:
>
>> On Wed, Jan 12, 2022 at 06:53:07PM -0300, Mauricio Faria de Oliveira wrote:
>>> Hi Minchan Kim,
>>> 
>>> Thanks for handling the hard questions! :)
>>> 
>>> On Wed, Jan 12, 2022 at 2:33 PM Minchan Kim <minchan@kernel.org> wrote:
>>> >
>>> > On Wed, Jan 12, 2022 at 09:46:23AM +0800, Huang, Ying wrote:
>>> > > Yu Zhao <yuzhao@google.com> writes:
>>> > >
>>> > > > On Wed, Jan 05, 2022 at 08:34:40PM -0300, Mauricio Faria de Oliveira wrote:
>>> > > >> diff --git a/mm/rmap.c b/mm/rmap.c
>>> > > >> index 163ac4e6bcee..8671de473c25 100644
>>> > > >> --- a/mm/rmap.c
>>> > > >> +++ b/mm/rmap.c
>>> > > >> @@ -1570,7 +1570,20 @@ static bool try_to_unmap_one(struct page *page, struct vm_area_struct *vma,
>>> > > >>
>>> > > >>                    /* MADV_FREE page check */
>>> > > >>                    if (!PageSwapBacked(page)) {
>>> > > >> -                          if (!PageDirty(page)) {
>>> > > >> +                          int ref_count = page_ref_count(page);
>>> > > >> +                          int map_count = page_mapcount(page);
>>> > > >> +
>>> > > >> +                          /*
>>> > > >> +                           * The only page refs must be from the isolation
>>> > > >> +                           * (checked by the caller shrink_page_list() too)
>>> > > >> +                           * and one or more rmap's (dropped by discard:).
>>> > > >> +                           *
>>> > > >> +                           * Check the reference count before dirty flag
>>> > > >> +                           * with memory barrier; see __remove_mapping().
>>> > > >> +                           */
>>> > > >> +                          smp_rmb();
>>> > > >> +                          if ((ref_count - 1 == map_count) &&
>>> > > >> +                              !PageDirty(page)) {
>>> > > >>                                    /* Invalidate as we cleared the pte */
>>> > > >>                                    mmu_notifier_invalidate_range(mm,
>>> > > >>                                            address, address + PAGE_SIZE);
>>> > > >
>>> > > > Out of curiosity, how does it work with COW in terms of reordering?
>>> > > > Specifically, it seems to me get_page() and page_dup_rmap() in
>>> > > > copy_present_pte() can happen in any order, and if page_dup_rmap()
>>> > > > is seen first, and direct io is holding a refcnt, this check can still
>>> > > > pass?
>>> > >
>>> > > I think that you are correct.
>>> > >
>>> > > After more thoughts, it appears very tricky to compare page count and
>>> > > map count.  Even if we have added smp_rmb() between page_ref_count() and
>>> > > page_mapcount(), an interrupt may happen between them.  During the
>>> > > interrupt, the page count and map count may be changed, for example,
>>> > > unmapped, or do_swap_page().
>>> >
>>> > Yeah, it happens but what specific problem are you concerning from the
>>> > count change under race? The fork case Yu pointed out was already known
>>> > for breaking DIO so user should take care not to fork under DIO(Please
>>> > look at O_DIRECT section in man 2 open). If you could give a specific
>>> > example, it would be great to think over the issue.
>>> >
>>> > I agree it's little tricky but it seems to be way other place has used
>>> > for a long time(Please look at write_protect_page in ksm.c).
>>> 
>>> Ah, that's great to see it's being used elsewhere, for DIO particularly!
>>> 
>>> > So, here what we missing is tlb flush before the checking.
>>> 
>>> That shouldn't be required for this particular issue/case, IIUIC.
>>> One of the things we checked early on was disabling deferred TLB flush
>>> (similarly to what you've done), and it didn't help with the issue; also, the
>>> issue happens on uniprocessor mode too (thus no remote CPU involved.)
>>
>> I guess you didn't try it with page_mapcount + 1 == page_count at tha
>> time?  Anyway, I agree we don't need TLB flush here like KSM.
>> I think the reason KSM is doing TLB flush before the check it to
>> make sure trap trigger on the write from userprocess in other core.
>> However, this MADV_FREE case, HW already gaurantees the trap.
>> Please see below.
>>
>>> 
>>> 
>>> >
>>> > Something like this.
>>> >
>>> > diff --git a/mm/rmap.c b/mm/rmap.c
>>> > index b0fd9dc19eba..b4ad9faa17b2 100644
>>> > --- a/mm/rmap.c
>>> > +++ b/mm/rmap.c
>>> > @@ -1599,18 +1599,8 @@ static bool try_to_unmap_one(struct page *page, struct vm_area_struct *vma,
>>> >
>>> >                         /* MADV_FREE page check */
>>> >                         if (!PageSwapBacked(page)) {
>>> > -                               int refcount = page_ref_count(page);
>>> > -
>>> > -                               /*
>>> > -                                * The only page refs must be from the isolation
>>> > -                                * (checked by the caller shrink_page_list() too)
>>> > -                                * and the (single) rmap (dropped by discard:).
>>> > -                                *
>>> > -                                * Check the reference count before dirty flag
>>> > -                                * with memory barrier; see __remove_mapping().
>>> > -                                */
>>> > -                               smp_rmb();
>>> > -                               if (refcount == 2 && !PageDirty(page)) {
>>> > +                               if (!PageDirty(page) &&
>>> > +                                       page_mapcount(page) + 1 == page_count(page)) {
>>> 
>>> In the interest of avoiding a different race/bug, it seemed worth following the
>>> suggestion outlined in __remove_mapping(), i.e., checking PageDirty()
>>> after the page's reference count, with a memory barrier in between.
>>
>> True so it means your patch as-is is good for me.
>
> If my understanding were correct, a shared anonymous page will be mapped
> read-only.  If so, will a private anonymous page be called
> SetPageDirty() concurrently after direct IO case has been dealt with
> via comparing page_count()/page_mapcount()?

Sorry, I found that I am not quite right here.  When direct IO read
completes, it will call SetPageDirty() and put_page() finally.  And
MADV_FREE in try_to_unmap_one() needs to deal with that too.

Checking direct IO code, it appears that set_page_dirty_lock() is used
to set page dirty, which will use lock_page().

  dio_bio_complete
    bio_check_pages_dirty
      bio_dirty_fn  /* through workqueue */
        bio_release_pages
          set_page_dirty_lock
    bio_release_pages
      set_page_dirty_lock

So in theory, for direct IO, the memory barrier may be unnecessary.  But
I don't think it's a good idea to depend on this specific behavior of
direct IO.  The original code with memory barrier looks more generic and
I don't think it will introduce visible overhead.

Best Regards,
Huang, Ying
