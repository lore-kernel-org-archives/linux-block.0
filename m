Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 549F4C433EF
	for <linux-block@archiver.kernel.org>; Mon, 13 Sep 2021 13:18:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3B96460F23
	for <linux-block@archiver.kernel.org>; Mon, 13 Sep 2021 13:18:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239113AbhIMNTs (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 13 Sep 2021 09:19:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57852 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236017AbhIMNRz (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 13 Sep 2021 09:17:55 -0400
Received: from mail-ej1-x62e.google.com (mail-ej1-x62e.google.com [IPv6:2a00:1450:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8EEBEC061760
        for <linux-block@vger.kernel.org>; Mon, 13 Sep 2021 06:16:39 -0700 (PDT)
Received: by mail-ej1-x62e.google.com with SMTP id i21so21030380ejd.2
        for <linux-block@vger.kernel.org>; Mon, 13 Sep 2021 06:16:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=rWeksFHVv/N3BBTXS57Au30PQ+gFerRKB+duU6bbpYs=;
        b=BZAcKkAWqRe5t6YlfZN/02XhMygpevekag0MI3VThwlwzaVJtihNhT3k45T95dIrmb
         Z52bbZ6oYMf7TtiEf1+wA1E9SXPh2T0SuMjamHdbgYwdkVPiCDjOVj+5TzTy5Fw7klxZ
         93nN5Kcc6A5ill/efE47gUMx3Lkdg91tB8a1bUQQgYRpgRA/9HuiNbr/NnaMa8gygEDQ
         nxBjqe/WVJAGafBwiwQxn8X6ZDUU+Bj47T3EUqFd+JEL1cScjlQqueFfwcVpxjq+GM4p
         wbJ/vFfAe+0etII9itVi1/nbjk0nl6Qb20H1rRjZVMc++iK+AEeJbqoxYhcGT1gvxLMy
         ezHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=rWeksFHVv/N3BBTXS57Au30PQ+gFerRKB+duU6bbpYs=;
        b=kb719dDHR1xRGaCMzfSN6ql5k6aFkJfdu/XfX3oAiB0RYg3dU40VklXoAj/5fZQPRR
         mu0F9sYGRVtU0f/z29Mi7J1yz0+b4+Aw+DagBx+KyDX0gjZUGctu1uGBIjk6Hb352yiE
         YcC3EhYjLnkDj11vy/gEXvKmCNr8Q+abB4bSsOWo7mH0FGpK+l43ulDF/QyJk5OZ4ZVN
         XE4Z0wUWXfjgDsfXW5IdDu3qPKioMd/oCYHh0klggHBWzGpxxvFlNdlbMzl1vnu5e28X
         i2Idot8WG0CrH8E3Pd16LLwBE3PM2N3yIFjNsRHtjvEEHrprGuEtgDCaP468mfkZGaAq
         /39Q==
X-Gm-Message-State: AOAM531BjyCbPhjeFhC0PaCc6FQpLpqG0+6EwUiBoGGL/tbgitP1uhHl
        yiRqxsayWf4K6jZIs3vhpCRE8+BYg20Sj0Z52OquGfQFQ6MY
X-Google-Smtp-Source: ABdhPJyEhcow43YHraovoI3/EQvYAmiJ1/x7jk3rb/fRJ8j4Kh3I/V+A78c9OYXpudrN4Zvb2ehn69X8hMm1XWc3FYo=
X-Received: by 2002:a17:906:ece1:: with SMTP id qt1mr12368702ejb.281.1631538998039;
 Mon, 13 Sep 2021 06:16:38 -0700 (PDT)
MIME-Version: 1.0
References: <20210913112557.191-1-xieyongji@bytedance.com> <20210913112557.191-2-xieyongji@bytedance.com>
 <YT9EuMgnTQezWJSQ@infradead.org>
In-Reply-To: <YT9EuMgnTQezWJSQ@infradead.org>
From:   Yongji Xie <xieyongji@bytedance.com>
Date:   Mon, 13 Sep 2021 21:16:20 +0800
Message-ID: <CACycT3v8i=quvDdG6i2YrsqqEKPL8Oa+Dr6AztijREYQpyZryQ@mail.gmail.com>
Subject: Re: [PATCH 1/3] block: Add invalidate_gendisk() helper to invalidate
 the gendisk
To:     Christoph Hellwig <hch@infradead.org>
Cc:     Jens Axboe <axboe@kernel.dk>, Josef Bacik <josef@toxicpanda.com>,
        linux-block@vger.kernel.org, nbd@other.debian.org,
        yixingchen@bytedance.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Mon, Sep 13, 2021 at 8:32 PM Christoph Hellwig <hch@infradead.org> wrote:
>
> On Mon, Sep 13, 2021 at 07:25:55PM +0800, Xie Yongji wrote:
> >
> > +/**
> > + * invalidate_gendisk - invalidate the gendisk
> > + * @disk: the struct gendisk to invalidate
> > + *
> > + * A helper to invalidates the gendisk. It will clean the gendisk's associated
> > + * buffer/page caches and reset its internal states so that the gendisk
> > + * can be reused by the drivers.
> > + *
> > + * Context: can sleep
> > + */
> > +
> > +void invalidate_gendisk(struct gendisk *disk)
>
> No need for the empty line.  Also I wonder if invalidate_disk might be a
> better name - except for del_gendisk we don't really use _gendisk in
> function names at all.
>

Looks good to me.

> > +extern void invalidate_gendisk(struct gendisk *gp);
>
> No need for the extern.  Also I'd name the argument disk, just as in
> the actual implementation.
>

OK.

Thanks,
Yongji
