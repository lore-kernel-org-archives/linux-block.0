Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 668FDC433EF
	for <linux-block@archiver.kernel.org>; Tue, 19 Oct 2021 00:42:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 45CE26103B
	for <linux-block@archiver.kernel.org>; Tue, 19 Oct 2021 00:42:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229730AbhJSAou (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 18 Oct 2021 20:44:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46804 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229677AbhJSAot (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 18 Oct 2021 20:44:49 -0400
Received: from mail-ed1-x531.google.com (mail-ed1-x531.google.com [IPv6:2a00:1450:4864:20::531])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A5631C06161C;
        Mon, 18 Oct 2021 17:42:37 -0700 (PDT)
Received: by mail-ed1-x531.google.com with SMTP id d3so6161299edp.3;
        Mon, 18 Oct 2021 17:42:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=GjGwQdVktjvV+tWzHSaef8ArATDvoXaYyDl0Pgr4guA=;
        b=L+aFB+B0AngW4r127wUHLfqy0+T4gzGP4tJtEyS6dInG0/5E5sGABqESCyuVP3ZYrT
         jeGTgXAYDgvo8lGTfLnr97R1Oo422zr1BPEntqz5OqMXowfqNEBNXPKVrGUQteIcmBFa
         hvAaUq/3U2bSp6X/MxrOMz8PRZgMVTCGHz1Hnqf4h/nlbqgBQPRXuYvsnuO3Na58k3yK
         DRJzNjd1xwVA6c4DAcW9NRSIE5rc5r6qCCZhjJSvhEEJccN2uBlOOSMosuTcqVkId3Ye
         1LbUKkGzx8rz5AkwvP8Go2dGkiU6/wmVOc0thW6zVmd2ki0EgzL60RwYz4ohNBHw4fDi
         LpgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=GjGwQdVktjvV+tWzHSaef8ArATDvoXaYyDl0Pgr4guA=;
        b=INro6zd0rWkZ4QAYV8t1ct3mcIBOsHM8TCk0XNe1uQJB4C8T+CLyj3jAtlEpa+cMbF
         BlTHPtQXhUYSDHk3HaUm4K9MS/A62Jr7/VddL1Jhb3814F10H8HlKhPMkzhRCXePRueN
         MigJq790iLQ+vg2M3NVF8wN5GMuJKdP1AGlh3OO3Ce6eNnYb28KT6bzwlSjrnygKfTr6
         ixzCj9ml3XXnCIXhzWhAuxr7eO/nWK6Sua9P5i8/fduOR+tZREoI+hPiP2Z5laLb6g4A
         f0MYaDSGunL1dMwmqweuFhlw4sF+RMbrVrnX5zDcuDzo06VZDJ6K5jGLn3b41kW4GClA
         1xfg==
X-Gm-Message-State: AOAM533+rH0J+oig5VBnW8DjaaTBZgmbWVZci4kqlRlMi/KOQryEdPKf
        xDIjjwh8r2dwMXxrIuPnn69n4TwbWj6k7ra+4p5F6kr8
X-Google-Smtp-Source: ABdhPJylfhSozLyajUhY7dIebgi7QaiCYTHSE9IYOFxf85SO+zlPhbCjljdBGdYFJTVJWzaj9DYlguLmpyY5oNIN3O0=
X-Received: by 2002:a17:907:d01:: with SMTP id gn1mr8424587ejc.187.1634604156306;
 Mon, 18 Oct 2021 17:42:36 -0700 (PDT)
MIME-Version: 1.0
References: <20211018222157.12238-1-schmitzmic@gmail.com> <8d60483d-3cd6-5df7-8db6-7a8b9ce462e3@kernel.dk>
 <791e1173-4794-a547-2c84-112cc6627a1f@gmail.com> <859908de-0ca0-0425-1220-a3192c1e9110@kernel.dk>
In-Reply-To: <859908de-0ca0-0425-1220-a3192c1e9110@kernel.dk>
From:   Michael Schmitz <schmitzmic@gmail.com>
Date:   Tue, 19 Oct 2021 13:42:24 +1300
Message-ID: <CAOmrzkJZAAGEQFamfSb-jZNr5r0hr6jM+YoMSTCS08TtDWxcZg@mail.gmail.com>
Subject: Re: [PATCH RFC] block - ataflop.c: fix breakage introduced at blk-mq refactoring
To:     Jens Axboe <axboe@kernel.dk>
Cc:     "Linux/m68k" <linux-m68k@vger.kernel.org>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        linux-block@vger.kernel.org,
        Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Hi Jens,

On Tue, Oct 19, 2021 at 12:40 PM Jens Axboe <axboe@kernel.dk> wrote:
> >> 'last' is set if it's the last of a sequence of ->queue_rq() calls. If
> >> you just do sync IO, then last is always set, as there is no sequence.
> >> It's not hard to generate sequences, but on a floppy with basically no
> >> queue depth the most you'd ever get is 2. You could try and set:
> >>
> >> /sys/block/<dev>/queue/max_sectors_kb
> >>
> >> to 4 for example, and then do something that generates a larger than 4k
> >> write or read. Ideally that should give you more than 1.
> >
> > Thanks, tried that - that does indeed cause multiple requests queued to
> > the driver (which rejects them promptly).
> >
> > Now fails because ataflop_commit_rqs() unconditionally calls
> > finish_fdc() right after the first request started processing- and
> > promptly wipes it again.
> >
> > What is the purpose of .commit_rqs? The PC legacy floppy driver doesn't
> > use it ...
>
> You only need to care about bd->last if you have something in the driver
> that can make it cheaper to commit more than one request. An example is
> a driver that fills in requests, and then has an operation to ring the
> submission doorbell to flush them out. The latter is what ->commit_rqs
> is for.

OK, that's indeed a no-op for our floppy driver, which can queue
exactly one request.

> For a floppy driver, just ignore bd->last and don't implement
> commit_rqs, I don't think we're squeezing a lot of extra efficiency out
> of it through that! Think many hundreds of thousands of IOPS or millions
> of IOPS, not a handful of IOPS or less.

I'm not averse to using bd->last to close down only after the last
request in a sequence if it can be done safely (i.e. the requests that
had been rejected are then promptly requeued). But complexity is the
enemy of maintainability, so the nice and easy fix should be enough.

I'll respin and send another version shortly.

Cheers,

    Michael
