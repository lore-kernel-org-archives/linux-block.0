Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C7715C433EF
	for <linux-block@archiver.kernel.org>; Thu, 21 Jul 2022 19:15:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229658AbiGUTP4 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 21 Jul 2022 15:15:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58330 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233203AbiGUTPk (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 21 Jul 2022 15:15:40 -0400
Received: from mail-io1-xd2c.google.com (mail-io1-xd2c.google.com [IPv6:2607:f8b0:4864:20::d2c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 76AEF2DC4
        for <linux-block@vger.kernel.org>; Thu, 21 Jul 2022 12:15:10 -0700 (PDT)
Received: by mail-io1-xd2c.google.com with SMTP id y197so1256217iof.12
        for <linux-block@vger.kernel.org>; Thu, 21 Jul 2022 12:15:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:in-reply-to:references:subject:message-id:date
         :mime-version:content-transfer-encoding;
        bh=o3/LkW9N1JHK6NujTIkSvQW7Jl4euF0VQ9L1FNiuyQY=;
        b=KIkfMhrupBvg7A2BkQw5yY5Mr8nzZ1BIiV86Oa9vDyvFCHkPvrAAKmUBUNSka3V94b
         RORgeFnJkFMlml6FvzGKstOEI0NH2LDwarBtZh6VyhJRoPOqlltuhKF//luggS8ErXXC
         nRRnYBF9BSHJNtV2/O7B1HgL2o5hK0B7FHnmDYfm6QyUE5Uspy4qHnufqqTf2mjPWiIU
         hJUwYmTwvakHX5hRID36AbfFw9+JNMI3SNFZTNG8EU9Kz30hfg+9pV5J1jLlLxk8Xd4Z
         LAypHNSTIEngmXq3qCTuwomIEJYaHhpcMJA9h25LoTbIG50iXhZ1LrKWyUQ+FTFblA1f
         vZrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:in-reply-to:references:subject
         :message-id:date:mime-version:content-transfer-encoding;
        bh=o3/LkW9N1JHK6NujTIkSvQW7Jl4euF0VQ9L1FNiuyQY=;
        b=SilfiGRbVGq6m5cG5CxepuuMLtLYA81Z4bkkz1iXueRdYMcWnt6MGtJRpwHR+QYsvk
         ChFtUaD7p3xOXMv+dxQtMxDoxHjbJajFB6jAcohVKdT1oYQ6oQt0q8A57Owfz/ls0ogB
         CbFEa5vK4NAuvNclY+pI+QMMaJ6RR/RvECtTMuSvawkV0w/PzFPhtsPUMKaWAOf5cSzu
         VuLXzKAz89j543v8LK9ESXgLtJe4n6GkfPtS90EycMfrp+BjNCYpq76fsvYDP6qFb8O3
         7BrAsJNFQZ3onhaTZ/fBVqZDLELqrIqeCwtGNKtdHxWpO7GJHyO1mgyo2azGar5WHZpL
         UwFg==
X-Gm-Message-State: AJIora8a07pjmAot9WT+AxxXZJOEBhOa2ObIF+/mXGQVxxJBB+WZBQ+9
        roRXPASj9R90Y+OnW7BV/CmPAp7ifSk0uw==
X-Google-Smtp-Source: AGRyM1uuKW49x61Wg0fkc2FVJH8XLVCLprKWAibWvD/BnY9ZiH8wYGFgg51RPT7JLCE/h6lk2QPwAA==
X-Received: by 2002:a05:6638:22c9:b0:341:56cf:c447 with SMTP id j9-20020a05663822c900b0034156cfc447mr18840jat.244.1658430909477;
        Thu, 21 Jul 2022 12:15:09 -0700 (PDT)
Received: from [127.0.1.1] ([207.135.234.126])
        by smtp.gmail.com with ESMTPSA id c6-20020a92cf06000000b002dd184e77b3sm399897ilo.61.2022.07.21.12.15.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 Jul 2022 12:15:08 -0700 (PDT)
From:   Jens Axboe <axboe@kernel.dk>
To:     ming.lei@redhat.com
Cc:     linux-block@vger.kernel.org
In-Reply-To: <20220721153117.591394-1-ming.lei@redhat.com>
References: <20220721153117.591394-1-ming.lei@redhat.com>
Subject: Re: [PATCH] ublk_drv: fix lockdep warning
Message-Id: <165843090844.106874.5398970910312566727.b4-ty@kernel.dk>
Date:   Thu, 21 Jul 2022 13:15:08 -0600
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Thu, 21 Jul 2022 23:31:17 +0800, Ming Lei wrote:
> ub->mutex is used to protecting reading and writing ub->mm, then the
> following lockdep warning is triggered.
> 
> Fix it by using one dedicated spin lock for protecting ub->mm.
> 
> [1] lockdep warning
> [   25.046186] ======================================================
> [   25.048886] WARNING: possible circular locking dependency detected
> [   25.051610] 5.19.0-rc4_for-v5.20+ #149 Not tainted
> [   25.053665] ------------------------------------------------------
> [   25.056334] ublk/989 is trying to acquire lock:
> [   25.058296] ffff975d0329a918 (&disk->open_mutex){+.+.}-{3:3}, at: bd_register_pending_holders+0x2a/0x110
> [   25.063678]
> [   25.063678] but task is already holding lock:
> [   25.066246] ffff975d1df59708 (&ub->mutex){+.+.}-{3:3}, at: ublk_ctrl_uring_cmd+0x2df/0x730
> [   25.069423]
> [   25.069423] which lock already depends on the new lock.
> [   25.069423]
> [   25.072603]
> [   25.072603] the existing dependency chain (in reverse order) is:
> [   25.074908]
> [   25.074908] -> #3 (&ub->mutex){+.+.}-{3:3}:
> [   25.076386]        __mutex_lock+0x93/0x870
> [   25.077470]        ublk_ch_mmap+0x3a/0x140
> [   25.078494]        mmap_region+0x375/0x5a0
> [   25.079386]        do_mmap+0x33a/0x530
> [   25.080168]        vm_mmap_pgoff+0xb9/0x150
> [   25.080979]        ksys_mmap_pgoff+0x184/0x1f0
> [   25.081838]        do_syscall_64+0x37/0x80
> [   25.082653]        entry_SYSCALL_64_after_hwframe+0x46/0xb0
> [   25.083730]
> [   25.083730] -> #2 (&mm->mmap_lock#2){++++}-{3:3}:
> [   25.084707]        __might_fault+0x55/0x80
> [   25.085344]        _copy_from_user+0x1e/0xa0
> [   25.086020]        get_sg_io_hdr+0x26/0xb0
> [   25.086651]        scsi_ioctl+0x42f/0x960
> [   25.087267]        sr_block_ioctl+0xe8/0x100
> [   25.087734]        blkdev_ioctl+0x134/0x2b0
> [   25.088196]        __x64_sys_ioctl+0x8a/0xc0
> [   25.088677]        do_syscall_64+0x37/0x80
> [   25.089044]        entry_SYSCALL_64_after_hwframe+0x46/0xb0
> [   25.089548]
> [   25.089548] -> #1 (&cd->lock){+.+.}-{3:3}:
> [   25.090072]        __mutex_lock+0x93/0x870
> [   25.090452]        sr_block_open+0x64/0xe0
> [   25.090837]        blkdev_get_whole+0x26/0x90
> [   25.091445]        blkdev_get_by_dev.part.0+0x1ce/0x2f0
> [   25.092203]        blkdev_open+0x52/0x90
> [   25.092617]        do_dentry_open+0x1ca/0x360
> [   25.093499]        path_openat+0x78d/0xcb0
> [   25.094136]        do_filp_open+0xa1/0x130
> [   25.094759]        do_sys_openat2+0x76/0x130
> [   25.095454]        __x64_sys_openat+0x5c/0x70
> [   25.096078]        do_syscall_64+0x37/0x80
> [   25.096637]        entry_SYSCALL_64_after_hwframe+0x46/0xb0
> [   25.097304]
> [   25.097304] -> #0 (&disk->open_mutex){+.+.}-{3:3}:
> [   25.098229]        __lock_acquire+0x12e2/0x1f90
> [   25.098789]        lock_acquire+0xbf/0x2c0
> [   25.099256]        __mutex_lock+0x93/0x870
> [   25.099706]        bd_register_pending_holders+0x2a/0x110
> [   25.100246]        device_add_disk+0x209/0x370
> [   25.100712]        ublk_ctrl_uring_cmd+0x405/0x730
> [   25.101205]        io_issue_sqe+0xfe/0x2ac0
> [   25.101665]        io_submit_sqes+0x352/0x1820
> [   25.102131]        __do_sys_io_uring_enter+0x848/0xdc0
> [   25.102646]        do_syscall_64+0x37/0x80
> [   25.103087]        entry_SYSCALL_64_after_hwframe+0x46/0xb0
> [   25.103640]
> [   25.103640] other info that might help us debug this:
> [   25.103640]
> [   25.104549] Chain exists of:
> [   25.104549]   &disk->open_mutex --> &mm->mmap_lock#2 --> &ub->mutex
> [   25.104549]
> [   25.105611]  Possible unsafe locking scenario:
> [   25.105611]
> [   25.106258]        CPU0                    CPU1
> [   25.106677]        ----                    ----
> [   25.107100]   lock(&ub->mutex);
> [   25.107446]                                lock(&mm->mmap_lock#2);
> [   25.108045]                                lock(&ub->mutex);
> [   25.108802]   lock(&disk->open_mutex);
> [   25.109265]
> [   25.109265]  *** DEADLOCK ***
> [   25.109265]
> [   25.110117] 2 locks held by ublk/989:
> [   25.110490]  #0: ffff975d07bbf8a8 (&ctx->uring_lock){+.+.}-{3:3}, at: __do_sys_io_uring_enter+0x83e/0xdc0
> [   25.111249]  #1: ffff975d1df59708 (&ub->mutex){+.+.}-{3:3}, at: ublk_ctrl_uring_cmd+0x2df/0x730
> [   25.111943]
> [   25.111943] stack backtrace:
> [   25.112557] CPU: 2 PID: 989 Comm: ublk Not tainted 5.19.0-rc4_for-v5.20+ #149
> [   25.113137] Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.14.0-1.fc33 04/01/2014
> [   25.113792] Call Trace:
> [   25.114130]  <TASK>
> [   25.114417]  dump_stack_lvl+0x71/0xa0
> [   25.114771]  check_noncircular+0xdf/0x100
> [   25.115137]  ? register_lock_class+0x38/0x470
> [   25.115524]  __lock_acquire+0x12e2/0x1f90
> [   25.115887]  ? find_held_lock+0x2b/0x80
> [   25.116244]  lock_acquire+0xbf/0x2c0
> [   25.116590]  ? bd_register_pending_holders+0x2a/0x110
> [   25.117009]  __mutex_lock+0x93/0x870
> [   25.117362]  ? bd_register_pending_holders+0x2a/0x110
> [   25.117780]  ? bd_register_pending_holders+0x2a/0x110
> [   25.118201]  ? kobject_add+0x71/0x90
> [   25.118546]  ? bd_register_pending_holders+0x2a/0x110
> [   25.118958]  bd_register_pending_holders+0x2a/0x110
> [   25.119373]  device_add_disk+0x209/0x370
> [   25.119732]  ublk_ctrl_uring_cmd+0x405/0x730
> [   25.120109]  ? rcu_read_lock_sched_held+0x3c/0x70
> [   25.120514]  io_issue_sqe+0xfe/0x2ac0
> [   25.120863]  io_submit_sqes+0x352/0x1820
> [   25.121228]  ? rcu_read_lock_sched_held+0x3c/0x70
> [   25.121626]  ? __do_sys_io_uring_enter+0x83e/0xdc0
> [   25.122028]  ? find_held_lock+0x2b/0x80
> [   25.122390]  ? __do_sys_io_uring_enter+0x848/0xdc0
> [   25.122791]  __do_sys_io_uring_enter+0x848/0xdc0
> [   25.123190]  ? syscall_enter_from_user_mode+0x20/0x70
> [   25.123606]  ? syscall_enter_from_user_mode+0x20/0x70
> [   25.124024]  do_syscall_64+0x37/0x80
> [   25.124383]  entry_SYSCALL_64_after_hwframe+0x46/0xb0
> [   25.124829] RIP: 0033:0x7f120a762af6
> [   25.125223] Code: 45 c1 41 89 c2 41 b9 08 00 00 00 41 83 ca 10 f6 87 d0 00 00 00 01 8b bf cc 00 00 00 44 0f 44 d0 45 31 c0c
> [   25.126576] RSP: 002b:00007ffdcb3c5518 EFLAGS: 00000246 ORIG_RAX: 00000000000001aa
> [   25.127153] RAX: ffffffffffffffda RBX: 00000000013aef50 RCX: 00007f120a762af6
> [   25.127748] RDX: 0000000000000000 RSI: 0000000000000001 RDI: 0000000000000004
> [   25.128351] RBP: 000000000000000b R08: 0000000000000000 R09: 0000000000000008
> [   25.128956] R10: 0000000000000000 R11: 0000000000000246 R12: 00007ffdcb3c74a6
> [   25.129524] R13: 00000000013aef50 R14: 0000000000000000 R15: 00000000000003df
> [   25.130121]  </TASK>
> 
> [...]

Applied, thanks!

[1/1] ublk_drv: fix lockdep warning
      commit: e94eb459d3e4604927ab4e08f81649fcea418318

Best regards,
-- 
Jens Axboe


