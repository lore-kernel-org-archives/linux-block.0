Return-Path: <SRS0=Dmuf=SM=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5A773C10F11
	for <linux-block@archiver.kernel.org>; Wed, 10 Apr 2019 11:43:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2400F217F4
	for <linux-block@archiver.kernel.org>; Wed, 10 Apr 2019 11:43:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="CPBnVJQ+"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729313AbfDJLn3 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 10 Apr 2019 07:43:29 -0400
Received: from mail-vs1-f68.google.com ([209.85.217.68]:39362 "EHLO
        mail-vs1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726880AbfDJLn3 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 10 Apr 2019 07:43:29 -0400
Received: by mail-vs1-f68.google.com with SMTP id g127so1144151vsd.6
        for <linux-block@vger.kernel.org>; Wed, 10 Apr 2019 04:43:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=aAYEd6KIlvjuLTeXZCynXX4LjDCCkR80aveb3LlPP8M=;
        b=CPBnVJQ+ynlDtlhw4BeSklCj+KEZG0cuxkLzfMv6Q0j66XIiiotRmmbkNLUAqIYZSH
         Ly/ZXCR993lGYs/rWhH4B2DERdCAEgUQPh2sSQ1iqk5wW8go3zYxlixdbrfU9mcp8j7T
         9/oPFuEs2SesJQEa4olmiOyP/Yzpr7yI5aF1cRDcWO50dCQrd6DqL7eq25KUc95R22tG
         dOQ0fRa2/8jULKTumLe1omIOYYLlbH9T6PCJDL/lFmlbtJx/NU8MHPEa8wGppj0HKwQp
         d3LYHCWlIhNyuXTqrrBxwLI+xcKDbCq2DICfEN1INi7yBzPsZaHUFRQNQ78kLTcB2o5r
         NevQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=aAYEd6KIlvjuLTeXZCynXX4LjDCCkR80aveb3LlPP8M=;
        b=qsejILM6mJlKNnJhD+2WGcpotamcpN+lXwjD7DRk2QoXftxmCd4FJVOMrIac+G4C9A
         DxJXtLf5dcSORziK2ECCyealjtEyUPVm3hyokwGRgd2FbU37Hvd/F3OUhsJS5jP4F84G
         4aaImXuuDmp4YH0Ehm9C6WwItbeJoFmls+3UjhAMrpSfz9OaU1XAhbkoqoIBFUdch6Mk
         AWM1B97X1sPPMRm7PL7s/jPcHkDLX84nAW07VYLQ1EEixwmY0UAXYw6m1mtGyZFsgGAs
         8J3yPw0fKSzehmObugN08OtJaRawvY0gFs4Y5FhHct1GdALNafrHtslpc4VUsKGOtIXq
         H9GQ==
X-Gm-Message-State: APjAAAWAJPbwQH5tF3nal8soPKAD3rHddaV3LeHkpcVOrm5JOgGxU4WF
        d1snijaIEaPg5OJhxOVgL08u0kotlafOzrSfHj3y4Q==
X-Google-Smtp-Source: APXvYqy9r3OIiLLt6826RD3Txamg5Ymfo8tKIHJur0Ek4YywcXuJ6iS7UJfmAPkMjqBNjHyr5fFswpNmU6mLLPFKRnA=
X-Received: by 2002:a67:7c8a:: with SMTP id x132mr23276381vsc.172.1554896608462;
 Wed, 10 Apr 2019 04:43:28 -0700 (PDT)
MIME-Version: 1.0
References: <20190408143935.9062-1-paolo.valente@linaro.org>
 <20190408143935.9062-2-paolo.valente@linaro.org> <20190408144925.GA23021@linux-x5ow.site>
 <7B68DAA9-61D9-4AE0-9FA9-05C07C7FE408@linaro.org> <20190408150430.GB23021@linux-x5ow.site>
 <df1dfe5d-c763-91c2-4aca-25d4622c4820@kernel.dk>
In-Reply-To: <df1dfe5d-c763-91c2-4aca-25d4622c4820@kernel.dk>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Wed, 10 Apr 2019 13:42:52 +0200
Message-ID: <CAPDyKFr+CKMRs7tCkVKDv-SV-8hPcGL8+cKjviymeiarao6V0w@mail.gmail.com>
Subject: Re: [PATCH 1/1] block, bfq: delete "bfq" prefix from cgroup filenames
To:     Jens Axboe <axboe@kernel.dk>
Cc:     Johannes Thumshirn <jthumshirn@suse.de>,
        Paolo Valente <paolo.valente@linaro.org>,
        linux-block <linux-block@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Mark Brown <broonie@kernel.org>,
        "'Paolo Valente' via bfq-iosched" <bfq-iosched@googlegroups.com>,
        Oleksandr Natalenko <oleksandr@natalenko.name>,
        Angelo Ruocco <angeloruocco90@gmail.com>,
        lennart@poettering.net, mkoutny@suse.cz
Content-Type: text/plain; charset="UTF-8"
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Mon, 8 Apr 2019 at 17:05, Jens Axboe <axboe@kernel.dk> wrote:
>
> On 4/8/19 9:04 AM, Johannes Thumshirn wrote:
> > [+Cc Michal ]
> > On Mon, Apr 08, 2019 at 04:54:39PM +0200, Paolo Valente wrote:
> >>
> >>
> >>> Il giorno 8 apr 2019, alle ore 16:49, Johannes Thumshirn <jthumshirn@suse.de> ha scritto:
> >>>
> >>> On Mon, Apr 08, 2019 at 04:39:35PM +0200, Paolo Valente wrote:
> >>>> From: Angelo Ruocco <angeloruocco90@gmail.com>
> >>>>
> >>>> When bfq was merged into mainline, there were two I/O schedulers that
> >>>> implemented the proportional-share policy: bfq for blk-mq and cfq for
> >>>> legacy blk. bfq's interface files in the blkio/io controller have the
> >>>> same names as cfq. But the cgroups interface doesn't allow two
> >>>> entities to use the same name for their files, so for bfq we had to
> >>>> prepend the "bfq" prefix to each of its files. However no legacy code
> >>>> uses these modified file names. This naming also causes confusion, as,
> >>>> e.g., in [1].
> >>>>
> >>>> Now cfq has gone with legacy blk, so there is no need any longer for
> >>>> these prefixes in (the never used) bfq names. In view of this fact, this
> >>>> commit removes these prefixes, thereby enabling legacy code to truly
> >>>> use the proportional share policy in blk-mq.
> >>>>
> >>>> [1] https://github.com/systemd/systemd/issues/7057
> >>>
> >>> Hmm, but isn't this a user-space facing interface and thus some sort of ABI?
> >>> Do you know what's using it and what breaks due to this conversion?
> >>>
> >>
> >> Yep, but AFAIK, the problem is exactly the opposite: nobody uses these
> >> names for the proportional-share policy, or wants to use these names.  I'm
> >> CCing Lennart too, in case he has some improbable news on this.
> >>
> >> So the idea is to align names to what people expect, possibly before
> >> more confusion arises.
> >
> > OK, crazy idea, not sure if Jens and Tejun will beat me for this, but
> > symlinks?
> >
> > This way we can a) keep the old files and b) have them point to the new (a.k.a
> > cfq style) files.
>
> I did consider that, and that would be doable. But honestly, I'm having a
> hard time seeing what issue we are attempting to fix by doing this.

Jens, didn't we actually break userspace ABI when dropping the legacy
block code and its I/O schedulers?

So, to me, it seems like introducing symlinks as suggested above,
would actually fix this "regression", wouldn't it?

Kind regards
Uffe
