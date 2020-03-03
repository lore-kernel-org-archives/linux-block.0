Return-Path: <SRS0=QBb8=4U=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A79A6C3F2D7
	for <linux-block@archiver.kernel.org>; Tue,  3 Mar 2020 21:36:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6915B20CC7
	for <linux-block@archiver.kernel.org>; Tue,  3 Mar 2020 21:36:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="q6ErthXf"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732741AbgCCVgq (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 3 Mar 2020 16:36:46 -0500
Received: from mail-pl1-f196.google.com ([209.85.214.196]:44098 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731027AbgCCVgp (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Tue, 3 Mar 2020 16:36:45 -0500
Received: by mail-pl1-f196.google.com with SMTP id d9so23162plo.11
        for <linux-block@vger.kernel.org>; Tue, 03 Mar 2020 13:36:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ymqoP/ndX/9mJ+CBpiEkMuPr3Hb5TQeTUbKPX3cVHZI=;
        b=q6ErthXf1GgYGgZ3C2Q/uIXRPwS5His4PldwJJeIf/wXLTyWCCgIn7BgRhyjB6iHoN
         FGM2AlJc6KMLQp9UNnZFH5vswC1+Tnsey3pt72wZ4Bt8jfGQJAAMZJymQTJfo2HT4Ggn
         SOc8C+R5+bbxXnCPKUyT/TFWebPQz2TIUnpA+UwSdtibqm4xzt88e+L+hfSau3ebXmNr
         eo6VQZhZRZlm/veAqrvDhnuCkQ9m07yCdZ8eWaSXIQQDMha4hFSrjWirR3H9qyJjN7mD
         XmI2EuGoPMQIWacCsHkWRfXE8Z1vN0SqibhnaM4JKsGVenFb9Y5dcAA4Ql2af0nHGm/J
         qpAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ymqoP/ndX/9mJ+CBpiEkMuPr3Hb5TQeTUbKPX3cVHZI=;
        b=tpRM45+78Y6/LZg3u6l5zdNpEgg5jiWtJM6Rgi32994lqheqrdHgr5FU906oNC9CvE
         qo3BzAitKh3A50LTnFeT9FpOSD7ylP0jP0xKQrrKHczBNXPL+OuHk9kkUoF0p4e7Fqa/
         RK1Xa16i9SwejLSerUFWteJYuEQyAMYKuF/utnPLfhffKBH82Z6a/XHbGtMolL2b8hQP
         hZ5jRmmYrq1+8+XjoALuPYdTSRBdjvia6NUd4WBAGGEZVXaTu1bQiQQi+tkBtY91Ovgf
         nyqerJmi9F7PmRffzAuISt7We/GAfiAl1+dLVHo+LqrRSHCRmZ9iWh/T/OzKtPfRKIaf
         fuBg==
X-Gm-Message-State: ANhLgQ2cyM7iDzXCO1WJgoYWJ3aVRZj545zUxDBy/dmwY3hB0rFY9x+4
        hztKeGMmjHmCJoqvTpflqL5JoLILHZoQkrfspcgYHdoI6Zg=
X-Google-Smtp-Source: ADFU+vsDrnq2gFRKvZBn604wbp9RJXOJvMGl1ZyNsmOB1jX8Wf3qPrWNavqjMii5iBLtvcUcs/4XnGQslzLWfDMhSaE=
X-Received: by 2002:a67:800e:: with SMTP id b14mr2493925vsd.191.1583271388590;
 Tue, 03 Mar 2020 13:36:28 -0800 (PST)
MIME-Version: 1.0
References: <CA+G9fYuqAQfhzF2BzHr7vMHx68bo8-jT+ob_F3eHQ3=oFjgYdg@mail.gmail.com>
 <CAPDyKFqqhxC-pmV_j8PLY-D=AbqCAbiipAAHXLpJ4N_BiYYOFw@mail.gmail.com>
 <CA+G9fYugQuAERqp3VXUFG-3QxXoF8bz7OSMh6WGSZcrGkbfDSQ@mail.gmail.com>
 <CAPDyKFo-vEO7zN_F+NqcKtnKmAo_deOZx3gYNiks3yTAQAjv-Q@mail.gmail.com>
 <a602a27a-b960-ce56-c541-3b4b95f5dce2@nvidia.com> <CAPDyKFrXQgtHa4gLaKUi_F0rs4FMBai3Y_+TcHZR_zpkb0B4QQ@mail.gmail.com>
 <6523119a-50ac-973a-d1cd-ab1569259411@nvidia.com> <f960aa98-5508-36fd-166d-7f41c7d85154@nvidia.com>
 <CAPDyKFokE6x0mn+v5B9=so-SyrdTn0JBU8Mrp3Zdu6kSaCie2g@mail.gmail.com>
 <0963b60f-15e7-4bc6-10df-6fc8003e4d42@nvidia.com> <CAPDyKFq5NoeHEBK3sv3yOSD2+pm9FueH1gaTyPq0j7GLfa6vnA@mail.gmail.com>
 <34fd84d7-387b-b6f3-7fb3-aa490909e205@ti.com> <CAPDyKFrrO4noYqdxWL9Y8Nx75LopbDudKGMotkGbGcAF1oq==w@mail.gmail.com>
In-Reply-To: <CAPDyKFrrO4noYqdxWL9Y8Nx75LopbDudKGMotkGbGcAF1oq==w@mail.gmail.com>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Tue, 3 Mar 2020 22:35:50 +0100
Message-ID: <CAPDyKFr-ntyXv8C0FB5oq4wWe-SL_YVjpvJVykK2+7jgqY82-Q@mail.gmail.com>
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

On Mon, 2 Mar 2020 at 17:50, Ulf Hansson <ulf.hansson@linaro.org> wrote:
>
> On Mon, 2 Mar 2020 at 14:11, Faiz Abbas <faiz_abbas@ti.com> wrote:
> >
> > Uffe,
> >
> > On 26/02/20 8:51 pm, Ulf Hansson wrote:
> > > + Anders, Kishon
> > >
> > > On Tue, 25 Feb 2020 at 17:24, Jon Hunter <jonathanh@nvidia.com> wrote:
> > >>
> > >>
> > >> On 25/02/2020 14:26, Ulf Hansson wrote:
> > >>
> > >> ...
> > >>
> > >>> However, from the core point of view, the response is still requested,
> > >>> only that we don't want the driver to wait for the card to stop
> > >>> signaling busy. Instead we want to deal with that via "polling" from
> > >>> the core.
> > >>>
> > >>> This is a rather worrying behaviour, as it seems like the host driver
> > >>> doesn't really follow this expectations from the core point of view.
> > >>> And mmc_flush_cache() is not the only case, as we have erase, bkops,
> > >>> sanitize, etc. Are all these working or not really well tested?
> > >>
> > >> I don't believe that they are well tested. We have a simple test to
> > >> mount an eMMC partition, create a file, check the contents, remove the
> > >> file and unmount. The timeouts always occur during unmounting.
> > >>
> > >>> Earlier, before my three patches, if the provided timeout_ms parameter
> > >>> to __mmc_switch() was zero, which was the case for
> > >>> mmc_mmc_flush_cache() - this lead to that __mmc_switch() simply
> > >>> ignored validating host->max_busy_timeout, which was wrong. In any
> > >>> case, this also meant that an R1B response was always used for
> > >>> mmc_flush_cache(), as you also indicated above. Perhaps this is the
> > >>> critical part where things can go wrong.
> > >>>
> > >>> BTW, have you tried erase commands for sdhci tegra driver? If those
> > >>> are working fine, do you have any special treatments for these?
> > >>
> > >> That I am not sure, but I will check.
> > >
> > > Great, thanks. Looking forward to your report.
> > >
> > > So, from my side, me and Anders Roxell, have been collaborating on
> > > testing the behaviour on a TI Beagleboard x15 (remotely with limited
> > > debug options), which is using the sdhci-omap variant. I am trying to
> > > get hold of an Nvidia jetson-TX2, but not found one yet. These are the
> > > conclusions from the observed behaviour on the Beagleboard for the
> > > CMD6 cache flush command.
> > >
> > > First, the reported host->max_busy_timeout is 2581 (ms) for the
> > > sdhci-omap driver in this configuration.
> > >
> > > 1. As we all know by now, the cache flush command (CMD6) fails with
> > > -110 currently. This is when MMC_CACHE_FLUSH_TIMEOUT_MS is set to 30 *
> > > 1000 (30s), which means __mmc_switch() drops the MMC_RSP_BUSY flag
> > > from the command.
> > >
> > > 2. Changing the MMC_CACHE_FLUSH_TIMEOUT_MS to 2000 (2s), means that
> > > the MMC_RSP_BUSY flag becomes set by __mmc_switch, because of the
> > > timeout_ms parameter is less than max_busy_timeout (2000 <  2581).
> > > Then everything works fine.
> > >
> > > 3. Updating the code to again use 30s as the
> > > MMC_CACHE_FLUSH_TIMEOUT_MS, but instead forcing the MMC_RSP_BUSY to be
> > > set, even when the timeout_ms becomes greater than max_busy_timeout.
> > > This also works fine.
> > >
> > > Clearly this indicates a problem that I think needs to be addressed in
> > > the sdhci driver. However, of course I can revert the three discussed
> > > patches to fix the problem, but that would only hide the issues and I
> > > am sure we would then get back to this issue, sooner or later.
> > >
> > > To fix the problem in the sdhci driver, I would appreciate if someone
> > > from TI and Nvidia can step in to help, as I don't have the HW on my
> > > desk.
> > >
> > > Comments or other ideas of how to move forward?
> > >
> >
> > Sorry I missed this earlier.
> >
> > I don't have an X15 with me here but I'm trying to set one up in our
> > remote farm. In the meantime, I tried to reproduce this issue on two
> > platforms (dra72-evm and am57xx-evm) and wasn't able to see the issue
> > because those eMMC's don't even have a cache. I will keep you updated
> > when I do get a board with a eMMC that has a cache.
> >
> > Is there a way to reproduce this CMD6 issue with another operation?
>
> Yes, most definitely.
>
> Let me cook a debug patch for you that should trigger the problem for
> another CMD6 operation. I will post something later this evening or in
> the mornings (Swedish timezone).

A bit later than promised, I am clearly an optimist. In any case
here's the patch I had in mind to trigger the problem for other CMD6
operations. Please give at shot and see what happens.

-------

From: Ulf Hansson <ulf.hansson@linaro.org>
Date: Tue, 3 Mar 2020 22:11:05 +0100
Subject: [PATCH] mmc: core: DEBUG: Force a long timeout for all CMD6

This is to test sdhci-omap, for example, to see what happens when using a
longer timeout. My guess is that it triggers __mmc_switch() to disable the
MMC_RSP_BUSY flag for the command. If so, it likely to make the host driver
to fail, in some way or the other.

Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
---
 drivers/mmc/core/mmc_ops.c | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/drivers/mmc/core/mmc_ops.c b/drivers/mmc/core/mmc_ops.c
index da425ee2d9bf..f0d2563961f6 100644
--- a/drivers/mmc/core/mmc_ops.c
+++ b/drivers/mmc/core/mmc_ops.c
@@ -532,6 +532,9 @@ int __mmc_switch(struct mmc_card *card, u8 set, u8
index, u8 value,

        mmc_retune_hold(host);

+       /* Force a long timeout to likely make use_r1b_resp to become false. */
+       timeout_ms = MMC_CACHE_FLUSH_TIMEOUT_MS;
+
        if (!timeout_ms) {
                pr_warn("%s: unspecified timeout for CMD6 - use generic\n",
                        mmc_hostname(host));
@@ -544,8 +547,11 @@ int __mmc_switch(struct mmc_card *card, u8 set,
u8 index, u8 value,
         * the host to avoid HW busy detection, by converting to a R1 response
         * instead of a R1B.
         */
-       if (host->max_busy_timeout && (timeout_ms > host->max_busy_timeout))
+       if (host->max_busy_timeout && (timeout_ms > host->max_busy_timeout)) {
+               pr_warn("%s:Disable MMC_RSP_BUSY. timeout_ms(%u) >
max_busy_timeout(%u)\n",
+                       mmc_hostname(host), timeout_ms, host->max_busy_timeout);
                use_r1b_resp = false;
+       }

        cmd.opcode = MMC_SWITCH;
        cmd.arg = (MMC_SWITCH_MODE_WRITE_BYTE << 24) |
-- 

Kind regards
Uffe
