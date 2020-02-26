Return-Path: <SRS0=LW4I=4O=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 04715C4BA1C
	for <linux-block@archiver.kernel.org>; Wed, 26 Feb 2020 17:05:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CFA6D20637
	for <linux-block@archiver.kernel.org>; Wed, 26 Feb 2020 17:05:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nvidia.com header.i=@nvidia.com header.b="p/bZ0fff"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728066AbgBZRFC (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 26 Feb 2020 12:05:02 -0500
Received: from hqnvemgate24.nvidia.com ([216.228.121.143]:17429 "EHLO
        hqnvemgate24.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727470AbgBZRFC (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 26 Feb 2020 12:05:02 -0500
Received: from hqpgpgate101.nvidia.com (Not Verified[216.228.121.13]) by hqnvemgate24.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5e56a4ee0000>; Wed, 26 Feb 2020 09:03:42 -0800
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate101.nvidia.com (PGP Universal service);
  Wed, 26 Feb 2020 09:05:00 -0800
X-PGP-Universal: processed;
        by hqpgpgate101.nvidia.com on Wed, 26 Feb 2020 09:05:00 -0800
Received: from [10.21.133.51] (10.124.1.5) by HQMAIL107.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Wed, 26 Feb
 2020 17:04:56 +0000
Subject: Re: LKFT: arm x15: mmc1: cache flush error -110
To:     Ulf Hansson <ulf.hansson@linaro.org>,
        Faiz Abbas <faiz_abbas@ti.com>,
        Bitan Biswas <bbiswas@nvidia.com>
CC:     Sowjanya Komatineni <skomatineni@nvidia.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Naresh Kamboju <naresh.kamboju@linaro.org>,
        "Jens Axboe" <axboe@kernel.dk>,
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
From:   Jon Hunter <jonathanh@nvidia.com>
Message-ID: <f1711223-91ba-c567-2983-b4783aa7601b@nvidia.com>
Date:   Wed, 26 Feb 2020 17:04:54 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <CAPDyKFq5NoeHEBK3sv3yOSD2+pm9FueH1gaTyPq0j7GLfa6vnA@mail.gmail.com>
X-Originating-IP: [10.124.1.5]
X-ClientProxiedBy: HQMAIL101.nvidia.com (172.20.187.10) To
 HQMAIL107.nvidia.com (172.20.187.13)
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1582736623; bh=6D+i0xe21mqqX6n5OUovAjoW11aRjUA9+tewaNzxrek=;
        h=X-PGP-Universal:Subject:To:CC:References:From:Message-ID:Date:
         User-Agent:MIME-Version:In-Reply-To:X-Originating-IP:
         X-ClientProxiedBy:Content-Type:Content-Language:
         Content-Transfer-Encoding;
        b=p/bZ0fff0n82hLSAwmcx0IFIA2eqFqLqQpyfZXDEcFPIUummqVfxXcQTIuqyWF1/i
         SK/uMll2Si5bisQfKYh75ukgPugxg8f5/KJxFg5Tvyqxit8Zt0NkpaME9B18VW1yuW
         JS0E1SOHEMh+5MYI7tHYpzV4sOHKWFn5VCNdIRLYbxNidMpYk2T5S5Ys9L511i8e9C
         /p/NOzHkP9Ju5PZj83rIjEHNOtbqWncEHAArlMGWO6iKfvDzpmcDdRWl7Guy+uXUQT
         /ShWW4i3pz16zR9rs4UhROn0VeKrSGkYunKEGxUh6mwVYDBCjAseQt3DxiwjneA60T
         GUOFOGxsNEouA==
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org


On 26/02/2020 15:21, Ulf Hansson wrote:
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

So no I don't believe that we have explicitly tried erase commands and
no there is nothing special that we are doing for erase.

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

OK, let me check to see who can help from our side.

Cheers
Jon

-- 
nvpublic
