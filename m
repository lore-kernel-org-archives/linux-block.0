Return-Path: <SRS0=qPv+=4N=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B40F8C35E00
	for <linux-block@archiver.kernel.org>; Tue, 25 Feb 2020 11:36:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8916820CC7
	for <linux-block@archiver.kernel.org>; Tue, 25 Feb 2020 11:36:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="kSnxeGcd"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729952AbgBYLgh (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 25 Feb 2020 06:36:37 -0500
Received: from mail-vs1-f67.google.com ([209.85.217.67]:47066 "EHLO
        mail-vs1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729574AbgBYLgf (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 25 Feb 2020 06:36:35 -0500
Received: by mail-vs1-f67.google.com with SMTP id t12so7765461vso.13
        for <linux-block@vger.kernel.org>; Tue, 25 Feb 2020 03:36:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=waQSb6stmPcnoB4eM+4hwJOeHqxIryXzXf95arFm1ZM=;
        b=kSnxeGcdCUm8c8qcQs+UjwEt2mVUY3QUveccoJK8UEHME1JecEh89chAY8hpuER069
         XUnq3TKRnjzWCvlZCYnl682fmAevkMx+E/+HV6+kWqmsTAKL+8INs2IJ8MMqJtBrgFmM
         H/dmfvsYTBUUHl3VVE0EKm0paYx3DdM1qQegFgAbBvPT7bvdjaOnnmRYxrRvtysL6vXk
         +Vmw31YY1EGlSV0OG1q9WfPR1K9EP5QVV2JfjLPNPeigRKW/V7Dbbi4tLQ6A890gJvwk
         PYBul1p+r2hp6q+Dn0qE5PlyYuM+xKEoDxWCpDRyEz4rhiEZwCm0bND8IQi8NQsqzmVE
         rvnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=waQSb6stmPcnoB4eM+4hwJOeHqxIryXzXf95arFm1ZM=;
        b=JkwZ7FWjW2HVPuXbVnJMcW7LCXD/Davs18KoNtVEuJX1jtqLS46lRy4VgRFFyUV/BB
         boyVEjaN7zlvBBfRYJRRNfQEa6Zf23DySqYQqN1XhUI0hSR9PiW85sE675ptxmFo0pwG
         BgXfGVRX2nuPESVpzv1oXYUq2F/XMd3cfISaxpuIRrz4D7WLT92r8Sug391Ox0oaX+f/
         OKqWvrPe8UEEvPbbnTp+cQE2vszO1pMjzbK8SQOOqUX9nfuo2dAAYBKOtLUHkZ3IDDzv
         Wb6iJnLWrMEBpZcPywU+JuIr13tC1ZBoFzvXOWNT/AM3lVgYl0+T7zurO55C4CjukQbq
         G0Kg==
X-Gm-Message-State: APjAAAWimmvDowbmnRbp7Wo7YAiOBzDOrKnQcb4TlyiqJHQbYNta0rdE
        WSnD/HZ0z9uCp71r7xwAjdcESioZ106xu11fVYm+ZA==
X-Google-Smtp-Source: APXvYqwnatp2kL7HBmo7cFXXOQwYTjKiSf3qt2bibPEDajZ3hf1PQp54sT0gs45xqpbdXFDSiC9ZbAlQ+ZycYfy1pJk=
X-Received: by 2002:a05:6102:757:: with SMTP id v23mr29794027vsg.35.1582630592569;
 Tue, 25 Feb 2020 03:36:32 -0800 (PST)
MIME-Version: 1.0
References: <CA+G9fYuqAQfhzF2BzHr7vMHx68bo8-jT+ob_F3eHQ3=oFjgYdg@mail.gmail.com>
 <CAPDyKFqqhxC-pmV_j8PLY-D=AbqCAbiipAAHXLpJ4N_BiYYOFw@mail.gmail.com>
 <CA+G9fYugQuAERqp3VXUFG-3QxXoF8bz7OSMh6WGSZcrGkbfDSQ@mail.gmail.com>
 <CAPDyKFo-vEO7zN_F+NqcKtnKmAo_deOZx3gYNiks3yTAQAjv-Q@mail.gmail.com>
 <a602a27a-b960-ce56-c541-3b4b95f5dce2@nvidia.com> <CAPDyKFrXQgtHa4gLaKUi_F0rs4FMBai3Y_+TcHZR_zpkb0B4QQ@mail.gmail.com>
 <6523119a-50ac-973a-d1cd-ab1569259411@nvidia.com>
In-Reply-To: <6523119a-50ac-973a-d1cd-ab1569259411@nvidia.com>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Tue, 25 Feb 2020 12:35:56 +0100
Message-ID: <CAPDyKFr5tN4Y2MqnbnuPu6YFJJ4EK2_VceUfNsDrgbgoxnJVBA@mail.gmail.com>
Subject: Re: LKFT: arm x15: mmc1: cache flush error -110
To:     Jon Hunter <jonathanh@nvidia.com>
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

On Tue, 25 Feb 2020 at 11:04, Jon Hunter <jonathanh@nvidia.com> wrote:
>
>
> On 24/02/2020 11:16, Ulf Hansson wrote:
> > + Adrian
> >
> > On Fri, 21 Feb 2020 at 20:44, Bitan Biswas <bbiswas@nvidia.com> wrote:
> >>
> >> On 2/21/20 1:48 AM, Ulf Hansson wrote:
> >>> External email: Use caution opening links or attachments
> >>>
> >>>
> >>> On Thu, 20 Feb 2020 at 18:54, Naresh Kamboju <naresh.kamboju@linaro.org> wrote:
> >>>>
> >>>> On Wed, 19 Feb 2020 at 21:54, Ulf Hansson <ulf.hansson@linaro.org> wrote:
> >>>>>
> >>>>> On Thu, 13 Feb 2020 at 16:43, Naresh Kamboju <naresh.kamboju@linaro.org> wrote:
> >>>>>>
> >>>>>
> >>>>> Try to restore the value for the cache flush timeout, by updating the
> >>>>> define MMC_CACHE_FLUSH_TIMEOUT_MS to 10 * 60 * 1000".
> >>>>
> >>>> I have increased the timeout to 10 minutes but it did not help.
> >>>> Same error found.
> >>>> [  608.679353] mmc1: Card stuck being busy! mmc_poll_for_busy
> >>>> [  608.684964] mmc1: cache flush error -110
> >>>> [  608.689005] blk_update_request: I/O error, dev mmcblk1, sector
> >>>> 4302400 op 0x1:(WRITE) flags 0x20800 phys_seg 1 prio class 0
> >>>>
> >>>> OTOH, What best i could do for my own experiment to revert all three patches and
> >>>> now the reported error gone and device mount successfully [1].
> >>>>
> >>>> List of patches reverted,
> >>>>    mmc: core: Specify timeouts for BKOPS and CACHE_FLUSH for eMMC
> >>>>    mmc: block: Use generic_cmd6_time when modifying
> >>>>      INAND_CMD38_ARG_EXT_CSD
> >>>>    mmc: core: Default to generic_cmd6_time as timeout in __mmc_switch()
>
>
> Reverting all the above also fixes the problem for me.
>
> >>   I find that from the commit the changes in mmc_flush_cache below is
> >> the cause.
> >>
> >> ##
> >> @@ -961,7 +963,8 @@ int mmc_flush_cache(struct mmc_card *card)
> >>                          (card->ext_csd.cache_size > 0) &&
> >>                          (card->ext_csd.cache_ctrl & 1)) {
> >>                  err = mmc_switch(card, EXT_CSD_CMD_SET_NORMAL,
> >> -                               EXT_CSD_FLUSH_CACHE, 1, 0);
> >> +                                EXT_CSD_FLUSH_CACHE, 1,
> >> +                                MMC_CACHE_FLUSH_TIMEOUT_MS);
>
>
> I no longer see the issue on reverting the above hunk as Bitan suggested
> but now I see the following (which is expected) ...
>
>  WARNING KERN mmc1: unspecified timeout for CMD6 - use generic
>
> > Just as a quick sanity test, please try the below patch, which
> > restores the old cache flush timeout to 10min.
> >
> > However, as I indicated above, this seems to be a problem that needs
> > to be fixed at in the host driver side. For the sdhci driver, there is
> > a bit of a tricky logic around how to deal with timeouts in
> > sdhci_send_command(). My best guess is that's where we should look
> > more closely (and I am doing that).
> >
> > From: Ulf Hansson <ulf.hansson@linaro.org>
> > Date: Mon, 24 Feb 2020 11:43:33 +0100
> > Subject: [PATCH] mmc: core: Restore busy timeout for eMMC cache flushing
> >
> > Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
> > ---
> >  drivers/mmc/core/mmc_ops.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > diff --git a/drivers/mmc/core/mmc_ops.c b/drivers/mmc/core/mmc_ops.c
> > index da425ee2d9bf..713e7dd6d028 100644
> > --- a/drivers/mmc/core/mmc_ops.c
> > +++ b/drivers/mmc/core/mmc_ops.c
> > @@ -21,7 +21,7 @@
> >
> >  #define MMC_OPS_TIMEOUT_MS             (10 * 60 * 1000) /* 10min*/
> >  #define MMC_BKOPS_TIMEOUT_MS           (120 * 1000) /* 120s */
> > -#define MMC_CACHE_FLUSH_TIMEOUT_MS     (30 * 1000) /* 30s */
> > +#define MMC_CACHE_FLUSH_TIMEOUT_MS     (10 * 60 * 1000) /* 10min */
>
> This does not fix the problem for me.

Thanks for testing and the report - the results are not surprising.

I am getting back with an update asap, just want to complete my tests
over here before I say more.

Kind regards
Uffe
