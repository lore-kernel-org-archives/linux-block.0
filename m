Return-Path: <SRS0=qPv+=4N=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 976E5C35DEA
	for <linux-block@archiver.kernel.org>; Tue, 25 Feb 2020 01:35:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 66A90222D9
	for <linux-block@archiver.kernel.org>; Tue, 25 Feb 2020 01:35:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MXbsLVZn"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728731AbgBYBf0 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 24 Feb 2020 20:35:26 -0500
Received: from mail-lf1-f66.google.com ([209.85.167.66]:45625 "EHLO
        mail-lf1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728682AbgBYBf0 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 24 Feb 2020 20:35:26 -0500
Received: by mail-lf1-f66.google.com with SMTP id z5so8303786lfd.12;
        Mon, 24 Feb 2020 17:35:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=7KfeF9bj6ln8qqzpe7IEHDvXUKwiiT/ipxNgBi4uFME=;
        b=MXbsLVZnsRrOiUyO+RyrtvqNQ3W25wfO2SG+jAz2GDo9XK5OnoEhcftf8feCiPrP/o
         srGQYWWWGNYCr3om2YQsFdD/rsSHi+0A62kC+hkD9OMswCyO91Zwbx9y/juew9cNgOE3
         rfSgxBlbT9XLepoOTw1IcnHpir7MQqP6TFzPtoJ6iOMDMJ1rhclVSwUxNNpJZyFt3b5x
         815tKXst1OZnrsdAoD2iC/CIxTNOHV2BfXC2e9uvGXSgQOXIEmzB+lec7kHgADjMrr/U
         qgGNLw1ts63mJJzZWy5EaDWPYdilzhuAS4p78kCVfOR1+hBuJDnDOUy7aqdaUd5o+Jgr
         Y+jw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=7KfeF9bj6ln8qqzpe7IEHDvXUKwiiT/ipxNgBi4uFME=;
        b=dNhHZuqg/8Qh2+QLqTdpDNknu6lsFN1VrntQK/wYG1494oxKNsDl+m5fOWSGtm25TS
         OsRV599+/JUoo7luyIQY5FBFbJTgziQn+Hmr8EH9icypCJBe87hkAiD9TziroLwFeYZ7
         nMKIHxLAthhpeKTxK61qaTPn5QF2BW3mb1v1ESjtNc6vRRnMG931CIFg8c4MUjBKQImj
         OrbmDrtf5riqy2iJFlyN4Y+d7qeWbA9D+kik/FhBFgzpm/U5Veqo9Hwf2YpLjPvYckDH
         GJSyVOdrb393gnNdtU5xtHuROaS+L46VoEQfwQRJl2nmHEh08HWZ/7loHWaXym+jlNxS
         xfMQ==
X-Gm-Message-State: APjAAAUPpZvdtq/X884aFFZIMPHbMie+y+5pmmlJE/GpG4hG7YlJtQtM
        nW1PLhi9nUlYI2shjL7OeK42NBq3
X-Google-Smtp-Source: APXvYqz/Z9/bQLbgH3q3d9zG8BlA3rujvO8lz+rf5xIvXdVWkiKCXHU2J1RhTI3+l112QMoW/cLkNQ==
X-Received: by 2002:a19:48cf:: with SMTP id v198mr3243388lfa.68.1582594523870;
        Mon, 24 Feb 2020 17:35:23 -0800 (PST)
Received: from [192.168.2.145] (79-139-233-37.dynamic.spd-mgts.ru. [79.139.233.37])
        by smtp.googlemail.com with ESMTPSA id 14sm6888501ljj.32.2020.02.24.17.35.22
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 24 Feb 2020 17:35:23 -0800 (PST)
Subject: Re: [PATCH v1 3/3] partitions: Introduce NVIDIA Tegra Partition Table
To:     Stephen Warren <swarren@wwwdotorg.org>
Cc:     Jens Axboe <axboe@kernel.dk>,
        Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        =?UTF-8?B?TWljaGHFgiBNaXJvc8WCYXc=?= <mirq-linux@rere.qmqm.pl>,
        David Heidelberg <david@ixit.cz>,
        Peter Geis <pgwipeout@gmail.com>,
        Nicolas Chauvet <kwizart@gmail.com>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Billy Laws <blaws05@gmail.com>, linux-tegra@vger.kernel.org,
        linux-block@vger.kernel.org, Andrey Danin <danindrey@mail.ru>,
        Gilles Grandou <gilles@grandou.net>,
        Ryan Grachek <ryan@edited.us>, linux-mmc@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20200224231841.26550-1-digetx@gmail.com>
 <20200224231841.26550-4-digetx@gmail.com>
 <44c22925-a14e-96d0-1f93-1979c0c60525@wwwdotorg.org>
From:   Dmitry Osipenko <digetx@gmail.com>
Message-ID: <69a76bbe-e088-6715-fefe-354dd4bc3ef2@gmail.com>
Date:   Tue, 25 Feb 2020 04:35:21 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.3.0
MIME-Version: 1.0
In-Reply-To: <44c22925-a14e-96d0-1f93-1979c0c60525@wwwdotorg.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

25.02.2020 03:20, Stephen Warren пишет:
> On 2/24/20 4:18 PM, Dmitry Osipenko wrote:
>> All NVIDIA Tegra devices use a special partition table format for the
>> internal storage partitioning. Most of Tegra devices have GPT partition
>> in addition to TegraPT, but some older Android consumer-grade devices do
>> not or GPT is placed in a wrong sector, and thus, the TegraPT is needed
>> in order to support these devices properly in the upstream kernel. This
>> patch adds support for NVIDIA Tegra Partition Table format that is used
>> at least by all NVIDIA Tegra20 and Tegra30 devices.
> 
>> diff --git a/arch/arm/mach-tegra/tegra.c b/arch/arm/mach-tegra/tegra.c
> 
>> +static void __init tegra_boot_config_table_init(void)
>> +{
>> +    void __iomem *bct_base;
>> +    u16 pt_addr, pt_size;
>> +
>> +    bct_base = IO_ADDRESS(TEGRA_IRAM_BASE) + TEGRA_IRAM_BCT_OFFSET;
> 
> This shouldn't be hard-coded. IIRC, the boot ROM writes a BIT (Boot
> Information Table) to a fixed location in IRAM, and there's some value
> in the BIT that points to where the BCT is in IRAM. In practice, it
> might work out that the BCT is always at the same place in IRAM, but
> this certainly isn't guaranteed. I think there's code in U-Boot which
> extracts the BCT location from the BIT? Yes, see
> arch/arm/mach-tegra/ap.c:get_odmdata().

Thank you very much, I didn't know about that.

I checked whether Nexus 7 and A500 have a correct pointer in the BIT and
they have it. I'll take it into account in v2, thank you again.
