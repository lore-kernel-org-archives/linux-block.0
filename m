Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.2 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 34F73C433EF
	for <linux-block@archiver.kernel.org>; Mon, 20 Sep 2021 19:45:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0F8CA611AE
	for <linux-block@archiver.kernel.org>; Mon, 20 Sep 2021 19:45:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348877AbhITTq1 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 20 Sep 2021 15:46:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37486 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347587AbhITTo1 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 20 Sep 2021 15:44:27 -0400
Received: from mail-pj1-x1030.google.com (mail-pj1-x1030.google.com [IPv6:2607:f8b0:4864:20::1030])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4C6DAC03D74A;
        Mon, 20 Sep 2021 10:10:58 -0700 (PDT)
Received: by mail-pj1-x1030.google.com with SMTP id me1so3815665pjb.4;
        Mon, 20 Sep 2021 10:10:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=subject:to:references:from:message-id:date:user-agent:mime-version
         :in-reply-to:content-language:content-transfer-encoding;
        bh=fj8App68ogzs6DNbiiMw3S0Ll09u5u6MeeOSOfbic40=;
        b=i91rtZnwYalIOEu1SQNj5+A5CGa5VYaa3qgsd19YRllciPg6z3ww9l2HbFNZLnIO4N
         E4RLHeaPVgJXFpFdr+ut+XBvlnE/JiObLwlJn9W6k5LIu8ingxZPz8qZRUoKAwiiM/A7
         f4ryYTWcYkkc/ymnlc4um8GudbNYvhl9QTKMkHUn3K0YP5RHBoUQpCvv1vvQ4LgpSQoY
         n4b/mGRF3SfRxK8Ddsw1DXSyLlXw+Ff1VPU3L2lriOaERbyuof3hE/KgpbaM7OUlgvfZ
         ZUDGgJIKDeeQXoil1s2KGo3YxLsglLG0OOjPil1XYOfLtjg56ySBW2+XD3ltPq38gbyZ
         T69g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=fj8App68ogzs6DNbiiMw3S0Ll09u5u6MeeOSOfbic40=;
        b=Jubw/MIfQz9rOPBxH8VBNra9mfXuyca042Ff+X2ATUecbVJC1/BFG3MUXcHVA5jX+V
         M8BT/+R2/WKnQB7LyEhHgtlTCMhW4MtsXzsgBQkli0n9tkJApx0h45cjeiWvVtsrEjAx
         ecbLgvPWAw5gbEAoS+o+SFcPEXbLYlYfB6CSSl7D4jruKLwGCRIy//V+gdE63PyXrepM
         4t7HRKD5sJbKFNxhv2q6/Zl1zVRoZRzxePnMmVSBBJYGuGzX0/EzxJ6vdjpVax3DIylY
         FMkNCYN5sKP/f+QNJo1Byjk6Egqp/+8qk7G/rdXtodu6DVdCvrJvJL56iKD/1jxVBR6U
         w+SQ==
X-Gm-Message-State: AOAM531XCUKDDEHUr1zqu8jIV1UGKuYSdszDdfG2Yo6HeJEgE4FSq2LW
        zUmxRZFdV+q48M5WMneRy4Lr5k8VGu4=
X-Google-Smtp-Source: ABdhPJyvhNuVszIBWkLOBCn+YK6oIYO610nLjP2PAURJngNYrck7HmEcJz7CZnOPNeg9ycxWPwliUw==
X-Received: by 2002:a17:902:9009:b0:13b:9cae:5dd7 with SMTP id a9-20020a170902900900b0013b9cae5dd7mr23659352plp.53.1632157857703;
        Mon, 20 Sep 2021 10:10:57 -0700 (PDT)
Received: from [192.168.86.235] (c-73-241-150-58.hsd1.ca.comcast.net. [73.241.150.58])
        by smtp.gmail.com with ESMTPSA id y3sm16407604pge.44.2021.09.20.10.10.56
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 20 Sep 2021 10:10:57 -0700 (PDT)
Subject: Re: [syzbot] possible deadlock in bd_register_pending_holders
To:     Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>,
        syzbot <syzbot+f5608de5d89cc0d998c7@syzkaller.appspotmail.com>,
        axboe@kernel.dk, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com
References: <000000000000e272fb05cba51fe4@google.com>
 <d4d71dc8-0373-b7a9-2a95-ba2d3c87f968@I-love.SAKURA.ne.jp>
