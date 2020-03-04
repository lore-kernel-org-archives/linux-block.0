Return-Path: <SRS0=k6TP=4V=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 54DF6C3F2CE
	for <linux-block@archiver.kernel.org>; Wed,  4 Mar 2020 17:09:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2C4EF22B48
	for <linux-block@archiver.kernel.org>; Wed,  4 Mar 2020 17:09:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="rIcS+2ej"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727308AbgCDRJU (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 4 Mar 2020 12:09:20 -0500
Received: from mail-lf1-f65.google.com ([209.85.167.65]:38906 "EHLO
        mail-lf1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726915AbgCDRJU (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Wed, 4 Mar 2020 12:09:20 -0500
Received: by mail-lf1-f65.google.com with SMTP id x22so2138748lff.5;
        Wed, 04 Mar 2020 09:09:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=yBZl3/9H7qG9t1GNuyPAhwaMbhvgRw8oAIP4mrCDQgs=;
        b=rIcS+2ejqyuy3Or/TxDzvhbS0RjAO9grbala4uKp9TkZwSL/5Viw5A9kGIV5D2BKbx
         AxY/ZqCamkTU2MUinGOxrxqa1N+/wZWi5RdlUUdyMIw5Vd8BmAEpf9r81qddGJqWztif
         T/1GRWfoq1fm5/NQhGQmO/vxc0LgrHSwmD8a+ODGMMrNK+aztcl64OTnt4DxQ+0u8WEP
         e7Tr7n5Y+IyiWefPikWfQJoOHbGNb3jXhRNu1dn8lX6Aitl1JhY7ED0y9tdil38BYE/N
         fSConbhm/ZN556D61NU6fh2KQnP32TgPdOomVRvPEqMVlBAWwMuXfUBm/SF/0yxrlP5m
         1CNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=yBZl3/9H7qG9t1GNuyPAhwaMbhvgRw8oAIP4mrCDQgs=;
        b=iWmhNFZ5WxRQEaV1NCy4O0tCp6z3BWSDF8v5Kh14WgfOSmSYXhmRdC2P+/rdZjHMBE
         yZT1MGqErCtIPHMCa2YIYfvZDvDZpkbZbU9TepYmyDsF+c615eDl6+EZ+wa2cEhz3yVc
         JzNP/vLEzC0KsNvC7q+Cm6IjKgsphmgSsR330Ayhm9mUjUjazvicrCVUEoiG4AUcp8TJ
         e/wdyXWDyuZmm5+/E4JypZHLGZN7mba5aKqUCACXs11I19Xm/NCEZWizAWkYqK7xuJFx
         gudU+1HUis7q7gKYZaBLb2iB4heF0phCQbzHVJqRK45KYR0brPiHJt5Fv6AGwjr/9W0h
         Ctng==
X-Gm-Message-State: ANhLgQ3oXGbPQrihcmfXkLdo4DbCfSnf4dHOg33kcuXf5A8ky1q9zv9A
        thBS9MOD0Oxwm70fUA8Iw2Hst0dG
X-Google-Smtp-Source: ADFU+vuG3z6ZnGM1bBt/YG1AYECEmQSaA1rt4z0OWiGLEyfUTpo8iXhF1qDr8fpQC9WQIGwBx+ugxQ==
X-Received: by 2002:ac2:4a84:: with SMTP id l4mr2533938lfp.217.1583341756930;
        Wed, 04 Mar 2020 09:09:16 -0800 (PST)
Received: from [192.168.2.145] (94-29-39-224.dynamic.spd-mgts.ru. [94.29.39.224])
        by smtp.googlemail.com with ESMTPSA id v15sm13994290lfg.51.2020.03.04.09.09.15
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 04 Mar 2020 09:09:16 -0800 (PST)
Subject: Re: [PATCH v1 3/3] partitions: Introduce NVIDIA Tegra Partition Table
To:     Ulf Hansson <ulf.hansson@linaro.org>,
        Stephen Warren <swarren@wwwdotorg.org>
Cc:     Jens Axboe <axboe@kernel.dk>,
        Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        =?UTF-8?B?TWljaGHFgiBNaXJvc8WCYXc=?= <mirq-linux@rere.qmqm.pl>,
        David Heidelberg <david@ixit.cz>,
        Peter Geis <pgwipeout@gmail.com>,
        Nicolas Chauvet <kwizart@gmail.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Billy Laws <blaws05@gmail.com>,
        linux-tegra <linux-tegra@vger.kernel.org>,
        linux-block <linux-block@vger.kernel.org>,
        Andrey Danin <danindrey@mail.ru>,
        Gilles Grandou <gilles@grandou.net>,
        Ryan Grachek <ryan@edited.us>,
        "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <20200224231841.26550-1-digetx@gmail.com>
 <20200224231841.26550-4-digetx@gmail.com>
 <44c22925-a14e-96d0-1f93-1979c0c60525@wwwdotorg.org>
 <CAPDyKFoXnoukjH_2cM=f0DGHBHS6kVUQSYOa_5ffQppC7VOn2A@mail.gmail.com>
From:   Dmitry Osipenko <digetx@gmail.com>
Message-ID: <824a4d5f-8280-8860-3e80-68188a13aa3d@gmail.com>
Date:   Wed, 4 Mar 2020 20:09:14 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <CAPDyKFoXnoukjH_2cM=f0DGHBHS6kVUQSYOa_5ffQppC7VOn2A@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

04.03.2020 19:36, Ulf Hansson пишет:
> On Tue, 25 Feb 2020 at 01:20, Stephen Warren <swarren@wwwdotorg.org> wrote:
>>
>> On 2/24/20 4:18 PM, Dmitry Osipenko wrote:
>>> All NVIDIA Tegra devices use a special partition table format for the
>>> internal storage partitioning. Most of Tegra devices have GPT partition
>>> in addition to TegraPT, but some older Android consumer-grade devices do
>>> not or GPT is placed in a wrong sector, and thus, the TegraPT is needed
>>> in order to support these devices properly in the upstream kernel. This
>>> patch adds support for NVIDIA Tegra Partition Table format that is used
>>> at least by all NVIDIA Tegra20 and Tegra30 devices.
>>
>>> diff --git a/arch/arm/mach-tegra/tegra.c b/arch/arm/mach-tegra/tegra.c
>>
>>> +static void __init tegra_boot_config_table_init(void)
>>> +{
>>> +     void __iomem *bct_base;
>>> +     u16 pt_addr, pt_size;
>>> +
>>> +     bct_base = IO_ADDRESS(TEGRA_IRAM_BASE) + TEGRA_IRAM_BCT_OFFSET;
>>
>> This shouldn't be hard-coded. IIRC, the boot ROM writes a BIT (Boot
>> Information Table) to a fixed location in IRAM, and there's some value
>> in the BIT that points to where the BCT is in IRAM. In practice, it
>> might work out that the BCT is always at the same place in IRAM, but
>> this certainly isn't guaranteed. I think there's code in U-Boot which
>> extracts the BCT location from the BIT? Yes, see
>> arch/arm/mach-tegra/ap.c:get_odmdata().
> 
> So, have you considered using the command line partition option,
> rather than adding yet another partition scheme to the kernel?
> 
> In principle, you would let the boot loader scan for the partitions,
> likely from machine specific code in U-boot. Then you append these to
> the kernel command line and let block/partitions/cmdline.c scan for
> it.

The bootloader is usually locked-down on a consumer Tegra machines (it's
signed / encrypted).

Technically, it should be possible to chain-load some custom secondary
bootloader instead of a kernel image, but this is not very practical
because now:

1. There is a need to make a custom bootloader and it is quite a lot of
work.

2. You'll have to tell everybody that a custom booloader may need to be
used in order to get a working eMMC.

3. NVIDIA's bootloader already passes a command line parameter to kernel
for locating GPT entry, but this hack is not acceptable for the upstream
kernel.
