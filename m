Return-Path: <SRS0=8/B6=VF=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 06480C48BE7
	for <linux-block@archiver.kernel.org>; Mon,  8 Jul 2019 04:13:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CDEE7204EC
	for <linux-block@archiver.kernel.org>; Mon,  8 Jul 2019 04:13:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="Hak6ImQ1"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726170AbfGHENZ (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 8 Jul 2019 00:13:25 -0400
Received: from mail-pl1-f196.google.com ([209.85.214.196]:39940 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725781AbfGHENY (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Mon, 8 Jul 2019 00:13:24 -0400
Received: by mail-pl1-f196.google.com with SMTP id a93so7553589pla.7
        for <linux-block@vger.kernel.org>; Sun, 07 Jul 2019 21:13:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=i+Gp7e2TTVWRIGNtNLLcS+/aDwgs42Rp9ma9jgTCkU0=;
        b=Hak6ImQ1L5z+ZH2jrgXemVa9L7v/9lZtxDmQADVlXJcLTaThiAfIznHSDVo5NMn/pG
         eF9y+q0wyM9Ma8trLkcLIcuxIPe0ZUHAJhVTcpp/3uQySxmWuqWK555v+2dMHQML1T92
         YmOroxoUzr2CtuXfB6UKDUqRRXsyaLMkklQ9dtB0ndkzb9EFvq5wD3nM+cFzdIBU81RA
         OXMO5pzzx4/7QEHjbuuh90oUzEs79fpTV8/hd/Q2hFprPE/MNKLko9a/l2ls2SuU9aJA
         SBruN1GJvhEYlc6C5UHiAhPDthxVUTJKHXOGsEMma5urFatVnrf2WkgKGHCYmijcGP/p
         eeFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=i+Gp7e2TTVWRIGNtNLLcS+/aDwgs42Rp9ma9jgTCkU0=;
        b=J95yWIpvASfXAJj/e4dPcOOyHw+7iKHJvwdl0C+0egrPyZzHsD7fYt5GolBpZPUqPz
         f5ydxIRivTC915EFrJBczoXqQpLvwAJKThWw3MGsWH2nTR362/ZDFSN5BqJvQkfhPu+U
         8jPAjHeaDhsJ+757U5xrYHGyNts+1mmSvA9FR3nw28U1p9zwscu3wgZra2XMgu4F9mXX
         LSXHS1E2LxqM4QHyHr7lXhUC4uRuoh+s4l+pdHLctUdAvvnfl9CnVDFUQzvEWhwo68SK
         o+ALjunm/KhiBd3zwb0ElBJi3IUllW9B2Mr3YZjmTWrf2bZQPkRfe/nK+nUeqcDzFGBU
         mPWQ==
X-Gm-Message-State: APjAAAWKdvHvsMDU3Wz/ej/M3IDYOe2BVg/VR+RAf2mx7FuCf+PSwcQm
        iBozh3I2Ae6XptL3ZrXCU1a9VAx6+RJ7Mg==
X-Google-Smtp-Source: APXvYqxq6KEoRkGD1iTH9nPcowa/2BUjry2uKCnNGeHS6wEKVPK0/ICboSzwPlalxCcKuU+ZBJ9qAA==
X-Received: by 2002:a17:902:aa09:: with SMTP id be9mr21255636plb.52.1562559203693;
        Sun, 07 Jul 2019 21:13:23 -0700 (PDT)
Received: from [192.168.1.121] (66.29.164.166.static.utbb.net. [66.29.164.166])
        by smtp.gmail.com with ESMTPSA id q1sm19441355pfg.84.2019.07.07.21.13.21
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 07 Jul 2019 21:13:21 -0700 (PDT)
Subject: Re: [PATCH v2] io_uring: fix io_sq_thread_stop running in front of
 io_sq_thread
To:     Jackie Liu <liuyun01@kylinos.cn>
Cc:     ebiggers@kernel.org, liuzhengyuan@kylinos.cn,
        linux-block@vger.kernel.org
References: <1562551626-22358-1-git-send-email-liuyun01@kylinos.cn>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <1d1473d2-67e1-9fe2-cfbc-8b8f7bdb86bc@kernel.dk>
Date:   Sun, 7 Jul 2019 22:13:21 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.2
MIME-Version: 1.0
In-Reply-To: <1562551626-22358-1-git-send-email-liuyun01@kylinos.cn>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 7/7/19 8:07 PM, Jackie Liu wrote:
> INFO: task syz-executor.5:8634 blocked for more than 143 seconds.
>         Not tainted 5.2.0-rc5+ #3
> "echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
> syz-executor.5  D25632  8634   8224 0x00004004
> Call Trace:
>    context_switch kernel/sched/core.c:2818 [inline]
>    __schedule+0x658/0x9e0 kernel/sched/core.c:3445
>    schedule+0x131/0x1d0 kernel/sched/core.c:3509
>    schedule_timeout+0x9a/0x2b0 kernel/time/timer.c:1783
>    do_wait_for_common+0x35e/0x5a0 kernel/sched/completion.c:83
>    __wait_for_common kernel/sched/completion.c:104 [inline]
>    wait_for_common kernel/sched/completion.c:115 [inline]
>    wait_for_completion+0x47/0x60 kernel/sched/completion.c:136
>    kthread_stop+0xb4/0x150 kernel/kthread.c:559
>    io_sq_thread_stop fs/io_uring.c:2252 [inline]
>    io_finish_async fs/io_uring.c:2259 [inline]
>    io_ring_ctx_free fs/io_uring.c:2770 [inline]
>    io_ring_ctx_wait_and_kill+0x268/0x880 fs/io_uring.c:2834
>    io_uring_release+0x5d/0x70 fs/io_uring.c:2842
>    __fput+0x2e4/0x740 fs/file_table.c:280
>    ____fput+0x15/0x20 fs/file_table.c:313
>    task_work_run+0x17e/0x1b0 kernel/task_work.c:113
>    tracehook_notify_resume include/linux/tracehook.h:185 [inline]
>    exit_to_usermode_loop arch/x86/entry/common.c:168 [inline]
>    prepare_exit_to_usermode+0x402/0x4f0 arch/x86/entry/common.c:199
>    syscall_return_slowpath+0x110/0x440 arch/x86/entry/common.c:279
>    do_syscall_64+0x126/0x140 arch/x86/entry/common.c:304
>    entry_SYSCALL_64_after_hwframe+0x49/0xbe
> RIP: 0033:0x412fb1
> Code: 80 3b 7c 0f 84 c7 02 00 00 c7 85 d0 00 00 00 00 00 00 00 48 8b 05 cf
> a6 24 00 49 8b 14 24 41 b9 cb 2a 44 00 48 89 ee 48 89 df <48> 85 c0 4c 0f
> 45 c8 45 31 c0 31 c9 e8 0e 5b 00 00 85 c0 41 89 c7
> RSP: 002b:00007ffe7ee6a180 EFLAGS: 00000293 ORIG_RAX: 0000000000000003
> RAX: 0000000000000000 RBX: 0000000000000004 RCX: 0000000000412fb1
> RDX: 0000001b2d920000 RSI: 0000000000000000 RDI: 0000000000000003
> RBP: 0000000000000001 R08: 00000000f3a3e1f8 R09: 00000000f3a3e1fc
> R10: 00007ffe7ee6a260 R11: 0000000000000293 R12: 000000000075c9a0
> R13: 000000000075c9a0 R14: 0000000000024c00 R15: 000000000075bf2c
> 
> =============================================
> 
> There is an wrong logic, when kthread_park running
> in front of io_sq_thread.
> 
> CPU#0					CPU#1
> 
> io_sq_thread_stop:			int kthread(void *_create):
> 
> kthread_park()
> 					__kthread_parkme(self);	 <<< Wrong
> kthread_stop()
>      << wait for self->exited
>      << clear_bit KTHREAD_SHOULD_PARK
> 
> 					ret = threadfn(data);
> 					   |
> 					   |- io_sq_thread
> 					       |- kthread_should_park()	<< false
> 					       |- schedule() <<< nobody wake up
> 
> stuck CPU#0				stuck CPU#1
> 
> So, use a new variable sqo_thread_started to ensure that io_sq_thread
> run first, then io_sq_thread_stop.
> 
> Reported-by: syzbot+94324416c485d422fe15@syzkaller.appspotmail.com
> Signed-off-by: Jackie Liu <liuyun01@kylinos.cn>
> ---
>   fs/io_uring.c | 8 ++++++++
>   1 file changed, 8 insertions(+)
> 
> diff --git a/fs/io_uring.c b/fs/io_uring.c
> index 4ef62a4..b7d92fa 100644
> --- a/fs/io_uring.c
> +++ b/fs/io_uring.c
> @@ -78,6 +78,8 @@
>   #define IORING_MAX_ENTRIES	4096
>   #define IORING_MAX_FIXED_FILES	1024
>   
> +#define SQO_THREAD_STARTED	1

Should be 0, first bit.

> @@ -2243,6 +2249,8 @@ static int io_sqe_files_unregister(struct io_ring_ctx *ctx)
>   static void io_sq_thread_stop(struct io_ring_ctx *ctx)
>   {
>   	if (ctx->sqo_thread) {
> +		while (unlikely(!test_bit(SQO_THREAD_STARTED, &ctx->sqo_flags)))
> +			schedule();

This doesn't really look safe - who wakes you up if the thread wasn't
started to begin with, but got started right after? This needs to use
some variant of a completion struct, for example, or some other way of
waiting for the thread to have started.

-- 
Jens Axboe

