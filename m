Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 622BAC433F5
	for <linux-block@archiver.kernel.org>; Sat, 27 Nov 2021 13:47:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1354960AbhK0NvB (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Sat, 27 Nov 2021 08:51:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55752 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239495AbhK0NtB (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Sat, 27 Nov 2021 08:49:01 -0500
Received: from mail-io1-xd32.google.com (mail-io1-xd32.google.com [IPv6:2607:f8b0:4864:20::d32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 097D9C06175B
        for <linux-block@vger.kernel.org>; Sat, 27 Nov 2021 05:45:47 -0800 (PST)
Received: by mail-io1-xd32.google.com with SMTP id b187so3807755iof.11
        for <linux-block@vger.kernel.org>; Sat, 27 Nov 2021 05:45:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20210112.gappssmtp.com; s=20210112;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=JmnC0XUwnd3NXwem01y5/D96/rbWb8lsqxD14QKG/1c=;
        b=HZhTyAVmRFToGMNVHvlCXW1gJAQYB5o1Hml5BSgmHHCsb38yb5m012Zrldto9JSxgK
         oGWFxLSIbmeVbLIikNlHV1ATyvOcINhlaH+ksPuQ40q6jU24cWPikGju2Uo16Lyryn7t
         KHun/7H6Ve+q3zYFFfmmFZbMNl0XK823YkEOchlQYykm0rWEHAOFE0s/DaOxP+JvtptQ
         GBIwBBVxuBhIm0+V7uokJXKH6d1JvFoXSv5+SdHIjXq7Pfpyg4O+FVE04l8llBx6KAvq
         sGe8yMKtcdelXwQD/MMa0HsD9ETs+h3nMdIuWj7YMIjJB2XJh2I9j1W/1xvHYPNlSNav
         6LIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=JmnC0XUwnd3NXwem01y5/D96/rbWb8lsqxD14QKG/1c=;
        b=cwyO8zk5T3uv2MB+c/KenPc3Y6krnmHLezGoWQM9nxKqRvVkxfOgS2ZfpV6kWe/ZIX
         ANIEo1I869Nx4ANXD2OpdW1gs9DLKo9kW4il12KQYSr0n5IpQY7A5P1/IKtxQCL+MKZW
         2xCKorqwJhvQOI2sb0XOLeyR2hz5rSM3GQc+ayS8nVkzRcGlnxouCA20ThCAUZJltsTo
         QzyzLUNe2Y7Qly7CeSvOY/Q5+zsGCO5CI+tPXKaHhR6SIyMgqLBv89lTO9njmKmWlmAR
         2JhWml4dMuNROEymg0JuAxTY+WQ6y+hr//87auHEuVtDiuW8w1auhq0tZpSsTJLUbVPA
         5coQ==
X-Gm-Message-State: AOAM532a9xWeYWhARYfhiuqJQDxk9XkmeMHZUxK60x/1a00q79YJOOsc
        dzh7pJFV7KFN+myo5nm9HRRjWg==
X-Google-Smtp-Source: ABdhPJy3v11jfrfIR7ecsdwNqCpygwA/8xQtf7akRjQLoefSYFmyO0PXiOGM3gPB0NV1T6FR8lGP1A==
X-Received: by 2002:a05:6638:160c:: with SMTP id x12mr50671483jas.60.1638020746405;
        Sat, 27 Nov 2021 05:45:46 -0800 (PST)
Received: from [192.168.1.116] ([66.219.217.159])
        by smtp.gmail.com with ESMTPSA id x14sm6136862ilu.53.2021.11.27.05.45.45
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 27 Nov 2021 05:45:46 -0800 (PST)
Subject: Re: I/O hang with v5.16-rc2
To:     Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>
Cc:     "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        Johannes Thumshirn <Johannes.Thumshirn@wdc.com>,
        Damien Le Moal <Damien.LeMoal@wdc.com>
References: <20211126095352.bkbrvtgfcmfj3wkj@shindev>
 <124f86f8-91db-3a02-702d-5c26b22de107@kernel.dk>
 <e1b65eee-e8c8-e98d-d2f7-5e35eca46651@kernel.dk>
 <20211127023803.ytrqsde5r4ydqn7m@shindev>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <8986cd0a-51b8-3c44-faa4-592d3cba895a@kernel.dk>
Date:   Sat, 27 Nov 2021 06:45:45 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20211127023803.ytrqsde5r4ydqn7m@shindev>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 11/26/21 7:38 PM, Shinichiro Kawasaki wrote:
> On Nov 26, 2021 / 09:55, Jens Axboe wrote:
>> On 11/26/21 9:21 AM, Jens Axboe wrote:
>>> On 11/26/21 2:53 AM, Shinichiro Kawasaki wrote:
>>>> I ran my test set on v5.16-rc2 and observed a process hang. The test work load
>>>> repeats file creation on xfs on dm-zoned. This dm-zoned device is on top of 3
>>>> dm-linear devices. One of them is dm-linear device on non-zoned NVMe device as
>>>> the cache of the dm-zoned device. The other two are dm-linear devices on zoned
>>>> SMR HDDs. So far, the hang is recreated 100% with my test system.
>>>>
>>>> The kernel message [2] reported hanging tasks. In the call stack, I observe
>>>> wbt_wait(). Also I observed "inflight 1" value in the "rqos/wbt/inflight"
>>>> attribute of debug sysfs.
>>>>
>>>> # grep -R . /sys/kernel/debug/block/nvme0n1 | grep inflight
>>>> /sys/kernel/debug/block/nvme0n1/rqos/wbt/inflight:0: inflight 1
>>>> /sys/kernel/debug/block/nvme0n1/rqos/wbt/inflight:1: inflight 0
>>>> /sys/kernel/debug/block/nvme0n1/rqos/wbt/inflight:2: inflight 0
>>>>
>>>> These symptoms look related to another issue reported to linux-block [1]. As
>>>> discussed in that thread, I set 0 to /sys/block/nvme0n1/queue/wbt_lat_usec.
>>>> With this setting, I observed the hang disappeared. Then this hang I observe
>>>> also related to writeback throttling for the NVMe device.
>>>>
>>>> I bisected and found the commit 4f5022453acd ("nvme: wire up completion batching
>>>> for the IRQ path") is the trigger commit. I reverted this commit from v5.16-rc2,
>>>> and observed the hang disappeared.
>>>>
>>>> Wish this report helps.
>>>>
>>>>
>>>> [1] https://lore.kernel.org/linux-block/b3ba57a7-d363-9c17-c4be-9dbe86875@panix.com
>>>
>>> Yes looks the same as that one, and that commit was indeed my suspicion
>>> on what could potentially cause the accounting discrepancy. I'll take a
>>> look at this.
>>
>> I sent out a patch in the other thread, please give that a whirl.
> 
> With the patch on v5.16-rc2, the hang symptom disappeared. Thank you!

Great, thanks for reporting and testing.

-- 
Jens Axboe

