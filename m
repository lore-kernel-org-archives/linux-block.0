Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7A853C4361B
	for <linux-block@archiver.kernel.org>; Tue,  8 Dec 2020 12:47:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 29FBA23A9B
	for <linux-block@archiver.kernel.org>; Tue,  8 Dec 2020 12:47:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726825AbgLHMrX (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 8 Dec 2020 07:47:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49930 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725881AbgLHMrX (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Tue, 8 Dec 2020 07:47:23 -0500
Received: from mail-ot1-x341.google.com (mail-ot1-x341.google.com [IPv6:2607:f8b0:4864:20::341])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 281A6C061749
        for <linux-block@vger.kernel.org>; Tue,  8 Dec 2020 04:46:43 -0800 (PST)
Received: by mail-ot1-x341.google.com with SMTP id a109so70649otc.1
        for <linux-block@vger.kernel.org>; Tue, 08 Dec 2020 04:46:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=uiEdY4kwzJgKYd6pLE8na1HanLvfmF07LkwOgbKDRno=;
        b=ZQkGdXtvQvo3P5efeTQ03PZ0eYh8GRUpEFYJYyDOCjX4sLKSWhAW8iEkZwnt1lW2/c
         AR/wQ/NTf/ZeTA2KQ9EC+a7z801VYLi+y4mCF+BjQLTq6xsNp7LkFPp9ypl4KmlmfFsN
         DE7wNZfWy2GjH2JoAUiGuw9BGEoH4qN4r667ToVyBoFvI8zB85nmzWptqwyw7QwnsOFw
         cybM/oItkn95Cam5eZhLbdhUlgxI6ntfISgDy5o/rcS7dFkj7xJjgzw32c1ZHTXNx/T4
         chVIh9+OGH265YJ7Azd6VQccGG6MM7o47pA7iQsAtCf12vqmyliwXt7rAAMGZANwlESL
         N9zg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=uiEdY4kwzJgKYd6pLE8na1HanLvfmF07LkwOgbKDRno=;
        b=ZtiILIQERPU74H66ocGnCvSWQ0URXc5oHhauHzUULT7vHjnmMdPtjbRFLLafbePHTR
         DCGRRUmUS8lLg1amNx2PIWX9gtOT+aewQ+7GNjjG+Kf0rGurJrqFREp3xx2a63FzALii
         fElcYOlSEQyCB8GrJpzxmo1XCxM9BDrUaYMPRDY1YYsAyyp10/BiixYRRpYMmnvVm2sF
         khqGd6HW3rPh6mObgHgsoiLjJUe5lkNjFZZWfjUGhPJIkElCMEZBRp1eF04IOI0gGdNb
         pyAuwmanT5uYdbq/LDRVtMuT+lBzFg5GXV8jiTP1c/H4tXGtYlCn1M7kj2vbfVt9MI+V
         WGig==
X-Gm-Message-State: AOAM532cOhrfXeUkXlQiVSoJ6yYXBB7Hy/fNoueC3hL9VPHJ4XeeiGHt
        Pzd6sYL3cZH4nz+euzr7mcNP1549Fy1MAQfCINii8v1f
X-Google-Smtp-Source: ABdhPJyvWWgGX8PUPebQXzV2i44tKhC6bOh0zIKpOmXOYh1WvMTklaQsU1/nBzmZYtGaiGCiOM6z6docHQQTqh8mv9g=
X-Received: by 2002:a9d:7cc8:: with SMTP id r8mr16642060otn.233.1607431602620;
 Tue, 08 Dec 2020 04:46:42 -0800 (PST)
MIME-Version: 1.0
References: <20201206051802.1890-1-tom.ty89@gmail.com> <20201207031226.GD985419@T590>
In-Reply-To: <20201207031226.GD985419@T590>
From:   Tom Yan <tom.ty89@gmail.com>
Date:   Tue, 8 Dec 2020 20:46:31 +0800
Message-ID: <CAGnHSE=9au+u+9q-XhZeFQr04GPDTiypkgMh6mi+in4-BBRi=g@mail.gmail.com>
Subject: Re: [PATCH] block: fix bio chaining in blk_next_bio()
To:     Ming Lei <ming.lei@redhat.com>
Cc:     linux-block@vger.kernel.org, Christoph Hellwig <hch@lst.de>,
        ming.l@ssi.samsung.com, sagig@grimberg.me, axboe@fb.com,
        tom.leiming@gmail.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Are you saying that it would work either way?

On Mon, 7 Dec 2020 at 11:12, Ming Lei <ming.lei@redhat.com> wrote:
>
> On Sun, Dec 06, 2020 at 01:18:02PM +0800, Tom Yan wrote:
> > While it seems to have worked for so long, it doesn't seem right
> > that we set the new bio as the parent. bio_chain() seems to be used
> > in the other way everywhere else anyway.
> >
> > Signed-off-by: Tom Yan <tom.ty89@gmail.com>
> > ---
> >  block/blk-lib.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > diff --git a/block/blk-lib.c b/block/blk-lib.c
> > index e90614fd8d6a..918deaf5c8a4 100644
> > --- a/block/blk-lib.c
> > +++ b/block/blk-lib.c
> > @@ -15,7 +15,7 @@ struct bio *blk_next_bio(struct bio *bio, unsigned int nr_pages, gfp_t gfp)
> >       struct bio *new = bio_alloc(gfp, nr_pages);
> >
> >       if (bio) {
> > -             bio_chain(bio, new);
> > +             bio_chain(new, bio);
> >               submit_bio(bio);
> >       }
>
> This patch isn't needed. We simply wait for completion of the last issued bio, which
> .bi_end_io(submit_bio_wait_endio) is only called after all previous bios are done.
>
> And the last bio is the ancestor of the whole chained bios, which are
> submitted in the following way(order):
>
>         bio 0 ---> bio 1 ---> ... -> bio N(the last bio)
>
>
> thanks,
> Ming
>
