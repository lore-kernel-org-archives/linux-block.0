Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BA8D5C433B4
	for <linux-block@archiver.kernel.org>; Mon, 10 May 2021 15:15:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8CA796147F
	for <linux-block@archiver.kernel.org>; Mon, 10 May 2021 15:15:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237520AbhEJPQJ (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 10 May 2021 11:16:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44946 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239224AbhEJPOU (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 10 May 2021 11:14:20 -0400
Received: from mail-lf1-x129.google.com (mail-lf1-x129.google.com [IPv6:2a00:1450:4864:20::129])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 98DE7C056740
        for <linux-block@vger.kernel.org>; Mon, 10 May 2021 07:33:01 -0700 (PDT)
Received: by mail-lf1-x129.google.com with SMTP id h4so23737071lfv.0
        for <linux-block@vger.kernel.org>; Mon, 10 May 2021 07:33:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=TD4F9oa3VitNBzFXjP4uGUFTgbLeIBvDuQfeO7iSJY8=;
        b=E/AVuCxqIjpRB0+97YiL29NgoO40mm0LemOYWr0wXSq8+huvTkRQzmYbXLpUpjnzTW
         DTd/i6sw7eW12OSeunmEp9C7EC9xGVmvUgzxnfduX/ZuXLne5SBkQqqNlhwHj9UJPEl4
         vROzCfpAZvTTkTnvLfomnlGIH3VFuxwbR5+4TlffIdAnC/KmOjV0QJ9CV5z9VviMtOgb
         QKr667wwvXurnBzzNn5Mn7mB/u4mbet24esfg81vJ6i0/da+V/svnOI3/0kuYvgJZ9wt
         2yPrxpX9mwqhNgdSRtlZONIV6fXHZW0bUjJ/N4AyJb7abtn06WELrTBGdjKBmhL+DFGH
         4T+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=TD4F9oa3VitNBzFXjP4uGUFTgbLeIBvDuQfeO7iSJY8=;
        b=c747pOj5ILcIHI77KTce/8Wdiy//Wu2ErZjYDktGWefBCqlgqPNhG6ZF6AE90oK3HO
         q4Eflxg6EAMhsa4DwOd/fQa3u42cnMOi2Ku+xgFoVXOY6/qZrPwE6Dsmu0fdeZLMiH1L
         GTjHPeXlnXAEshCRueFNQx3ViQmUZ5h4gv3J7sKeTtr0Gm7FjD4ES5IYaEvilI/qUp/C
         4qW5azHGBXfZ4iUgxsYQP3zFjSherHhKe/Yhiq4za9TpJjMP7eb2iC/JYjyQzaRScT8J
         ofqULwrH7ra9DQQyw+ky3W2inZknt0nShTdhe2W+e+reX21vjQAdzd3rjMjuk+wRcKJh
         3BtA==
X-Gm-Message-State: AOAM532kCR+nCYZLE5tIHnW5eh7sADn9Ye5nilrWqfODFxkkSNTgb4xk
        FuvhDc5/uFVYZPBOp/YIpmCv2XiNiIMuiuXRNWEN2w==
X-Google-Smtp-Source: ABdhPJwkl4uaiRO8zDucHIXDoAr9bPah/2qvkFw0x4qRgxXcIfiLsPizRjl4ovVfsUxSnLSBQKUZrYUi+VGBuItVfn0=
X-Received: by 2002:a05:6512:24b:: with SMTP id b11mr16869562lfo.486.1620657179908;
 Mon, 10 May 2021 07:32:59 -0700 (PDT)
MIME-Version: 1.0
References: <20210506145829.198823-1-ulf.hansson@linaro.org>
 <20210506145829.198823-3-ulf.hansson@linaro.org> <CACRpkdZ2JRapr5x2zn3ABwiGJw-8kbfG4K2oZVD0Lfr7KHG8Jw@mail.gmail.com>
In-Reply-To: <CACRpkdZ2JRapr5x2zn3ABwiGJw-8kbfG4K2oZVD0Lfr7KHG8Jw@mail.gmail.com>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Mon, 10 May 2021 16:32:22 +0200
Message-ID: <CAPDyKFqPhSSP1TBite3dcBd7W2x2=c-xH=_M=udzBiMs95bkjw@mail.gmail.com>
Subject: Re: [PATCH 2/2] mmc: core: Add support for cache ctrl for SD cards
To:     Linus Walleij <linus.walleij@linaro.org>
Cc:     linux-mmc <linux-mmc@vger.kernel.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Wolfram Sang <wsa+renesas@sang-engineering.com>,
        Shawn Lin <shawn.lin@rock-chips.com>,
        Avri Altman <avri.altman@wdc.com>,
        Masami Hiramatsu <masami.hiramatsu@linaro.org>,
        linux-block <linux-block@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Sun, 9 May 2021 at 21:01, Linus Walleij <linus.walleij@linaro.org> wrote:
>
> On Thu, May 6, 2021 at 4:58 PM Ulf Hansson <ulf.hansson@linaro.org> wrote:
>
> > In SD spec v6.x the SD function extension registers for performance
> > enhancements were introduced. As a part of this an optional internal cache
> > on the SD card, can be used to improve performance.
> >
> > The let the SD card use the cache, the host needs to enable it and manage
> > flushing of the cache, so let's add support for this.
> >
> > Note that for an SD card supporting the cache it's mandatory for it, to
> > also support the poweroff notification feature. According to the SD spec,
> > if the cache has been enabled and a poweroff notification is sent to the
> > card, that implicitly also means that the card should flush its internal
> > cache. Therefore, dealing with cache flushing for REQ_OP_FLUSH block
> > requests is sufficient.
> >
> > Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
> (...)
>
> > +       /*
> > +        * Set the Flush Cache bit in the performance enhancement register at
> > +        * 261 bytes offset.
> > +        */
> > +       fno = card->ext_perf.fno;
> > +       page = card->ext_perf.page;
> > +       offset = card->ext_perf.offset + 261;
>
> 261 looks a bit magic, can we add a define of some sort?

We could, but I am not sure it really improves things. At least it
would not be consistent with the way we treat other magic numbers.

I think it's better to look into this as wider cleanup instead.

> I guess it has a name in the spec?

It's called the "Power Management Setting Register".

>
> > +       err = sd_write_ext_reg(card, fno, page, offset, 0x1);
> > +       if (err) {
> > +               pr_warn("%s: error %d writing Cache Flush bit\n",
> > +                       mmc_hostname(host), err);
> > +               goto out;
> > +       }
>
> So this offset contains a single bit.
>
> > +       if (reg_buf[0] & 0x1)
> > +               err = -ETIMEDOUT;
>
> And that same bit is checked here.

Correct.

>
> Is it always going to be one bit only or do we want to
>
> #include <linux/bits.h>
> #define SD_CACHE_FLUSH_FLAG BIT(0)
>
> Does it have a name in the spec we can use?

Well, it just says "Cache Flush" bit.

It seems to be one bit always for these features. The remaining bits
in the same byte are unused/reserved.

Each feature has at least one dedicated byte, so there are no bytes
being shared between features.

>
> > +       /*
> > +        * Set the Cache Enable bit in the performance enhancement register at
> > +        * 260 bytes offset.
> > +        */
> > +       err = sd_write_ext_reg(card, card->ext_perf.fno, card->ext_perf.page,
> > +                              card->ext_perf.offset + 260, 0x1);
>
> Same here we want to #define 260 to something symbolic,
>
> And here some define for BIT(0) as well. At least with BIT(0)
> in the call to sd_write_ext_reg() rather than 0x1 if I can say
> something.

The conversion to BIT(0) in the argument is clearly an improvement. I
do that change when applying, but leave the defines for the other
magics to be considered as a future cleanup.

>
> With the above nitpicking fixed up (I trust you):
> Reviewed-by: Linus Walleij <linus.walleij@linaro.org>

Thanks!

Kind regards
Uffe
