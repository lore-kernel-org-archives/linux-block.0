Return-Path: <SRS0=yWSg=4X=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0BC03C10F26
	for <linux-block@archiver.kernel.org>; Fri,  6 Mar 2020 11:15:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D596F2084E
	for <linux-block@archiver.kernel.org>; Fri,  6 Mar 2020 11:15:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="L1atKqdq"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726359AbgCFLPG (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 6 Mar 2020 06:15:06 -0500
Received: from mail-vs1-f45.google.com ([209.85.217.45]:42861 "EHLO
        mail-vs1-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726240AbgCFLPG (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Fri, 6 Mar 2020 06:15:06 -0500
Received: by mail-vs1-f45.google.com with SMTP id w142so1244768vsw.9
        for <linux-block@vger.kernel.org>; Fri, 06 Mar 2020 03:15:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=RALxsLUaehfVlQvSftzg+Fa2mm4tOh4KA3MkWJBS1Wg=;
        b=L1atKqdq+Sd3Hdsm7/3Om3qiUD7MEXQHhdSIB02f2vHyUBzfwL2ntphoeKdPS7HqWu
         GA1SbtTT3XMAjS8DIFx8wap0iOQBn1/esVAlZXpsMH+VnW1fczqEj/9jqaj7+yVI08Qh
         qLTtmUC74LNea1rG+hK+S6YrvexWiAw8V1nZJtL0Ocb9uYyoIJePnirVSj9JDaP5+fYX
         NbY8kq90JZkrsmJ01kQ7amgyp0caa+m58V0KYtLyujSkMOpNETuUbQxPDNEHB3KoeFGD
         oRURHTtpkyxUfc+fFB2nuuvhIssCHI13ejkYu6GfL5Hu+jnvJGooTG2Tc+l98n0UgCke
         hKiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=RALxsLUaehfVlQvSftzg+Fa2mm4tOh4KA3MkWJBS1Wg=;
        b=L45ByTcDxArmYWacbIxxN1q8a5dAFqYaEJf9bzTP34GAFR/iGdGazfgT+uuT78fKu0
         qHJFJs3jmCGg0k9GXtNwpdUGzAQbcXk5dMaZzDidQeHTQA7p+wXdZRcnp33TZ7knKeAh
         twqVDDXWnsOb6t1CUDHeR8S3tpDng3skOCJTStHyMLWFOhNm++rugINplbrtts1sYj82
         dW1mVo4Wb+jOcW2OBbcTh4XeyhO62NpP7sOCx2L/mNPnFMa/gmZl3mynaIeIpmqm8sxQ
         pASVqE8jZBeh2oCeYS4G0FrPrqCefxXvQKpnYRE9n0oi2TvSqPdic1zndaonsMPJy2pp
         17Rw==
X-Gm-Message-State: ANhLgQ1Xh5+HKjcpCZf0ZCKvFVAGoMViXhM3sMwkzsvZA0DSupMj1UBU
        VikeijH+0GhOvHIYtmXNrkB4M3Xb+BdYjEaQMsareA==
X-Google-Smtp-Source: ADFU+vu5ic0WXuqQCkTpsuPEoSJuLGAvJotbaObBa+yxHqWEywYiNwpxOLlyc0d5So2Sg6BN1yJw/KM7oGHOxKOCHCc=
X-Received: by 2002:a67:7fd0:: with SMTP id a199mr1838473vsd.200.1583493304009;
 Fri, 06 Mar 2020 03:15:04 -0800 (PST)
MIME-Version: 1.0
References: <CA+G9fYuqAQfhzF2BzHr7vMHx68bo8-jT+ob_F3eHQ3=oFjgYdg@mail.gmail.com>
 <6523119a-50ac-973a-d1cd-ab1569259411@nvidia.com> <f960aa98-5508-36fd-166d-7f41c7d85154@nvidia.com>
 <CAPDyKFokE6x0mn+v5B9=so-SyrdTn0JBU8Mrp3Zdu6kSaCie2g@mail.gmail.com>
 <0963b60f-15e7-4bc6-10df-6fc8003e4d42@nvidia.com> <CAPDyKFq5NoeHEBK3sv3yOSD2+pm9FueH1gaTyPq0j7GLfa6vnA@mail.gmail.com>
 <34fd84d7-387b-b6f3-7fb3-aa490909e205@ti.com> <CAPDyKFrrO4noYqdxWL9Y8Nx75LopbDudKGMotkGbGcAF1oq==w@mail.gmail.com>
 <5e9b5646-bd48-e55b-54ee-1c2c41fc9218@nvidia.com> <CAPDyKFqpNo_4OePBR1KnJNO=kR8XEqbcsEd=icSceSdDH+Rk1Q@mail.gmail.com>
 <757853cf-987e-f6b6-9259-b4560a031692@nvidia.com> <d12fe142-7e72-ab58-33ab-17817e35096f@nvidia.com>
 <c216f131-6f83-c9c9-9d17-8d44ec06972d@nvidia.com> <87ad7586-9569-4276-044a-adb64e84ca15@nvidia.com>
 <a0962e0b-0f1d-9f32-f6e9-92f69f93167f@nvidia.com> <57ddddc2-3ee8-d867-bba0-0dd9929ba37d@nvidia.com>
 <CAPDyKFqZSd9E3+16yFsmpee2JsbRJ-DGThxx7NJHu6UE00Xi1Q@mail.gmail.com> <26ee7225-9483-4664-c2d7-b5cefeadcd4b@nvidia.com>
In-Reply-To: <26ee7225-9483-4664-c2d7-b5cefeadcd4b@nvidia.com>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Fri, 6 Mar 2020 12:14:27 +0100
Message-ID: <CAPDyKFqwVQDEnPNi33mc9ycTxpaT1cRLejbR3Ja4c8dha4gFRw@mail.gmail.com>
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

> >>>>>>>>>
> >>>>>>>>> Actually we always use R1B with CMD6 as per spec.
> >>>>>>>> I fully agree that R1B is preferable, but it's not against the
> >>>>>>>> spec to
> >>>>>>>> send CMD13 to poll for busy.
> >>>>>>>>
> >>>>>>>> Moreover, we need to cope with the scenario when the host has
> >>>>>>>> specified a maximum timeout that isn't sufficiently long enough for
> >>>>>>>> the requested operation. Do you have another proposal for how to
> >>>>>>>> manage this, but disabling MMC_RSP_BUSY?
> >>>>>>>>
> >>>>>>>> Let's assume you driver would get a R1B for the CMD6 (we force it),
> >>>>>>>> then what timeout would the driver be using if we would set
> >>>>>>>> cmd.busy_timeout to 30ms?
> >>>>>>>>
> >> Sorry didn't understood clearly. Are you asking with 30s timeout, whats
> >> the data timeout counter used?
> > Yes. It seems like it will pick the maximum, which is 11s?
> yes

Okay, thanks!

> >
> >> Because of above mentioned issue on our host where CMD interrupt happens
> >> after busy state, poll for busy returns right away as not busy.
> > I see.
> >
> >> So issuing CMD13 after CMD6-R1 followed by busy poll should be working.
> >> But weird that with small delay of 1ms or debug print before CMD13 it
> >> doesn't timeout and works all the time.
> > I have digested the information you provided in these emails. Let me
> > summarize it, to see if I have understood correctly.
> >
> > 1.
> > Your controller can't distinguish between R1 and R1B because of a
> > limitation in the HW. So, in both cases you need to wait for the card
> > to stop signal busy, before the controller can give an IRQ to notify
> > that the R1 response has been received. Correct?
> >
> > In this context, I am wondering if sdhci_send_command(), really
> > conforms to these requirements. For example, depending on if the CMD6
> > has MMC_RSP_BUSY or not, it may pick either SDHCI_CMD_RESP_SHORT or
> > SDHCI_CMD_RESP_SHORT_BUSY.
> >
> > Does this work as expected for your case?
> Design team re-verified internally and bug where HW waits for busy state
> before IRQ is only for R1B and R1 is spec compliant.
>
> So, with R1, CMD complete is generated after response received.

Okay.

So, the issue we see for CMD6 with R1, is a software problem that we
should be able to fix.

>
> With R1B, CMD complete and xfer complete both are generated after
> response received + device busy (max timeout of 11s)
> DATA timeout interrupt will be asserted incase if HW busy detection fails.
>
> With R1B we may see DATA Timeout if operation takes more than max busy
> timeout of 11s.

Okay, I see.

>
> > 2.
> > Assuming my interpretation of the above is somewhat correct. Then you
> > always need to set a busy timeout for R1/R1B responses in the
> > controller. The maximum timeout seems to be 11s long. Obviously, this
> > isn't enough for all cases, such as cache flushing and erase, for
> > example. So, what can we do to support a longer timeouts than 11s?
> > Would it be possible to disable the HW timeout, if the requested
> > timeout is longer than 11s and use a SW timeout instead?
> >
> > Kind regards
> > Uffe
>
> For erase long operations we have register bit to enable for infinite
> busy wait mode where host controller would be monitoring until card is busy.

Alright, that sounds great!

>
> But so far for emmc devices we used on our platforms, we haven't seen
> cache flush taking more than 11s.

I understand that 11s is probably fine to use, for most cases.

However, it's not spec compliant, as for some operations there are
simply no timeout specified. BKOPS, cache flush, sanitize are cases
like this - and then 11s is definitely not sufficient.

>
> Will get back on possibility of disabling HW timeout and using SW timeout..

Thanks!

I would like to get the regression fixed asap, but I also would like
to avoid reverting patches, unless really necessary. May I propose the
following two options.

1. Find out why polling with ->card_busy() or CMD13, for a CMD6 with
an R1 response doesn't work - and then fix that behaviour.

2. Set the mmc->max_busy_timeout to zero for sdhci-tegra, which makes
the core to always use R1B for CMD6 (and erase). This also means that
when the cmd->busy_timeout becomes longer than 11s, sdhci-tegra must
disable the HW busy timeout and just wait "forever".

If you decide for 2, you can add the software timeout support on top,
but make that can be considered as a next step of an improvement,
rather than needed as fix. Note that, I believe there are some support
for software timeout already in the sdhci core, maybe you need to
tweak it a bit for your case, I don't know.

Kind regards
Uffe
