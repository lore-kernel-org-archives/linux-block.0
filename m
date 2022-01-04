Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DE072C433EF
	for <linux-block@archiver.kernel.org>; Tue,  4 Jan 2022 23:32:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236477AbiADXc6 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 4 Jan 2022 18:32:58 -0500
Received: from smtp-relay-internal-1.canonical.com ([185.125.188.123]:60048
        "EHLO smtp-relay-internal-1.canonical.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S234152AbiADXc5 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 4 Jan 2022 18:32:57 -0500
Received: from mail-pf1-f199.google.com (mail-pf1-f199.google.com [209.85.210.199])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id 4317B3F1A2
        for <linux-block@vger.kernel.org>; Tue,  4 Jan 2022 23:32:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1641339170;
        bh=2Jq5YA9QElG6IgLbn0P5uha5jwOm4n0q6iN1EfoB0uU=;
        h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
         To:Cc:Content-Type;
        b=rtwO/iqnPILQjw2ToUPr/VMtHTiFxRDTjyMlWfZ4gU8376ieLQ7khGaPbqwIEutdE
         hY8SMJifHhjRk2N2OKJDcRXamssrAnI4LDyWuPBKMK6AWhPI52ipQ3geELX48T7lmV
         U79Rcntb8sJaPyg/pN3I1fOm2ZrzjF/w1IlCXMZ9hgyS9mja31EMEnBHaIu3jF8qDc
         SoYwAbFeOVwlwIgOdlfzkDkbRB5qSvfcJakWnNFicvt5nAkIOn7w2nNyjylODAigQw
         3rr31CaaAOhLAbvigKQ++8rc88cY0v+nkV11EW8/ootZK7M/wDVNcHipXkkqaDin5U
         GhMCkgG4Ebnag==
Received: by mail-pf1-f199.google.com with SMTP id f5-20020a62db05000000b004ba9efaaf08so19280161pfg.10
        for <linux-block@vger.kernel.org>; Tue, 04 Jan 2022 15:32:50 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=2Jq5YA9QElG6IgLbn0P5uha5jwOm4n0q6iN1EfoB0uU=;
        b=3CVcfhWzxw5MNcyYOY2DYsJ31KxS1TyrD6FQTaP4fr3xPqOhCSVMn2YRB+Lud5kGSH
         39bLn6GSK/57yHsqTC49ozJCliYOj4vgIRapEoiRpyAVyGdqvpSldW0mVBL+p+X34AsU
         EsEFLayYZG0WALt4bSccHYs9p/oqv2qFuSwCokvDmIyr1R1YrkVtySQ3CB0pnIrayhsw
         avuezs1A7Ef/bzQ9MGwph2wu+Qu6SXlLQ9+w4Gqwv4aVh39ins/fvPNaL7cQMjN73Yiw
         N1yGfUz2TY2C9FRmIELYw0uBeIv3sDYTCg7bc0KfsDkj7/za636+WFfVbLKr38NOhOqn
         l2Qw==
X-Gm-Message-State: AOAM532QFG6lDaYHkqnQE6smxF2bveTgTGC/Pa56i8qGgqdcPslT7S8q
        MquZiw6ma4tdknzDQ6JX+/UQlu64qLz1mNyx1tYv9H5ucva1keTLgClyMvAbMZ+TiSOOi4zYjQl
        o/lfhCNZRZPHJWfOeqWK3EQzrIPYZNA2SzcIYjXScUYlMj+8BgX3OMgcI
X-Received: by 2002:a17:90b:4a86:: with SMTP id lp6mr854996pjb.57.1641339168765;
        Tue, 04 Jan 2022 15:32:48 -0800 (PST)
X-Google-Smtp-Source: ABdhPJzg0a00iFZhBsqRdaTn5SYJknz35E9l87qVAr0K6JBncmlx7dgKFy2VV/Hs6sKTQUegi36wH8UHBQGtisvDlOE=
X-Received: by 2002:a17:90b:4a86:: with SMTP id lp6mr854970pjb.57.1641339168489;
 Tue, 04 Jan 2022 15:32:48 -0800 (PST)
MIME-Version: 1.0
References: <20211211022115.1547617-1-mfo@canonical.com> <YbuCvo12yVHiZgRE@google.com>
 <CAO9xwp32+izoL54iCWRMGttL_T9yJKcyDyqwqxoDBx8Z7d_ZKg@mail.gmail.com> <YdTTAjfse0Zwl7eB@google.com>
In-Reply-To: <YdTTAjfse0Zwl7eB@google.com>
From:   Mauricio Faria de Oliveira <mfo@canonical.com>
Date:   Tue, 4 Jan 2022 20:32:36 -0300
Message-ID: <CAO9xwp3aiXts8-zjJJB=PWFPUyTMe4UqdQgvwCKqWfi9py1FEw@mail.gmail.com>
Subject: Re: [PATCH] mm: fix race between MADV_FREE reclaim and blkdev direct
 IO read
To:     Minchan Kim <minchan@kernel.org>
Cc:     Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        linux-block@vger.kernel.org, Huang Ying <ying.huang@intel.com>,
        Miaohe Lin <linmiaohe@huawei.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Tue, Jan 4, 2022 at 8:06 PM Minchan Kim <minchan@kernel.org> wrote:
>
> On Tue, Jan 04, 2022 at 08:46:17AM -0300, Mauricio Faria de Oliveira wrote:
> > On Thu, Dec 16, 2021 at 3:17 PM Minchan Kim <minchan@kernel.org> wrote:
> > ...
> > > Hi Mauricio,
> > >
> > > Thanks for catching the bug. There is some comment before I would
> > > look the problem in more detail. Please see below.
> > >
> >
> > Hey! Thanks for looking into this. Sorry for the delay; I've been out
> > a few weeks.
> >
> > > > diff --git a/mm/rmap.c b/mm/rmap.c
> > > > index 163ac4e6bcee..f04151aae03b 100644
> > > > --- a/mm/rmap.c
> > > > +++ b/mm/rmap.c
> > > > @@ -1570,7 +1570,18 @@ static bool try_to_unmap_one(struct page *page, struct vm_area_struct *vma,
> > > >
> > > >                       /* MADV_FREE page check */
> > > >                       if (!PageSwapBacked(page)) {
> > > > -                             if (!PageDirty(page)) {
> > > > +                             int refcount = page_ref_count(page);
> > > > +
> > > > +                             /*
> > > > +                              * The only page refs must be from the isolation
> > > > +                              * (checked by the caller shrink_page_list() too)
> > > > +                              * and the (single) rmap (dropped by discard:).
> > > > +                              *
> > > > +                              * Check the reference count before dirty flag
> > > > +                              * with memory barrier; see __remove_mapping().
> > > > +                              */
> > > > +                             smp_rmb();
> > > > +                             if (refcount == 2 && !PageDirty(page)) {
> > >
> > > A madv_free marked page could be mapped at several processes so
> > > it wouldn't be refcount two all the time, I think.
> > > Shouldn't we check it with page_mapcount with page_refcount?
> > >
> > >     page_ref_count(page) - 1  > page_mapcount(page)
> > >
> >
> > It's the other way around, isn't it? The madvise(MADV_FREE) call only clears
> > the page dirty flag if page_mapcount() == 1 (ie not mapped by more processes).
> >
> > @ madvise_free_pte_range()
> >
> >                         /*
> >                          * If page is shared with others, we couldn't clear
> >                          * PG_dirty of the page.
> >                          */
> >                         if (page_mapcount(page) != 1) {
> >                                 unlock_page(page);
> >                                 continue;
> >                         }
> > ...
> >                         ClearPageDirty(page);
> >                         unlock_page(page);
> >
> >
> > If that's right, the refcount of 2 should be OK (one from the isolation,
> > another one from the single map/one process.)
> >
> > Does that make sense?  I might be missing something.
>
> A child process could be forked from parent after madvise so the page
> mapcount of the hinted page could have elevated refcount.

Thanks for clarifying. I was indeed missing something. :)

I revisited your commit 854e9ed09ded ("mm: support madvise(MADV_FREE)"),
and now realized that the restriction for map count == 1 is only for _cleaning_
the dirty flag, not for discarding the (clean) page mapping later on.

"""
    To solve the problem, this patch clears PG_dirty if only the page is
    owned exclusively by current process when madvise is called because
    PG_dirty represents ptes's dirtiness in several processes so we could
    clear it only if we own it exclusively.
"""

I'll look at this tomorrow and submit a v2.

Thanks!

-- 
Mauricio Faria de Oliveira
