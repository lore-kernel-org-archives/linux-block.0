Return-Path: <SRS0=t5UG=4W=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2E135C3F2D1
	for <linux-block@archiver.kernel.org>; Thu,  5 Mar 2020 13:05:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F24002073B
	for <linux-block@archiver.kernel.org>; Thu,  5 Mar 2020 13:05:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="d+n29AXD"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725880AbgCENF5 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 5 Mar 2020 08:05:57 -0500
Received: from mail-vs1-f68.google.com ([209.85.217.68]:37340 "EHLO
        mail-vs1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726143AbgCENF5 (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Thu, 5 Mar 2020 08:05:57 -0500
Received: by mail-vs1-f68.google.com with SMTP id h5so3500526vsc.4
        for <linux-block@vger.kernel.org>; Thu, 05 Mar 2020 05:05:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=BjkRuQYMyyFjl0y/fOGiKVnPDnu/J4lZvjwDegGe96U=;
        b=d+n29AXDDhYorD0rgc8tlPdDz9jjA0I582hVN3X8bQTsoTzxgcBYIV07gA5RBlaVnR
         EbNS5Kf0fSXc6DX8+2Gh28l/YfSqbqwFplfnkOFNgvvR9cz69hcT9mY9fr6MXDAGUJCP
         hzWfm0bKhQkDzuPJ2/TW9LsqGh8mi3IT3DaE+w5nrlE6CaBfId3fRojJXCHGeE085FVx
         unJuzWO5OuwAIN4IOSV7JOBf7jiLnXX5dfgtE+rSYG4HQs625dZAg39n5q9co3kmVjkb
         gsRi7cIIMcr39mZn95hQq0h1sNLc+DZA2UCWF8eui1iyu81iwm3G6VAIONiofa3Gmh8S
         S6ew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=BjkRuQYMyyFjl0y/fOGiKVnPDnu/J4lZvjwDegGe96U=;
        b=f1fQlyucXZ4VjIrpwg25z2DM5ifGHpfIf8HqG5nV6OR8uy8NqLzb/H89LiRAkMu9do
         k0UkYH28K2fr9ze7uPisM5nt1T0z8RSQ63qoJExDL7x8Ok4NTab91OyZwVYQYcWcnfw1
         op1La3pV50apkHcF3BoksQK67Ydq57QBdKodq8BSYrNiRT0y3qmczc7gQ2eNdSDn/hdE
         X5pk9afMG4Mww3h96gZ2ia4ze65QJ5DwEG9JZCivd7iCzOEpt9evxd7kH3NSpEm1NhHC
         aiv44PH/l3lY63wbwdcFOBPoLzglqSjsHxhC37efu9O/6vuHcbCAwF0D+U/MoDz81/5R
         ASCA==
X-Gm-Message-State: ANhLgQ2tlAewZElnF0KKMTxFoOn/kTtPksIpR/dleYTKz5ATYM7/IKYe
        zGkZliTVY3EauO2ehDdcwhdl+gj2H3KNptolJ2P+1w==
X-Google-Smtp-Source: ADFU+vu96s16IZesBT0UmQDEVDoMZl+fZ6G2vrGYhB+mU4dC7FTL6fBlkZo06dqfr6hBPBupCfzLx46bxsVHUMyRbAE=
X-Received: by 2002:a67:646:: with SMTP id 67mr4982294vsg.34.1583413553982;
 Thu, 05 Mar 2020 05:05:53 -0800 (PST)
MIME-Version: 1.0
References: <CA+G9fYuqAQfhzF2BzHr7vMHx68bo8-jT+ob_F3eHQ3=oFjgYdg@mail.gmail.com>
 <a602a27a-b960-ce56-c541-3b4b95f5dce2@nvidia.com> <CAPDyKFrXQgtHa4gLaKUi_F0rs4FMBai3Y_+TcHZR_zpkb0B4QQ@mail.gmail.com>
 <6523119a-50ac-973a-d1cd-ab1569259411@nvidia.com> <f960aa98-5508-36fd-166d-7f41c7d85154@nvidia.com>
 <CAPDyKFokE6x0mn+v5B9=so-SyrdTn0JBU8Mrp3Zdu6kSaCie2g@mail.gmail.com>
 <0963b60f-15e7-4bc6-10df-6fc8003e4d42@nvidia.com> <CAPDyKFq5NoeHEBK3sv3yOSD2+pm9FueH1gaTyPq0j7GLfa6vnA@mail.gmail.com>
 <34fd84d7-387b-b6f3-7fb3-aa490909e205@ti.com> <CAPDyKFrrO4noYqdxWL9Y8Nx75LopbDudKGMotkGbGcAF1oq==w@mail.gmail.com>
 <5e9b5646-bd48-e55b-54ee-1c2c41fc9218@nvidia.com> <CAPDyKFqpNo_4OePBR1KnJNO=kR8XEqbcsEd=icSceSdDH+Rk1Q@mail.gmail.com>
 <757853cf-987e-f6b6-9259-b4560a031692@nvidia.com> <d12fe142-7e72-ab58-33ab-17817e35096f@nvidia.com>
 <c216f131-6f83-c9c9-9d17-8d44ec06972d@nvidia.com> <87ad7586-9569-4276-044a-adb64e84ca15@nvidia.com>
 <a0962e0b-0f1d-9f32-f6e9-92f69f93167f@nvidia.com> <57ddddc2-3ee8-d867-bba0-0dd9929ba37d@nvidia.com>
In-Reply-To: <57ddddc2-3ee8-d867-bba0-0dd9929ba37d@nvidia.com>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Thu, 5 Mar 2020 14:05:17 +0100
Message-ID: <CAPDyKFqZSd9E3+16yFsmpee2JsbRJ-DGThxx7NJHu6UE00Xi1Q@mail.gmail.com>
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

On Thu, 5 Mar 2020 at 01:20, Sowjanya Komatineni <skomatineni@nvidia.com> wrote:
>
>
> On 3/4/20 2:35 PM, Sowjanya Komatineni wrote:
> >
> > On 3/4/20 9:51 AM, Sowjanya Komatineni wrote:
> >>
> >> On 3/4/20 9:26 AM, Sowjanya Komatineni wrote:
> >>>
> >>> On 3/4/20 9:21 AM, Sowjanya Komatineni wrote:
> >>>>
> >>>> On 3/4/20 8:56 AM, Sowjanya Komatineni wrote:
> >>>>>
> >>>>> On 3/4/20 2:18 AM, Ulf Hansson wrote:
> >>>>>> External email: Use caution opening links or attachments
> >>>>>>
> >>>>>>
> >>>>>> [...]
> >>>>>>
> >>>>>>> So, from my side, me and Anders Roxell, have been collaborating on
> >>>>>>> testing the behaviour on a TI Beagleboard x15 (remotely with
> >>>>>>> limited
> >>>>>>> debug options), which is using the sdhci-omap variant. I am
> >>>>>>> trying to
> >>>>>>> get hold of an Nvidia jetson-TX2, but not found one yet. These
> >>>>>>> are the
> >>>>>>> conclusions from the observed behaviour on the Beagleboard for the
> >>>>>>> CMD6 cache flush command.
> >>>>>>>
> >>>>>>> First, the reported host->max_busy_timeout is 2581 (ms) for the
> >>>>>>> sdhci-omap driver in this configuration.
> >>>>>>>
> >>>>>>> 1. As we all know by now, the cache flush command (CMD6) fails with
> >>>>>>> -110 currently. This is when MMC_CACHE_FLUSH_TIMEOUT_MS is set
> >>>>>>> to 30 *
> >>>>>>> 1000 (30s), which means __mmc_switch() drops the MMC_RSP_BUSY flag
> >>>>>>> from the command.
> >>>>>>>
> >>>>>>> 2. Changing the MMC_CACHE_FLUSH_TIMEOUT_MS to 2000 (2s), means that
> >>>>>>> the MMC_RSP_BUSY flag becomes set by __mmc_switch, because of the
> >>>>>>> timeout_ms parameter is less than max_busy_timeout (2000 < 2581).
> >>>>>>> Then everything works fine.
> >>>>>>>
> >>>>>>> 3. Updating the code to again use 30s as the
> >>>>>>> MMC_CACHE_FLUSH_TIMEOUT_MS, but instead forcing the MMC_RSP_BUSY
> >>>>>>> to be
> >>>>>>> set, even when the timeout_ms becomes greater than
> >>>>>>> max_busy_timeout.
> >>>>>>> This also works fine.
> >>>>>>>
> >>>>>>> Clearly this indicates a problem that I think needs to be
> >>>>>>> addressed in
> >>>>>>> the sdhci driver. However, of course I can revert the three
> >>>>>>> discussed
> >>>>>>> patches to fix the problem, but that would only hide the issues
> >>>>>>> and I
> >>>>>>> am sure we would then get back to this issue, sooner or later.
> >>>>>>>
> >>>>>>> To fix the problem in the sdhci driver, I would appreciate if
> >>>>>>> someone
> >>>>>>> from TI and Nvidia can step in to help, as I don't have the HW
> >>>>>>> on my
> >>>>>>> desk.
> >>>>>>>
> >>>>>>> Comments or other ideas of how to move forward?
> >>>>>> [...]
> >>>>>>
> >>>>>>> Hi Ulf,
> >>>>>>>
> >>>>>>> I could repro during suspend on Jetson TX1/TX2 as when it does
> >>>>>>> mmc flush cache.
> >>>>>> Okay, great.
> >>>>>>
> >>>>>>>
> >>>>>>> Timeout I see is for switch status CMD13 after sending CMD6 as
> >>>>>>> device side CMD6 is still inflight while host sends CMD13 as we
> >>>>>>> are using R1 response type with timeout_ms changes to 30s.
> >>>>>>>
> >>>>>>>
> >>>>>>>
> >>>>>>> Earlier we used timeout_ms of 0 for CMD6 flush cache, and with
> >>>>>>> it uses R1B response type and host will wait for busy state
> >>>>>>> followed by response from device for CMD6 and then data lines go
> >>>>>>> High.
> >>>>>>>
> >>>>>>>
> >>>>>>>
> >>>>>>> Now with timeout_ms changed to 30s, we use R1 response and SW
> >>>>>>> waits for busy by checking for DAT0 line to go High.
> >>>>>> If I understand correctly, because of the timeout now set to 30s,
> >>>>>> MMC_RSP_BUSY becomes disabled in __mmc_switch() for your case in
> >>>>>> sdhci-tegra as well?
> >>>>> Yes
> >>>>>>
> >>>>>> In other words, mmc_poll_for_busy() is being called, which in your
> >>>>>> case means the ->card_busy() host ops (set to sdhci_card_busy() in
> >>>>>> your case) will be invoked to wait for the card to stop signal
> >>>>>> busy on
> >>>>>> DAT0.
> >>>>>>
> >>>>>> This indicates to me, that the ->card_busy() ops returns zero to
> >>>>>> inform that the card is *not* busy, even if the card actually
> >>>>>> signals
> >>>>>> busy? Is that correct?
> >>>>> Yes
> >>>>>>
> >>>>>>>
> >>>>>>>
> >>>>>>> With R1B type, host design after sending command at end of
> >>>>>>> completion after end bit waits for 2 cycles for data line to go
> >>>>>>> low (busy state from device) and waits for response cycles after
> >>>>>>> which data lines will go back high and then we issue switch
> >>>>>>> status CMD13.
> >>>>>>>
> >>>>>>>
> >>>>>>>
> >>>>>>> With R1 type, host after sending command and at end of
> >>>>>>> completion after end bit, DATA lines will go high immediately as
> >>>>>>> its R1 type and switch status CMD13 gets issued but by this time
> >>>>>>> it looks like CMD6 on device side is still in flight for sending
> >>>>>>> status and data.
> >>>>>> So, yes, using R1 instead of R1B triggers a different behaviour, but
> >>>>>> according to the eMMC spec it's perfectly allowed to issue a CMD13
> >>>>>> even if the card signals busy on DAT0. The CMD13 is not using the
> >>>>>> DATA
> >>>>>> lines, so this should work.
> >>>>>>
> >>>>>> If I understand correctly, your driver (and controller?) has issues
> >>>>>> with coping with this scenario. Is it something that can be fixed?
> >>>>>>
> >>>>>>>
> >>>>>>> 30s timeout is the wait time for data0 line to go high and
> >>>>>>> mmc_busy_status will return success right away with R1 response
> >>>>>>> type and SW sends switch status CMD13 but during that time on
> >>>>>>> device side looks like still processing CMD6 as we are not
> >>>>>>> waiting for enough time when we use R1 response type.
> >>>>>> Right, as stated above, isn't sdhci_card_busy() working for your
> >>>>>> case?
> >>>>>> Can we fix it?
> >>>>>
> >>>>> sdhci_card_busy() returned 0 indicating its not busy.
> >>>>>
> >>>>> Based on our host design, When CMD6 is issued with R1 type, we
> >>>>> program it as NO_RESPONSE and with this command complete interrupt
> >>>>> happens right at end bit of command and there will be no transfer
> >>>>> complete interrupt.
> >>>> *[Correction] Based on our host design, When CMD6 is issued with R1
> >>>> type as we program it as NO_RESPONSE and with this command complete
> >>>> interrupt happens right at end bit of command and there will be no
> >>>> transfer complete interrupt.
> >>>
> >>> Sorry to correct wordings, I meant sdhci driver programs response
> >>> type as NO_RESPONSE for CMD6.
> >>>
> >>> When CMD6 is issued with R1 type and as NO_RESPONSE, Based on our
> >>> host design  command complete interrupt happens right at end bit of
> >>> command and there will be no transfer complete interrupt.
> >>>
> >>>
> >> Sorry for confusion. Please ignore above on response. it is using
> >> SHORT response for R1. So SW poll should be working.
> >>
> >> Will get back on checking on host design side internally.
> >>
> > Hi Ulf,
> >
> > Verified internally regarding the busy state over DATA0 Our host
> > design has known minor bug where command complete interrupt is
> > asserted after waiting for busy cycles from device.So because of this
> > polling for card_busy() returns 0 (DAT0 line High) immediately as
> > waiting for busy is taken care during command complete interrupt in
> > host design. This behavior is same for R1 and R1B.
> >
> >
> >>>>>
> >>>>> When CMD6 is issued with R1B type, we program is as R1B RESP_SHORT
> >>>>> and with this command complete is end bit of device resp and
> >>>>> transfer complete interrupt will be when DAT0 LOW -> HIGH.
> >>>>>
> >>>>> Regardless of R1/R1B, device side CMD6 will always have busy state
> >>>>> on D0 and response on CMD lines.
> >>>>>
> >>>>> There will be 2 clock cycles period after sending CMD6 for device
> >>>>> to send busy state on data0.
> >>>>>
> >>>>> In case of R1 type, after sending command DAT will stay high and
> >>>>> looks like we are polling for busy early before busy state has
> >>>>> started and sending CMD13 while device is busy and sending
> >>>>> response on CMD line is causing timeout.
> >>>>>
> >>>>> Probably with this specific case of CMD6 with R1 type, to wait for
> >>>>> card busy we should poll for DAT0 to go Low first and then to go
> >>>>> High??
> >>>>>
> >>>>>>
> >>
> >>>>>>>
> >>>>>>>
> >>>>>>>
> >>>>>>> Actually we always use R1B with CMD6 as per spec.
> >>>>>> I fully agree that R1B is preferable, but it's not against the
> >>>>>> spec to
> >>>>>> send CMD13 to poll for busy.
> >>>>>>
> >>>>>> Moreover, we need to cope with the scenario when the host has
> >>>>>> specified a maximum timeout that isn't sufficiently long enough for
> >>>>>> the requested operation. Do you have another proposal for how to
> >>>>>> manage this, but disabling MMC_RSP_BUSY?
> >>>>>>
> >>>>>> Let's assume you driver would get a R1B for the CMD6 (we force it),
> >>>>>> then what timeout would the driver be using if we would set
> >>>>>> cmd.busy_timeout to 30ms?
> >>>>>>
> >
> Sorry didn't understood clearly. Are you asking with 30s timeout, whats
> the data timeout counter used?

Yes. It seems like it will pick the maximum, which is 11s?

>
> Because of above mentioned issue on our host where CMD interrupt happens
> after busy state, poll for busy returns right away as not busy.

I see.

>
> So issuing CMD13 after CMD6-R1 followed by busy poll should be working.
> But weird that with small delay of 1ms or debug print before CMD13 it
> doesn't timeout and works all the time.

I have digested the information you provided in these emails. Let me
summarize it, to see if I have understood correctly.

1.
Your controller can't distinguish between R1 and R1B because of a
limitation in the HW. So, in both cases you need to wait for the card
to stop signal busy, before the controller can give an IRQ to notify
that the R1 response has been received. Correct?

In this context, I am wondering if sdhci_send_command(), really
conforms to these requirements. For example, depending on if the CMD6
has MMC_RSP_BUSY or not, it may pick either SDHCI_CMD_RESP_SHORT or
SDHCI_CMD_RESP_SHORT_BUSY.

Does this work as expected for your case?

2.
Assuming my interpretation of the above is somewhat correct. Then you
always need to set a busy timeout for R1/R1B responses in the
controller. The maximum timeout seems to be 11s long. Obviously, this
isn't enough for all cases, such as cache flushing and erase, for
example. So, what can we do to support a longer timeouts than 11s?
Would it be possible to disable the HW timeout, if the requested
timeout is longer than 11s and use a SW timeout instead?

Kind regards
Uffe
