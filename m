Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8EE95C433F5
	for <linux-block@archiver.kernel.org>; Fri,  4 Feb 2022 05:57:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243548AbiBDF5M (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 4 Feb 2022 00:57:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43228 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243547AbiBDF5M (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Fri, 4 Feb 2022 00:57:12 -0500
Received: from mail-ua1-x934.google.com (mail-ua1-x934.google.com [IPv6:2607:f8b0:4864:20::934])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5ECD0C061714
        for <linux-block@vger.kernel.org>; Thu,  3 Feb 2022 21:57:11 -0800 (PST)
Received: by mail-ua1-x934.google.com with SMTP id b37so9107875uad.12
        for <linux-block@vger.kernel.org>; Thu, 03 Feb 2022 21:57:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=LhDcUu3Ah3HZ65FQSPghcO3kyhkxVY9J9SeqjAvd2Fw=;
        b=K1pF2m5RKywvhxtdwrfFT98zAoy7v14CJrP/cEUKbZ3nzk5SacG7CKL+pvEBPuLHZk
         dDIfQoUdrgwxzxH+UzPPdbY/FIG3gxQaKssFF7dMyxmT2eifYq+bAorIbCrB+uuS/hqt
         92R+lq/qRyM+H3Qvvd4lHjRbtYu5LKx5Wdoec3XzFLSrW9kYAG8fUDS/OzbOLS89ybML
         in7YrcHGhtYyar+8MTuFkXAseuXMceN8BzGkX2Dt/6mBmW396ajO0Y1Il/Hauzgcp61r
         B8cfi6DXXcFM99PcxexHi/NbH5PLhg3TsHWfhljoE6senApyrQihD7BXQFDX/QGB7Ww8
         spOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=LhDcUu3Ah3HZ65FQSPghcO3kyhkxVY9J9SeqjAvd2Fw=;
        b=A5LmIVnDxoz41gCw/QpNG1VtTGynug/VuwBQHBNiPalOXudnLyMDG2DPfFic+Lsv2U
         GPb1KSpvNsB2VRayPDp9QySuVgllqTXV99BmXr7LGjkwx2XBe7itmmSXTylsvbKDXdok
         mIshi0itdoL9FZTOYFwY8J1l3ovREQoh3a7jzgKD/ShtiEixM7HIS1V3DGixV4hD6nOz
         bU/cgkKGQb7AODUPxk3lZakvi2j/mni/3LOb8A9KQ2gu0ZMmTebOQmtffwAQvl699rXK
         XtqEjrEqe34r1Kes7JN/5ea2xkGFobUbWm7yyzfeIqByAguZXUl+6cz9wUHMMf4gwj72
         3N/A==
X-Gm-Message-State: AOAM532GBwRsDHQEsOk/aAJcpot/RdskxWpjMI+1vZJJiZdPpZwaft4U
        bOgwbWDuZbJjJhzNYtskm1UQlQaHqlrJPgCwbZbVew==
X-Google-Smtp-Source: ABdhPJy7o0D9msmWzU/lM04nhhBo9zAihX2iB3mo/hUoczBILrE6VlbDQ25BjYSLtAkQfjDs0kSkALwgG/UsPC4eKi0=
X-Received: by 2002:ab0:4d6d:: with SMTP id k45mr423355uag.55.1643954230355;
 Thu, 03 Feb 2022 21:57:10 -0800 (PST)
MIME-Version: 1.0
References: <20220131230255.789059-1-mfo@canonical.com> <Yfrh9F67ligMDUB7@google.com>
 <CAO9xwp3DNioiVPJNH9w-eXLxfVmTx9jBpOgq9eatpTFJTTg50Q@mail.gmail.com>
 <Yfr9UkEtLSHL2qhZ@google.com> <CAO9xwp0U4u_XST3WARND0eQ5nyHFrKx+sLWVJLQpjYrkZJOBaw@mail.gmail.com>
In-Reply-To: <CAO9xwp0U4u_XST3WARND0eQ5nyHFrKx+sLWVJLQpjYrkZJOBaw@mail.gmail.com>
From:   Yu Zhao <yuzhao@google.com>
Date:   Thu, 3 Feb 2022 22:56:58 -0700
Message-ID: <CAOUHufbrQZQ=ZCmVFRGOFk6+Snuy4Z6YSDUb3qMsHwROXatz_w@mail.gmail.com>
Subject: Re: [PATCH v3] mm: fix race between MADV_FREE reclaim and blkdev
 direct IO read
To:     Mauricio Faria de Oliveira <mfo@canonical.com>,
        John Hubbard <jhubbard@nvidia.com>
Cc:     Minchan Kim <minchan@kernel.org>,
        "Huang, Ying" <ying.huang@intel.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Yang Shi <shy828301@gmail.com>,
        Miaohe Lin <linmiaohe@huawei.com>,
        Linux-MM <linux-mm@kvack.org>, linux-block@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Thu, Feb 3, 2022 at 3:17 PM Mauricio Faria de Oliveira
<mfo@canonical.com> wrote:
>
> On Wed, Feb 2, 2022 at 6:53 PM Yu Zhao <yuzhao@google.com> wrote:
> >
> > On Wed, Feb 02, 2022 at 06:27:47PM -0300, Mauricio Faria de Oliveira wrote:
> > > On Wed, Feb 2, 2022 at 4:56 PM Yu Zhao <yuzhao@google.com> wrote:
> > > >
> > > > On Mon, Jan 31, 2022 at 08:02:55PM -0300, Mauricio Faria de Oliveira wrote:
> > > > > Problem:
> > > > > =======
> > > >
> > > > Thanks for the update. A couple of quick questions:
> > > >
> > > > > Userspace might read the zero-page instead of actual data from a
> > > > > direct IO read on a block device if the buffers have been called
> > > > > madvise(MADV_FREE) on earlier (this is discussed below) due to a
> > > > > race between page reclaim on MADV_FREE and blkdev direct IO read.
> > > >
> > > > 1) would page migration be affected as well?
> > >
> > > Could you please elaborate on the potential problem you considered?
> > >
> > > I checked migrate_pages() -> try_to_migrate() holds the page lock,
> > > thus shouldn't race with shrink_page_list() -> with try_to_unmap()
> > > (where the issue with MADV_FREE is), but maybe I didn't get you
> > > correctly.
> >
> > Could the race exist between DIO and migration? While DIO is writing
> > to a page, could migration unmap it and copy the data from this page
> > to a new page?
> >
>
> Thanks for clarifying. I started looking into this, but since it's unrelated
> to MADV_FREE (which doesn't apply to page migration), I guess this
> shouldn't block this patch, if at all possible.  Is that OK with you?
>
>
> > > > > @@ -1599,7 +1599,30 @@ static bool try_to_unmap_one(struct page *page, struct vm_area_struct *vma,
> > > > >
> > > > >                       /* MADV_FREE page check */
> > > > >                       if (!PageSwapBacked(page)) {
> > > > > -                             if (!PageDirty(page)) {
> > > > > +                             int ref_count, map_count;
> > > > > +
> > > > > +                             /*
> > > > > +                              * Synchronize with gup_pte_range():
> > > > > +                              * - clear PTE; barrier; read refcount
> > > > > +                              * - inc refcount; barrier; read PTE
> > > > > +                              */
> > > > > +                             smp_mb();
> > > > > +
> > > > > +                             ref_count = page_count(page);
> > > > > +                             map_count = page_mapcount(page);
> > > > > +
> > > > > +                             /*
> > > > > +                              * Order reads for page refcount and dirty flag;
> > > > > +                              * see __remove_mapping().
> > > > > +                              */
> > > > > +                             smp_rmb();
> > > >
> > > > 2) why does it need to order against __remove_mapping()? It seems to
> > > >    me that here (called from the reclaim path) it can't race with
> > > >    __remove_mapping() because both lock the page.
> > >
> > > I'll improve that comment in v4.  The ordering isn't against __remove_mapping(),
> > > but actually because of an issue described in __remove_mapping()'s comments
> > > (something else that doesn't hold the page lock, just has a page reference, that
> > > may clear the page dirty flag then drop the reference; thus check ref,
> > > then dirty).
> >
> > Got it. IIRC, get_user_pages() doesn't imply a write barrier. If so,
> > there should be a smp_wmb() on the other side:
>
> If I understand it correctly, it actually implies a full memory
> barrier, doesn't it?
>
> Because... gup_pte_range() (fast path) calls try_grab_compound_head(),
> which eventually calls* atomic_add_unless(), an atomic conditional RMW
> operation with return value, thus fully ordered on success (atomic_t.rst);
> (on failure gup_pte_range() falls back to the slow path, below.)
>
> And follow_page_pte() (slow path) calls try_grab_page(), which also calls
> into try_grab_compound_head(), as the above.
>
> (* on CONFIG_TINY_RCU, it calls just atomic_add(), which isn't ordered,
> but that option is targeted for UP/!SMP, thus not a problem for this race.)
>
> Looking at the implementation of arch_atomic_fetch_add_unless() on
> more relaxed/weakly ordered archs (arm, powerpc, if I got that right),
> there are barriers like 'smp_mb()' and 'sync' instruction if 'old != unless',
> so that seems to be OK.
>
> And the set_page_dirty() calls occur after get_user_pages() / that point.
>
> Does that make sense?

Yes, it does, thanks. I was thinking along the lines of whether there
is an actual contract. The reason get_user_pages() currently works as
a full barrier is not intentional but a side effect of this recent
cleanup patch:
commit 54d516b1d6 ("mm/gup: small refactoring: simplify try_grab_page()")
But I agree your fix works as is.
