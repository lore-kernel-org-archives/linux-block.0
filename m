Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 86D57C4361B
	for <linux-block@archiver.kernel.org>; Fri, 11 Dec 2020 20:11:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 297252311A
	for <linux-block@archiver.kernel.org>; Fri, 11 Dec 2020 20:11:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726522AbgLKSlq (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 11 Dec 2020 13:41:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55228 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728198AbgLKSlX (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 11 Dec 2020 13:41:23 -0500
Received: from mail-io1-xd41.google.com (mail-io1-xd41.google.com [IPv6:2607:f8b0:4864:20::d41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CA21EC0613CF;
        Fri, 11 Dec 2020 10:40:42 -0800 (PST)
Received: by mail-io1-xd41.google.com with SMTP id d9so10482045iob.6;
        Fri, 11 Dec 2020 10:40:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=MRVPUYlxS/fdaO/lelSMT47zpvZj2vTgUngdVgjDGwA=;
        b=Ir5gHcc7zNOlMmrJ0q+Xj0tTlGHhECw3YZTd4v5JxzdqrTUGAMhJ43ddLAfMkyFXEV
         FDDAVgFJVI9GO1qtKJ9Lxh9Y9W6XGTd2X/rl/zE+Y1mtZODcpzfLXJwXLgF+SAKXuefo
         fgYHtgokNAmzphxUY4DIu4KducGEHUK4T6nACi9NBozJLRIMTc9x5CotOMm7RyR2djj9
         6ATJW6LGJ/m0GBrn8aLUEYVWYf+RHNRLRcsI+7A8sKlSBBfh47/4Iv9U6vIb81He0Mr5
         zVyN53UWgp4iNofTfdpArWax4m1qtwrPiidWOhSqVVtniDzU8A+Bo9ariDjolWTOzNog
         4Row==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=MRVPUYlxS/fdaO/lelSMT47zpvZj2vTgUngdVgjDGwA=;
        b=pjsImLRAAn0Ybm2JfjWrH57Pyfjx4N7k5NoDyPwQHfg9ewHIgePUSPCB6cGJCpSMbc
         VMIHxOM54EwdOtOAFZcuG4aND+G7qADW7XvPaicZFJptMVkUfTgm8rsERBrFUnygMNW1
         4v6+p399D3AaFJMo0UG4jJMZ3abUBNQjpx5gvIcgCbCj1QrTq4k92mT8YtFxnoh3fTMo
         weBFtFiOwGue10W8gPvkbIAuHR2vlw2TDF11NGv9leu8s4LPCmAnVEELqm6ztpYOaPtC
         8ZIS5BybUx/RIMPBhM999pvCT6cUA0PZpmW6xjrefW6RrE02Lm1E4wiIumzNNllMjkg3
         MZ4w==
X-Gm-Message-State: AOAM531raXHokeOtLHONganO3PIh7VsyEVBPi+oswW//INJeyNv/rqJO
        /Y4Zm7+rxCULTQB+HQjWOIkZV6jzs5sWUjnZ0PA=
X-Google-Smtp-Source: ABdhPJyXdoBPNBzhpCLxZitOL92KJPCNn9fJyOqUhYwSq8qVgiIH0rlsOK7m3GDl08B/H4f0R7SdvyNP8QSpde6tWYQ=
X-Received: by 2002:a05:6638:bc1:: with SMTP id g1mr17132579jad.27.1607712042045;
 Fri, 11 Dec 2020 10:40:42 -0800 (PST)
MIME-Version: 1.0
References: <20201211181236.25755-1-lukas.bulwahn@gmail.com> <alpine.DEB.2.22.394.2012111923020.2669@hadrien>
In-Reply-To: <alpine.DEB.2.22.394.2012111923020.2669@hadrien>
From:   Lukas Bulwahn <lukas.bulwahn@gmail.com>
Date:   Fri, 11 Dec 2020 19:40:31 +0100
Message-ID: <CAKXUXMxjtv5B4ekC58=Ww8R4Ju2MvT0pXbPi7XH+OU7JuYnP3w@mail.gmail.com>
Subject: Re: [PATCH] block: drop dead assignments in loop_init()
To:     Julia Lawall <julia.lawall@inria.fr>
Cc:     Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>,
        linux-block@vger.kernel.org, Hannes Reinecke <hare@suse.de>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        clang-built-linux <clang-built-linux@googlegroups.com>,
        kernel-janitors@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Fri, Dec 11, 2020 at 7:23 PM Julia Lawall <julia.lawall@inria.fr> wrote:
>
>
>
> On Fri, 11 Dec 2020, Lukas Bulwahn wrote:
>
> > Commit 8410d38c2552 ("loop: use __register_blkdev to allocate devices on
> > demand") simplified loop_init(); so computing the range of the block region
> > is not required anymore and can be dropped.
> >
> > Drop dead assignments in loop_init().
> >
> > As compilers will detect these unneeded assignments and optimize this,
> > the resulting object code is identical before and after this change.
> >
> > No functional change. No change in object code.
>
> It looks like some braces should be dropped too?
>
> julia
>

Julia, you are right; I just rewrote it to:

nr = max_loop ? max_loop : CONFIG_BLK_DEV_LOOP_MIN_COUNT;

v2 will follow in a moment.

Lukas

> >
> > Signed-off-by: Lukas Bulwahn <lukas.bulwahn@gmail.com>
> > ---
> > Christoph, please ack.
> >
> > Jens, please pick this minor non-urgent clean-up patch on your
> > block -next tree on top of Christoph's commit above.
> >
> >  drivers/block/loop.c | 3 ---
> >  1 file changed, 3 deletions(-)
> >
> > diff --git a/drivers/block/loop.c b/drivers/block/loop.c
> > index d2ce1ddc192d..eed4bc5ef5c5 100644
> > --- a/drivers/block/loop.c
> > +++ b/drivers/block/loop.c
> > @@ -2304,7 +2304,6 @@ MODULE_ALIAS("devname:loop-control");
> >  static int __init loop_init(void)
> >  {
> >       int i, nr;
> > -     unsigned long range;
> >       struct loop_device *lo;
> >       int err;
> >
> > @@ -2343,10 +2342,8 @@ static int __init loop_init(void)
> >        */
> >       if (max_loop) {
> >               nr = max_loop;
> > -             range = max_loop << part_shift;
> >       } else {
> >               nr = CONFIG_BLK_DEV_LOOP_MIN_COUNT;
> > -             range = 1UL << MINORBITS;
> >       }
> >
> >       err = misc_register(&loop_misc);
> > --
> > 2.17.1
> >
> >
