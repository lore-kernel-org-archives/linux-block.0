Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EE85FC433F5
	for <linux-block@archiver.kernel.org>; Wed, 12 Jan 2022 21:53:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233822AbiALVx3 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 12 Jan 2022 16:53:29 -0500
Received: from smtp-relay-internal-1.canonical.com ([185.125.188.123]:57596
        "EHLO smtp-relay-internal-1.canonical.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S233525AbiALVx2 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 12 Jan 2022 16:53:28 -0500
Received: from mail-pl1-f198.google.com (mail-pl1-f198.google.com [209.85.214.198])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id A014E3F1E3
        for <linux-block@vger.kernel.org>; Wed, 12 Jan 2022 21:53:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1642024402;
        bh=Y1Ve+1LJZDPSGyIp/E8azQkkAj72SZxMSASpb4nWKgc=;
        h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
         To:Cc:Content-Type;
        b=CNUxFulcPsAejpyTBKcNf/xcW6UkHjTWQtGuLuK9Zie/cgED+6e4EW6jpzDOVvr2p
         sHU9zBeDMV5v5bLMTb8NA39sgB2jOngdR6Zr02h83gvpq5iYkGSKxr6PKmt/RlYCrZ
         97rzkC9QPKLAHFnUiNNGQOm5iUD9bCcw/sEpyWPVr+lHoSdAlnjRSsmgPzMI3ScgHO
         +1kHPZuWCoWdeQIP6s/uWnUSFSFb3vsC8zW+Gp74GV15Hwx6XkxH2JBMOgTxc4Qgwa
         HLW3VC0ZMGLTX5eW//fJliwK2zyOHFgy13q91riRNj8OHwPBbaPRiVKUVltkrAcfLx
         FAB/Jv9iJvRiw==
Received: by mail-pl1-f198.google.com with SMTP id y16-20020a170902b49000b0014984296e61so3873109plr.16
        for <linux-block@vger.kernel.org>; Wed, 12 Jan 2022 13:53:22 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Y1Ve+1LJZDPSGyIp/E8azQkkAj72SZxMSASpb4nWKgc=;
        b=5agBJEe+DVbXbuLgLtBdRo6IuGoyAf/2A1zFX9FWD68czEy7eeaYc5IYlaBTWuqhzs
         oP3KR6cpB3zc1cOIiv/8IGVYexcHNfRzBLVdaebQ/SnnWhbyoANleZ7mPSfivG/bklKa
         wfFMh0lwutOGdcOqbdpcJJaKsOn3Gql8eSjH6bc5MrsxBha+KzjKm0Nct1yc1pwUrd9H
         1IQZabW83NB7HHEJHrA40EvKpfl7E9+SQ15YhMGSS1F3uMY6NH37nHvbB59Qk9JWA2L8
         9rTwxFY0waRAGQRpLDMeEIm0TsR/AkOmOR4W6B6hYcVtxA+kroV0uwUnIELUK8TlnB2V
         Cyvw==
X-Gm-Message-State: AOAM532S1MJH6Jr5zSU3GzOAzR+RFuPSDKLdS94hnlBzo0/A5kATrElx
        qJPAMkTQKigceySAyTt9Nh88YHUzru4ms1LWVWNota7D00d+C6pdNcXBQhUw6ZJDShYLzVLJS9+
        DUTNtEtk1UusFMh+5O8JgrG5zJD6t1002Gw0uadwTIw3JSuegeMXtnjVl
X-Received: by 2002:a63:af07:: with SMTP id w7mr1419735pge.209.1642024400963;
        Wed, 12 Jan 2022 13:53:20 -0800 (PST)
X-Google-Smtp-Source: ABdhPJxKyLlecNcvKnB+IH5EiFIIEq6O9ab2QBZ/1MtAk2ElMvsRCBh6ksSG3PlHaSZ7+dQJQMMa3I0WOLUPM8B3JzU=
X-Received: by 2002:a63:af07:: with SMTP id w7mr1419725pge.209.1642024400669;
 Wed, 12 Jan 2022 13:53:20 -0800 (PST)
MIME-Version: 1.0
References: <20220105233440.63361-1-mfo@canonical.com> <Yd0oLWtVAyAexyQc@google.com>
 <87v8ypybdc.fsf@yhuang6-desk2.ccr.corp.intel.com> <Yd8Q7Cplp5xLTYlV@google.com>
In-Reply-To: <Yd8Q7Cplp5xLTYlV@google.com>
From:   Mauricio Faria de Oliveira <mfo@canonical.com>
Date:   Wed, 12 Jan 2022 18:53:07 -0300
Message-ID: <CAO9xwp3cgdXRmogRReJW+_AKktWhYL74kzphKpz_8wh12BVzGA@mail.gmail.com>
Subject: Re: [PATCH v2] mm: fix race between MADV_FREE reclaim and blkdev
 direct IO read
To:     Minchan Kim <minchan@kernel.org>
Cc:     "Huang, Ying" <ying.huang@intel.com>, Yu Zhao <yuzhao@google.com>,
        Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        linux-block@vger.kernel.org, Miaohe Lin <linmiaohe@huawei.com>,
        Yang Shi <shy828301@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Hi Minchan Kim,

Thanks for handling the hard questions! :)

