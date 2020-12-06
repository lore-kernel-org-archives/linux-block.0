Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3552FC433FE
	for <linux-block@archiver.kernel.org>; Sun,  6 Dec 2020 14:18:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 09FE22312F
	for <linux-block@archiver.kernel.org>; Sun,  6 Dec 2020 14:18:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728108AbgLFOS1 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Sun, 6 Dec 2020 09:18:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43282 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728098AbgLFOS1 (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Sun, 6 Dec 2020 09:18:27 -0500
Received: from mail-ej1-x643.google.com (mail-ej1-x643.google.com [IPv6:2a00:1450:4864:20::643])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A2509C0613D0
        for <linux-block@vger.kernel.org>; Sun,  6 Dec 2020 06:17:46 -0800 (PST)
Received: by mail-ej1-x643.google.com with SMTP id x16so15671700ejj.7
        for <linux-block@vger.kernel.org>; Sun, 06 Dec 2020 06:17:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=TL0b/E5cGbJjzmn2uYQh+VzbuEtko2kRxRbzEx1ExxE=;
        b=q0OM2jHIWWNEd/K8dQ1vPQSZmgj4wiWrBWZwhH+jDUH4tog+bammlZEND2fBZiBU1D
         bIKIMn5lH2qOmXQ8AKAoR7LpolU+SsiKyXhtzwEfDQqIKkdlRHxQ7oOr6+gBKD3ZkA50
         Y+QtDXi+9cjRfq4KDm0759XPa+NQrZM9pHffTxdtuhtCL2L5xalRETlvPYEL0wI6l8tH
         5Xg/5JWwMuDp87rY8qb/awMhTFP/Y1xn6QRiSIZznRUFO9CP7q3SnB9J0hT3sFz0Ctbw
         cO97rY7svL8VmIZwKD8pDQzrAb5KrRG3JVQ3VLNOjA0A5J5ODodHH0cV6TvMNBcwPzUx
         AlUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=TL0b/E5cGbJjzmn2uYQh+VzbuEtko2kRxRbzEx1ExxE=;
        b=DhCQLOGpUuN0+mbcHg/YejTmt+oT45IR4PVrEBwISHIIKmvHSQFo0KVeyjrfnQlPSs
         WSASJO67x17BI+HzQdAzpm9BgWApUQYfA5l8L/kdtRrhQrB+Scr8xv/ne+2QSjnmn05S
         x8VcnulgBv8CTMwA2kTp+E/BLhJuSIur22bCiIV89lB19opeus+KAsTpmPQigAFmn9Y/
         no//n5NGx78+1GmdDVobMrLzggWiiWu2sv+SJEI19EKiaziaeA+MCvV7oML+jEjMIuNj
         HCZ1K9CCdyQWVZnQFiIakWlLrCIqodwmXW8fwmcWJkLFcxO0+RaHsZ9HQXHttGWF26IL
         pQdg==
X-Gm-Message-State: AOAM533K21u4PF3VtWUDFx0eOgpjyZo1G9Io9ESvUruSHjBXna10Md+C
        IL53rWdDn5jXueREXNWo0zAzNa+0TwhNPx/K1xE=
X-Google-Smtp-Source: ABdhPJyJwGy0ArFHa4gGaXKT0MdEGkomEOzfxcRyXTsqjMzZqEglm24uG8DtQRO0kXWm9sMA3T9qqmlQBfnXji+36lY=
X-Received: by 2002:a17:906:d930:: with SMTP id rn16mr15377070ejb.412.1607264265279;
 Sun, 06 Dec 2020 06:17:45 -0800 (PST)
MIME-Version: 1.0
References: <20201206051802.1890-1-tom.ty89@gmail.com> <2bfe61a7-2dd1-9bb1-76a4-26e948493342@suse.de>
 <CAGnHSEk6NJaX3OQg4V-7U7jJFV+b4w5oj8KyC6gNnH-8dx0v-Q@mail.gmail.com>
In-Reply-To: <CAGnHSEk6NJaX3OQg4V-7U7jJFV+b4w5oj8KyC6gNnH-8dx0v-Q@mail.gmail.com>
From:   Tom Yan <tom.ty89@gmail.com>
Date:   Sun, 6 Dec 2020 22:17:34 +0800
Message-ID: <CAGnHSEkwy8ZfJQdrfjJ1GYJD1axgDfz1jEQDXqgv2saWx3ZXDw@mail.gmail.com>
Subject: Re: [PATCH] block: fix bio chaining in blk_next_bio()
To:     Hannes Reinecke <hare@suse.de>
Cc:     linux-block@vger.kernel.org, Christoph Hellwig <hch@lst.de>,
        axboe@fb.com, tom.leiming@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Also see https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git=
/tree/block/bio.c?h=3Dv5.10-rc6#n1384
btw. I really think the "new as parent" is a careless typo.
(Christoph?)

On Sun, 6 Dec 2020 at 21:17, Tom Yan <tom.ty89@gmail.com> wrote:
>
> I still don't think this sounds right.
>
> See the definition of bio_chain():
> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/b=
lock/bio.c?h=3Dv5.10-rc6#n344
>
> And in turn bio_inc_remaining():
> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/i=
nclude/linux/bio.h?h=3Dv5.10-rc6#n667
>
> With the current blk_next_bio(), the first bio will never even be
> handled by bio_chain()/bio_inc_remaining()/bio_set_flag(bio,
> BIO_CHAIN). When the first submit_bio() is called, it won't have any
> idea that the next/new bio exists. What you said actually sounds a bit
> like the current situation.
>
> On Sun, 6 Dec 2020 at 19:20, Hannes Reinecke <hare@suse.de> wrote:
> >
> > On 12/6/20 6:18 AM, Tom Yan wrote:
> > > While it seems to have worked for so long, it doesn't seem right
> > > that we set the new bio as the parent. bio_chain() seems to be used
> > > in the other way everywhere else anyway.
> > >
> > > Signed-off-by: Tom Yan <tom.ty89@gmail.com>
> > > ---
> > >   block/blk-lib.c | 2 +-
> > >   1 file changed, 1 insertion(+), 1 deletion(-)
> > >
> > > diff --git a/block/blk-lib.c b/block/blk-lib.c
> > > index e90614fd8d6a..918deaf5c8a4 100644
> > > --- a/block/blk-lib.c
> > > +++ b/block/blk-lib.c
> > > @@ -15,7 +15,7 @@ struct bio *blk_next_bio(struct bio *bio, unsigned =
int nr_pages, gfp_t gfp)
> > >       struct bio *new =3D bio_alloc(gfp, nr_pages);
> > >
> > >       if (bio) {
> > > -             bio_chain(bio, new);
> > > +             bio_chain(new, bio);
> > >               submit_bio(bio);
> > >       }
> > >
> > >
> > I don't think this is correct.
> > This code is submitting the original bio, and we _want_ to keep the
> > newly allocated one even though the original might have been completed
> > already. If we were setting the 'parent' to the original bio upper
> > layers might infer that the entire request has been completed (as the
> > original bio is now the 'parent' bio), which is patently not true.
> >
> > So, rather not.
> >
> > Cheers,
> >
> > Hannes
> > --
> > Dr. Hannes Reinecke                Kernel Storage Architect
> > hare@suse.de                              +49 911 74053 688
> > SUSE Software Solutions GmbH, Maxfeldstr. 5, 90409 N=C3=BCrnberg
> > HRB 36809 (AG N=C3=BCrnberg), Gesch=C3=A4ftsf=C3=BChrer: Felix Imend=C3=
=B6rffer
