Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 905A6C433EF
	for <linux-block@archiver.kernel.org>; Wed, 17 Nov 2021 00:21:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6B1C661BBD
	for <linux-block@archiver.kernel.org>; Wed, 17 Nov 2021 00:21:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229632AbhKQAYQ (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 16 Nov 2021 19:24:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34056 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229544AbhKQAYP (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 16 Nov 2021 19:24:15 -0500
Received: from mail-io1-xd34.google.com (mail-io1-xd34.google.com [IPv6:2607:f8b0:4864:20::d34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 29B9BC061570
        for <linux-block@vger.kernel.org>; Tue, 16 Nov 2021 16:21:18 -0800 (PST)
Received: by mail-io1-xd34.google.com with SMTP id e144so857281iof.3
        for <linux-block@vger.kernel.org>; Tue, 16 Nov 2021 16:21:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20210112.gappssmtp.com; s=20210112;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=FMhYkfi+6pTJofNrMf6qtvpazSaRa/maid/TZweeiXk=;
        b=qPfwMazhpGEaNcIApa9gP6nlmozRPnrtOtvI/Qe2NW4u4WqHt3Q2zjWq+zpyPMCsMQ
         Hoa4yUgqOm9awtH1PsHBqEKhEzlcYCUQ1NjwRncNTbRK6EpPKhbH1dpJcWQImHhglG+T
         /ro1p5dak0VJff9dBNLkaqZsxVH17d4Zi83rpXRPj0rJxHUTghCsg1WpJ+yldii8WWDI
         n8XQ8+LuU9uIbdQezor4jjIbl21YcoWR7gioT3MUX14blrUP09TJ0DBQvIAR99FVXDUk
         xoWC7JU4IXv1a8G+UIG7ydsFr5mtESG5gQDthm5tq/xoVLNi8qhY5QaAdlQHIDOUAqFY
         /SIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=FMhYkfi+6pTJofNrMf6qtvpazSaRa/maid/TZweeiXk=;
        b=JWCkdUiveuljX7DMR8hquWpwTSNCOQo7h5Twr8HfIolafbHQB+yFJ1xnpq/4hVjh3Y
         FZHkezMMjJJfPa/FSO/YLP6XgBFrzqM1EgFS/dP11ajrvo0SZ9928Z+rwJutOK7R2+Vy
         nNfgVDw2KxfOO3eqekAbYgyilv3u2vujfBXFwzH+Fcqk0z1VyaOPZ9XMvHqH4yjXZjMz
         OKSJgeVoWy6QPixLMUAwYbfe6f58e+L7zTb6mvViGQ1Ts8izhs7+EPP25lA5UpjHnXYw
         Fnz3T9lwd/JEnwpRX33ddqlx2HVpjhogVPo0LBbhl7Q2r1mIEUj+VQZTkCyh7brbyrNY
         yUIA==
X-Gm-Message-State: AOAM531FUfNrqudbfUu71Ofuxd7ecT8gfeTVXEURopbQHdqbuwC1SoNa
        Y5yAOEqcdxmgqNUxCiIavxr+a6W/pmdSQH2/
X-Google-Smtp-Source: ABdhPJygfFtx0ISwcDoRdHuu/HKKxeyW69vvPxcgoJXN7yBFPBvH9JvayZqweI2ex0KIBfPO9uK09Q==
X-Received: by 2002:a6b:4e07:: with SMTP id c7mr7706211iob.23.1637108477399;
        Tue, 16 Nov 2021 16:21:17 -0800 (PST)
Received: from [192.168.1.116] ([66.219.217.159])
        by smtp.gmail.com with ESMTPSA id b15sm12846506iln.36.2021.11.16.16.21.16
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 16 Nov 2021 16:21:17 -0800 (PST)
Subject: Re: Hang in blk_mq_freeze_queue_wait()
To:     Bart Van Assche <bvanassche@acm.org>
Cc:     "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        Ming Lei <ming.lei@redhat.com>
References: <2f79a604-592e-a4b9-48df-020a5923311f@acm.org>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <fb109032-3926-98ce-41c0-0670c0037bd9@kernel.dk>
Date:   Tue, 16 Nov 2021 17:21:11 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <2f79a604-592e-a4b9-48df-020a5923311f@acm.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 11/16/21 5:15 PM, Bart Van Assche wrote:
> Hi,
> 
> If I run test srp/002 against v5.16-rc1 then dmsetup hangs as follows at 
> the end of the test:
> 
> sysrq: Show Blocked State
> task:dmsetup         state:D stack:28136 pid: 3088 ppid:  3087 
> flags:0x00004000
> Call Trace:
>   <TASK>
>   __schedule+0x4bd/0xc20
>   schedule+0x84/0x140
>   blk_mq_freeze_queue_wait+0xf7/0x130
>   del_gendisk+0x342/0x410
>   cleanup_mapped_device+0x165/0x170 [dm_mod]
>   __dm_destroy+0x280/0x450 [dm_mod]
>   dm_destroy+0x13/0x20 [dm_mod]
>   dev_remove+0x156/0x1d0 [dm_mod]
>   ctl_ioctl+0x2bb/0x4d0 [dm_mod]
>   dm_ctl_ioctl+0xe/0x20 [dm_mod]
>   __x64_sys_ioctl+0xc2/0xe0
>   do_syscall_64+0x35/0x80
>   entry_SYSCALL_64_after_hwframe+0x44/0xae
> 
> I haven't seen this hang with any previous kernel version. Could this be 
> a block layer issue?
> 
> v5.16-rc1 includes Ming's commit 10f7335e3627 ("blk-mq: don't grab 
> ->q_usage_counter in blk_mq_sched_bio_merge").

Can you try with:

https://git.kernel.dk/cgit/linux-block/commit/?h=block-5.16&id=95febeb61bf87ca803a1270498cd4cd61554a68f

-- 
Jens Axboe

