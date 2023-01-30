Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DA499C54EED
	for <linux-block@archiver.kernel.org>; Mon, 30 Jan 2023 03:44:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231157AbjA3DoK (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Sun, 29 Jan 2023 22:44:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44344 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229878AbjA3DoJ (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Sun, 29 Jan 2023 22:44:09 -0500
Received: from mail-pg1-x536.google.com (mail-pg1-x536.google.com [IPv6:2607:f8b0:4864:20::536])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A96CE1D900
        for <linux-block@vger.kernel.org>; Sun, 29 Jan 2023 19:44:08 -0800 (PST)
Received: by mail-pg1-x536.google.com with SMTP id f3so6750674pgc.2
        for <linux-block@vger.kernel.org>; Sun, 29 Jan 2023 19:44:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=qoBscvoo8jokDo/WI/wb/4WYkSiZvS0p/vQURdXXYSQ=;
        b=olhQqBosVaUeHGPIXvLR2QMeof84svQ4R+m6aT3NywzVK6qfpvfyZ/q4raeH4WqKme
         4PIwZ0uqkDf6QsJa25CwGGS/2mcXPdAk/k+KktZf20g6A+J/tHAWDFTBvuQWMl1EnCpj
         IyLcUJHfIZs8Dse0nuEmzB1O1gLHC+J1ARDp7isaRaNF8fBDs5s9kCHyGX/eiaSXh6tG
         j6uqI3raXPNhlhta2iMIaKAEl7j232tx9+h8zs7yG+JXSUJFbfP3+7o8dLNC+MPZY0/y
         qPPEVemRdo6YZc0asQHeuZVBPwjN/45yTWeSJzpJUbzNYZcxGaNKxUfEEGGk2k8X7Kxd
         J9jg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=qoBscvoo8jokDo/WI/wb/4WYkSiZvS0p/vQURdXXYSQ=;
        b=ZxdbZ7JvBQ9Dz7Nr/XpPm9JYriCNUDa/K21TrlwraNCOONu4lg656DJPrK06Xis5Og
         AvcGvzyt8NHEq+GzYFx5cQidyJVAh/SbtcFbMpimvZsFAF2fN0JH9CmOTWm640zu5bU2
         dM65Edywszxwe8NvrJwa3eO4v0FdokQM6p4x/4lsPU1gRv9ne8q5N3eHUYCQ44LB6GRo
         MigSYDR4rgirIJE+Ib0Oq6LYrOjGu0cjULvlYfipjg+UBBi3r3P2eCVJkGFWjCDElZvg
         nrHLymNtvaqR6/xYMaD1bCXkYSwA61XHSHb9E9TKuCL446VaehJ79AqYZ5EeBMMYsNgm
         kfXw==
X-Gm-Message-State: AFqh2kpwRfz+A6BgXL4NemEeVsQwWSfikKDKIgaT3/lJhGyFb5We7Pfj
        4k/n4njK9NtJMvl9x/7sH5dVRw==
X-Google-Smtp-Source: AMrXdXviVtK9Kg1Z9OKXWZHRKFwZTbsUTYBUyjOclnLA5O4DmkNwdA+S0xpXLF/1P7dhH0Xtx93p0w==
X-Received: by 2002:a05:6a00:188a:b0:58b:453e:d12d with SMTP id x10-20020a056a00188a00b0058b453ed12dmr11550799pfh.1.1675050248061;
        Sun, 29 Jan 2023 19:44:08 -0800 (PST)
Received: from [192.168.1.136] ([198.8.77.157])
        by smtp.gmail.com with ESMTPSA id x29-20020a056a000bdd00b00587c11bc925sm6256639pfu.168.2023.01.29.19.44.06
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 29 Jan 2023 19:44:07 -0800 (PST)
Message-ID: <e843fde8-7295-dd30-6d98-a62f63d7753c@kernel.dk>
Date:   Sun, 29 Jan 2023 20:44:06 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux aarch64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.0
Subject: Re: [PATCH v3] pata_parport: add driver (PARIDE replacement)
Content-Language: en-US
To:     Damien Le Moal <damien.lemoal@opensource.wdc.com>,
        Ondrej Zary <linux@zary.sk>
Cc:     Christoph Hellwig <hch@lst.de>,
        Sergey Shtylyov <s.shtylyov@omp.ru>,
        Tim Waugh <tim@cyberelk.net>, linux-block@vger.kernel.org,
        linux-parport@lists.infradead.org, linux-ide@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <425b5646-23e2-e271-5ca6-0f3783d39a3b@opensource.wdc.com>
 <20230123190954.5085-1-linux@zary.sk>
 <d4f7ebd5-d90d-fb96-0fad-bd129ac162dc@opensource.wdc.com>
From:   Jens Axboe <axboe@kernel.dk>
In-Reply-To: <d4f7ebd5-d90d-fb96-0fad-bd129ac162dc@opensource.wdc.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 1/29/23 8:30?PM, Damien Le Moal wrote:
> On 1/24/23 04:09, Ondrej Zary wrote:
>> The pata_parport is a libata-based replacement of the old PARIDE
>> subsystem - driver for parallel port IDE devices.
>> It uses the original paride low-level protocol drivers but does not
>> need the high-level drivers (pd, pcd, pf, pt, pg). The IDE devices
>> behind parallel port adapters are handled by the ATA layer.
>>
>> This will allow paride and its high-level drivers to be removed.
>>
>> Unfortunately, libata drivers cannot sleep so pata_parport claims
>> parport before activating the ata host and keeps it claimed (and
>> protocol connected) until the ata host is removed. This means that
>> no devices can be chained (neither other pata_parport devices nor
>> a printer).
>>
>> paride and pata_parport are mutually exclusive because the compiled
>> protocol drivers are incompatible.
>>
>> Tested with:
>>  - Imation SuperDisk LS-120 and HP C4381A (EPAT)
>>  - Freecom Parallel CD (FRPW)
>>  - Toshiba Mobile CD-RW 2793008 w/Freecom Parallel Cable rev.903 (FRIQ)
>>  - Backpack CD-RW 222011 and CD-RW 19350 (BPCK6)
>>
>> The following bugs in low-level protocol drivers were found and will
>> be fixed later:
>>
>> Note: EPP-32 mode is buggy in EPAT - and also in all other protocol
>> drivers - they don't handle non-multiple-of-4 block transfers
>> correctly. This causes problems with LS-120 drive.
>> There is also another bug in EPAT: EPP modes don't work unless a 4-bit
>> or 8-bit mode is used first (probably some initialization missing?).
>> Once the device is initialized, EPP works until power cycle.
>>
>> So after device power on, you have to:
>> echo "parport0 epat 0" >/sys/bus/pata_parport/new_device
>> echo pata_parport.0 >/sys/bus/pata_parport/delete_device
>> echo "parport0 epat 4" >/sys/bus/pata_parport/new_device
>> (autoprobe will initialize correctly as it tries the slowest modes
>> first but you'll get the broken EPP-32 mode)
>>
>> Note: EPP modes are buggy in FRPW, only modes 0 and 1 work.
>> Signed-off-by: Ondrej Zary <linux@zary.sk>
> 
> Are you going to send a patch to remove the legacy parport code ?
> If we want this queued for 6.3, it is now (this week, asap) or we will
> have to delay to 6.4. Unless Jens prefers the deprecation first, which I
> think he said "better delete now".

I would prefer if we just delete it after merging this one, in the same
release. I don't think there's any point in delaying, as we're not
removing any functionality.

You could just queue that up too when adding this patch.
 

-- 
Jens Axboe

