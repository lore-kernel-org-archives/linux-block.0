Return-Path: <SRS0=qPv+=4N=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E7714C35E01
	for <linux-block@archiver.kernel.org>; Tue, 25 Feb 2020 15:46:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BE66520CC7
	for <linux-block@archiver.kernel.org>; Tue, 25 Feb 2020 15:46:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Fiz01y9c"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730607AbgBYPqz (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 25 Feb 2020 10:46:55 -0500
Received: from mail-lf1-f66.google.com ([209.85.167.66]:41420 "EHLO
        mail-lf1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726019AbgBYPqy (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 25 Feb 2020 10:46:54 -0500
Received: by mail-lf1-f66.google.com with SMTP id y17so6992880lfe.8;
        Tue, 25 Feb 2020 07:46:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=xNinaEdvBrD29kIqkWAyPHB9SdoxJ8ycU201le/hisU=;
        b=Fiz01y9cf2SUthjj3oaLENxEuUSpzQxFNWI5hOr/cL2h7HkApo1lImUAIgP5dcY8rO
         RoHbH1fRR3EJ+WM1si/54m208q/FM1YJGTzEoTr7Mq2gvPn4i1xC5nlpYmiXwJx1H6IY
         NMclvh2UCA/Tut2OKO+ndrY0Q/nJFneZ+PjhC1Tnf9nJ2qIT5Dl6yEY8/DCVflY48F+o
         +EUGP/vTHVRIFO9hzD+d26b2b7hb+mwtiXF1jSa0HiPYyq5AsoQeiaBa0naQZt6Tzj6L
         Bc+VKTT4K/ILMe0yBDoIWMsvVtuj2l7dhuqup8coym03xm1g3jZMf/wC+0RAFEGfrYBk
         YD6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=xNinaEdvBrD29kIqkWAyPHB9SdoxJ8ycU201le/hisU=;
        b=H4zQmj8cm0wYkPBW7G72AOkeZQGfj1wrfXyInq5YjVkLuTK0yguYoPjHHzucFQvbKD
         dayvqSbdPHXO6gdNvQ6mbwKB3N/QwjHNL9ZPW3GrO24wPZSpZu8OjzQR00K3TxBMaGRd
         vCQ4SYgiJwp81WBqQgIO0eFngjohngj1cVwGbDCqFvKk8Kw8As36oVBJV70fB83W67pB
         RWwsrVqtPGtiOvH5QdAkRWMOza7+tFYPUm1JRzd28ZyE6NI1Yt3KLPGWv/FXM47R7RKI
         /sI+adpLwn1L24NQ3gTiZ1lWRJHhWFgdVmbwhGZpq7XUo1abKlZNBx9Iiv6+MjroHVPT
         0LTw==
X-Gm-Message-State: APjAAAVip9xU5AywWeYJLcgvOe0lohfogRqYOESWMp+XPKvdnYNil+aN
        eJnPm0cGjUvGYqL5oNs6DJzlXNyT
X-Google-Smtp-Source: APXvYqxm0Hm8L4foYBZLswdA53J6fY2WU9UOSsqOY82N5bsjaQslmdPcu8HY2FBcsfPFLd5YJmba0A==
X-Received: by 2002:ac2:489b:: with SMTP id x27mr30382322lfc.130.1582645612280;
        Tue, 25 Feb 2020 07:46:52 -0800 (PST)
Received: from [192.168.2.145] (79-139-233-37.dynamic.spd-mgts.ru. [79.139.233.37])
        by smtp.googlemail.com with ESMTPSA id q13sm9690543ljj.63.2020.02.25.07.46.50
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 25 Feb 2020 07:46:51 -0800 (PST)
Subject: Re: [PATCH v1 2/3] mmc: block: Add mmc_bdev_to_card() helper
To:     Ulf Hansson <ulf.hansson@linaro.org>, Jens Axboe <axboe@kernel.dk>
Cc:     Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        =?UTF-8?B?TWljaGHFgiBNaXJvc8WCYXc=?= <mirq-linux@rere.qmqm.pl>,
        David Heidelberg <david@ixit.cz>,
        Peter Geis <pgwipeout@gmail.com>,
        Stephen Warren <swarren@wwwdotorg.org>,
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
 <20200224231841.26550-3-digetx@gmail.com>
 <CAPDyKFoSwjkOX85jjA-Q-ScdC0aUozroOu3_-FO4yBE8pgtCow@mail.gmail.com>
From:   Dmitry Osipenko <digetx@gmail.com>
Message-ID: <62a4e5ac-40c2-7fb2-60eb-e465c665270f@gmail.com>
Date:   Tue, 25 Feb 2020 18:46:44 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.3.0
MIME-Version: 1.0
In-Reply-To: <CAPDyKFoSwjkOX85jjA-Q-ScdC0aUozroOu3_-FO4yBE8pgtCow@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

25.02.2020 17:53, Ulf Hansson пишет:
> On Tue, 25 Feb 2020 at 00:22, Dmitry Osipenko <digetx@gmail.com> wrote:
>>
>> NVIDIA Tegra Partition Table takes into account MMC card's BOOT_SIZE_MULT
>> parameter, and thus, the partition parser needs to retrieve that EXT_CSD
>> value from the block device. This patch introduces new helper which takes
>> block device for the input argument and returns corresponding MMC card.
> 
> Rather than returning the card, why not return the value you are
> looking for instead? That sound more straightforward, but also allows
> mmc core code to stay closer to the mmc core.

Please take a look at patch #3, in particular see the
tegra_partition_table_emmc_boot_offset(). We already need more than just
the BOOT_SIZE_MULT from the struct mmc_card, in the the v2 of this
series we will probably need even a bit more.

I'll adjust the commit's message of this patch in v2, saying that more
than BOOT_SIZE_MULT is needed from the struct mmc_card. Are you okay
with this variant?

----

BTW, do you have any idea how partition table scanning of MMC's boot0/1
partitions potentially could be implemented?

It's not uncommon for Tegra devices that partition table could reside in
one of the MMC's boot partitions (Nexus 7 is one example). For now I
don't see how the scanning could be implemented easily because all
boot0/boot1/main partitions are very separated from each other in the
kernel's MMC_BLOCK.

One potential hack that comes into my mind is that the boot0/1
partitions could be always registered before the main MMC partition and
then they always will be scanned first, i.e. before the main partition.
This will allow to read out partition table from the boot partitions and
stash it for the main.
