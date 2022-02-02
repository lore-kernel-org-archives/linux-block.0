Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2263FC433FE
	for <linux-block@archiver.kernel.org>; Wed,  2 Feb 2022 16:29:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241379AbiBBQ3r (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 2 Feb 2022 11:29:47 -0500
Received: from smtp-relay-internal-0.canonical.com ([185.125.188.122]:45464
        "EHLO smtp-relay-internal-0.canonical.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S238353AbiBBQ3q (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 2 Feb 2022 11:29:46 -0500
Received: from mail-pl1-f198.google.com (mail-pl1-f198.google.com [209.85.214.198])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id 8DDF13F33A
        for <linux-block@vger.kernel.org>; Wed,  2 Feb 2022 16:29:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1643819378;
        bh=llyfKV+ioP7EWk9AqLoXWJ66pPJCl2G3speZl7pY9Vs=;
        h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
         To:Cc:Content-Type;
        b=RjNlUd7gDXmmhdxoO4VNu2VWp2h6N6Ki2t69js3Nha8wf0CCq40LlLrjdpNoonB+y
         e2DckuERIbLrJWuLSmUf/ef2Nxj/htutbd3ZN4nz55GJhyKEUKBOudc6go1pz/oepe
         owuohnOdMeYN9Wz1Zj3hlw79N83FSvqTbN17tmF2AoEjT/hAe5I6JW7vvmrSAvB8Ae
         3oUIJPl30MduswS/8gZtCSkEVQKg9uQpN0MaWGg7YLrZoXoLNEnS8q/WgfOvl7XvCm
         tUv8kpgi1OUKO5qH9Q6OxXD83cZoyohUhrjQRQd5NmXhvgQpm6CTzO1QbWt+LpkTWU
         pdCd1NuFzMpmg==
Received: by mail-pl1-f198.google.com with SMTP id y3-20020a1709029b8300b0014c8bcb70a1so7513776plp.3
        for <linux-block@vger.kernel.org>; Wed, 02 Feb 2022 08:29:38 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=llyfKV+ioP7EWk9AqLoXWJ66pPJCl2G3speZl7pY9Vs=;
        b=rmyHnNG/Wx44XqmHF76AZ0FMhnne5Wh8AtaAtCWYHQDbMWvtuUYwNMNWQbrzqas6OV
         ljbwecRqzM+6/KLyG3CRqRW1EKgMjY3UGIzoNtzUrriOgXcgHDmdnAijn0GqyIEmKFrL
         wHvo2qnsmzEcV3PZ5fqDQvWaPbCtPnPPd4IVsWNtkqAqkxQBILzYKnHwEcQ0123pw56p
         OSL8RS0nXxLJAdpvYx2RXlY6yZGDkXqpZESEG5zzaUetZLn/PyZBWQ6bnGVp79/4wQSy
         gywt4zqXbOaNazky2H3E0Azs0TxXiy8o5mU4cVVCLkrzQJT/8+jByeohyVMYxoMz/JH7
         lc4A==
X-Gm-Message-State: AOAM530v28fpSeNw5aDYD0P7LDMccEs2ZdvKgglSb3dOgnV0c/o3EbmH
        SFVyKrW6L0tFin2C3wPAJpsbQYdeWB6IfsGthigCnmyUR/e0xNlw0T4/CfCZXbAWe92cnwWEfng
        mo+ydvJsTCg40aS6QbhQ4ZEaszFfaDtBFBEFYOUOoyZ55aaf6wPXj0YcG
X-Received: by 2002:a17:90a:df0e:: with SMTP id gp14mr9003822pjb.57.1643819377092;
        Wed, 02 Feb 2022 08:29:37 -0800 (PST)
X-Google-Smtp-Source: ABdhPJyswMWCa52XqgcIu1WL5JLiOUhXyaQDnDmcd5FFFXmKagloRfAQe7okpAd3lh2G339PdTc6V4gHf+nS6pDUjNM=
X-Received: by 2002:a17:90a:df0e:: with SMTP id gp14mr9003800pjb.57.1643819376835;
 Wed, 02 Feb 2022 08:29:36 -0800 (PST)
MIME-Version: 1.0
References: <20220131230255.789059-1-mfo@canonical.com> <YfqPJLTIx18DCGii@infradead.org>
In-Reply-To: <YfqPJLTIx18DCGii@infradead.org>
From:   Mauricio Faria de Oliveira <mfo@canonical.com>
Date:   Wed, 2 Feb 2022 13:29:25 -0300
Message-ID: <CAO9xwp3RwkNxWC+FRTcX6Mzi+Ehgbgsmm0qyru_Mb=AMONyexg@mail.gmail.com>
Subject: Re: [PATCH v3] mm: fix race between MADV_FREE reclaim and blkdev
 direct IO read
To:     Christoph Hellwig <hch@infradead.org>
Cc:     Minchan Kim <minchan@kernel.org>,
        "Huang, Ying" <ying.huang@intel.com>, Yu Zhao <yuzhao@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Yang Shi <shy828301@gmail.com>,
        Miaohe Lin <linmiaohe@huawei.com>, linux-mm@kvack.org,
        linux-block@vger.kernel.org, axboe@kernel.dk,
        John Hubbard <jhubbard@nvidia.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Wed, Feb 2, 2022 at 11:03 AM Christoph Hellwig <hch@infradead.org> wrote:
>
> On Mon, Jan 31, 2022 at 08:02:55PM -0300, Mauricio Faria de Oliveira wrote:
> > Well, blkdev_direct_IO() gets references for all pages, and on READ
> > operations it only sets them dirty _later_.
> >
> > So, if MADV_FREE'd pages (i.e., not dirty) are used as buffers for
> > direct IO read from block devices, and page reclaim happens during
> > __blkdev_direct_IO[_simple]() exactly AFTER bio_iov_iter_get_pages()
> > returns, but BEFORE the pages are set dirty, the situation happens.
> >
> > The direct IO read eventually completes. Now, when userspace reads
> > the buffers, the PTE is no longer there and the page fault handler
> > do_anonymous_page() services that with the zero-page, NOT the data!
>
> So why not just set the pages dirty early like the other direct I/O
> implementations?  Or if this is fine with the patch should we remove
> the early dirtying elsewhere?

In general, since this particular problem is specific to MADV_FREE,
it seemed about right to go for a more contained/particular solution
(than changes with broader impact/risk to things that aren't broken).

This isn't to say either approach shouldn't be pursued, but just that
the larger changes aren't strictly needed to actually fix _this_ issue
(and might complicate landing the fix into the stable/distro kernels.)

Now, specifically on the 2 suggestions you mentioned, I'm not very
familiar with other implementations, thus I can't speak to that, sorry.

However, on the 1st suggestion (set pages dirty early), John noted
[1] there might be issues with that and advised not going there.

>
> > Reproducer:
> > ==========
> >
> > @ test.c (simplified, but works)
>
> Can you add this to blktests or some other regularly run regression
> test suite?

Sure.

The test also needs the kernel-side change (to trigger memory reclaim),
which can probably be wired for blktests with a fault-injection capability.

Does that sound good? Maybe there's a better way to do it.

>
> > +                             smp_rmb();
> > +
> > +                             /*
> > +                              * The only page refs must be from the isolation
> > +                              * plus one or more rmap's (dropped by discard:).
>
> Overly long line.

Hmm, checkpatch.pl didn't complain about it. Ah, it checks for 100 chars.
Ok; v4.

>
> > +                              */
> > +                             if ((ref_count == 1 + map_count) &&
>
> No need for the inner braces.
>

Ok; v4.

I'll wait a bit in case more changes are needed, and send v4 w/ the above.

Thanks!

[1] https://lore.kernel.org/linux-mm/7094dbd6-de0c-9909-e657-e358e14dc6c3@nvidia.com/

-- 
Mauricio Faria de Oliveira
