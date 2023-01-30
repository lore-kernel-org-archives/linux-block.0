Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3C0F8C54EED
	for <linux-block@archiver.kernel.org>; Mon, 30 Jan 2023 10:45:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231377AbjA3KpF (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 30 Jan 2023 05:45:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38540 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235963AbjA3KpF (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 30 Jan 2023 05:45:05 -0500
Received: from mail-yb1-xb30.google.com (mail-yb1-xb30.google.com [IPv6:2607:f8b0:4864:20::b30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 392DC303C0
        for <linux-block@vger.kernel.org>; Mon, 30 Jan 2023 02:45:02 -0800 (PST)
Received: by mail-yb1-xb30.google.com with SMTP id p141so13417669ybg.12
        for <linux-block@vger.kernel.org>; Mon, 30 Jan 2023 02:45:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=71XgswOr1+sZGoFqqq/sqekWXb+8lPdFnkGQ+6sDRWs=;
        b=HHtwYQLQZKO4H3ESpkSS0Toe2X0ZmQfd6n1Rig6scRX4jYa08YtNWcOmIgnoLO6xpj
         4zrOkuNbUaoErfwKvulr2O2xCzUiFxrY+CRPgmbzlICCUhapkJFOxpSyr4woqMfN7yWf
         qB9jCEKybiMPbj/1ZleTTJMfJG1e8HwDTSseYU1QePoziHf8wToe9zrt5aKuj3ibs9tQ
         8xX7ye4jfzsXwWkAim4PzrKDJ9RklqDo3rXZr2tOHLH/y4/7wkw6F0g9wvp++e3vuE0L
         9/D0sthxjO40vPv9xeSGhaTGta955VTmOfsLbxydDC8ZRVyeUEzX2fgC6kVgFAXTlg+f
         KeaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=71XgswOr1+sZGoFqqq/sqekWXb+8lPdFnkGQ+6sDRWs=;
        b=4PT1eG1w62zQVuKp2Ld4KDIVZoJe+srnw6nAvdrYw/aUp9+C0MPMRhXXk4DwThLibU
         auWHKIxtEtWsdbxRkL7TAiWnCsjXIDVJWBdNQxjcAUYylDVZ0FMapdXIxExfiUop3s0D
         rb2i91d0gx76KdC9sp/87UATwfpHX63ZKWv7h4Aq8RHIsQoloSGUHWPL7CfuLivyMh8g
         zCkIEvCkY1MCY05ZVf0WCYxdG9pIjyuAGr1K93+dnJO1v5esFklTB0SnR0c5thO7Q2oX
         jaZOu09u8iUQfRQ+psadXlfKYC1oMhS4N0AHvTPBctKepuM8EWNIwpI2iI/QEFX7qSes
         1KdQ==
X-Gm-Message-State: AO0yUKUDMDvmiFg8xZMzmIY+r0dfvyvr3nlGcCPGIXQeNmoIRvnzMadB
        4VdTjva5+8Qsz1nInCf5GDBAUq/FcbgJ9dQpcLLPzw==
X-Google-Smtp-Source: AK7set+ZuiLyMuoEEgzd+xb0t21ts7HDLfejBQTRcYsYZf7zDRmRCHmRPKMW/UdiBOqI8W2UQP3uJLPqw+VGdJKUIOI=
X-Received: by 2002:a25:d884:0:b0:80b:66c5:9fc5 with SMTP id
 p126-20020a25d884000000b0080b66c59fc5mr2825641ybg.210.1675075502014; Mon, 30
 Jan 2023 02:45:02 -0800 (PST)
MIME-Version: 1.0
References: <20230127154339.157460-1-ulf.hansson@linaro.org>
 <5743fb1b-eb4b-d169-a467-ee618bcd75f5@kernel.dk> <CAPDyKFqFrB4h21F0901nBp-mpiP70nObOrCpRA0ZRfOD_kD5ug@mail.gmail.com>
 <3ba1adc6-4fb4-036c-8eca-91f549471c49@kernel.dk>
In-Reply-To: <3ba1adc6-4fb4-036c-8eca-91f549471c49@kernel.dk>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Mon, 30 Jan 2023 11:44:51 +0100
Message-ID: <CACRpkdY8DbvSMcf00zSwm5z1v3nWKMoJ+wYL90E9iR2W2hpvCw@mail.gmail.com>
Subject: Re: [PATCH] block: Default to build the BFQ I/O scheduler
To:     Jens Axboe <axboe@kernel.dk>
Cc:     Ulf Hansson <ulf.hansson@linaro.org>, linux-block@vger.kernel.org,
        Paolo Valente <paolo.valente@linaro.org>,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Fri, Jan 27, 2023 at 9:10 PM Jens Axboe <axboe@kernel.dk> wrote:

> On 1/27/23 8:58=E2=80=AFAM, Ulf Hansson wrote:
> > On Fri, 27 Jan 2023 at 16:48, Jens Axboe <axboe@kernel.dk> wrote:
> >> On 1/27/23 8:43=E2=80=AFAM, Ulf Hansson wrote:
> >>> Today BFQ is widely used and it's also the default choice for some of=
 the
> >>> single-queue-based storage devices. Therefore, let's make it more
> >>> convenient to build it as default, along with the other I/O scheduler=
s.
> >>>
> >>> Let's also build the cgroup support for BFQ as default, as it's likel=
y that
> >>> it's wanted too, assuming CONFIG_BLK_CGROUP is also set, of course.
> >>
> >> This won't make much of a difference, when the symbols are already in
> >> the .config. So let's please not. It may be a 'y' for you by default,
> >> but for lots of others it is not. Don't impose it on folks.
> >
> > This isn't about folkz, but HW. :-)
>
> Is it everybody? No, it's a subset. Everybody adding a new driver wants
> to default to y/m, and it's almost always wrong.

This isn't about individual drivers, as I showed from the udev rules
used by Fedora/Redhat it is clearly entire subsystems and hundreds
of drivers that desire this.

Ulf can certainly decide what is best for the MMC and memstick drivers.

Thus I think it is probably best to make each subsystem that desire
BFQ imply it.

Yours,
Linus Walleij
