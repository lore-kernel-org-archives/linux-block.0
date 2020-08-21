Return-Path: <SRS0=euq6=B7=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6F13AC433E1
	for <linux-block@archiver.kernel.org>; Fri, 21 Aug 2020 22:45:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 473A3207C3
	for <linux-block@archiver.kernel.org>; Fri, 21 Aug 2020 22:45:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1598049933;
	bh=GGTBLKeFVTqDEvCLFOgY0gmU2JTRZNw4K2fiTNtF6oc=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=KoO6Huk4g8V3W6GuVJrvzNR9lWsBjvsHQWWMkRatOldzsR4U6xKXtvqXEHrKJ8X00
	 CF5HEcJCU6/Z3ikALYJvHlxKIsFx36RvKyLv6ghMLLYKbjShtl72jOP1M9koydQRDG
	 g03rlCK5HuQlb412ksgm1fpxMkKI2IZ8TcSowqcI=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726772AbgHUWpc (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 21 Aug 2020 18:45:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36654 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726358AbgHUWpc (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 21 Aug 2020 18:45:32 -0400
Received: from mail-lj1-x241.google.com (mail-lj1-x241.google.com [IPv6:2a00:1450:4864:20::241])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 14300C061573
        for <linux-block@vger.kernel.org>; Fri, 21 Aug 2020 15:45:32 -0700 (PDT)
Received: by mail-lj1-x241.google.com with SMTP id h19so3505889ljg.13
        for <linux-block@vger.kernel.org>; Fri, 21 Aug 2020 15:45:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=pgdPXVu12oC5v4ONKGsQsWpv2R/f2Ol3CcFBY4UQ5tI=;
        b=XYcqxn4Zu2HM55BSvgZP9HhEzNzK7Itg8Q5XzAY5nBvUwdoqbNLoadFb98YF3K1gVE
         RylRCyuCkBF0bJ34Ck4QWD6bh66MTUUD+HICvO8G9WIi9e612QSrCjAV7PsndF2TsC6m
         DLfxfe7Gl022lvCcTJCoJwcPEhzpvjuxX/M/w=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=pgdPXVu12oC5v4ONKGsQsWpv2R/f2Ol3CcFBY4UQ5tI=;
        b=hWPKYENUaiPVmYnv+sg+loceuKIcyMeH7QZEjAFiU2FDGeSB4PpCD56cWpwRmRLS4R
         quLkh+ZycpNCX0hafDTwr6cJd1abrFkLhq5brxVEKbxUnA3mFkoZJ7uX9lGtJOtdD+z4
         PoH56GmyLaxKNWcddjgJB5ybuMBjC68gF54KSou7tuoTic56gcq9QFWBFLENhxjyCf5G
         rdKDJuZegU/OZwEkYEytL0JM69AZiaWsEcmnsRV+Bp0tK++VQTxOpLpiYsok4gRtsR0K
         1PIDf7EByo9CemhO1MMF2YkZ2cvvB/M3b+Fdi2RITliJBjnClAI1j+TZ4MvkEmUraF9f
         8uUw==
X-Gm-Message-State: AOAM5311xmB6NMy5zKKg78ocfr41OsnS3tZoAFYzsfXOxCvUoqz5Cj+I
        JCcP0MVqAvyOkMdknqG15QJakQbWxoz3NQ==
X-Google-Smtp-Source: ABdhPJy6EfESsB3wbeLfq+253O7A0KKZ53x14d7l3fKqa5QbE9TspElnqNU6GOzzCOzvCZC7YFFbXg==
X-Received: by 2002:a05:651c:1213:: with SMTP id i19mr2470384lja.191.1598049930165;
        Fri, 21 Aug 2020 15:45:30 -0700 (PDT)
Received: from mail-lf1-f49.google.com (mail-lf1-f49.google.com. [209.85.167.49])
        by smtp.gmail.com with ESMTPSA id t16sm663759ljo.27.2020.08.21.15.45.29
        for <linux-block@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 21 Aug 2020 15:45:29 -0700 (PDT)
Received: by mail-lf1-f49.google.com with SMTP id i19so1668035lfj.8
        for <linux-block@vger.kernel.org>; Fri, 21 Aug 2020 15:45:29 -0700 (PDT)
X-Received: by 2002:ac2:58d5:: with SMTP id u21mr2338413lfo.31.1598049928911;
 Fri, 21 Aug 2020 15:45:28 -0700 (PDT)
MIME-Version: 1.0
References: <2e213354-a1f8-cdb6-0f3c-24473a2a2ef8@kernel.dk>
 <CAHk-=wiFwUUEpCQ2FDWxBFb3XSxu=+yODHGfLPncvTQa9BeP9w@mail.gmail.com> <22fc2c2f-1ab9-6c57-df94-4768a64644e9@kernel.dk>
In-Reply-To: <22fc2c2f-1ab9-6c57-df94-4768a64644e9@kernel.dk>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Fri, 21 Aug 2020 15:45:13 -0700
X-Gmail-Original-Message-ID: <CAHk-=wg=CkBbPHVOjoaFWoACzm+7jWhBBzwmsw7y0EYcmseh0Q@mail.gmail.com>
Message-ID: <CAHk-=wg=CkBbPHVOjoaFWoACzm+7jWhBBzwmsw7y0EYcmseh0Q@mail.gmail.com>
Subject: Re: [GIT PULL] Block fixes for 5.9-rc2
To:     Jens Axboe <axboe@kernel.dk>
Cc:     "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Fri, Aug 21, 2020 at 3:09 PM Jens Axboe <axboe@kernel.dk> wrote:
>
> I had to look for that, because it obviously didn't complain for me.
> Looks like it's the one in drivers/block/rnbd/rnbd-srv.c which changes
> from PTR_ERR() to using 'err' which is indeed an int.

You clearly didn't even build the patch you applied.

You can claim it's some odd uninteresting file, but then you damn well
shouldn't have applied the patch if you can't even be bothered to
compile-test it.

It really is that simple - this is not some odd configuration that has
a build problem because it's esoteric.  That file *will* warn if you
compile it. I don't think you can avoid it.

So it's literally a patch that cannot have been build-tested AT ALL.

I don't see why you even make excuses for it.

Send me the fixes part of the pull, no new features, and no untested garbage.

And no, I'm not your test build server that you send crap to and then
when I notice it was broken you try to fix it up.

So it's your choice. If you want to let it simmer in linux-next for
better testing and sending it to me for 5.10, I guess that's a choice
too.

But I'm very very fed up with people sending me stuff that they didn't
care enough to even check for warnings for. And no, I don't want to
get some minimal fixup. I want a clean tree.

                      Linus
