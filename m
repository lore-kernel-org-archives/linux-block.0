Return-Path: <SRS0=qPv+=4N=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CCC95C35DF5
	for <linux-block@archiver.kernel.org>; Tue, 25 Feb 2020 11:41:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9D3E920CC7
	for <linux-block@archiver.kernel.org>; Tue, 25 Feb 2020 11:41:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nvidia.com header.i=@nvidia.com header.b="jcoG8NiU"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730170AbgBYLlg (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 25 Feb 2020 06:41:36 -0500
Received: from hqnvemgate25.nvidia.com ([216.228.121.64]:1756 "EHLO
        hqnvemgate25.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729178AbgBYLlg (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 25 Feb 2020 06:41:36 -0500
Received: from hqpgpgate101.nvidia.com (Not Verified[216.228.121.13]) by hqnvemgate25.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5e5507cc0000>; Tue, 25 Feb 2020 03:41:00 -0800
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate101.nvidia.com (PGP Universal service);
  Tue, 25 Feb 2020 03:41:35 -0800
X-PGP-Universal: processed;
        by hqpgpgate101.nvidia.com on Tue, 25 Feb 2020 03:41:35 -0800
Received: from [10.21.133.51] (172.20.13.39) by HQMAIL107.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Tue, 25 Feb
 2020 11:41:33 +0000
Subject: Re: LKFT: arm x15: mmc1: cache flush error -110
From:   Jon Hunter <jonathanh@nvidia.com>
To:     Ulf Hansson <ulf.hansson@linaro.org>,
        Bitan Biswas <bbiswas@nvidia.com>,
        Adrian Hunter <adrian.hunter@intel.com>
CC:     Naresh Kamboju <naresh.kamboju@linaro.org>,
        Jens Axboe <axboe@kernel.dk>,
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
Message-ID: <f960aa98-5508-36fd-166d-7f41c7d85154@nvidia.com>
Date:   Tue, 25 Feb 2020 11:41:31 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <6523119a-50ac-973a-d1cd-ab1569259411@nvidia.com>
X-Originating-IP: [172.20.13.39]
X-ClientProxiedBy: HQMAIL107.nvidia.com (172.20.187.13) To
 HQMAIL107.nvidia.com (172.20.187.13)
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1582630860; bh=kN3trSKoccgVaVoLzgLr6MddKiuYEMaFJBNPZvEzBt8=;
        h=X-PGP-Universal:Subject:From:To:CC:References:Message-ID:Date:
         User-Agent:MIME-Version:In-Reply-To:X-Originating-IP:
         X-ClientProxiedBy:Content-Type:Content-Language:
         Content-Transfer-Encoding;
        b=jcoG8NiUW+9/vpRg5f9yNJFSRtICczCMS8LRMfCL22Ns33XRFKglyjZTyZdFKI1m/
         Xy7Qhvsmwo5Bfjzdk5oi2yuKlXEo2gDO8LdneqUJix7SjcERGs2iL0jOE1qcrBPSUG
         Dp1vG4V4r4Usty1XFbQLi/KD8nM3x8k77voEA+fNzW+ATMmbQcgF71bxv9MrdBf8I5
         o46ihG47nP8qEAeDJJTouOdZT5CJrbgU6eEar/y1qbXd4xyfdibd8AgzskBQIbMdaf
         MBAdVvI0rxU6J67yhiPoMs2JbPAWJubD5/z4z2C1BCYRe29OpVgWjmLHYqEKUSljYQ
         YIHTQOut/qpwQ==
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org


On 25/02/2020 10:04, Jon Hunter wrote:

...

>>>   I find that from the commit the changes in mmc_flush_cache below is
>>> the cause.
>>>
>>> ##
>>> @@ -961,7 +963,8 @@ int mmc_flush_cache(struct mmc_card *card)
>>>                          (card->ext_csd.cache_size > 0) &&
>>>                          (card->ext_csd.cache_ctrl & 1)) {
>>>                  err = mmc_switch(card, EXT_CSD_CMD_SET_NORMAL,
>>> -                               EXT_CSD_FLUSH_CACHE, 1, 0);
>>> +                                EXT_CSD_FLUSH_CACHE, 1,
>>> +                                MMC_CACHE_FLUSH_TIMEOUT_MS);
> 
> 
> I no longer see the issue on reverting the above hunk as Bitan suggested
> but now I see the following (which is expected) ...
> 
>  WARNING KERN mmc1: unspecified timeout for CMD6 - use generic

For Tegra, the default timeout used when no timeout is specified for CMD6
is 100mS. So hard-coding the following also appears to workaround the
problem on Tegra ...

diff --git a/drivers/mmc/core/mmc_ops.c b/drivers/mmc/core/mmc_ops.c
index 868653bc1555..5155e0240fca 100644
--- a/drivers/mmc/core/mmc_ops.c
+++ b/drivers/mmc/core/mmc_ops.c
@@ -992,7 +992,7 @@ int mmc_flush_cache(struct mmc_card *card)
                        (card->ext_csd.cache_size > 0) &&
                        (card->ext_csd.cache_ctrl & 1)) {
                err = mmc_switch(card, EXT_CSD_CMD_SET_NORMAL,
-                                EXT_CSD_FLUSH_CACHE, 1, 0);
+                                EXT_CSD_FLUSH_CACHE, 1, 100);
                if (err)
                        pr_err("%s: cache flush error %d\n",
                                        mmc_hostname(card->host), err);

So the problem appears to be causing by the timeout being too long rather
than not long enough. 

Looking more at the code, I think now that we are hitting the condition
...

diff --git a/drivers/mmc/core/mmc_ops.c b/drivers/mmc/core/mmc_ops.c
index 868653bc1555..feae82b1ff35 100644
--- a/drivers/mmc/core/mmc_ops.c
+++ b/drivers/mmc/core/mmc_ops.c
@@ -579,8 +579,10 @@ int __mmc_switch(struct mmc_card *card, u8 set, u8 index, u8 value,
         * the host to avoid HW busy detection, by converting to a R1 response
         * instead of a R1B.
         */
-       if (host->max_busy_timeout && (timeout_ms > host->max_busy_timeout))
+       if (host->max_busy_timeout && (timeout_ms > host->max_busy_timeout)) {
+               pr_warn("%s: timeout (%d) > max busy timeout (%d)", mmc_hostname(host), timeout_ms, host->max_busy_timeout);
                use_r1b_resp = false;
+       }


With the above I see ...

 WARNING KERN mmc1: timeout (1600) > max busy timeout (672)

So with the longer timeout we are not using/requesting the response.

Cheers
Jon

-- 
nvpublic
