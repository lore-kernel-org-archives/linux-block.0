Return-Path: <SRS0=yjA8=5K=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 32C8CC10DCE
	for <linux-block@archiver.kernel.org>; Wed, 25 Mar 2020 00:27:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0DC8B20724
	for <linux-block@archiver.kernel.org>; Wed, 25 Mar 2020 00:27:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gur2Fdx5"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727110AbgCYA1S (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 24 Mar 2020 20:27:18 -0400
Received: from mail-lj1-f193.google.com ([209.85.208.193]:32882 "EHLO
        mail-lj1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727099AbgCYA1S (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 24 Mar 2020 20:27:18 -0400
Received: by mail-lj1-f193.google.com with SMTP id f20so683970ljm.0;
        Tue, 24 Mar 2020 17:27:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=s6zd3UYK29fUCTxRSVX6khNgXQZ1S35CUyUqP1O3zvE=;
        b=gur2Fdx5A5vxUD7xHXM9nA5NKXDKZWV4LJT8DOy8AWi/ydU8KTFOr9qgD8hhgm4bEC
         eoL5AiS+D4+7TTAHrsOqi/uuFl9x0EMqwFp5elv8myIDxM6hkxzaOeMMZgEp+ByydTHe
         wtIS1nLntpk5Vcc5W48qtDmmSrhF+PJSzXQAu5FB64kb9KoZvuJWUiR+IFNhO6wecKG0
         BiKdzv8LCfzeKSFyPKHPO1EM4yoYwWUZc2/sQd9LYh9pWWEkR3YTmbMxXiFSM5tzbc9Q
         5AlLDahImkswVRWHDQ8ElKy+gu61IY1uNr9veNoHwa4b3GeoIVejy14udFtH3X51254s
         O+0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=s6zd3UYK29fUCTxRSVX6khNgXQZ1S35CUyUqP1O3zvE=;
        b=BGFnt6OJVd6SsbA0NvR/rndhrqOatgAJHwiAmic0XAYMYveo1cP4eE1XDf43yq/61I
         daop9BLs6KJN3s46qhXI8DxgtuTgomCsaPUUDIQUSeCo8+hYvzKUgLEH7A/VsO1Q31Ws
         dZ0+LTwTDLiCC4xlBQV+hvXDJhy0MIt/uUR4gIP7TcGr21l+2/avG77d9jMvSWzAGwNa
         4Hw/GD9AFW+6GYhS8y2XHcBH1yQAHxSyA6gNBN3dRkC3qVhmJDqoR/hwmRuyIsDjVzmL
         GON0WyD4xjrr4bPGqvLSL6ZmI4ZgKkZ2OUQXLlf5/izkctf2YS97Y4sQBAIT4lA4BUMs
         bccA==
X-Gm-Message-State: ANhLgQ2Ap5qS86/ZWe1hp2sWVRvDmqB7t3o/1KVviHDFDek2oabdGZE9
        S9q2Hy67aZ+L1aVni3a7NRCSzUxt
X-Google-Smtp-Source: ADFU+vuFH8ehvnD/bp7hBKOSsNdH56QLACFEQ8Wn3FPYQpSL/WypuWGDsvM84fT8v/EWl8Jy9atQFQ==
X-Received: by 2002:a2e:8612:: with SMTP id a18mr195633lji.250.1585096035316;
        Tue, 24 Mar 2020 17:27:15 -0700 (PDT)
Received: from [192.168.2.145] (94-29-39-224.dynamic.spd-mgts.ru. [94.29.39.224])
        by smtp.googlemail.com with ESMTPSA id n17sm4889281ljc.76.2020.03.24.17.27.14
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 24 Mar 2020 17:27:14 -0700 (PDT)
Subject: Re: [PATCH v3 03/10] partitions: Introduce NVIDIA Tegra Partition
 Table
To:     =?UTF-8?B?TWljaGHFgiBNaXJvc8WCYXc=?= <mirq-linux@rere.qmqm.pl>
Cc:     Jens Axboe <axboe@kernel.dk>,
        Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        David Heidelberg <david@ixit.cz>,
        Peter Geis <pgwipeout@gmail.com>,
        Stephen Warren <swarren@wwwdotorg.org>,
        Nicolas Chauvet <kwizart@gmail.com>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Billy Laws <blaws05@gmail.com>, linux-tegra@vger.kernel.org,
        linux-block@vger.kernel.org, Andrey Danin <danindrey@mail.ru>,
        Gilles Grandou <gilles@grandou.net>,
        Ryan Grachek <ryan@edited.us>, linux-mmc@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20200323163431.7678-1-digetx@gmail.com>
 <20200323163431.7678-4-digetx@gmail.com>
 <20200323191748.GB30585@qmqm.qmqm.pl>
 <67140755-c829-5c58-3fbf-efd496e225df@gmail.com>
 <20200323213520.GA16587@qmqm.qmqm.pl>
 <c31a0335-a174-0f45-af03-3267710a8205@gmail.com>
 <20200324205221.GA22063@qmqm.qmqm.pl>
From:   Dmitry Osipenko <digetx@gmail.com>
Message-ID: <ff2b5121-0ff7-1494-9184-31ec7f6d2e1a@gmail.com>
Date:   Wed, 25 Mar 2020 03:27:13 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <20200324205221.GA22063@qmqm.qmqm.pl>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

24.03.2020 23:52, Michał Mirosław пишет:
> On Tue, Mar 24, 2020 at 02:22:34AM +0300, Dmitry Osipenko wrote:
>> 24.03.2020 00:35, Michał Mirosław пишет:
>>> On Mon, Mar 23, 2020 at 10:59:52PM +0300, Dmitry Osipenko wrote:
>>>> 23.03.2020 22:17, Michał Mirosław пишет:
>>>>> On Mon, Mar 23, 2020 at 07:34:24PM +0300, Dmitry Osipenko wrote:
>>>>>> All NVIDIA Tegra devices use a special partition table format for the
>>>>>> internal storage partitioning. Most of Tegra devices have GPT partition
>>>>>> in addition to TegraPT, but some older Android consumer-grade devices do
>>>>>> not or GPT is placed in a wrong sector, and thus, the TegraPT is needed
>>>>>> in order to support these devices properly in the upstream kernel. This
>>>>>> patch adds support for NVIDIA Tegra Partition Table format that is used
>>>>>> at least by all NVIDIA Tegra20 and Tegra30 devices.
>>>>>>
>>>>>> Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
>>>>>> ---
>>>>>>  arch/arm/mach-tegra/tegra.c   |  54 ++++
>>>>> [...]
>>>>>
>>>>> Please split off this part and make the information available to
>>>>> userspace (pt_addr + pt_size) if found. This would make it easier
>>>>> to support use the partition table later in initrd instead.
>>>>
>>>> Please clarify what do you mean by "use the partition table later in
>>>> initrd instead".
>>>
>>> Configure device-mapper to span eMMC boot+data partitions and then ask
>>> (modified) kpartx to partition the resulting device. All before rootfs
>>> is mounted and switched to in initrd.
>>
>> The whole point of this series is to make partition handling generic in
>> the kernel, avoiding the need to customize anything.
> 
> Yes, but at least for diagnostic purposes, it would be nice to have the
> values from BCT exposed somewhere in /sys.

It could be useful indeed, but for now I'm not sure that it should be a
part of this patchset. I'll keep it mind, thank you for the suggestion.
