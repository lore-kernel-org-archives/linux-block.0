Return-Path: <SRS0=7FI7=SR=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 96C8FC282DA
	for <linux-block@archiver.kernel.org>; Mon, 15 Apr 2019 16:49:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4CEBA2087C
	for <linux-block@archiver.kernel.org>; Mon, 15 Apr 2019 16:49:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="iD7RiUb6"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727633AbfDOQta (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 15 Apr 2019 12:49:30 -0400
Received: from mail-it1-f196.google.com ([209.85.166.196]:54020 "EHLO
        mail-it1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727598AbfDOQt3 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 15 Apr 2019 12:49:29 -0400
Received: by mail-it1-f196.google.com with SMTP id y204so28128196itf.3
        for <linux-block@vger.kernel.org>; Mon, 15 Apr 2019 09:49:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:references:from:message-id:date:user-agent:mime-version
         :in-reply-to:content-language:content-transfer-encoding;
        bh=zPfgrP+xMGw2jpeJZAt0Vf1te85+6udsGgr2e/tUZvk=;
        b=iD7RiUb66BNtjmp0f5xXv6gywfXIZPZUW0du5mq78eAFjsNUlF6i/oRG3O60BW6gfh
         bCZ1rp8UIVNMbLtGLsPOfX8uiewS2E579Ely88/5eMTQHi/bL8ZOnu5ax8nmKuEAOXoC
         WL7/nEXFarHSKdmlzUa6yxMAcLgh5wZZc9wjdjzaFhlbh9dUyYBbyiZhpE5kSBId7EIM
         pUlWjnnc/hqyo6nohvdVNCxwFg+hoWQHIbAyol95ahNjOysd3yjy4ExO/CThBf5P+5c+
         nkNcWFy/kctIOKZlO0EuWUceYruKtO8qNWa5dG1Kca4yb4UT5ZNa/YJECow54nF0El6B
         KTRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=zPfgrP+xMGw2jpeJZAt0Vf1te85+6udsGgr2e/tUZvk=;
        b=Ih5xSve9clH0dcQjsf3PNLhfz1/05t+Zl8As3zq9LKZ7A6/kNp+CJFRAwEmd/fFhNL
         1ISS5v4JNm0h2WRlexZ2ommKYCJ8ujlq5hQGIhPPB0VXGRvUwnX/snMSqLNF9xfufO46
         QzwL4M8GrM9Z3azrGMln6MjFyxKpak3wN/qApK6tmSxhsvFDLfGiwgVCSBl9MLTDY6Mu
         DLp6KFYh2SFBOPv9XJhE5+dZXvC0wGD92xlLWChwVPIzv8yjy3dDLVu3c0lQ2pcUrr+8
         ytjGUWVpdafG8spkitJARRDJhNlGupYyQWQs6KQMEW5otx66RZRFatPYvtekqgbnLdDg
         ZTsg==
X-Gm-Message-State: APjAAAWIcI3UFgc50rnSF4+7WXZ8r8YkDCyZVsZJEq9QTxNMWpcuSICk
        Hdusfx48yd8GG+50iO74IjeX7g==
X-Google-Smtp-Source: APXvYqyUwUQTh3kPrNpu5wsDhzJ388E+zYD+z5THBnUw7KntWxmU99ke6YzNWHZKVNpLGhMMZXEzyw==
X-Received: by 2002:a24:1342:: with SMTP id 63mr26075175itz.69.1555346968015;
        Mon, 15 Apr 2019 09:49:28 -0700 (PDT)
Received: from [192.168.1.158] ([216.160.245.98])
        by smtp.gmail.com with ESMTPSA id u66sm19127979ioe.74.2019.04.15.09.49.25
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 15 Apr 2019 09:49:26 -0700 (PDT)
Subject: Re: INFO: task hung in __io_uring_register
To:     syzbot <syzbot+16dc03452dee970a0c3e@syzkaller.appspotmail.com>,
        linux-block@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com,
        viro@zeniv.linux.org.uk
References: <0000000000003393e6058691f589@google.com>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <0ed0d88e-268b-fc1c-0273-2f4063cf75a1@kernel.dk>
Date:   Mon, 15 Apr 2019 10:49:25 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <0000000000003393e6058691f589@google.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 4/15/19 7:52 AM, syzbot wrote:
> syzbot has found a reproducer for the following crash on:
> 
> HEAD commit:    dc4060a5 Linux 5.1-rc5
> git tree:       upstream
> console output: https://syzkaller.appspot.com/x/log.txt?x=17eacddd200000
> kernel config:  https://syzkaller.appspot.com/x/.config?x=856fc6d0fbbeede9
> dashboard link: https://syzkaller.appspot.com/bug?extid=16dc03452dee970a0c3e
> compiler:       gcc (GCC) 9.0.0 20181231 (experimental)
> userspace arch: i386
> syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=14eb47ed200000
> C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=112175dd200000
> 
> IMPORTANT: if you fix the bug, please add the following tag to the commit:
> Reported-by: syzbot+16dc03452dee970a0c3e@syzkaller.appspotmail.com
> 
> INFO: task syz-executor043:8083 blocked for more than 143 seconds.
>        Not tainted 5.1.0-rc5 #68
> "echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
> syz-executor043 D29912  8083   8063 0x20020004
> Call Trace:
>   context_switch kernel/sched/core.c:2877 [inline]
>   __schedule+0x813/0x1cc0 kernel/sched/core.c:3518
>   schedule+0x92/0x180 kernel/sched/core.c:3562
>   schedule_timeout+0x8ca/0xfd0 kernel/time/timer.c:1779
>   do_wait_for_common kernel/sched/completion.c:83 [inline]
>   __wait_for_common kernel/sched/completion.c:104 [inline]
>   wait_for_common kernel/sched/completion.c:115 [inline]
>   wait_for_completion+0x29c/0x440 kernel/sched/completion.c:136
>   __io_uring_register+0xb6/0x1fd0 fs/io_uring.c:2929
>   __do_sys_io_uring_register fs/io_uring.c:2979 [inline]
>   __se_sys_io_uring_register fs/io_uring.c:2961 [inline]
>   __ia32_sys_io_uring_register+0x193/0x1f0 fs/io_uring.c:2961
>   do_syscall_32_irqs_on arch/x86/entry/common.c:326 [inline]
>   do_fast_syscall_32+0x281/0xc98 arch/x86/entry/common.c:397
>   entry_SYSENTER_compat+0x70/0x7f arch/x86/entry/entry_64_compat.S:139
> RIP: 0023:0xf7f06869
> Code: Bad RIP value.
> RSP: 002b:00000000f7f021ec EFLAGS: 00000296 ORIG_RAX: 00000000000001ab
> RAX: ffffffffffffffda RBX: 0000000000000003 RCX: 0000000000000001
> RDX: 0000000000000000 RSI: 0000000000000000 RDI: 000000000000014a
> RBP: 00000000200000c0 R08: 0000000000000000 R09: 0000000000000000
> R10: 0000000000000000 R11: 0000000000000000 R12: 0000000000000000
> R13: 0000000000000000 R14: 0000000000000000 R15: 0000000000000000
> INFO: task syz-executor043:8084 blocked for more than 143 seconds.
>        Not tainted 5.1.0-rc5 #68
> "echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
> syz-executor043 D30320  8084   8063 0x20020004
> Call Trace:
>   context_switch kernel/sched/core.c:2877 [inline]
>   __schedule+0x813/0x1cc0 kernel/sched/core.c:3518
>   schedule+0x92/0x180 kernel/sched/core.c:3562
>   schedule_preempt_disabled+0x13/0x20 kernel/sched/core.c:3620
>   __mutex_lock_common kernel/locking/mutex.c:1002 [inline]
>   __mutex_lock+0x726/0x1310 kernel/locking/mutex.c:1072
>   mutex_lock_nested+0x16/0x20 kernel/locking/mutex.c:1087
>   __do_sys_io_uring_enter fs/io_uring.c:2678 [inline]
>   __se_sys_io_uring_enter fs/io_uring.c:2637 [inline]
>   __ia32_sys_io_uring_enter+0x67f/0xac0 fs/io_uring.c:2637
>   do_syscall_32_irqs_on arch/x86/entry/common.c:326 [inline]
>   do_fast_syscall_32+0x281/0xc98 arch/x86/entry/common.c:397
>   entry_SYSENTER_compat+0x70/0x7f arch/x86/entry/entry_64_compat.S:139
> RIP: 0023:0xf7f06869
> Code: Bad RIP value.
> RSP: 002b:00000000f7ee11ec EFLAGS: 00000292 ORIG_RAX: 00000000000001aa
> RAX: ffffffffffffffda RBX: 0000000000000003 RCX: 0000000000010005
> RDX: 0000000000000002 RSI: 0000000000000003 RDI: 0000000000000000
> RBP: 0000000000000000 R08: 0000000000000000 R09: 0000000000000000
> R10: 0000000000000000 R11: 0000000000000000 R12: 0000000000000000
> R13: 0000000000000000 R14: 0000000000000000 R15: 0000000000000000
> 
> Showing all locks held in the system:
> 1 lock held by khungtaskd/1042:
>   #0: 00000000fbdbf33e (rcu_read_lock){....}, at:  
> debug_show_all_locks+0x5f/0x27e kernel/locking/lockdep.c:5056
> 2 locks held by rsyslogd/7952:
>   #0: 000000001bb2c5a7 (&f->f_pos_lock){+.+.}, at: __fdget_pos+0xee/0x110  
> fs/file.c:801
>   #1: 000000007392ce44 (fs_reclaim){+.+.}, at: is_bpf_text_address+0x0/0x170  
> kernel/bpf/core.c:697
> 2 locks held by getty/8041:
>   #0: 00000000e7d67802 (&tty->ldisc_sem){++++}, at:  
> ldsem_down_read+0x33/0x40 drivers/tty/tty_ldsem.c:341
>   #1: 0000000026520570 (&ldata->atomic_read_lock){+.+.}, at:  
> n_tty_read+0x232/0x1b70 drivers/tty/n_tty.c:2156
> 2 locks held by getty/8042:
>   #0: 000000004426012c (&tty->ldisc_sem){++++}, at:  
> ldsem_down_read+0x33/0x40 drivers/tty/tty_ldsem.c:341
>   #1: 0000000004c02a9e (&ldata->atomic_read_lock){+.+.}, at:  
> n_tty_read+0x232/0x1b70 drivers/tty/n_tty.c:2156
> 2 locks held by getty/8043:
>   #0: 00000000e0209856 (&tty->ldisc_sem){++++}, at:  
> ldsem_down_read+0x33/0x40 drivers/tty/tty_ldsem.c:341
>   #1: 000000009f921bda (&ldata->atomic_read_lock){+.+.}, at:  
> n_tty_read+0x232/0x1b70 drivers/tty/n_tty.c:2156
> 2 locks held by getty/8044:
>   #0: 0000000000de2ea5 (&tty->ldisc_sem){++++}, at:  
> ldsem_down_read+0x33/0x40 drivers/tty/tty_ldsem.c:341
>   #1: 000000002674bf52 (&ldata->atomic_read_lock){+.+.}, at:  
> n_tty_read+0x232/0x1b70 drivers/tty/n_tty.c:2156
> 2 locks held by getty/8045:
>   #0: 00000000abbba1ef (&tty->ldisc_sem){++++}, at:  
> ldsem_down_read+0x33/0x40 drivers/tty/tty_ldsem.c:341
>   #1: 00000000ef32475e (&ldata->atomic_read_lock){+.+.}, at:  
> n_tty_read+0x232/0x1b70 drivers/tty/n_tty.c:2156
> 2 locks held by getty/8046:
>   #0: 000000008d742c83 (&tty->ldisc_sem){++++}, at:  
> ldsem_down_read+0x33/0x40 drivers/tty/tty_ldsem.c:341
>   #1: 00000000fa255b8a (&ldata->atomic_read_lock){+.+.}, at:  
> n_tty_read+0x232/0x1b70 drivers/tty/n_tty.c:2156
> 2 locks held by getty/8047:
>   #0: 00000000d3d56b2b (&tty->ldisc_sem){++++}, at:  
> ldsem_down_read+0x33/0x40 drivers/tty/tty_ldsem.c:341
>   #1: 0000000015242045 (&ldata->atomic_read_lock){+.+.}, at:  
> n_tty_read+0x232/0x1b70 drivers/tty/n_tty.c:2156
> 1 lock held by syz-executor043/8083:
>   #0: 000000005524ed18 (&ctx->uring_lock){+.+.}, at:  
> __do_sys_io_uring_register fs/io_uring.c:2978 [inline]
>   #0: 000000005524ed18 (&ctx->uring_lock){+.+.}, at:  
> __se_sys_io_uring_register fs/io_uring.c:2961 [inline]
>   #0: 000000005524ed18 (&ctx->uring_lock){+.+.}, at:  
> __ia32_sys_io_uring_register+0x182/0x1f0 fs/io_uring.c:2961
> 1 lock held by syz-executor043/8084:
>   #0: 000000005524ed18 (&ctx->uring_lock){+.+.}, at: __do_sys_io_uring_enter  
> fs/io_uring.c:2678 [inline]
>   #0: 000000005524ed18 (&ctx->uring_lock){+.+.}, at: __se_sys_io_uring_enter  
> fs/io_uring.c:2637 [inline]
>   #0: 000000005524ed18 (&ctx->uring_lock){+.+.}, at:  
> __ia32_sys_io_uring_enter+0x67f/0xac0 fs/io_uring.c:2637
> 
> =============================================
> 
> NMI backtrace for cpu 1
> CPU: 1 PID: 1042 Comm: khungtaskd Not tainted 5.1.0-rc5 #68
> Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS  
> Google 01/01/2011
> Call Trace:
>   __dump_stack lib/dump_stack.c:77 [inline]
>   dump_stack+0x172/0x1f0 lib/dump_stack.c:113
>   nmi_cpu_backtrace.cold+0x63/0xa4 lib/nmi_backtrace.c:101
>   nmi_trigger_cpumask_backtrace+0x1be/0x236 lib/nmi_backtrace.c:62
>   arch_trigger_cpumask_backtrace+0x14/0x20 arch/x86/kernel/apic/hw_nmi.c:38
>   trigger_all_cpu_backtrace include/linux/nmi.h:146 [inline]
>   check_hung_uninterruptible_tasks kernel/hung_task.c:204 [inline]
>   watchdog+0x9b7/0xec0 kernel/hung_task.c:288
>   kthread+0x357/0x430 kernel/kthread.c:253
>   ret_from_fork+0x3a/0x50 arch/x86/entry/entry_64.S:352
> Sending NMI from CPU 1 to CPUs 0:

This is a deadlock due to io_uring_register() waiting for existing
users to exit. But it does so with the io_uring mutex held, and
existing callers to io_uring_enter() may need that mutex to make
progress. Hence we're deadlocked - one side holding the mutex and
waiting for users to exit, the other side waiting on the mutex
to make progress and then exit.

This should fix it.


diff --git a/fs/io_uring.c b/fs/io_uring.c
index f4ddb9d23241..b35300e4c9a7 100644
--- a/fs/io_uring.c
+++ b/fs/io_uring.c
@@ -2929,11 +2929,23 @@ SYSCALL_DEFINE2(io_uring_setup, u32, entries,
 
 static int __io_uring_register(struct io_ring_ctx *ctx, unsigned opcode,
 			       void __user *arg, unsigned nr_args)
+	__releases(ctx->uring_lock)
+	__acquires(ctx->uring_lock)
 {
 	int ret;
 
 	percpu_ref_kill(&ctx->refs);
+
+	/*
+	 * Drop uring mutex before waiting for references to exit. If another
+	 * thread is currently inside io_uring_enter() it might need to grab
+	 * the uring_lock to make progress. If we hold it here across the drain
+	 * wait, then we can deadlock. It's safe to drop the mutex here, since
+	 * no new references will come in after we've killed the percpu ref.
+	 */
+	mutex_unlock(&ctx->uring_lock);
 	wait_for_completion(&ctx->ctx_done);
+	mutex_lock(&ctx->uring_lock);
 
 	switch (opcode) {
 	case IORING_REGISTER_BUFFERS:

-- 
Jens Axboe

