Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2A8DDC433F5
	for <linux-block@archiver.kernel.org>; Fri,  4 Feb 2022 18:59:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229567AbiBDS7D (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 4 Feb 2022 13:59:03 -0500
Received: from smtp-relay-internal-0.canonical.com ([185.125.188.122]:33800
        "EHLO smtp-relay-internal-0.canonical.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S235038AbiBDS6s (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 4 Feb 2022 13:58:48 -0500
Received: from mail-pj1-f71.google.com (mail-pj1-f71.google.com [209.85.216.71])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id 521034019A
        for <linux-block@vger.kernel.org>; Fri,  4 Feb 2022 18:58:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1644001119;
        bh=QC1X2RM71Awb1moshBsuaGTei8lAkzyYiOUHcrb832I=;
        h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
         To:Cc:Content-Type;
        b=ZaBwsSX7fq638ZMo1N6DblQeDXcbAPMG80ahuqF41ADiUdyT8vs2HNq+iY4oRtb92
         cB2xH+jpK/iBGb40LXatgkRXRy/QG3/WHB7tGs1xjqygBZZA4S4LusJtf39naFcljx
         KWYz9qzRvQknoGiL2WXipw9htoPkP1VqfA7NGvPHVcv3Nms7cYerFHOyJbNwAOru9h
         /QKImHk09SQ2ZzBlOIgEwo1zs5ET7SG7koTMOQrXnS5qHXWcrEiU8knfJ/KeAoKzcE
         9WQuy1QFHQfLb3/4g8eUubhlkMX6SItHJkEcGPvtbzCxweMsZGh6+3ddS4T/3FyHe0
         x/G1FcwTvsYxw==
Received: by mail-pj1-f71.google.com with SMTP id q12-20020a17090a2e0c00b001b874772fecso602052pjd.2
        for <linux-block@vger.kernel.org>; Fri, 04 Feb 2022 10:58:39 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=QC1X2RM71Awb1moshBsuaGTei8lAkzyYiOUHcrb832I=;
        b=N1sVzO6zN521gJTCD2bZ7k0gijOFckdfb5bbfPzO21s4+NFppx9hrzxPS0PPAPySFl
         tocPOy6n8JqvURy422uavkA8rQVJg8Wq6wFDT3i+oIUTCk5XtcNgxXkkhBQQc1QLwuPa
         HSGqC68jXCMUATKQKHx5+dP3ENTR3XBI+duLYII5RSPk7jFdO305HRZ9E6c4VZrCWe5E
         SXCV6r15kgvXXFqnMkOTintKK5NdOBN6CrwbQCQOkdbboMFTYe90wlzq8eWx/DR+Gwtg
         Dl2OMRlYwH17iYIOoBr5SWm2Axie5KXwS3BYJtV6v64mBfEgTZU8ApPqZdcJj0D/Ldu3
         s+9g==
X-Gm-Message-State: AOAM53372HcwPSnfRgUyc+51Bq6zPFioV/77A2b4b4LzDc8tpIg/oS6x
        qoF70hsh50f4+uD7j/Bq0MTUCVcm2By3k/XbQjnYEGoDHYYF1W4/CYMQUTaKoU4XFpOpTkYlqJ/
        yYs/IUsHabS742a6bcltSIggUV3T8tJ0+9n3kKj/oJTVg74cKcCcvruqs
X-Received: by 2002:a17:902:b189:: with SMTP id s9mr4485538plr.112.1644001116753;
        Fri, 04 Feb 2022 10:58:36 -0800 (PST)
X-Google-Smtp-Source: ABdhPJzuk7oKvRr5g5rTmO/g4zY0rk6mbprl0xb/vtL7A7Epg/efssaXqnqWVn9eorBVMSJVXU29JHGqszbnckbLPqY=
X-Received: by 2002:a17:902:b189:: with SMTP id s9mr4485508plr.112.1644001116472;
 Fri, 04 Feb 2022 10:58:36 -0800 (PST)
MIME-Version: 1.0
References: <20220131230255.789059-1-mfo@canonical.com> <Yfrh9F67ligMDUB7@google.com>
 <CAO9xwp3DNioiVPJNH9w-eXLxfVmTx9jBpOgq9eatpTFJTTg50Q@mail.gmail.com>
 <Yfr9UkEtLSHL2qhZ@google.com> <CAO9xwp0U4u_XST3WARND0eQ5nyHFrKx+sLWVJLQpjYrkZJOBaw@mail.gmail.com>
 <CAOUHufbrQZQ=ZCmVFRGOFk6+Snuy4Z6YSDUb3qMsHwROXatz_w@mail.gmail.com>
In-Reply-To: <CAOUHufbrQZQ=ZCmVFRGOFk6+Snuy4Z6YSDUb3qMsHwROXatz_w@mail.gmail.com>
From:   Mauricio Faria de Oliveira <mfo@canonical.com>
Date:   Fri, 4 Feb 2022 15:58:24 -0300
Message-ID: <CAO9xwp0z3Gi4NmNsgGfNPQvmp=4e5-NfQ0Wu_m-9XoRR_eegXw@mail.gmail.com>
Subject: Re: [PATCH v3] mm: fix race between MADV_FREE reclaim and blkdev
 direct IO read
To:     Yu Zhao <yuzhao@google.com>
Cc:     John Hubbard <jhubbard@nvidia.com>,
        Minchan Kim <minchan@kernel.org>,
        "Huang, Ying" <ying.huang@intel.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Yang Shi <shy828301@gmail.com>,
        Miaohe Lin <linmiaohe@huawei.com>,
        Linux-MM <linux-mm@kvack.org>, linux-block@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Fri, Feb 4, 2022 at 2:57 AM Yu Zhao <yuzhao@google.com> wrote:
>
> On Thu, Feb 3, 2022 at 3:17 PM Mauricio Faria de Oliveira
> <mfo@canonical.com> wrote:
> >
> > On Wed, Feb 2, 2022 at 6:53 PM Yu Zhao <yuzhao@google.com> wrote:
[...]
> > > Got it. IIRC, get_user_pages() doesn't imply a write barrier. If so,
> > > there should be a smp_wmb() on the other side:
> >
> > If I understand it correctly, it actually implies a full memory
> > barrier, doesn't it?
> >
> > Because... gup_pte_range() (fast path) calls try_grab_compound_head(),
> > which eventually calls* atomic_add_unless(), an atomic conditional RMW
> > operation with return value, thus fully ordered on success (atomic_t.rst);
> > (on failure gup_pte_range() falls back to the slow path, below.)
> >
> > And follow_page_pte() (slow path) calls try_grab_page(), which also calls
> > into try_grab_compound_head(), as the above.
> >
> > (* on CONFIG_TINY_RCU, it calls just atomic_add(), which isn't ordered,
> > but that option is targeted for UP/!SMP, thus not a problem for this race.)
> >
> > Looking at the implementation of arch_atomic_fetch_add_unless() on
> > more relaxed/weakly ordered archs (arm, powerpc, if I got that right),
> > there are barriers like 'smp_mb()' and 'sync' instruction if 'old != unless',
> > so that seems to be OK.
> >
> > And the set_page_dirty() calls occur after get_user_pages() / that point.
> >
> > Does that make sense?
>
> Yes, it does, thanks. I was thinking along the lines of whether there
> is an actual contract. [...]

Ok, got you.

> [...] The reason get_user_pages() currently works as
> a full barrier is not intentional but a side effect of this recent
> cleanup patch:
> commit 54d516b1d6 ("mm/gup: small refactoring: simplify try_grab_page()")
> But I agree your fix works as is.

Thanks for bringing it up!

That commit and its revert [1] (that John mentioned in his reply)
change only try_grab_page() / not try_grab_compound_head(),
thus should affect only the slow path / not the fast path.

So, with either change or revert, the slow path should still be okay,
as it takes the page table lock, and try_to_unmap_one() too, thus
they shouldn't race. And the spinlock barriers get values through.

Thanks,

[1] commit c36c04c2e132 ("Revert "mm/gup: small refactoring: simplify
try_grab_page()"")

-- 
Mauricio Faria de Oliveira
