Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9E8A9C43461
	for <linux-block@archiver.kernel.org>; Tue, 11 May 2021 10:57:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 743AA60FEB
	for <linux-block@archiver.kernel.org>; Tue, 11 May 2021 10:57:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231530AbhEKK64 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 11 May 2021 06:58:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57346 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231597AbhEKK6s (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 11 May 2021 06:58:48 -0400
Received: from mail-vk1-xa2f.google.com (mail-vk1-xa2f.google.com [IPv6:2607:f8b0:4864:20::a2f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 341DAC06138D
        for <linux-block@vger.kernel.org>; Tue, 11 May 2021 03:57:41 -0700 (PDT)
Received: by mail-vk1-xa2f.google.com with SMTP id u205so3948513vke.10
        for <linux-block@vger.kernel.org>; Tue, 11 May 2021 03:57:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Src+3+3h0ibymDTZkXaqOGd8iBEIrlfTZTvmjldZejk=;
        b=ezXUEtlEWRFaXFXFayEb4McCrhZNZQMExlKd/oA0YxqXmvwHtJhioWNhkaKyo0TBi0
         C3rGMXuAPv2mG5l7zmJULtePhTP2eaVBfwIY1wxrlqH8D6EDlwQ1O718e7VQwdgRFTnu
         AG5JQID5NEZlHt3QqC/DsGUD+clbGlEV7C0qWZQLUlgvEJswfXwHL9NIBzCR1/f0jEN9
         Y6d0yewWeVpRxQWfrQF7iWngo+qi8wo3hQJgxgvqyslG2VkGGXHDg66SWVg2MAYg7ApO
         cfVrrjtLEhF2oS+AU53K6CDWuU89cbDkn65fixR6Ky/jQq27V5YBkK6sJxYBvicD00PM
         kXBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Src+3+3h0ibymDTZkXaqOGd8iBEIrlfTZTvmjldZejk=;
        b=IfyNeAO6vkCk1OabVvw4rhupRY0lXE1T1S+uQSmO9LOb+luOqpaIwRX04Xw7d+KMT2
         bBxWnS58izrdZsVGIiJBt7n/0xJN3L0Ci++mo19tvoI+jfIZe9vR48Kk96YyMr712eO8
         WboXShdonC29xofOFHm/SczWXBgJ3PyWvkTlvn5T1JzZQRU5vmWkXzbj++ZNB04Thwo5
         vtMcYCsDI44d0qlZYPcxwJteS4H7kSl3ZKsoyLF8WHTU1qZehF8Y0EBAwA71WadlyGbb
         Us9LyIuuW/ri0J50oxnS0uFH4wnoLHk6O5waYL+EQmzImTImCjjofdto40J/4qk1PGsG
         iK1A==
X-Gm-Message-State: AOAM532m41aDoJrWWsvpo/te9LAfbCu8b0AL2EkDcQhAtO/xDCi4scbZ
        Eo6EynyAEhMrepWpPq4rtS6ut459SxQbYe93p/kmEQ==
X-Google-Smtp-Source: ABdhPJxPjVkzKrtg8VoYUfVnvI+2BvYyDFi2MuPdbYN6B2mOt31jI9vyT27GHQoOdLJo4YiDh/dGrKgAVwU+fAo8NVc=
X-Received: by 2002:a1f:2a95:: with SMTP id q143mr21572667vkq.8.1620730660367;
 Tue, 11 May 2021 03:57:40 -0700 (PDT)
MIME-Version: 1.0
References: <20210511101359.83521-1-ulf.hansson@linaro.org> <DM6PR04MB6575686B680A115571EBB015FC539@DM6PR04MB6575.namprd04.prod.outlook.com>
In-Reply-To: <DM6PR04MB6575686B680A115571EBB015FC539@DM6PR04MB6575.namprd04.prod.outlook.com>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Tue, 11 May 2021 12:57:03 +0200
Message-ID: <CAPDyKFp3zzCLuRfwY39DgNuWnte-ti6SFaxwuDw3T5UDvXVsLQ@mail.gmail.com>
Subject: Re: [PATCH v2] mmc: core: Add support for cache ctrl for SD cards
To:     Avri Altman <Avri.Altman@wdc.com>
Cc:     "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Wolfram Sang <wsa+renesas@sang-engineering.com>,
        Shawn Lin <shawn.lin@rock-chips.com>,
        Masami Hiramatsu <masami.hiramatsu@linaro.org>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Tue, 11 May 2021 at 12:40, Avri Altman <Avri.Altman@wdc.com> wrote:
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
> > Reviewed-by: Linus Walleij <linus.walleij@linaro.org>
> > Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
> Reviewed-by: Avri Altman <avri.altman@wdc.com>

Thanks!

FYI the SD cache ctrl patches have been applied on next.

Kind regards
Uffe


>
> > ---
> >
> > Changes in v2:
> >  - Converted to use the BIT() macro for clarification, as suggested by Linus.
> >  - Reset SD_EXT_PERF_CACHE bit when cache enable fails, as suggested by
> > Avri.
> >
> > Note that:
> >  - I decided to keep the error path when failing to enable the cache. It's
> > seems more robust, as it's unclear what happens with the SD card at failure.
> > Additionally, if improvements are needed we can make it on top.
> >
> > ---
> >  drivers/mmc/core/mmc_ops.c |   1 +
> >  drivers/mmc/core/mmc_ops.h |   1 +
> >  drivers/mmc/core/sd.c      | 100
> > +++++++++++++++++++++++++++++++++++++
> >  include/linux/mmc/card.h   |   1 +
> >  4 files changed, 103 insertions(+)
> >
> > diff --git a/drivers/mmc/core/mmc_ops.c b/drivers/mmc/core/mmc_ops.c
> > index af423acc4c88..3c58f6d0f482 100644
> > --- a/drivers/mmc/core/mmc_ops.c
> > +++ b/drivers/mmc/core/mmc_ops.c
> > @@ -456,6 +456,7 @@ static int mmc_busy_cb(void *cb_data, bool *busy)
> >                 err = R1_STATUS(status) ? -EIO : 0;
> >                 break;
> >         case MMC_BUSY_HPI:
> > +       case MMC_BUSY_EXTR_SINGLE:
> >                 break;
> >         default:
> >                 err = -EINVAL;
> > diff --git a/drivers/mmc/core/mmc_ops.h b/drivers/mmc/core/mmc_ops.h
> > index c3c1d9c2577e..41ab4f573a31 100644
> > --- a/drivers/mmc/core/mmc_ops.h
> > +++ b/drivers/mmc/core/mmc_ops.h
> > @@ -14,6 +14,7 @@ enum mmc_busy_cmd {
> >         MMC_BUSY_CMD6,
> >         MMC_BUSY_ERASE,
> >         MMC_BUSY_HPI,
> > +       MMC_BUSY_EXTR_SINGLE,
> >  };
> >
> >  struct mmc_host;
> > diff --git a/drivers/mmc/core/sd.c b/drivers/mmc/core/sd.c
> > index bd40c682d264..781c1e24308c 100644
> > --- a/drivers/mmc/core/sd.c
> > +++ b/drivers/mmc/core/sd.c
> > @@ -67,6 +67,7 @@ static const unsigned int sd_au_size[] = {
> >         })
> >
> >  #define SD_POWEROFF_NOTIFY_TIMEOUT_MS 2000
> > +#define SD_WRITE_EXTR_SINGLE_TIMEOUT_MS 1000
> >
> >  struct sd_busy_data {
> >         struct mmc_card *card;
> > @@ -1287,6 +1288,96 @@ static int sd_read_ext_regs(struct mmc_card
> > *card)
> >         return err;
> >  }
> >
> > +static bool sd_cache_enabled(struct mmc_host *host)
> > +{
> > +       return host->card->ext_perf.feature_enabled & SD_EXT_PERF_CACHE;
> > +}
> > +
> > +static int sd_flush_cache(struct mmc_host *host)
> > +{
> > +       struct mmc_card *card = host->card;
> > +       u8 *reg_buf, fno, page;
> > +       u16 offset;
> > +       int err;
> > +
> > +       if (!sd_cache_enabled(host))
> > +               return 0;
> > +
> > +       reg_buf = kzalloc(512, GFP_KERNEL);
> > +       if (!reg_buf)
> > +               return -ENOMEM;
> > +
> > +       /*
> > +        * Set Flush Cache at bit 0 in the performance enhancement register at
> > +        * 261 bytes offset.
> > +        */
> > +       fno = card->ext_perf.fno;
> > +       page = card->ext_perf.page;
> > +       offset = card->ext_perf.offset + 261;
> > +
> > +       err = sd_write_ext_reg(card, fno, page, offset, BIT(0));
> > +       if (err) {
> > +               pr_warn("%s: error %d writing Cache Flush bit\n",
> > +                       mmc_hostname(host), err);
> > +               goto out;
> > +       }
> > +
> > +       err = mmc_poll_for_busy(card,
> > SD_WRITE_EXTR_SINGLE_TIMEOUT_MS, false,
> > +                               MMC_BUSY_EXTR_SINGLE);
> > +       if (err)
> > +               goto out;
> > +
> > +       /*
> > +        * Read the Flush Cache bit. The card shall reset it, to confirm that
> > +        * it's has completed the flushing of the cache.
> > +        */
> > +       err = sd_read_ext_reg(card, fno, page, offset, 1, reg_buf);
> > +       if (err) {
> > +               pr_warn("%s: error %d reading Cache Flush bit\n",
> > +                       mmc_hostname(host), err);
> > +               goto out;
> > +       }
> > +
> > +       if (reg_buf[0] & BIT(0))
> > +               err = -ETIMEDOUT;
> > +out:
> > +       kfree(reg_buf);
> > +       return err;
> > +}
> > +
> > +static int sd_enable_cache(struct mmc_card *card)
> > +{
> > +       u8 *reg_buf;
> > +       int err;
> > +
> > +       card->ext_perf.feature_enabled &= ~SD_EXT_PERF_CACHE;
> > +
> > +       reg_buf = kzalloc(512, GFP_KERNEL);
> > +       if (!reg_buf)
> > +               return -ENOMEM;
> > +
> > +       /*
> > +        * Set Cache Enable at bit 0 in the performance enhancement register at
> > +        * 260 bytes offset.
> > +        */
> > +       err = sd_write_ext_reg(card, card->ext_perf.fno, card->ext_perf.page,
> > +                              card->ext_perf.offset + 260, BIT(0));
> > +       if (err) {
> > +               pr_warn("%s: error %d writing Cache Enable bit\n",
> > +                       mmc_hostname(card->host), err);
> > +               goto out;
> > +       }
> > +
> > +       err = mmc_poll_for_busy(card,
> > SD_WRITE_EXTR_SINGLE_TIMEOUT_MS, false,
> > +                               MMC_BUSY_EXTR_SINGLE);
> > +       if (!err)
> > +               card->ext_perf.feature_enabled |= SD_EXT_PERF_CACHE;
> > +
> > +out:
> > +       kfree(reg_buf);
> > +       return err;
> > +}
> > +
> >  /*
> >   * Handle the detection and initialisation of a card.
> >   *
> > @@ -1442,6 +1533,13 @@ static int mmc_sd_init_card(struct mmc_host
> > *host, u32 ocr,
> >                         goto free_card;
> >         }
> >
> > +       /* Enable internal SD cache if supported. */
> > +       if (card->ext_perf.feature_support & SD_EXT_PERF_CACHE) {
> > +               err = sd_enable_cache(card);
> > +               if (err)
> > +                       goto free_card;
> > +       }
> > +
> >         if (host->cqe_ops && !host->cqe_enabled) {
> >                 err = host->cqe_ops->cqe_enable(host, card);
> >                 if (!err) {
> > @@ -1694,6 +1792,8 @@ static const struct mmc_bus_ops mmc_sd_ops = {
> >         .alive = mmc_sd_alive,
> >         .shutdown = mmc_sd_suspend,
> >         .hw_reset = mmc_sd_hw_reset,
> > +       .cache_enabled = sd_cache_enabled,
> > +       .flush_cache = sd_flush_cache,
> >  };
> >
> >  /*
> > diff --git a/include/linux/mmc/card.h b/include/linux/mmc/card.h
> > index 2867af0635f8..74e6c0624d27 100644
> > --- a/include/linux/mmc/card.h
> > +++ b/include/linux/mmc/card.h
> > @@ -196,6 +196,7 @@ struct sd_ext_reg {
> >         u8                      page;
> >         u16                     offset;
> >         u8                      rev;
> > +       u8                      feature_enabled;
> >         u8                      feature_support;
> >  /* Power Management Function. */
> >  #define SD_EXT_POWER_OFF_NOTIFY        (1<<0)
> > --
> > 2.25.1
>
