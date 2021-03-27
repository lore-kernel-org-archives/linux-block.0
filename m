Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 200E3C433DB
	for <linux-block@archiver.kernel.org>; Sat, 27 Mar 2021 06:51:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D9BF3619B4
	for <linux-block@archiver.kernel.org>; Sat, 27 Mar 2021 06:51:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230424AbhC0GvP (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Sat, 27 Mar 2021 02:51:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36098 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230322AbhC0Gum (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Sat, 27 Mar 2021 02:50:42 -0400
Received: from mail-yb1-xb35.google.com (mail-yb1-xb35.google.com [IPv6:2607:f8b0:4864:20::b35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6E180C0613AA;
        Fri, 26 Mar 2021 23:50:41 -0700 (PDT)
Received: by mail-yb1-xb35.google.com with SMTP id g38so8115339ybi.12;
        Fri, 26 Mar 2021 23:50:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=tIj5lRAkgv/NrVn5wIrjJkDVsVSwu3/pbuGFuWTqpLk=;
        b=CPJn6qsE4Vy0jq9xmSgEJRCGasYUlEWQRIhk99RU3rGB31qYJSV0W8iJiYBRP/8jre
         VEFLakbxP8gH/8uKHfwNPyjrBDDE0M6djAdZCb54+YYpk1fDxfY8aZMKCbzN0hBfMrh3
         qNGVzLaELZGAHOx2cOkmNz3x8OM2NbQUZp28PfFaLiZ3ALiwXbnk1iieQKYWyFHpiv8Z
         WntzJDpLMJO94vHDKw0A5MWrZpyr2PsPqxMXn2+n+cjAmSw93EGedPz8/JhaxwXRurFl
         x49x3X32Z+RKFE4+qpbaP+taMCreQKNqoY7bR2/VKi2jnPXtqRwT+SZLMeXoFBtvYy7q
         PA6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=tIj5lRAkgv/NrVn5wIrjJkDVsVSwu3/pbuGFuWTqpLk=;
        b=sRs6J4jNvG3Oxxs1Eu/u0FKapUjs8+R+MYEVJZCVUczftFgQZygWgi1SAfWN2DGlWs
         6w8e1dTKlxaxXNhSV4IMwLI4G+I55gFJdhYCUVlWdxx25hS8XXeRaOp5LLkF4bOCRwpx
         Lptg4Oy6147XFooieP/UDEIQSMrByuegTOIVJ3xSUKQ3hiiLUozjVW4EhM5xFC0+ENyI
         FqiWz6GrMcvVyXz5p6MPudGo0jnil2rOoKOXuAwjF/IasDFxTg9RU9+Ly5Y2Iyo5gT74
         GDFY91UUv7TlmD+WA7Kovr/mOrc7ybjv01chiZYYwNfTPqk6uycQs60k9fP8fdCs6raj
         neyQ==
X-Gm-Message-State: AOAM531itXJodZ9gxTQuyQpYGdNXxZeWhdA5xerwBJNdAURQILWwBkBK
        D+PTq4fkEOXXVOfKJsqgrtOtBIC5I0DKmLhgHw8=
X-Google-Smtp-Source: ABdhPJwvKnXKx9RsqIdc7tNN1AmOo0Lxct+7IIx4jfRiYDa9wvOObAtTxEmjrXTjQ9NSuDVoTDVF4sPH6jIX7cbTwt0=
X-Received: by 2002:a25:d0c7:: with SMTP id h190mr20463963ybg.428.1616827840644;
 Fri, 26 Mar 2021 23:50:40 -0700 (PDT)
MIME-Version: 1.0
References: <CACVXFVMf9n8bHP8ZTx74bBqoKRFHbPPLSBkvmdaV50xXwNKC1A@mail.gmail.com>
 <00000000000088336505be737abc@google.com>
In-Reply-To: <00000000000088336505be737abc@google.com>
From:   Ming Lei <tom.leiming@gmail.com>
Date:   Sat, 27 Mar 2021 14:50:29 +0800
Message-ID: <CACVXFVN+ygnq022S_jn498BR=g-sUhrYfzERn6moZ-B5-iUoBw@mail.gmail.com>
Subject: Re: [syzbot] KASAN: use-after-free Read in disk_part_iter_next (2)
To:     syzbot <syzbot+8fede7e30c7cee0de139@syzkaller.appspotmail.com>
Cc:     Jens Axboe <axboe@kernel.dk>,
        linux-block <linux-block@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Sat, Mar 27, 2021 at 1:01 AM syzbot
<syzbot+8fede7e30c7cee0de139@syzkaller.appspotmail.com> wrote:
>
> Hello,
>
> syzbot has tested the proposed patch but the reproducer is still triggering an issue:
> WARNING in kvm_wait
>
> ------------[ cut here ]------------
> raw_local_irq_restore() called with IRQs enabled
> WARNING: CPU: 1 PID: 10753 at kernel/locking/irqflag-debug.c:10 warn_bogus_irq_restore+0x1d/0x20 kernel/locking/irqflag-debug.c:10
> Modules linked in:
> CPU: 1 PID: 10753 Comm: syz-executor.4 Not tainted 5.12.0-rc3-syzkaller #0
> Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 01/01/2011
> RIP: 0010:warn_bogus_irq_restore+0x1d/0x20 kernel/locking/irqflag-debug.c:10
> Code: be ff cc cc cc cc cc cc cc cc cc cc cc 80 3d a1 e7 2b 04 00 74 01 c3 48 c7 c7 20 92 6b 89 c6 05 90 e7 2b 04 01 e8 79 cf be ff <0f> 0b c3 48 39 77 10 0f 84 97 00 00 00 66 f7 47 22 f0 ff 74 4b 48
> RSP: 0018:ffffc90008f0f9c0 EFLAGS: 00010286
> RAX: 0000000000000000 RBX: ffff888021f02040 RCX: 0000000000000000
> RDX: ffff888017d4d4c0 RSI: ffffffff815c3875 RDI: fffff520011e1f2a
> RBP: 0000000000000200 R08: 0000000000000000 R09: 0000000000000000
> R10: ffffffff815bc60e R11: 0000000000000000 R12: 0000000000000003
> R13: ffffed10043e0408 R14: 0000000000000001 R15: ffff8880b9f35f40
> FS:  00000000022dd400(0000) GS:ffff8880b9f00000(0000) knlGS:0000000000000000
> CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> CR2: 00000000004e4a64 CR3: 0000000016964000 CR4: 0000000000350ee0
> Call Trace:
>  kvm_wait arch/x86/kernel/kvm.c:860 [inline]
>  kvm_wait+0xc9/0xe0 arch/x86/kernel/kvm.c:837
>  pv_wait arch/x86/include/asm/paravirt.h:564 [inline]
>  pv_wait_head_or_lock kernel/locking/qspinlock_paravirt.h:470 [inline]
>  __pv_queued_spin_lock_slowpath+0x8b8/0xb40 kernel/locking/qspinlock.c:508
>  pv_queued_spin_lock_slowpath arch/x86/include/asm/paravirt.h:554 [inline]
>  queued_spin_lock_slowpath arch/x86/include/asm/qspinlock.h:51 [inline]
>  queued_spin_lock include/asm-generic/qspinlock.h:85 [inline]
>  do_raw_spin_lock+0x200/0x2b0 kernel/locking/spinlock_debug.c:113
>  spin_lock include/linux/spinlock.h:354 [inline]
>  ext4_lock_group fs/ext4/ext4.h:3383 [inline]
>  __ext4_new_inode+0x384f/0x5570 fs/ext4/ialloc.c:1188
>  ext4_symlink+0x489/0xd50 fs/ext4/namei.c:3347
>  vfs_symlink fs/namei.c:4176 [inline]
>  vfs_symlink+0x10f/0x270 fs/namei.c:4161
>  do_symlinkat+0x27a/0x300 fs/namei.c:4206
>  do_syscall_64+0x2d/0x70 arch/x86/entry/common.c:46
>  entry_SYSCALL_64_after_hwframe+0x44/0xae
> RIP: 0033:0x465d67
> Code: 73 01 c3 48 c7 c1 bc ff ff ff f7 d8 64 89 01 48 83 c8 ff c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 44 00 00 b8 58 00 00 00 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 bc ff ff ff f7 d8 64 89 01 48
> RSP: 002b:00007ffda32c3708 EFLAGS: 00000202 ORIG_RAX: 0000000000000058
> RAX: ffffffffffffffda RBX: 0000000000000000 RCX: 0000000000465d67
> RDX: 00007ffda32c37f3 RSI: 00000000004bfab2 RDI: 00007ffda32c37e0
> RBP: 0000000000000000 R08: 0000000000000000 R09: 00007ffda32c35a0
> R10: 00007ffda32c3457 R11: 0000000000000202 R12: 0000000000000001
> R13: 0000000000000000 R14: 0000000000000001 R15: 00007ffda32c37e0

This is another & un-related warning with original report, so I think
the patch in above
tree fixes the issue.


-- 
Ming Lei
