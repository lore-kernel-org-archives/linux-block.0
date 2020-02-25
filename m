Return-Path: <SRS0=qPv+=4N=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AF356C35E04
	for <linux-block@archiver.kernel.org>; Tue, 25 Feb 2020 16:24:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 82EE52082F
	for <linux-block@archiver.kernel.org>; Tue, 25 Feb 2020 16:24:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nvidia.com header.i=@nvidia.com header.b="kWdhcXQK"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730863AbgBYQYq (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 25 Feb 2020 11:24:46 -0500
Received: from hqnvemgate26.nvidia.com ([216.228.121.65]:14686 "EHLO
        hqnvemgate26.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729817AbgBYQYp (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 25 Feb 2020 11:24:45 -0500
Received: from hqpgpgate101.nvidia.com (Not Verified[216.228.121.13]) by hqnvemgate26.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5e554a3f0000>; Tue, 25 Feb 2020 08:24:31 -0800
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate101.nvidia.com (PGP Universal service);
  Tue, 25 Feb 2020 08:24:44 -0800
X-PGP-Universal: processed;
        by hqpgpgate101.nvidia.com on Tue, 25 Feb 2020 08:24:44 -0800
Received: from [10.21.133.51] (172.20.13.39) by HQMAIL107.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Tue, 25 Feb
 2020 16:24:41 +0000
Subject: Re: LKFT: arm x15: mmc1: cache flush error -110
To:     Ulf Hansson <ulf.hansson@linaro.org>,
        Faiz Abbas <faiz_abbas@ti.com>,
        Sowjanya Komatineni <skomatineni@nvidia.com>
CC:     Bitan Biswas <bbiswas@nvidia.com>,
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
        Thierry Reding <treding@nvidia.com>
References: <CA+G9fYuqAQfhzF2BzHr7vMHx68bo8-jT+ob_F3eHQ3=oFjgYdg@mail.gmail.com>
 <CAPDyKFqqhxC-pmV_j8PLY-D=AbqCAbiipAAHXLpJ4N_BiYYOFw@mail.gmail.com>
 <CA+G9fYugQuAERqp3VXUFG-3QxXoF8bz7OSMh6WGSZcrGkbfDSQ@mail.gmail.com>
 <CAPDyKFo-vEO7zN_F+NqcKtnKmAo_deOZx3gYNiks3yTAQAjv-Q@mail.gmail.com>
 <a602a27a-b960-ce56-c541-3b4b95f5dce2@nvidia.com>
 <CAPDyKFrXQgtHa4gLaKUi_F0rs4FMBai3Y_+TcHZR_zpkb0B4QQ@mail.gmail.com>
 <6523119a-50ac-973a-d1cd-ab1569259411@nvidia.com>
 <f960aa98-5508-36fd-166d-7f41c7d85154@nvidia.com>
 <CAPDyKFokE6x0mn+v5B9=so-SyrdTn0JBU8Mrp3Zdu6kSaCie2g@mail.gmail.com>
From:   Jon Hunter <jonathanh@nvidia.com>
Message-ID: <0963b60f-15e7-4bc6-10df-6fc8003e4d42@nvidia.com>
Date:   Tue, 25 Feb 2020 16:24:38 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <CAPDyKFokE6x0mn+v5B9=so-SyrdTn0JBU8Mrp3Zdu6kSaCie2g@mail.gmail.com>
X-Originating-IP: [172.20.13.39]
X-ClientProxiedBy: HQMAIL107.nvidia.com (172.20.187.13) To
 HQMAIL107.nvidia.com (172.20.187.13)
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1582647871; bh=d+k2oADQBKeJHCExPW9X42DfdEf4wTEDT/QfdHMU5IM=;
        h=X-PGP-Universal:Subject:To:CC:References:From:Message-ID:Date:
         User-Agent:MIME-Version:In-Reply-To:X-Originating-IP:
         X-ClientProxiedBy:Content-Type:Content-Language:
         Content-Transfer-Encoding;
        b=kWdhcXQKSJH4GXa6xSkXVhbj0mroRtOyJ6fnisSE9GfHmcEkd+fFWgatHxHs9IYib
         TIT861jiVMWct2KGXdBFUnuz93ncHEEos7SfypX0n4Lb8z+0RL8QGT5xJWD75wupir
         yz0sPoHdlKRuA1JlUgef7zx/r24mxhiIiuTPFFT08JwydZt+Skpkum8t5c6F2IhzXz
         jKEYhTQyc2xHXPD8GHsN18TntYROuk+3yZd/5IUGoCfMszcdk9oFv4u+4gyjxVaEeZ
         0EFR+RoPiIATIToqWkAMtrrtqId6IKNMS08ObahXZPI9ib6XI09J9/cGGQcqlsu8zP
         VP3GAeLJ37K4g==
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org


On 25/02/2020 14:26, Ulf Hansson wrote:

...

> However, from the core point of view, the response is still requested,
> only that we don't want the driver to wait for the card to stop
> signaling busy. Instead we want to deal with that via "polling" from
> the core.
> 
> This is a rather worrying behaviour, as it seems like the host driver
> doesn't really follow this expectations from the core point of view.
> And mmc_flush_cache() is not the only case, as we have erase, bkops,
> sanitize, etc. Are all these working or not really well tested?

I don't believe that they are well tested. We have a simple test to
mount an eMMC partition, create a file, check the contents, remove the
file and unmount. The timeouts always occur during unmounting.

> Earlier, before my three patches, if the provided timeout_ms parameter
> to __mmc_switch() was zero, which was the case for
> mmc_mmc_flush_cache() - this lead to that __mmc_switch() simply
> ignored validating host->max_busy_timeout, which was wrong. In any
> case, this also meant that an R1B response was always used for
> mmc_flush_cache(), as you also indicated above. Perhaps this is the
> critical part where things can go wrong.
> 
> BTW, have you tried erase commands for sdhci tegra driver? If those
> are working fine, do you have any special treatments for these?

That I am not sure, but I will check.

Cheers
Jon

-- 
nvpublic
