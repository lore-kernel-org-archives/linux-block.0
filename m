Return-Path: <SRS0=ZA/H=42=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 02967C18E5A
	for <linux-block@archiver.kernel.org>; Mon,  9 Mar 2020 15:57:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D13E421D7E
	for <linux-block@archiver.kernel.org>; Mon,  9 Mar 2020 15:57:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="wGb7G/oj"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726973AbgCIP5k (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 9 Mar 2020 11:57:40 -0400
Received: from mail-ua1-f65.google.com ([209.85.222.65]:34558 "EHLO
        mail-ua1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726977AbgCIP5k (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Mon, 9 Mar 2020 11:57:40 -0400
Received: by mail-ua1-f65.google.com with SMTP id g21so1119648uaj.1
        for <linux-block@vger.kernel.org>; Mon, 09 Mar 2020 08:57:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=pCRd2UEbEJTn5mfXepX9c61lhmQ/IqiJL7ywIto/CQw=;
        b=wGb7G/oj6hspozY0jRklGG9i3hdO4FwSj1vwBXsKEq7SgzsswMznpltaAZp3zoa5f6
         n/oq31BIy+k3AODVPylffydQIJtTFJMpght6yOR86WM4gDzVhsNFB8QcI1e3b3VJ9+0c
         b38AK8ylGkFmW48/4FRvjLFS9PT7+PiS1GNPK37JE+EWavPu8qqV2SbvbuUtwY6iqxjO
         onQ0dLrgFyIlJsSbVaKYfh823nESfyTZxb3aMIZDdlH0awx5q+BuJ0YE6wko3sk+NVUS
         xujcScGOmNNviQWC0MuJ+eKutyaAjz4JkNA7Cngty5jYWleivrYGioI4YGlM99SanOX9
         ET2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=pCRd2UEbEJTn5mfXepX9c61lhmQ/IqiJL7ywIto/CQw=;
        b=dC2+ygfHpNULmAjCRZctnqNjY87bOyXTlcaBS3jSB2/Ch/GUMlFEC5D89/99Zm5G4E
         HHcJKy+RGDSTyRd1ARixZmXcu969SbjxIYs2nyMW12EWefv1DXJxbWNNqtcdTwyFdiYZ
         TDNF7kP9Y/3Zxe53iBpsVwhmYmBwPAo0miWQCsnYPWjI9ug5EXe6FhSUbiLBCgmqbUIk
         tsjofsHvrjfAMVjIBsg2i2srotGXWwD6r/RhhG7lBnzGdcyixy3kVRRfmFzQNx0AqTnx
         V0ltT+B+qHHvtDgjge8a7NAEEW618RBo+nyGOFrx7wkIXcnigrqqdj6AlyBkurQXe+xU
         Y6Dw==
X-Gm-Message-State: ANhLgQ2BH38PUsWvlCABVPRXF+TmbHrn64qI5MxwHCZOTIqKFfR0MiD8
        0ODqzuE5q4H8VoQJYWUVy1FUuWueGtaVHNgaigN1cw==
X-Google-Smtp-Source: ADFU+vtFgOOCmRSQPSf7CEJwiUNA+g1wHtqy+hLf7WB6ZnEytbypnc3boO4lzqtz6KH7aUm6G/dQPc06T/1yNYg/jp8=
X-Received: by 2002:ab0:7802:: with SMTP id x2mr9482796uaq.100.1583769457230;
 Mon, 09 Mar 2020 08:57:37 -0700 (PDT)
MIME-Version: 1.0
References: <CA+G9fYuqAQfhzF2BzHr7vMHx68bo8-jT+ob_F3eHQ3=oFjgYdg@mail.gmail.com>
 <CAPDyKFokE6x0mn+v5B9=so-SyrdTn0JBU8Mrp3Zdu6kSaCie2g@mail.gmail.com>
 <0963b60f-15e7-4bc6-10df-6fc8003e4d42@nvidia.com> <CAPDyKFq5NoeHEBK3sv3yOSD2+pm9FueH1gaTyPq0j7GLfa6vnA@mail.gmail.com>
 <34fd84d7-387b-b6f3-7fb3-aa490909e205@ti.com> <CAPDyKFrrO4noYqdxWL9Y8Nx75LopbDudKGMotkGbGcAF1oq==w@mail.gmail.com>
 <5e9b5646-bd48-e55b-54ee-1c2c41fc9218@nvidia.com> <CAPDyKFqpNo_4OePBR1KnJNO=kR8XEqbcsEd=icSceSdDH+Rk1Q@mail.gmail.com>
 <757853cf-987e-f6b6-9259-b4560a031692@nvidia.com> <d12fe142-7e72-ab58-33ab-17817e35096f@nvidia.com>
 <c216f131-6f83-c9c9-9d17-8d44ec06972d@nvidia.com> <87ad7586-9569-4276-044a-adb64e84ca15@nvidia.com>
 <a0962e0b-0f1d-9f32-f6e9-92f69f93167f@nvidia.com> <57ddddc2-3ee8-d867-bba0-0dd9929ba37d@nvidia.com>
 <CAPDyKFqZSd9E3+16yFsmpee2JsbRJ-DGThxx7NJHu6UE00Xi1Q@mail.gmail.com>
 <26ee7225-9483-4664-c2d7-b5cefeadcd4b@nvidia.com> <CAPDyKFqwVQDEnPNi33mc9ycTxpaT1cRLejbR3Ja4c8dha4gFRw@mail.gmail.com>
 <a67b2831-3eff-545a-de67-102dffe4a0d9@ti.com>
In-Reply-To: <a67b2831-3eff-545a-de67-102dffe4a0d9@ti.com>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Mon, 9 Mar 2020 16:57:00 +0100
Message-ID: <CAPDyKFpDUnaZ_x=Xoj625t=t1J_+xZWmkxwK78ruELsvLi+x+g@mail.gmail.com>
Subject: Re: LKFT: arm x15: mmc1: cache flush error -110
To:     Faiz Abbas <faiz_abbas@ti.com>
Cc:     Sowjanya Komatineni <skomatineni@nvidia.com>,
        Jon Hunter <jonathanh@nvidia.com>,
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
        Thierry Reding <treding@nvidia.com>,
        Anders Roxell <anders.roxell@linaro.org>,
        Kishon <kishon@ti.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Mon, 9 Mar 2020 at 15:06, Faiz Abbas <faiz_abbas@ti.com> wrote:
>
> Uffe,
>
> On 06/03/20 4:44 pm, Ulf Hansson wrote:
> > [...]
> >
> >>>>>>>>>>>
> >>>>>>>>>>> Actually we always use R1B with CMD6 as per spec.
> >>>>>>>>>> I fully agree that R1B is preferable, but it's not against the
> >>>>>>>>>> spec to
> >>>>>>>>>> send CMD13 to poll for busy.
> >>>>>>>>>>
> >>>>>>>>>> Moreover, we need to cope with the scenario when the host has
> >>>>>>>>>> specified a maximum timeout that isn't sufficiently long enough for
> >>>>>>>>>> the requested operation. Do you have another proposal for how to
> >>>>>>>>>> manage this, but disabling MMC_RSP_BUSY?
> >>>>>>>>>>
> >>>>>>>>>> Let's assume you driver would get a R1B for the CMD6 (we force it),
> >>>>>>>>>> then what timeout would the driver be using if we would set
> >>>>>>>>>> cmd.busy_timeout to 30ms?
> >>>>>>>>>>
> >>>> Sorry didn't understood clearly. Are you asking with 30s timeout, whats
> >>>> the data timeout counter used?
> >>> Yes. It seems like it will pick the maximum, which is 11s?
> >> yes
> >
> > Okay, thanks!
> >
> >>>
> >>>> Because of above mentioned issue on our host where CMD interrupt happens
> >>>> after busy state, poll for busy returns right away as not busy.
> >>> I see.
> >>>
> >>>> So issuing CMD13 after CMD6-R1 followed by busy poll should be working.
> >>>> But weird that with small delay of 1ms or debug print before CMD13 it
> >>>> doesn't timeout and works all the time.
> >>> I have digested the information you provided in these emails. Let me
> >>> summarize it, to see if I have understood correctly.
> >>>
> >>> 1.
> >>> Your controller can't distinguish between R1 and R1B because of a
> >>> limitation in the HW. So, in both cases you need to wait for the card
> >>> to stop signal busy, before the controller can give an IRQ to notify
> >>> that the R1 response has been received. Correct?
> >>>
> >>> In this context, I am wondering if sdhci_send_command(), really
> >>> conforms to these requirements. For example, depending on if the CMD6
> >>> has MMC_RSP_BUSY or not, it may pick either SDHCI_CMD_RESP_SHORT or
> >>> SDHCI_CMD_RESP_SHORT_BUSY.
> >>>
> >>> Does this work as expected for your case?
> >> Design team re-verified internally and bug where HW waits for busy state
> >> before IRQ is only for R1B and R1 is spec compliant.
> >>
> >> So, with R1, CMD complete is generated after response received.
> >
> > Okay.
> >
> > So, the issue we see for CMD6 with R1, is a software problem that we
> > should be able to fix.
> >
> >>
> >> With R1B, CMD complete and xfer complete both are generated after
> >> response received + device busy (max timeout of 11s)
> >> DATA timeout interrupt will be asserted incase if HW busy detection fails.
> >>
> >> With R1B we may see DATA Timeout if operation takes more than max busy
> >> timeout of 11s.
> >
> > Okay, I see.
> >
> >>
> >>> 2.
> >>> Assuming my interpretation of the above is somewhat correct. Then you
> >>> always need to set a busy timeout for R1/R1B responses in the
> >>> controller. The maximum timeout seems to be 11s long. Obviously, this
> >>> isn't enough for all cases, such as cache flushing and erase, for
> >>> example. So, what can we do to support a longer timeouts than 11s?
> >>> Would it be possible to disable the HW timeout, if the requested
> >>> timeout is longer than 11s and use a SW timeout instead?
> >>>
> >>> Kind regards
> >>> Uffe
> >>
> >> For erase long operations we have register bit to enable for infinite
> >> busy wait mode where host controller would be monitoring until card is busy.
> >
> > Alright, that sounds great!
> >
> >>
> >> But so far for emmc devices we used on our platforms, we haven't seen
> >> cache flush taking more than 11s.
> >
> > I understand that 11s is probably fine to use, for most cases.
> >
> > However, it's not spec compliant, as for some operations there are
> > simply no timeout specified. BKOPS, cache flush, sanitize are cases
> > like this - and then 11s is definitely not sufficient.
> >
> >>
> >> Will get back on possibility of disabling HW timeout and using SW timeout..
> >
> > Thanks!
> >
> > I would like to get the regression fixed asap, but I also would like
> > to avoid reverting patches, unless really necessary. May I propose the
> > following two options.
> >
> > 1. Find out why polling with ->card_busy() or CMD13, for a CMD6 with
> > an R1 response doesn't work - and then fix that behaviour.
> >
> > 2. Set the mmc->max_busy_timeout to zero for sdhci-tegra, which makes
> > the core to always use R1B for CMD6 (and erase). This also means that
> > when the cmd->busy_timeout becomes longer than 11s, sdhci-tegra must
> > disable the HW busy timeout and just wait "forever".
> >
> > If you decide for 2, you can add the software timeout support on top,
> > but make that can be considered as a next step of an improvement,
> > rather than needed as fix. Note that, I believe there are some support
> > for software timeout already in the sdhci core, maybe you need to
> > tweak it a bit for your case, I don't know.
> >
>
> I was able to reproduce the issue on sdhci-omap with your patch applied.

Great, thanks for confirming!

>
> In our case, the dat0 line never comes back up when trying to send a
> CMD6 with R1. It needs an R1b to work properly. I also set

Do you know if that is because of how the driver manages R1B/R1 or
because of a limitation in the HW?

> mmc->max_busy_timeout to 0 and that made it work as well.

Okay, good.

>
> I wanna try it out with other R1b commands like erase to see if it works
> properly if the delay is actually very long.

Right, it probably works for most cases. In any case, this was broken
even before my three patches that screwed things up.

BTW, what HW busy time out will you be using for sdhci omap if
cmd->busy_timeout exceeds it? Is it 2581ms for all sdhci-omap
instances or does it differ depending on platform?

Anyway, in this phase, it sounds like we should move forward with a
patch setting max_busy_timeout to zero for sdhci omap, as that
restores things to the earlier behavior. Would you mind posting a
patch, or do you want me to manage it?

Kind regards
Uffe
