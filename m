Return-Path: <SRS0=8/B6=VF=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2CCAEC5B578
	for <linux-block@archiver.kernel.org>; Mon,  8 Jul 2019 04:38:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0C92D20665
	for <linux-block@archiver.kernel.org>; Mon,  8 Jul 2019 04:38:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727502AbfGHEiv convert rfc822-to-8bit (ORCPT
        <rfc822;linux-block@archiver.kernel.org>);
        Mon, 8 Jul 2019 00:38:51 -0400
Received: from smtpbgbr2.qq.com ([54.207.22.56]:33895 "EHLO smtpbgbr2.qq.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727341AbfGHEiv (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Mon, 8 Jul 2019 00:38:51 -0400
X-QQ-mid: bizesmtp29t1562560721tgv2yngj
Received: from [192.168.142.168] (unknown [218.76.23.26])
        by esmtp10.qq.com (ESMTP) with 
        id ; Mon, 08 Jul 2019 12:38:40 +0800 (CST)
X-QQ-SSF: 00400000002000Q0WO70000A0000000
X-QQ-FEAT: mJep2VbaKxZBum1VFssTmtMBvWiexGWRTcolk2Dr6+te2tsAUUYPGeTknxwlR
        RbZM29k0697mUkrJTrY1wLHTPvqgtgRprfNcuXtGb88fAQe3M5QM4EpQpSrAes4W+F/HHaf
        BwYkpgbMHtfkteWhY5ZTtJQRvltsr9DB5dqgvARkJmPadVw+ueVgikXxuvoGw92UOACs24n
        Han5Z5o+8wQIUQJDM3ipvMnVm/szA68ryYMn40xPXfZ8gUuNGiP7TyuuAN89jgWbN/3L+2P
        bo1SkBaYDn8kHVnmFQj4wj7FdDvLaGVCv0E/nTXiU8/hKSSzYmmM+japB7kdsObkX6jZ5z2
        tK123t+SmIQ3sh5a1yaHNIq057t4g==
X-QQ-GoodBg: 2
Content-Type: text/plain;
        charset=gb2312
Mime-Version: 1.0 (Mac OS X Mail 12.4 \(3445.104.11\))
Subject: Re: [PATCH v2] io_uring: fix io_sq_thread_stop running in front of
 io_sq_thread
From:   JackieLiu <liuyun01@kylinos.cn>
In-Reply-To: <1d1473d2-67e1-9fe2-cfbc-8b8f7bdb86bc@kernel.dk>
Date:   Mon, 8 Jul 2019 12:38:39 +0800
Cc:     ebiggers@kernel.org,
        =?gb2312?B?wfXV/dSq?= <liuzhengyuan@kylinos.cn>,
        linux-block@vger.kernel.org
Content-Transfer-Encoding: 8BIT
Message-Id: <07DF55FE-258F-43AC-8589-C5E44ECAAB66@kylinos.cn>
References: <1562551626-22358-1-git-send-email-liuyun01@kylinos.cn>
 <1d1473d2-67e1-9fe2-cfbc-8b8f7bdb86bc@kernel.dk>
To:     Jens Axboe <axboe@kernel.dk>
X-Mailer: Apple Mail (2.3445.104.11)
X-QQ-SENDSIZE: 520
Feedback-ID: bizesmtp:kylinos.cn:qybgforeign:qybgforeign1
X-QQ-Bgrelay: 1
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org



> 在 2019年7月8日，12:13，Jens Axboe <axboe@kernel.dk> 写道：
> 
> On 7/7/19 8:07 PM, Jackie Liu wrote:
>> INFO: task syz-executor.5:8634 blocked for more than 143 seconds.
>>        Not tainted 5.2.0-rc5+ #3
>> "echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
>> syz-executor.5  D25632  8634   8224 0x00004004
>> Call Trace:
>>   context_switch kernel/sched/core.c:2818 [inline]
>>   __schedule+0x658/0x9e0 kernel/sched/core.c:3445
>>   schedule+0x131/0x1d0 kernel/sched/core.c:3509
>>   schedule_timeout+0x9a/0x2b0 kernel/time/timer.c:1783
>>   do_wait_for_common+0x35e/0x5a0 kernel/sched/completion.c:83
>>   __wait_for_common kernel/sched/completion.c:104 [inline]
>>   wait_for_common kernel/sched/completion.c:115 [inline]
>>   wait_for_completion+0x47/0x60 kernel/sched/completion.c:136
>>   kthread_stop+0xb4/0x150 kernel/kthread.c:559
>>   io_sq_thread_stop fs/io_uring.c:2252 [inline]
>>   io_finish_async fs/io_uring.c:2259 [inline]
>>   io_ring_ctx_free fs/io_uring.c:2770 [inline]
>>   io_ring_ctx_wait_and_kill+0x268/0x880 fs/io_uring.c:2834
>>   io_uring_release+0x5d/0x70 fs/io_uring.c:2842
>>   __fput+0x2e4/0x740 fs/file_table.c:280
>>   ____fput+0x15/0x20 fs/file_table.c:313
>>   task_work_run+0x17e/0x1b0 kernel/task_work.c:113
>>   tracehook_notify_resume include/linux/tracehook.h:185 [inline]
>>   exit_to_usermode_loop arch/x86/entry/common.c:168 [inline]
>>   prepare_exit_to_usermode+0x402/0x4f0 arch/x86/entry/common.c:199
>>   syscall_return_slowpath+0x110/0x440 arch/x86/entry/common.c:279
>>   do_syscall_64+0x126/0x140 arch/x86/entry/common.c:304
>>   entry_SYSCALL_64_after_hwframe+0x49/0xbe
>> RIP: 0033:0x412fb1
>> Code: 80 3b 7c 0f 84 c7 02 00 00 c7 85 d0 00 00 00 00 00 00 00 48 8b 05 cf
>> a6 24 00 49 8b 14 24 41 b9 cb 2a 44 00 48 89 ee 48 89 df <48> 85 c0 4c 0f
>> 45 c8 45 31 c0 31 c9 e8 0e 5b 00 00 85 c0 41 89 c7
>> RSP: 002b:00007ffe7ee6a180 EFLAGS: 00000293 ORIG_RAX: 0000000000000003
>> RAX: 0000000000000000 RBX: 0000000000000004 RCX: 0000000000412fb1
>> RDX: 0000001b2d920000 RSI: 0000000000000000 RDI: 0000000000000003
>> RBP: 0000000000000001 R08: 00000000f3a3e1f8 R09: 00000000f3a3e1fc
>> R10: 00007ffe7ee6a260 R11: 0000000000000293 R12: 000000000075c9a0
>> R13: 000000000075c9a0 R14: 0000000000024c00 R15: 000000000075bf2c
>> 
>> =============================================
>> 
>> There is an wrong logic, when kthread_park running
>> in front of io_sq_thread.
>> 
>> CPU#0					CPU#1
>> 
>> io_sq_thread_stop:			int kthread(void *_create):
>> 
>> kthread_park()
>> 					__kthread_parkme(self);	 <<< Wrong
>> kthread_stop()
>>     << wait for self->exited
>>     << clear_bit KTHREAD_SHOULD_PARK
>> 
>> 					ret = threadfn(data);
>> 					   |
>> 					   |- io_sq_thread
>> 					       |- kthread_should_park()	<< false
>> 					       |- schedule() <<< nobody wake up
>> 
>> stuck CPU#0				stuck CPU#1
>> 
>> So, use a new variable sqo_thread_started to ensure that io_sq_thread
>> run first, then io_sq_thread_stop.
>> 
>> Reported-by: syzbot+94324416c485d422fe15@syzkaller.appspotmail.com
>> Signed-off-by: Jackie Liu <liuyun01@kylinos.cn>
>> ---
>>  fs/io_uring.c | 8 ++++++++
>>  1 file changed, 8 insertions(+)
>> 
>> diff --git a/fs/io_uring.c b/fs/io_uring.c
>> index 4ef62a4..b7d92fa 100644
>> --- a/fs/io_uring.c
>> +++ b/fs/io_uring.c
>> @@ -78,6 +78,8 @@
>>  #define IORING_MAX_ENTRIES	4096
>>  #define IORING_MAX_FIXED_FILES	1024
>> 
>> +#define SQO_THREAD_STARTED	1
> 
> Should be 0, first bit.
> 
>> @@ -2243,6 +2249,8 @@ static int io_sqe_files_unregister(struct io_ring_ctx *ctx)
>>  static void io_sq_thread_stop(struct io_ring_ctx *ctx)
>>  {
>>  	if (ctx->sqo_thread) {
>> +		while (unlikely(!test_bit(SQO_THREAD_STARTED, &ctx->sqo_flags)))
>> +			schedule();
> 
> This doesn't really look safe - who wakes you up if the thread wasn't
> started to begin with, but got started right after? This needs to use
> some variant of a completion struct, for example, or some other way of
> waiting for the thread to have started.

Hi, Jens.

Yes, you are right, I will use a completion struct for new version, base
on 'drivers/staging/wilc1000/wilc_netdev.c',

It's wl->txq_thread_started.

Thanks.

> 
> -- 
> Jens Axboe
> 
> 



