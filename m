Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1E807C433F5
	for <linux-block@archiver.kernel.org>; Wed, 17 Nov 2021 13:25:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id F185C6140D
	for <linux-block@archiver.kernel.org>; Wed, 17 Nov 2021 13:25:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237411AbhKQN2l (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 17 Nov 2021 08:28:41 -0500
Received: from mail-lf1-f50.google.com ([209.85.167.50]:34683 "EHLO
        mail-lf1-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232627AbhKQN2k (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 17 Nov 2021 08:28:40 -0500
Received: by mail-lf1-f50.google.com with SMTP id n12so8511190lfe.1;
        Wed, 17 Nov 2021 05:25:41 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=ktgvYN1PoD/4uPIKFT1eS+g9vqs5gmujrNkL090jjTA=;
        b=5HYurOLfyJc4xwBC3PKYmtFnLychZr3iM0HCIN4s31rPZmDfzcIT4UPRHQHjaAZ1ls
         xfykQ55hvs+/4866urWnMQJoNkx+dKLVkqMaJ3wRZj4lnBDJxadFIEu7Ntn7aOlNfP9S
         bcKa/MFGeXs3wEDX1y8BuZ+IEGeF0ZEcxuOmHzp4nXD8H5pFpa/TtvqAoCHp99tXCg7P
         ybf5kEgnWa5DzjR7ddn1o1mN5nYe3U9Q1JIlavjHZqrWXdF9dYpB0Jl3bOZX+4ZMjqfq
         SuL1pxwwKpWCXqdykxytL121EqpBvy8ARbwX/YAsl2XXZjBzHGEGper+ws0CI1KsLpAe
         jRDw==
X-Gm-Message-State: AOAM5334rzCerS9RfUO9c9PGGQTc+CvzP2zqEMyXiA5U6kcsXPj5J2hk
        U6aVAXIlm6d9w4R8DwKOpZo=
X-Google-Smtp-Source: ABdhPJyvhhpGPikx//laywZPo+7A3uM4GU4myRTkPh+RkSLCta75O3gDxYpSyAQsN6XZgWfabhKnWA==
X-Received: by 2002:a2e:8143:: with SMTP id t3mr7783494ljg.18.1637155540527;
        Wed, 17 Nov 2021 05:25:40 -0800 (PST)
Received: from [10.68.32.40] (broadband-109-173-81-86.ip.moscow.rt.ru. [109.173.81.86])
        by smtp.gmail.com with ESMTPSA id x12sm2117971lfa.243.2021.11.17.05.25.39
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 17 Nov 2021 05:25:39 -0800 (PST)
Message-ID: <0d05bdd9-b962-2f63-c0d8-b87ab593ea1b@linux.com>
Date:   Wed, 17 Nov 2021 16:25:39 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.3.0
Subject: Re: [PATCH] floppy: Add max size check for user space request
Content-Language: en-US
To:     sxwjean@me.com, axboe@kernel.dk, linux-block@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, Xiongwei Song <sxwjean@gmail.com>
References: <20211116131033.27685-1-sxwjean@me.com>
From:   Denis Efremov <efremov@linux.com>
In-Reply-To: <20211116131033.27685-1-sxwjean@me.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Hi,

On 11/16/21 16:10, sxwjean@me.com wrote:
> From: Xiongwei Song <sxwjean@gmail.com>
> 
> We need to check the max request size that is from user space before
> allocating pages. If the request size exceeds the limit, return -EINVAL.
> This check can avoid the warning below from page allocator.

Thank you for the patch. Applied,
https://github.com/evdenis/linux-floppy/commit/3c2d8686849713e3267b972038bb649c8f093345

I will send it to Jens by the of the week.

Regards,
Denis

> 
> WARNING: CPU: 3 PID: 16525 at mm/page_alloc.c:5344 current_gfp_context include/linux/sched/mm.h:195 [inline]
> WARNING: CPU: 3 PID: 16525 at mm/page_alloc.c:5344 __alloc_pages+0x45d/0x500 mm/page_alloc.c:5356
> Modules linked in:
> CPU: 3 PID: 16525 Comm: syz-executor.3 Not tainted 5.15.0-syzkaller #0
> Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.14.0-2 04/01/2014
> RIP: 0010:__alloc_pages+0x45d/0x500 mm/page_alloc.c:5344
> Code: be c9 00 00 00 48 c7 c7 20 4a 97 89 c6 05 62 32 a7 0b 01 e8 74 9a 42 07 e9 6a ff ff ff 0f 0b e9 a0 fd ff ff 40 80 e5 3f eb 88 <0f> 0b e9 18 ff ff ff 4c 89 ef 44 89 e6 45 31 ed e8 1e 76 ff ff e9
> RSP: 0018:ffffc90023b87850 EFLAGS: 00010246
> RAX: 0000000000000000 RBX: 1ffff92004770f0b RCX: dffffc0000000000
> RDX: 0000000000000000 RSI: 0000000000000033 RDI: 0000000000010cc1
> RBP: 0000000000000000 R08: 0000000000000000 R09: 0000000000000001
> R10: ffffffff81bb4686 R11: 0000000000000001 R12: ffffffff902c1960
> R13: 0000000000000033 R14: 0000000000000000 R15: ffff88804cf64a30
> FS:  0000000000000000(0000) GS:ffff88802cd00000(0063) knlGS:00000000f44b4b40
> CS:  0010 DS: 002b ES: 002b CR0: 0000000080050033
> CR2: 000000002c921000 CR3: 000000004f507000 CR4: 0000000000150ee0
> DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
> DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
> Call Trace:
>  <TASK>
>  alloc_pages+0x1a7/0x300 mm/mempolicy.c:2191
>  __get_free_pages+0x8/0x40 mm/page_alloc.c:5418
>  raw_cmd_copyin drivers/block/floppy.c:3113 [inline]
>  raw_cmd_ioctl drivers/block/floppy.c:3160 [inline]
>  fd_locked_ioctl+0x12e5/0x2820 drivers/block/floppy.c:3528
>  fd_ioctl drivers/block/floppy.c:3555 [inline]
>  fd_compat_ioctl+0x891/0x1b60 drivers/block/floppy.c:3869
>  compat_blkdev_ioctl+0x3b8/0x810 block/ioctl.c:662
>  __do_compat_sys_ioctl+0x1c7/0x290 fs/ioctl.c:972
>  do_syscall_32_irqs_on arch/x86/entry/common.c:112 [inline]
>  __do_fast_syscall_32+0x65/0xf0 arch/x86/entry/common.c:178
>  do_fast_syscall_32+0x2f/0x70 arch/x86/entry/common.c:203
>  entry_SYSENTER_compat_after_hwframe+0x4d/0x5c
> 
> Reported-by: syzbot+23a02c7df2cf2bc93fa2@syzkaller.appspotmail.com
> Signed-off-by: Xiongwei Song <sxwjean@gmail.com>
> ---
>  drivers/block/floppy.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/block/floppy.c b/drivers/block/floppy.c
> index c4267da716fe..52112ed59dd0 100644
> --- a/drivers/block/floppy.c
> +++ b/drivers/block/floppy.c
> @@ -3081,6 +3081,8 @@ static void raw_cmd_free(struct floppy_raw_cmd **ptr)
>  	}
>  }
>  
> +#define MAX_LEN (1UL << MAX_ORDER << PAGE_SHIFT)
> +
>  static int raw_cmd_copyin(int cmd, void __user *param,
>  				 struct floppy_raw_cmd **rcmd)
>  {
> @@ -3108,7 +3110,7 @@ static int raw_cmd_copyin(int cmd, void __user *param,
>  	ptr->resultcode = 0;
>  
>  	if (ptr->flags & (FD_RAW_READ | FD_RAW_WRITE)) {
> -		if (ptr->length <= 0)
> +		if (ptr->length <= 0 || ptr->length >= MAX_LEN)
>  			return -EINVAL;
>  		ptr->kernel_data = (char *)fd_dma_mem_alloc(ptr->length);
>  		fallback_on_nodma_alloc(&ptr->kernel_data, ptr->length);
> 
