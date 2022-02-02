Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7730AC433F5
	for <linux-block@archiver.kernel.org>; Wed,  2 Feb 2022 21:28:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234415AbiBBV2F (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 2 Feb 2022 16:28:05 -0500
Received: from smtp-relay-internal-0.canonical.com ([185.125.188.122]:57398
        "EHLO smtp-relay-internal-0.canonical.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1345804AbiBBV2D (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 2 Feb 2022 16:28:03 -0500
Received: from mail-pj1-f70.google.com (mail-pj1-f70.google.com [209.85.216.70])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id C931C3F320
        for <linux-block@vger.kernel.org>; Wed,  2 Feb 2022 21:28:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1643837280;
        bh=L4fb5I2Qy+n1xMTtUMeKV+ktMXhZO+7bzeLzs5mvbSQ=;
        h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
         To:Cc:Content-Type;
        b=TII8T+Pp2zOkzM45w1ZFC1BqpkOdIQki9lS86DcSbdCjl5mq6arSXZtBI6dh4SgM8
         umF0V8fLYO3MkQTVDk/d3UnSEGkN2yk3xK4maKHusSo9NgA9G/15AOUQDFH8Amvpd1
         Ldv51pSLTd8kbrci2qnKYzLV4z8ztpWuyhLZq38KJ7xqwi3T6ghjcMRhyh02+COs6k
         X+h1DAmFeAJclRzKqTc/mml04bXk95Py6viPFQsye7EK9O4Ekun8+V/JuJ6yY3d4kD
         uKRfJn1V0m3HNTGwyoUbvgG2M7ytvZaSTY4BYz1ZPF/Cn6RMB9nS10w0n2dowpwyGl
         6l3HcBXGHMFAg==
Received: by mail-pj1-f70.google.com with SMTP id n13-20020a17090a928d00b001b80df27e05so450508pjo.8
        for <linux-block@vger.kernel.org>; Wed, 02 Feb 2022 13:28:00 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=L4fb5I2Qy+n1xMTtUMeKV+ktMXhZO+7bzeLzs5mvbSQ=;
        b=HxZ9xGB95yp5sOCoA6sa0b1p+S26TTgnYWw4NxoPpiTFyyQOKmYhX8yajwK0K9n9t+
         IT1R8PAchmTX2jZMI9LqbXrREcPH5oZOsFzh0NP+KQS2I6IKHoKHXVu9Kkh8z9BtK21N
         w+MAaQ1yuGyLuVePK57S7inyvHq6oDfzzg4b6v0KQziTl08Kx3pTfFfwbBNU1dUoXGio
         /6QnA4VnXcai54sgpVoWcbG/w0rYwkOaM2M2xyyFJzzf7kgZTO5Tp7M2AO28iL4D7i68
         2cD2B2s5245xQWGI/6mJgGa1+55zO7YLphzfh8fea0OcJpbm1LPphS1l73n3lg/G19Tc
         rn6w==
X-Gm-Message-State: AOAM533ge37hm/S9wjr05JhiyuwwxGeCKiksl2WTtyzQbxqzvvpunWmk
        EoQzqcebUDl8Q9UAu4IfmXbLOUc3yLnWlpIwRu/EvLtqqfYDFGupAWVccYosxOnaGJmjiIf4YEV
        ImKPj2RgUNB8h4YoE2tsTLNQTsxOo9T16Dzw6Iz5IOMjn1X+eei7gJ/wy
X-Received: by 2002:a17:902:c412:: with SMTP id k18mr32559615plk.142.1643837279502;
        Wed, 02 Feb 2022 13:27:59 -0800 (PST)
X-Google-Smtp-Source: ABdhPJzzvdObhXy/sbCjnrjCiO10WZGFW0bvTdQ82TtuOngDDa/6lCGmqoZkAsggiBDk/qQwN32jO6EPQJ2oSzAxQEg=
X-Received: by 2002:a17:902:c412:: with SMTP id k18mr32559593plk.142.1643837279128;
 Wed, 02 Feb 2022 13:27:59 -0800 (PST)
MIME-Version: 1.0
References: <20220131230255.789059-1-mfo@canonical.com> <Yfrh9F67ligMDUB7@google.com>
In-Reply-To: <Yfrh9F67ligMDUB7@google.com>
From:   Mauricio Faria de Oliveira <mfo@canonical.com>
Date:   Wed, 2 Feb 2022 18:27:47 -0300
Message-ID: <CAO9xwp3DNioiVPJNH9w-eXLxfVmTx9jBpOgq9eatpTFJTTg50Q@mail.gmail.com>
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

On Wed, Feb 2, 2022 at 4:56 PM Yu Zhao <yuzhao@google.com> wrote:
>
> On Mon, Jan 31, 2022 at 08:02:55PM -0300, Mauricio Faria de Oliveira wrote:
> > Problem:
> > =======
>
> Thanks for the update. A couple of quick questions:
>
> > Userspace might read the zero-page instead of actual data from a
> > direct IO read on a block device if the buffers have been called
> > madvise(MADV_FREE) on earlier (this is discussed below) due to a
> > race between page reclaim on MADV_FREE and blkdev direct IO read.
>
> 1) would page migration be affected as well?

Could you please elaborate on the potential problem you considered?

I checked migrate_pages() -> try_to_migrate() holds the page lock,
thus shouldn't race with shrink_page_list() -> with try_to_unmap()
(where the issue with MADV_FREE is), but maybe I didn't get you
correctly.

>
> > @@ -1599,7 +1599,30 @@ static bool try_to_unmap_one(struct page *page, struct vm_area_struct *vma,
> >
> >                       /* MADV_FREE page check */
> >                       if (!PageSwapBacked(page)) {
> > -                             if (!PageDirty(page)) {
> > +                             int ref_count, map_count;
> > +
> > +                             /*
> > +                              * Synchronize with gup_pte_range():
> > +                              * - clear PTE; barrier; read refcount
> > +                              * - inc refcount; barrier; read PTE
> > +                              */
> > +                             smp_mb();
> > +
> > +                             ref_count = page_count(page);
> > +                             map_count = page_mapcount(page);
> > +
> > +                             /*
> > +                              * Order reads for page refcount and dirty flag;
> > +                              * see __remove_mapping().
> > +                              */
> > +                             smp_rmb();
>
> 2) why does it need to order against __remove_mapping()? It seems to
>    me that here (called from the reclaim path) it can't race with
>    __remove_mapping() because both lock the page.

I'll improve that comment in v4.  The ordering isn't against __remove_mapping(),
but actually because of an issue described in __remove_mapping()'s comments
(something else that doesn't hold the page lock, just has a page reference, that
may clear the page dirty flag then drop the reference; thus check ref,
then dirty).

Hope this clarifies the question.

Thanks!

>
> > +                             /*
> > +                              * The only page refs must be from the isolation
> > +                              * plus one or more rmap's (dropped by discard:).
> > +                              */
> > +                             if ((ref_count == 1 + map_count) &&
> > +                                 !PageDirty(page)) {
> >                                       /* Invalidate as we cleared the pte */
> >                                       mmu_notifier_invalidate_range(mm,
> >                                               address, address + PAGE_SIZE);



-- 
Mauricio Faria de Oliveira
