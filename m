Return-Path: <SRS0=mBf9=44=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B412BC10F27
	for <linux-block@archiver.kernel.org>; Wed, 11 Mar 2020 08:35:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7AD8120828
	for <linux-block@archiver.kernel.org>; Wed, 11 Mar 2020 08:35:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Hs5aHTGN"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728593AbgCKIfA (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 11 Mar 2020 04:35:00 -0400
Received: from mail-vs1-f65.google.com ([209.85.217.65]:33405 "EHLO
        mail-vs1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728559AbgCKIfA (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 11 Mar 2020 04:35:00 -0400
Received: by mail-vs1-f65.google.com with SMTP id n27so791713vsa.0
        for <linux-block@vger.kernel.org>; Wed, 11 Mar 2020 01:34:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=6rNuWuI5vEh6quc7cKRB+pZeyoL5c6UG91ILq5XntxY=;
        b=Hs5aHTGNtrgRFRedaUQQhWTsBC+67TrVxPs6KaTiZQbJ2I7RNdwIlrL9rPKmueZ9XW
         nkHdJB5KFmSrE0I2u7BcLGnj87GfGL9sIDPo2d9CFu2r/qDTyyKGbKhr1YXejfumWJgo
         V3pDlnWbe6UzouLEFCMG8CK56HqsXNp9FpPqVy4ulTbALembsj/LXl6NzgDt4x70ijZT
         2AqgVoNMnHR3C4LYGn+uSoUP0b6+ZYF/qavgJ0Hj1enh0SOd57v6YmDaO/kk1rb5h2Zz
         OydB++ql5k4JqaWfhcY7mFadbvAJYkxj/8nQf3o7l5u9Mb2b7mDXs57e36v3tZHdVkSl
         mQPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=6rNuWuI5vEh6quc7cKRB+pZeyoL5c6UG91ILq5XntxY=;
        b=IpqDmN4SNYYnAL3PIxAE8KGT6c5xRVI0D0bXbXLIQf88mJ+qdDt90jKmjHZoV3uGqd
         JleZmg4BxcWSx+5pgH7dDz2NBn9XvRM8iog51Z6kEPHcYkkLQDvkMoSzOhPwW2ybHBaP
         keAaZNwvNA0HYB68o24YveG7Hgi0b95f/TYCJGgUy3WbNI4QyGLYP0U6RIbOz2FWa5KN
         AVoIRYFeu+NQZxfO+QfBiZ4GuoKcfrONwha5PEURKhicJJJjmX2v3ypG2D019qLBLT5b
         +kYcxLXVwPJvnoxfzM4LjmhMNkk454BFdyDcM8CBR2bOOT15KO/Zz2Ds795JEIKbao5b
         o2eQ==
X-Gm-Message-State: ANhLgQ1ZGdJLnIkuHraL3Nkk2q3jH+rjUd+m4keqdhj7Ys8KD3q9jS2d
        kt43RUE95L9LnIYbZgpDfNYl5PMlmzGtxeithiczuQ==
X-Google-Smtp-Source: ADFU+vttsT7RqdC8Qm0U36Qc9gQOGuLkAfJMgoJ5rM5UHhq3GqsbbX2zd8A9ty5Wve/g17LmGK4FKqzKyZMTarzszU8=
X-Received: by 2002:a05:6102:2051:: with SMTP id q17mr1265721vsr.165.1583915699166;
 Wed, 11 Mar 2020 01:34:59 -0700 (PDT)
MIME-Version: 1.0
References: <CA+G9fYuqAQfhzF2BzHr7vMHx68bo8-jT+ob_F3eHQ3=oFjgYdg@mail.gmail.com>
 <757853cf-987e-f6b6-9259-b4560a031692@nvidia.com> <d12fe142-7e72-ab58-33ab-17817e35096f@nvidia.com>
 <c216f131-6f83-c9c9-9d17-8d44ec06972d@nvidia.com> <87ad7586-9569-4276-044a-adb64e84ca15@nvidia.com>
 <a0962e0b-0f1d-9f32-f6e9-92f69f93167f@nvidia.com> <57ddddc2-3ee8-d867-bba0-0dd9929ba37d@nvidia.com>
 <CAPDyKFqZSd9E3+16yFsmpee2JsbRJ-DGThxx7NJHu6UE00Xi1Q@mail.gmail.com>
 <26ee7225-9483-4664-c2d7-b5cefeadcd4b@nvidia.com> <CAPDyKFqwVQDEnPNi33mc9ycTxpaT1cRLejbR3Ja4c8dha4gFRw@mail.gmail.com>
 <0301bbd5-8d4d-4a77-42c7-8a1391c2d60a@nvidia.com> <CAPDyKFp93H0=ttazofW9NMBtL5VnjB4PdkwN0FDCtWR0pMHrPA@mail.gmail.com>
 <f01b5533-124a-d978-a90a-9c9c6235fb65@nvidia.com> <CAPDyKFqJjsuHect-azQKO8cCoq5JJQrZ=eShsdLHq97NXgXnuQ@mail.gmail.com>
 <227d9f08-582e-fd79-e1dc-7695bddd162d@nvidia.com> <2456654f-2724-0b6d-8936-afa05f345344@nvidia.com>
 <df939962-2cb4-1c36-0baf-d82e3527d05a@nvidia.com> <41348c8f-6bc7-a5a3-e1ed-9143f60cbdae@nvidia.com>
In-Reply-To: <41348c8f-6bc7-a5a3-e1ed-9143f60cbdae@nvidia.com>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Wed, 11 Mar 2020 09:34:22 +0100
Message-ID: <CAPDyKFqWRGK6LCevwXQoZnRqfMkUDWNUMqbGqnqv+OopmhvBeg@mail.gmail.com>
Subject: Re: LKFT: arm x15: mmc1: cache flush error -110
To:     Sowjanya Komatineni <skomatineni@nvidia.com>
Cc:     Jon Hunter <jonathanh@nvidia.com>,
        Bitan Biswas <bbiswas@nvidia.com>,
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
        Faiz Abbas <faiz_abbas@ti.com>,
        Thierry Reding <treding@nvidia.com>,
        Anders Roxell <anders.roxell@linaro.org>,
        Kishon <kishon@ti.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Wed, 11 Mar 2020 at 01:19, Sowjanya Komatineni
<skomatineni@nvidia.com> wrote:
>
>
> On 3/10/20 4:10 PM, Sowjanya Komatineni wrote:
> >
> > On 3/10/20 2:59 PM, Sowjanya Komatineni wrote:
> >>
> >> On 3/10/20 10:27 AM, Sowjanya Komatineni wrote:
> >>>
> >>> On 3/10/20 10:09 AM, Ulf Hansson wrote:
> >>>> External email: Use caution opening links or attachments
> >>>>
> >>>>
> >>>> [...]
> >>>>
> >>>>>>>> I would like to get the regression fixed asap, but I also would
> >>>>>>>> like
> >>>>>>>> to avoid reverting patches, unless really necessary. May I
> >>>>>>>> propose the
> >>>>>>>> following two options.
> >>>>>>>>
> >>>>>>>> 1. Find out why polling with ->card_busy() or CMD13, for a CMD6
> >>>>>>>> with
> >>>>>>>> an R1 response doesn't work - and then fix that behaviour.
> >>>>>>>>
> >>>>>>>> 2. Set the mmc->max_busy_timeout to zero for sdhci-tegra, which
> >>>>>>>> makes
> >>>>>>>> the core to always use R1B for CMD6 (and erase). This also
> >>>>>>>> means that
> >>>>>>>> when the cmd->busy_timeout becomes longer than 11s, sdhci-tegra
> >>>>>>>> must
> >>>>>>>> disable the HW busy timeout and just wait "forever".
> >>>>>>>>
> >>>>>>>> If you decide for 2, you can add the software timeout support
> >>>>>>>> on top,
> >>>>>>>> but make that can be considered as a next step of an improvement,
> >>>>>>>> rather than needed as fix. Note that, I believe there are some
> >>>>>>>> support
> >>>>>>>> for software timeout already in the sdhci core, maybe you need to
> >>>>>>>> tweak it a bit for your case, I don't know.
> >>>>>>>>
> >>>>>>>> Kind regards
> >>>>>>>> Uffe
> >>>>>>> Hi Uffe
> >>>>>>>
> >>>>>>> Will go with 2nd option and will send patches out when ready.
> >>>>>> Okay, good.
> >>>>>>
> >>>>>>> BTW, Tegra host also supports
> >>>>>>> SDHCI_QUIRK_DATA_TIMEOUT_USES_SDCLK for
> >>>>>>> data timeout based on host clock when using finite mode (HW busy
> >>>>>>> detection based on DATA TIMEOUT count value when cmd operation
> >>>>>>> timeout
> >>>>>>> is < 11s for tegra host).
> >>>>>>>
> >>>>>>> So, looks like we cant set host max_busy_timeout to 0 for Tegra
> >>>>>>> host to
> >>>>>>> force R1B during SWITCH and SLEEP_AWAKE.
> >>>>>>>
> >>>>>>> So, was thinking to introduce host capability
> >>>>>>> MMC_CAP2_LONG_WAIT_HW_BUSY
> >>>>>>> which can be used for hosts supporting long or infinite HW busy
> >>>>>>> wait
> >>>>>>> detection and will update mmc and mmc_ops drivers to not allow
> >>>>>>> convert
> >>>>>>> R1B to R1B for hosts with this capability during SLEEP_AWAKE and
> >>>>>>> SWITCH.
> >>>>>> That seems reasonable, it becomes probably both easier and
> >>>>>> clearer by
> >>>>>> adding a new host cap.
> >>>>>>
> >>>>>> In any case, let me help out and cook a patch for this for the core
> >>>>>> part (I leave the sdhci change to you). It may be a bit tricky,
> >>>>>> especially since I have currently queued a bunch of new changes for
> >>>>>> v5.7, that enables more users of mmc_poll_for_busy() in the core.
> >>>>>> Maybe I need to temporarily drop them, so we can fix these problems
> >>>>>> first. I will check.
> >>>>>>
> >>>>>> Probably, I would also name the cap MMC_CAP_HW_NEED_RSP_BUSY, as
> >>>>>> that
> >>>>>> seems to be describing the common problem we have for sdhci
> >>>>>> omap/tegra.
> >>>>>>
> >>>>>> Finally, it seems like MMC_CAP_WAIT_WHILE_BUSY should be set for
> >>>>>> sdhci- tegra, so while at it, perhaps you can cook a patch for
> >>>>>> that as
> >>>>>> well.
> >>>>>>
> >>>>>> Kind regards
> >>>>>> Uffe
> >>>>> OK, I sent v1 yesterday. Please ignore them then.
> >>>> Oh, I haven't seen them. In any case, I am ignoring them.
> >>>>
> >>>>> Will send out patches only for HW busy wait modes program based on
> >>>>> cmd
> >>>>> timeout and WAIT_WHILE_BUSY enabled.
> >>>> Great, thanks!
> >>>>
> >>>> Please help test the series I just posted as well, if you have the
> >>>> time ofcourse.
> >>>>
> >>>> Kind regards
> >>>> Uffe
> >>>
> >>> Sure,
> >>>
> >>> Thanks
> >>>
> >>> Sowjanya
> >>
> >>
> >> mmc_sleep() also needs update to force R1B when host sets capability
> >> MMC_CAP_NEED_RSP_BUSY

Yes, I am on it! Thanks!

> >>
> >>
> > Tested patches and they work good.

Great, I am adding your tested-by tag then.

> >
> Sent sdhci-tegra v2 patches
>
> - includes busy wait mode programming based on cmd busy_timeout
>
> - enables MMC_CAP_WAIT_WHILE_BUSY

Sounds great, but I don't see the patches on the mailing list, nor did
they reach the mmc patchtracker.

Seems like you probably need to check your email settings when sending patches.

Kind regards
Uffe
