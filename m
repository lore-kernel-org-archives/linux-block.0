Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9C2A1C433F5
	for <linux-block@archiver.kernel.org>; Mon, 31 Jan 2022 23:10:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237208AbiAaXKs (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 31 Jan 2022 18:10:48 -0500
Received: from smtp-relay-internal-0.canonical.com ([185.125.188.122]:47162
        "EHLO smtp-relay-internal-0.canonical.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S237063AbiAaXKn (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 31 Jan 2022 18:10:43 -0500
Received: from mail-pf1-f197.google.com (mail-pf1-f197.google.com [209.85.210.197])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id 0BF093F19C
        for <linux-block@vger.kernel.org>; Mon, 31 Jan 2022 23:10:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1643670641;
        bh=qDAoyKLrThEX97wyXuTvqV1tZSHfeVw7Dz/Fs/OO44A=;
        h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
         To:Cc:Content-Type;
        b=pAEgE+U52dtN7yazWLWjH/a46GA6C7iBKPMa25IaVmZwNS5qcmeA03VfAMfmEowyR
         O/OjwCNsM69q/mNAPCJFh1ba+9/8S9bSiH3s0b7G8ruEcEoobXwvTEZfWXIQSs7t9/
         nsiWs3A52+oxbCas47LkDdOiX+gSAoFN/A1HKtpf/9HMZKIe83beYfWmsR40QoaWTc
         YEGmSVgtIcNTfv6Bk6uEvQDQLYcmFtX7u2p4n4XqKDDU9pT+G8lNZRO81BCAe4nZbH
         PjvxeTOgUqF8anceyb+TtQ0agrKnufOCNEHhXaf9K5JIERfapDkb0fTTyVcMV3Nloq
         118iYNEsicR/g==
Received: by mail-pf1-f197.google.com with SMTP id p16-20020aa78610000000b004c7cf2724beso8115569pfn.23
        for <linux-block@vger.kernel.org>; Mon, 31 Jan 2022 15:10:40 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=qDAoyKLrThEX97wyXuTvqV1tZSHfeVw7Dz/Fs/OO44A=;
        b=T9b/s/quPxj/TdfME1Z9H/hfEONORhuZ0dWGoVximc4mKKTvIkh/FhHYzGoZ04oUXE
         Ovm1e+94+sjn1Nqe2HEg+GCtMkUchUaCnOFJuewa8ajvEDdQM/3buNjBMwV6IGrFFixm
         q8n9HRcCVr5UxsQK5WX1V6yVAax3cZoyc+pY3DPTfZNpZ7r7o130MGgwEg7svm7qiyiG
         59+Pymdtxx8S9sCoOA2PQB+fD7/+3bDM6DyBcO+wBlxwiu17M+CB2yH5OlIeEjaJWdmQ
         Lxh8NaHw7IbbzNCAf0FfSXrIO4WvyeGLoZndIAqIdK6F56z5X/TRYrID8IBPODBj0JXO
         qvsQ==
X-Gm-Message-State: AOAM533BzI+8IvtCR3Eszxa4dDFQFxn/nrr3c2T0BkSpryPkmemSjHFB
        CZwUo9jvzu5SfBZQ3oEvftbjC16gw23wp7bmLTwJRje/yUTu8oRSW7OpQHBakNvyn7LN22ekkVB
        F5ArmSSdqHpxEmLIXNWc+neF0oGr/9YYbuwZdNeGUmFm2Yjwf2i+vi4I1
X-Received: by 2002:a17:902:7c92:: with SMTP id y18mr22352357pll.131.1643670639557;
        Mon, 31 Jan 2022 15:10:39 -0800 (PST)
X-Google-Smtp-Source: ABdhPJyc90EIY6ymKiT8nLNUDt+NzsecnGbLKGJ1EVCQzH9ys8+d8S3iA2+lYWo+vwgvg6bbsPFDFKePd0+JsQ91NTA=
X-Received: by 2002:a17:902:7c92:: with SMTP id y18mr22352339pll.131.1643670639259;
 Mon, 31 Jan 2022 15:10:39 -0800 (PST)
MIME-Version: 1.0
References: <20220105233440.63361-1-mfo@canonical.com> <Yd0oLWtVAyAexyQc@google.com>
 <87v8ypybdc.fsf@yhuang6-desk2.ccr.corp.intel.com> <Yd8Q7Cplp5xLTYlV@google.com>
 <CAO9xwp3cgdXRmogRReJW+_AKktWhYL74kzphKpz_8wh12BVzGA@mail.gmail.com>
 <CAOUHufZk1YF5g4b33Sz8WHaKooCcF-KoiHO+sw3XjiHEGhkPEQ@mail.gmail.com> <YeDFU3k7pkMpTl6T@google.com>
In-Reply-To: <YeDFU3k7pkMpTl6T@google.com>
From:   Mauricio Faria de Oliveira <mfo@canonical.com>
Date:   Mon, 31 Jan 2022 20:10:26 -0300
Message-ID: <CAO9xwp1NS9pZ0ZdOmjHfk0=JmNu9JSGP2K16gJhrx3Z2TfekOQ@mail.gmail.com>
Subject: Re: [PATCH v2] mm: fix race between MADV_FREE reclaim and blkdev
 direct IO read
To:     Minchan Kim <minchan@kernel.org>, Yu Zhao <yuzhao@google.com>
Cc:     "Huang, Ying" <ying.huang@intel.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linux-MM <linux-mm@kvack.org>, linux-block@vger.kernel.org,
        Miaohe Lin <linmiaohe@huawei.com>,
        Yang Shi <shy828301@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Thu, Jan 13, 2022 at 9:35 PM Minchan Kim <minchan@kernel.org> wrote:
>
> On Thu, Jan 13, 2022 at 12:29:51AM -0700, Yu Zhao wrote:
> > On Wed, Jan 12, 2022 at 2:53 PM Mauricio Faria de Oliveira
> > <mfo@canonical.com> wrote:
> > >
> > > Hi Minchan Kim,
> > >
> > > Thanks for handling the hard questions! :)
> > >
> > > On Wed, Jan 12, 2022 at 2:33 PM Minchan Kim <minchan@kernel.org> wrote:
> > > >
> > > > On Wed, Jan 12, 2022 at 09:46:23AM +0800, Huang, Ying wrote:
> > > > > Yu Zhao <yuzhao@google.com> writes:
> > > > >
> > > > > > On Wed, Jan 05, 2022 at 08:34:40PM -0300, Mauricio Faria de Oliveira wrote:
> > > > > >> diff --git a/mm/rmap.c b/mm/rmap.c
> > > > > >> index 163ac4e6bcee..8671de473c25 100644
> > > > > >> --- a/mm/rmap.c
> > > > > >> +++ b/mm/rmap.c
> > > > > >> @@ -1570,7 +1570,20 @@ static bool try_to_unmap_one(struct page *page, struct vm_area_struct *vma,
> > > > > >>
> > > > > >>                    /* MADV_FREE page check */
> > > > > >>                    if (!PageSwapBacked(page)) {
> > > > > >> -                          if (!PageDirty(page)) {
> > > > > >> +                          int ref_count = page_ref_count(page);
> > > > > >> +                          int map_count = page_mapcount(page);
> > > > > >> +
> > > > > >> +                          /*
> > > > > >> +                           * The only page refs must be from the isolation
> > > > > >> +                           * (checked by the caller shrink_page_list() too)
> > > > > >> +                           * and one or more rmap's (dropped by discard:).
> > > > > >> +                           *
> > > > > >> +                           * Check the reference count before dirty flag
> > > > > >> +                           * with memory barrier; see __remove_mapping().
> > > > > >> +                           */
> > > > > >> +                          smp_rmb();
> > > > > >> +                          if ((ref_count - 1 == map_count) &&
> > > > > >> +                              !PageDirty(page)) {
> > > > > >>                                    /* Invalidate as we cleared the pte */
> > > > > >>                                    mmu_notifier_invalidate_range(mm,
> > > > > >>                                            address, address + PAGE_SIZE);
> > > > > >
> > > > > > Out of curiosity, how does it work with COW in terms of reordering?
> > > > > > Specifically, it seems to me get_page() and page_dup_rmap() in
> > > > > > copy_present_pte() can happen in any order, and if page_dup_rmap()
> > > > > > is seen first, and direct io is holding a refcnt, this check can still
> > > > > > pass?
> > > > >
> > > > > I think that you are correct.
> > > > >
> > > > > After more thoughts, it appears very tricky to compare page count and
> > > > > map count.  Even if we have added smp_rmb() between page_ref_count() and
> > > > > page_mapcount(), an interrupt may happen between them.  During the
> > > > > interrupt, the page count and map count may be changed, for example,
> > > > > unmapped, or do_swap_page().
> > > >
> > > > Yeah, it happens but what specific problem are you concerning from the
> > > > count change under race? The fork case Yu pointed out was already known
> > > > for breaking DIO so user should take care not to fork under DIO(Please
> > > > look at O_DIRECT section in man 2 open). If you could give a specific
> > > > example, it would be great to think over the issue.
> > > >
> > > > I agree it's little tricky but it seems to be way other place has used
> > > > for a long time(Please look at write_protect_page in ksm.c).
> > >
> > > Ah, that's great to see it's being used elsewhere, for DIO particularly!
> > >
> > > > So, here what we missing is tlb flush before the checking.
> > >
> > > That shouldn't be required for this particular issue/case, IIUIC.
> > > One of the things we checked early on was disabling deferred TLB flush
> > > (similarly to what you've done), and it didn't help with the issue; also, the
> > > issue happens on uniprocessor mode too (thus no remote CPU involved.)
> >
> > Fast gup doesn't block tlb flush; it only blocks IPI used when freeing
> > page tables. So it's expected that forcing a tlb flush doesn't fix the
> > problem.
> >
> > But it still seems to me the fix is missing smp_mb(). IIUC, a proper
> > fix would require, on the dio side
> > inc page refcnt
> > smp_mb()
> > read pte
> >
> > and on the rmap side
> > clear pte
> > smp_mb()
> > read page refcnt
> >
> > try_grab_compound_head() implies smp_mb, but i don't think
> > ptep_get_and_clear() does.
> >
> > mapcount, as Minchan said, probably is irrelevant given dio is already
> > known to be broken with fork.
> >
> > I glanced at the thread and thought it might be worth menthing.
>
> If the madv_freed page is shared among processes, it means the ptes
> pointing the page are CoW state. If DIO is about to work with the
> page, gup_fast will fallback to slow path and then break the CoW
> using faultin_page before the submit bio. Thus, the page is not
> shared any longer and the pte was alrady marked as dirty on fault
> handling. Thus, I think there is no race.
>
> Only, problem is race between DIO and reclaim on exclusive private
> madv_free page. In the case, page_count would be only racy.
> If ptep_get_and_clear is unordered, yeah, we need barrier there.
> (Looks like unorder since ARM uses xchg_relaxed).

Sorry for the long delay in getting back to this.

Thanks to both of you for bringing this up and checking further!
Agree; I missed this barrier was needed for the gup() fast path.

Just sent PATCH v3.

-- 
Mauricio Faria de Oliveira
