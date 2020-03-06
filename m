Return-Path: <SRS0=yWSg=4X=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 51FF7C3F2C6
	for <linux-block@archiver.kernel.org>; Fri,  6 Mar 2020 21:56:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 26CA7206E2
	for <linux-block@archiver.kernel.org>; Fri,  6 Mar 2020 21:56:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="T6dZB2LI"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726162AbgCFV4R (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 6 Mar 2020 16:56:17 -0500
Received: from mail-lf1-f66.google.com ([209.85.167.66]:34221 "EHLO
        mail-lf1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726194AbgCFV4Q (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Fri, 6 Mar 2020 16:56:16 -0500
Received: by mail-lf1-f66.google.com with SMTP id w27so3120728lfc.1;
        Fri, 06 Mar 2020 13:56:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=bHMaQl8LS+kUipNNyOSSMitpE/YaBqFWVsAjUSuCc2c=;
        b=T6dZB2LI8Slsj0freZ731/RtEkdC6/kteNUVd9ADzIXfHsT2dD3kdH/PM+QX7JSrVR
         krPy0dsJLFfriBt7G60gPfLzXj96UZ0aq4Yb/8ZtDHLXcmDabgD93eBbMKhzRIBPYGsd
         juWUwZ6xsfFxPsk82UglwDyUL0ZiYP6gbYowohPr2FK0P4oCtsOoLDOCz2grv/ihc5Pg
         BlTEcPxcFuUcSS0K2mVn7p0I2a8o1lA6Q6tNwLG6ieulrC7tr2afGDMB6sKYPOe3rViF
         NZuNK+QWhM4MOQR70hYL0gfVgjQ8sSjmbh+oq3ITKiJi4NlQceBWj2jnplesQ4ZRI8yt
         EzRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=bHMaQl8LS+kUipNNyOSSMitpE/YaBqFWVsAjUSuCc2c=;
        b=g7V6ncQPYGs2yUHVivvsaJJEvX8j6s97tufKyaATKBoLq3O9LxpOlawILDU1oHN+WX
         iQH3VTVSts1hR/yOSFZpHC45FMidMJ/qASGUc7Pd9x+n9mdSnITYnhVv38tw9CaVeQ3U
         514w3cKzeMuhfOUVHA6MatbZ0h9Tk9g4bxvK4uPBIfn47lW7RTRKbepZsDMuUb298ces
         L+QpQU0EcBVWzM4UKkLMaiA83WrgAMRgxRApEgJpt/ZMHHr+xN3QQOeLsuW98CeU5/Vr
         AjzgFoDf5OCxyOYUgibr4e3ZhT5GCQJsNr1e+hh2jrhHqOTqnRFteCa0nwIdQK0WtOr7
         2vlw==
X-Gm-Message-State: ANhLgQ3NruvJXGhqw09liRdvQZyU/gd39JsDl5L1o5xFw7EGW7bF81Jd
        szcpKGANUndbWaMly25J/fYH2495
X-Google-Smtp-Source: ADFU+vv7d4IqEihasRGNv5gsfrXFjPRK9cQYmZJp/Mp9rhNhRA/3PG+yZW+BOYLPlBlj4yNmllgsfQ==
X-Received: by 2002:a19:ca15:: with SMTP id a21mr3099252lfg.67.1583531772370;
        Fri, 06 Mar 2020 13:56:12 -0800 (PST)
Received: from [192.168.2.145] (94-29-39-224.dynamic.spd-mgts.ru. [94.29.39.224])
        by smtp.googlemail.com with ESMTPSA id d12sm1409006lfi.86.2020.03.06.13.56.06
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 06 Mar 2020 13:56:11 -0800 (PST)
Subject: Re: [PATCH v1 3/3] partitions: Introduce NVIDIA Tegra Partition Table
To:     Stephen Warren <swarren@wwwdotorg.org>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Jens Axboe <axboe@kernel.dk>
Cc:     Thierry Reding <thierry.reding@gmail.com>,
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
 <824a4d5f-8280-8860-3e80-68188a13aa3d@gmail.com>
 <CAPDyKFric6pZbJ5-2qkwAFoeJ0c0kcha99zHJ12AUrWO6FQmgg@mail.gmail.com>
 <6fe6d262-c6b0-52d8-0150-4c32a4c36cbd@wwwdotorg.org>
From:   Dmitry Osipenko <digetx@gmail.com>
Message-ID: <82974dbe-9e6c-95fd-dd4d-b1cedc33f8ea@gmail.com>
Date:   Sat, 7 Mar 2020 00:56:04 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <6fe6d262-c6b0-52d8-0150-4c32a4c36cbd@wwwdotorg.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

06.03.2020 19:52, Stephen Warren пишет:
> On 3/6/20 6:37 AM, Ulf Hansson wrote:
>> On Wed, 4 Mar 2020 at 18:09, Dmitry Osipenko <digetx@gmail.com> wrote:
>>>
>>> 04.03.2020 19:36, Ulf Hansson пишет:
>>>> On Tue, 25 Feb 2020 at 01:20, Stephen Warren <swarren@wwwdotorg.org>
>>>> wrote:
>>>>>
>>>>> On 2/24/20 4:18 PM, Dmitry Osipenko wrote:
>>>>>> All NVIDIA Tegra devices use a special partition table format for the
>>>>>> internal storage partitioning. Most of Tegra devices have GPT
>>>>>> partition
>>>>>> in addition to TegraPT, but some older Android consumer-grade
>>>>>> devices do
>>>>>> not or GPT is placed in a wrong sector, and thus, the TegraPT is
>>>>>> needed
>>>>>> in order to support these devices properly in the upstream kernel.
>>>>>> This
>>>>>> patch adds support for NVIDIA Tegra Partition Table format that is
>>>>>> used
>>>>>> at least by all NVIDIA Tegra20 and Tegra30 devices.
>>>>>
>>>>>> diff --git a/arch/arm/mach-tegra/tegra.c
>>>>>> b/arch/arm/mach-tegra/tegra.c
>>>>>
>>>>>> +static void __init tegra_boot_config_table_init(void)
>>>>>> +{
>>>>>> +     void __iomem *bct_base;
>>>>>> +     u16 pt_addr, pt_size;
>>>>>> +
>>>>>> +     bct_base = IO_ADDRESS(TEGRA_IRAM_BASE) + TEGRA_IRAM_BCT_OFFSET;
>>>>>
>>>>> This shouldn't be hard-coded. IIRC, the boot ROM writes a BIT (Boot
>>>>> Information Table) to a fixed location in IRAM, and there's some value
>>>>> in the BIT that points to where the BCT is in IRAM. In practice, it
>>>>> might work out that the BCT is always at the same place in IRAM, but
>>>>> this certainly isn't guaranteed. I think there's code in U-Boot which
>>>>> extracts the BCT location from the BIT? Yes, see
>>>>> arch/arm/mach-tegra/ap.c:get_odmdata().
>>>>
>>>> So, have you considered using the command line partition option,
>>>> rather than adding yet another partition scheme to the kernel?
>>>>
>>>> In principle, you would let the boot loader scan for the partitions,
>>>> likely from machine specific code in U-boot. Then you append these to
>>>> the kernel command line and let block/partitions/cmdline.c scan for
>>>> it.
>>>
>>> The bootloader is usually locked-down on a consumer Tegra machines (it's
>>> signed / encrypted).
>>
>> Right, you are you talking about this from a developer point of view,
>> not from an end product user?
>>
>> I mean, for sure you can upgrade the bootloader on Nvidia products?
>> No, really?
> 
> For developer-oriented products like Jetson developer kits, you can
> upgrade the bootloader, and luckily they haven't used this partition
> table format for many versions.
> 
> However, commercial Android products typically have secure boot enabled,
> so you can't replace the bootloader unless you know the secure boot
> keys, which only the manufacturer knows. Dmitry is working on
> re-purposing such products.

Thank you very much for the good clarification :)
