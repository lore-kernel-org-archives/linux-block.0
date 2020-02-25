Return-Path: <SRS0=qPv+=4N=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CA4C0C35E01
	for <linux-block@archiver.kernel.org>; Tue, 25 Feb 2020 14:26:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8E31420CC7
	for <linux-block@archiver.kernel.org>; Tue, 25 Feb 2020 14:26:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="qoxHjOy/"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730719AbgBYO0y (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 25 Feb 2020 09:26:54 -0500
Received: from mail-vs1-f67.google.com ([209.85.217.67]:35751 "EHLO
        mail-vs1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730478AbgBYO0y (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 25 Feb 2020 09:26:54 -0500
Received: by mail-vs1-f67.google.com with SMTP id x123so8106285vsc.2
        for <linux-block@vger.kernel.org>; Tue, 25 Feb 2020 06:26:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=dc9mXVyInlW6eLNwpAGbHUKzj6s6l4zfLFOdqnVBf5M=;
        b=qoxHjOy/GqgzD/NTmr9stfdAfFgOFFxqtrHseCckSRfapbD8ztNi/TI6LfdhPfuDqh
         wRyW0A/z3R22Av6sYOs/oG5S6GTBj3WhCWFSEq4CehCfZOhA4uwNyfLXZOfYrdPz939X
         8Of1AwtxaR3tKdRswTDJ1RIC42BKYFfFixgxiMS9CUU6Xg7RaCZpeMgjhYqZKDJgbZ8Q
         8e24iEpuWoTQqPVMBorcg41tA44diEyCBFTJbqKqvcV6P+Ohrc3iIy3iumTshW8WFqBS
         RuYsfmWm3KyvdT53cFhgTsV9EfHKdfHszyqnlg8HN9PdnP72WGy/ITmKDZzMoragPt9E
         g1lw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=dc9mXVyInlW6eLNwpAGbHUKzj6s6l4zfLFOdqnVBf5M=;
        b=n8bN2TBcxerzb9u2i9C9JOrvTVfo0jGatLKo5RjCJCLxDRl8/VLvkJbTwsQ1ce5AlX
         Qsn63i16wpiv8zGnGkw9hXRzA/RxNMUemHVSZpoewt8X4l97xfwtt9YwL65Ppuny5rfL
         kXrLQ5wZxS0FyZfXF1mLpNuGY5CKi58Jh+fbj9ogTqXkhdT1iYqemfWvMPJ/wxEkcORm
         2d3Xkgh6McKPWDGoWc9VGDsrySl+0VTp5tnu6h2c6L806epa0tLciD3/+a6nyPZmBDOY
         GzGWZ75wqPSrIur0kxY1tvO+m3pRvwXp/JxtJflGB8IU8sWeag2DfUbLVGRY0E0fDts9
         QjRQ==
X-Gm-Message-State: APjAAAVhfaIHtf5gMgOlpbpTBRrTlvFIfhLvu7LoSCFZiAbiyu1Sj1Xc
        45KqdlfU9OT27kW1g0NiQycplnVih97jNWk91HROeg==
X-Google-Smtp-Source: APXvYqzOGPKZDkx0TUAeyXUaxQ9W2P2xwrMP0XdLMV2o4KLwTAxAdwW6k9ZHpquQwNMPJVcG7wB2vdH3XsBrqb/Q2dk=
X-Received: by 2002:a05:6102:22d6:: with SMTP id a22mr28791854vsh.191.1582640812562;
 Tue, 25 Feb 2020 06:26:52 -0800 (PST)
MIME-Version: 1.0
References: <CA+G9fYuqAQfhzF2BzHr7vMHx68bo8-jT+ob_F3eHQ3=oFjgYdg@mail.gmail.com>
 <CAPDyKFqqhxC-pmV_j8PLY-D=AbqCAbiipAAHXLpJ4N_BiYYOFw@mail.gmail.com>
 <CA+G9fYugQuAERqp3VXUFG-3QxXoF8bz7OSMh6WGSZcrGkbfDSQ@mail.gmail.com>
 <CAPDyKFo-vEO7zN_F+NqcKtnKmAo_deOZx3gYNiks3yTAQAjv-Q@mail.gmail.com>
 <a602a27a-b960-ce56-c541-3b4b95f5dce2@nvidia.com> <CAPDyKFrXQgtHa4gLaKUi_F0rs4FMBai3Y_+TcHZR_zpkb0B4QQ@mail.gmail.com>
 <6523119a-50ac-973a-d1cd-ab1569259411@nvidia.com> <f960aa98-5508-36fd-166d-7f41c7d85154@nvidia.com>
In-Reply-To: <f960aa98-5508-36fd-166d-7f41c7d85154@nvidia.com>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Tue, 25 Feb 2020 15:26:16 +0100
Message-ID: <CAPDyKFokE6x0mn+v5B9=so-SyrdTn0JBU8Mrp3Zdu6kSaCie2g@mail.gmail.com>
Subject: Re: LKFT: arm x15: mmc1: cache flush error -110
To:     Jon Hunter <jonathanh@nvidia.com>, Faiz Abbas <faiz_abbas@ti.com>
Cc:     Bitan Biswas <bbiswas@nvidia.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Naresh Kamboju <naresh.kamboju@linaro.org>,
        Jens Axboe <axboe@kernel.dk>,
        Alexei Starovoitov <ast@kernel.org>,
        linux-block <linux-block@vger.kernel.org>,
        lkft-triage@lists.linaro.org,
        open list <linux-kernel@vger.kernel.org>,
        "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
        Arnd Bergmann <arnd@arndb.de>,
        John Stultz <john.stultz@linaro.org>,
        Thierry Reding <treding@nvidia.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

+ Faiz Abbas

On Tue, 25 Feb 2020 at 12:41, Jon Hunter <jonathanh@nvidia.com> wrote:
>
>
> On 25/02/2020 10:04, Jon Hunter wrote:
>
> ...
>
> >>>   I find that from the commit the changes in mmc_flush_cache below is
> >>> the cause.
> >>>
> >>> ##
> >>> @@ -961,7 +963,8 @@ int mmc_flush_cache(struct mmc_card *card)
> >>>                          (card->ext_csd.cache_size > 0) &&
> >>>                          (card->ext_csd.cache_ctrl & 1)) {
> >>>                  err = mmc_switch(card, EXT_CSD_CMD_SET_NORMAL,
> >>> -                               EXT_CSD_FLUSH_CACHE, 1, 0);
> >>> +                                EXT_CSD_FLUSH_CACHE, 1,
> >>> +                                MMC_CACHE_FLUSH_TIMEOUT_MS);
> >
> >
> > I no longer see the issue on reverting the above hunk as Bitan suggested
> > but now I see the following (which is expected) ...
> >
> >  WARNING KERN mmc1: unspecified timeout for CMD6 - use generic
>
> For Tegra, the default timeout used when no timeout is specified for CMD6
> is 100mS. So hard-coding the following also appears to workaround the
> problem on Tegra ...

Interesting.

>
> diff --git a/drivers/mmc/core/mmc_ops.c b/drivers/mmc/core/mmc_ops.c
> index 868653bc1555..5155e0240fca 100644
> --- a/drivers/mmc/core/mmc_ops.c
> +++ b/drivers/mmc/core/mmc_ops.c
> @@ -992,7 +992,7 @@ int mmc_flush_cache(struct mmc_card *card)
>                         (card->ext_csd.cache_size > 0) &&
>                         (card->ext_csd.cache_ctrl & 1)) {
>                 err = mmc_switch(card, EXT_CSD_CMD_SET_NORMAL,
> -                                EXT_CSD_FLUSH_CACHE, 1, 0);
> +                                EXT_CSD_FLUSH_CACHE, 1, 100);
>                 if (err)
>                         pr_err("%s: cache flush error %d\n",
>                                         mmc_hostname(card->host), err);
>
> So the problem appears to be causing by the timeout being too long rather
> than not long enough.
>
> Looking more at the code, I think now that we are hitting the condition
> ...
>
> diff --git a/drivers/mmc/core/mmc_ops.c b/drivers/mmc/core/mmc_ops.c
> index 868653bc1555..feae82b1ff35 100644
> --- a/drivers/mmc/core/mmc_ops.c
> +++ b/drivers/mmc/core/mmc_ops.c
> @@ -579,8 +579,10 @@ int __mmc_switch(struct mmc_card *card, u8 set, u8 index, u8 value,
>          * the host to avoid HW busy detection, by converting to a R1 response
>          * instead of a R1B.
>          */
> -       if (host->max_busy_timeout && (timeout_ms > host->max_busy_timeout))
> +       if (host->max_busy_timeout && (timeout_ms > host->max_busy_timeout)) {
> +               pr_warn("%s: timeout (%d) > max busy timeout (%d)", mmc_hostname(host), timeout_ms, host->max_busy_timeout);
>                 use_r1b_resp = false;
> +       }
>
>
> With the above I see ...
>
>  WARNING KERN mmc1: timeout (1600) > max busy timeout (672)
>
> So with the longer timeout we are not using/requesting the response.

You are most likely correct.

However, from the core point of view, the response is still requested,
only that we don't want the driver to wait for the card to stop
signaling busy. Instead we want to deal with that via "polling" from
the core.

This is a rather worrying behaviour, as it seems like the host driver
doesn't really follow this expectations from the core point of view.
And mmc_flush_cache() is not the only case, as we have erase, bkops,
sanitize, etc. Are all these working or not really well tested?

Earlier, before my three patches, if the provided timeout_ms parameter
to __mmc_switch() was zero, which was the case for
mmc_mmc_flush_cache() - this lead to that __mmc_switch() simply
ignored validating host->max_busy_timeout, which was wrong. In any
case, this also meant that an R1B response was always used for
mmc_flush_cache(), as you also indicated above. Perhaps this is the
critical part where things can go wrong.

BTW, have you tried erase commands for sdhci tegra driver? If those
are working fine, do you have any special treatments for these?

I have looped in Faiz, as sdhci-omap seems to suffer from very similar
problems. One thing I noted for sdhci-omap, is that MMC_ERASE commands
is treated in a special manner in sdhci_omap_set_timeout(). This
indicates that there is something fishy going on.

Faiz, can you please comment on this?

Kind regards
Uffe
