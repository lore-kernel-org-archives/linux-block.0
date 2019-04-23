Return-Path: <SRS0=N4qE=SZ=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 090AFC10F03
	for <linux-block@archiver.kernel.org>; Tue, 23 Apr 2019 16:28:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B901720645
	for <linux-block@archiver.kernel.org>; Tue, 23 Apr 2019 16:28:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="WuChwvah"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727737AbfDWQ2b (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 23 Apr 2019 12:28:31 -0400
Received: from mail-it1-f193.google.com ([209.85.166.193]:51775 "EHLO
        mail-it1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726655AbfDWQ2a (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 23 Apr 2019 12:28:30 -0400
Received: by mail-it1-f193.google.com with SMTP id s3so1208620itk.1
        for <linux-block@vger.kernel.org>; Tue, 23 Apr 2019 09:28:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=HW9AaEkgrzEZ42cRhQ9y8e3MA20EKlTQKZnVjemCfqc=;
        b=WuChwvahDN5EtBp+uKD5od6zpei09rGUG3CLGlB4ter6JNzf/4Mcw4mxOwb/2ag9w7
         tC+tl6HFarxuRCGCxf+/ypyBsx45EXDbabr+joV+TsmxxSJUHQ4GqBPYXyD4t9lAkajK
         hCgZLvYF5bfHUcvqMdCJBqHQTVtnaywIcEl/bcozcQohFH6xLp3kzqA8ViYwbLJLQ/rx
         oqJUWBN4UEG/KMfrvIInh9K65j6G+/Z5n3VQRHMYJgL+p13JfqSrGyNDMiKw9XggUw0Q
         blyj+6bmEJsoKTgyQSJ5uQEYExJ9SSR29E1681KOYa+G6zHBof3utZjb8R3bLOm0VULI
         DV1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=HW9AaEkgrzEZ42cRhQ9y8e3MA20EKlTQKZnVjemCfqc=;
        b=eGJQbvtW56zoIVplXGOAMII2RH5xw/WyGUIT5NA6geIFIfyIk902Tt5ev9MaE+q2tl
         dwKfi1ZDF6tNisLlPc/qEljUy49I5jkP3RPIA0co5pmj0F1evz1syPhibh2FfbC2iV2M
         zWw7/ZwKMRGCOCOwP4tFSaZDnoEUFrPxGZBK1QlqoTA1fZ9Nc1PJt7sLS4jDtLGZD37K
         HGWh+4iM7kxcfgS2F2iPJaZHVChqL1eHNTrSNr2zzwGP4lvD1Rpk9pg04veKwlcCPYns
         MHm0baHD87lZXt6S573mWuIX5iD+sPAhA3u9oh3/XG+ew9JmVY7j1dUYpfrsi10umWoM
         aReg==
X-Gm-Message-State: APjAAAXpr2TFi/qPrgMAZmKfilKAG8i797ObUAX4O3oj7nMRSLO+C2pC
        E9yS3A93si0BQhab8w0TdhLJAgRJgebbfZj6786ASw==
X-Google-Smtp-Source: APXvYqyb1h/4KVdxocLP+XXOp08PnIzgtUI2UW7wf8EnLG+6VLIUGOGs74grEtCCnpN7yoTSHU31/xeXky8RX+dE/a8=
X-Received: by 2002:a05:660c:38a:: with SMTP id x10mr2806183itj.12.1556036909492;
 Tue, 23 Apr 2019 09:28:29 -0700 (PDT)
MIME-Version: 1.0
References: <000000000000b20dd60587350ae0@google.com>
In-Reply-To: <000000000000b20dd60587350ae0@google.com>
From:   Dmitry Vyukov <dvyukov@google.com>
Date:   Tue, 23 Apr 2019 19:28:18 +0300
Message-ID: <CACT4Y+acM+7pwW+L_F0K7AJ6XBuC8eFRO+6ZHn-8_LxEinjFnw@mail.gmail.com>
Subject: Re: general protection fault in debugfs_remove
To:     syzbot <syzbot+c091783d82e47615bb28@syzkaller.appspotmail.com>,
        Jens Axboe <axboe@kernel.dk>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ingo Molnar <mingo@redhat.com>,
        linux-block <linux-block@vger.kernel.org>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        LKML <linux-kernel@vger.kernel.org>, rafael@kernel.org,
        syzkaller-bugs <syzkaller-bugs@googlegroups.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Tue, Apr 23, 2019 at 7:26 PM syzbot
<syzbot+c091783d82e47615bb28@syzkaller.appspotmail.com> wrote:
>
> Hello,
>
> syzbot found the following crash on:
>
> HEAD commit:    dc4060a5 Linux 5.1-rc5
> git tree:       upstream
> console output: https://syzkaller.appspot.com/x/log.txt?x=146c7ab7200000
> kernel config:  https://syzkaller.appspot.com/x/.config?x=856fc6d0fbbeede9
> dashboard link: https://syzkaller.appspot.com/bug?extid=c091783d82e47615bb28
> compiler:       gcc (GCC) 9.0.0 20181231 (experimental)
> userspace arch: i386
>
> Unfortunately, I don't have any reproducer for this crash yet.
>
> IMPORTANT: if you fix the bug, please add the following tag to the commit:
> Reported-by: syzbot+c091783d82e47615bb28@syzkaller.appspotmail.com
>
> kasan: CONFIG_KASAN_INLINE enabled
> kasan: GPF could be caused by NULL-ptr deref or user memory access
> general protection fault: 0000 [#1] PREEMPT SMP KASAN
> CPU: 1 PID: 17253 Comm: syz-executor.2 Not tainted 5.1.0-rc5 #68
> Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS
> Google 01/01/2011
> RIP: 0010:__lock_acquire+0xbef/0x3fb0 kernel/locking/lockdep.c:3573
> Code: 00 0f 85 a5 1f 00 00 48 81 c4 10 01 00 00 5b 41 5c 41 5d 41 5e 41 5f
> 5d c3 48 b8 00 00 00 00 00 fc ff df 4c 89 ea 48 c1 ea 03 <80> 3c 02 00 0f
> 85 4a 21 00 00 49 81 7d 00 20 54 9c 89 0f 84 cf f4
> RSP: 0018:ffff88805c8c7af0 EFLAGS: 00010006
> RAX: dffffc0000000000 RBX: 0000000000000000 RCX: 0000000000000000
> RDX: 0000000000000027 RSI: 0000000000000000 RDI: 0000000000000001
> RBP: ffff88805c8c7c28 R08: 0000000000000001 R09: 0000000000000000
> R10: ffffed100bd89a87 R11: ffff8880a447e640 R12: 0000000000000000
> R13: 0000000000000138 R14: 0000000000000000 R15: 0000000000000001
> FS:  0000000000000000(0000) GS:ffff8880ae900000(0063) knlGS:00000000f5d5bb40
> CS:  0010 DS: 002b ES: 002b CR0: 0000000080050033
> CR2: 00007fa5913df4a0 CR3: 0000000098cec000 CR4: 00000000001426e0
> Call Trace:
>   lock_acquire+0x16f/0x3f0 kernel/locking/lockdep.c:4211
>   down_write+0x38/0x90 kernel/locking/rwsem.c:70
>   inode_lock include/linux/fs.h:772 [inline]
>   debugfs_remove+0x94/0x130 fs/debugfs/inode.c:691
>   blk_trace_free+0x38/0x140 kernel/trace/blktrace.c:312
>   blk_trace_cleanup kernel/trace/blktrace.c:339 [inline]
>   __blk_trace_remove+0x78/0xa0 kernel/trace/blktrace.c:352
>   blk_trace_ioctl+0x239/0x300 kernel/trace/blktrace.c:731
>   compat_blkdev_ioctl+0x461/0x1a60 block/compat_ioctl.c:402
>   __do_compat_sys_ioctl fs/compat_ioctl.c:1052 [inline]
>   __se_compat_sys_ioctl fs/compat_ioctl.c:998 [inline]
>   __ia32_compat_sys_ioctl+0x197/0x620 fs/compat_ioctl.c:998
>   do_syscall_32_irqs_on arch/x86/entry/common.c:326 [inline]
>   do_fast_syscall_32+0x281/0xc98 arch/x86/entry/common.c:397
>   entry_SYSENTER_compat+0x70/0x7f arch/x86/entry/entry_64_compat.S:139
> RIP: 0023:0xf7f5f869
> Code: 85 d2 74 02 89 0a 5b 5d c3 8b 04 24 c3 8b 14 24 c3 8b 3c 24 c3 90 90
> 90 90 90 90 90 90 90 90 90 90 51 52 55 89 e5 0f 34 cd 80 <5d> 5a 59 c3 90
> 90 90 90 eb 0d 90 90 90 90 90 90 90 90 90 90 90 90
> RSP: 002b:00000000f5d5b0cc EFLAGS: 00000296 ORIG_RAX: 0000000000000036
> RAX: ffffffffffffffda RBX: 0000000000000003 RCX: 0000000000001276
> RDX: 0000000000000000 RSI: 0000000000000000 RDI: 0000000000000000
> RBP: 0000000000000000 R08: 0000000000000000 R09: 0000000000000000
> R10: 0000000000000000 R11: 0000000000000000 R12: 0000000000000000
> R13: 0000000000000000 R14: 0000000000000000 R15: 0000000000000000
> Modules linked in:
> ---[ end trace 91aa7acaf1536f2c ]---
> RIP: 0010:__lock_acquire+0xbef/0x3fb0 kernel/locking/lockdep.c:3573
> Code: 00 0f 85 a5 1f 00 00 48 81 c4 10 01 00 00 5b 41 5c 41 5d 41 5e 41 5f
> 5d c3 48 b8 00 00 00 00 00 fc ff df 4c 89 ea 48 c1 ea 03 <80> 3c 02 00 0f
> 85 4a 21 00 00 49 81 7d 00 20 54 9c 89 0f 84 cf f4
> RSP: 0018:ffff88805c8c7af0 EFLAGS: 00010006
> RAX: dffffc0000000000 RBX: 0000000000000000 RCX: 0000000000000000
> RDX: 0000000000000027 RSI: 0000000000000000 RDI: 0000000000000001
> RBP: ffff88805c8c7c28 R08: 0000000000000001 R09: 0000000000000000
> R10: ffffed100bd89a87 R11: ffff8880a447e640 R12: 0000000000000000
> R13: 0000000000000138 R14: 0000000000000000 R15: 0000000000000001
> FS:  0000000000000000(0000) GS:ffff8880ae900000(0063) knlGS:00000000f5d5bb40
> CS:  0010 DS: 002b ES: 002b CR0: 0000000080050033
> CR2: 00007fa5913df4a0 CR3: 0000000098cec000 CR4: 00000000001426e0
>
>
> ---
> This bug is generated by a bot. It may contain errors.
> See https://goo.gl/tpsmEJ for more information about syzbot.
> syzbot engineers can be reached at syzkaller@googlegroups.com.
>
> syzbot will keep track of this bug report. See:
> https://goo.gl/tpsmEJ#status for how to communicate with syzbot.


Maybe related to:
https://lkml.org/lkml/2018/10/10/317
https://syzkaller.appspot.com/bug?id=6d5c55bc531f0ef83e8faca014cc123b4498f7a6

I suspect the problem is in kernel/trace/blktrace.c
+linux-block maintainers