From:   Eric Dumazet <eric.dumazet@gmail.com>
Message-ID: <8431ea39-7ace-a601-419a-dca74e1db287@gmail.com>
Date:   Mon, 20 Sep 2021 10:10:55 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <d4d71dc8-0373-b7a9-2a95-ba2d3c87f968@I-love.SAKURA.ne.jp>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org



On 9/10/21 9:57 AM, Tetsuo Handa wrote:
> Since commit dfbb3409b27fa42b in axboe/linux-block.git#block-5.15 breaks
> "sb_writers#$N => &p->lock => major_names_lock" dependency chain,
> I think that this dependency chain should be no longer possible.
> 
> #syz fix: block: genhd: don't call blkdev_show() with major_names_lock held
> 
> On 2021/09/10 23:42, syzbot wrote:
>> Hello,
>>
>> syzbot found the following issue on:
>>
>> HEAD commit:    27151f177827 Merge tag 'perf-tools-for-v5.15-2021-09-04' o..
>> git tree:       upstream
>> console output: https://syzkaller.appspot.com/x/log.txt?x=104612b3300000
>> kernel config:  https://syzkaller.appspot.com/x/.config?x=ac2f9cc43f6b17e4
>> dashboard link: https://syzkaller.appspot.com/bug?extid=f5608de5d89cc0d998c7
>> compiler:       gcc (Debian 10.2.1-6) 10.2.1 20210110, GNU ld (GNU Binutils for Debian) 2.35.1
>>
>> Unfortunately, I don't have any reproducer for this issue yet.
>>
>> IMPORTANT: if you fix the issue, please add the following tag to the commit:
>> Reported-by: syzbot+f5608de5d89cc0d998c7@syzkaller.appspotmail.com

Note that current kernels (which include dfbb3409b27fa42b)
still hit this :

[    3.197383] ======================================================
[    3.204253] WARNING: possible circular locking dependency detected
[    3.211116] 5.15.0-dbx-DEV #16 Not tainted
[    3.215907] ------------------------------------------------------
[    3.222770] kinit/1 is trying to acquire lock:
[    3.227900] ffffa09bc8971230 (&mddev->open_mutex){+.+.}-{3:3}, at: md_open+0xf3/0x150
[    3.237803] 
               but task is already holding lock:
[    3.245020] ffffa09bcf003f18 (&disk->open_mutex){+.+.}-{3:3}, at: blkdev_get_by_dev+0xa2/0x580
[    3.254663] 
               which lock already depends on the new lock.

[    3.264916] 
               the existing dependency chain (in reverse order) is:
[    3.273772] 
               -> #1 (&disk->open_mutex){+.+.}-{3:3}:
[    3.281422]        lock_acquire+0xb3/0x1e0
[    3.286213]        __mutex_lock_common+0xe0/0xde0
[    3.291619]        mutex_lock_nested+0x20/0x30
[    3.296749]        bd_register_pending_holders+0x2c/0x130
[    3.302839]        device_add_disk+0x1c0/0x3a0
[    3.307969]        md_alloc+0x3ed/0x550
[    3.312493]        md_probe+0x35/0x40
[    3.316843]        blk_request_module+0x6b/0xd0
[    3.322058]        blkdev_get_no_open+0x33/0xb0
[    3.327275]        blkdev_get_by_dev+0x69/0x580
[    3.332501]        blkdev_open+0x61/0x90
[    3.337118]        do_dentry_open+0x281/0x3a0
[    3.342170]        vfs_open+0x2d/0x30
[    3.346529]        path_openat+0xb93/0xf30
[    3.351345]        do_filp_open+0xc7/0x170
[    3.356127]        do_sys_openat2+0x91/0x170
[    3.361085]        __x64_sys_open+0x7c/0xa0
[    3.365963]        do_syscall_64+0x44/0xa0
[    3.370762]        entry_SYSCALL_64_after_hwframe+0x44/0xae
[    3.377034] 
               -> #0 (&mddev->open_mutex){+.+.}-{3:3}:
[    3.384770]        validate_chain+0xacb/0x2e60
[    3.389900]        __lock_acquire+0x91e/0xf00
[    3.394950]        lock_acquire+0xb3/0x1e0
[    3.399734]        __mutex_lock_common+0xe0/0xde0
[    3.405131]        mutex_lock_interruptible_nested+0x20/0x30
[    3.411482]        md_open+0xf3/0x150
[    3.415840]        blkdev_get_by_dev+0x1b2/0x580
[    3.421153]        blkdev_open+0x61/0x90
[    3.425771]        do_dentry_open+0x281/0x3a0
[    3.430821]        vfs_open+0x2d/0x30
[    3.435180]        path_openat+0xb93/0xf30
[    3.439980]        do_filp_open+0xc7/0x170
[    3.444762]        do_sys_openat2+0x91/0x170
[    3.449720]        __x64_sys_open+0x7c/0xa0
[    3.454597]        do_syscall_64+0x44/0xa0
[    3.459391]        entry_SYSCALL_64_after_hwframe+0x44/0xae
[    3.465654] 
               other info that might help us debug this:

