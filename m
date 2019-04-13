Return-Path: <SRS0=i+2c=SP=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 180D0C10F14
	for <linux-block@archiver.kernel.org>; Sat, 13 Apr 2019 15:13:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D17702082E
	for <linux-block@archiver.kernel.org>; Sat, 13 Apr 2019 15:13:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="NQWqp4gw"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727204AbfDMPNy (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Sat, 13 Apr 2019 11:13:54 -0400
Received: from mail-pg1-f194.google.com ([209.85.215.194]:45513 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727171AbfDMPNx (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Sat, 13 Apr 2019 11:13:53 -0400
Received: by mail-pg1-f194.google.com with SMTP id y3so6544889pgk.12
        for <linux-block@vger.kernel.org>; Sat, 13 Apr 2019 08:13:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:references:from:message-id:date:user-agent:mime-version
         :in-reply-to:content-language:content-transfer-encoding;
        bh=EMeQkZNPZK4BNLMkFl8YLqqorRHFUA+Z34QfP9hnmL4=;
        b=NQWqp4gwp2bA6X5TVcZezzqjNj0VKeoTn+YJAdnFBf30tM1lVCE2MrGWbyjUy2XU2H
         FKsaUBnFLkiD+XjOoS3qFASuW65AJ04+NZoiAkDlhRvwNY2lMqsFzplOC3F8U8GQn3SQ
         qLM3l2r/T4VW9WSxQ29Y8130FBDSpJHoZH6HmR61zM53DKRKCoWFdG7Es4zeatIOZQQF
         tDuRniKfzHxdY5ibXabyigN7anoNto9lgAyGasK09lT2HMvuwVAaclaRbQkGfRdJHK+x
         3W0SIdpHLF4+F17Bsavsm23hq7dx35Mitwd/yIjbxaISYMyxQfKcFb5hHKbQIKLSJ0ch
         Uhpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=EMeQkZNPZK4BNLMkFl8YLqqorRHFUA+Z34QfP9hnmL4=;
        b=X4WMTr4mJ3yXL1mm0jSbg/exnkKiNR5FAsy+UhNNeh+aPUYtQ1FTpJ56OAiQzod38g
         Od10O6/UQ8iiJC3QC+LtXDSXmQAeZ+m/cLRpQfiqDVBWcdnfwz2uMZyXavnlkr40Wbel
         6tFe2P7p1oTVvBxX/t1mscf7lpQfE5isqux3buYzmZT7r2rc8FihGu/7i6h8CbY29AoZ
         /pZ3o+fpPNExKg99kG/EaVGd+FngS4dd4YEgt3Kl7HjvJ2el9kGZCkNuCWBKIQQm//zO
         Z/RgnLwxJQ77dHxbIBPKQD9vpAGrwS980G7s0rOvKpqzqnkaYDcfoXnSBbRSOH+mVSWH
         A/wQ==
X-Gm-Message-State: APjAAAXwe6gt9855YfwxAzqo9TLdNv7XdFi8iBm5DaTY5C9Ghkfy+B3v
        Q07cXpa436lErajrXlaLwZA9Gg==
X-Google-Smtp-Source: APXvYqygX0Qwi14+fqaRGgHdPomqe6K5nDHKkM8wK2deBQlGqb2Ji7UF8a1KW1cdlH5viJ9B++6hXg==
X-Received: by 2002:aa7:91c8:: with SMTP id z8mr64264122pfa.110.1555168432320;
        Sat, 13 Apr 2019 08:13:52 -0700 (PDT)
Received: from [192.168.1.121] (66.29.188.166.static.utbb.net. [66.29.188.166])
        by smtp.gmail.com with ESMTPSA id i15sm31636408pfr.8.2019.04.13.08.13.48
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 13 Apr 2019 08:13:50 -0700 (PDT)
Subject: Re: WARNING in __kthread_bind_mask
To:     syzbot <syzbot+6d4a92619eb0ad08602b@syzkaller.appspotmail.com>,
        hare@suse.com, linux-block@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        syzkaller-bugs@googlegroups.com, viro@zeniv.linux.org.uk
References: <00000000000033aefc058665083c@google.com>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <c4785bc1-9e49-4a49-2752-77162e99ab32@kernel.dk>
Date:   Sat, 13 Apr 2019 09:13:47 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <00000000000033aefc058665083c@google.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 4/13/19 2:16 AM, syzbot wrote:
> Hello,
> 
> syzbot found the following crash on:
> 
> HEAD commit:    bcb67f0f Add linux-next specific files for 20190412
> git tree:       linux-next
> console output: https://syzkaller.appspot.com/x/log.txt?x=165912d3200000
> kernel config:  https://syzkaller.appspot.com/x/.config?x=35c479ecf64ba753
> dashboard link: https://syzkaller.appspot.com/bug?extid=6d4a92619eb0ad08602b
> compiler:       gcc (GCC) 9.0.0 20181231 (experimental)
> syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=14c9ebbb200000
> C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=153f76dd200000
> 
> The bug was bisected to:
> 
> commit 6c271ce2f1d572f7fa225700a13cfe7ced492434
> Author: Jens Axboe <axboe@kernel.dk>
> Date:   Thu Jan 10 18:22:30 2019 +0000
> 
>      io_uring: add submission polling
> 
> bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=143498f3200000
> final crash:    https://syzkaller.appspot.com/x/report.txt?x=163498f3200000
> console output: https://syzkaller.appspot.com/x/log.txt?x=123498f3200000
> 
> IMPORTANT: if you fix the bug, please add the following tag to the commit:
> Reported-by: syzbot+6d4a92619eb0ad08602b@syzkaller.appspotmail.com
> Fixes: 6c271ce2f1d5 ("io_uring: add submission polling")
> 
> WARNING: CPU: 0 PID: 7822 at kernel/kthread.c:399  
> __kthread_bind_mask+0x3b/0xc0 kernel/kthread.c:399
> Kernel panic - not syncing: panic_on_warn set ...
> CPU: 0 PID: 7822 Comm: syz-executor030 Not tainted 5.1.0-rc4-next-20190412  
> #24
> Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS  
> Google 01/01/2011
> Call Trace:
>   __dump_stack lib/dump_stack.c:77 [inline]
>   dump_stack+0x172/0x1f0 lib/dump_stack.c:113
>   panic+0x2cb/0x72b kernel/panic.c:214
>   __warn.cold+0x20/0x46 kernel/panic.c:576
>   report_bug+0x263/0x2b0 lib/bug.c:186
>   fixup_bug arch/x86/kernel/traps.c:179 [inline]
>   fixup_bug arch/x86/kernel/traps.c:174 [inline]
>   do_error_trap+0x11b/0x200 arch/x86/kernel/traps.c:272
>   do_invalid_op+0x37/0x50 arch/x86/kernel/traps.c:291
>   invalid_op+0x14/0x20 arch/x86/entry/entry_64.S:973
> RIP: 0010:__kthread_bind_mask+0x3b/0xc0 kernel/kthread.c:399
> Code: 48 89 fb e8 f7 ab 24 00 4c 89 e6 48 89 df e8 ac e1 02 00 31 ff 49 89  
> c4 48 89 c6 e8 7f ad 24 00 4d 85 e4 75 15 e8 d5 ab 24 00 <0f> 0b e8 ce ab  
> 24 00 5b 41 5c 41 5d 41 5e 5d c3 e8 c0 ab 24 00 4c
> RSP: 0018:ffff8880a89bfbb8 EFLAGS: 00010293
> RAX: ffff88808ca7a280 RBX: ffff8880a98e4380 RCX: ffffffff814bdd11
> RDX: 0000000000000000 RSI: ffffffff814bdd1b RDI: 0000000000000007
> RBP: ffff8880a89bfbd8 R08: ffff88808ca7a280 R09: 0000000000000000
> R10: 0000000000000000 R11: 0000000000000000 R12: 0000000000000000
> R13: ffffffff87691148 R14: ffff8880a98e43a0 R15: ffffffff81c91e10
>   __kthread_bind kernel/kthread.c:412 [inline]
>   kthread_unpark+0x123/0x160 kernel/kthread.c:480
>   kthread_stop+0xfa/0x6c0 kernel/kthread.c:556
>   io_sq_thread_stop fs/io_uring.c:2057 [inline]
>   io_sq_thread_stop fs/io_uring.c:2052 [inline]
>   io_finish_async+0xab/0x180 fs/io_uring.c:2064
>   io_ring_ctx_free fs/io_uring.c:2534 [inline]
>   io_ring_ctx_wait_and_kill+0x133/0x510 fs/io_uring.c:2591
>   io_uring_release+0x42/0x50 fs/io_uring.c:2599
>   __fput+0x2e5/0x8d0 fs/file_table.c:278
>   ____fput+0x16/0x20 fs/file_table.c:309
>   task_work_run+0x14a/0x1c0 kernel/task_work.c:113
>   exit_task_work include/linux/task_work.h:22 [inline]
>   do_exit+0x90a/0x2fa0 kernel/exit.c:876
>   do_group_exit+0x135/0x370 kernel/exit.c:980
>   __do_sys_exit_group kernel/exit.c:991 [inline]
>   __se_sys_exit_group kernel/exit.c:989 [inline]
>   __x64_sys_exit_group+0x44/0x50 kernel/exit.c:989
>   do_syscall_64+0x103/0x610 arch/x86/entry/common.c:290
>   entry_SYSCALL_64_after_hwframe+0x49/0xbe
> RIP: 0033:0x43ee98
> Code: Bad RIP value.
> RSP: 002b:00007fff28656a18 EFLAGS: 00000246 ORIG_RAX: 00000000000000e7
> RAX: ffffffffffffffda RBX: 0000000000000000 RCX: 000000000043ee98
> RDX: 0000000000000000 RSI: 000000000000003c RDI: 0000000000000000
> RBP: 00000000004be6a8 R08: 00000000000000e7 R09: ffffffffffffffd0
> R10: 00000000ffffffff R11: 0000000000000246 R12: 0000000000000001
> R13: 00000000006d0180 R14: 0000000000000000 R15: 0000000000000000
> Kernel Offset: disabled
> Rebooting in 86400 seconds..

This should fix it.


diff --git a/fs/io_uring.c b/fs/io_uring.c
index 07d6ef195d05..06ee42cfb9c7 100644
--- a/fs/io_uring.c
+++ b/fs/io_uring.c
@@ -1920,6 +1920,10 @@ static int io_sq_thread(void *data)
 		unuse_mm(cur_mm);
 		mmput(cur_mm);
 	}
+
+	if (kthread_should_park())
+		kthread_parkme();
+
 	return 0;
 }
 
@@ -2054,6 +2058,7 @@ static void io_sq_thread_stop(struct io_ring_ctx *ctx)
 	if (ctx->sqo_thread) {
 		ctx->sqo_stop = 1;
 		mb();
+		kthread_park(ctx->sqo_thread);
 		kthread_stop(ctx->sqo_thread);
 		ctx->sqo_thread = NULL;
 	}

-- 
Jens Axboe

