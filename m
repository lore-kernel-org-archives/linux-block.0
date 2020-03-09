Return-Path: <SRS0=ZA/H=42=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BEB17C10F27
	for <linux-block@archiver.kernel.org>; Mon,  9 Mar 2020 17:33:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 777012253D
	for <linux-block@archiver.kernel.org>; Mon,  9 Mar 2020 17:33:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nvidia.com header.i=@nvidia.com header.b="E2ikta4r"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727286AbgCIRdr (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 9 Mar 2020 13:33:47 -0400
Received: from hqnvemgate25.nvidia.com ([216.228.121.64]:12860 "EHLO
        hqnvemgate25.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727254AbgCIRdr (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Mon, 9 Mar 2020 13:33:47 -0400
Received: from hqpgpgate101.nvidia.com (Not Verified[216.228.121.13]) by hqnvemgate25.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5e667dca0000>; Mon, 09 Mar 2020 10:32:59 -0700
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate101.nvidia.com (PGP Universal service);
  Mon, 09 Mar 2020 10:33:42 -0700
X-PGP-Universal: processed;
        by hqpgpgate101.nvidia.com on Mon, 09 Mar 2020 10:33:42 -0700
Received: from [10.2.175.232] (10.124.1.5) by HQMAIL107.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Mon, 9 Mar
 2020 17:33:42 +0000
Subject: Re: LKFT: arm x15: mmc1: cache flush error -110
To:     Ulf Hansson <ulf.hansson@linaro.org>
CC:     Jon Hunter <jonathanh@nvidia.com>,
        Bitan Biswas <bbiswas@nvidia.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Naresh Kamboju <naresh.kamboju@linaro.org>,
        Jens Axboe <axboe@kernel.dk>,
        Alexei Starovoitov <ast@kernel.org>,
        linux-block <linux-block@vger.kernel.org>,
        <lkft-triage@lists.linaro.org>,
        open list <linux-kernel@vger.kernel.org>,
        "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
        Arnd Bergmann <arnd@arndb.de>,
        John Stultz <john.stultz@linaro.org>,
        Faiz Abbas <faiz_abbas@ti.com>,
        Thierry Reding <treding@nvidia.com>,
        Anders Roxell <anders.roxell@linaro.org>,
        Kishon <kishon@ti.com>
References: <CA+G9fYuqAQfhzF2BzHr7vMHx68bo8-jT+ob_F3eHQ3=oFjgYdg@mail.gmail.com>
 <CAPDyKFokE6x0mn+v5B9=so-SyrdTn0JBU8Mrp3Zdu6kSaCie2g@mail.gmail.com>
 <0963b60f-15e7-4bc6-10df-6fc8003e4d42@nvidia.com>
 <CAPDyKFq5NoeHEBK3sv3yOSD2+pm9FueH1gaTyPq0j7GLfa6vnA@mail.gmail.com>
 <34fd84d7-387b-b6f3-7fb3-aa490909e205@ti.com>
 <CAPDyKFrrO4noYqdxWL9Y8Nx75LopbDudKGMotkGbGcAF1oq==w@mail.gmail.com>
 <5e9b5646-bd48-e55b-54ee-1c2c41fc9218@nvidia.com>
 <CAPDyKFqpNo_4OePBR1KnJNO=kR8XEqbcsEd=icSceSdDH+Rk1Q@mail.gmail.com>
 <757853cf-987e-f6b6-9259-b4560a031692@nvidia.com>
 <d12fe142-7e72-ab58-33ab-17817e35096f@nvidia.com>
 <c216f131-6f83-c9c9-9d17-8d44ec06972d@nvidia.com>
 <87ad7586-9569-4276-044a-adb64e84ca15@nvidia.com>
 <a0962e0b-0f1d-9f32-f6e9-92f69f93167f@nvidia.com>
 <57ddddc2-3ee8-d867-bba0-0dd9929ba37d@nvidia.com>
 <CAPDyKFqZSd9E3+16yFsmpee2JsbRJ-DGThxx7NJHu6UE00Xi1Q@mail.gmail.com>
 <26ee7225-9483-4664-c2d7-b5cefeadcd4b@nvidia.com>
 <CAPDyKFqwVQDEnPNi33mc9ycTxpaT1cRLejbR3Ja4c8dha4gFRw@mail.gmail.com>
From:   Sowjanya Komatineni <skomatineni@nvidia.com>
Message-ID: <0301bbd5-8d4d-4a77-42c7-8a1391c2d60a@nvidia.com>
Date:   Mon, 9 Mar 2020 10:35:31 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <CAPDyKFqwVQDEnPNi33mc9ycTxpaT1cRLejbR3Ja4c8dha4gFRw@mail.gmail.com>
X-Originating-IP: [10.124.1.5]
X-ClientProxiedBy: HQMAIL105.nvidia.com (172.20.187.12) To
 HQMAIL107.nvidia.com (172.20.187.13)
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1583775179; bh=CYaifugh60g9oO62CRHXR8kHhNzWHbyTDaF0kgHrBPI=;
        h=X-PGP-Universal:Subject:To:CC:References:From:Message-ID:Date:
         User-Agent:MIME-Version:In-Reply-To:X-Originating-IP:
         X-ClientProxiedBy:Content-Type:Content-Transfer-Encoding:
         Content-Language;
        b=E2ikta4rTotdZ9vdOIYMuaIOOfvDngHacwS6IlqPRUsxZweuaoG3VC/1Gs/3jaZsO
         ddnzbKnqD2ckd79tq/qAMwzMYcsYOoL73Er4IYO7b89lc/Hb931hSi54+Eum1e5xtJ
         dvoBWxSrJ3CTgTvobhl/Z9tKPh+cLuHJ2lnHtzgw4dJrjvsimdfplUK4S7hHrzX4hB
         AnD+9fxTno86x/XJ19gd8GKflyH2jFX9+dRM/JFk3EFbjNAdDN3maGR41UHxbI/EJn
         HDbUeTv0bzS8RFp0fboaWszYVGwJbhrObA2x7dsChfuK4ElohDYgrqWblNCAqyO9fX
         wgQ1RWrxj3V2A==
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org


On 3/6/20 3:14 AM, Ulf Hansson wrote:
> External email: Use caution opening links or attachments
>
>
> [...]
>
>>>>>>>>>>> Actually we always use R1B with CMD6 as per spec.
>>>>>>>>>> I fully agree that R1B is preferable, but it's not against the
>>>>>>>>>> spec to
>>>>>>>>>> send CMD13 to poll for busy.
>>>>>>>>>>
>>>>>>>>>> Moreover, we need to cope with the scenario when the host has
>>>>>>>>>> specified a maximum timeout that isn't sufficiently long enough for
>>>>>>>>>> the requested operation. Do you have another proposal for how to
>>>>>>>>>> manage this, but disabling MMC_RSP_BUSY?
>>>>>>>>>>
>>>>>>>>>> Let's assume you driver would get a R1B for the CMD6 (we force it),
>>>>>>>>>> then what timeout would the driver be using if we would set
>>>>>>>>>> cmd.busy_timeout to 30ms?
>>>>>>>>>>
>>>> Sorry didn't understood clearly. Are you asking with 30s timeout, whats
>>>> the data timeout counter used?
>>> Yes. It seems like it will pick the maximum, which is 11s?
>> yes
> Okay, thanks!
>
>>>> Because of above mentioned issue on our host where CMD interrupt happens
>>>> after busy state, poll for busy returns right away as not busy.
>>> I see.
>>>
>>>> So issuing CMD13 after CMD6-R1 followed by busy poll should be working.
>>>> But weird that with small delay of 1ms or debug print before CMD13 it
>>>> doesn't timeout and works all the time.
>>> I have digested the information you provided in these emails. Let me
>>> summarize it, to see if I have understood correctly.
>>>
>>> 1.
>>> Your controller can't distinguish between R1 and R1B because of a
>>> limitation in the HW. So, in both cases you need to wait for the card
>>> to stop signal busy, before the controller can give an IRQ to notify
>>> that the R1 response has been received. Correct?
>>>
>>> In this context, I am wondering if sdhci_send_command(), really
>>> conforms to these requirements. For example, depending on if the CMD6
>>> has MMC_RSP_BUSY or not, it may pick either SDHCI_CMD_RESP_SHORT or
>>> SDHCI_CMD_RESP_SHORT_BUSY.
>>>
>>> Does this work as expected for your case?
>> Design team re-verified internally and bug where HW waits for busy state
>> before IRQ is only for R1B and R1 is spec compliant.
>>
>> So, with R1, CMD complete is generated after response received.
> Okay.
>
> So, the issue we see for CMD6 with R1, is a software problem that we
> should be able to fix.
>
>> With R1B, CMD complete and xfer complete both are generated after
>> response received + device busy (max timeout of 11s)
>> DATA timeout interrupt will be asserted incase if HW busy detection fails.
>>
>> With R1B we may see DATA Timeout if operation takes more than max busy
>> timeout of 11s.
> Okay, I see.
>
>>> 2.
>>> Assuming my interpretation of the above is somewhat correct. Then you
>>> always need to set a busy timeout for R1/R1B responses in the
>>> controller. The maximum timeout seems to be 11s long. Obviously, this
>>> isn't enough for all cases, such as cache flushing and erase, for
>>> example. So, what can we do to support a longer timeouts than 11s?
>>> Would it be possible to disable the HW timeout, if the requested
>>> timeout is longer than 11s and use a SW timeout instead?
>>>
>>> Kind regards
>>> Uffe
>> For erase long operations we have register bit to enable for infinite
>> busy wait mode where host controller would be monitoring until card is busy.
> Alright, that sounds great!
>
>> But so far for emmc devices we used on our platforms, we haven't seen
>> cache flush taking more than 11s.
> I understand that 11s is probably fine to use, for most cases.
>
> However, it's not spec compliant, as for some operations there are
> simply no timeout specified. BKOPS, cache flush, sanitize are cases
> like this - and then 11s is definitely not sufficient.
>
>> Will get back on possibility of disabling HW timeout and using SW timeout..
> Thanks!
>
> I would like to get the regression fixed asap, but I also would like
> to avoid reverting patches, unless really necessary. May I propose the
> following two options.
>
> 1. Find out why polling with ->card_busy() or CMD13, for a CMD6 with
> an R1 response doesn't work - and then fix that behaviour.
>
> 2. Set the mmc->max_busy_timeout to zero for sdhci-tegra, which makes
> the core to always use R1B for CMD6 (and erase). This also means that
> when the cmd->busy_timeout becomes longer than 11s, sdhci-tegra must
> disable the HW busy timeout and just wait "forever".
>
> If you decide for 2, you can add the software timeout support on top,
> but make that can be considered as a next step of an improvement,
> rather than needed as fix. Note that, I believe there are some support
> for software timeout already in the sdhci core, maybe you need to
> tweak it a bit for your case, I don't know.
>
> Kind regards
> Uffe

Hi Uffe

Will go with 2nd option and will send patches out when ready.

BTW, Tegra host also supports SDHCI_QUIRK_DATA_TIMEOUT_USES_SDCLK for 
data timeout based on host clock when using finite mode (HW busy 
detection based on DATA TIMEOUT count value when cmd operation timeout 
is < 11s for tegra host).

So, looks like we cant set host max_busy_timeout to 0 for Tegra host to 
force R1B during SWITCH and SLEEP_AWAKE.

So, was thinking to introduce host capability MMC_CAP2_LONG_WAIT_HW_BUSY 
which can be used for hosts supporting long or infinite HW busy wait 
detection and will update mmc and mmc_ops drivers to not allow convert 
R1B to R1B for hosts with this capability during SLEEP_AWAKE and SWITCH.

Thanks

Sowjanya