[    3.475721]  Possible unsafe locking scenario:

[    3.483017]        CPU0                    CPU1
[    3.488241]        ----                    ----
[    3.493457]   lock(&disk->open_mutex);
[    3.497900]                                lock(&mddev->open_mutex);
[    3.504955]                                lock(&disk->open_mutex);
[    3.511912]   lock(&mddev->open_mutex);
[    3.516434] 
                *** DEADLOCK ***

[    3.524424] 1 lock held by kinit/1:
[    3.527289] tsc: Refined TSC clocksource calibration: 2599.997 MHz
[    3.528600]  #0: ffffa09bcf003f18 (&disk->open_mutex){+.+.}-{3:3}, at: blkdev_get_by_dev+0xa2/0x580
[    3.535499] clocksource: tsc: mask: 0xffffffffffffffff max_cycles: 0x257a391c223, max_idle_ns: 440795220104 ns
[    3.545202] 
               stack backtrace:
[    3.545204] CPU: 17 PID: 1 Comm: kinit Not tainted 5.15.0-dbx-DEV #16
[    3.545208] Hardware name: Intel RML,PCH/Ibis_QC_18, BIOS 2.48.0 10/02/2019
[    3.576394] Call Trace:
[    3.579540]  dump_stack_lvl+0x6c/0x9a
[    3.583898]  dump_stack+0x10/0x12
[    3.587908]  print_circular_bug+0x2cb/0x2d0
[    3.592786]  check_noncircular+0x139/0x140
[    3.597579]  validate_chain+0xacb/0x2e60
[    3.602199]  ? add_lock_to_list+0xdd/0x110
[    3.606987]  ? validate_chain+0x8ee/0x2e60
[    3.611781]  __lock_acquire+0x91e/0xf00
[    3.616311]  lock_acquire+0xb3/0x1e0
[    3.620581]  ? md_open+0xf3/0x150
[    3.624596]  __mutex_lock_common+0xe0/0xde0
[    3.629471]  ? md_open+0xf3/0x150
[    3.633482]  ? md_open+0xf3/0x150
[    3.637493]  ? md_open+0xa0/0x150
[    3.641507]  ? lock_release+0xc5/0x260
[    3.645953]  mutex_lock_interruptible_nested+0x20/0x30
[    3.651784]  md_open+0xf3/0x150
[    3.655623]  blkdev_get_by_dev+0x1b2/0x580
[    3.660417]  blkdev_open+0x61/0x90
[    3.664511]  do_dentry_open+0x281/0x3a0
[    3.669044]  vfs_open+0x2d/0x30
[    3.672881]  path_openat+0xb93/0xf30
[    3.677157]  ? __lock_acquire+0x91e/0xf00
[    3.681858]  ? lock_is_held_type+0x9b/0x130
[    3.686737]  do_filp_open+0xc7/0x170
[    3.691015]  do_sys_openat2+0x91/0x170
[    3.695463]  __x64_sys_open+0x7c/0xa0
[    3.699821]  do_syscall_64+0x44/0xa0
[    3.704091]  entry_SYSCALL_64_after_hwframe+0x44/0xae
[    3.709835] RIP: 0033:0x20fe89
[    3.713587] Code: 48 89 77 38 c3 89 f0 48 8b 1f 48 8b 67 08 48 8b 6f 10 4c 8b 67 18 4c 8b 6f 20 4c 8b 77 28 4c 8b 7f 30 ff 67 38 49 89 ca 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 f7
 d8 89 05 5e 36 00 00 48 83 c8 ff c3
[    3.733022] RSP: 002b:00007ffebd54c5d8 EFLAGS: 00000246 ORIG_RAX: 0000000000000002
[    3.741279] RAX: ffffffffffffffda RBX: 0000000000000000 RCX: 000000000020fe89
[    3.749102] RDX: 0000000000000000 RSI: 0000000000000000 RDI: 000000000020076f
[    3.756920] RBP: 00007ffebd54cbc0 R08: 0000000000000042 R09: 000000000000006d
[    3.764746] R10: 000000000020fe89 R11: 0000000000000246 R12: 0000000000000000
