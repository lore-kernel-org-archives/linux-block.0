Return-Path: <SRS0=QOfo=4T=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 87AEFC3F2D2
	for <linux-block@archiver.kernel.org>; Mon,  2 Mar 2020 13:11:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4E87E21739
	for <linux-block@archiver.kernel.org>; Mon,  2 Mar 2020 13:11:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="pNieg9sN"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727543AbgCBNLM (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 2 Mar 2020 08:11:12 -0500
Received: from lelv0142.ext.ti.com ([198.47.23.249]:48610 "EHLO
        lelv0142.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727107AbgCBNLM (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Mon, 2 Mar 2020 08:11:12 -0500
Received: from fllv0034.itg.ti.com ([10.64.40.246])
        by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id 022DAw2L071227;
        Mon, 2 Mar 2020 07:10:58 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1583154658;
        bh=WOSq9y6rCEhZW0FkxG8Whfp5Agrr46Y+r+ygfnL02xw=;
        h=Subject:To:CC:References:From:Date:In-Reply-To;
        b=pNieg9sNQ290W0dYPDFpOF7XgGdxgmgR2vVpUc+sBfUnDB5XNEZd3qy8A4PuIksow
         8rL1aeWYSS/6x9+ptkPFp+M53stnAM6DhaEAAmFqVs1MWCcjxm+Ww2Iae+abI1/F/W
         Ew4Lt08ky++b4OzDhnvfniXD82VXugif3ZhPe26s=
Received: from DLEE103.ent.ti.com (dlee103.ent.ti.com [157.170.170.33])
        by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 022DAwK9065900
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Mon, 2 Mar 2020 07:10:58 -0600
Received: from DLEE103.ent.ti.com (157.170.170.33) by DLEE103.ent.ti.com
 (157.170.170.33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1847.3; Mon, 2 Mar
 2020 07:10:57 -0600
Received: from localhost.localdomain (10.64.41.19) by DLEE103.ent.ti.com
 (157.170.170.33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1847.3 via
 Frontend Transport; Mon, 2 Mar 2020 07:10:57 -0600
Received: from [10.24.69.157] (ileax41-snat.itg.ti.com [10.172.224.153])
        by localhost.localdomain (8.15.2/8.15.2) with ESMTP id 022DAqtk053018;
        Mon, 2 Mar 2020 07:10:53 -0600
Subject: Re: LKFT: arm x15: mmc1: cache flush error -110
To:     Ulf Hansson <ulf.hansson@linaro.org>,
        Jon Hunter <jonathanh@nvidia.com>,
        Bitan Biswas <bbiswas@nvidia.com>
CC:     Sowjanya Komatineni <skomatineni@nvidia.com>,
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
        Thierry Reding <treding@nvidia.com>,
        Anders Roxell <anders.roxell@linaro.org>,
        Kishon <kishon@ti.com>
References: <CA+G9fYuqAQfhzF2BzHr7vMHx68bo8-jT+ob_F3eHQ3=oFjgYdg@mail.gmail.com>
 <CAPDyKFqqhxC-pmV_j8PLY-D=AbqCAbiipAAHXLpJ4N_BiYYOFw@mail.gmail.com>
 <CA+G9fYugQuAERqp3VXUFG-3QxXoF8bz7OSMh6WGSZcrGkbfDSQ@mail.gmail.com>
 <CAPDyKFo-vEO7zN_F+NqcKtnKmAo_deOZx3gYNiks3yTAQAjv-Q@mail.gmail.com>
 <a602a27a-b960-ce56-c541-3b4b95f5dce2@nvidia.com>
 <CAPDyKFrXQgtHa4gLaKUi_F0rs4FMBai3Y_+TcHZR_zpkb0B4QQ@mail.gmail.com>
 <6523119a-50ac-973a-d1cd-ab1569259411@nvidia.com>
 <f960aa98-5508-36fd-166d-7f41c7d85154@nvidia.com>
 <CAPDyKFokE6x0mn+v5B9=so-SyrdTn0JBU8Mrp3Zdu6kSaCie2g@mail.gmail.com>
 <0963b60f-15e7-4bc6-10df-6fc8003e4d42@nvidia.com>
 <CAPDyKFq5NoeHEBK3sv3yOSD2+pm9FueH1gaTyPq0j7GLfa6vnA@mail.gmail.com>
From:   Faiz Abbas <faiz_abbas@ti.com>
Message-ID: <34fd84d7-387b-b6f3-7fb3-aa490909e205@ti.com>
Date:   Mon, 2 Mar 2020 18:42:45 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <CAPDyKFq5NoeHEBK3sv3yOSD2+pm9FueH1gaTyPq0j7GLfa6vnA@mail.gmail.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Uffe,

On 26/02/20 8:51 pm, Ulf Hansson wrote:
> + Anders, Kishon
> 
> On Tue, 25 Feb 2020 at 17:24, Jon Hunter <jonathanh@nvidia.com> wrote:
>>
>>
>> On 25/02/2020 14:26, Ulf Hansson wrote:
>>
>> ...
>>
>>> However, from the core point of view, the response is still requested,
>>> only that we don't want the driver to wait for the card to stop
>>> signaling busy. Instead we want to deal with that via "polling" from
>>> the core.
>>>
>>> This is a rather worrying behaviour, as it seems like the host driver
>>> doesn't really follow this expectations from the core point of view.
>>> And mmc_flush_cache() is not the only case, as we have erase, bkops,
>>> sanitize, etc. Are all these working or not really well tested?
>>
>> I don't believe that they are well tested. We have a simple test to
>> mount an eMMC partition, create a file, check the contents, remove the
>> file and unmount. The timeouts always occur during unmounting.
>>
>>> Earlier, before my three patches, if the provided timeout_ms parameter
>>> to __mmc_switch() was zero, which was the case for
>>> mmc_mmc_flush_cache() - this lead to that __mmc_switch() simply
>>> ignored validating host->max_busy_timeout, which was wrong. In any
>>> case, this also meant that an R1B response was always used for
>>> mmc_flush_cache(), as you also indicated above. Perhaps this is the
>>> critical part where things can go wrong.
>>>
>>> BTW, have you tried erase commands for sdhci tegra driver? If those
>>> are working fine, do you have any special treatments for these?
>>
>> That I am not sure, but I will check.
> 
> Great, thanks. Looking forward to your report.
> 
> So, from my side, me and Anders Roxell, have been collaborating on
> testing the behaviour on a TI Beagleboard x15 (remotely with limited
> debug options), which is using the sdhci-omap variant. I am trying to
> get hold of an Nvidia jetson-TX2, but not found one yet. These are the
> conclusions from the observed behaviour on the Beagleboard for the
> CMD6 cache flush command.
> 
> First, the reported host->max_busy_timeout is 2581 (ms) for the
> sdhci-omap driver in this configuration.
> 
> 1. As we all know by now, the cache flush command (CMD6) fails with
> -110 currently. This is when MMC_CACHE_FLUSH_TIMEOUT_MS is set to 30 *
> 1000 (30s), which means __mmc_switch() drops the MMC_RSP_BUSY flag
> from the command.
> 
> 2. Changing the MMC_CACHE_FLUSH_TIMEOUT_MS to 2000 (2s), means that
> the MMC_RSP_BUSY flag becomes set by __mmc_switch, because of the
> timeout_ms parameter is less than max_busy_timeout (2000 <  2581).
> Then everything works fine.
> 
> 3. Updating the code to again use 30s as the
> MMC_CACHE_FLUSH_TIMEOUT_MS, but instead forcing the MMC_RSP_BUSY to be
> set, even when the timeout_ms becomes greater than max_busy_timeout.
> This also works fine.
> 
> Clearly this indicates a problem that I think needs to be addressed in
> the sdhci driver. However, of course I can revert the three discussed
> patches to fix the problem, but that would only hide the issues and I
> am sure we would then get back to this issue, sooner or later.
> 
> To fix the problem in the sdhci driver, I would appreciate if someone
> from TI and Nvidia can step in to help, as I don't have the HW on my
> desk.
> 
> Comments or other ideas of how to move forward?
> 

Sorry I missed this earlier.

I don't have an X15 with me here but I'm trying to set one up in our
remote farm. In the meantime, I tried to reproduce this issue on two
platforms (dra72-evm and am57xx-evm) and wasn't able to see the issue
because those eMMC's don't even have a cache. I will keep you updated
when I do get a board with a eMMC that has a cache.

Is there a way to reproduce this CMD6 issue with another operation?

Thanks,
Faiz
