Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0035AC433EF
	for <linux-block@archiver.kernel.org>; Fri, 14 Jan 2022 00:35:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238427AbiANAff (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 13 Jan 2022 19:35:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60274 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238400AbiANAfe (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 13 Jan 2022 19:35:34 -0500
Received: from mail-pg1-x536.google.com (mail-pg1-x536.google.com [IPv6:2607:f8b0:4864:20::536])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A9006C061574
        for <linux-block@vger.kernel.org>; Thu, 13 Jan 2022 16:35:34 -0800 (PST)
Received: by mail-pg1-x536.google.com with SMTP id x83so1368994pgx.4
        for <linux-block@vger.kernel.org>; Thu, 13 Jan 2022 16:35:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=AjzOkDchvf02gYZZoxvXFJNLTblhB7iQVr4M395uCo0=;
        b=O6128YMBPVSio52qugA5q2UpiJ471XvdTyOF5goIce06TcQioUwOs0jhLo2jqYBYqi
         eAOyiyU+3u0EL95DGHtYyYDvnwZAYCc//Ru50LiLIK/3i6jTALCh7IckEfaMIx/Cr/Ry
         DfYBLszSgT/3c38P3gsV+3b6QXUbvaMWahCEQnPMTOkdxI5okARgLit6Hj+EPmKet9ok
         UEYa3+4KrI1qjLKGuhHwJW764a+GWnScfkmURH1+jDOjfGh913nosoZbcboDxAl+ofzz
         9pzoM13hQzGCZTIH6GoKlFyWxr8mbRwQv/HUhwXm5ZWasooj8YNdiw7jXx7z3RLPXmHR
         w0/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to;
        bh=AjzOkDchvf02gYZZoxvXFJNLTblhB7iQVr4M395uCo0=;
        b=SW1MyaPLcvFXhcg5mdxQ0LhICIza4IelWM7arGTFBKWav1hgN2cMmjbBRYhvNPvFp9
         OZvoPXIL2EZT8zvPQVWesV6mDbbzXfxJzVik1lYULZUUjiVYQBrY6kgYWp+RIAAmxEuD
         VE43qzxHU8KdaKR/RlbOLBxfUGDWIjyRMXOQKcFeiwhQO8MU4+PeXMwk7lAW0VAwpRyp
         xORDjZOYZ1TmpIo3a+imcciTXRWztzZiCd1Te3+btCoeJF/h/38dTNRQkugUJpxDrfv1
         pTKZC7vsRuOCOKl2L5PCq29WviW0okpLWzI9VOTS7nxGmCJBkoKGfLgJ3hcgNu7Tn48t
         Ad4g==
X-Gm-Message-State: AOAM530sH1r6jJXX/vIdJfJjnBNG0LZIy3F37GXuV9h67DY5Mj1vciRs
        uvm6lln07gMSUJ8slGcfMJI=
X-Google-Smtp-Source: ABdhPJw9pKgsSa2xUfDa80qoAdxljjrQ8kMlcCFpiTeCp2GFmMigIP9oPnboN/8m22embZXJC2rGzw==
X-Received: by 2002:a05:6a00:2286:b0:4bb:3358:7ea0 with SMTP id f6-20020a056a00228600b004bb33587ea0mr6581122pfe.35.1642120534036;
        Thu, 13 Jan 2022 16:35:34 -0800 (PST)
Received: from google.com ([2620:15c:211:201:5a69:b957:d6be:ccb0])
        by smtp.gmail.com with ESMTPSA id s5sm3750513pfe.117.2022.01.13.16.35.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Jan 2022 16:35:33 -0800 (PST)
Sender: Minchan Kim <minchan.kim@gmail.com>
Date:   Thu, 13 Jan 2022 16:35:31 -0800
From:   Minchan Kim <minchan@kernel.org>
To:     Yu Zhao <yuzhao@google.com>
Cc:     Mauricio Faria de Oliveira <mfo@canonical.com>,
        "Huang, Ying" <ying.huang@intel.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linux-MM <linux-mm@kvack.org>, linux-block@vger.kernel.org,
        Miaohe Lin <linmiaohe@huawei.com>,
        Yang Shi <shy828301@gmail.com>
Subject: Re: [PATCH v2] mm: fix race between MADV_FREE reclaim and blkdev
 direct IO read
Message-ID: <YeDFU3k7pkMpTl6T@google.com>
References: <20220105233440.63361-1-mfo@canonical.com>
 <Yd0oLWtVAyAexyQc@google.com>
 <87v8ypybdc.fsf@yhuang6-desk2.ccr.corp.intel.com>
 <Yd8Q7Cplp5xLTYlV@google.com>
 <CAO9xwp3cgdXRmogRReJW+_AKktWhYL74kzphKpz_8wh12BVzGA@mail.gmail.com>
 <CAOUHufZk1YF5g4b33Sz8WHaKooCcF-KoiHO+sw3XjiHEGhkPEQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAOUHufZk1YF5g4b33Sz8WHaKooCcF-KoiHO+sw3XjiHEGhkPEQ@mail.gmail.com>
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Thu, Jan 13, 2022 at 12:29:51AM -0700, Yu Zhao wrote:
> On Wed, Jan 12, 2022 at 2:53 PM Mauricio Faria de Oliveira
> <mfo@canonical.com> wrote:
> >
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
> Fast gup doesn't block tlb flush; it only blocks IPI used when freeing
> page tables. So it's expected that forcing a tlb flush doesn't fix the
> problem.
> 
> But it still seems to me the fix is missing smp_mb(). IIUC, a proper
> fix would require, on the dio side
> inc page refcnt
> smp_mb()
> read pte
> 
> and on the rmap side
> clear pte
> smp_mb()
> read page refcnt
> 
> try_grab_compound_head() implies smp_mb, but i don't think
> ptep_get_and_clear() does.
> 
> mapcount, as Minchan said, probably is irrelevant given dio is already
> known to be broken with fork.
> 
> I glanced at the thread and thought it might be worth menthing.

If the madv_freed page is shared among processes, it means the ptes
pointing the page are CoW state. If DIO is about to work with the
page, gup_fast will fallback to slow path and then break the CoW
using faultin_page before the submit bio. Thus, the page is not
shared any longer and the pte was alrady marked as dirty on fault
handling. Thus, I think there is no race.

Only, problem is race between DIO and reclaim on exclusive private
madv_free page. In the case, page_count would be only racy.
If ptep_get_and_clear is unordered, yeah, we need barrier there.
(Looks like unorder since ARM uses xchg_relaxed).
