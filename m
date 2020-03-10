Return-Path: <SRS0=5EYj=43=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5D1B1C18E5B
	for <linux-block@archiver.kernel.org>; Tue, 10 Mar 2020 17:09:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3593521D56
	for <linux-block@archiver.kernel.org>; Tue, 10 Mar 2020 17:09:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="A53qKT0B"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726437AbgCJRJt (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 10 Mar 2020 13:09:49 -0400
Received: from mail-vk1-f170.google.com ([209.85.221.170]:38042 "EHLO
        mail-vk1-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726426AbgCJRJs (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 10 Mar 2020 13:09:48 -0400
Received: by mail-vk1-f170.google.com with SMTP id w4so3783969vkd.5
        for <linux-block@vger.kernel.org>; Tue, 10 Mar 2020 10:09:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=eprLM6zHakbwczHBnEThEr8bvFByNvpCbFpgSfdXpuY=;
        b=A53qKT0BVZ6BmdnUVoX9J37Wm7yO8T5ElQSfcxIN+Cg9BfRVcem7vnNKGRiCf+HsW0
         nAiPnQsrFs8fwwsygGdC+wQPztZ5csQuPy8fVjrewFCJD/UnvM1B2htj9b0a76Fhkk2p
         Wirnhdgxz0LHYyafVuzBE6uJsbIX5AwJWeVo8SJcpG8GkyFZXTglgjiD7UARhrR+4pdD
         ThrGByXyX8Uu/MOJvvwBQRI8O3MoLAn4r/QhRJfcmbt9tgy7oYTbvSzvKCZZfrJZeYTU
         xS550rVqcp3frAd3D2xwvPWVjeMvllJAVI81Q8kkaVdzRPmTGam70mqH1Va1b8J+zUzW
         Wfog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=eprLM6zHakbwczHBnEThEr8bvFByNvpCbFpgSfdXpuY=;
        b=jJS8vwZ7HUgmFWrr4AqEpe04dlWrfoaUADj5+/SYOj3V4LmUYpvNkx1oNdepJtbeuT
         LQfwvjUF/WfjnY/gV8H0GrAb+d8zR9zeF4jqusuYjwTafH4GyynH2vJ0rdw04bol1ib2
         ApppqFXq7vdUVKXO+j4WUeTrLVb/hxYF0pIjsN6XFOSq4b9QalHHWZRUl2049L8kIZRt
         r2d0XgKiISyFkMo8PPzYJSWbzLAjt27ppZvzZ6dBGzVt0wjdk8d53LAgbIoDF2C2ZpVY
         wbse/pT8womapaiZYlrqRz0pYIswfagdYh5kJOvx0/MTXK7ikBGMX2YmL+Tr7LBRdtqI
         mvEg==
X-Gm-Message-State: ANhLgQ0im3jFODWRDVva9d7fx3cYaFdWaoYv205qRce/vf9pwll2gAt+
        MKQIDdzA4ar9/H/OJlmp7/6FJC+NDk7PlaWa9jv4Dw==
X-Google-Smtp-Source: ADFU+vvF1lWmURkq6bP2SDIfO6y4O1XQKGlX19Ny1UioOWP+boJDE4OJbwIl9AWhwo+uuT8DqmeCsycvGgr3wlAeYas=
X-Received: by 2002:ac5:c4fc:: with SMTP id b28mr12541606vkl.101.1583860187278;
 Tue, 10 Mar 2020 10:09:47 -0700 (PDT)
MIME-Version: 1.0
References: <CA+G9fYuqAQfhzF2BzHr7vMHx68bo8-jT+ob_F3eHQ3=oFjgYdg@mail.gmail.com>
 <CAPDyKFq5NoeHEBK3sv3yOSD2+pm9FueH1gaTyPq0j7GLfa6vnA@mail.gmail.com>
 <34fd84d7-387b-b6f3-7fb3-aa490909e205@ti.com> <CAPDyKFrrO4noYqdxWL9Y8Nx75LopbDudKGMotkGbGcAF1oq==w@mail.gmail.com>
 <5e9b5646-bd48-e55b-54ee-1c2c41fc9218@nvidia.com> <CAPDyKFqpNo_4OePBR1KnJNO=kR8XEqbcsEd=icSceSdDH+Rk1Q@mail.gmail.com>
 <757853cf-987e-f6b6-9259-b4560a031692@nvidia.com> <d12fe142-7e72-ab58-33ab-17817e35096f@nvidia.com>
 <c216f131-6f83-c9c9-9d17-8d44ec06972d@nvidia.com> <87ad7586-9569-4276-044a-adb64e84ca15@nvidia.com>
 <a0962e0b-0f1d-9f32-f6e9-92f69f93167f@nvidia.com> <57ddddc2-3ee8-d867-bba0-0dd9929ba37d@nvidia.com>
 <CAPDyKFqZSd9E3+16yFsmpee2JsbRJ-DGThxx7NJHu6UE00Xi1Q@mail.gmail.com>
 <26ee7225-9483-4664-c2d7-b5cefeadcd4b@nvidia.com> <CAPDyKFqwVQDEnPNi33mc9ycTxpaT1cRLejbR3Ja4c8dha4gFRw@mail.gmail.com>
 <0301bbd5-8d4d-4a77-42c7-8a1391c2d60a@nvidia.com> <CAPDyKFp93H0=ttazofW9NMBtL5VnjB4PdkwN0FDCtWR0pMHrPA@mail.gmail.com>
 <f01b5533-124a-d978-a90a-9c9c6235fb65@nvidia.com>
In-Reply-To: <f01b5533-124a-d978-a90a-9c9c6235fb65@nvidia.com>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Tue, 10 Mar 2020 18:09:10 +0100
Message-ID: <CAPDyKFqJjsuHect-azQKO8cCoq5JJQrZ=eShsdLHq97NXgXnuQ@mail.gmail.com>
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

[...]

> >>>
> >>> I would like to get the regression fixed asap, but I also would like
> >>> to avoid reverting patches, unless really necessary. May I propose the
> >>> following two options.
> >>>
> >>> 1. Find out why polling with ->card_busy() or CMD13, for a CMD6 with
> >>> an R1 response doesn't work - and then fix that behaviour.
> >>>
> >>> 2. Set the mmc->max_busy_timeout to zero for sdhci-tegra, which makes
> >>> the core to always use R1B for CMD6 (and erase). This also means that
> >>> when the cmd->busy_timeout becomes longer than 11s, sdhci-tegra must
> >>> disable the HW busy timeout and just wait "forever".
> >>>
> >>> If you decide for 2, you can add the software timeout support on top,
> >>> but make that can be considered as a next step of an improvement,
> >>> rather than needed as fix. Note that, I believe there are some support
> >>> for software timeout already in the sdhci core, maybe you need to
> >>> tweak it a bit for your case, I don't know.
> >>>
> >>> Kind regards
> >>> Uffe
> >> Hi Uffe
> >>
> >> Will go with 2nd option and will send patches out when ready.
> > Okay, good.
> >
> >> BTW, Tegra host also supports SDHCI_QUIRK_DATA_TIMEOUT_USES_SDCLK for
> >> data timeout based on host clock when using finite mode (HW busy
> >> detection based on DATA TIMEOUT count value when cmd operation timeout
> >> is < 11s for tegra host).
> >>
> >> So, looks like we cant set host max_busy_timeout to 0 for Tegra host to
> >> force R1B during SWITCH and SLEEP_AWAKE.
> >>
> >> So, was thinking to introduce host capability MMC_CAP2_LONG_WAIT_HW_BUSY
> >> which can be used for hosts supporting long or infinite HW busy wait
> >> detection and will update mmc and mmc_ops drivers to not allow convert
> >> R1B to R1B for hosts with this capability during SLEEP_AWAKE and SWITCH.
> > That seems reasonable, it becomes probably both easier and clearer by
> > adding a new host cap.
> >
> > In any case, let me help out and cook a patch for this for the core
> > part (I leave the sdhci change to you). It may be a bit tricky,
> > especially since I have currently queued a bunch of new changes for
> > v5.7, that enables more users of mmc_poll_for_busy() in the core.
> > Maybe I need to temporarily drop them, so we can fix these problems
> > first. I will check.
> >
> > Probably, I would also name the cap MMC_CAP_HW_NEED_RSP_BUSY, as that
> > seems to be describing the common problem we have for sdhci
> > omap/tegra.
> >
> > Finally, it seems like MMC_CAP_WAIT_WHILE_BUSY should be set for
> > sdhci- tegra, so while at it, perhaps you can cook a patch for that as
> > well.
> >
> > Kind regards
> > Uffe
>
> OK, I sent v1 yesterday. Please ignore them then.

Oh, I haven't seen them. In any case, I am ignoring them.

>
> Will send out patches only for HW busy wait modes program based on cmd
> timeout and WAIT_WHILE_BUSY enabled.

Great, thanks!

Please help test the series I just posted as well, if you have the
time ofcourse.

Kind regards
Uffe
