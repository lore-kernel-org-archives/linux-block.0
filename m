Return-Path: <SRS0=o1BL=5G=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 19DE2C4332E
	for <linux-block@archiver.kernel.org>; Sat, 21 Mar 2020 07:15:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BF653206F9
	for <linux-block@archiver.kernel.org>; Sat, 21 Mar 2020 07:15:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="rEz8pcxA"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728095AbgCUHPp (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Sat, 21 Mar 2020 03:15:45 -0400
Received: from mail-qk1-f195.google.com ([209.85.222.195]:42029 "EHLO
        mail-qk1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728072AbgCUHPp (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Sat, 21 Mar 2020 03:15:45 -0400
Received: by mail-qk1-f195.google.com with SMTP id e11so9643333qkg.9
        for <linux-block@vger.kernel.org>; Sat, 21 Mar 2020 00:15:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=wFLyCcbMHtgLvt40DJJ2uQa9RLOkww+bHxdrRh/zvZ0=;
        b=rEz8pcxAS/Qcdq7Ca+miKFPxx/BUTksSrm8mo6/7/nloz9+K/0OjNRib1qZ33uGMC9
         c27uuDERD3SVuO2caywuob4h0HCPhEGOP3IIPgptciivI4EdbnAySE7yv9em3E4lRFr6
         vFpv+zuJmB6JyVorjk5WnsY0DkVzYbUgSK625t9YG501189eTw3Yjm2wTc96RfiJ8Nq9
         6OD37CejZE+feFtox9GpVi5sOajawedPtHF1r2nFm0UKR/hSPCm+uQA6eOd0DWzAH10u
         d44iQkjgCMZ3Aq54AXDtbItMkNmwaMPnlP0lSaWUJF5ZAjaQG4ep8PSAS6bUD+4jwDvj
         P4fA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=wFLyCcbMHtgLvt40DJJ2uQa9RLOkww+bHxdrRh/zvZ0=;
        b=slTKl5KD6Yx0i59eI6o4ebRKwsPaxDof6i2HRTK3khMa8+yw5vCHG5adkR48L6Qc4c
         ussuBabh6Pzji8faWBkxSfMnUJ4j/apgfC3ocL7JwmsixB2YuOSzp0j861NP9ZVaknhy
         0/P668Fp2melpnn+EfyptY4V72cD8dbsOnL2m0UreUt6NBYDM4HOzB+yrC7hO/MkXj6O
         mFX5t1aRUijgbuOEkw6KrrmurFAqqVgMiNcldvKzl0oH8EiJaCSobZvrGRJI/VpYVWFR
         smPcici1EMnZD3JOq1GMUSERuuNF81QLlGgj7zcZKqEpRSic9SwxHBA7qiwrBilWYJfQ
         /Nyg==
X-Gm-Message-State: ANhLgQ3WkIzVRkjWui5NAXoUOUq12OsPXg45Ynty/ZQBpQ92YbfNmdi8
        auLO4Nyle8auliQRqJS8xoSTYd0Isvwadcv4alcRzQ==
X-Google-Smtp-Source: ADFU+vsXLo8HLVgqQmG2EbR8mc/WFsJEdsoIV9M51ZLxhyZ6LOIv4t/7J1CXV9CUrFnFgSzXrsFVCsnY34RcDNpeLpQ=
X-Received: by 2002:a05:620a:1654:: with SMTP id c20mr219563qko.250.1584774943333;
 Sat, 21 Mar 2020 00:15:43 -0700 (PDT)
MIME-Version: 1.0
References: <0000000000000bec9805a1581f05@google.com>
In-Reply-To: <0000000000000bec9805a1581f05@google.com>
From:   Dmitry Vyukov <dvyukov@google.com>
Date:   Sat, 21 Mar 2020 08:15:31 +0100
Message-ID: <CACT4Y+Z_ZuQmDqq=0kKZuKAe=Dme=UsOnES6h9Y8vRmw2v3WmA@mail.gmail.com>
Subject: Re: INFO: task hung in blk_trace_remove
To:     syzbot <syzbot+c07afbbb410e9f712273@syzkaller.appspotmail.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        =?UTF-8?B?QXJ2ZSBIasO4bm5ldsOlZw==?= <arve@android.com>,
        Todd Kjos <tkjos@android.com>,
        Martijn Coenen <maco@android.com>,
        Joel Fernandes <joel@joelfernandes.org>,
        Christian Brauner <christian@brauner.io>,
        "open list:ANDROID DRIVERS" <devel@driverdev.osuosl.org>
Cc:     Jens Axboe <axboe@kernel.dk>,
        linux-block <linux-block@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@redhat.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        syzkaller-bugs <syzkaller-bugs@googlegroups.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Sat, Mar 21, 2020 at 8:12 AM syzbot
<syzbot+c07afbbb410e9f712273@syzkaller.appspotmail.com> wrote:
>
> Hello,
>
> syzbot found the following crash on:
>
> HEAD commit:    fb33c651 Linux 5.6-rc6
> git tree:       upstream
> console output: https://syzkaller.appspot.com/x/log.txt?x=140688d3e00000
> kernel config:  https://syzkaller.appspot.com/x/.config?x=9f894bd92023de02
> dashboard link: https://syzkaller.appspot.com/bug?extid=c07afbbb410e9f712273
> compiler:       gcc (GCC) 9.0.0 20181231 (experimental)
>
> Unfortunately, I don't have any reproducer for this crash yet.
>
> IMPORTANT: if you fix the bug, please add the following tag to the commit:
> Reported-by: syzbot+c07afbbb410e9f712273@syzkaller.appspotmail.com

+ashmem maintainers

From the log, ashmem spews an infinite sequence of some errors which
probably stall the machine:

[ 1094.685541][ T9460] vmscan: shrink_slab:
ashmem_shrink_scan+0x0/0x500 negative objects to delete
nr=-6917529027641097791
[ 1094.701750][ T7239] vmscan: shrink_slab:
ashmem_shrink_scan+0x0/0x500 negative objects to delete
nr=-6917529027641383141
[ 1094.708003][ T9576] vmscan: shrink_slab:
ashmem_shrink_scan+0x0/0x500 negative objects to delete
nr=-6917529027641233534
[ 1094.723597][ T1876] vmscan: shrink_slab:
ashmem_shrink_scan+0x0/0x500 negative objects to delete
nr=-6917529027641083174
[ 1094.730025][ T9460] vmscan: shrink_slab:
ashmem_shrink_scan+0x0/0x500 negative objects to delete
nr=-6917529027641098111
[ 1094.745592][ T7239] vmscan: shrink_slab:
ashmem_shrink_scan+0x0/0x500 negative objects to delete
nr=-6917529027641383221
[ 1094.753153][ T9576] vmscan: shrink_slab:
ashmem_shrink_scan+0x0/0x500 negative objects to delete
nr=-6917529027641233534
[ 1094.767903][ T1876] vmscan: shrink_slab:
ashmem_shrink_scan+0x0/0x500 negative objects to delete
nr=-6917529027641084454
[ 1094.819845][ T7239] vmscan: shrink_slab:
ashmem_shrink_scan+0x0/0x500 negative objects to delete
nr=-6917529027641526579
[ 1094.830116][ T9460] vmscan: shrink_slab:
ashmem_shrink_scan+0x0/0x500 negative objects to delete
nr=-6917529027641098111
[ 1094.845813][ T7239] vmscan: shrink_slab:
ashmem_shrink_scan+0x0/0x500 negative objects to delete
nr=-6917529027641527219
[ 1094.852188][ T9460] vmscan: shrink_slab:
ashmem_shrink_scan+0x0/0x500 negative objects to delete
nr=-6917529027641098751
[ 1094.871456][ T7239] vmscan: shrink_slab:
ashmem_shrink_scan+0x0/0x500 negative objects to delete
nr=-6917529027641527219
[ 1094.874256][ T9460] vmscan: shrink_slab:
ashmem_shrink_scan+0x0/0x500 negative objects to delete
nr=-6917529027641098751
[ 1094.890195][ T7239] vmscan: shrink_slab:
ashmem_shrink_scan+0x0/0x500 negative objects to delete
nr=-6917529027641528499
[ 1094.895999][ T1876] vmscan: shrink_slab:
ashmem_shrink_scan+0x0/0x500 negative objects to delete
nr=-6917529027641087014
[ 1094.912931][ T7239] vmscan: shrink_slab:
ashmem_shrink_scan+0x0/0x500 negative objects to delete
nr=-6917529027641528499
[ 1094.918797][ T9460] vmscan: shrink_slab:
ashmem_shrink_scan+0x0/0x500 negative objects to delete
nr=-6917529027641100031
[ 1094.936636][ T7239] vmscan: shrink_slab:
ashmem_shrink_scan+0x0/0x500 negative objects to delete
nr=-6917529027641531059
[ 1094.941391][ T1876] vmscan: shrink_slab:
ashmem_shrink_scan+0x0/0x500 negative objects to delete
nr=-6917529027641081897
[ 1094.957463][ T7239] vmscan: shrink_slab:
ashmem_shrink_scan+0x0/0x500 negative objects to delete
nr=-6917529027641531059
[ 1094.963568][ T9460] vmscan: shrink_slab:
ashmem_shrink_scan+0x0/0x500 negative objects to delete
nr=-6917529027641100031
[ 1094.980233][ T7239] vmscan: shrink_slab:
ashmem_shrink_scan+0x0/0x500 negative objects to delete
nr=-6917529027641536179
[ 1094.985311][ T1876] vmscan: shrink_slab:
ashmem_shrink_scan+0x0/0x500 negative objects to delete
nr=-6917529027641081899
[ 1095.001393][ T7239] vmscan: shrink_slab:
ashmem_shrink_scan+0x0/0x500 negative objects to delete
nr=-6917529027641536179
[ 1095.008146][ T9460] vmscan: shrink_slab:
ashmem_shrink_scan+0x0/0x500 negative objects to delete
nr=-6917529027641102591
[ 1095.024425][ T7239] vmscan: shrink_slab:
ashmem_shrink_scan+0x0/0x500 negative objects to delete
nr=-6917529027641525942
[ 1095.029644][ T1876] vmscan: shrink_slab:
ashmem_shrink_scan+0x0/0x500 negative objects to delete
nr=-6917529027641081904
[ 1095.046399][ T7239] vmscan: shrink_slab:
ashmem_shrink_scan+0x0/0x500 negative objects to delete
nr=-6917529027641525942
[ 1095.052377][ T9460] vmscan: shrink_slab:
ashmem_shrink_scan+0x0/0x500 negative objects to delete
nr=-6917529027641102591
[ 1095.068000][ T7239] vmscan: shrink_slab:
ashmem_shrink_scan+0x0/0x500 negative objects to delete
nr=-6917529027641525944
[ 1095.073934][ T1876] vmscan: shrink_slab:
ashmem_shrink_scan+0x0/0x500 negative objects to delete
nr=-6917529027641081914
[ 1095.091076][ T7239] vmscan: shrink_slab:
ashmem_shrink_scan+0x0/0x500 negative objects to delete
nr=-6917529027641525944
[ 1095.096925][ T9460] vmscan: shrink_slab:
ashmem_shrink_scan+0x0/0x500 negative objects to delete
nr=-6917529027641107711
[ 1095.112305][ T7239] vmscan: shrink_slab:
ashmem_shrink_scan+0x0/0x500 negative objects to delete
nr=-6917529027641525949
[ 1095.118570][ T1876] vmscan: shrink_slab:
ashmem_shrink_scan+0x0/0x500 negative objects to delete
nr=-6917529027641081934
[ 1095.135413][ T7239] vmscan: shrink_slab:
ashmem_shrink_scan+0x0/0x500 negative objects to delete
nr=-6917529027641525949
[ 1095.141206][ T9460] vmscan: shrink_slab:
ashmem_shrink_scan+0x0/0x500 negative objects to delete
nr=-6917529027641107711



> INFO: task syz-executor.4:7237 blocked for more than 143 seconds.
>       Not tainted 5.6.0-rc6-syzkaller #0
> "echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
> syz-executor.4  D26576  7237   9609 0x00004004
> Call Trace:
>  schedule+0xd0/0x2a0 kernel/sched/core.c:4154
>  schedule_preempt_disabled+0xf/0x20 kernel/sched/core.c:4213
>  __mutex_lock_common kernel/locking/mutex.c:1033 [inline]
>  __mutex_lock+0x7ab/0x13c0 kernel/locking/mutex.c:1103
>  blk_trace_remove+0x1e/0x40 kernel/trace/blktrace.c:361
>  sg_ioctl_common+0x221/0x2710 drivers/scsi/sg.c:1125
>  sg_ioctl+0x8f/0x120 drivers/scsi/sg.c:1159
>  vfs_ioctl fs/ioctl.c:47 [inline]
>  ksys_ioctl+0x11a/0x180 fs/ioctl.c:763
>  __do_sys_ioctl fs/ioctl.c:772 [inline]
>  __se_sys_ioctl fs/ioctl.c:770 [inline]
>  __x64_sys_ioctl+0x6f/0xb0 fs/ioctl.c:770
>  do_syscall_64+0xf6/0x7d0 arch/x86/entry/common.c:294
>  entry_SYSCALL_64_after_hwframe+0x49/0xbe
> RIP: 0033:0x45c849
> Code: Bad RIP value.
> RSP: 002b:00007f5ba5a3bc78 EFLAGS: 00000246 ORIG_RAX: 0000000000000010
> RAX: ffffffffffffffda RBX: 00007f5ba5a3c6d4 RCX: 000000000045c849
> RDX: 0000000000000000 RSI: 0000000000001276 RDI: 0000000000000003
> RBP: 000000000076bf00 R08: 0000000000000000 R09: 0000000000000000
> R10: 0000000000000000 R11: 0000000000000246 R12: 00000000ffffffff
> R13: 000000000000022b R14: 00000000004c4526 R15: 000000000076bf0c
> INFO: task syz-executor.4:7266 blocked for more than 146 seconds.
>       Not tainted 5.6.0-rc6-syzkaller #0
> "echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
> syz-executor.4  D27752  7266   9609 0x00004004
> Call Trace:
>  schedule+0xd0/0x2a0 kernel/sched/core.c:4154
>  schedule_preempt_disabled+0xf/0x20 kernel/sched/core.c:4213
>  __mutex_lock_common kernel/locking/mutex.c:1033 [inline]
>  __mutex_lock+0x7ab/0x13c0 kernel/locking/mutex.c:1103
>  blk_trace_setup+0x2f/0x60 kernel/trace/blktrace.c:588
>  sg_ioctl_common+0x2f2/0x2710 drivers/scsi/sg.c:1116
>  sg_ioctl+0x8f/0x120 drivers/scsi/sg.c:1159
>  vfs_ioctl fs/ioctl.c:47 [inline]
>  ksys_ioctl+0x11a/0x180 fs/ioctl.c:763
>  __do_sys_ioctl fs/ioctl.c:772 [inline]
>  __se_sys_ioctl fs/ioctl.c:770 [inline]
>  __x64_sys_ioctl+0x6f/0xb0 fs/ioctl.c:770
>  do_syscall_64+0xf6/0x7d0 arch/x86/entry/common.c:294
>  entry_SYSCALL_64_after_hwframe+0x49/0xbe
> RIP: 0033:0x45c849
> Code: Bad RIP value.
> RSP: 002b:00007f5ba5a1ac78 EFLAGS: 00000246 ORIG_RAX: 0000000000000010
> RAX: ffffffffffffffda RBX: 00007f5ba5a1b6d4 RCX: 000000000045c849
> RDX: 0000000020000080 RSI: 00000000c0481273 RDI: 0000000000000008
> RBP: 000000000076bfa0 R08: 0000000000000000 R09: 0000000000000000
> R10: 0000000000000000 R11: 0000000000000246 R12: 00000000ffffffff
> R13: 0000000000000228 R14: 00000000004c44eb R15: 000000000076bfac
> INFO: task syz-executor.5:7265 blocked for more than 149 seconds.
>       Not tainted 5.6.0-rc6-syzkaller #0
> "echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
> syz-executor.5  D26736  7265   9613 0x00004004
> Call Trace:
>  schedule+0xd0/0x2a0 kernel/sched/core.c:4154
>  schedule_preempt_disabled+0xf/0x20 kernel/sched/core.c:4213
>  __mutex_lock_common kernel/locking/mutex.c:1033 [inline]
>  __mutex_lock+0x7ab/0x13c0 kernel/locking/mutex.c:1103
>  blk_trace_setup+0x2f/0x60 kernel/trace/blktrace.c:588
>  sg_ioctl_common+0x2f2/0x2710 drivers/scsi/sg.c:1116
>  sg_ioctl+0x8f/0x120 drivers/scsi/sg.c:1159
>  vfs_ioctl fs/ioctl.c:47 [inline]
>  ksys_ioctl+0x11a/0x180 fs/ioctl.c:763
>  __do_sys_ioctl fs/ioctl.c:772 [inline]
>  __se_sys_ioctl fs/ioctl.c:770 [inline]
>  __x64_sys_ioctl+0x6f/0xb0 fs/ioctl.c:770
>  do_syscall_64+0xf6/0x7d0 arch/x86/entry/common.c:294
>  entry_SYSCALL_64_after_hwframe+0x49/0xbe
> RIP: 0033:0x45c849
> Code: Bad RIP value.
> RSP: 002b:00007f576f48ac78 EFLAGS: 00000246 ORIG_RAX: 0000000000000010
> RAX: ffffffffffffffda RBX: 00007f576f48b6d4 RCX: 000000000045c849
> RDX: 0000000020000080 RSI: 00000000c0481273 RDI: 0000000000000006
>
>
> ---
> This bug is generated by a bot. It may contain errors.
> See https://goo.gl/tpsmEJ for more information about syzbot.
> syzbot engineers can be reached at syzkaller@googlegroups.com.
>
> syzbot will keep track of this bug report. See:
> https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
>
> --
> You received this message because you are subscribed to the Google Groups "syzkaller-bugs" group.
> To unsubscribe from this group and stop receiving emails from it, send an email to syzkaller-bugs+unsubscribe@googlegroups.com.
> To view this discussion on the web visit https://groups.google.com/d/msgid/syzkaller-bugs/0000000000000bec9805a1581f05%40google.com.
