Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C57FAC433EF
	for <linux-block@archiver.kernel.org>; Thu,  3 Feb 2022 22:17:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233578AbiBCWRV (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 3 Feb 2022 17:17:21 -0500
Received: from smtp-relay-internal-1.canonical.com ([185.125.188.123]:56196
        "EHLO smtp-relay-internal-1.canonical.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1355748AbiBCWRU (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 3 Feb 2022 17:17:20 -0500
Received: from mail-pg1-f199.google.com (mail-pg1-f199.google.com [209.85.215.199])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id 8995E3F1AE
        for <linux-block@vger.kernel.org>; Thu,  3 Feb 2022 22:17:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1643926634;
        bh=7D8Lle+FlZ+qvq0z0waDd40W76EwTMH9mbE1wJMW4I0=;
        h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
         To:Cc:Content-Type;
        b=N+yDLu1ckij5+ytLBxtr84q9LDjaNyCDpI9bwSYtaTZr+ybsHYMmb63jsAEyHhEHR
         mRWMr7q81Obwiy0W/vAFnhLLraEomtHsW9HQnE1R8XMmQ9K8fjpridptmYeUrp6ej8
         IdqydBVsLX7KLl0HQLyoemsR7pSjRsxY71TX2NqoUY/CF94P4Fx5oqLxOO+nmLQ9UL
         OrfeYXxRxJoRjWEef5jbmNEXT/tYc4s01fOxKdyOpoL5XzDuUbqpkoGXJn8VYDbby6
         F6g8HMgqMSuoHnn+4vWcqvxKzNrmj+aC+mHUeI1Q8NJOJ1y1IO1MGBh+oegh5FRmTh
         eYCF6t4V82VBg==
Received: by mail-pg1-f199.google.com with SMTP id r3-20020a634403000000b0034dea886e0aso1975415pga.21
        for <linux-block@vger.kernel.org>; Thu, 03 Feb 2022 14:17:14 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=7D8Lle+FlZ+qvq0z0waDd40W76EwTMH9mbE1wJMW4I0=;
        b=ntqLNErtPX7a6CPATZVSlTe/KLVlmBZ/JCUJm0DulN8S2BuJa+DWS7fe52k2iPqWiY
         qe/iPq+deeYAbTgzc1G8Wk1QWUcQSHC+VZdmvU8neYe6ngbjJQL945isdsmmzDuRdp6K
         SDmAksb/Ii/5p0eNTz/UuQxlgSenGGdUe4E27BNzxndOm4fcG24mIDOieiUH5K20NNF1
         1ypNu+n68TniFNKbruyGkmkrlZM94ir3rfa5aWCCnKT1ZdTkcaJOi6RfB59qrjrArLrx
         7QZADuxEQst4jP0qYkm9P/0foTGKZX6UcRC7RPK7RCCDnQR1dDJ76ybJJXyOrRfunIld
         NKng==
X-Gm-Message-State: AOAM531ENDZmlLHFqqWoBNBHNZmUaUHDOJnBoYVAecPkKhENA5XmJX61
        4h19T0cb/JRbna0yp1Np85LeFZeZyw/dxT4dwnvj9+q0b54UZsgoSwzdd0X+1iP2baHYaoUPwjW
        KvaauSLXqUnH3RhkJhSuzd+COkQfO48C0cJFWJoxI8tDya7Ew1zcB9V2R
X-Received: by 2002:a63:3302:: with SMTP id z2mr125904pgz.209.1643926633163;
        Thu, 03 Feb 2022 14:17:13 -0800 (PST)
X-Google-Smtp-Source: ABdhPJwGSt8Il3egvwwKWg9+ox02Ly5+kjHmNJeIqHnVu+ckiD+zBc/LubiBkPJIrc4ntkSIGLh8cTSbP1E+hjUdHCU=
X-Received: by 2002:a63:3302:: with SMTP id z2mr125874pgz.209.1643926632838;
 Thu, 03 Feb 2022 14:17:12 -0800 (PST)
MIME-Version: 1.0
References: <20220131230255.789059-1-mfo@canonical.com> <Yfrh9F67ligMDUB7@google.com>
 <CAO9xwp3DNioiVPJNH9w-eXLxfVmTx9jBpOgq9eatpTFJTTg50Q@mail.gmail.com> <Yfr9UkEtLSHL2qhZ@google.com>
In-Reply-To: <Yfr9UkEtLSHL2qhZ@google.com>
From:   Mauricio Faria de Oliveira <mfo@canonical.com>
Date:   Thu, 3 Feb 2022 19:17:00 -0300
Message-ID: <CAO9xwp0U4u_XST3WARND0eQ5nyHFrKx+sLWVJLQpjYrkZJOBaw@mail.gmail.com>
Subject: Re: [PATCH v3] mm: fix race between MADV_FREE reclaim and blkdev
 direct IO read
To:     Yu Zhao <yuzhao@google.com>
Cc:     Minchan Kim <minchan@kernel.org>,
        "Huang, Ying" <ying.huang@intel.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Yang Shi <shy828301@gmail.com>,
        Miaohe Lin <linmiaohe@huawei.com>, linux-mm@kvack.org,
        linux-block@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Wed, Feb 2, 2022 at 6:53 PM Yu Zhao <yuzhao@google.com> wrote:
>
> On Wed, Feb 02, 2022 at 06:27:47PM -0300, Mauricio Faria de Oliveira wrote:
> > On Wed, Feb 2, 2022 at 4:56 PM Yu Zhao <yuzhao@google.com> wrote:
> > >
> > > On Mon, Jan 31, 2022 at 08:02:55PM -0300, Mauricio Faria de Oliveira wrote:
> > > > Problem:
> > > > =======
> > >
> > > Thanks for the update. A couple of quick questions:
> > >
> > > > Userspace might read the zero-page instead of actual data from a
> > > > direct IO read on a block device if the buffers have been called
> > > > madvise(MADV_FREE) on earlier (this is discussed below) due to a
> > > > race between page reclaim on MADV_FREE and blkdev direct IO read.
> > >
> > > 1) would page migration be affected as well?
> >
> > Could you please elaborate on the potential problem you considered?
> >
> > I checked migrate_pages() -> try_to_migrate() holds the page lock,
> > thus shouldn't race with shrink_page_list() -> with try_to_unmap()
> > (where the issue with MADV_FREE is), but maybe I didn't get you
> > correctly.
>
> Could the race exist between DIO and migration? While DIO is writing
> to a page, could migration unmap it and copy the data from this page
> to a new page?
>

Thanks for clarifying. I started looking into this, but since it's unrelated
to MADV_FREE (which doesn't apply to page migration), I guess this
shouldn't block this patch, if at all possible.  Is that OK with you?


> > > > @@ -1599,7 +1599,30 @@ static bool try_to_unmap_one(struct page *page, struct vm_area_struct *vma,
> > > >
> > > >                       /* MADV_FREE page check */
> > > >                       if (!PageSwapBacked(page)) {
> > > > -                             if (!PageDirty(page)) {
> > > > +                             int ref_count, map_count;
> > > > +
> > > > +                             /*
> > > > +                              * Synchronize with gup_pte_range():
> > > > +                              * - clear PTE; barrier; read refcount
> > > > +                              * - inc refcount; barrier; read PTE
> > > > +                              */
> > > > +                             smp_mb();
> > > > +
> > > > +                             ref_count = page_count(page);
> > > > +                             map_count = page_mapcount(page);
> > > > +
> > > > +                             /*
> > > > +                              * Order reads for page refcount and dirty flag;
> > > > +                              * see __remove_mapping().
> > > > +                              */
> > > > +                             smp_rmb();
> > >
> > > 2) why does it need to order against __remove_mapping()? It seems to
> > >    me that here (called from the reclaim path) it can't race with
> > >    __remove_mapping() because both lock the page.
> >
> > I'll improve that comment in v4.  The ordering isn't against __remove_mapping(),
> > but actually because of an issue described in __remove_mapping()'s comments
> > (something else that doesn't hold the page lock, just has a page reference, that
> > may clear the page dirty flag then drop the reference; thus check ref,
> > then dirty).
>
> Got it. IIRC, get_user_pages() doesn't imply a write barrier. If so,
> there should be a smp_wmb() on the other side:

If I understand it correctly, it actually implies a full memory
barrier, doesn't it?

Because... gup_pte_range() (fast path) calls try_grab_compound_head(),
which eventually calls* atomic_add_unless(), an atomic conditional RMW
operation with return value, thus fully ordered on success (atomic_t.rst);
(on failure gup_pte_range() falls back to the slow path, below.)

And follow_page_pte() (slow path) calls try_grab_page(), which also calls
into try_grab_compound_head(), as the above.

(* on CONFIG_TINY_RCU, it calls just atomic_add(), which isn't ordered,
but that option is targeted for UP/!SMP, thus not a problem for this race.)

Looking at the implementation of arch_atomic_fetch_add_unless() on
more relaxed/weakly ordered archs (arm, powerpc, if I got that right),
there are barriers like 'smp_mb()' and 'sync' instruction if 'old != unless',
so that seems to be OK.

And the set_page_dirty() calls occur after get_user_pages() / that point.

Does that make sense?

Thanks!


>
>          * get_user_pages(&page);
>
>         smp_wmb()
>
>          * SetPageDirty(page);
>          * put_page(page);
>
> (__remove_mapping() doesn't need smp_[rw]mb() on either side because
> it relies on page refcnt freeze and retesting.)
>
> Thanks.



-- 
Mauricio Faria de Oliveira
