Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 205EFC43460
	for <linux-block@archiver.kernel.org>; Sun,  9 May 2021 03:51:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EC6F56142D
	for <linux-block@archiver.kernel.org>; Sun,  9 May 2021 03:51:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229614AbhEIDwh (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Sat, 8 May 2021 23:52:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34822 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229558AbhEIDwg (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Sat, 8 May 2021 23:52:36 -0400
Received: from mail-pg1-x533.google.com (mail-pg1-x533.google.com [IPv6:2607:f8b0:4864:20::533])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 19988C061573
        for <linux-block@vger.kernel.org>; Sat,  8 May 2021 20:51:34 -0700 (PDT)
Received: by mail-pg1-x533.google.com with SMTP id u25so355342pgl.9
        for <linux-block@vger.kernel.org>; Sat, 08 May 2021 20:51:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:references:from:message-id:date:user-agent:mime-version
         :in-reply-to:content-language:content-transfer-encoding;
        bh=wK5/7IU4o9YhDHFoicZcfLXLedUpMj2SAlDtfL68d0I=;
        b=YUpn4sry2AzpIxDfiNijmM4iRtMGnH8b+1iis0Bdzql5346VfsKns8E+76D/iQgwI+
         OTiIacC2fI4kB+PnuIGUXwdHSriipYsxazKqj8y+7QKzz0LsGUAP0LQ4/jh2hthuprCd
         Z1zTattZJiNEeR4npGvLSKYWP6JiwbBlnX9hTBrqi153aQjghZl2hTFmm3/S6n8MhavY
         bcgAy6FGCwm1Dw/DoVtUmcVX5gzkfUN+jLKh5g1BJKhoPk5DbDe8oxY+xB5lec8YADai
         rqFd3aRo1jys3vkW+wM0/jJcuR26dzi3GpSEXLWMhWMx9Abtn4Sg0r7Cw7pkGtAhccO6
         Oujw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=wK5/7IU4o9YhDHFoicZcfLXLedUpMj2SAlDtfL68d0I=;
        b=J/YPNnLqMzo0hAckjGjRsUjfC/jJIdUaLUvKVU0YkJ7ins5LsuP9JzRZxsCb4bf+gp
         aCNueT1uKT/ELeCA0WZRb1wur8+0vpKvx88Ui96hf5v/vkjdtMcuw7LhqQ3GcSQZD4nC
         8qj3qUU5E0k5LsFmmWW/KW22B54GwG4d6vjLO1JXWidg01PZBMM8CGyeId+Lf+TNkBe+
         DTYN1GYS24gV3o1lxcvXRaK8JvnV40LSeVHvbK9edNIIZ1gG+9w6iSrZWCtkW5aXp+CE
         tsH+dpxWg1nj9xF3SiJhLqPP/4qJYIod7uS+TusBdYrFPDzWfWiLboK4VI4kSprBw6pB
         RoxA==
X-Gm-Message-State: AOAM531X+sjL1GF2dzxyvYx6ElnzEu/EEyd7T4Kfj/GZ2UHDN9LJPtln
        gbaaBJqX4ET5RECo52BSU09Ckg==
X-Google-Smtp-Source: ABdhPJz2bYqb40v/5PySanPTXWCo+v5sANxFSuWgfuXlAqfRT48bHmD8zZcuwLyY9aZHX4I/7fKTkA==
X-Received: by 2002:a63:a511:: with SMTP id n17mr18825904pgf.9.1620532293431;
        Sat, 08 May 2021 20:51:33 -0700 (PDT)
Received: from [192.168.4.41] (cpe-72-132-29-68.dc.res.rr.com. [72.132.29.68])
        by smtp.gmail.com with ESMTPSA id ne20sm7834245pjb.52.2021.05.08.20.51.31
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 08 May 2021 20:51:32 -0700 (PDT)
Subject: Re: regression: data corruption with ext4 on LUKS on nvme with
 torvalds master
To:     "Alex Xu (Hello71)" <alex_y_xu@yahoo.ca>,
        linux-kernel@vger.kernel.org, linux-ext4@vger.kernel.org,
        dm-crypt@saout.de, linux-nvme@lists.infradead.org,
        linux-block@vger.kernel.org,
        Changheun Lee <nanich.lee@samsung.com>, bvanassche@acm.org,
        yi.zhang@redhat.com, ming.lei@redhat.com, bgoncalv@redhat.com,
        hch@lst.de, jaegeuk@kernel.org
References: <1620493841.bxdq8r5haw.none@localhost>
 <1620526887.tg1zx7w5np.none@localhost>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <f0c90fc0-c239-df68-371d-a5c74c8f32eb@kernel.dk>
Date:   Sat, 8 May 2021 21:51:36 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <1620526887.tg1zx7w5np.none@localhost>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 5/8/21 8:29 PM, Alex Xu (Hello71) wrote:
> Excerpts from Alex Xu (Hello71)'s message of May 8, 2021 1:54 pm:
>> Hi all,
>>
>> Using torvalds master, I recently encountered data corruption on my ext4 
>> volume on LUKS on NVMe. Specifically, during heavy writes, the system 
>> partially hangs; SysRq-W shows that processes are blocked in the kernel 
>> on I/O. After forcibly rebooting, chunks of files are replaced with 
>> other, unrelated data. I'm not sure exactly what the data is; some of it 
>> is unknown binary data, but in at least one case, a list of file paths 
>> was inserted into a file, indicating that the data is misdirected after 
>> encryption.
>>
>> This issue appears to affect files receiving writes in the temporal 
>> vicinity of the hang, but affects both new and old data: for example, my 
>> shell history file was corrupted up to many months before.
>>
>> The drive reports no SMART issues.
>>
>> I believe this is a regression in the kernel related to something merged 
>> in the last few days, as it consistently occurs with my most recent 
>> kernel versions, but disappears when reverting to an older kernel.
>>
>> I haven't investigated further, such as by bisecting. I hope this is 
>> sufficient information to give someone a lead on the issue, and if it is 
>> a bug, nail it down before anybody else loses data.
>>
>> Regards,
>> Alex.
>>
> 
> I found the following test to reproduce a hang, which I guess may be the 
> cause:
> 
> host$ cd /tmp
> host$ truncate -s 10G drive
> host$ qemu-system-x86_64 -drive format=raw,file=drive,if=none,id=drive -device nvme,drive=drive,serial=1 [... more VM setup options]
> guest$ cryptsetup luksFormat /dev/nvme0n1
> [accept warning, use any password]
> guest$ cryptsetup open /dev/nvme0n1
> [enter password]
> guest$ mkfs.ext4 /dev/mapper/test
> [normal output...]
> Creating journal (16384 blocks): [hangs forever]
> 
> I bisected this issue to:
> 
> cd2c7545ae1beac3b6aae033c7f31193b3255946 is the first bad commit
> commit cd2c7545ae1beac3b6aae033c7f31193b3255946
> Author: Changheun Lee <nanich.lee@samsung.com>
> Date:   Mon May 3 18:52:03 2021 +0900
> 
>     bio: limit bio max size
> 
> I didn't try reverting this commit or further reducing the test case. 
> Let me know if you need my kernel config or other information.

If you have time, please do test with that reverted. I'd be anxious to
get this revert queued up for 5.13-rc1.

-- 
Jens Axboe

