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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 88A35C4361B
	for <linux-block@archiver.kernel.org>; Sun,  6 Dec 2020 13:18:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4A0D82311B
	for <linux-block@archiver.kernel.org>; Sun,  6 Dec 2020 13:18:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727943AbgLFNS2 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Sun, 6 Dec 2020 08:18:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34104 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727939AbgLFNS2 (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Sun, 6 Dec 2020 08:18:28 -0500
Received: from mail-ed1-x542.google.com (mail-ed1-x542.google.com [IPv6:2a00:1450:4864:20::542])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F0C21C0613D0
        for <linux-block@vger.kernel.org>; Sun,  6 Dec 2020 05:17:47 -0800 (PST)
Received: by mail-ed1-x542.google.com with SMTP id r5so10744483eda.12
        for <linux-block@vger.kernel.org>; Sun, 06 Dec 2020 05:17:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=VnCRrSU/yqwSir7wzo0VO1fgu/uJufVaI3Cpnkw8arM=;
        b=ckfkGxp7E5lF5ay53VH9Qk67W9dR3347Vfu4Z6CU1vCCVVyJ4+V7dlojJAUIrTPVsl
         Lpl5T0Ug5l3du3TV5VX1z53muywRvuPzE83maF+bMgtYYgeOekK+68kMvFykqFictaky
         qAZB8WRba9AOftB3CaTq6PqpMfw7r8OBpH7h6j9DESgWfLi/6YqVn9ZsQOqRCORpCBcZ
         VVj9Jm7nh7LgOxD5HSYSmPYwepiBAunj9gkXVWITZyALTRDJWrj1f4RkN8gQYrPIF4HR
         le/UJVFTBE3w4AgQm9aQOstDzH6L/Hy0lNurfldLliVeN9vbCdoXS/1WFuXT3H4uJQut
         QB8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=VnCRrSU/yqwSir7wzo0VO1fgu/uJufVaI3Cpnkw8arM=;
        b=Vmm5Gf53KnmDjotzal7PYEn/nXyFYxYL2DeoEuxDPMP+81GzM9RRwkr71RKrekHLYj
         /tttCrS7TlKjvElGEHz0pTCuMh9WUFvl79qiXZlUKruuEgJ2pIYZzZ4DNgQeu3oEBkE8
         i+dKwgCAPXGNAqGvOVxj1nDR/MpftavipVcKd5DoLWEZySdPojUFMWfVdUbR19HvgLou
         /rfbsAYUelRVDAJ0swN/yNUQ92KgMSKLmfo35dwd7/TI+wIQ8JDFwJ35AXeyg/yRyDgJ
         DDyZ0lAfOLupEFuqyqwfZ2qXx4SgoCEV0dVsXmvH+mxewGHjTMaZUyWAyaB4Uq1LFamZ
         e0IA==
X-Gm-Message-State: AOAM530NfMeJ8arLeCuvL6M8OKHCntNelsOPMT1OJLRe2UHZ63gesj5p
        Ld2FjKxekcVWQUBJejkAy657YAMif6E6YJjKh0A=
X-Google-Smtp-Source: ABdhPJzxc6pFy8mAkqDnph8K+SYYR5tty1biALP8ySt+gjZZRr1sM2bWVPVqn8/WQaplzjEnWAq7lOJPosz2cAvPD80=
X-Received: by 2002:a50:d6dc:: with SMTP id l28mr15480842edj.286.1607260666776;
 Sun, 06 Dec 2020 05:17:46 -0800 (PST)
MIME-Version: 1.0
References: <20201206051802.1890-1-tom.ty89@gmail.com> <2bfe61a7-2dd1-9bb1-76a4-26e948493342@suse.de>
In-Reply-To: <2bfe61a7-2dd1-9bb1-76a4-26e948493342@suse.de>
From:   Tom Yan <tom.ty89@gmail.com>
Date:   Sun, 6 Dec 2020 21:17:35 +0800
Message-ID: <CAGnHSEk6NJaX3OQg4V-7U7jJFV+b4w5oj8KyC6gNnH-8dx0v-Q@mail.gmail.com>
Subject: Re: [PATCH] block: fix bio chaining in blk_next_bio()
To:     Hannes Reinecke <hare@suse.de>
Cc:     linux-block@vger.kernel.org, Christoph Hellwig <hch@lst.de>,
        axboe@fb.com, tom.leiming@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

I still don't think this sounds right.

See the definition of bio_chain():
https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/blo=
ck/bio.c?h=3Dv5.10-rc6#n344

And in turn bio_inc_remaining():
https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/inc=
lude/linux/bio.h?h=3Dv5.10-rc6#n667

With the current blk_next_bio(), the first bio will never even be
handled by bio_chain()/bio_inc_remaining()/bio_set_flag(bio,
BIO_CHAIN). When the first submit_bio() is called, it won't have any
idea that the next/new bio exists. What you said actually sounds a bit
like the current situation.

On Sun, 6 Dec 2020 at 19:20, Hannes Reinecke <hare@suse.de> wrote:
>
> On 12/6/20 6:18 AM, Tom Yan wrote:
> > While it seems to have worked for so long, it doesn't seem right
> > that we set the new bio as the parent. bio_chain() seems to be used
> > in the other way everywhere else anyway.
> >
> > Signed-off-by: Tom Yan <tom.ty89@gmail.com>
> > ---
> >   block/blk-lib.c | 2 +-
> >   1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > diff --git a/block/blk-lib.c b/block/blk-lib.c
> > index e90614fd8d6a..918deaf5c8a4 100644
> > --- a/block/blk-lib.c
> > +++ b/block/blk-lib.c
> > @@ -15,7 +15,7 @@ struct bio *blk_next_bio(struct bio *bio, unsigned in=
t nr_pages, gfp_t gfp)
> >       struct bio *new =3D bio_alloc(gfp, nr_pages);
> >
> >       if (bio) {
> > -             bio_chain(bio, new);
> > +             bio_chain(new, bio);
> >               submit_bio(bio);
> >       }
> >
> >
> I don't think this is correct.
> This code is submitting the original bio, and we _want_ to keep the
> newly allocated one even though the original might have been completed
> already. If we were setting the 'parent' to the original bio upper
> layers might infer that the entire request has been completed (as the
> original bio is now the 'parent' bio), which is patently not true.
>
> So, rather not.
>
> Cheers,
>
> Hannes
> --
> Dr. Hannes Reinecke                Kernel Storage Architect
> hare@suse.de                              +49 911 74053 688
> SUSE Software Solutions GmbH, Maxfeldstr. 5, 90409 N=C3=BCrnberg
> HRB 36809 (AG N=C3=BCrnberg), Gesch=C3=A4ftsf=C3=BChrer: Felix Imend=C3=
=B6rffer
