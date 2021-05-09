Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 41279C433ED
	for <linux-block@archiver.kernel.org>; Sun,  9 May 2021 19:02:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 15F32613FA
	for <linux-block@archiver.kernel.org>; Sun,  9 May 2021 19:02:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229940AbhEITCq (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Sun, 9 May 2021 15:02:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60698 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229693AbhEITCp (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Sun, 9 May 2021 15:02:45 -0400
Received: from mail-lj1-x22e.google.com (mail-lj1-x22e.google.com [IPv6:2a00:1450:4864:20::22e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AA8B8C061573
        for <linux-block@vger.kernel.org>; Sun,  9 May 2021 12:01:40 -0700 (PDT)
Received: by mail-lj1-x22e.google.com with SMTP id c15so3566460ljr.7
        for <linux-block@vger.kernel.org>; Sun, 09 May 2021 12:01:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=gKQhzQ0P4XyQz90sgnwAHoDnS29R/uNtlMfJta0NT4E=;
        b=dWDqSKTe3nZml1msjJQErs0BtDMqlsiQNWe0ZBwXAzTUZ0QIbPG0MToiUvfbzYs6F0
         2SsrqFpVLZVtskz5MEennoADCCmTOqdta8BZe7PUGW/gpdO/Xmt75iQ855UIDkpwycGc
         apt1Deib0Etzm6NjIxxV3fUfaq/iBXOW92uNoATb76zFuadg49eXGSZ+fFENll38Cngo
         tBmEndDuGmXm8R4O9K8k/Dn8qoO8Spcc6OjS6WLZZMiYpozbTn7m0l8HA39rVpBrv6oG
         IEAkSNM6s01oNV4Hf/Avmirecv4vSqMlbjGFPUkRAMWtzHBpa1P/tmhfCQ8esaL1nPdX
         dWtA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=gKQhzQ0P4XyQz90sgnwAHoDnS29R/uNtlMfJta0NT4E=;
        b=LJ3QAd5f/iCJlYFO8euJgSkCN2VE52mK7bw1ekvs22bDSc+SYiiYr9Q3VlD8lwWdNm
         6+A6rbdnUMHH6lVYpVFtSCcroJ0I6tkC2JxtI1uYOqt4Wlqcx+Hq7dNQ9mrWv8usPUT3
         CDxDmM++qwcW8UvRwGB9a8LzpyppgBhw7x1aH54bjWnpXOup7lJ9tQXRp7YXuqfwNgbY
         g8/Ggwg48uYUkwsdcKrB9cq58aJj7P+ckNnG4i6NP51MFxO4MA6sAyzHp/fn/iVEwG/v
         GUWntJkoqZTuCGtza8O8RBGmCS48PXMRQ6/b3fWD/nJ/eQ7CkB8g2XikY738zxa2uzY9
         kGjQ==
X-Gm-Message-State: AOAM532d32SnnaIf0SInsYpCWA34SVhkW/LIeROyzMEys0Ol6gaIW2hu
        2WM8NxmNVA1gVZscwWqtft0Y+IuXOofEZh0hu1sI7A==
X-Google-Smtp-Source: ABdhPJyoCmWHi8Zg5PHJoV7Fv2YfnjZwSqEOiUjlpvSiMSAsck8eA1iEmA0fiSAB2taTJS7a4yULRAZ4AgkhIJP16H4=
X-Received: by 2002:a2e:889a:: with SMTP id k26mr17085100lji.438.1620586899039;
 Sun, 09 May 2021 12:01:39 -0700 (PDT)
MIME-Version: 1.0
References: <20210506145829.198823-1-ulf.hansson@linaro.org> <20210506145829.198823-3-ulf.hansson@linaro.org>
In-Reply-To: <20210506145829.198823-3-ulf.hansson@linaro.org>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Sun, 9 May 2021 21:01:27 +0200
Message-ID: <CACRpkdZ2JRapr5x2zn3ABwiGJw-8kbfG4K2oZVD0Lfr7KHG8Jw@mail.gmail.com>
Subject: Re: [PATCH 2/2] mmc: core: Add support for cache ctrl for SD cards
To:     Ulf Hansson <ulf.hansson@linaro.org>
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

On Thu, May 6, 2021 at 4:58 PM Ulf Hansson <ulf.hansson@linaro.org> wrote:

> In SD spec v6.x the SD function extension registers for performance
> enhancements were introduced. As a part of this an optional internal cache
> on the SD card, can be used to improve performance.
>
> The let the SD card use the cache, the host needs to enable it and manage
> flushing of the cache, so let's add support for this.
>
> Note that for an SD card supporting the cache it's mandatory for it, to
> also support the poweroff notification feature. According to the SD spec,
> if the cache has been enabled and a poweroff notification is sent to the
> card, that implicitly also means that the card should flush its internal
> cache. Therefore, dealing with cache flushing for REQ_OP_FLUSH block
> requests is sufficient.
>
> Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
(...)

> +       /*
> +        * Set the Flush Cache bit in the performance enhancement register at
> +        * 261 bytes offset.
> +        */
> +       fno = card->ext_perf.fno;
> +       page = card->ext_perf.page;
> +       offset = card->ext_perf.offset + 261;

261 looks a bit magic, can we add a define of some sort?
I guess it has a name in the spec?

> +       err = sd_write_ext_reg(card, fno, page, offset, 0x1);
> +       if (err) {
> +               pr_warn("%s: error %d writing Cache Flush bit\n",
> +                       mmc_hostname(host), err);
> +               goto out;
> +       }

So this offset contains a single bit.

> +       if (reg_buf[0] & 0x1)
> +               err = -ETIMEDOUT;

And that same bit is checked here.

Is it always going to be one bit only or do we want to

#include <linux/bits.h>
#define SD_CACHE_FLUSH_FLAG BIT(0)

Does it have a name in the spec we can use?

> +       /*
> +        * Set the Cache Enable bit in the performance enhancement register at
> +        * 260 bytes offset.
> +        */
> +       err = sd_write_ext_reg(card, card->ext_perf.fno, card->ext_perf.page,
> +                              card->ext_perf.offset + 260, 0x1);

Same here we want to #define 260 to something symbolic,

And here some define for BIT(0) as well. At least with BIT(0)
in the call to sd_write_ext_reg() rather than 0x1 if I can say
something.

With the above nitpicking fixed up (I trust you):
Reviewed-by: Linus Walleij <linus.walleij@linaro.org>

Yours,
Linus Walleij
