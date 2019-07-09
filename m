Return-Path: <SRS0=ruTu=VG=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DCD09C606CF
	for <linux-block@archiver.kernel.org>; Tue,  9 Jul 2019 00:45:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ACB7E216C4
	for <linux-block@archiver.kernel.org>; Tue,  9 Jul 2019 00:45:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726981AbfGIApq convert rfc822-to-8bit (ORCPT
        <rfc822;linux-block@archiver.kernel.org>);
        Mon, 8 Jul 2019 20:45:46 -0400
Received: from smtpbgsg2.qq.com ([54.254.200.128]:51080 "EHLO smtpbgsg2.qq.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726970AbfGIApp (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Mon, 8 Jul 2019 20:45:45 -0400
X-QQ-mid: bizesmtp28t1562633138t7drh2e9
Received: from [192.168.142.168] (unknown [218.76.23.26])
        by esmtp10.qq.com (ESMTP) with 
        id ; Tue, 09 Jul 2019 08:45:37 +0800 (CST)
X-QQ-SSF: 00400000002000Q0WO70000A0000000
X-QQ-FEAT: ZCfpn3Y0+jOX0ipQlHpu/yS04TS50q2JRaVTYErCQpkAsTWlCfKW7b0qGEk9y
        4bgoOMEqXYShCG54fdMFE+FDpsNmysAHSNW3Riy0Qs0Xwzn5l8AoWP9KrDbeBBLWhbkXAhc
        /Byf7MXxKB/gw5Tn2V/NrYJbcNLWHTulB5bU979JnrKJDG49UspA7RBcmFQnY5Lgd5Km9+K
        6KI/761jDoAwBhoTWd6QmSc5MTB0pMutuK+qqqMAW8dDUUQ4o5rlbfv5VE7G/j479H0v285
        bdsiu/YklQMguo7maKW4IYus7rZLt43Lac+1pxBk4sNfECXdSNorsH7qQcEX3DBjB/pVo2f
        sQCJy29s+mIVO29D7Y=
X-QQ-GoodBg: 2
Content-Type: text/plain;
        charset=gb2312
Mime-Version: 1.0 (Mac OS X Mail 12.4 \(3445.104.11\))
Subject: Re: [PATCH v3] io_uring: fix io_sq_thread_stop running in front of
 io_sq_thread
From:   JackieLiu <liuyun01@kylinos.cn>
In-Reply-To: <7db0b9eb-ae1a-f133-ed49-83813e0ed632@kernel.dk>
Date:   Tue, 9 Jul 2019 08:45:37 +0800
Cc:     ebiggers@kernel.org,
        =?gb2312?B?wfXV/dSq?= <liuzhengyuan@kylinos.cn>,
        linux-block@vger.kernel.org
Content-Transfer-Encoding: 8BIT
Message-Id: <48F1415A-8A02-4DC8-B610-73A304423681@kylinos.cn>
References: <1562564472-18277-1-git-send-email-liuyun01@kylinos.cn>
 <d157c7f6-712b-a904-5335-2b4ac803376c@kernel.dk>
 <29EFA309-E42B-423B-9260-0E5FD0A2D7ED@kylinos.cn>
 <7db0b9eb-ae1a-f133-ed49-83813e0ed632@kernel.dk>
To:     Jens Axboe <axboe@kernel.dk>
X-Mailer: Apple Mail (2.3445.104.11)
X-QQ-SENDSIZE: 520
Feedback-ID: bizesmtp:kylinos.cn:qybgforeign:qybgforeign4
X-QQ-Bgrelay: 1
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Thanks.

> 在 2019年7月9日，08:41，Jens Axboe <axboe@kernel.dk> 写道：
> 
> On 7/8/19 6:37 PM, JackieLiu wrote:
>> 
>> 
>>> 在 2019年7月9日，06:31，Jens Axboe <axboe@kernel.dk> 写道：
>>> 
>>> On 7/7/19 11:41 PM, Jackie Liu wrote:
>>>> INFO: task syz-executor.5:8634 blocked for more than 143 seconds.
>>>>        Not tainted 5.2.0-rc5+ #3
>>>> "echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
>>>> syz-executor.5  D25632  8634   8224 0x00004004
>>>> Call Trace:
>>>>   context_switch kernel/sched/core.c:2818 [inline]
>>>>   __schedule+0x658/0x9e0 kernel/sched/core.c:3445
>>>>   schedule+0x131/0x1d0 kernel/sched/core.c:3509
>>>>   schedule_timeout+0x9a/0x2b0 kernel/time/timer.c:1783
>>>>   do_wait_for_common+0x35e/0x5a0 kernel/sched/completion.c:83
>>>>   __wait_for_common kernel/sched/completion.c:104 [inline]
>>>>   wait_for_common kernel/sched/completion.c:115 [inline]
>>>>   wait_for_completion+0x47/0x60 kernel/sched/completion.c:136
>>>>   kthread_stop+0xb4/0x150 kernel/kthread.c:559
>>>>   io_sq_thread_stop fs/io_uring.c:2252 [inline]
>>>>   io_finish_async fs/io_uring.c:2259 [inline]
>>>>   io_ring_ctx_free fs/io_uring.c:2770 [inline]
>>>>   io_ring_ctx_wait_and_kill+0x268/0x880 fs/io_uring.c:2834
>>>>   io_uring_release+0x5d/0x70 fs/io_uring.c:2842
>>>>   __fput+0x2e4/0x740 fs/file_table.c:280
>>>>   ____fput+0x15/0x20 fs/file_table.c:313
>>>>   task_work_run+0x17e/0x1b0 kernel/task_work.c:113
>>>>   tracehook_notify_resume include/linux/tracehook.h:185 [inline]
>>>>   exit_to_usermode_loop arch/x86/entry/common.c:168 [inline]
>>>>   prepare_exit_to_usermode+0x402/0x4f0 arch/x86/entry/common.c:199
>>>>   syscall_return_slowpath+0x110/0x440 arch/x86/entry/common.c:279
>>>>   do_syscall_64+0x126/0x140 arch/x86/entry/common.c:304
>>>>   entry_SYSCALL_64_after_hwframe+0x49/0xbe
>>>> RIP: 0033:0x412fb1
>>>> Code: 80 3b 7c 0f 84 c7 02 00 00 c7 85 d0 00 00 00 00 00 00 00 48 8b 05 cf
>>>> a6 24 00 49 8b 14 24 41 b9 cb 2a 44 00 48 89 ee 48 89 df <48> 85 c0 4c 0f
>>>> 45 c8 45 31 c0 31 c9 e8 0e 5b 00 00 85 c0 41 89 c7
>>>> RSP: 002b:00007ffe7ee6a180 EFLAGS: 00000293 ORIG_RAX: 0000000000000003
>>>> RAX: 0000000000000000 RBX: 0000000000000004 RCX: 0000000000412fb1
>>>> RDX: 0000001b2d920000 RSI: 0000000000000000 RDI: 0000000000000003
>>>> RBP: 0000000000000001 R08: 00000000f3a3e1f8 R09: 00000000f3a3e1fc
>>>> R10: 00007ffe7ee6a260 R11: 0000000000000293 R12: 000000000075c9a0
>>>> R13: 000000000075c9a0 R14: 0000000000024c00 R15: 000000000075bf2c
>>>> 
>>>> =============================================
>>>> 
>>>> There is an wrong logic, when kthread_park running
>>>> in front of io_sq_thread.
>>>> 
>>>> CPU#0					CPU#1
>>>> 
>>>> io_sq_thread_stop:			int kthread(void *_create):
>>>> 
>>>> kthread_park()
>>>> 					__kthread_parkme(self);	 <<< Wrong
>>>> kthread_stop()
>>>>     << wait for self->exited
>>>>     << clear_bit KTHREAD_SHOULD_PARK
>>>> 
>>>> 					ret = threadfn(data);
>>>> 					   |
>>>> 					   |- io_sq_thread
>>>> 					       |- kthread_should_park()	<< false
>>>> 					       |- schedule() <<< nobody wake up
>>>> 
>>>> stuck CPU#0				stuck CPU#1
>>>> 
>>>> So, use a new variable sqo_thread_started to ensure that io_sq_thread
>>>> run first, then io_sq_thread_stop.
>>> 
>>> I think this looks fine now, I'll apply it. Thanks!
>>> 
>>> Do you have the test case as well? Would like to add it to the
>>> liburing arsenal of regression tests.
>> 
>> Yes, I will. but what's the rules for naming file, they look like sha1
>> or MD5 values.
> 
> It's the git sha of the commit that fixed the problem. But don't worry
> about that, call it whatever and I'll fix it up, if need be.
> 
> -- 
> Jens Axboe



