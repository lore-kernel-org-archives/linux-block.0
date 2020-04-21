Return-Path: <SRS0=KmMx=6F=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A9DA1C38A30
	for <linux-block@archiver.kernel.org>; Tue, 21 Apr 2020 01:26:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 790372070B
	for <linux-block@archiver.kernel.org>; Tue, 21 Apr 2020 01:26:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ij9bg8X+"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725958AbgDUB0D (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 20 Apr 2020 21:26:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40686 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725897AbgDUB0C (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 20 Apr 2020 21:26:02 -0400
Received: from mail-wr1-x441.google.com (mail-wr1-x441.google.com [IPv6:2a00:1450:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6201BC061A0E
        for <linux-block@vger.kernel.org>; Mon, 20 Apr 2020 18:26:02 -0700 (PDT)
Received: by mail-wr1-x441.google.com with SMTP id k1so14574391wrx.4
        for <linux-block@vger.kernel.org>; Mon, 20 Apr 2020 18:26:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=m7cRCh+T53jaOy59Eyt25q4iQmc0/XS2c6JvyLJpMqM=;
        b=Ij9bg8X+Q5LDVGIH9NP5Zrvmt7p4zzVvl2n+Kyd12Cl8pn0LSwkg40W2OE8EUK6Yc5
         4zQyKHbsemw98I+dKth0K/7Yuw3blRUoQVEigBJwL3obaWpmmM5PS6LYpwuvsDwMPZNi
         6RuuETwwwq6XJ7mR6UICXEGlR+yY2P27ccNoRT3JF/YMPduMvO06OIZuRg9txUhY3pco
         EaF8uk3qEWgvDMRzUBb5avZ+wBZMklFl02m+ehgVTIKcvP9gyxQWntxM82mYTRa2TSo9
         lQxxpibsPQhLoKVnR8fA6slZv4a8nYsdAmKk8CMoGHMCbTm70uJ9Tt8TZQxhnK4cyYaq
         L59g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=m7cRCh+T53jaOy59Eyt25q4iQmc0/XS2c6JvyLJpMqM=;
        b=jilpzrTLsIaBqe6nCaolkgO7+c8ZqBiLS96JmFR1CY69fQ5IZQfejZOOPndqb4QQtU
         YUZH251WTaGKLpQYCqFZMD4IsyRHwwxhmn8+R0AmTtIDqM1GjUI8l7vHQ1DEgf88DHMg
         m2OAZTrtSUpGlN8Eyyez8bYYt8z1EXbpxRPkSsaG1bAvRILoO9IarfTAJKAr2+ZJRRbZ
         E+owjK5c19r05jlzrwmMeIj0Gid45AuwsZza6cPZrrQie63Op14dJQGUoN1SzhRAhf7c
         Itb0Wt8WUoCdii8Ky2vSG0YkdAk1pLfq0MFBGJoG3i+JWG46/NCUg61M68GuSy/UBppx
         2qoQ==
X-Gm-Message-State: AGi0PuampxS1/fjYN4rXX7UBzjJf9V0zsJ8z01wQ9NpQSKyRwCEwJjnl
        Hdp+wwZZTasHZpdEE3iBvJUyAMMh+x1OYOjh4lQ=
X-Google-Smtp-Source: APiQypJfCTWjURCk+OU2M9jFug7AISNPKlsxBWXYpbQACoeNtil/+xo6IVr5jL9bLIxcaSQeZccAGUMTPau3iCeLXU4=
X-Received: by 2002:adf:fe45:: with SMTP id m5mr22934043wrs.124.1587432361058;
 Mon, 20 Apr 2020 18:26:01 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1586199103.git.zhangweiping@didiglobal.com>
 <9e542bceca1c467c99f114be7ab958066b8c7bf5.1586199103.git.zhangweiping@didiglobal.com>
 <a0fd4ea9-750a-92a1-11ae-a95d5f5dc74f@acm.org>
In-Reply-To: <a0fd4ea9-750a-92a1-11ae-a95d5f5dc74f@acm.org>
From:   Ming Lei <tom.leiming@gmail.com>
Date:   Tue, 21 Apr 2020 09:25:49 +0800
Message-ID: <CACVXFVMsHg=nvkopcpEhZ53PPu8o6zO2MmycWO8k0hnE68EdcA@mail.gmail.com>
Subject: Re: [PATCH v3 1/7] block: rename __blk_mq_alloc_rq_map
To:     Bart Van Assche <bvanassche@acm.org>
Cc:     Jens Axboe <axboe@kernel.dk>,
        linux-block <linux-block@vger.kernel.org>,
        Weiping Zhang <zhangweiping@didiglobal.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Tue, Apr 21, 2020 at 4:42 AM Bart Van Assche <bvanassche@acm.org> wrote:
>
> On 4/6/20 12:36 PM, Weiping Zhang wrote:
> > rename __blk_mq_alloc_rq_map to __blk_mq_alloc_rq_map_and_request,
> > actually it alloc both map and request, make function name
> > align with function.
> >
> > Signed-off-by: Weiping Zhang <zhangweiping@didiglobal.com>
> > ---
> >   block/blk-mq.c | 6 +++---
> >   1 file changed, 3 insertions(+), 3 deletions(-)
> >
> > diff --git a/block/blk-mq.c b/block/blk-mq.c
> > index f6291ceedee4..3a482ce7ed28 100644
> > --- a/block/blk-mq.c
> > +++ b/block/blk-mq.c
> > @@ -2468,7 +2468,7 @@ static void blk_mq_init_cpu_queues(struct request_queue *q,
> >       }
> >   }
> >
> > -static bool __blk_mq_alloc_rq_map(struct blk_mq_tag_set *set, int hctx_idx)
> > +static bool __blk_mq_alloc_rq_map_and_request(struct blk_mq_tag_set *set, int hctx_idx)
> >   {
> >       int ret = 0;
> >
> > @@ -2519,7 +2519,7 @@ static void blk_mq_map_swqueue(struct request_queue *q)
> >               hctx_idx = set->map[HCTX_TYPE_DEFAULT].mq_map[i];
> >               /* unmapped hw queue can be remapped after CPU topo changed */
> >               if (!set->tags[hctx_idx] &&
> > -                 !__blk_mq_alloc_rq_map(set, hctx_idx)) {
> > +                 !__blk_mq_alloc_rq_map_and_request(set, hctx_idx)) {
> >                       /*
> >                        * If tags initialization fail for some hctx,
> >                        * that hctx won't be brought online.  In this
> > @@ -2983,7 +2983,7 @@ static int __blk_mq_alloc_rq_maps(struct blk_mq_tag_set *set)
> >       int i;
> >
> >       for (i = 0; i < set->nr_hw_queues; i++)
> > -             if (!__blk_mq_alloc_rq_map(set, i))
> > +             if (!__blk_mq_alloc_rq_map_and_request(set, i))
> >                       goto out_unwind;
> >
> >       return 0;
>
> What the __blk_mq_alloc_rq_map() function allocates is a request map and
> requests. The new name is misleading because it suggests that only a
> single request is allocated instead of multiple. The name
> __blk_mq_alloc_rq_map_and_requests() is probably a better choice than
> __blk_mq_alloc_rq_map_and_request().
>
> My opinion is that the old name is clear enough. I prefer the current name.

Also putting renaming patches before actual fix patches does make more trouble
for backporting the fix to stable tree.

So please re-organize patches by fixing issues first, then following rename
stuff.

Thanks,
Ming Lei