On Wed, Jan 12, 2022 at 2:33 PM Minchan Kim <minchan@kernel.org> wrote:
>
> On Wed, Jan 12, 2022 at 09:46:23AM +0800, Huang, Ying wrote:
> > Yu Zhao <yuzhao@google.com> writes:
> >
> > > On Wed, Jan 05, 2022 at 08:34:40PM -0300, Mauricio Faria de Oliveira wrote:
> > >> diff --git a/mm/rmap.c b/mm/rmap.c
> > >> index 163ac4e6bcee..8671de473c25 100644
> > >> --- a/mm/rmap.c
> > >> +++ b/mm/rmap.c
> > >> @@ -1570,7 +1570,20 @@ static bool try_to_unmap_one(struct page *page, struct vm_area_struct *vma,
> > >>
> > >>                    /* MADV_FREE page check */
> > >>                    if (!PageSwapBacked(page)) {
> > >> -                          if (!PageDirty(page)) {
> > >> +                          int ref_count = page_ref_count(page);
> > >> +                          int map_count = page_mapcount(page);
> > >> +
> > >> +                          /*
> > >> +                           * The only page refs must be from the isolation
> > >> +                           * (checked by the caller shrink_page_list() too)
> > >> +                           * and one or more rmap's (dropped by discard:).
> > >> +                           *
> > >> +                           * Check the reference count before dirty flag
> > >> +                           * with memory barrier; see __remove_mapping().
> > >> +                           */
> > >> +                          smp_rmb();
> > >> +                          if ((ref_count - 1 == map_count) &&
> > >> +                              !PageDirty(page)) {
> > >>                                    /* Invalidate as we cleared the pte */
> > >>                                    mmu_notifier_invalidate_range(mm,
> > >>                                            address, address + PAGE_SIZE);
> > >
> > > Out of curiosity, how does it work with COW in terms of reordering?
> > > Specifically, it seems to me get_page() and page_dup_rmap() in
> > > copy_present_pte() can happen in any order, and if page_dup_rmap()
> > > is seen first, and direct io is holding a refcnt, this check can still
> > > pass?
> >
> > I think that you are correct.
> >
> > After more thoughts, it appears very tricky to compare page count and
> > map count.  Even if we have added smp_rmb() between page_ref_count() and
> > page_mapcount(), an interrupt may happen between them.  During the
> > interrupt, the page count and map count may be changed, for example,
> > unmapped, or do_swap_page().
>
> Yeah, it happens but what specific problem are you concerning from the
> count change under race? The fork case Yu pointed out was already known
> for breaking DIO so user should take care not to fork under DIO(Please
> look at O_DIRECT section in man 2 open). If you could give a specific
> example, it would be great to think over the issue.
>
> I agree it's little tricky but it seems to be way other place has used
> for a long time(Please look at write_protect_page in ksm.c).

Ah, that's great to see it's being used elsewhere, for DIO particularly!

> So, here what we missing is tlb flush before the checking.

That shouldn't be required for this particular issue/case, IIUIC.
One of the things we checked early on was disabling deferred TLB flush
(similarly to what you've done), and it didn't help with the issue; also, the
issue happens on uniprocessor mode too (thus no remote CPU involved.)


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

In the interest of avoiding a different race/bug, it seemed worth following the
suggestion outlined in __remove_mapping(), i.e., checking PageDirty()
after the page's reference count, with a memory barrier in between.

I'm not familiar with the details of the original issue behind that code change,
but it seemed to be possible here too, particularly as writes from user-space
can happen asynchronously / after try_to_unmap_one() checked PTE clean
and didn't set PageDirty, and if the page's PTE is present, there's no fault?

Thanks again,
Mauricio

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
>
>
>
>
>
>


-- 
Mauricio Faria de Oliveira
