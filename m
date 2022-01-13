Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 52C34C433F5
	for <linux-block@archiver.kernel.org>; Thu, 13 Jan 2022 14:54:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230016AbiAMOyy (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 13 Jan 2022 09:54:54 -0500
Received: from smtp-relay-internal-0.canonical.com ([185.125.188.122]:60510
        "EHLO smtp-relay-internal-0.canonical.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229849AbiAMOyy (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 13 Jan 2022 09:54:54 -0500
Received: from mail-pf1-f197.google.com (mail-pf1-f197.google.com [209.85.210.197])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id 5E7F04000F
        for <linux-block@vger.kernel.org>; Thu, 13 Jan 2022 14:54:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1642085692;
        bh=kSoYFGVnjMiASeQONGPcg/T4UKNiAh9jAEBBJBOIX0o=;
        h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
         To:Cc:Content-Type;
        b=GzvVQBCDhGkZGkHKLh0AHYJR7aum0GoTVULUMSRLdneEh7gMUAc2PIRnKt+NcZynV
         hfU/eo1Ttc3aWakM4xqeOtvrC1NW82dYFfLSEWwNV2qOJtS8BpuDNR1XX4j9lqsgc/
         8E+fsi8q7unqZmcnIyQP9Lj7+Q0YWZEWmrlvbRwcTOiXtdjBAHVjQeRMpiftm+skzQ
         f6o2Z4pyECefKRAgAGjwYB2lvCOTY6PsjXTFi3thy+K6UsBzU2vI+hWVjEQ8qEuIcz
         NJN5rxLkInASehbmk45gYBAnR5xzzdUUYvENZkwUMA7Okx4ACnaEjuwGJ83/SqATSx
         /u3JjTaAgzJaA==
Received: by mail-pf1-f197.google.com with SMTP id d127-20020a623685000000b004bcdb7cce18so35217pfa.21
        for <linux-block@vger.kernel.org>; Thu, 13 Jan 2022 06:54:52 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=kSoYFGVnjMiASeQONGPcg/T4UKNiAh9jAEBBJBOIX0o=;
        b=PhEl8kkW+Uq/Aw1pYRXu3+7NBv4gc5bE0wKKnga8ZHQJvMhlGGEJ2ttrwjlktq/zdu
         OJx/GIEj+bzs8cRwtbjteY5HklawxfLew21mgEqRwrci/xDZP6tEF7tGzOuZmAbxObe8
         Pq+O7Gaok70uz4tDs23so8sZO4o5/uZexbQy7XVuPplxlaDzCEfl6bje2ErtcqXUpRkB
         Y1aqNJnDLRrzi89dg6a90RcMWmlROe/w2Q/rZCNHEexahhEnuRn++LwDHtFRmay2mzB5
         ASFq1/04F1cyLDE1Hhvs771D8BwBncAnBS726TlAe1lQeh8nXnQpiLvoW626HPOkd1W7
         8Y0w==
X-Gm-Message-State: AOAM531cUMhs/c8N1Y3K4lAkFu9bLv4mNcDfsNmXtg/UvJ021Q5Dof+X
        E7UnT5uqF7qiLveQo95XszXSp7M/uVlNDo6d01w3yRKd7VFmQ0MmpdD3rXacKvxwOS5XrUGC2WF
        DkYQ5XMhKbdnLJR31RB9sarbef/MnEg8I3SJKR/1mGRJcA2lE6a7dMS3t
X-Received: by 2002:a17:902:c106:b0:14a:7c95:1b0 with SMTP id 6-20020a170902c10600b0014a7c9501b0mr3512003pli.112.1642085690884;
        Thu, 13 Jan 2022 06:54:50 -0800 (PST)
X-Google-Smtp-Source: ABdhPJwuG9SY4wsfZBciLrUqstbc5gnpqJ0VEJ2eLAzFOTFgOZqsFttuX3mrygrYUhozl3VVkLhZNDvDJQS/gxAYWS4=
X-Received: by 2002:a17:902:c106:b0:14a:7c95:1b0 with SMTP id
 6-20020a170902c10600b0014a7c9501b0mr3511977pli.112.1642085690512; Thu, 13 Jan
 2022 06:54:50 -0800 (PST)
MIME-Version: 1.0
References: <20220105233440.63361-1-mfo@canonical.com> <Yd0oLWtVAyAexyQc@google.com>
 <87v8ypybdc.fsf@yhuang6-desk2.ccr.corp.intel.com> <Yd8Q7Cplp5xLTYlV@google.com>
 <CAO9xwp3cgdXRmogRReJW+_AKktWhYL74kzphKpz_8wh12BVzGA@mail.gmail.com>
 <Yd9YIGLWEeYBkTge@google.com> <87zgo0t3qz.fsf@yhuang6-desk2.ccr.corp.intel.com>
 <87ilunu8au.fsf@yhuang6-desk2.ccr.corp.intel.com>
In-Reply-To: <87ilunu8au.fsf@yhuang6-desk2.ccr.corp.intel.com>
From:   Mauricio Faria de Oliveira <mfo@canonical.com>
Date:   Thu, 13 Jan 2022 11:54:36 -0300
Message-ID: <CAO9xwp1QbmLNA6her4HveuBOZSwcNY5jZqtc00XQ0=V=HEV6Aw@mail.gmail.com>
Subject: Re: [PATCH v2] mm: fix race between MADV_FREE reclaim and blkdev
 direct IO read
To:     "Huang, Ying" <ying.huang@intel.com>
Cc:     Minchan Kim <minchan@kernel.org>, Yu Zhao <yuzhao@google.com>,
        Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        linux-block@vger.kernel.org, Miaohe Lin <linmiaohe@huawei.com>,
        Yang Shi <shy828301@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Thu, Jan 13, 2022 at 9:30 AM Huang, Ying <ying.huang@intel.com> wrote:
>
> "Huang, Ying" <ying.huang@intel.com> writes:
>
> > Minchan Kim <minchan@kernel.org> writes:
> >
> >> On Wed, Jan 12, 2022 at 06:53:07PM -0300, Mauricio Faria de Oliveira wrote:
> >>> Hi Minchan Kim,
> >>>
> >>> Thanks for handling the hard questions! :)
> >>>
> >>> On Wed, Jan 12, 2022 at 2:33 PM Minchan Kim <minchan@kernel.org> wrote:
> >>> >
> >>> > On Wed, Jan 12, 2022 at 09:46:23AM +0800, Huang, Ying wrote:
> >>> > > Yu Zhao <yuzhao@google.com> writes:
> >>> > >
> >>> > > > On Wed, Jan 05, 2022 at 08:34:40PM -0300, Mauricio Faria de Oliveira wrote:
> >>> > > >> diff --git a/mm/rmap.c b/mm/rmap.c
> >>> > > >> index 163ac4e6bcee..8671de473c25 100644
> >>> > > >> --- a/mm/rmap.c
> >>> > > >> +++ b/mm/rmap.c
> >>> > > >> @@ -1570,7 +1570,20 @@ static bool try_to_unmap_one(struct page *page, struct vm_area_struct *vma,
> >>> > > >>
> >>> > > >>                    /* MADV_FREE page check */
> >>> > > >>                    if (!PageSwapBacked(page)) {
> >>> > > >> -                          if (!PageDirty(page)) {
> >>> > > >> +                          int ref_count = page_ref_count(page);
> >>> > > >> +                          int map_count = page_mapcount(page);
> >>> > > >> +
> >>> > > >> +                          /*
> >>> > > >> +                           * The only page refs must be from the isolation
> >>> > > >> +                           * (checked by the caller shrink_page_list() too)
> >>> > > >> +                           * and one or more rmap's (dropped by discard:).
> >>> > > >> +                           *
> >>> > > >> +                           * Check the reference count before dirty flag
> >>> > > >> +                           * with memory barrier; see __remove_mapping().
> >>> > > >> +                           */
> >>> > > >> +                          smp_rmb();
> >>> > > >> +                          if ((ref_count - 1 == map_count) &&
> >>> > > >> +                              !PageDirty(page)) {
> >>> > > >>                                    /* Invalidate as we cleared the pte */
> >>> > > >>                                    mmu_notifier_invalidate_range(mm,
> >>> > > >>                                            address, address + PAGE_SIZE);
> >>> > > >
> >>> > > > Out of curiosity, how does it work with COW in terms of reordering?
> >>> > > > Specifically, it seems to me get_page() and page_dup_rmap() in
> >>> > > > copy_present_pte() can happen in any order, and if page_dup_rmap()
> >>> > > > is seen first, and direct io is holding a refcnt, this check can still
> >>> > > > pass?
> >>> > >
> >>> > > I think that you are correct.
> >>> > >
> >>> > > After more thoughts, it appears very tricky to compare page count and
> >>> > > map count.  Even if we have added smp_rmb() between page_ref_count() and
> >>> > > page_mapcount(), an interrupt may happen between them.  During the
> >>> > > interrupt, the page count and map count may be changed, for example,
> >>> > > unmapped, or do_swap_page().
> >>> >
> >>> > Yeah, it happens but what specific problem are you concerning from the
> >>> > count change under race? The fork case Yu pointed out was already known
> >>> > for breaking DIO so user should take care not to fork under DIO(Please
> >>> > look at O_DIRECT section in man 2 open). If you could give a specific
> >>> > example, it would be great to think over the issue.
> >>> >
> >>> > I agree it's little tricky but it seems to be way other place has used
> >>> > for a long time(Please look at write_protect_page in ksm.c).
> >>>
> >>> Ah, that's great to see it's being used elsewhere, for DIO particularly!
> >>>
> >>> > So, here what we missing is tlb flush before the checking.
> >>>
> >>> That shouldn't be required for this particular issue/case, IIUIC.
> >>> One of the things we checked early on was disabling deferred TLB flush
> >>> (similarly to what you've done), and it didn't help with the issue; also, the
> >>> issue happens on uniprocessor mode too (thus no remote CPU involved.)
> >>
> >> I guess you didn't try it with page_mapcount + 1 == page_count at tha
> >> time?  Anyway, I agree we don't need TLB flush here like KSM.
> >> I think the reason KSM is doing TLB flush before the check it to
> >> make sure trap trigger on the write from userprocess in other core.
> >> However, this MADV_FREE case, HW already gaurantees the trap.
> >> Please see below.
> >>
> >>>
> >>>
> >>> >
> >>> > Something like this.
> >>> >
> >>> > diff --git a/mm/rmap.c b/mm/rmap.c
> >>> > index b0fd9dc19eba..b4ad9faa17b2 100644
> >>> > --- a/mm/rmap.c
> >>> > +++ b/mm/rmap.c
> >>> > @@ -1599,18 +1599,8 @@ static bool try_to_unmap_one(struct page *page, struct vm_area_struct *vma,
> >>> >
> >>> >                         /* MADV_FREE page check */
> >>> >                         if (!PageSwapBacked(page)) {
> >>> > -                               int refcount = page_ref_count(page);
> >>> > -
> >>> > -                               /*
> >>> > -                                * The only page refs must be from the isolation
> >>> > -                                * (checked by the caller shrink_page_list() too)
> >>> > -                                * and the (single) rmap (dropped by discard:).
> >>> > -                                *
> >>> > -                                * Check the reference count before dirty flag
> >>> > -                                * with memory barrier; see __remove_mapping().
> >>> > -                                */
> >>> > -                               smp_rmb();
> >>> > -                               if (refcount == 2 && !PageDirty(page)) {
> >>> > +                               if (!PageDirty(page) &&
> >>> > +                                       page_mapcount(page) + 1 == page_count(page)) {
> >>>
> >>> In the interest of avoiding a different race/bug, it seemed worth following the
> >>> suggestion outlined in __remove_mapping(), i.e., checking PageDirty()
> >>> after the page's reference count, with a memory barrier in between.
> >>
> >> True so it means your patch as-is is good for me.
> >
> > If my understanding were correct, a shared anonymous page will be mapped
> > read-only.  If so, will a private anonymous page be called
> > SetPageDirty() concurrently after direct IO case has been dealt with
> > via comparing page_count()/page_mapcount()?
>
> Sorry, I found that I am not quite right here.  When direct IO read
> completes, it will call SetPageDirty() and put_page() finally.  And
> MADV_FREE in try_to_unmap_one() needs to deal with that too.
>
> Checking direct IO code, it appears that set_page_dirty_lock() is used
> to set page dirty, which will use lock_page().
>
>   dio_bio_complete
>     bio_check_pages_dirty
>       bio_dirty_fn  /* through workqueue */
>         bio_release_pages
>           set_page_dirty_lock
>     bio_release_pages
>       set_page_dirty_lock
>
> So in theory, for direct IO, the memory barrier may be unnecessary.  But
> I don't think it's a good idea to depend on this specific behavior of
> direct IO.  The original code with memory barrier looks more generic and
> I don't think it will introduce visible overhead.
>

Thanks for all the considerations/thought process with potential corner cases!

Regarding the overhead, agreed; and this is in memory reclaim which isn't a
fast path (and even if it's under direct reclaim, things have slowed
down already),
so that would seem to be fine.

cheers,

> Best Regards,
> Huang, Ying



-- 
Mauricio Faria de Oliveira
