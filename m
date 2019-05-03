Return-Path: <SRS0=mx3V=TD=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_HIGH autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C8A93C43219
	for <linux-block@archiver.kernel.org>; Fri,  3 May 2019 17:47:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 786CD205F4
	for <linux-block@archiver.kernel.org>; Fri,  3 May 2019 17:47:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="NllS5QzJ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727969AbfECRrs (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 3 May 2019 13:47:48 -0400
Received: from mail-lj1-f172.google.com ([209.85.208.172]:42807 "EHLO
        mail-lj1-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726992AbfECRrs (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Fri, 3 May 2019 13:47:48 -0400
Received: by mail-lj1-f172.google.com with SMTP id r72so5904177ljb.9
        for <linux-block@vger.kernel.org>; Fri, 03 May 2019 10:47:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:from:date:message-id:subject:to:cc;
        bh=cwP6wxrcbhRd6oegUegMFx6BqN6mg5qssg+c1Id8ddQ=;
        b=NllS5QzJjgZ62UYDnAkYCSk1g/Np/Yvz/aZdMTkL0lon5t/z+N/MEvzpi4gwcCR6nN
         5r+7WQwdlncHNNYezCDMygVJSx5f1POhBRBUF7mpv+ZRsoDyEGUnYJgSv4vhZrZLpQkG
         lx9oDkQ9Rz9XGbJHZQc3DCA4w3voBugYxsCtY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc;
        bh=cwP6wxrcbhRd6oegUegMFx6BqN6mg5qssg+c1Id8ddQ=;
        b=nvrULLwIqueluJZ2mGwo6fLh6We5qCOUFi3l+kXaGKXdOOlOheA5xHEbGeG0ygbKR/
         K+eXKizDV6qTqzw+fsVFOr6jPaUTXHAJwjBHkjPaXNJCPsNNuIV9f7vYM0LVQ7Y7iXgG
         lYjnYLTNPGI88mx9HBRism64NHvUb7kAwKN5E+QNaYs9BB8Y3BU31HDViwBesfuuC5jK
         Lty6s5PfZexvcKAluOce1Yj2JIac1TMyIoAMU6MgMsgvDaW9OxCiLtVc3GBYolfO5TJL
         kLhg/uB2Yymxakq8733Sb63Th8W9Dh/91HRVQK3BmjjCItC8097mJ7Tpm3bYSY6AIr9w
         Sv6A==
X-Gm-Message-State: APjAAAXx7VivWr2EyrW+kdoC/5wWKe8THPNPLooXEyjlETtveylfoavx
        D89l0edqw82Iz8bPE+Xa3KK6X8/DRSs=
X-Google-Smtp-Source: APXvYqwRWJc9DNinYhKb8OYZzUCuzKzhSNrp67fyrOZxMZ/GEOg+yLaAQmK2HIT5nZRK8JEOsQus3A==
X-Received: by 2002:a2e:8984:: with SMTP id c4mr5783538lji.161.1556905662767;
        Fri, 03 May 2019 10:47:42 -0700 (PDT)
Received: from mail-lj1-f181.google.com (mail-lj1-f181.google.com. [209.85.208.181])
        by smtp.gmail.com with ESMTPSA id y7sm509324ljj.34.2019.05.03.10.47.42
        for <linux-block@vger.kernel.org>
        (version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
        Fri, 03 May 2019 10:47:42 -0700 (PDT)
Received: by mail-lj1-f181.google.com with SMTP id k8so5919583lja.8
        for <linux-block@vger.kernel.org>; Fri, 03 May 2019 10:47:42 -0700 (PDT)
X-Received: by 2002:a2e:86c5:: with SMTP id n5mr5921338ljj.184.1556905660981;
 Fri, 03 May 2019 10:47:40 -0700 (PDT)
MIME-Version: 1.0
From:   Evan Green <evgreen@chromium.org>
Date:   Fri, 3 May 2019 10:47:04 -0700
X-Gmail-Original-Message-ID: <CAE=gft4irmMAapAj3O0hWr53PnyRUmcX2AJB+p_PqCJHT0rvNg@mail.gmail.com>
Message-ID: <CAE=gft4irmMAapAj3O0hWr53PnyRUmcX2AJB+p_PqCJHT0rvNg@mail.gmail.com>
Subject: blkdev_get deadlock
To:     linux-block <linux-block@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Cc:     Jens Axboe <axboe@kernel.dk>, Bart Van Assche <bvanassche@acm.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Hey blockies,

I'm seeing a hung task in the kernel, and I wanted to share it in case
it's a known issue. I'm still trying to wrap my head around the stacks
myself. This is our Chrome OS 4.19 kernel, which is admittedly not
100% vanilla mainline master, but we try to keep it pretty close.

I can reproduce this reliably within our chrome OS installer, where
it's trying to dd from my system disk (NVMe) to a loop device backed
by a removable UFS card (4kb sectors) in a USB dongle.
-Evan

[  371.440691] INFO: task udevd:197 blocked for more than 120 seconds.
[  371.447807]       Not tainted 4.19.37 #8
[  371.452300] "echo 0 > /proc/sys/kernel/hung_task_timeout_secs"
disables this message.
[  371.461261] udevd           D    0   197      1 0x00000000
[  371.467511] Call Trace:
[  371.470314]  ? __schedule+0x1308/0x1c2f
[  371.474650]  ? lock_acquire+0x377/0x4aa
[  371.478984]  ? is_mmconf_reserved+0x3bf/0x3bf
[  371.483893]  ? do_raw_spin_unlock+0x4f/0x24e
[  371.488702]  ? _raw_spin_unlock+0x7e/0xfa
[  371.493210]  ? _raw_spin_lock_bh+0x49/0x49
[  371.497816]  schedule+0x112/0x13c
[  371.501559]  schedule_preempt_disabled+0x17/0x22
[  371.506736]  __mutex_lock_common+0xe69/0x22b4
[  371.511634]  ? __blkdev_get+0x10f/0xdf2
[  371.515980]  ? mutex_lock_io_nested+0x5a/0x5a
[  371.520865]  ? cancel_work_sync+0xe/0xe
[  371.525172]  ? __mutex_unlock_slowpath+0x1b5/0x5fa
[  371.530575]  ? _raw_spin_unlock+0xfa/0xfa
[  371.535107]  ? mutex_unlock+0x10/0x10
[  371.539255]  mutex_lock_nested+0x20/0x26
[  371.543694]  __blkdev_get+0x10f/0xdf2
[  371.547800]  ? bd_acquire+0x206/0x23a
[  371.551912]  ? __lock_acquire+0x41fb/0x41fb
[  371.556667]  ? lock_acquire+0x377/0x4aa
[  371.560977]  ? blkdev_get+0x88e/0x88e
[  371.565094]  blkdev_get+0x114/0x88e
[  371.569201]  ? _raw_spin_unlock+0x7e/0xfa
[  371.573707]  ? _raw_spin_lock_bh+0x49/0x49
[  371.578311]  ? selinux_file_receive+0xdd/0xdd
[  371.583202]  ? do_raw_spin_unlock+0x4f/0x24e
[  371.587995]  ? bd_set_size+0xa1/0xa1
[  371.592019]  ? bd_acquire+0x206/0x23a
[  371.596125]  ? blkdev_open+0x11a/0x224
[  371.600339]  do_dentry_open+0x78b/0xe21
[  371.604652]  ? __devcgroup_check_permission+0x1dd/0x229
[  371.611026]  ? block_ioctl+0xee/0xee
[  371.615045]  ? finish_open+0xad/0xad
[  371.619067]  ? security_inode_permission+0x73/0xbb
[  371.624501]  path_openat+0x953/0x34a0
[  371.628625]  ? lock_acquire+0x4aa/0x4aa
[  371.632936]  ? __irqentry_text_end+0x1f9a26/0x1f9a26
[  371.638526]  ? do_filp_open+0x381/0x381
[  371.642831]  ? kasan_kmalloc+0x1aa/0x1d6
[  371.647227]  ? kmem_cache_alloc+0xeb/0x2b1
[  371.651822]  ? __alloc_fd+0x4b7/0x5ad
[  371.655968]  ? __lock_acquire+0x41fb/0x41fb
[  371.660668]  ? expand_files+0xe5/0x66a
[  371.664913]  ? do_raw_spin_lock+0xbd/0x1e9
[  371.669543]  do_filp_open+0x23a/0x381
[  371.673701]  ? vfs_tmpfile+0x1cd/0x1cd
[  371.677951]  ? __alloc_fd+0x4b7/0x5ad
[  371.682049]  ? exit_files+0x90/0x90
[  371.685974]  do_sys_open+0x2af/0x967
[  371.689993]  ? prepare_exit_to_usermode+0x2e0/0x2e0
[  371.695464]  ? file_open_root+0x49f/0x49f
[  371.700132]  ? trace_irq_disable_rcuidle+0x75/0x228
[  371.705611]  ? trace_irq_enable_rcuidle+0x75/0x228
[  371.710983]  ? trace_hardirqs_off+0x3f/0x3f
[  371.715683]  ? trace_hardirqs_on_thunk+0x1a/0x1c
[  371.720871]  ? trace_hardirqs_on+0x3f/0x3f
[  371.725504]  ? do_syscall_64+0x28/0x120
[  371.729817]  ? filp_close+0xd3/0x10a
[  371.733837]  do_syscall_64+0xcd/0x120
[  371.737950]  entry_SYSCALL_64_after_hwframe+0x49/0xbe
[  371.743613] RIP: 0033:0x7c577338adcf
[  371.747667] Code: Bad RIP value.
[  371.751287] RSP: 002b:00007fff83e955c0 EFLAGS: 00000246 ORIG_RAX:
0000000000000101
[  371.759776] RAX: ffffffffffffffda RBX: 00005c8073608370 RCX: 00007c577338adcf
[  371.767805] RDX: 00000000000a0800 RSI: 00005c807364e510 RDI: 00000000ffffff9c
[  371.775860] RBP: 00007fff83e95ba0 R08: 0000000000000004 R09: 00005c80720b5b00
[  371.783867] R10: 0000000000000000 R11: 0000000000000246 R12: 00005c807361d360
[  371.791860] R13: 00005c80736082a0 R14: 00007fff83e95660 R15: 00007fff83e95670
[  371.799938] INFO: lockdep is turned off.
[  371.804377]   task                        PC stack   pid father
[  371.811077] kworker/u16:3   D    0   119      2 0x80000000
[  371.817273] Workqueue: writeback wb_workfn (flush-8:0)
[  371.823079] Call Trace:
[  371.825827]  ? __schedule+0x1308/0x1c2f
[  371.830140]  ? try_to_wake_up+0xa20/0xf52
[  371.834817]  ? __lock_acquire+0x41fb/0x41fb
[  371.839518]  ? __sbitmap_get_word+0x96/0x16a
[  371.844328]  ? is_mmconf_reserved+0x3bf/0x3bf
[  371.849218]  ? blk_poll+0xc7/0xc7
[  371.852942]  ? sbitmap_get_shallow+0x11e/0x268
[  371.857926]  schedule+0x112/0x13c
[  371.861673]  io_schedule+0x19/0x69
[  371.865553]  blk_mq_get_tag+0x4ff/0xaee
[  371.869855]  ? __blk_mq_tag_idle+0x11c/0x11c
[  371.874646]  ? do_raw_spin_lock+0x84/0x1e9
[  371.879239]  ? lock_acquire+0x4aa/0x4aa
[  371.883540]  blk_mq_get_request+0x47d/0xfc1
[  371.888236]  ? blk_put_request+0xd4/0xd4
[  371.892641]  ? blk_mq_alloc_request+0x23a/0x23a
[  371.897782]  ? trace_hardirqs_on+0x3f/0x3f
[  371.902386]  ? print_irqtrace_events+0x223/0x223
[  371.907568]  ? update_cfs_rq_load_avg+0x31b/0x5ee
[  371.912850]  ? update_load_avg+0x203/0xe4c
[  371.917442]  ? __update_load_avg_se+0x8e1/0x8e1
[  371.922554]  ? update_stats_wait_end+0x88/0x644
[  371.927642]  ? ___slab_alloc+0x396/0x432
[  371.932047]  ? sched_group_set_shares+0x2f2/0x2f2
[  371.937336]  ? set_next_entity+0x191/0x46c
[  371.941950]  ? generic_make_request+0x410/0xb50
[  371.947027]  ? __lock_acquire+0x41fb/0x41fb
[  371.951725]  ? check_preempt_wakeup+0x6c9/0x6c9
[  371.956807]  ? prepare_lock_switch+0x94/0x119
[  371.961862]  ? __schedule+0x1308/0x1c2f
[  371.966193]  ? wait_on_page_bit_common+0x4ea/0x64b
[  371.971566]  ? generic_block_bmap+0x1d9/0x1d9
[  371.976471]  ? blk_flush_plug_list+0x496/0x912
[  371.981580]  ? submit_bh_wbc+0x4e5/0x5e9
[  371.986087]  ? is_mmconf_reserved+0x3bf/0x3bf
[  371.991028]  ? blk_poll+0xc7/0xc7
[  371.994901]  ? block_size_bits+0x1a/0x1a
[  371.999503]  ? _raw_spin_unlock_irq+0x83/0x100
[  372.004489]  ? schedule+0x112/0x13c
[  372.008438]  ? __block_write_full_page+0x65c/0x9b2
[  372.013808]  ? io_schedule+0x19/0x69
[  372.017824]  ? wait_on_page_bit_common+0x536/0x64b
[  372.023201]  ? mark_buffer_write_io_error+0xd7/0xd7
[  372.028666]  ? blkdev_direct_IO+0x9e/0x9e
[  372.033166]  ? wait_on_page_bit+0x37/0x37
[  372.037666]  ? trace_raw_output_file_check_and_advance_wb_err+0x1b4/0x1b4
[  372.045329]  ? write_cache_pages+0x9c8/0xf0f
[  372.050122]  ? generic_writepages+0x147/0x147
[  372.055035]  ? tag_pages_for_writeback+0x327/0x327
[  372.060413]  ? __update_load_avg_se+0x8e1/0x8e1
[  372.065496]  ? lock_acquire+0x4aa/0x4aa
[  372.069835]  ? __writeback_single_inode+0x727/0x1146
[  372.075398]  ? __lock_acquire+0x41fb/0x41fb
[  372.080113]  ? generic_writepages+0xeb/0x147
[  372.084907]  ? clear_page_dirty_for_io+0x43d/0x43d
[  372.090472]  ? update_cfs_rq_load_avg+0x31b/0x5ee
[  372.095758]  ? lock_acquire+0x4aa/0x4aa
[  372.100062]  ? do_raw_spin_unlock+0x4f/0x24e
[  372.104846]  ? lock_acquire+0x4aa/0x4aa
[  372.109154]  ? _raw_spin_unlock+0x7e/0xfa
[  372.113654]  ? _raw_spin_lock_bh+0x49/0x49
[  372.118244]  ? do_writepages+0xaf/0x12c
[  372.122553]  ? __writeback_single_inode+0x327/0x1146
[  372.128128]  ? redirty_tail+0x136/0x136
[  372.132429]  ? __lock_acquire+0x41fb/0x41fb
[  372.137123]  ? lock_acquire+0x377/0x4aa
[  372.141432]  ? writeback_sb_inodes+0xcf0/0xe5b
[  372.146430]  ? lock_downgrade+0x60a/0x60a
[  372.150959]  ? do_raw_spin_unlock+0x4f/0x24e
[  372.155749]  ? _raw_spin_unlock+0x7e/0xfa
[  372.160250]  ? _raw_spin_lock_bh+0x49/0x49
[  372.164849]  ? do_raw_spin_lock+0xbd/0x1e9
[  372.169446]  ? do_raw_spin_lock+0xbd/0x1e9
[  372.174035]  ? writeback_sb_inodes+0x4d9/0xe5b
[  372.179026]  ? queue_io+0x545/0x545
[  372.182934]  ? wb_over_bg_thresh+0x202/0x3c4
[  372.187714]  ? down_read_trylock+0x61/0xaa
[  372.192310]  ? trylock_super+0x1f/0xa6
[  372.196553]  ? __writeback_inodes_wb+0x110/0x1d1
[  372.201726]  ? wb_writeback+0x885/0xdcd
[  372.206033]  ? wb_io_lists_depopulated+0x10d/0x10d
[  372.211407]  ? wb_over_bg_thresh+0x202/0x3c4
[  372.216345]  ? balance_dirty_pages+0x16cc/0x16cc
[  372.221523]  ? trace_irq_enable_rcuidle+0x75/0x228
[  372.226897]  ? lock_downgrade+0x5b2/0x60a
[  372.231388]  ? __local_bh_enable_ip+0x10b/0x1b4
[  372.236472]  ? wb_workfn+0x810/0xeda
[  372.240519]  ? wb_workfn+0xb87/0xeda
[  372.244525]  ? update_cfs_rq_load_avg+0x31b/0x5ee
[  372.249797]  ? __inode_wait_for_writeback+0x294/0x294
[  372.255491]  ? trace_irq_enable_rcuidle+0x75/0x228
[  372.260860]  ? lock_acquire+0x377/0x4aa
[  372.265171]  ? trace_hardirqs_on+0x3f/0x3f
[  372.269817]  ? process_one_work+0x655/0x11b6
[  372.274609]  ? trace_irq_enable_rcuidle+0x75/0x228
[  372.279992]  ? lock_acquire+0x377/0x4aa
[  372.284302]  ? process_one_work+0x6a4/0x11b6
[  372.289144]  ? lock_downgrade+0x60a/0x60a
[  372.293643]  ? _raw_spin_unlock_irq+0x83/0x100
[  372.298667]  ? _raw_spin_unlock_irqrestore+0x12e/0x12e
[  372.304433]  ? read_word_at_a_time+0x12/0x18
[  372.309239]  ? strscpy+0x6c/0x256
[  372.312984]  ? process_one_work+0x90b/0x11b6
[  372.317774]  ? worker_detach_from_pool+0x1fa/0x1fa
[  372.323193]  ? is_mmconf_reserved+0x3bf/0x3bf
[  372.328122]  ? lock_downgrade+0x60a/0x60a
[  372.332626]  ? trace_irq_disable_rcuidle+0x75/0x228
[  372.338187]  ? lockdep_hardirqs_on+0x6d8/0x6d8
[  372.343235]  ? _raw_spin_unlock_irq+0x83/0x100
[  372.348366]  ? do_raw_spin_lock+0xbd/0x1e9
[  372.352967]  ? worker_thread+0xad5/0xdcc
[  372.357413]  ? pr_cont_work+0xe6/0xe6
[  372.361528]  ? kthread+0x34e/0x35e
[  372.365349]  ? pr_cont_work+0xe6/0xe6
[  372.369492]  ? kthread_blkcg+0xa2/0xa2
[  372.373697]  ? ret_from_fork+0x24/0x50
[  372.377922] udevd           D    0   197      1 0x00000000
[  372.384124] Call Trace:
[  372.386874]  ? __schedule+0x1308/0x1c2f
[  372.391194]  ? lock_acquire+0x377/0x4aa
[  372.395520]  ? is_mmconf_reserved+0x3bf/0x3bf
[  372.400410]  ? do_raw_spin_unlock+0x4f/0x24e
[  372.405217]  ? _raw_spin_unlock+0x7e/0xfa
[  372.409704]  ? _raw_spin_lock_bh+0x49/0x49
[  372.414300]  schedule+0x112/0x13c
[  372.418046]  schedule_preempt_disabled+0x17/0x22
[  372.423227]  __mutex_lock_common+0xe69/0x22b4
[  372.428124]  ? __blkdev_get+0x10f/0xdf2
[  372.432424]  ? mutex_lock_io_nested+0x5a/0x5a
[  372.437307]  ? cancel_work_sync+0xe/0xe
[  372.441611]  ? __mutex_unlock_slowpath+0x1b5/0x5fa
[  372.447017]  ? _raw_spin_unlock+0xfa/0xfa
[  372.451538]  ? mutex_unlock+0x10/0x10
[  372.455679]  mutex_lock_nested+0x20/0x26
[  372.460141]  __blkdev_get+0x10f/0xdf2
[  372.464253]  ? bd_acquire+0x206/0x23a
[  372.468363]  ? __lock_acquire+0x41fb/0x41fb
[  372.473107]  ? lock_acquire+0x377/0x4aa
[  372.477408]  ? blkdev_get+0x88e/0x88e
[  372.481678]  blkdev_get+0x114/0x88e
[  372.485596]  ? _raw_spin_unlock+0x7e/0xfa
[  372.490113]  ? _raw_spin_lock_bh+0x49/0x49
[  372.494708]  ? selinux_file_receive+0xdd/0xdd
[  372.499637]  ? do_raw_spin_unlock+0x4f/0x24e
[  372.504431]  ? bd_set_size+0xa1/0xa1
[  372.508481]  ? bd_acquire+0x206/0x23a
[  372.512596]  ? blkdev_open+0x11a/0x224
[  372.516834]  do_dentry_open+0x78b/0xe21
[  372.521171]  ? __devcgroup_check_permission+0x1dd/0x229
[  372.527042]  ? block_ioctl+0xee/0xee
[  372.531075]  ? finish_open+0xad/0xad
[  372.535090]  ? security_inode_permission+0x73/0xbb
[  372.540469]  path_openat+0x953/0x34a0
[  372.544601]  ? lock_acquire+0x4aa/0x4aa
[  372.548920]  ? __irqentry_text_end+0x1f9a26/0x1f9a26
[  372.554514]  ? do_filp_open+0x381/0x381
[  372.558834]  ? kasan_kmalloc+0x1aa/0x1d6
[  372.563248]  ? kmem_cache_alloc+0xeb/0x2b1
[  372.567862]  ? __alloc_fd+0x4b7/0x5ad
[  372.572030]  ? __lock_acquire+0x41fb/0x41fb
[  372.576726]  ? expand_files+0xe5/0x66a
[  372.580934]  ? do_raw_spin_lock+0xbd/0x1e9
[  372.585601]  do_filp_open+0x23a/0x381
[  372.589726]  ? vfs_tmpfile+0x1cd/0x1cd
[  372.593947]  ? __alloc_fd+0x4b7/0x5ad
[  372.598072]  ? exit_files+0x90/0x90
[  372.602003]  do_sys_open+0x2af/0x967
[  372.606024]  ? prepare_exit_to_usermode+0x2e0/0x2e0
[  372.611677]  ? file_open_root+0x49f/0x49f
[  372.616189]  ? trace_irq_disable_rcuidle+0x75/0x228
[  372.621669]  ? trace_irq_enable_rcuidle+0x75/0x228
[  372.627058]  ? trace_hardirqs_off+0x3f/0x3f
[  372.631754]  ? trace_hardirqs_on_thunk+0x1a/0x1c
[  372.636941]  ? trace_hardirqs_on+0x3f/0x3f
[  372.641549]  ? do_syscall_64+0x28/0x120
[  372.645855]  ? filp_close+0xd3/0x10a
[  372.649882]  do_syscall_64+0xcd/0x120
[  372.653997]  entry_SYSCALL_64_after_hwframe+0x49/0xbe
[  372.659674] RIP: 0033:0x7c577338adcf
[  372.663692] Code: Bad RIP value.
[  372.667323] RSP: 002b:00007fff83e955c0 EFLAGS: 00000246 ORIG_RAX:
0000000000000101
[  372.675825] RAX: ffffffffffffffda RBX: 00005c8073608370 RCX: 00007c577338adcf
[  372.683834] RDX: 00000000000a0800 RSI: 00005c807364e510 RDI: 00000000ffffff9c
[  372.691845] RBP: 00007fff83e95ba0 R08: 0000000000000004 R09: 00005c80720b5b00
[  372.699877] R10: 0000000000000000 R11: 0000000000000246 R12: 00005c807361d360
[  372.707891] R13: 00005c80736082a0 R14: 00007fff83e95660 R15: 00007fff83e95670
[  372.715995] dd              D    0  5250   4342 0x00000080
[  372.722293] Call Trace:
[  372.725416]  ? __schedule+0x1308/0x1c2f
[  372.729861]  ? unwind_next_frame+0xdee/0x16d2
[  372.735412]  ? is_mmconf_reserved+0x3bf/0x3bf
[  372.740326]  ? blk_poll+0xc7/0xc7
[  372.744364]  ? do_raw_spin_unlock+0x4f/0x24e
[  372.749176]  ? sbitmap_get_shallow+0x11e/0x268
[  372.754170]  schedule+0x112/0x13c
[  372.757931]  ? unwind_next_frame+0xdee/0x16d2
[  372.762833]  io_schedule+0x19/0x69
[  372.766682]  ? blk_mq_get_tag+0x4ff/0xaee
[  372.771179]  ? __blk_mq_tag_idle+0x11c/0x11c
[  372.775964]  ? do_raw_spin_lock+0x84/0x1e9
[  372.780578]  ? init_wait_entry+0xd6/0xd6
[  372.784976]  ? _raw_spin_unlock+0xdf/0xfa
[  372.789471]  ? blk_mq_get_request+0x47d/0xfc1
[  372.794363]  ? blk_mq_alloc_request+0x23a/0x23a
[  372.799446]  ? trace_hardirqs_on+0x3f/0x3f
[  372.804032]  ? blk_mq_make_request+0x620/0x15ff
[  372.809119]  ? blk_mq_requeue_work+0x5b8/0x5b8
[  372.814113]  ? trace_tlb_flush_rcuidle+0x79/0x280
[  372.819400]  ? print_irqtrace_events+0x223/0x223
[  372.824586]  ? ___slab_alloc+0x430/0x432
[  372.829008]  ? mempool_alloc_slab+0x15/0x17
[  372.833701]  ? blk_queue_enter+0x359/0x3a9
[  372.838305]  ? blk_alloc_queue_node+0x934/0x934
[  372.843399]  ? switch_mm_irqs_off+0x8a2/0x1445
[  372.848441]  ? generic_make_request+0x410/0xb50
[  372.853530]  ? blk_rq_bio_prep+0x233/0x233
[  372.858129]  ? print_irqtrace_events+0x223/0x223
[  372.863292]  ? submit_bio+0x21d/0x4b2
[  372.867404]  ? direct_make_request+0x165/0x165
[  372.872538]  ? bio_chain_endio+0xe1/0xe1
[  372.877136]  ? bio_add_page+0x7d/0xc5
[  372.881371]  ? submit_bh_wbc+0x4e5/0x5e9
[  372.885884]  ? block_size_bits+0x1a/0x1a
[  372.890393]  ? __block_write_full_page+0x65c/0x9b2
[  372.895958]  ? mark_buffer_write_io_error+0xd7/0xd7
[  372.901518]  ? blkdev_direct_IO+0x9e/0x9e
[  372.906144]  ? clean_bdev_aliases+0x676/0x676
[  372.911134]  ? wait_on_page_bit+0x37/0x37
[  372.915753]  ? block_write_full_page+0x11c/0x2c6
[  372.921073]  ? blkdev_direct_IO+0x9e/0x9e
[  372.925679]  ? trace_raw_output_file_check_and_advance_wb_err+0x1b4/0x1b4
[  372.933401]  ? clear_page_dirty_for_io+0x3aa/0x43d
[  372.938891]  ? write_cache_pages+0x9c8/0xf0f
[  372.943953]  ? generic_writepages+0x147/0x147
[  372.948884]  ? tag_pages_for_writeback+0x327/0x327
[  372.954265]  ? _raw_spin_unlock_irq+0x83/0x100
[  372.959246]  ? schedule_timeout+0x3b/0x20d
[  372.963877]  ? lock_downgrade+0x60a/0x60a
[  372.968384]  ? schedule_tail+0x267/0x267
[  372.972792]  ? __switch_to_asm+0x40/0x70
[  372.977222]  ? syscall_return_via_sysret+0xe/0x7e
[  372.982503]  ? generic_writepages+0xeb/0x147
[  372.987286]  ? clear_page_dirty_for_io+0x43d/0x43d
[  372.992688]  ? __mutex_lock_common+0x24e/0x22b4
[  372.997779]  ? do_writepages+0xaf/0x12c
[  373.002235]  ? __filemap_fdatawrite_range+0x237/0x2cf
[  373.007917]  ? blkdev_put+0x238/0x326
[  373.012051]  ? filemap_check_errors+0x19c/0x19c
[  373.017281]  ? preempt_schedule_common+0x24/0x56
[  373.022602]  ? preempt_schedule+0xc1/0xc8
[  373.027247]  ? trace_hardirqs_on+0x3f/0x3f
[  373.031864]  ? filemap_write_and_wait+0x5b/0xa7
[  373.036955]  ? __blkdev_put+0x1a4/0x54f
[  373.041255]  ? do_raw_spin_lock+0xbd/0x1e9
[  373.045883]  ? blkdev_get_by_dev+0x49/0x49
[  373.050482]  ? blkdev_put+0x238/0x326
[  373.054600]  ? blkdev_close+0x7b/0x9d
[  373.058738]  ? __fput+0x240/0x571
[  373.062471]  ? task_work_run+0x93/0x14e
[  373.066815]  ? prepare_exit_to_usermode+0x203/0x2e0
[  373.072318]  ? syscall_return_slowpath+0x12f/0x66e
[  373.077722]  ? prepare_exit_to_usermode+0x2e0/0x2e0
[  373.083222]  ? fput+0x10d/0x1d0
[  373.086776]  ? delayed_fput+0x68/0x68
[  373.090893]  ? trace_irq_enable_rcuidle+0x75/0x228
[  373.096270]  ? __put_unused_fd+0x44/0x139
[  373.100791]  ? filp_close+0xd3/0x10a
[  373.104813]  ? __x64_sys_close+0x69/0x8f
[  373.109213]  ? do_syscall_64+0xcd/0x120
[  373.113529]  ? entry_SYSCALL_64_after_hwframe+0x49/0xbe
[  373.119431] Binder:3211_1   D    0  8032   2347 0xa0020080
[  373.125593] Call Trace:
[  373.128542]  ? __schedule+0x1308/0x1c2f
[  373.132861]  ? is_mmconf_reserved+0x3bf/0x3bf
[  373.137770]  ? __might_sleep+0x4a/0xfc
[  373.141989]  schedule+0x112/0x13c
[  373.145742]  exit_mm+0x351/0x5e5
[  373.149406]  ? do_exit+0x229b/0x229b
[  373.153498]  ? do_exit+0xf36/0x229b
[  373.157418]  do_exit+0x5b2/0x229b
[  373.161182]  ? preempt_schedule_common+0x24/0x56
[  373.166359]  ? preempt_schedule+0xc1/0xc8
[  373.170872]  ? will_become_orphaned_pgrp+0x22f/0x22f
[  373.176460]  ? retint_kernel+0x2d/0x2d
[  373.180695]  ? ___preempt_schedule+0x16/0x18
[  373.185524]  ? _raw_spin_unlock_irq+0x83/0x100
[  373.190525]  ? _raw_spin_unlock_irq+0xe5/0x100
[  373.195510]  do_group_exit+0x225/0x260
[  373.199738]  get_signal+0x3f1/0x179e
[  373.203752]  ? lock_acquire+0x4aa/0x4aa
[  373.208067]  ? ptrace_do_notify+0x2c8/0x2c8
[  373.212766]  ? rcu_lock_release+0x4/0x1d
[  373.217203]  ? __lock_acquire+0x41fb/0x41fb
[  373.221907]  do_signal+0xd9/0x114a
[  373.225738]  ? audit_filter_inodes+0x365/0x3d5
[  373.230718]  ? signal_fault+0x1e5/0x1e5
[  373.235021]  ? rcu_lock_release+0x1d/0x1d
[  373.239532]  ? audit_take_context+0x3c4/0x50e
[  373.244430]  ? __audit_syscall_exit+0x554/0x6cb
[  373.249517]  ? trace_irq_enable_rcuidle+0x75/0x228
[  373.254904]  ? __audit_free+0x549/0x549
[  373.259468]  ? prepare_exit_to_usermode+0x20a/0x2e0
[  373.264952]  ? print_irqtrace_events+0x223/0x223
[  373.270145]  ? trace_irq_disable_rcuidle+0x75/0x228
[  373.275633]  ? trace_hardirqs_off+0x3f/0x3f
[  373.280340]  prepare_exit_to_usermode+0x230/0x2e0
[  373.285628]  syscall_return_slowpath+0x12f/0x66e
[  373.290816]  ? fput+0x74/0x1d0
[  373.294274]  ? prepare_exit_to_usermode+0x2e0/0x2e0
[  373.299757]  ? do_syscall_64+0x120/0x120
[  373.304178]  ? security_file_ioctl+0x62/0x95
[  373.308986]  ? __ia32_compat_sys_ioctl+0x182f/0x2112
[  373.314568]  ? do_int80_syscall_32+0x108/0x175
[  373.319586]  entry_INT80_compat+0x87/0xa0
[  373.324098] Binder:3211_2   D    0  8033   2347 0xa0020080
[  373.330252] Call Trace:
[  373.333002]  ? __schedule+0x1308/0x1c2f
[  373.337336]  ? _raw_spin_unlock_irqrestore+0xa5/0x12e
[  373.342994]  ? is_mmconf_reserved+0x3bf/0x3bf
[  373.347884]  ? _raw_spin_unlock_irqrestore+0xa5/0x12e
[  373.353576]  ? _raw_spin_unlock_irqrestore+0x113/0x12e
[  373.359351]  ? __wake_up_common+0x290/0x479
[  373.364054]  ? _raw_spin_unlock+0xfa/0xfa
[  373.368598]  schedule+0x112/0x13c
[  373.372324]  exit_mm+0x351/0x5e5
[  373.375952]  ? do_exit+0x229b/0x229b
[  373.379976]  ? do_exit+0xf36/0x229b
[  373.383902]  do_exit+0x5b2/0x229b
[  373.387644]  ? trace_irq_enable_rcuidle+0x75/0x228
[  373.393209]  ? will_become_orphaned_pgrp+0x22f/0x22f
[  373.398787]  ? lock_acquire+0x377/0x4aa
[  373.403100]  ? trace_hardirqs_on+0x3f/0x3f
[  373.407702]  ? _raw_spin_unlock_irq+0x83/0x100
[  373.412697]  ? print_irqtrace_events+0x223/0x223
[  373.417877]  ? _raw_spin_unlock_irq+0x83/0x100
[  373.422876]  do_group_exit+0x225/0x260
[  373.427088]  get_signal+0x3f1/0x179e
[  373.431113]  ? lock_acquire+0x4aa/0x4aa
[  373.435428]  ? ptrace_do_notify+0x2c8/0x2c8
[  373.440133]  ? rcu_lock_release+0x4/0x1d
[  373.444559]  ? __lock_acquire+0x41fb/0x41fb
[  373.449311]  do_signal+0xd9/0x114a
[  373.453149]  ? audit_filter_inodes+0x365/0x3d5
[  373.458142]  ? signal_fault+0x1e5/0x1e5
[  373.462454]  ? rcu_lock_release+0x1d/0x1d
[  373.466967]  ? audit_take_context+0x3c4/0x50e
[  373.471861]  ? __audit_syscall_exit+0x554/0x6cb
[  373.476957]  ? trace_irq_enable_rcuidle+0x75/0x228
[  373.482340]  ? __audit_free+0x549/0x549
[  373.486656]  ? prepare_exit_to_usermode+0x20a/0x2e0
[  373.492138]  ? print_irqtrace_events+0x223/0x223
[  373.497321]  ? trace_irq_disable_rcuidle+0x75/0x228
[  373.502801]  ? trace_hardirqs_off+0x3f/0x3f
[  373.507520]  prepare_exit_to_usermode+0x230/0x2e0
[  373.512803]  syscall_return_slowpath+0x12f/0x66e
[  373.517996]  ? fput+0x74/0x1d0
[  373.521674]  ? prepare_exit_to_usermode+0x2e0/0x2e0
[  373.527158]  ? do_syscall_64+0x120/0x120
[  373.531571]  ? security_file_ioctl+0x62/0x95
[  373.536372]  ? __ia32_compat_sys_ioctl+0x182f/0x2112
[  373.541948]  ? do_int80_syscall_32+0x108/0x175
[  373.546935]  entry_INT80_compat+0x87/0xa0
[  373.551485] DispSync        D    0  8034   2347 0xa0020080
[  373.557625] Call Trace:
[  373.560379]  ? __schedule+0x1308/0x1c2f
[  373.564691]  ? is_mmconf_reserved+0x3bf/0x3bf
[  373.569612]  ? __might_sleep+0x4a/0xfc
[  373.573825]  schedule+0x112/0x13c
[  373.577553]  exit_mm+0x351/0x5e5
[  373.581172]  ? do_exit+0x229b/0x229b
[  373.585186]  ? do_exit+0xf36/0x229b
[  373.589106]  do_exit+0x5b2/0x229b
[  373.592833]  ? trace_irq_enable_rcuidle+0x75/0x228
[  373.598202]  ? will_become_orphaned_pgrp+0x22f/0x22f
[  373.603774]  ? lock_acquire+0x377/0x4aa
[  373.608083]  ? trace_hardirqs_on+0x3f/0x3f
[  373.612670]  ? _raw_spin_unlock_irq+0x83/0x100
[  373.617656]  ? print_irqtrace_events+0x223/0x223
[  373.622847]  ? _raw_spin_unlock_irq+0x83/0x100
[  373.627890]  do_group_exit+0x225/0x260
[  373.632097]  get_signal+0x3f1/0x179e
[  373.636126]  ? lock_acquire+0x4aa/0x4aa
[  373.640447]  ? ptrace_do_notify+0x2c8/0x2c8
[  373.645143]  ? rcu_lock_release+0x4/0x1d
[  373.649724]  ? __lock_acquire+0x41fb/0x41fb
[  373.654438]  ? do_signal+0xd9/0x114a
[  373.658457]  do_signal+0xd9/0x114a
[  373.662308]  ? audit_filter_inodes+0x365/0x3d5
[  373.667292]  ? signal_fault+0x1e5/0x1e5
[  373.671599]  ? rcu_lock_release+0x1d/0x1d
[  373.676103]  ? audit_take_context+0x3c4/0x50e
[  373.680986]  ? __audit_syscall_exit+0x554/0x6cb
[  373.686074]  ? trace_irq_enable_rcuidle+0x75/0x228
[  373.691469]  ? __audit_free+0x549/0x549
[  373.695808]  ? prepare_exit_to_usermode+0x20a/0x2e0
[  373.701284]  ? print_irqtrace_events+0x223/0x223
[  373.706472]  ? trace_irq_disable_rcuidle+0x75/0x228
[  373.711941]  ? trace_hardirqs_off+0x3f/0x3f
[  373.716637]  prepare_exit_to_usermode+0x230/0x2e0
[  373.721919]  syscall_return_slowpath+0x12f/0x66e
[  373.727100]  ? prepare_exit_to_usermode+0x2e0/0x2e0
[  373.732574]  ? __ia32_compat_sys_futex+0x2d7/0x331
[  373.737940]  ? trace_hardirqs_on_thunk+0x1a/0x1c
[  373.743124]  ? __ia32_compat_sys_get_robust_list+0x26c/0x26c
[  373.749475]  ? do_int80_syscall_32+0x25/0x175
[  373.754380]  ? print_irqtrace_events+0x223/0x223
[  373.759566]  ? do_int80_syscall_32+0x108/0x175
[  373.764547]  entry_INT80_compat+0x87/0xa0
[  373.769053] appEventThread  D    0  8035   2347 0xa0020080
[  373.775229] Call Trace:
[  373.778127]  ? __schedule+0x1308/0x1c2f
[  373.782451]  ? is_mmconf_reserved+0x3bf/0x3bf
[  373.787361]  ? __might_sleep+0x4a/0xfc
[  373.791583]  schedule+0x112/0x13c
[  373.795356]  exit_mm+0x351/0x5e5
[  373.798984]  ? do_exit+0x229b/0x229b
[  373.803001]  ? do_exit+0xf36/0x229b
[  373.806901]  do_exit+0x5b2/0x229b
[  373.810629]  ? trace_irq_enable_rcuidle+0x75/0x228
[  373.816021]  ? will_become_orphaned_pgrp+0x22f/0x22f
[  373.821587]  ? lock_acquire+0x377/0x4aa
[  373.825909]  ? trace_hardirqs_on+0x3f/0x3f
[  373.830541]  ? _raw_spin_unlock_irq+0x83/0x100
[  373.835532]  ? print_irqtrace_events+0x223/0x223
[  373.840716]  ? _raw_spin_unlock_irq+0x83/0x100
[  373.845709]  do_group_exit+0x225/0x260
[  373.849921]  get_signal+0x3f1/0x179e
[  373.853938]  ? lock_acquire+0x4aa/0x4aa
[  373.858254]  ? ptrace_do_notify+0x2c8/0x2c8
[  373.862941]  ? rcu_lock_release+0x4/0x1d
[  373.867349]  ? __lock_acquire+0x41fb/0x41fb
[  373.872045]  ? do_signal+0xd9/0x114a
[  373.876059]  do_signal+0xd9/0x114a
[  373.879882]  ? audit_filter_inodes+0x365/0x3d5
[  373.884873]  ? signal_fault+0x1e5/0x1e5
[  373.889175]  ? rcu_lock_release+0x1d/0x1d
[  373.893679]  ? audit_take_context+0x3c4/0x50e
[  373.898570]  ? __audit_syscall_exit+0x554/0x6cb
[  373.903814]  ? trace_irq_enable_rcuidle+0x75/0x228
[  373.909191]  ? __audit_free+0x549/0x549
[  373.913516]  ? prepare_exit_to_usermode+0x20a/0x2e0
[  373.918991]  ? print_irqtrace_events+0x223/0x223
[  373.924173]  ? trace_irq_disable_rcuidle+0x75/0x228
[  373.929645]  ? trace_hardirqs_off+0x3f/0x3f
[  373.934355]  prepare_exit_to_usermode+0x230/0x2e0
[  373.939638]  syscall_return_slowpath+0x12f/0x66e
[  373.944815]  ? prepare_exit_to_usermode+0x2e0/0x2e0
[  373.950306]  ? __ia32_compat_sys_futex+0x2d7/0x331
[  373.955684]  ? trace_hardirqs_on_thunk+0x1a/0x1c
[  373.960860]  ? __ia32_compat_sys_get_robust_list+0x26c/0x26c
[  373.967220]  ? do_int80_syscall_32+0x25/0x175
[  373.972100]  ? print_irqtrace_events+0x223/0x223
[  373.977291]  ? do_int80_syscall_32+0x108/0x175
[  373.982281]  entry_INT80_compat+0x87/0xa0
[  373.986786] sfEventThread   D    0  8036   2347 0xa0020080
[  373.992942] Call Trace:
[  373.995695]  ? __schedule+0x1308/0x1c2f
[  374.000007]  ? is_mmconf_reserved+0x3bf/0x3bf
[  374.004898]  ? __might_sleep+0x4a/0xfc
[  374.009110]  schedule+0x112/0x13c
[  374.012830]  exit_mm+0x351/0x5e5
[  374.016484]  ? do_exit+0x229b/0x229b
[  374.020501]  ? do_exit+0xf36/0x229b
[  374.024418]  do_exit+0x5b2/0x229b
[  374.028148]  ? trace_irq_enable_rcuidle+0x75/0x228
[  374.033702]  ? will_become_orphaned_pgrp+0x22f/0x22f
[  374.039292]  ? lock_acquire+0x377/0x4aa
[  374.043617]  ? trace_hardirqs_on+0x3f/0x3f
[  374.048238]  ? _raw_spin_unlock_irq+0x83/0x100
[  374.053233]  ? print_irqtrace_events+0x223/0x223
[  374.058418]  ? _raw_spin_unlock_irq+0x83/0x100
[  374.063407]  do_group_exit+0x225/0x260
[  374.067612]  get_signal+0x3f1/0x179e
[  374.071619]  ? lock_acquire+0x4aa/0x4aa
[  374.075928]  ? ptrace_do_notify+0x2c8/0x2c8
[  374.080624]  ? rcu_lock_release+0x4/0x1d
[  374.085022]  ? __lock_acquire+0x41fb/0x41fb
[  374.089741]  ? do_signal+0xd9/0x114a
[  374.093789]  do_signal+0xd9/0x114a
[  374.097613]  ? audit_filter_inodes+0x365/0x3d5
[  374.102602]  ? signal_fault+0x1e5/0x1e5
[  374.106910]  ? rcu_lock_release+0x1d/0x1d
[  374.111415]  ? audit_take_context+0x3c4/0x50e
[  374.116307]  ? __audit_syscall_exit+0x554/0x6cb
[  374.121395]  ? trace_irq_enable_rcuidle+0x75/0x228
[  374.126773]  ? __audit_free+0x549/0x549
[  374.131079]  ? prepare_exit_to_usermode+0x20a/0x2e0
[  374.136557]  ? print_irqtrace_events+0x223/0x223
[  374.141730]  ? trace_irq_disable_rcuidle+0x75/0x228
[  374.147207]  ? trace_hardirqs_off+0x3f/0x3f
[  374.151896]  prepare_exit_to_usermode+0x230/0x2e0
[  374.157201]  syscall_return_slowpath+0x12f/0x66e
[  374.162589]  ? prepare_exit_to_usermode+0x2e0/0x2e0
[  374.168063]  ? __ia32_compat_sys_futex+0x2d7/0x331
[  374.173451]  ? trace_hardirqs_on_thunk+0x1a/0x1c
[  374.178652]  ? __ia32_compat_sys_get_robust_list+0x26c/0x26c
[  374.185001]  ? do_int80_syscall_32+0x25/0x175
[  374.189896]  ? print_irqtrace_events+0x223/0x223
[  374.195075]  ? do_int80_syscall_32+0x108/0x175
[  374.200065]  entry_INT80_compat+0x87/0xa0
[  374.204570] Binder:3211_3   D    0  8038   2347 0xa0020080
[  374.210721] Call Trace:
[  374.213479]  ? __schedule+0x1308/0x1c2f
[  374.217790]  ? is_mmconf_reserved+0x3bf/0x3bf
[  374.222685]  ? __might_sleep+0x4a/0xfc
[  374.226909]  schedule+0x112/0x13c
[  374.230635]  exit_mm+0x351/0x5e5
[  374.234246]  ? do_exit+0x229b/0x229b
[  374.238269]  ? do_exit+0xf36/0x229b
[  374.242225]  do_exit+0x5b2/0x229b
[  374.245951]  ? trace_irq_enable_rcuidle+0x75/0x228
[  374.251314]  ? will_become_orphaned_pgrp+0x22f/0x22f
[  374.256911]  ? lock_acquire+0x377/0x4aa
[  374.261214]  ? trace_hardirqs_on+0x3f/0x3f
[  374.265809]  ? _raw_spin_unlock_irq+0x83/0x100
[  374.270829]  ? print_irqtrace_events+0x223/0x223
[  374.276032]  ? _raw_spin_unlock_irq+0x83/0x100
[  374.281031]  do_group_exit+0x225/0x260
[  374.285264]  get_signal+0x3f1/0x179e
[  374.289282]  ? lock_acquire+0x4aa/0x4aa
[  374.293625]  ? ptrace_do_notify+0x2c8/0x2c8
[  374.298491]  ? rcu_lock_release+0x4/0x1d
[  374.302913]  ? __lock_acquire+0x41fb/0x41fb
[  374.307603]  do_signal+0xd9/0x114a
[  374.311437]  ? audit_filter_inodes+0x365/0x3d5
[  374.316462]  ? signal_fault+0x1e5/0x1e5
[  374.320771]  ? rcu_lock_release+0x1d/0x1d
[  374.325274]  ? audit_take_context+0x3c4/0x50e
[  374.330183]  ? __audit_syscall_exit+0x554/0x6cb
[  374.335263]  ? trace_irq_enable_rcuidle+0x75/0x228
[  374.340641]  ? __audit_free+0x549/0x549
[  374.344945]  ? prepare_exit_to_usermode+0x20a/0x2e0
[  374.350411]  ? print_irqtrace_events+0x223/0x223
[  374.355600]  ? trace_irq_disable_rcuidle+0x75/0x228
[  374.361109]  ? trace_hardirqs_off+0x3f/0x3f
[  374.365826]  prepare_exit_to_usermode+0x230/0x2e0
[  374.371113]  syscall_return_slowpath+0x12f/0x66e
[  374.376291]  ? fput+0x74/0x1d0
[  374.379722]  ? prepare_exit_to_usermode+0x2e0/0x2e0
[  374.385197]  ? do_syscall_64+0x120/0x120
[  374.389598]  ? security_file_ioctl+0x62/0x95
[  374.394409]  ? __ia32_compat_sys_ioctl+0x182f/0x2112
[  374.399985]  ? do_int80_syscall_32+0x108/0x175
[  374.404974]  entry_INT80_compat+0x87/0xa0
[  374.409479] crash_reporter  D    0  8043      2 0x00000080
[  374.415626] Call Trace:
[  374.418380]  ? __schedule+0x1308/0x1c2f
[  374.422698]  ? security_sb_umount+0x5a/0x89
[  374.427402]  ? is_mmconf_reserved+0x3bf/0x3bf
[  374.432479]  ? do_wait_for_common+0x381/0x5c2
[  374.437379]  ? trace_irq_enable_rcuidle+0x75/0x228
[  374.442759]  schedule+0x112/0x13c
[  374.446491]  schedule_timeout+0xa1/0x20d
[  374.450897]  ? console_conditional_schedule+0x29/0x29
[  374.456576]  ? _raw_spin_unlock_irq+0x83/0x100
[  374.461576]  ? _raw_spin_unlock_irqrestore+0x12e/0x12e
[  374.467370]  ? trace_irq_enable_rcuidle+0x75/0x228
[  374.472762]  ? avc_has_perm_noaudit+0x233/0x290
[  374.477863]  ? lock_downgrade+0x60a/0x60a
[  374.482385]  ? trace_hardirqs_on+0x3f/0x3f
[  374.487016]  ? __call_rcu+0x286/0x547
[  374.491142]  do_wait_for_common+0x391/0x5c2
[  374.495847]  ? console_conditional_schedule+0x29/0x29
[  374.501525]  ? wait_for_completion_killable_timeout+0x5f/0x5f
[  374.507992]  ? do_task_dead+0xb8/0xb8
[  374.512120]  ? invoke_rcu_core+0xdf/0xdf
[  374.516546]  ? umount_tree+0x7de/0xaad
[  374.520768]  ? do_raw_spin_lock+0xbd/0x1e9
[  374.525378]  wait_for_completion+0x4c/0x58
[  374.529997]  __wait_rcu_gp+0x29e/0x2ba
[  374.534220]  synchronize_rcu+0x161/0x1b4
[  374.538634]  ? cond_synchronize_rcu+0x24/0x24
[  374.543539]  ? sync_rcu_exp_handler+0x14a/0x14a
[  374.548637]  ? __lock_acquire+0x40fe/0x41fb
[  374.553345]  ? _raw_spin_unlock+0x7e/0xfa
[  374.557857]  ? rcu_read_lock_bh_held+0x1d8/0x1d8
[  374.563205]  namespace_unlock+0x11a/0x129
[  374.567710]  ? umount_tree+0xaad/0xaad
[  374.571936]  ? do_raw_spin_lock+0xbd/0x1e9
[  374.576540]  ? __x64_sys_umount+0x5a/0x63
[  374.581051]  ksys_umount+0xc68/0xcc6
[  374.585075]  ? kfree+0xe5/0x723
[  374.588612]  ? prepare_exit_to_usermode+0x2e0/0x2e0
[  374.594103]  ? namespace_unlock+0x129/0x129
[  374.598807]  ? trace_irq_enable_rcuidle+0x75/0x228
[  374.604216]  ? trace_hardirqs_off+0x3f/0x3f
[  374.608910]  ? trace_hardirqs_on_thunk+0x1a/0x1c
[  374.614122]  ? trace_hardirqs_on+0x3f/0x3f
[  374.618737]  ? do_syscall_64+0x28/0x120
[  374.623066]  ? print_irqtrace_events+0x223/0x223
[  374.628249]  __x64_sys_umount+0x5a/0x63
[  374.632550]  do_syscall_64+0xcd/0x120
[  374.636661]  entry_SYSCALL_64_after_hwframe+0x49/0xbe
[  374.642330] RIP: 0033:0x7a54d3c67e07
[  374.646341] Code: Bad RIP value.
[  374.649964] RSP: 002b:00007ffc2e494d38 EFLAGS: 00000286 ORIG_RAX:
00000000000000a6
[  374.658472] RAX: ffffffffffffffda RBX: 0000000000000003 RCX: 00007a54d3c67e07
[  374.666467] RDX: 000056b8fed1d1a0 RSI: 0000000000000002 RDI: 00007a54d434c661
[  374.674470] RBP: 00007ffc2e494dd0 R08: 0000000000000000 R09: 0000000000000000
[  374.682472] R10: 000000000000102f R11: 0000000000000286 R12: 0000000000000012
[  374.690485] R13: 00007ffc2e495a21 R14: 000056b8fed1cb50 R15: 000056b8fed1c7b0
[  374.698685] NMI backtrace for cpu 1
[  374.702724] CPU: 1 PID: 57 Comm: khungtaskd Not tainted 4.19.37 #8
[  374.719785] Call Trace:
[  374.722526]  dump_stack+0x122/0x1b5
[  374.726433]  ? arch_trigger_cpumask_backtrace+0x16/0x16
[  374.732297]  ? log_buf_vmcoreinfo_setup+0x131/0x131
[  374.737761]  ? swake_up_locked+0x75/0x139
[  374.742264]  ? show_regs_print_info+0x5/0x5
[  374.746958]  ? rcu_read_unlock_special+0x909/0xac8
[  374.752322]  nmi_cpu_backtrace+0xf7/0x197
[  374.756820]  ? nmi_trigger_cpumask_backtrace+0x2f2/0x2f2
[  374.762785]  ? rcu_lock_release+0x4/0x1d
[  374.767185]  ? arch_trigger_cpumask_backtrace+0x16/0x16
[  374.773043]  nmi_trigger_cpumask_backtrace+0x186/0x2f2
[  374.778804]  ? uevent_net_rcv_skb+0x3c1/0x3c1
[  374.783689]  ? __rcu_read_unlock+0xb7/0x141
[  374.788380]  ? show_state_filter+0x265/0x2e4
[  374.793162]  watchdog+0xeb0/0xec3
[  374.796884]  ? hungtask_pm_notify+0x25/0x25
[  374.801604]  ? _raw_spin_unlock+0xfa/0xfa
[  374.806093]  ? __kthread_parkme+0xc9/0x145
[  374.810690]  ? hungtask_pm_notify+0x25/0x25
[  374.815392]  kthread+0x34e/0x35e
[  374.819018]  ? hungtask_pm_notify+0x25/0x25
[  374.823711]  ? kthread_blkcg+0xa2/0xa2
[  374.827918]  ret_from_fork+0x24/0x50
[  374.832107] Sending NMI from CPU 1 to CPUs 0,2-7:
[  374.837425] NMI backtrace for cpu 0 skipped: idling at intel_idle+0x196/0x259
[  374.837427] NMI backtrace for cpu 2 skipped: idling at intel_idle+0x196/0x259
[  374.837497] NMI backtrace for cpu 4 skipped: idling at intel_idle+0x196/0x259
[  374.837499] NMI backtrace for cpu 5 skipped: idling at intel_idle+0x196/0x259
[  374.837501] NMI backtrace for cpu 6 skipped: idling at intel_idle+0x196/0x259
[  374.837503] NMI backtrace for cpu 7 skipped: idling at intel_idle+0x196/0x259
[  374.837523] NMI backtrace for cpu 3
[  374.837524] CPU: 3 PID: 116 Comm: kworker/u16:2 Not tainted 4.19.37 #8
[  374.837525] Workqueue: i915 __sleep_work
[  374.837527] RIP: 0010:qlist_move_cache+0x75/0x110
[  374.837544] Code: d0 4c 8d 58 08 48 8d 40 10 48 89 45 c8 49 bc 00
00 00 80 7f 77 00 00 eb 0b 4c 89 f7 eb 64 48 8b 7d d0 eb 73 48 89 d8
48 8b 1b <4c> 89 e1 48 be ff ff ff 7f ff ff ff ff 48 39 f0 76 08 48 8b
0c 25
[  374.837545] RSP: 0018:ffff88840701fb20 EFLAGS: 00000086
[  374.837546] RAX: ffff8883458b8388 RBX: ffff8883458baa08 RCX: 00000000000001c0
[  374.837549] RDX: ffff888408a3a140 RSI: 0000000000000000 RDI: ffff8883458ba848
[  374.837550] RBP: ffff88840701fb58 R08: ffffea0000000000 R09: ffffffff84e92a10
[  374.837552] R10: ffffffff84e92a10 R11: ffff88840701fb70 R12: 0000777f80000000
[  374.837554] R13: ffffffff84e92a08 R14: ffffffff84e92a00 R15: ffffffff84e92a08
[  374.837556] FS:  0000000000000000(0000) GS:ffff88840ecc0000(0000)
knlGS:0000000000000000
[  374.837558] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[  374.837560] CR2: 00000000def78ffc CR3: 0000000003c26003 CR4: 00000000003606e0
[  374.837562] Call Trace:
[  374.837564]  quarantine_remove_cache+0x74/0xfa
[  374.837566]  kmem_cache_shrink+0x1a/0x2e
[  374.837568]  __sleep_work+0xcc/0x1ab
[  374.837570]  process_one_work+0x90b/0x11b6
[  374.837572]  ? worker_detach_from_pool+0x1fa/0x1fa
[  374.837574]  ? is_mmconf_reserved+0x3bf/0x3bf
[  374.837577]  ? lock_downgrade+0x60a/0x60a
[  374.837578]  ? trace_irq_disable_rcuidle+0x75/0x228
[  374.837580]  ? lockdep_hardirqs_on+0x6d8/0x6d8
[  374.837582]  ? _raw_spin_unlock_irq+0x83/0x100
[  374.837584]  ? do_raw_spin_lock+0xbd/0x1e9
[  374.837586]  worker_thread+0xad5/0xdcc
[  374.837588]  ? pr_cont_work+0xe6/0xe6
[  374.837590]  kthread+0x34e/0x35e
[  374.837592]  ? pr_cont_work+0xe6/0xe6
[  374.837594]  ? kthread_blkcg+0xa2/0xa2
[  374.837596]  ret_from_fork+0x24/0x50
[  374.838582] Kernel panic - not syncing: hung_task: blocked tasks
[  375.093158] CPU: 1 PID: 57 Comm: khungtaskd Not tainted 4.19.37 #8
[  375.110218] Call Trace:
[  375.112968]  dump_stack+0x122/0x1b5
[  375.116881]  ? log_buf_vmcoreinfo_setup+0x131/0x131
[  375.122351]  ? show_regs_print_info+0x5/0x5
[  375.127044]  panic+0x1af/0x3c0
[  375.130470]  ? nmi_panic+0x6f/0x6f
[  375.134287]  ? __rcu_read_unlock+0xb7/0x141
[  375.138976]  ? show_state_filter+0x265/0x2e4
[  375.143766]  watchdog+0xec3/0xec3
[  375.147485]  ? hungtask_pm_notify+0x25/0x25
[  375.152169]  ? _raw_spin_unlock+0xfa/0xfa
[  375.156689]  ? __kthread_parkme+0xc9/0x145
[  375.161308]  ? hungtask_pm_notify+0x25/0x25
[  375.165994]  kthread+0x34e/0x35e
[  375.169616]  ? hungtask_pm_notify+0x25/0x25
[  375.174305]  ? kthread_blkcg+0xa2/0xa2
[  375.178499]  ret_from_fork+0x24/0x50
PANIC: hung_task: blocked tasks
