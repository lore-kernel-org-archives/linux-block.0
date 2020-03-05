Return-Path: <SRS0=t5UG=4W=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 731A8C3F2CE
	for <linux-block@archiver.kernel.org>; Thu,  5 Mar 2020 03:06:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 311792073D
	for <linux-block@archiver.kernel.org>; Thu,  5 Mar 2020 03:06:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nvidia.com header.i=@nvidia.com header.b="Dz66BdH9"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725807AbgCEDGC (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 4 Mar 2020 22:06:02 -0500
Received: from hqnvemgate25.nvidia.com ([216.228.121.64]:12909 "EHLO
        hqnvemgate25.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725797AbgCEDGC (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Wed, 4 Mar 2020 22:06:02 -0500
Received: from hqpgpgate101.nvidia.com (Not Verified[216.228.121.13]) by hqnvemgate25.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5e606c6f0001>; Wed, 04 Mar 2020 19:05:19 -0800
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate101.nvidia.com (PGP Universal service);
  Wed, 04 Mar 2020 19:06:00 -0800
X-PGP-Universal: processed;
        by hqpgpgate101.nvidia.com on Wed, 04 Mar 2020 19:06:00 -0800
Received: from [10.2.174.88] (10.124.1.5) by HQMAIL107.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Thu, 5 Mar
 2020 03:05:59 +0000
Subject: Re: LKFT: arm x15: mmc1: cache flush error -110
From:   Sowjanya Komatineni <skomatineni@nvidia.com>
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
 <CAPDyKFrXQgtHa4gLaKUi_F0rs4FMBai3Y_+TcHZR_zpkb0B4QQ@mail.gmail.com>
 <6523119a-50ac-973a-d1cd-ab1569259411@nvidia.com>
 <f960aa98-5508-36fd-166d-7f41c7d85154@nvidia.com>
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
Message-ID: <7c753d80-8aec-808c-c496-15fc841cf44d@nvidia.com>
Date:   Wed, 4 Mar 2020 19:06:11 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <57ddddc2-3ee8-d867-bba0-0dd9929ba37d@nvidia.com>
X-Originating-IP: [10.124.1.5]
X-ClientProxiedBy: HQMAIL111.nvidia.com (172.20.187.18) To
 HQMAIL107.nvidia.com (172.20.187.13)
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: quoted-printable
Content-Language: en-US
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1583377519; bh=yoXVGJwpDfbITheh44MJc7mZQsxjU1PCYgpzSXeVgY0=;
        h=X-PGP-Universal:Subject:From:To:CC:References:Message-ID:Date:
         User-Agent:MIME-Version:In-Reply-To:X-Originating-IP:
         X-ClientProxiedBy:Content-Type:Content-Transfer-Encoding:
         Content-Language;
        b=Dz66BdH9ZvKJX319vHWLbYzHg20mxYW2p9ChLFXyC574I8WlqmVBt9TXgQwVEZ37/
         xxVpVg+7JkSMC9CKA18iSxk6e8TivlTPD0jhUx2vIbWtMgRWfDROiusCIGsfxtp93y
         jaN34Kw8tYLrktdnQTzxMLa+61UNbvGoM1pnMA5H5H0mz7cp/mf27HpJkFfe5Q83Ou
         T5oCPUBuYxeeP1ZKYzm1H9cBe4BFmLHyFqKW0aSpyYCu9e8TE+6Vo9dLlZmqAQEFtX
         YzpMNjRJrQmE3EdzKQBrM7kIaHXGwdAFQvBZ6eTcefjkEalv3+7sFdRXyhzjDfsW/1
         8rtGzwxlUjasg==
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org


On 3/4/20 4:20 PM, Sowjanya Komatineni wrote:
>
> On 3/4/20 2:35 PM, Sowjanya Komatineni wrote:
>>
>> On 3/4/20 9:51 AM, Sowjanya Komatineni wrote:
>>>
>>> On 3/4/20 9:26 AM, Sowjanya Komatineni wrote:
>>>>
>>>> On 3/4/20 9:21 AM, Sowjanya Komatineni wrote:
>>>>>
>>>>> On 3/4/20 8:56 AM, Sowjanya Komatineni wrote:
>>>>>>
>>>>>> On 3/4/20 2:18 AM, Ulf Hansson wrote:
>>>>>>> External email: Use caution opening links or attachments
>>>>>>>
>>>>>>>
>>>>>>> [...]
>>>>>>>
>>>>>>>> So, from my side, me and Anders Roxell, have been collaborating on
>>>>>>>> testing the behaviour on a TI Beagleboard x15 (remotely with=20
>>>>>>>> limited
>>>>>>>> debug options), which is using the sdhci-omap variant. I am=20
>>>>>>>> trying to
>>>>>>>> get hold of an Nvidia jetson-TX2, but not found one yet. These=20
>>>>>>>> are the
>>>>>>>> conclusions from the observed behaviour on the Beagleboard for the
>>>>>>>> CMD6 cache flush command.
>>>>>>>>
>>>>>>>> First, the reported host->max_busy_timeout is 2581 (ms) for the
>>>>>>>> sdhci-omap driver in this configuration.
>>>>>>>>
>>>>>>>> 1. As we all know by now, the cache flush command (CMD6) fails=20
>>>>>>>> with
>>>>>>>> -110 currently. This is when MMC_CACHE_FLUSH_TIMEOUT_MS is set=20
>>>>>>>> to 30 *
>>>>>>>> 1000 (30s), which means __mmc_switch() drops the MMC_RSP_BUSY flag
>>>>>>>> from the command.
>>>>>>>>
>>>>>>>> 2. Changing the MMC_CACHE_FLUSH_TIMEOUT_MS to 2000 (2s), means=20
>>>>>>>> that
>>>>>>>> the MMC_RSP_BUSY flag becomes set by __mmc_switch, because of the
>>>>>>>> timeout_ms parameter is less than max_busy_timeout (2000 < 2581).
>>>>>>>> Then everything works fine.
>>>>>>>>
>>>>>>>> 3. Updating the code to again use 30s as the
>>>>>>>> MMC_CACHE_FLUSH_TIMEOUT_MS, but instead forcing the=20
>>>>>>>> MMC_RSP_BUSY to be
>>>>>>>> set, even when the timeout_ms becomes greater than=20
>>>>>>>> max_busy_timeout.
>>>>>>>> This also works fine.
>>>>>>>>
>>>>>>>> Clearly this indicates a problem that I think needs to be=20
>>>>>>>> addressed in
>>>>>>>> the sdhci driver. However, of course I can revert the three=20
>>>>>>>> discussed
>>>>>>>> patches to fix the problem, but that would only hide the issues=20
>>>>>>>> and I
>>>>>>>> am sure we would then get back to this issue, sooner or later.
>>>>>>>>
>>>>>>>> To fix the problem in the sdhci driver, I would appreciate if=20
>>>>>>>> someone
>>>>>>>> from TI and Nvidia can step in to help, as I don't have the HW=20
>>>>>>>> on my
>>>>>>>> desk.
>>>>>>>>
>>>>>>>> Comments or other ideas of how to move forward?
>>>>>>> [...]
>>>>>>>
>>>>>>>> Hi Ulf,
>>>>>>>>
>>>>>>>> I could repro during suspend on Jetson TX1/TX2 as when it does=20
>>>>>>>> mmc flush cache.
>>>>>>> Okay, great.
>>>>>>>
>>>>>>>>
>>>>>>>> Timeout I see is for switch status CMD13 after sending CMD6 as=20
>>>>>>>> device side CMD6 is still inflight while host sends CMD13 as we=20
>>>>>>>> are using R1 response type with timeout_ms changes to 30s.
>>>>>>>>
>>>>>>>>
>>>>>>>>
>>>>>>>> Earlier we used timeout_ms of 0 for CMD6 flush cache, and with=20
>>>>>>>> it uses R1B response type and host will wait for busy state=20
>>>>>>>> followed by response from device for CMD6 and then data lines=20
>>>>>>>> go High.
>>>>>>>>
>>>>>>>>
>>>>>>>>
>>>>>>>> Now with timeout_ms changed to 30s, we use R1 response and SW=20
>>>>>>>> waits for busy by checking for DAT0 line to go High.
>>>>>>> If I understand correctly, because of the timeout now set to 30s,
>>>>>>> MMC_RSP_BUSY becomes disabled in __mmc_switch() for your case in
>>>>>>> sdhci-tegra as well?
>>>>>> Yes
>>>>>>>
>>>>>>> In other words, mmc_poll_for_busy() is being called, which in your
>>>>>>> case means the ->card_busy() host ops (set to sdhci_card_busy() in
>>>>>>> your case) will be invoked to wait for the card to stop signal=20
>>>>>>> busy on
>>>>>>> DAT0.
>>>>>>>
>>>>>>> This indicates to me, that the ->card_busy() ops returns zero to
>>>>>>> inform that the card is *not* busy, even if the card actually=20
>>>>>>> signals
>>>>>>> busy? Is that correct?
>>>>>> Yes
>>>>>>>
>>>>>>>>
>>>>>>>>
>>>>>>>> With R1B type, host design after sending command at end of=20
>>>>>>>> completion after end bit waits for 2 cycles for data line to go=20
>>>>>>>> low (busy state from device) and waits for response cycles=20
>>>>>>>> after which data lines will go back high and then we issue=20
>>>>>>>> switch status CMD13.
>>>>>>>>
>>>>>>>>
>>>>>>>>
>>>>>>>> With R1 type, host after sending command and at end of=20
>>>>>>>> completion after end bit, DATA lines will go high immediately=20
>>>>>>>> as its R1 type and switch status CMD13 gets issued but by this=20
>>>>>>>> time it looks like CMD6 on device side is still in flight for=20
>>>>>>>> sending status and data.
>>>>>>> So, yes, using R1 instead of R1B triggers a different behaviour,=20
>>>>>>> but
>>>>>>> according to the eMMC spec it's perfectly allowed to issue a CMD13
>>>>>>> even if the card signals busy on DAT0. The CMD13 is not using=20
>>>>>>> the DATA
>>>>>>> lines, so this should work.
>>>>>>>
>>>>>>> If I understand correctly, your driver (and controller?) has issues
>>>>>>> with coping with this scenario. Is it something that can be fixed?
>>>>>>>
>>>>>>>>
>>>>>>>> 30s timeout is the wait time for data0 line to go high and=20
>>>>>>>> mmc_busy_status will return success right away with R1 response=20
>>>>>>>> type and SW sends switch status CMD13 but during that time on=20
>>>>>>>> device side looks like still processing CMD6 as we are not=20
>>>>>>>> waiting for enough time when we use R1 response type.
>>>>>>> Right, as stated above, isn't sdhci_card_busy() working for your=20
>>>>>>> case?
>>>>>>> Can we fix it?
>>>>>>
>>>>>> sdhci_card_busy() returned 0 indicating its not busy.
>>>>>>
>>>>>> Based on our host design, When CMD6 is issued with R1 type, we=20
>>>>>> program it as NO_RESPONSE and with this command complete=20
>>>>>> interrupt happens right at end bit of command and there will be=20
>>>>>> no transfer complete interrupt.
>>>>> *[Correction] Based on our host design, When CMD6 is issued with=20
>>>>> R1 type as we program it as NO_RESPONSE and with this command=20
>>>>> complete interrupt happens right at end bit of command and there=20
>>>>> will be no transfer complete interrupt.
>>>>
>>>> Sorry to correct wordings, I meant sdhci driver programs response=20
>>>> type as NO_RESPONSE for CMD6.
>>>>
>>>> When CMD6 is issued with R1 type and as NO_RESPONSE, Based on our=20
>>>> host design=C2=A0 command complete interrupt happens right at end bit =
of=20
>>>> command and there will be no transfer complete interrupt.
>>>>
>>>>
>>> Sorry for confusion. Please ignore above on response. it is using=20
>>> SHORT response for R1. So SW poll should be working.
>>>
>>> Will get back on checking on host design side internally.
>>>
>> Hi Ulf,
>>
>> Verified internally regarding the busy state over DATA0 Our host=20
>> design has known minor bug where command complete interrupt is=20
>> asserted after waiting for busy cycles from device.So because of this=20
>> polling for card_busy() returns 0 (DAT0 line High) immediately as=20
>> waiting for busy is taken care during command complete interrupt in=20
>> host design. This behavior is same for R1 and R1B.
>>
>>
>>>>>>
>>>>>> When CMD6 is issued with R1B type, we program is as R1B=20
>>>>>> RESP_SHORT and with this command complete is end bit of device=20
>>>>>> resp and transfer complete interrupt will be when DAT0 LOW -> HIGH.
>>>>>>
>>>>>> Regardless of R1/R1B, device side CMD6 will always have busy=20
>>>>>> state on D0 and response on CMD lines.
>>>>>>
>>>>>> There will be 2 clock cycles period after sending CMD6 for device=20
>>>>>> to send busy state on data0.
>>>>>>
>>>>>> In case of R1 type, after sending command DAT will stay high and=20
>>>>>> looks like we are polling for busy early before busy state has=20
>>>>>> started and sending CMD13 while device is busy and sending=20
>>>>>> response on CMD line is causing timeout.
>>>>>>
>>>>>> Probably with this specific case of CMD6 with R1 type, to wait=20
>>>>>> for card busy we should poll for DAT0 to go Low first and then to=20
>>>>>> go High??
>>>>>>
>>>>>>>
>>>
>>>>>>>>
>>>>>>>>
>>>>>>>>
>>>>>>>> Actually we always use R1B with CMD6 as per spec.
>>>>>>> I fully agree that R1B is preferable, but it's not against the=20
>>>>>>> spec to
>>>>>>> send CMD13 to poll for busy.
>>>>>>>
>>>>>>> Moreover, we need to cope with the scenario when the host has
>>>>>>> specified a maximum timeout that isn't sufficiently long enough for
>>>>>>> the requested operation. Do you have another proposal for how to
>>>>>>> manage this, but disabling MMC_RSP_BUSY?
>>>>>>>
>>>>>>> Let's assume you driver would get a R1B for the CMD6 (we force it),
>>>>>>> then what timeout would the driver be using if we would set
>>>>>>> cmd.busy_timeout to 30ms?
>>>>>>>
>>
> Sorry didn't understood clearly. Are you asking with 30s timeout,=20
> whats the data timeout counter used?
>
> Because of above mentioned issue on our host where CMD interrupt=20
> happens after busy state, poll for busy returns right away as not busy.
>
> So issuing CMD13 after CMD6-R1 followed by busy poll should be=20
> working. But weird that with small delay of 1ms or debug print before=20
> CMD13 it doesn't timeout and works all the time.
>
>
With R1B for CMD6, busy detection timeout on our host is 11s (data=20
timeout count =3D 0xE)
>>>>>>> Kind regards
>>>>>>> Uffe
