Return-Path: <SRS0=Rcoh=SY=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_PASS autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 26310C10F11
	for <linux-block@archiver.kernel.org>; Mon, 22 Apr 2019 16:23:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E322D214AE
	for <linux-block@archiver.kernel.org>; Mon, 22 Apr 2019 16:23:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="o8DaeBrq"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727601AbfDVQXF (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 22 Apr 2019 12:23:05 -0400
Received: from mail-it1-f194.google.com ([209.85.166.194]:52804 "EHLO
        mail-it1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727443AbfDVQXF (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 22 Apr 2019 12:23:05 -0400
Received: by mail-it1-f194.google.com with SMTP id x132so18646693itf.2
        for <linux-block@vger.kernel.org>; Mon, 22 Apr 2019 09:23:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:references:from:message-id:date:user-agent:mime-version
         :in-reply-to:content-language:content-transfer-encoding;
        bh=mS61KLZj/sBareTsWqLhUTCpDblwoYCid3k19PmLKQw=;
        b=o8DaeBrqWu6+yLfVUysgK9pQdbBGn0neMwZz8QZNF4YFR4xA3CuWFZ9xN358ZF0Elz
         kHtvDmtqj0Ocy6mzg1QoZY/7XyyPTFB6npuhSGO/8BawSHKtMvQuOnXi1KnB6LfcUikp
         y/TG2Y3mkT0x+aBzn6fZ7bOx1WSq21nFAgeWqcz4uvKlfvphjgqZNFNou5r9jpteqx8X
         xzsODDKAnQoDcQyVidDyUPQKAMsXaUjNqGttVF3BUBSWnjNRRttu6GVTSDlGsuXeD9gU
         EUprSSNPKSyJA9N80IFqpyDIpyA2WAZbnCF+Ed94WAcJaUP1mL1Er4M6Uw8JFSeH2WA6
         euKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=mS61KLZj/sBareTsWqLhUTCpDblwoYCid3k19PmLKQw=;
        b=qBLyD5s3VK626NCDXlUigKVcx9lYOojMgx2MvehNclKQfNYH4lttnSr8myA9vwARRK
         ZC1wbrYlJj7cLGp1vbFeiYqtceLuCLKyVZqJf5qDjjePufk/P68mNA9qlqFWzd2zz8oa
         ww34+IO0Hw5ZIaMyEBXBpeBdzzX8I+0QoUUuxcpFM7aZhTRXdXpanEET1ux/B0lgTjrb
         0eZEGH+zcHPVgb8ZJJpdWRNDEojQyAewkwPkpd2A+1tJtLppel8VVZk1hCOsfQ/CXDlf
         qjYuGCuK/ebkQa39k0nsGoCcQknnwAqTnsG2vwZO2MMNgX7z9h/fG5zkivlueYu5dYCx
         Q3/g==
X-Gm-Message-State: APjAAAX28WD8RtUw4CQ4p+EMav2+5J22uO/O1ID6gXBb7/rNXdtcTdj8
        NEPigU1ZbtdYkLtRaH+8a43v2A==
X-Google-Smtp-Source: APXvYqzBJ4Kf7/w1USgwJO0M/TqIJlbzVaIVWGV33Ix3VngXgvVxtWAIbOPtEAusYniDlUl1mAO3vA==
X-Received: by 2002:a02:950a:: with SMTP id y10mr14625688jah.26.1555950184245;
        Mon, 22 Apr 2019 09:23:04 -0700 (PDT)
Received: from [192.168.1.158] ([216.160.245.98])
        by smtp.gmail.com with ESMTPSA id a16sm6371987itc.36.2019.04.22.09.23.02
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 22 Apr 2019 09:23:03 -0700 (PDT)
Subject: Re: WARNING in percpu_ref_kill_and_confirm
To:     syzbot <syzbot+10d25e23199614b7721f@syzkaller.appspotmail.com>,
        arnd@arndb.de, bp@alien8.de, darrick.wong@oracle.com,
        gregkh@linuxfoundation.org, hpa@zytor.com,
        linux-api@vger.kernel.org, linux-arch@vger.kernel.org,
        linux-block@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, luto@kernel.org,
        mathieu.desnoyers@efficios.com, mingo@redhat.com,
        mpe@ellerman.id.au, syzkaller-bugs@googlegroups.com,
        tglx@linutronix.de, torvalds@linux-foundation.org,
        viro@zeniv.linux.org.uk, x86@kernel.org
References: <00000000000043fe9c058720a5d3@google.com>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <ad884b18-0e03-d6be-02b0-4e5273f068ce@kernel.dk>
Date:   Mon, 22 Apr 2019 10:23:01 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <00000000000043fe9c058720a5d3@google.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 4/22/19 10:06 AM, syzbot wrote:
> Hello,
> 
> syzbot found the following crash on:
> 
> HEAD commit:    9e5de623 Merge tag 'nfs-for-5.1-5' of git://git.linux-nfs...
> git tree:       upstream
> console output: https://syzkaller.appspot.com/x/log.txt?x=15624257200000
> kernel config:  https://syzkaller.appspot.com/x/.config?x=856fc6d0fbbeede9
> dashboard link: https://syzkaller.appspot.com/bug?extid=10d25e23199614b7721f
> compiler:       gcc (GCC) 9.0.0 20181231 (experimental)
> userspace arch: i386
> syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=17ff39f3200000
> C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=15758647200000
> 
> The bug was bisected to:
> 
> commit 38e7571c07be01f9f19b355a9306a4e3d5cb0f5b
> Author: Linus Torvalds <torvalds@linux-foundation.org>
> Date:   Fri Mar 8 22:48:40 2019 +0000
> 
>      Merge tag 'io_uring-2019-03-06' of git://git.kernel.dk/linux-block
> 
> bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=1736bc57200000
> final crash:    https://syzkaller.appspot.com/x/report.txt?x=14b6bc57200000
> console output: https://syzkaller.appspot.com/x/log.txt?x=10b6bc57200000
> 
> IMPORTANT: if you fix the bug, please add the following tag to the commit:
> Reported-by: syzbot+10d25e23199614b7721f@syzkaller.appspotmail.com
> Fixes: 38e7571c07be ("Merge tag 'io_uring-2019-03-06' of  
> git://git.kernel.dk/linux-block")
> 
> ------------[ cut here ]------------
> percpu_ref_kill_and_confirm called more than once on io_ring_ctx_ref_free!
> WARNING: CPU: 1 PID: 7815 at lib/percpu-refcount.c:335  
> percpu_ref_kill_and_confirm+0x341/0x3b0 lib/percpu-refcount.c:335
> Kernel panic - not syncing: panic_on_warn set ...
> CPU: 1 PID: 7815 Comm: syz-executor269 Not tainted 5.1.0-rc5+ #77
> Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS  
> Google 01/01/2011
> Call Trace:
>   __dump_stack lib/dump_stack.c:77 [inline]
>   dump_stack+0x172/0x1f0 lib/dump_stack.c:113
>   panic+0x2cb/0x65c kernel/panic.c:214
>   __warn.cold+0x20/0x45 kernel/panic.c:571
>   report_bug+0x263/0x2b0 lib/bug.c:186
>   fixup_bug arch/x86/kernel/traps.c:179 [inline]
>   fixup_bug arch/x86/kernel/traps.c:174 [inline]
>   do_error_trap+0x11b/0x200 arch/x86/kernel/traps.c:272
>   do_invalid_op+0x37/0x50 arch/x86/kernel/traps.c:291
>   invalid_op+0x14/0x20 arch/x86/entry/entry_64.S:973
> RIP: 0010:percpu_ref_kill_and_confirm+0x341/0x3b0 lib/percpu-refcount.c:335
> Code: 42 e0 2a 06 01 48 89 fa 48 c1 ea 03 80 3c 02 00 75 76 49 8b 54 24 10  
> 48 c7 c6 a0 71 a1 87 48 c7 c7 40 71 a1 87 e8 ad 92 13 fe <0f> 0b 48 b8 00  
> 00 00 00 00 fc ff df 4c 89 ea 48 c1 ea 03 80 3c 02
> RSP: 0018:ffff8880a96cfce0 EFLAGS: 00010086
> RAX: 0000000000000000 RBX: 0000607f5142e35b RCX: 0000000000000000
> RDX: 0000000000000000 RSI: ffffffff815afcf6 RDI: ffffed10152d9f8e
> RBP: ffff8880a96cfd10 R08: ffff8880a85c40c0 R09: fffffbfff1133639
> R10: fffffbfff1133638 R11: ffffffff8899b1c3 R12: ffff88809ee571c0
> R13: ffff88809ee571c8 R14: 0000000000000286 R15: 0000000000000000
>   percpu_ref_kill include/linux/percpu-refcount.h:128 [inline]
>   __io_uring_register+0xa7/0x1fe0 fs/io_uring.c:2937
>   __do_sys_io_uring_register fs/io_uring.c:2998 [inline]
>   __se_sys_io_uring_register fs/io_uring.c:2980 [inline]
>   __ia32_sys_io_uring_register+0x193/0x1f0 fs/io_uring.c:2980
>   do_syscall_32_irqs_on arch/x86/entry/common.c:326 [inline]
>   do_fast_syscall_32+0x281/0xc98 arch/x86/entry/common.c:397
>   entry_SYSENTER_compat+0x70/0x7f arch/x86/entry/entry_64_compat.S:139
> RIP: 0023:0xf7f16869
> Code: 85 d2 74 02 89 0a 5b 5d c3 8b 04 24 c3 8b 14 24 c3 8b 3c 24 c3 90 90  
> 90 90 90 90 90 90 90 90 90 90 51 52 55 89 e5 0f 34 cd 80 <5d> 5a 59 c3 90  
> 90 90 90 eb 0d 90 90 90 90 90 90 90 90 90 90 90 90
> RSP: 002b:00000000f7ef11ec EFLAGS: 00000296 ORIG_RAX: 00000000000001ab
> RAX: ffffffffffffffda RBX: 0000000000000003 RCX: 0000000000000000
> RDX: 0000000000000000 RSI: 0000000000000000 RDI: 0000000000000000
> RBP: 0000000000000000 R08: 0000000000000000 R09: 0000000000000000
> R10: 0000000000000000 R11: 0000000000000000 R12: 0000000000000000
> R13: 0000000000000000 R14: 0000000000000000 R15: 0000000000000000
> Kernel Offset: disabled
> Rebooting in 86400 seconds..

I think the below should fix this. Very early versions of io_uring didn't
have this issue, since we did the percpu ref tryget for io_uring_register().
But I think we'll be just fine just checking if the ref is already dying
once inside the mutex. If it is, it's either going away, or someone else
is already doing io_uring_register() on it.


diff --git a/fs/io_uring.c b/fs/io_uring.c
index f65f85d89217..a2f39faed6a7 100644
--- a/fs/io_uring.c
+++ b/fs/io_uring.c
@@ -2934,6 +2934,14 @@ static int __io_uring_register(struct io_ring_ctx *ctx, unsigned opcode,
 {
 	int ret;
 
+	/*
+	 * We're inside the ring mutex, if the ref is already dying, then
+	 * someone else killed the ctx or is already going through
+	 * io_uring_register().
+	 */
+	if (percpu_ref_is_dying(&ctx->refs))
+		return -ENXIO;
+
 	percpu_ref_kill(&ctx->refs);
 
 	/*

-- 
Jens Axboe

