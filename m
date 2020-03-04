Return-Path: <SRS0=k6TP=4V=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 341DDC3F2D1
	for <linux-block@archiver.kernel.org>; Wed,  4 Mar 2020 16:37:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 04F202166E
	for <linux-block@archiver.kernel.org>; Wed,  4 Mar 2020 16:37:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="b/h5yz5w"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729689AbgCDQhY (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 4 Mar 2020 11:37:24 -0500
Received: from mail-vs1-f68.google.com ([209.85.217.68]:36817 "EHLO
        mail-vs1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726764AbgCDQhY (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Wed, 4 Mar 2020 11:37:24 -0500
Received: by mail-vs1-f68.google.com with SMTP id n6so1571180vsc.3
        for <linux-block@vger.kernel.org>; Wed, 04 Mar 2020 08:37:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=hABaqSyYZLOUCpK2+i1NqdTSDdnUnv1VCEKCW00h9WI=;
        b=b/h5yz5wlSBuj4Lbv+kbPLguRwtFdV5HC/ap61En5X/K6/4YD+4zRyFLn78H9qD27V
         7GAA7Uuczidrny2Vt2luLVc9+Ex0aJ/lGNQ8tEBs+DmWPecQpoBQb9F4JV2uw2bgipSd
         CAvK4wsRbKO/d+Z9hQUQmcLpGcMtuAroXiK2hFYLHgxsa0Ifiu+7sZ7f5dG1zniuK5l+
         zPvvbaNW6IJT2P4KEmZdKgwZ2kGkOtvy8B3ZjXOvKK+D2Ptk8sh8yVy91lCEUh+rSHVp
         1UwsYKyiQMqvc89tkSoFnVWGIhC5EDiBTZ9whQR4DYCLTFMHOLW8XrXJrII2HeibgVs6
         W4NA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=hABaqSyYZLOUCpK2+i1NqdTSDdnUnv1VCEKCW00h9WI=;
        b=B1pDV4aNw3J8MjwoHqEOrLRGYMO0f0kwCQOgVcudgDACd6xBWHR5pFOJml+qmISYYe
         xTzADGVEjcaY1QJjXOtBBikDuGEri8ynU5NtcVZrg6FesvDtS6oPed5X8nKiIfSc1/zL
         3g7V/2tXR8z/2OVqanHJNwyVUDUSKpz3/B5fFmkA0gRc3+XBD2XW5S0ItKgG9DakCRpu
         xxjU6d1ho6IS+vHaCUbyOwog40PJsGfQ67fQSV8UWR6EVdlgKAU8fKOXtes3Q4nxu744
         bl37YfXR67Xu6JuVob3uS2q4278lHpd0xMz8lX5TOShXFBcJrkLNZthBkEMK1wNW7jUf
         JvcA==
X-Gm-Message-State: ANhLgQ3fUP+6YhPiuzG0O+m90h6AA3eBGAO24exy8lZlwJzgS4pkoL9s
        54aVRowWaeDVFD82z3hnhFCYugCFgfynQIgkaMpCtg==
X-Google-Smtp-Source: ADFU+vsqaKb2RoRKxPcXhxp65L9DlvDybJ++9ZBqVDK57rvpHpGbRYrYO7V96B/Jdy+fc8mQrqBMgQDJ+jef4TTwT+Y=
X-Received: by 2002:a67:7fd0:: with SMTP id a199mr2328053vsd.200.1583339842981;
 Wed, 04 Mar 2020 08:37:22 -0800 (PST)
MIME-Version: 1.0
References: <20200224231841.26550-1-digetx@gmail.com> <20200224231841.26550-4-digetx@gmail.com>
 <44c22925-a14e-96d0-1f93-1979c0c60525@wwwdotorg.org>
In-Reply-To: <44c22925-a14e-96d0-1f93-1979c0c60525@wwwdotorg.org>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Wed, 4 Mar 2020 17:36:46 +0100
Message-ID: <CAPDyKFoXnoukjH_2cM=f0DGHBHS6kVUQSYOa_5ffQppC7VOn2A@mail.gmail.com>
Subject: Re: [PATCH v1 3/3] partitions: Introduce NVIDIA Tegra Partition Table
To:     Stephen Warren <swarren@wwwdotorg.org>,
        Dmitry Osipenko <digetx@gmail.com>
Cc:     Jens Axboe <axboe@kernel.dk>,
        Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        =?UTF-8?B?TWljaGHFgiBNaXJvc8WCYXc=?= <mirq-linux@rere.qmqm.pl>,
        David Heidelberg <david@ixit.cz>,
        Peter Geis <pgwipeout@gmail.com>,
        Nicolas Chauvet <kwizart@gmail.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Billy Laws <blaws05@gmail.com>,
        linux-tegra <linux-tegra@vger.kernel.org>,
        linux-block <linux-block@vger.kernel.org>,
        Andrey Danin <danindrey@mail.ru>,
        Gilles Grandou <gilles@grandou.net>,
        Ryan Grachek <ryan@edited.us>,
        "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Tue, 25 Feb 2020 at 01:20, Stephen Warren <swarren@wwwdotorg.org> wrote:
>
> On 2/24/20 4:18 PM, Dmitry Osipenko wrote:
> > All NVIDIA Tegra devices use a special partition table format for the
> > internal storage partitioning. Most of Tegra devices have GPT partition
> > in addition to TegraPT, but some older Android consumer-grade devices do
> > not or GPT is placed in a wrong sector, and thus, the TegraPT is needed
> > in order to support these devices properly in the upstream kernel. This
> > patch adds support for NVIDIA Tegra Partition Table format that is used
> > at least by all NVIDIA Tegra20 and Tegra30 devices.
>
> > diff --git a/arch/arm/mach-tegra/tegra.c b/arch/arm/mach-tegra/tegra.c
>
> > +static void __init tegra_boot_config_table_init(void)
> > +{
> > +     void __iomem *bct_base;
> > +     u16 pt_addr, pt_size;
> > +
> > +     bct_base = IO_ADDRESS(TEGRA_IRAM_BASE) + TEGRA_IRAM_BCT_OFFSET;
>
> This shouldn't be hard-coded. IIRC, the boot ROM writes a BIT (Boot
> Information Table) to a fixed location in IRAM, and there's some value
> in the BIT that points to where the BCT is in IRAM. In practice, it
> might work out that the BCT is always at the same place in IRAM, but
> this certainly isn't guaranteed. I think there's code in U-Boot which
> extracts the BCT location from the BIT? Yes, see
> arch/arm/mach-tegra/ap.c:get_odmdata().

So, have you considered using the command line partition option,
rather than adding yet another partition scheme to the kernel?

In principle, you would let the boot loader scan for the partitions,
likely from machine specific code in U-boot. Then you append these to
the kernel command line and let block/partitions/cmdline.c scan for
it.

Kind regards
Uffe
