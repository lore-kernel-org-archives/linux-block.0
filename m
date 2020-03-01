Return-Path: <SRS0=IUku=4S=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 76579C3F2CD
	for <linux-block@archiver.kernel.org>; Sun,  1 Mar 2020 23:09:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4BA6A246B6
	for <linux-block@archiver.kernel.org>; Sun,  1 Mar 2020 23:09:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="sxTPbIe4"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726880AbgCAXJO (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Sun, 1 Mar 2020 18:09:14 -0500
Received: from mail-lj1-f195.google.com ([209.85.208.195]:42355 "EHLO
        mail-lj1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726050AbgCAXJN (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Sun, 1 Mar 2020 18:09:13 -0500
Received: by mail-lj1-f195.google.com with SMTP id d10so9650226ljl.9;
        Sun, 01 Mar 2020 15:09:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=Iq/KgsrwSxvpby2goIRSH5cRmhkTMkp2al5Cysx8Mb8=;
        b=sxTPbIe4c0Af60ar6aopox61tDGdoAuteIgqFp7R5KXi86Vy1mfYhYNHGsK14ibx3a
         mcMFmdbVr7glbJp7SCAeuMCo6reqCCND/4iXa2mqVx4u3dob92i6T/iQ3BthiNKhcFAt
         Vjpg/Fqx5zZp4gBvqmr5YZv6N/iIhSxMNQjUGLbZPFNZCFxIcInoMtXoKT9hmdben2lV
         wRWSl/rgp4Ex+aijp7Wl7zGPIEUfYYKfdiSnOIS2hoZLB9lbmeGHZuf3B83sKOfBdKqZ
         E5tc0YE9L59eEy6QLd5bGrnexepaa+S91WaccPZwuNj3jpRmtAuvtH4n9Fx9aGuRRHij
         OkMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=Iq/KgsrwSxvpby2goIRSH5cRmhkTMkp2al5Cysx8Mb8=;
        b=m2f6xhH/rzk3TVkpBOg2dpHUTKcv/6d8WkbJ+JANYlxSeaSiKRMapzX1g8lvrmD3tg
         NwGjp7PzklEtyJOCZlrnanCOa4WNVRDSDNg0c1uCKM78O0DfhkbB/vS6kO72umrjHMzd
         IRAQA3MBHFIHKnv5AUx0HarGIwbzVVXQ1VEttbrPov/sxee7RD1VQ13qKL1UO55qJDrM
         G7a2fnPjEKIm3kyOQDb10qz0Om5v6fiQGAGtfCBsyOdGI48KLh5pH0AiB3n9xY1XkMsZ
         3r22/FbpKdCXLKrQniv13aUB4RtyEOqXaUsUaZJOIxjfwJWAqowldI3IHcCeETxqeCoq
         SC/Q==
X-Gm-Message-State: ANhLgQ3HqFPaiiFHiLPBSxFGu1OO1K2TI6Q2HIUN76IqvJpuIZpQJ/Cv
        jR9d3nEC2PqXnJ7Upy3McCaUGEz/
X-Google-Smtp-Source: ADFU+vvVUAThE91+zafUv8AYR5mKTxcSsZQoMmBQquYfQex92iJVJ4aUm5nQ5wDKyofWYP7XnhhrXg==
X-Received: by 2002:a2e:8490:: with SMTP id b16mr9849000ljh.282.1583104151055;
        Sun, 01 Mar 2020 15:09:11 -0800 (PST)
Received: from [192.168.2.145] (79-139-233-37.dynamic.spd-mgts.ru. [79.139.233.37])
        by smtp.googlemail.com with ESMTPSA id f14sm9401803lfh.40.2020.03.01.15.09.09
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 01 Mar 2020 15:09:09 -0800 (PST)
Subject: Re: [PATCH v1 1/3] mmc: core: Add raw_boot_mult field to mmc_ext_csd
To:     Avri Altman <Avri.Altman@wdc.com>, Jens Axboe <axboe@kernel.dk>,
        Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        =?UTF-8?B?TWljaGHFgiBNaXJvc8WCYXc=?= <mirq-linux@rere.qmqm.pl>,
        David Heidelberg <david@ixit.cz>,
        Peter Geis <pgwipeout@gmail.com>,
        Stephen Warren <swarren@wwwdotorg.org>,
        Nicolas Chauvet <kwizart@gmail.com>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Billy Laws <blaws05@gmail.com>
Cc:     "linux-tegra@vger.kernel.org" <linux-tegra@vger.kernel.org>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        Andrey Danin <danindrey@mail.ru>,
        Gilles Grandou <gilles@grandou.net>,
        Ryan Grachek <ryan@edited.us>,
        "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
References: <20200224231841.26550-1-digetx@gmail.com>
 <20200224231841.26550-2-digetx@gmail.com>
 <MN2PR04MB699121991FCB80BE39FC106FFCE60@MN2PR04MB6991.namprd04.prod.outlook.com>
From:   Dmitry Osipenko <digetx@gmail.com>
Message-ID: <0fb5f6ec-8aa0-3bc8-e6cc-8e061c401839@gmail.com>
Date:   Mon, 2 Mar 2020 02:09:08 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <MN2PR04MB699121991FCB80BE39FC106FFCE60@MN2PR04MB6991.namprd04.prod.outlook.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

01.03.2020 13:50, Avri Altman пишет:
> Hi,
>>
>>
>> In order to support parsing of NVIDIA Tegra Partition Table format, we
>> need to know the BOOT_SIZE_MULT value of the Extended CSD register
>> because
>> NVIDIA's bootloader linearizes the boot0/boot1/main partitions into a
>> single virtual space, and thus, all partition addresses are shifted by
>> the size of boot0 + boot1 partitions.
>>
>> Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
>> ---
>>  drivers/mmc/core/mmc.c   | 2 ++
>>  include/linux/mmc/card.h | 1 +
>>  2 files changed, 3 insertions(+)
>>
>> diff --git a/drivers/mmc/core/mmc.c b/drivers/mmc/core/mmc.c
>> index f6912ded652d..88e5b4224d3c 100644
>> --- a/drivers/mmc/core/mmc.c
>> +++ b/drivers/mmc/core/mmc.c
>> @@ -417,6 +417,8 @@ static int mmc_decode_ext_csd(struct mmc_card
>> *card, u8 *ext_csd)
>>                 ext_csd[EXT_CSD_ERASE_TIMEOUT_MULT];
>>         card->ext_csd.raw_hc_erase_grp_size =
>>                 ext_csd[EXT_CSD_HC_ERASE_GRP_SIZE];
>> +       card->ext_csd.raw_boot_mult =
>> +               ext_csd[EXT_CSD_BOOT_MULT];
> You might want at this point multiply it by 128K,
> And get rid of: part_size = ext_csd[EXT_CSD_BOOT_MULT] << 17;
> Below...

But it's not a *raw* _boot_mult anymore then. I'm not sure that it will
be a worthwhile change.
