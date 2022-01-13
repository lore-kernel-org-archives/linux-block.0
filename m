Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 78526C433EF
	for <linux-block@archiver.kernel.org>; Thu, 13 Jan 2022 07:30:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230395AbiAMHaI (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 13 Jan 2022 02:30:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52480 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230386AbiAMHaF (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 13 Jan 2022 02:30:05 -0500
Received: from mail-ua1-x92a.google.com (mail-ua1-x92a.google.com [IPv6:2607:f8b0:4864:20::92a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 77402C06173F
        for <linux-block@vger.kernel.org>; Wed, 12 Jan 2022 23:30:05 -0800 (PST)
Received: by mail-ua1-x92a.google.com with SMTP id l15so9382454uai.11
        for <linux-block@vger.kernel.org>; Wed, 12 Jan 2022 23:30:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=+U75foDpLEp9Pq2d/J8EvjvvaOqsx+qmp2d6MCOXFyY=;
        b=MwjTSnct3Ztyug+4y7QwvVZ27rekc9u4NvZHRffC7cbGVRYxAkE0Wun9rnM/f3k0eo
         QuGduUYnuMiZCh9MtPHitwrqnnced1dXNhm/BQ9q3biyhogI1F/nXWIxmyGwOpSPaKka
         mSzxY2/mxeYbHEurGd5kDBf+kGfFQVyAifmfv3N2tH5GCC9SAhw6qRttq8Fiaa+Oqdbt
         poWq8/5MKlnLkDJHiMdnfGbxjCYogSPDrXqBe5szeozZSZEKoD9wTTb9UxTqzAEuCFEj
         UgtrfSqQjPgpLCYY2OrdtlL6WbBZdJSzdCi+mDcLz9BQJpBzlD0yoYOkMpJjxH+usG/8
         4/Eg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=+U75foDpLEp9Pq2d/J8EvjvvaOqsx+qmp2d6MCOXFyY=;
        b=57UbrNiN6g5ExAyaNsTrCKbIdpHl0NqDNDL/8DWLYONdrvWlf9m2ny3iv/zGDlWsxd
         2Vd1S3edbk6b1Tsr3+maNFe2Jz2iR6kW4618k8ZZLAEZsnQNdTSnJ8OOfq+DcpZJBv/J
         fpw9c7mmQmFe0kRqNm0fKul99RK6OeCxrq8c5Ih/LwiyHMzZlSfsy/QpkMWC+Lab+RC4
         ylFfggT1/CnxYBlLlJNgcDiX/G2QQ3t9feCxJRvsCC0AqpTn0P6u92+Wk/GgykRtoHp/
         guLy7rxZNQwDOMtS/Zc2hfDCLpp2QrWbEyu8oKztDn95Y67tXPjgtjFsTFwRJt9C+XBS
         3E2Q==
X-Gm-Message-State: AOAM531hH0pgi/4EZUiVxfMuG2uMQjqjThAZWNdWZwvNafhdLn27813E
        kfkMpPPs6cSpOeY5wbr8pSijaqDnYHzedB04Pj3qyJ1elnHJmNCj
X-Google-Smtp-Source: ABdhPJy4UrxFbV2B2/nyhI205Y521c7tX99SnNl+kwvs+WGcecUAR1gq4pQ8H6TCfe/VdOXrnqH2RT7WGE8lAu1ZovQ=
X-Received: by 2002:a05:6102:1d6:: with SMTP id s22mr1595777vsq.80.1642059004396;
 Wed, 12 Jan 2022 23:30:04 -0800 (PST)
MIME-Version: 1.0
References: <20220105233440.63361-1-mfo@canonical.com> <Yd0oLWtVAyAexyQc@google.com>
 <87v8ypybdc.fsf@yhuang6-desk2.ccr.corp.intel.com> <Yd8Q7Cplp5xLTYlV@google.com>
 <CAO9xwp3cgdXRmogRReJW+_AKktWhYL74kzphKpz_8wh12BVzGA@mail.gmail.com>
In-Reply-To: <CAO9xwp3cgdXRmogRReJW+_AKktWhYL74kzphKpz_8wh12BVzGA@mail.gmail.com>
From:   Yu Zhao <yuzhao@google.com>
Date:   Thu, 13 Jan 2022 00:29:51 -0700
Message-ID: <CAOUHufZk1YF5g4b33Sz8WHaKooCcF-KoiHO+sw3XjiHEGhkPEQ@mail.gmail.com>
Subject: Re: [PATCH v2] mm: fix race between MADV_FREE reclaim and blkdev
 direct IO read
To:     Mauricio Faria de Oliveira <mfo@canonical.com>
Cc:     Minchan Kim <minchan@kernel.org>,
        "Huang, Ying" <ying.huang@intel.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linux-MM <linux-mm@kvack.org>, linux-block@vger.kernel.org,
        Miaohe Lin <linmiaohe@huawei.com>,
        Yang Shi <shy828301@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Wed, Jan 12, 2022 at 2:53 PM Mauricio Faria de Oliveira
<mfo@canonical.com> wrote:
>
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

Fast gup doesn't block tlb flush; it only blocks IPI used when freeing
page tables. So it's expected that forcing a tlb flush doesn't fix the
problem.

But it still seems to me the fix is missing smp_mb(). IIUC, a proper
fix would require, on the dio side
inc page refcnt
smp_mb()
read pte

and on the rmap side
clear pte
smp_mb()
read page refcnt

try_grab_compound_head() implies smp_mb, but i don't think
ptep_get_and_clear() does.

mapcount, as Minchan said, probably is irrelevant given dio is already
known to be broken with fork.

I glanced at the thread and thought it might be worth menthing.
