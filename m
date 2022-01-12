Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 56394C433F5
	for <linux-block@archiver.kernel.org>; Wed, 12 Jan 2022 22:37:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234465AbiALWh1 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 12 Jan 2022 17:37:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47484 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234494AbiALWhX (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 12 Jan 2022 17:37:23 -0500
Received: from mail-pj1-x102c.google.com (mail-pj1-x102c.google.com [IPv6:2607:f8b0:4864:20::102c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5DB1DC061748
        for <linux-block@vger.kernel.org>; Wed, 12 Jan 2022 14:37:23 -0800 (PST)
Received: by mail-pj1-x102c.google.com with SMTP id hv15so7952537pjb.5
        for <linux-block@vger.kernel.org>; Wed, 12 Jan 2022 14:37:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=kVe0Ne6n5xMwKKrAQ4mP8uWVdsiOXXolu4Kb/XQC380=;
        b=qB1NA+4OfViIbepFqIZigdpQC0SA4p2rY+ukViOgoyq+boZXVSvXxh9bH6VY5WMWOf
         RGitJQHc/w+CS8Tf7MiiH5rZCOcWOHVyYGt1X5iTMqwLzbSBWnBUT4FrbYAojaILl+5Q
         4ise2vpuobK71c+GDR0o625sVo1xEWgmbYd6eXM5pGlexLT+jQ/FyKwIZlajhBe1gtBY
         CvKkiGZa19sJluc4CI2p1jopiPAsmslrkNvWpUrtcWYrEXYeraygfvZEHZmcM85Rzywc
         sUbkmG0IGEjqb3jLS9eTn7u08i12Hav0Z5s+3BbVeqvzUGT1JYZ/JM60vzls/R1Q8QOt
         92Qw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to;
        bh=kVe0Ne6n5xMwKKrAQ4mP8uWVdsiOXXolu4Kb/XQC380=;
        b=i8Ddu+X8mNKNLC1ZJLr6SaGPUC45HBCUGzHUmypEP87SLOjVIh0Bw/cQqwuWvY4tzG
         1ow6hR7F1WwdXCCTfaxUYKmT6dUqVePxF2k0j8bPssGEi1H87ykDuPpUGkAoiznadSYc
         YOKbTE+a9KgJW54OAMqx6eO54DMOR8fiDQEhdQ0HoKYJaoLkxvW/KTPa2ph8cHq3k7Ie
         /q7Wh4Mj4PEyO7D7RRDEmchpqLptaCm6Xs8vwBpgqILH/p9E0TiwknhaHXsJsiNQPSR4
         rz+H+MS6BeZUkoroxmx+ofBAtJYZbubUjnic9yXgQazhxrcIiqT5guaxzk4/qbkDNnMV
         sQhA==
X-Gm-Message-State: AOAM533yD1sOUUDeb9HEv93HsGYv6wTFDNmmR3C//LHp1Koyj7GiXdAj
        1t7clX1uwFFVutptP950M9Y=
X-Google-Smtp-Source: ABdhPJwdkdBSVIZolRc1Ww6r9xHbPEzCiNbkFoJX8Bw8qVPm+iX14PoWZ4WwoIGjtkImdUuHP7/Q/Q==
X-Received: by 2002:aa7:918e:0:b0:4bb:793:b7a7 with SMTP id x14-20020aa7918e000000b004bb0793b7a7mr1462781pfa.71.1642027042808;
        Wed, 12 Jan 2022 14:37:22 -0800 (PST)
Received: from google.com ([2620:15c:211:201:b6c7:c163:623d:56bc])
        by smtp.gmail.com with ESMTPSA id x1sm565051pgh.44.2022.01.12.14.37.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Jan 2022 14:37:22 -0800 (PST)
Sender: Minchan Kim <minchan.kim@gmail.com>
Date:   Wed, 12 Jan 2022 14:37:20 -0800
From:   Minchan Kim <minchan@kernel.org>
To:     Mauricio Faria de Oliveira <mfo@canonical.com>
Cc:     "Huang, Ying" <ying.huang@intel.com>, Yu Zhao <yuzhao@google.com>,
        Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        linux-block@vger.kernel.org, Miaohe Lin <linmiaohe@huawei.com>,
        Yang Shi <shy828301@gmail.com>
Subject: Re: [PATCH v2] mm: fix race between MADV_FREE reclaim and blkdev
 direct IO read
Message-ID: <Yd9YIGLWEeYBkTge@google.com>
References: <20220105233440.63361-1-mfo@canonical.com>
 <Yd0oLWtVAyAexyQc@google.com>
 <87v8ypybdc.fsf@yhuang6-desk2.ccr.corp.intel.com>
 <Yd8Q7Cplp5xLTYlV@google.com>
 <CAO9xwp3cgdXRmogRReJW+_AKktWhYL74kzphKpz_8wh12BVzGA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAO9xwp3cgdXRmogRReJW+_AKktWhYL74kzphKpz_8wh12BVzGA@mail.gmail.com>
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Wed, Jan 12, 2022 at 06:53:07PM -0300, Mauricio Faria de Oliveira wrote:
> Hi Minchan Kim,
> 
> Thanks for handling the hard questions! :)
> 
> On Wed, Jan 12, 2022 at 2:33 PM Minchan Kim <minchan@kernel.org> wrote:
> >
> > On Wed, Jan 12, 2022 at 09:46:23AM +0800, Huang, Ying wrote:
> > > Yu Zhao <yuzhao@google.com> writes:
> > >
> > > > On Wed, Jan 05, 2022 at 08:34:40PM -0300, Mauricio Faria de Oliveira wrote:
> > > >> diff --git a/mm/rmap.c b/mm/rmap.c
> > > >> index 163ac4e6bcee..8671de473c25 100644
> > > >> --- a/mm/rmap.c
> > > >> +++ b/mm/rmap.c
> > > >> @@ -1570,7 +1570,20 @@ static bool try_to_unmap_one(struct page *page, struct vm_area_struct *vma,
> > > >>
> > > >>                    /* MADV_FREE page check */
> > > >>                    if (!PageSwapBacked(page)) {
> > > >> -                          if (!PageDirty(page)) {
> > > >> +                          int ref_count = page_ref_count(page);
> > > >> +                          int map_count = page_mapcount(page);
> > > >> +
> > > >> +                          /*
> > > >> +                           * The only page refs must be from the isolation
> > > >> +                           * (checked by the caller shrink_page_list() too)
> > > >> +                           * and one or more rmap's (dropped by discard:).
> > > >> +                           *
> > > >> +                           * Check the reference count before dirty flag
> > > >> +                           * with memory barrier; see __remove_mapping().
> > > >> +                           */
> > > >> +                          smp_rmb();
> > > >> +                          if ((ref_count - 1 == map_count) &&
> > > >> +                              !PageDirty(page)) {
> > > >>                                    /* Invalidate as we cleared the pte */
> > > >>                                    mmu_notifier_invalidate_range(mm,
> > > >>                                            address, address + PAGE_SIZE);
> > > >
> > > > Out of curiosity, how does it work with COW in terms of reordering?
> > > > Specifically, it seems to me get_page() and page_dup_rmap() in
> > > > copy_present_pte() can happen in any order, and if page_dup_rmap()
> > > > is seen first, and direct io is holding a refcnt, this check can still
> > > > pass?
> > >
> > > I think that you are correct.
> > >
> > > After more thoughts, it appears very tricky to compare page count and
> > > map count.  Even if we have added smp_rmb() between page_ref_count() and
> > > page_mapcount(), an interrupt may happen between them.  During the
> > > interrupt, the page count and map count may be changed, for example,
> > > unmapped, or do_swap_page().
> >
> > Yeah, it happens but what specific problem are you concerning from the
> > count change under race? The fork case Yu pointed out was already known
> > for breaking DIO so user should take care not to fork under DIO(Please
> > look at O_DIRECT section in man 2 open). If you could give a specific
> > example, it would be great to think over the issue.
> >
> > I agree it's little tricky but it seems to be way other place has used
> > for a long time(Please look at write_protect_page in ksm.c).
> 
> Ah, that's great to see it's being used elsewhere, for DIO particularly!
> 
> > So, here what we missing is tlb flush before the checking.
> 
> That shouldn't be required for this particular issue/case, IIUIC.
> One of the things we checked early on was disabling deferred TLB flush
> (similarly to what you've done), and it didn't help with the issue; also, the
> issue happens on uniprocessor mode too (thus no remote CPU involved.)

I guess you didn't try it with page_mapcount + 1 == page_count at tha
time?  Anyway, I agree we don't need TLB flush here like KSM.
I think the reason KSM is doing TLB flush before the check it to
make sure trap trigger on the write from userprocess in other core.
However, this MADV_FREE case, HW already gaurantees the trap.
Please see below.

> 
> 
> >
> > Something like this.
> >
> > diff --git a/mm/rmap.c b/mm/rmap.c
> > index b0fd9dc19eba..b4ad9faa17b2 100644
> > --- a/mm/rmap.c
> > +++ b/mm/rmap.c
> > @@ -1599,18 +1599,8 @@ static bool try_to_unmap_one(struct page *page, struct vm_area_struct *vma,
> >
> >                         /* MADV_FREE page check */
> >                         if (!PageSwapBacked(page)) {
> > -                               int refcount = page_ref_count(page);
> > -
> > -                               /*
> > -                                * The only page refs must be from the isolation
> > -                                * (checked by the caller shrink_page_list() too)
> > -                                * and the (single) rmap (dropped by discard:).
> > -                                *
> > -                                * Check the reference count before dirty flag
> > -                                * with memory barrier; see __remove_mapping().
> > -                                */
> > -                               smp_rmb();
> > -                               if (refcount == 2 && !PageDirty(page)) {
> > +                               if (!PageDirty(page) &&
> > +                                       page_mapcount(page) + 1 == page_count(page)) {
> 
> In the interest of avoiding a different race/bug, it seemed worth following the
> suggestion outlined in __remove_mapping(), i.e., checking PageDirty()
> after the page's reference count, with a memory barrier in between.

True so it means your patch as-is is good for me.

> 
> I'm not familiar with the details of the original issue behind that code change,
> but it seemed to be possible here too, particularly as writes from user-space
> can happen asynchronously / after try_to_unmap_one() checked PTE clean
> and didn't set PageDirty, and if the page's PTE is present, there's no fault?

Yeah, it was discussed. 

For clean pte, CPU has to fetch and update the actual pte entry, not TLB
so trap triggers for MADV_FREE page.

https://lkml.org/lkml/2015/4/15/565
https://lkml.org/lkml/2015/4/16/136
