Return-Path: <SRS0=QOfo=4T=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AC00AC3F2CD
	for <linux-block@archiver.kernel.org>; Mon,  2 Mar 2020 16:51:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 76CFC2064A
	for <linux-block@archiver.kernel.org>; Mon,  2 Mar 2020 16:51:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="x0ReNb3Y"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727367AbgCBQvY (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 2 Mar 2020 11:51:24 -0500
Received: from mail-ua1-f67.google.com ([209.85.222.67]:45523 "EHLO
        mail-ua1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726872AbgCBQvY (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Mon, 2 Mar 2020 11:51:24 -0500
Received: by mail-ua1-f67.google.com with SMTP id q17so591669uao.12
        for <linux-block@vger.kernel.org>; Mon, 02 Mar 2020 08:51:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=FwQQQHxuz3c6VL7U4BBPixCOrvkb1+9h0SeP1AGJNyU=;
        b=x0ReNb3YU4Sguq0VaQfFbFXH0kpNCmamyKbSHMsHnjWCLKswOZajP3kZVsS4iIuPTP
         EV/thxYeCx0pzmVnY0G6ynukRR8GkHvBh0a9wq+5rgPWkbqw1aGH5erQeMcK7gVnt8lj
         SdcZrdo+KyXM7dD7+P/KC3hNHdPQl0TpJoPaR47UX1Z31aXiaU15E8lmRdJhURyJmlMx
         qS1sx5LmQB/6C0MPKqLQ3bVOvPOTt7cBhj9zuzvNYnckFu8Qd6Mpperu6t9faSHWGA/W
         sjqClCrQxfSJGGIWO/9e7weyeDQJeg6/uFpUAsmR4Ly1l92n9mcAuBFyXlARpHwuc4ho
         B/vA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=FwQQQHxuz3c6VL7U4BBPixCOrvkb1+9h0SeP1AGJNyU=;
        b=Ss1jGln6yapq/+njlkpxo6n8GL+Uw6y5sdznDJm21Lh5pw98r8iD5i0Wrc/n0QL2H9
         1+RVazDcXiju77SVILnqhIq+UhaBS8jfoSAauUwPUjBeJ3x2oN1XNPHohCMC0/pUdH7i
         TQ2C0tHfWhFJxA7cTebRcEd9X1+2DV7nixtNN3TZG1QmWYgxilidGmm7pf2Ut+y6Q9kF
         4O1pq1vwb65FEQuKMlQPTQhZmZ607kXyKl8VopRthUQQY/GYkrdrrHmFX8ExX/xPN/kT
         DCzXg47SnxQQePHwJnQllQdCZQzan7UgI9VPsifAZPB2+dgHwkkbTfD1xcqcMSMYSL+G
         5OWg==
X-Gm-Message-State: ANhLgQ12aiBXzuZumWjPfuqkVPef7wy0YaTU11af2MDTBc/utRPFVEx6
        UXKBek/ctD2HVcgOBczj7EhZ1khXRaUFhPASWNQGhg==
X-Google-Smtp-Source: ADFU+vvrmUEP7ncpThWE2+Q3Zvb4NoLX1dYm8tNxgvi/NpPadyBWiI8XbxTF/lHfu9Z/liBwGp9FJkruarN9m3rtA9k=
X-Received: by 2002:ab0:7802:: with SMTP id x2mr384034uaq.100.1583167881874;
 Mon, 02 Mar 2020 08:51:21 -0800 (PST)
MIME-Version: 1.0
References: <CA+G9fYuqAQfhzF2BzHr7vMHx68bo8-jT+ob_F3eHQ3=oFjgYdg@mail.gmail.com>
 <CAPDyKFqqhxC-pmV_j8PLY-D=AbqCAbiipAAHXLpJ4N_BiYYOFw@mail.gmail.com>
 <CA+G9fYugQuAERqp3VXUFG-3QxXoF8bz7OSMh6WGSZcrGkbfDSQ@mail.gmail.com>
 <CAPDyKFo-vEO7zN_F+NqcKtnKmAo_deOZx3gYNiks3yTAQAjv-Q@mail.gmail.com>
 <a602a27a-b960-ce56-c541-3b4b95f5dce2@nvidia.com> <CAPDyKFrXQgtHa4gLaKUi_F0rs4FMBai3Y_+TcHZR_zpkb0B4QQ@mail.gmail.com>
 <6523119a-50ac-973a-d1cd-ab1569259411@nvidia.com> <f960aa98-5508-36fd-166d-7f41c7d85154@nvidia.com>
 <CAPDyKFokE6x0mn+v5B9=so-SyrdTn0JBU8Mrp3Zdu6kSaCie2g@mail.gmail.com>
 <0963b60f-15e7-4bc6-10df-6fc8003e4d42@nvidia.com> <CAPDyKFq5NoeHEBK3sv3yOSD2+pm9FueH1gaTyPq0j7GLfa6vnA@mail.gmail.com>
 <34fd84d7-387b-b6f3-7fb3-aa490909e205@ti.com>
In-Reply-To: <34fd84d7-387b-b6f3-7fb3-aa490909e205@ti.com>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Mon, 2 Mar 2020 17:50:45 +0100
Message-ID: <CAPDyKFrrO4noYqdxWL9Y8Nx75LopbDudKGMotkGbGcAF1oq==w@mail.gmail.com>
Subject: Re: LKFT: arm x15: mmc1: cache flush error -110
To:     Faiz Abbas <faiz_abbas@ti.com>
Cc:     Jon Hunter <jonathanh@nvidia.com>,
        Bitan Biswas <bbiswas@nvidia.com>,
        Sowjanya Komatineni <skomatineni@nvidia.com>,
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
        Thierry Reding <treding@nvidia.com>,
        Anders Roxell <anders.roxell@linaro.org>,
        Kishon <kishon@ti.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Mon, 2 Mar 2020 at 14:11, Faiz Abbas <faiz_abbas@ti.com> wrote:
>
> Uffe,
>
> On 26/02/20 8:51 pm, Ulf Hansson wrote:
> > + Anders, Kishon
> >
> > On Tue, 25 Feb 2020 at 17:24, Jon Hunter <jonathanh@nvidia.com> wrote:
> >>
> >>
> >> On 25/02/2020 14:26, Ulf Hansson wrote:
> >>
> >> ...
> >>
> >>> However, from the core point of view, the response is still requested,
> >>> only that we don't want the driver to wait for the card to stop
> >>> signaling busy. Instead we want to deal with that via "polling" from
> >>> the core.
> >>>
> >>> This is a rather worrying behaviour, as it seems like the host driver
> >>> doesn't really follow this expectations from the core point of view.
> >>> And mmc_flush_cache() is not the only case, as we have erase, bkops,
> >>> sanitize, etc. Are all these working or not really well tested?
> >>
> >> I don't believe that they are well tested. We have a simple test to
> >> mount an eMMC partition, create a file, check the contents, remove the
> >> file and unmount. The timeouts always occur during unmounting.
> >>
> >>> Earlier, before my three patches, if the provided timeout_ms parameter
> >>> to __mmc_switch() was zero, which was the case for
> >>> mmc_mmc_flush_cache() - this lead to that __mmc_switch() simply
> >>> ignored validating host->max_busy_timeout, which was wrong. In any
> >>> case, this also meant that an R1B response was always used for
> >>> mmc_flush_cache(), as you also indicated above. Perhaps this is the
> >>> critical part where things can go wrong.
> >>>
> >>> BTW, have you tried erase commands for sdhci tegra driver? If those
> >>> are working fine, do you have any special treatments for these?
> >>
> >> That I am not sure, but I will check.
> >
> > Great, thanks. Looking forward to your report.
> >
> > So, from my side, me and Anders Roxell, have been collaborating on
> > testing the behaviour on a TI Beagleboard x15 (remotely with limited
> > debug options), which is using the sdhci-omap variant. I am trying to
> > get hold of an Nvidia jetson-TX2, but not found one yet. These are the
> > conclusions from the observed behaviour on the Beagleboard for the
> > CMD6 cache flush command.
> >
> > First, the reported host->max_busy_timeout is 2581 (ms) for the
> > sdhci-omap driver in this configuration.
> >
> > 1. As we all know by now, the cache flush command (CMD6) fails with
> > -110 currently. This is when MMC_CACHE_FLUSH_TIMEOUT_MS is set to 30 *
> > 1000 (30s), which means __mmc_switch() drops the MMC_RSP_BUSY flag
> > from the command.
> >
> > 2. Changing the MMC_CACHE_FLUSH_TIMEOUT_MS to 2000 (2s), means that
> > the MMC_RSP_BUSY flag becomes set by __mmc_switch, because of the
> > timeout_ms parameter is less than max_busy_timeout (2000 <  2581).
> > Then everything works fine.
> >
> > 3. Updating the code to again use 30s as the
> > MMC_CACHE_FLUSH_TIMEOUT_MS, but instead forcing the MMC_RSP_BUSY to be
> > set, even when the timeout_ms becomes greater than max_busy_timeout.
> > This also works fine.
> >
> > Clearly this indicates a problem that I think needs to be addressed in
> > the sdhci driver. However, of course I can revert the three discussed
> > patches to fix the problem, but that would only hide the issues and I
> > am sure we would then get back to this issue, sooner or later.
> >
> > To fix the problem in the sdhci driver, I would appreciate if someone
> > from TI and Nvidia can step in to help, as I don't have the HW on my
> > desk.
> >
> > Comments or other ideas of how to move forward?
> >
>
> Sorry I missed this earlier.
>
> I don't have an X15 with me here but I'm trying to set one up in our
> remote farm. In the meantime, I tried to reproduce this issue on two
> platforms (dra72-evm and am57xx-evm) and wasn't able to see the issue
> because those eMMC's don't even have a cache. I will keep you updated
> when I do get a board with a eMMC that has a cache.
>
> Is there a way to reproduce this CMD6 issue with another operation?

Yes, most definitely.

Let me cook a debug patch for you that should trigger the problem for
another CMD6 operation. I will post something later this evening or in
the mornings (Swedish timezone).

Kind regards
Uffe
