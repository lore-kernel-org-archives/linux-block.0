Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A7287C54EED
	for <linux-block@archiver.kernel.org>; Mon, 30 Jan 2023 11:57:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235951AbjA3L5Y (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 30 Jan 2023 06:57:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53670 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236482AbjA3L5T (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 30 Jan 2023 06:57:19 -0500
Received: from mail-pl1-x62f.google.com (mail-pl1-x62f.google.com [IPv6:2607:f8b0:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9B564302BB
        for <linux-block@vger.kernel.org>; Mon, 30 Jan 2023 03:57:13 -0800 (PST)
Received: by mail-pl1-x62f.google.com with SMTP id z1so3806383plg.6
        for <linux-block@vger.kernel.org>; Mon, 30 Jan 2023 03:57:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dOw5Amet5HkRN6/jqBDs2rHk1OlhX6XHqYi2UcrRbUg=;
        b=pD/KJ9zk8Z/VmvlrgCuKM/3e4ksS8RwJpVJJJJE5SJwslPyWof4EQZ1LGJ/MGyRrSZ
         K2dDfctg7EMJlXItQ9p0Sq+zFCtE04hsHjHeDnW6/sr97Xcv1VmxiDxhOzdc8H2iHiNq
         z87shxyeLNuP2k+9LnHzaNFBhIpey/AQYLetkK4z4iPfYviE7JfVqnR3//v4idXvkBeg
         Ef/2MPnrvmk+7BIvsabaKy/WAcT+m1JJRdcgk8g32HE0A9Rtg9AykF1lywjKA1OKUAcm
         M5DATG7QDMq7PCCDM3XCXVqHQCmm0kFLBF1K3/6v5m0GSWwB52x3ymQ+zsXjKI0bkf83
         4wEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=dOw5Amet5HkRN6/jqBDs2rHk1OlhX6XHqYi2UcrRbUg=;
        b=KAxIqKjB64+SEhClKehv2FORO/qjHP5Jn0eAG2LQ2xAxWjognKXsvhR/NtQWE4laBh
         pfeyqNn2D9KidlWK5k7kagvZsN5n2Itpd0kxLg1mVU7Qj9fUZCXTK1FP1iDo/cFyYGzM
         EVav5IgIgpW17jqUpi+1Thj/gBotz1FwVN0SbVqShsALYnnUMbP/YnzOLxSRF557ehOf
         2Zg9Ue4IrTNecd8gEYlLJc4HgteoZyx+H7nFdDhnBD5NGx8BYzhwWBd6kMX4OClNHp2t
         URFUx/llmAWtv4z3ZB3WzWAee+UasGcG88Kp1RB+qbPAV80Dc75kBZ7znwI54IiVNjI2
         Q+sA==
X-Gm-Message-State: AO0yUKVRAiZPDXmF3kyzgiRYqyO/EQYMA9F29snU956rIv/WIC9/6Z0X
        st8Ey+TKePdy0455ePNGpWriSHrE/7uWvB+nJN3K5A==
X-Google-Smtp-Source: AK7set9DKUAM4jI0uZSfPQBByN/Tbgj9fznM1S4VUJIQeQf8sOdNbCBBX/oNb1S48j8DVuSlwMECYdinvCEDauTPpNA=
X-Received: by 2002:a17:90a:70cc:b0:22c:1dd5:db7 with SMTP id
 a12-20020a17090a70cc00b0022c1dd50db7mr2749087pjm.148.1675079833015; Mon, 30
 Jan 2023 03:57:13 -0800 (PST)
MIME-Version: 1.0
References: <20230127154339.157460-1-ulf.hansson@linaro.org>
 <5743fb1b-eb4b-d169-a467-ee618bcd75f5@kernel.dk> <CAPDyKFqFrB4h21F0901nBp-mpiP70nObOrCpRA0ZRfOD_kD5ug@mail.gmail.com>
 <3ba1adc6-4fb4-036c-8eca-91f549471c49@kernel.dk>
In-Reply-To: <3ba1adc6-4fb4-036c-8eca-91f549471c49@kernel.dk>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Mon, 30 Jan 2023 12:56:36 +0100
Message-ID: <CAPDyKFpZSTJozGX5wy4=ePwFO6vZPgu4p5tpML_Cz-ZYSHyb2Q@mail.gmail.com>
Subject: Re: [PATCH] block: Default to build the BFQ I/O scheduler
To:     Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org,
        Paolo Valente <paolo.valente@linaro.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Fri, 27 Jan 2023 at 21:10, Jens Axboe <axboe@kernel.dk> wrote:
>
> On 1/27/23 8:58=E2=80=AFAM, Ulf Hansson wrote:
> > On Fri, 27 Jan 2023 at 16:48, Jens Axboe <axboe@kernel.dk> wrote:
> >>
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

BFQ and I/O schedulers aren't just simple "drivers'', but common
pieces of the storage stack.

As pointed out by Linus in his other reply, instead this strives
towards getting a sensible default configuration of the kernel.

>
> > I was thinking that it makes sense for the similar reason to why kyber
> > and deadline are being built as default. Or are there any particular
> > other reasons to why we build those in as default, but not BFQ?
>
> deadline arguably makes sense as it's simple, and we should have one
> default scheduler. kyber probably does not need to be default y. But
> at least that one doesn't pull in other dependencies.

Alright, so it sounds like it's rather a matter of the code's
complexity, whether it deserves to be default y or not. No?

I would rather let all the three I/O schedulers be default y, as it
looks like that would be the best default configuration of the kernel.
But it looks like we don't agree on that.

>
> --
> Jens Axboe
>
>

Kind regards
Uffe
