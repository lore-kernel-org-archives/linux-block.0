Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EE190C433EF
	for <linux-block@archiver.kernel.org>; Thu, 13 Jan 2022 14:30:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235668AbiAMOaV (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 13 Jan 2022 09:30:21 -0500
Received: from smtp-relay-internal-0.canonical.com ([185.125.188.122]:59402
        "EHLO smtp-relay-internal-0.canonical.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231161AbiAMOaU (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 13 Jan 2022 09:30:20 -0500
Received: from mail-pl1-f197.google.com (mail-pl1-f197.google.com [209.85.214.197])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id 683A94000F
        for <linux-block@vger.kernel.org>; Thu, 13 Jan 2022 14:30:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1642084219;
        bh=HIQ5hZKAExUHUltLtEhUCpJKl7xHVkzAgmFwoS/ssFA=;
        h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
         To:Cc:Content-Type;
        b=f0EFzpLWfyDeTsAbiXTBPfEQgEOSpZoX9RLw49YR2SXyvTcvFhfjn9t8pXIDuD1bF
         UY7AEq9ASnjganMde2dJAWb62WWT86c1k7DGjr8jQd1XBfrKF6LtYL5b3jXQX1hD0h
         jfxkerxw4vT+7AXasR/UL0Jog2clt3hrvVtQUSjiHiDkxbEtKYOtXgcYsbSMapmY+G
         he4envBfmJD2QvBCC3f98Ao/AiIyzQbPy/y6l/STS05z7yD4d+mv8+QpyycvkfmUbl
         ffitP5tggO/cMz98AVkTwz+aGbbJB54wrO7JIi0d+HrD+UF29oypD/Rg9mHVHcXrv6
         AnRAUbpiZ2YAw==
Received: by mail-pl1-f197.google.com with SMTP id l9-20020a170903120900b0014a4205ebe3so6176432plh.11
        for <linux-block@vger.kernel.org>; Thu, 13 Jan 2022 06:30:19 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=HIQ5hZKAExUHUltLtEhUCpJKl7xHVkzAgmFwoS/ssFA=;
        b=tkf8P2sXj8pqqWYX12dEnP68ns2M8/rQBwceLPJpXwQIsP3yiiw61FVA6kAxevDT85
         FROVlKf7AqefbcNgohbyrHQ2BdELVvroY+JY44do2VOhkoaYIp150W2uGoUmQoKdtuYk
         1IQH9hzJX/1Zw6a28g39FOvFcQpzZ7H4kng4Qhr2oVKp2WPdN3/3DQFFyGh3EfTjKlQO
         4sL7v8SJ7tKYjnCYln6cIl8dt9Iri0Nkzkzt+IGOmRVLBPN0qU8sUFEYFMZfZcQ/24Ns
         kNjQk3A9Uq9nA8TohivVCfnlcaIO1CXYzzi2hUiwoiyUyxi4WzkOvaoxrflZSVQqs5du
         1g9w==
X-Gm-Message-State: AOAM530OpUzHH1Bdb8wyLSQ9pHCyKBaZcHI88qA7bUxfcZc0XNFemMRp
        gZsT/PKAtxh1zC5FWLqrXTZ2SBjA5Cbxugz7tl8mwk9qGAmmgufzeclTo6oE1O7dWByQdPHyi3X
        8O9KvFDsZWQCYhIL4+ue+kLklhnBzHNx6BXGx7BE5REXhsgvoHW7avk6r
X-Received: by 2002:a62:cd41:0:b0:4bf:3fb3:82a8 with SMTP id o62-20020a62cd41000000b004bf3fb382a8mr4419996pfg.66.1642084217965;
        Thu, 13 Jan 2022 06:30:17 -0800 (PST)
X-Google-Smtp-Source: ABdhPJzvGDXWAiNB5rW11Z+adJgXDrc55KxfusAtCi4cLJIONImHO3EWuvHT8rG2dN/P5KiYr5lsX6vOJk21OUmLCpw=
X-Received: by 2002:a62:cd41:0:b0:4bf:3fb3:82a8 with SMTP id
 o62-20020a62cd41000000b004bf3fb382a8mr4419969pfg.66.1642084217627; Thu, 13
 Jan 2022 06:30:17 -0800 (PST)
MIME-Version: 1.0
References: <20220105233440.63361-1-mfo@canonical.com> <Yd0oLWtVAyAexyQc@google.com>
 <87v8ypybdc.fsf@yhuang6-desk2.ccr.corp.intel.com> <Yd8Q7Cplp5xLTYlV@google.com>
 <CAO9xwp3cgdXRmogRReJW+_AKktWhYL74kzphKpz_8wh12BVzGA@mail.gmail.com> <Yd9YIGLWEeYBkTge@google.com>
In-Reply-To: <Yd9YIGLWEeYBkTge@google.com>
From:   Mauricio Faria de Oliveira <mfo@canonical.com>
Date:   Thu, 13 Jan 2022 11:30:05 -0300
Message-ID: <CAO9xwp1O33=x5web1me=ZZaDCc2fY5UUoUtKuOFrE-UADQZJxQ@mail.gmail.com>
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

On Wed, Jan 12, 2022 at 7:37 PM Minchan Kim <minchan@kernel.org> wrote:
>
> On Wed, Jan 12, 2022 at 06:53:07PM -0300, Mauricio Faria de Oliveira wrote:
> > Hi Minchan Kim,
> >
> > Thanks for handling the hard questions! :)
> >
> > On Wed, Jan 12, 2022 at 2:33 PM Minchan Kim <minchan@kernel.org> wrote:
> > >
> > > On Wed, Jan 12, 2022 at 09:46:23AM +0800, Huang, Ying wrote:
> > > > Yu Zhao <yuzhao@google.com> writes:
> > > >
> > > > > On Wed, Jan 05, 2022 at 08:34:40PM -0300, Mauricio Faria de Oliveira wrote:
> > > > >> diff --git a/mm/rmap.c b/mm/rmap.c
> > > > >> index 163ac4e6bcee..8671de473c25 100644
> > > > >> --- a/mm/rmap.c
> > > > >> +++ b/mm/rmap.c
> > > > >> @@ -1570,7 +1570,20 @@ static bool try_to_unmap_one(struct page *page, struct vm_area_struct *vma,
> > > > >>
> > > > >>                    /* MADV_FREE page check */
> > > > >>                    if (!PageSwapBacked(page)) {
> > > > >> -                          if (!PageDirty(page)) {
> > > > >> +                          int ref_count = page_ref_count(page);
> > > > >> +                          int map_count = page_mapcount(page);
> > > > >> +
> > > > >> +                          /*
> > > > >> +                           * The only page refs must be from the isolation
> > > > >> +                           * (checked by the caller shrink_page_list() too)
> > > > >> +                           * and one or more rmap's (dropped by discard:).
> > > > >> +                           *
> > > > >> +                           * Check the reference count before dirty flag
> > > > >> +                           * with memory barrier; see __remove_mapping().
> > > > >> +                           */
> > > > >> +                          smp_rmb();
> > > > >> +                          if ((ref_count - 1 == map_count) &&
> > > > >> +                              !PageDirty(page)) {
> > > > >>                                    /* Invalidate as we cleared the pte */
> > > > >>                                    mmu_notifier_invalidate_range(mm,
> > > > >>                                            address, address + PAGE_SIZE);
> > > > >
> > > > > Out of curiosity, how does it work with COW in terms of reordering?
> > > > > Specifically, it seems to me get_page() and page_dup_rmap() in
> > > > > copy_present_pte() can happen in any order, and if page_dup_rmap()
> > > > > is seen first, and direct io is holding a refcnt, this check can still
> > > > > pass?
> > > >
> > > > I think that you are correct.
> > > >
> > > > After more thoughts, it appears very tricky to compare page count and
> > > > map count.  Even if we have added smp_rmb() between page_ref_count() and
> > > > page_mapcount(), an interrupt may happen between them.  During the
> > > > interrupt, the page count and map count may be changed, for example,
> > > > unmapped, or do_swap_page().
> > >
> > > Yeah, it happens but what specific problem are you concerning from the
> > > count change under race? The fork case Yu pointed out was already known
> > > for breaking DIO so user should take care not to fork under DIO(Please
> > > look at O_DIRECT section in man 2 open). If you could give a specific
> > > example, it would be great to think over the issue.
> > >
> > > I agree it's little tricky but it seems to be way other place has used
> > > for a long time(Please look at write_protect_page in ksm.c).
> >
> > Ah, that's great to see it's being used elsewhere, for DIO particularly!
> >
> > > So, here what we missing is tlb flush before the checking.
> >
> > That shouldn't be required for this particular issue/case, IIUIC.
> > One of the things we checked early on was disabling deferred TLB flush
> > (similarly to what you've done), and it didn't help with the issue; also, the
> > issue happens on uniprocessor mode too (thus no remote CPU involved.)
>
> I guess you didn't try it with page_mapcount + 1 == page_count at tha
> time?  Anyway, I agree we don't need TLB flush here like KSM.

Sorry, I fail to understand how the page (map) count and TLB flush
would be related.
(I realize you and Yu Zhao already confirmed the TLB flush is not
needed/expected
to fix the issue too; but just for my own education, if you have a chance.)

> I think the reason KSM is doing TLB flush before the check it to
> make sure trap trigger on the write from userprocess in other core.
> However, this MADV_FREE case, HW already gaurantees the trap.

Understood.

> Please see below.
>
> >
> >
> > >
> > > Something like this.
> > >
> > > diff --git a/mm/rmap.c b/mm/rmap.c
> > > index b0fd9dc19eba..b4ad9faa17b2 100644
> > > --- a/mm/rmap.c
> > > +++ b/mm/rmap.c
> > > @@ -1599,18 +1599,8 @@ static bool try_to_unmap_one(struct page *page, struct vm_area_struct *vma,
> > >
> > >                         /* MADV_FREE page check */
> > >                         if (!PageSwapBacked(page)) {
> > > -                               int refcount = page_ref_count(page);
> > > -
> > > -                               /*
> > > -                                * The only page refs must be from the isolation
> > > -                                * (checked by the caller shrink_page_list() too)
> > > -                                * and the (single) rmap (dropped by discard:).
> > > -                                *
> > > -                                * Check the reference count before dirty flag
> > > -                                * with memory barrier; see __remove_mapping().
> > > -                                */
> > > -                               smp_rmb();
> > > -                               if (refcount == 2 && !PageDirty(page)) {
> > > +                               if (!PageDirty(page) &&
> > > +                                       page_mapcount(page) + 1 == page_count(page)) {
> >
> > In the interest of avoiding a different race/bug, it seemed worth following the
> > suggestion outlined in __remove_mapping(), i.e., checking PageDirty()
> > after the page's reference count, with a memory barrier in between.
>
> True so it means your patch as-is is good for me.

That's good news! Thanks for all your help, review, and discussion so
far; it's been very educational.

I see Yu Zhao mentioned a possible concern/suggestion with additional
memory barriers elsewhere.
I'll try and dig to understand/check that in more detail and follow up.

>
> >
> > I'm not familiar with the details of the original issue behind that code change,
> > but it seemed to be possible here too, particularly as writes from user-space
> > can happen asynchronously / after try_to_unmap_one() checked PTE clean
> > and didn't set PageDirty, and if the page's PTE is present, there's no fault?
>
> Yeah, it was discussed.
>
> For clean pte, CPU has to fetch and update the actual pte entry, not TLB
> so trap triggers for MADV_FREE page.
>
> https://lkml.org/lkml/2015/4/15/565
> https://lkml.org/lkml/2015/4/16/136

Thanks for the pointers; great reading.

cheers,

-- 
Mauricio Faria de Oliveira
