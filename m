Return-Path: <SRS0=yWSg=4X=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DE7A3C3F2D1
	for <linux-block@archiver.kernel.org>; Fri,  6 Mar 2020 02:30:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B091720870
	for <linux-block@archiver.kernel.org>; Fri,  6 Mar 2020 02:30:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="f51iBsa6"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726751AbgCFCaq (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 5 Mar 2020 21:30:46 -0500
Received: from mail-lj1-f193.google.com ([209.85.208.193]:42292 "EHLO
        mail-lj1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726358AbgCFCaq (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Thu, 5 Mar 2020 21:30:46 -0500
Received: by mail-lj1-f193.google.com with SMTP id q19so539161ljp.9;
        Thu, 05 Mar 2020 18:30:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=eH9bp9uRZgGX041TTGJP0RqQGDwpGGO3NTiYFhAbSX0=;
        b=f51iBsa69izFo1z8fmVasqtE1/5vi7VYtzC0s1uoLRW1dMYdC2sYrepYi+oAxO/3RC
         9sKaThX3cdL/uT54JSs0LOM/q5QKzcqOdY+A4g+gpzmTAhw7EhNArlzNCQ+QC5Lksg9G
         qL4cF3YXbBLawWq5yCCq+iK1aO2hWlJ44nYEqpgyi32y8rEMKuTKja8yWo2SvAfbX9MG
         x3d1mtLFpZULdwSKK1Ms4bboKtkr5+WN4s+bUyjcEnCTnyr/AT5JkXI7idWAcoQxIldM
         48emlyjC4jyTi+tQxKR5e/lREfpBtDI56YIoMJyQXclypvAVxRXpFWoc7eexBLK2K19B
         +www==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=eH9bp9uRZgGX041TTGJP0RqQGDwpGGO3NTiYFhAbSX0=;
        b=QtAfDO0I42aYcwU/k+LlQm4Kt3SyygBO+7GL90nVBw8uaJbl33TNaQh7+pfl5vTpAG
         NkWtNUkiRLYjtJiC8VUhPmfk1aoYvZwsCo7WFjr+/S5ECe/VrPtJXC3PjozmvfnbxrMY
         7RRwWae6lMSrci73RKYdl2+0T4sI3pTrIOzqYIRqRIo/qGb8cDjDDzaFLX7u/kufJ017
         w1Mi7uCvnrf1g/stl+9RRkTDkPv/tvDwgwC5qnQxgpQckh0dANXV7bVYp/Iw0RGYtI2I
         wWmed2QROL3bO8T03Mg7EWhIdi7Si94MMun0JQmRNXn6f5nMiU4Wkz6hTyYPkh3mjSgM
         itZw==
X-Gm-Message-State: ANhLgQ0YfYKWetttYjMDf27clZzXsty6JFfbnxkOB9lanX75BIqI5go3
        ymOXJKvgitolZDLG/fz2Fx0V8K0b
X-Google-Smtp-Source: ADFU+vuJV24RDwMbfIGoSzi9w5ISnp6gMhWI10jo+YMxOwYTt5uyC/d8vce+TpwHsecFCw0FIJTWKA==
X-Received: by 2002:a2e:730b:: with SMTP id o11mr539097ljc.228.1583461841508;
        Thu, 05 Mar 2020 18:30:41 -0800 (PST)
Received: from [192.168.2.145] (94-29-39-224.dynamic.spd-mgts.ru. [94.29.39.224])
        by smtp.googlemail.com with ESMTPSA id j19sm13044730lfg.49.2020.03.05.18.30.40
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 05 Mar 2020 18:30:40 -0800 (PST)
Subject: Re: [PATCH v2 3/8] partitions: Introduce NVIDIA Tegra Partition Table
To:     Randy Dunlap <rdunlap@infradead.org>, Jens Axboe <axboe@kernel.dk>,
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
Cc:     linux-tegra@vger.kernel.org, linux-block@vger.kernel.org,
        Andrey Danin <danindrey@mail.ru>,
        Gilles Grandou <gilles@grandou.net>,
        Ryan Grachek <ryan@edited.us>, linux-mmc@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20200306021220.22097-1-digetx@gmail.com>
 <20200306021220.22097-4-digetx@gmail.com>
 <14ebbc7f-91f3-16dd-b998-ddd71385c772@infradead.org>
From:   Dmitry Osipenko <digetx@gmail.com>
Message-ID: <d6e4a7b1-3412-7ccc-1941-04d28b847698@gmail.com>
Date:   Fri, 6 Mar 2020 05:30:39 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <14ebbc7f-91f3-16dd-b998-ddd71385c772@infradead.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

06.03.2020 05:22, Randy Dunlap пишет:
> On 3/5/20 6:12 PM, Dmitry Osipenko wrote:
>> All NVIDIA Tegra devices use a special partition table format for the
>> internal storage partitioning. Most of Tegra devices have GPT partition
>> in addition to TegraPT, but some older Android consumer-grade devices do
>> not or GPT is placed in a wrong sector, and thus, the TegraPT is needed
>> in order to support these devices properly in the upstream kernel. This
>> patch adds support for NVIDIA Tegra Partition Table format that is used
>> at least by all NVIDIA Tegra20 and Tegra30 devices.
>>
>> Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
>> ---
>>  arch/arm/mach-tegra/tegra.c   |  54 ++++
>>  block/partitions/Kconfig      |   9 +
>>  block/partitions/Makefile     |   1 +
>>  block/partitions/check.c      |   4 +
>>  block/partitions/tegra.c      | 510 ++++++++++++++++++++++++++++++++++
>>  block/partitions/tegra.h      |  83 ++++++
>>  include/soc/tegra/bootdata.h  |  46 +++
>>  include/soc/tegra/common.h    |   9 +
>>  include/soc/tegra/partition.h |  18 ++
>>  9 files changed, 734 insertions(+)
>>  create mode 100644 block/partitions/tegra.c
>>  create mode 100644 block/partitions/tegra.h
>>  create mode 100644 include/soc/tegra/bootdata.h
>>  create mode 100644 include/soc/tegra/partition.h
> 
> Hi Dmitry,
> 
> 
>> diff --git a/block/partitions/Kconfig b/block/partitions/Kconfig
>> index 702689a628f0..d3c5c6ad6d58 100644
>> --- a/block/partitions/Kconfig
>> +++ b/block/partitions/Kconfig
>> @@ -268,3 +268,12 @@ config CMDLINE_PARTITION
>>  	help
>>  	  Say Y here if you want to read the partition table from bootargs.
>>  	  The format for the command line is just like mtdparts.
>> +
>> +config TEGRA_PARTITION
>> +	bool "NVIDIA Tegra Partition support" if PARTITION_ADVANCED
>> +	default y if ARCH_TEGRA
>> +	depends on ARCH_TEGRA || COMPILE_TEST
>> +	select MMC_BLOCK
> 
> You shouldn't select MMC_BLOCK unless MMC is already enabled,
> so this entire config should depend on MMC also.
> As is, without MMC set/enabled, it should give you a kconfig warning.
> 
> (no, you should not also select MMC here.)
> 
> (This is just based on reading the patch--I haven't tested it
> with CONFIG_MMC not set/enabled.  Have you?)

Hello Randy,

I haven't tested it with the disabled CONFIG_MMC, that's a good
suggestion. I'll take it into account in a v3, thank you.
