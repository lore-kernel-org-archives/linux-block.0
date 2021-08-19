Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E2AF4C4338F
	for <linux-block@archiver.kernel.org>; Thu, 19 Aug 2021 14:24:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B78A5610FA
	for <linux-block@archiver.kernel.org>; Thu, 19 Aug 2021 14:24:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238536AbhHSOYs (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 19 Aug 2021 10:24:48 -0400
Received: from www262.sakura.ne.jp ([202.181.97.72]:56354 "EHLO
        www262.sakura.ne.jp" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238613AbhHSOYr (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 19 Aug 2021 10:24:47 -0400
Received: from fsav314.sakura.ne.jp (fsav314.sakura.ne.jp [153.120.85.145])
        by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTP id 17JENd0P075522;
        Thu, 19 Aug 2021 23:23:40 +0900 (JST)
        (envelope-from penguin-kernel@i-love.sakura.ne.jp)
Received: from www262.sakura.ne.jp (202.181.97.72)
 by fsav314.sakura.ne.jp (F-Secure/fsigk_smtp/550/fsav314.sakura.ne.jp);
 Thu, 19 Aug 2021 23:23:39 +0900 (JST)
X-Virus-Status: clean(F-Secure/fsigk_smtp/550/fsav314.sakura.ne.jp)
Received: from [192.168.1.9] (M106072142033.v4.enabler.ne.jp [106.72.142.33])
        (authenticated bits=0)
        by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTPSA id 17JENcCI075515
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NO);
        Thu, 19 Aug 2021 23:23:39 +0900 (JST)
        (envelope-from penguin-kernel@i-love.sakura.ne.jp)
Subject: Re: [PATCH v4] block: genhd: don't call probe function with
 major_names_lock held
To:     Christoph Hellwig <hch@lst.de>
Cc:     Jens Axboe <axboe@kernel.dk>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Hannes Reinecke <hare@suse.de>,
        Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>,
        Hillf Danton <hdanton@sina.com>,
        Desmond Cheong Zhi Xi <desmondcheongzx@gmail.com>,
        linux-block <linux-block@vger.kernel.org>,
        Greg KH <gregkh@linuxfoundation.org>,
        Tyler Hicks <tyhicks@linux.microsoft.com>,
        Pavel Tatashin <pasha.tatashin@soleen.com>
References: <f790f8fb-5758-ea4e-a527-0ee4af82dd44@i-love.sakura.ne.jp>
 <4e153910-bf60-2cca-fa02-b46d22b6e2c5@i-love.sakura.ne.jp>
 <YRi9EQJqfK6ldrZG@kroah.com>
 <a3f43d54-8d10-3272-1fbb-1193d9f1b6dd@i-love.sakura.ne.jp>
 <YRjcHJE0qEIIJ9gA@kroah.com>
 <d7d31bf1-33d3-b817-0ce3-943e6835de33@i-love.sakura.ne.jp>
 <20210818134752.GA7453@lst.de>
 <1f4218ca-9bfa-7d80-1c69-f5902715d8d9@i-love.sakura.ne.jp>
 <20210819091941.GB12883@lst.de>
From:   Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>
Message-ID: <1668a287-091b-4a4b-01c9-e0fa8740ce9d@i-love.sakura.ne.jp>
Date:   Thu, 19 Aug 2021 23:23:36 +0900
User-Agent: Mozilla/5.0 (Windows NT 6.3; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <20210819091941.GB12883@lst.de>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 2021/08/19 18:19, Christoph Hellwig wrote:
> On Wed, Aug 18, 2021 at 11:34:15PM +0900, Tetsuo Handa wrote:
>> I posted "[PATCH] loop: break loop_ctl_mutex into loop_idr_spinlock and loop_removal_mutex"
> 
> Well, you hid it somewhere deep inside a mail deep in a thread.  If you
> want proper patch review and actually post it as a patch.

I didn't paste it for review. I pasted it only for demonstrating how complicated
it is if we try to address this circular locking problem on the loop module side.

> 
>> which reduces the locking complexity while fixing bugs, but you ignored it. Instead,
> 
> No, it doesn't.  Adding even more locks does not reduce complexity.

I guess that my and your terminology are incompatible.

> 
>> you decided to remove cryptoloop module (where userspace doing "modprobe cryptoloop"
>> will break).
> 
> Did you try it?

No, I didn't. I concluded that this series does not worth trying as soon as
I looked at how your series tries to address and found failing badly.

>                  Because on my system it works just fine thanks to
> the MODULE_ALIAS().

OK, I didn't realize that your series contained MODULE_ALIAS("cryptoloop") line
because I looked only loop add/remove/lookup part and found three bugs.

Strictly speaking, adding MODULE_ALIAS("cryptoloop") might still break userspace.
See the return code difference of "rmmod cryptoloop" shown in below example.

Before your series:
----------------------------------------
root@fuzz:~# truncate -s 16M /tmp/file
root@fuzz:~# modprobe loop
root@fuzz:~# lsmod | grep loop
loop                   40960  0
root@fuzz:~# losetup /dev/loop0 /tmp/file
root@fuzz:~# lsmod | grep loop
loop                   40960  1
root@fuzz:~# modprobe cryptoloop
root@fuzz:~# lsmod | grep loop
cryptoloop             16384  0
loop                   40960  2 cryptoloop
root@fuzz:~# rmmod cryptoloop
root@fuzz:~# lsmod | grep loop
loop                   40960  1
----------------------------------------

After your series:
----------------------------------------
root@fuzz:~# truncate -s 16M /tmp/file
root@fuzz:~# modprobe loop
root@fuzz:~# lsmod | grep loop
loop                   40960  0
root@fuzz:~# losetup /dev/loop0 /tmp/file
root@fuzz:~# lsmod | grep loop
loop                   40960  1
root@fuzz:~# modprobe cryptoloop
root@fuzz:~# lsmod | grep loop
loop                   40960  1
root@fuzz:~# rmmod cryptoloop
rmmod: ERROR: Module cryptoloop is not currently loaded
root@fuzz:~# echo $?
1
root@fuzz:~# lsmod | grep loop
loop                   40960  1
----------------------------------------

If userspace is expecting that "rmmod cryptoloop" succeeds, this is a breakage.

Anyway, I tried your series, and below is the result of your series.

----------------------------------------
fuzz login: [   46.957802][ T6638] loop0: detected capacity change from 0 to 4096
[   46.963189][ T6638] EXT4-fs error (device loop0): ext4_fill_super:4956: inode #2: comm a.out: iget: root inode unallocated
[   46.969001][ T6638] EXT4-fs (loop0): get root inode failed
[   46.972008][ T6638] EXT4-fs (loop0): mount failed
[   47.001030][ T6613] sysfs: cannot create duplicate filename '/devices/virtual/block/loop1'
[   47.005448][ T6613] CPU: 2 PID: 6613 Comm: systemd-udevd Tainted: G            E     5.14.0-rc6+ #747
[   47.009769][ T6613] Hardware name: VMware, Inc. VMware Virtual Platform/440BX Desktop Reference Platform, BIOS 6.00 02/27/2020
[   47.014951][ T6613] Call Trace:
[   47.016418][ T6613]  dump_stack_lvl+0x57/0x7d
[   47.018735][ T6613]  sysfs_warn_dup.cold+0x17/0x24
[   47.021035][ T6613]  sysfs_create_dir_ns+0xb7/0xd0
[   47.023299][ T6613]  kobject_add_internal+0xa8/0x290
[   47.025396][ T6613]  kobject_add+0x7e/0xb0
[   47.027276][ T6613]  device_add+0x11d/0x910
[   47.029380][ T6613]  ? dev_set_name+0x4e/0x70
[   47.032238][ T6613]  __device_add_disk+0xbf/0x300
[   47.034167][ T6613]  ? blkdev_get_by_dev+0x330/0x330
[   47.037066][ T6613]  loop_add+0x292/0x320 [loop]
[   47.038716][ T6613]  blk_request_module+0x63/0xc0
[   47.040340][ T6613]  blkdev_get_no_open+0x98/0xc0
[   47.041969][ T6613]  blkdev_get_by_dev+0x54/0x330
[   47.043630][ T6613]  ? blkdev_get_by_dev+0x330/0x330
[   47.045431][ T6613]  blkdev_open+0x59/0xa0
[   47.046944][ T6613]  do_dentry_open+0x14c/0x3a0
[   47.048560][ T6613]  path_openat+0x78e/0xa50
[   47.050129][ T6613]  do_filp_open+0xad/0x120
[   47.051625][ T6613]  ? alloc_fd+0x14c/0x1f0
[   47.053085][ T6613]  do_sys_openat2+0x241/0x310
[   47.054698][ T6613]  do_sys_open+0x3f/0x80
[   47.056133][ T6613]  do_syscall_64+0x35/0xb0
[   47.057612][ T6613]  entry_SYSCALL_64_after_hwframe+0x44/0xae
[   47.059613][ T6613] RIP: 0033:0x7f8f168c7eab
[   47.061137][ T6613] Code: 25 00 00 41 00 3d 00 00 41 00 74 4b 64 8b 04 25 18 00 00 00 85 c0 75 67 44 89 e2 48 89 ee bf 9c ff ff ff b8 01 01 00 00 0f 05 <48> 3d 00 f0 ff ff 0f 87 91 00 00 00 48 8b 4c 24 28 64 48 33 0c 25
[   47.067845][ T6613] RSP: 002b:00007ffeb2e28d60 EFLAGS: 00000246 ORIG_RAX: 0000000000000101
[   47.070689][ T6613] RAX: ffffffffffffffda RBX: 000055714bba6d20 RCX: 00007f8f168c7eab
[   47.073379][ T6613] RDX: 00000000000a0800 RSI: 000055714bd070e0 RDI: 00000000ffffff9c
[   47.076091][ T6613] RBP: 000055714bd070e0 R08: 000055714b782270 R09: 00007ffeb2fe3090
[   47.078974][ T6613] R10: 0000000000000000 R11: 0000000000000246 R12: 00000000000a0800
[   47.081669][ T6613] R13: 0000000000000000 R14: 0000000000000001 R15: 0000000000000000
[   47.085863][ T6613] kobject_add_internal failed for loop1 with -EEXIST, don't try to register things with the same name in the same directory.
[   47.090403][ T6613] kobject_add_internal failed for queue (error: -2 parent: loop1)
[   47.093848][ T6613] kobject_add_internal failed for integrity (error: -2 parent: loop1)
[   47.108619][ T6612] 
[   47.109437][ T6612] ======================================================
[   47.111786][ T6612] WARNING: possible circular locking dependency detected
[   47.114178][ T6612] 5.14.0-rc6+ #747 Tainted: G            E    
[   47.116181][ T6612] ------------------------------------------------------
[   47.118489][ T6612] systemd-udevd/6612 is trying to acquire lock:
[   47.120548][ T6612] ffff88801b875948 ((wq_completion)loop0){+.+.}-{0:0}, at: flush_workqueue+0x85/0x560
[   47.123687][ T6612] 
[   47.123687][ T6612] but task is already holding lock:
[   47.126176][ T6612] ffff88800cdfbc88 (&lo->lo_mutex){+.+.}-{3:3}, at: __loop_clr_fd+0x5b/0x610 [loop]
[   47.129415][ T6612] 
[   47.129415][ T6612] which lock already depends on the new lock.
[   47.129415][ T6612] 
[   47.132788][ T6612] 
[   47.132788][ T6612] the existing dependency chain (in reverse order) is:
[   47.135661][ T6612] 
[   47.135661][ T6612] -> #6 (&lo->lo_mutex){+.+.}-{3:3}:
[   47.138051][ T6612]        lock_acquire+0xd0/0x300
[   47.139625][ T6612]        __mutex_lock+0x97/0x950
[   47.141566][ T6612]        loop_control_ioctl+0x10a/0x1b0 [loop]
[   47.143602][ T6612]        __x64_sys_ioctl+0x6a/0xa0
[   47.145473][ T6612]        do_syscall_64+0x35/0xb0
[   47.147054][ T6612]        entry_SYSCALL_64_after_hwframe+0x44/0xae
[   47.149295][ T6612] 
[   47.149295][ T6612] -> #5 (loop_ctl_mutex){+.+.}-{3:3}:
[   47.151671][ T6612]        lock_acquire+0xd0/0x300
[   47.153206][ T6612]        __mutex_lock+0x97/0x950
[   47.154698][ T6612]        loop_add+0x43/0x320 [loop]
[   47.156471][ T6612]        blk_request_module+0x63/0xc0
[   47.158153][ T6612]        blkdev_get_no_open+0x98/0xc0
[   47.159848][ T6612]        blkdev_get_by_dev+0x54/0x330
[   47.161721][ T6612]        blkdev_open+0x59/0xa0
[   47.163292][ T6612]        do_dentry_open+0x14c/0x3a0
[   47.165028][ T6612]        path_openat+0x78e/0xa50
[   47.166629][ T6612]        do_filp_open+0xad/0x120
[   47.168341][ T6612]        do_sys_openat2+0x241/0x310
[   47.169956][ T6612]        do_sys_open+0x3f/0x80
[   47.171463][ T6612]        do_syscall_64+0x35/0xb0
[   47.172980][ T6612]        entry_SYSCALL_64_after_hwframe+0x44/0xae
[   47.174897][ T6612] 
[   47.174897][ T6612] -> #4 (major_names_lock){+.+.}-{3:3}:
[   47.177271][ T6612]        lock_acquire+0xd0/0x300
[   47.178930][ T6612]        __mutex_lock+0x97/0x950
[   47.180514][ T6612]        blkdev_show+0x18/0x90
[   47.181961][ T6612]        devinfo_show+0x58/0x70
[   47.183489][ T6612]        seq_read_iter+0x27b/0x3f0
[   47.185044][ T6612]        proc_reg_read_iter+0x3c/0x60
[   47.186665][ T6612]        new_sync_read+0x110/0x190
[   47.188268][ T6612]        vfs_read+0x11d/0x1b0
[   47.189661][ T6612]        ksys_read+0x63/0xe0
[   47.191162][ T6612]        do_syscall_64+0x35/0xb0
[   47.192745][ T6612]        entry_SYSCALL_64_after_hwframe+0x44/0xae
[   47.194831][ T6612] 
[   47.194831][ T6612] -> #3 (&p->lock){+.+.}-{3:3}:
[   47.196966][ T6612]        lock_acquire+0xd0/0x300
[   47.198445][ T6612]        __mutex_lock+0x97/0x950
[   47.200160][ T6612]        seq_read_iter+0x4c/0x3f0
[   47.201690][ T6612]        generic_file_splice_read+0xf7/0x1a0
[   47.203512][ T6612]        splice_direct_to_actor+0xc0/0x230
[   47.205258][ T6612]        do_splice_direct+0x8c/0xd0
[   47.206811][ T6612]        do_sendfile+0x319/0x5a0
[   47.208264][ T6612]        __x64_sys_sendfile64+0xad/0xc0
[   47.209870][ T6612]        do_syscall_64+0x35/0xb0
[   47.211670][ T6612]        entry_SYSCALL_64_after_hwframe+0x44/0xae
[   47.213551][ T6612] 
[   47.213551][ T6612] -> #2 (sb_writers#3){.+.+}-{0:0}:
[   47.215827][ T6612]        lock_acquire+0xd0/0x300
[   47.217277][ T6612]        lo_write_bvec+0xe1/0x260 [loop]
[   47.218964][ T6612]        loop_process_work+0x3fa/0xcf0 [loop]
[   47.220716][ T6612]        process_one_work+0x2aa/0x600
[   47.222343][ T6612]        worker_thread+0x48/0x3d0
[   47.223796][ T6612]        kthread+0x13e/0x170
[   47.225124][ T6612]        ret_from_fork+0x1f/0x30
[   47.226605][ T6612] 
[   47.226605][ T6612] -> #1 ((work_completion)(&lo->rootcg_work)){+.+.}-{0:0}:
[   47.229563][ T6612]        lock_acquire+0xd0/0x300
[   47.231200][ T6612]        process_one_work+0x27e/0x600
[   47.232784][ T6612]        worker_thread+0x48/0x3d0
[   47.234372][ T6612]        kthread+0x13e/0x170
[   47.235704][ T6612]        ret_from_fork+0x1f/0x30
[   47.237136][ T6612] 
[   47.237136][ T6612] -> #0 ((wq_completion)loop0){+.+.}-{0:0}:
[   47.239544][ T6612]        check_prev_add+0x91/0xc00
[   47.241026][ T6612]        __lock_acquire+0x14a8/0x1f40
[   47.242661][ T6612]        lock_acquire+0xd0/0x300
[   47.244133][ T6612]        flush_workqueue+0xa9/0x560
[   47.246009][ T6612]        drain_workqueue+0x9b/0x100
[   47.247518][ T6612]        destroy_workqueue+0x2f/0x210
[   47.249094][ T6612]        __loop_clr_fd+0xbf/0x610 [loop]
[   47.251016][ T6612]        blkdev_put+0xaf/0x180
[   47.252421][ T6612]        blkdev_close+0x20/0x30
[   47.253942][ T6612]        __fput+0xa0/0x240
[   47.255221][ T6612]        task_work_run+0x57/0xa0
[   47.256649][ T6612]        exit_to_user_mode_prepare+0x252/0x260
[   47.258572][ T6612]        syscall_exit_to_user_mode+0x19/0x60
[   47.260300][ T6612]        do_syscall_64+0x42/0xb0
[   47.262051][ T6612]        entry_SYSCALL_64_after_hwframe+0x44/0xae
[   47.263923][ T6612] 
[   47.263923][ T6612] other info that might help us debug this:
[   47.263923][ T6612] 
[   47.267105][ T6612] Chain exists of:
[   47.267105][ T6612]   (wq_completion)loop0 --> loop_ctl_mutex --> &lo->lo_mutex
[   47.267105][ T6612] 
[   47.271208][ T6612]  Possible unsafe locking scenario:
[   47.271208][ T6612] 
[   47.273524][ T6612]        CPU0                    CPU1
[   47.275232][ T6612]        ----                    ----
[   47.276848][ T6612]   lock(&lo->lo_mutex);
[   47.278416][ T6612]                                lock(loop_ctl_mutex);
[   47.280490][ T6612]                                lock(&lo->lo_mutex);
[   47.282600][ T6612]   lock((wq_completion)loop0);
[   47.284026][ T6612] 
[   47.284026][ T6612]  *** DEADLOCK ***
[   47.284026][ T6612] 
[   47.286474][ T6612] 2 locks held by systemd-udevd/6612:
[   47.288032][ T6612]  #0: ffff888009829128 (&disk->open_mutex){+.+.}-{3:3}, at: blkdev_put+0x30/0x180
[   47.290806][ T6612]  #1: ffff88800cdfbc88 (&lo->lo_mutex){+.+.}-{3:3}, at: __loop_clr_fd+0x5b/0x610 [loop]
[   47.293886][ T6612] 
[   47.293886][ T6612] stack backtrace:
[   47.295873][ T6612] CPU: 2 PID: 6612 Comm: systemd-udevd Tainted: G            E     5.14.0-rc6+ #747
[   47.298596][ T6612] Hardware name: VMware, Inc. VMware Virtual Platform/440BX Desktop Reference Platform, BIOS 6.00 02/27/2020
[   47.302078][ T6612] Call Trace:
[   47.303038][ T6612]  dump_stack_lvl+0x57/0x7d
[   47.304506][ T6612]  check_noncircular+0x114/0x130
[   47.305936][ T6612]  check_prev_add+0x91/0xc00
[   47.307261][ T6612]  ? __lock_acquire+0x5c1/0x1f40
[   47.308783][ T6612]  __lock_acquire+0x14a8/0x1f40
[   47.310184][ T6612]  lock_acquire+0xd0/0x300
[   47.311765][ T6612]  ? flush_workqueue+0x85/0x560
[   47.313256][ T6612]  ? lockdep_init_map_type+0x51/0x220
[   47.314828][ T6612]  ? lockdep_init_map_type+0x51/0x220
[   47.316459][ T6612]  flush_workqueue+0xa9/0x560
[   47.317824][ T6612]  ? flush_workqueue+0x85/0x560
[   47.319246][ T6612]  ? drain_workqueue+0x9b/0x100
[   47.320768][ T6612]  drain_workqueue+0x9b/0x100
[   47.322124][ T6612]  destroy_workqueue+0x2f/0x210
[   47.323753][ T6612]  __loop_clr_fd+0xbf/0x610 [loop]
[   47.325250][ T6612]  ? __mutex_unlock_slowpath+0x40/0x2a0
[   47.326855][ T6612]  blkdev_put+0xaf/0x180
[   47.328478][ T6612]  blkdev_close+0x20/0x30
[   47.329831][ T6612]  __fput+0xa0/0x240
[   47.330967][ T6612]  task_work_run+0x57/0xa0
[   47.332297][ T6612]  exit_to_user_mode_prepare+0x252/0x260
[   47.333979][ T6612]  syscall_exit_to_user_mode+0x19/0x60
[   47.335654][ T6612]  do_syscall_64+0x42/0xb0
[   47.336939][ T6612]  entry_SYSCALL_64_after_hwframe+0x44/0xae
[   47.338650][ T6612] RIP: 0033:0x7f8f168c8987
[   47.340034][ T6612] Code: ff ff e8 9c 11 02 00 66 2e 0f 1f 84 00 00 00 00 00 66 90 f3 0f 1e fa 64 8b 04 25 18 00 00 00 85 c0 75 10 b8 03 00 00 00 0f 05 <48> 3d 00 f0 ff ff 77 41 c3 48 83 ec 18 89 7c 24 0c e8 c3 5d f8 ff
[   47.346349][ T6612] RSP: 002b:00007ffeb2e28da8 EFLAGS: 00000246 ORIG_RAX: 0000000000000003
[   47.349015][ T6612] RAX: 0000000000000000 RBX: 00007f8f16350788 RCX: 00007f8f168c8987
[   47.351533][ T6612] RDX: 0000000000000000 RSI: 0000000000000000 RDI: 0000000000000006
[   47.353848][ T6612] RBP: 0000000000000006 R08: 000055714b78faf0 R09: 0000000000000000
[   47.356265][ T6612] R10: 00007f8f16350788 R11: 0000000000000246 R12: 0000000000000000
[   47.358566][ T6612] R13: 0000000000000000 R14: 0000000000000000 R15: 000055714b777635
[   47.366005][ T6642] loop0: detected capacity change from 0 to 4096
[   47.369917][ T6642] EXT4-fs error (device loop0): ext4_fill_super:4956: inode #2: comm a.out: iget: root inode unallocated
[   47.373415][ T6642] EXT4-fs (loop0): get root inode failed
[   47.375217][ T6642] EXT4-fs (loop0): mount failed
[   47.402986][ T6650] ------------[ cut here ]------------
[   47.404646][ T6650] kernfs: can not remove 'format', no directory
[   47.406571][ T6650] WARNING: CPU: 3 PID: 6650 at fs/kernfs/dir.c:1508 kernfs_remove_by_name_ns+0x6f/0x80
[   47.409418][ T6650] Modules linked in: loop(E)
[   47.411712][ T6650] CPU: 2 PID: 6650 Comm: a.out Tainted: G            E     5.14.0-rc6+ #747
[   47.414617][ T6650] Hardware name: VMware, Inc. VMware Virtual Platform/440BX Desktop Reference Platform, BIOS 6.00 02/27/2020
[   47.418279][ T6650] RIP: 0010:kernfs_remove_by_name_ns+0x6f/0x80
[   47.421282][ T6650] Code: bb 38 01 31 c0 5d 41 5c 41 5d c3 48 c7 c7 e0 7d 7d 83 e8 b4 bb 38 01 b8 fe ff ff ff eb e7 48 c7 c7 18 39 2a 83 e8 41 9a 29 01 <0f> 0b b8 fe ff ff ff eb d2 0f 1f 84 00 00 00 00 00 41 57 41 56 41
[   47.427371][ T6650] RSP: 0018:ffffc90001673df0 EFLAGS: 00010286
[   47.429782][ T6650] RAX: 0000000000000000 RBX: ffffffff83804c28 RCX: 0000000000000027
[   47.432268][ T6650] RDX: 0000000000000027 RSI: 00000000ffffdfff RDI: ffff88807d3e78b8
[   47.434731][ T6650] RBP: 0000000000000000 R08: ffff88807d3e78b0 R09: 0000000000000000
[   47.439351][ T6650] R10: 0000000000000001 R11: 0000000000000001 R12: ffffffff833d7a00
[   47.442188][ T6650] R13: 0000000000000001 R14: ffff888010cba340 R15: 0000000000000000
[   47.444833][ T6650] FS:  00007f2a594ce580(0000) GS:ffff88807ce00000(0000) knlGS:0000000000000000
[   47.447964][ T6650] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[   47.462680][ T6650] CR2: 00005651cf34e6b8 CR3: 0000000007541000 CR4: 00000000001506e0
[   47.465238][ T6650] Call Trace:
[   47.466194][ T6650]  remove_files.isra.0+0x2b/0x60
[   47.467659][ T6650]  sysfs_remove_group+0x38/0x80
[   47.469986][ T6650]  sysfs_remove_groups+0x24/0x40
[   47.471472][ T6650]  __kobject_del+0x1b/0x80
[   47.472828][ T6650]  kobject_del+0xf/0x20
[   47.474071][ T6650]  blk_integrity_del+0x1d/0x30
[   47.475524][ T6650]  del_gendisk+0x3c/0x1d0
[   47.476868][ T6650]  loop_remove+0x10/0x40 [loop]
[   47.478601][ T6650]  loop_control_ioctl+0x1a1/0x1b0 [loop]
[   47.480437][ T6650]  __x64_sys_ioctl+0x6a/0xa0
[   47.481816][ T6650]  do_syscall_64+0x35/0xb0
[   47.483135][ T6650]  entry_SYSCALL_64_after_hwframe+0x44/0xae
[   47.484923][ T6650] RIP: 0033:0x7f2a593f689d
[   47.486240][ T6650] Code: 00 c3 66 2e 0f 1f 84 00 00 00 00 00 90 f3 0f 1e fa 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 8b 0d c3 f5 0c 00 f7 d8 64 89 01 48
[   47.492220][ T6650] RSP: 002b:00007ffe1f075b78 EFLAGS: 00000246 ORIG_RAX: 0000000000000010
[   47.494945][ T6650] RAX: ffffffffffffffda RBX: 431bde82d7b634db RCX: 00007f2a593f689d
[   47.497417][ T6650] RDX: 0000000000000001 RSI: 0000000000004c81 RDI: 0000000000000005
[   47.499842][ T6650] RBP: 00007ffe1f075bb0 R08: 0000000000000000 R09: 0000000000000000
[   47.502165][ T6650] R10: 0000000000000000 R11: 0000000000000246 R12: 00007ffe1f075bb0
[   47.504530][ T6650] R13: 000000000000b44f R14: 00007ffe1f075b8c R15: 0000000000000000
[   47.506856][ T6650] irq event stamp: 0
[   47.508086][ T6650] hardirqs last  enabled at (0): [<0000000000000000>] 0x0
[   47.510206][ T6650] hardirqs last disabled at (0): [<ffffffff811262d4>] copy_process+0x984/0x2010
[   47.513225][ T6650] softirqs last  enabled at (0): [<ffffffff811262d4>] copy_process+0x984/0x2010
[   47.516142][ T6650] softirqs last disabled at (0): [<0000000000000000>] 0x0
[   47.518372][ T6650] ---[ end trace 864118b148d36438 ]---
[   47.520079][ T6650] ------------[ cut here ]------------
[   47.521683][ T6650] kernfs: can not remove 'tag_size', no directory
[   47.523607][ T6650] WARNING: CPU: 2 PID: 6650 at fs/kernfs/dir.c:1508 kernfs_remove_by_name_ns+0x6f/0x80
[   47.526414][ T6650] Modules linked in: loop(E)
[   47.527966][ T6650] CPU: 2 PID: 6650 Comm: a.out Tainted: G        W   E     5.14.0-rc6+ #747
[   47.530959][ T6650] Hardware name: VMware, Inc. VMware Virtual Platform/440BX Desktop Reference Platform, BIOS 6.00 02/27/2020
[   47.534391][ T6650] RIP: 0010:kernfs_remove_by_name_ns+0x6f/0x80
[   47.536288][ T6650] Code: bb 38 01 31 c0 5d 41 5c 41 5d c3 48 c7 c7 e0 7d 7d 83 e8 b4 bb 38 01 b8 fe ff ff ff eb e7 48 c7 c7 18 39 2a 83 e8 41 9a 29 01 <0f> 0b b8 fe ff ff ff eb d2 0f 1f 84 00 00 00 00 00 41 57 41 56 41
[   47.547625][ T6650] RSP: 0018:ffffc90001673df0 EFLAGS: 00010286
[   47.550209][ T6650] RAX: 0000000000000000 RBX: ffffffff83804c30 RCX: 0000000000000027
[   47.553838][ T6650] RDX: 0000000000000027 RSI: 00000000ffffdfff RDI: ffff88807cfe78b8
[   47.556561][ T6650] RBP: 0000000000000000 R08: ffff88807cfe78b0 R09: 0000000000000000
[   47.559190][ T6650] R10: 0000000000000001 R11: 0000000000000001 R12: ffffffff832b69c5
[   47.562085][ T6650] R13: 0000000000000001 R14: ffff888010cba340 R15: 0000000000000000
[   47.564588][ T6650] FS:  00007f2a594ce580(0000) GS:ffff88807ce00000(0000) knlGS:0000000000000000
[   47.567361][ T6650] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[   47.569384][ T6650] CR2: 00005651cf34e6b8 CR3: 0000000007541000 CR4: 00000000001506e0
[   47.571960][ T6650] Call Trace:
[   47.572947][ T6650]  remove_files.isra.0+0x2b/0x60
[   47.574474][ T6650]  sysfs_remove_group+0x38/0x80
[   47.575927][ T6650]  sysfs_remove_groups+0x24/0x40
[   47.577461][ T6650]  __kobject_del+0x1b/0x80
[   47.579167][ T6650]  kobject_del+0xf/0x20
[   47.580455][ T6650]  blk_integrity_del+0x1d/0x30
[   47.582019][ T6650]  del_gendisk+0x3c/0x1d0
[   47.583455][ T6650]  loop_remove+0x10/0x40 [loop]
[   47.584906][ T6650]  loop_control_ioctl+0x1a1/0x1b0 [loop]
[   47.586743][ T6650]  __x64_sys_ioctl+0x6a/0xa0
[   47.588213][ T6650]  do_syscall_64+0x35/0xb0
[   47.589643][ T6650]  entry_SYSCALL_64_after_hwframe+0x44/0xae
[   47.591405][ T6650] RIP: 0033:0x7f2a593f689d
[   47.592727][ T6650] Code: 00 c3 66 2e 0f 1f 84 00 00 00 00 00 90 f3 0f 1e fa 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 8b 0d c3 f5 0c 00 f7 d8 64 89 01 48
[   47.599154][ T6650] RSP: 002b:00007ffe1f075b78 EFLAGS: 00000246 ORIG_RAX: 0000000000000010
[   47.601767][ T6650] RAX: ffffffffffffffda RBX: 431bde82d7b634db RCX: 00007f2a593f689d
[   47.604170][ T6650] RDX: 0000000000000001 RSI: 0000000000004c81 RDI: 0000000000000005
[   47.606578][ T6650] RBP: 00007ffe1f075bb0 R08: 0000000000000000 R09: 0000000000000000
[   47.609213][ T6650] R10: 0000000000000000 R11: 0000000000000246 R12: 00007ffe1f075bb0
[   47.611959][ T6650] R13: 000000000000b44f R14: 00007ffe1f075b8c R15: 0000000000000000
[   47.614393][ T6650] irq event stamp: 0
[   47.615556][ T6650] hardirqs last  enabled at (0): [<0000000000000000>] 0x0
[   47.617786][ T6650] hardirqs last disabled at (0): [<ffffffff811262d4>] copy_process+0x984/0x2010
[   47.620581][ T6650] softirqs last  enabled at (0): [<ffffffff811262d4>] copy_process+0x984/0x2010
[   47.623221][ T6650] softirqs last disabled at (0): [<0000000000000000>] 0x0
[   47.625325][ T6650] ---[ end trace 864118b148d36439 ]---
[   47.626907][ T6650] ------------[ cut here ]------------
[   47.628950][ T6650] kernfs: can not remove 'protection_interval_bytes', no directory
[   47.631422][ T6650] WARNING: CPU: 2 PID: 6650 at fs/kernfs/dir.c:1508 kernfs_remove_by_name_ns+0x6f/0x80
[   47.634336][ T6650] Modules linked in: loop(E)
[   47.635703][ T6650] CPU: 2 PID: 6650 Comm: a.out Tainted: G        W   E     5.14.0-rc6+ #747
[   47.638354][ T6650] Hardware name: VMware, Inc. VMware Virtual Platform/440BX Desktop Reference Platform, BIOS 6.00 02/27/2020
[   47.643677][ T6650] RIP: 0010:kernfs_remove_by_name_ns+0x6f/0x80
[   47.645933][ T6650] Code: bb 38 01 31 c0 5d 41 5c 41 5d c3 48 c7 c7 e0 7d 7d 83 e8 b4 bb 38 01 b8 fe ff ff ff eb e7 48 c7 c7 18 39 2a 83 e8 41 9a 29 01 <0f> 0b b8 fe ff ff ff eb d2 0f 1f 84 00 00 00 00 00 41 57 41 56 41
[   47.651920][ T6650] RSP: 0018:ffffc90001673df0 EFLAGS: 00010286
[   47.653721][ T6650] RAX: 0000000000000000 RBX: ffffffff83804c38 RCX: 0000000000000027
[   47.656499][ T6650] RDX: 0000000000000027 RSI: 00000000ffffdfff RDI: ffff88807cfe78b8
[   47.659000][ T6650] RBP: 0000000000000000 R08: ffff88807cfe78b0 R09: 0000000000000000
[   47.661814][ T6650] R10: 0000000000000001 R11: 0000000000000001 R12: ffffffff832b69ab
[   47.664364][ T6650] R13: 0000000000000001 R14: ffff888010cba340 R15: 0000000000000000
[   47.666748][ T6650] FS:  00007f2a594ce580(0000) GS:ffff88807ce00000(0000) knlGS:0000000000000000
[   47.669505][ T6650] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[   47.671563][ T6650] CR2: 00005651cf34e6b8 CR3: 0000000007541000 CR4: 00000000001506e0
[   47.673942][ T6650] Call Trace:
[   47.674922][ T6650]  remove_files.isra.0+0x2b/0x60
[   47.676452][ T6650]  sysfs_remove_group+0x38/0x80
[   47.677970][ T6650]  sysfs_remove_groups+0x24/0x40
[   47.679790][ T6650]  __kobject_del+0x1b/0x80
[   47.681237][ T6650]  kobject_del+0xf/0x20
[   47.682481][ T6650]  blk_integrity_del+0x1d/0x30
[   47.684036][ T6650]  del_gendisk+0x3c/0x1d0
[   47.685432][ T6650]  loop_remove+0x10/0x40 [loop]
[   47.686948][ T6650]  loop_control_ioctl+0x1a1/0x1b0 [loop]
[   47.688652][ T6650]  __x64_sys_ioctl+0x6a/0xa0
[   47.690033][ T6650]  do_syscall_64+0x35/0xb0
[   47.691385][ T6650]  entry_SYSCALL_64_after_hwframe+0x44/0xae
[   47.693112][ T6650] RIP: 0033:0x7f2a593f689d
[   47.694393][ T6650] Code: 00 c3 66 2e 0f 1f 84 00 00 00 00 00 90 f3 0f 1e fa 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 8b 0d c3 f5 0c 00 f7 d8 64 89 01 48
[   47.700693][ T6650] RSP: 002b:00007ffe1f075b78 EFLAGS: 00000246 ORIG_RAX: 0000000000000010
[   47.703295][ T6650] RAX: ffffffffffffffda RBX: 431bde82d7b634db RCX: 00007f2a593f689d
[   47.705675][ T6650] RDX: 0000000000000001 RSI: 0000000000004c81 RDI: 0000000000000005
[   47.708199][ T6650] RBP: 00007ffe1f075bb0 R08: 0000000000000000 R09: 0000000000000000
[   47.710668][ T6650] R10: 0000000000000000 R11: 0000000000000246 R12: 00007ffe1f075bb0
[   47.713170][ T6650] R13: 000000000000b44f R14: 00007ffe1f075b8c R15: 0000000000000000
[   47.715608][ T6650] irq event stamp: 0
[   47.716815][ T6650] hardirqs last  enabled at (0): [<0000000000000000>] 0x0
[   47.719102][ T6650] hardirqs last disabled at (0): [<ffffffff811262d4>] copy_process+0x984/0x2010
[   47.721832][ T6650] softirqs last  enabled at (0): [<ffffffff811262d4>] copy_process+0x984/0x2010
[   47.724668][ T6650] softirqs last disabled at (0): [<0000000000000000>] 0x0
[   47.727010][ T6650] ---[ end trace 864118b148d3643a ]---
[   47.728848][ T6650] ------------[ cut here ]------------
[   47.730606][ T6650] kernfs: can not remove 'read_verify', no directory
[   47.732800][ T6650] WARNING: CPU: 2 PID: 6650 at fs/kernfs/dir.c:1508 kernfs_remove_by_name_ns+0x6f/0x80
[   47.735787][ T6650] Modules linked in: loop(E)
[   47.737179][ T6650] CPU: 2 PID: 6650 Comm: a.out Tainted: G        W   E     5.14.0-rc6+ #747
[   47.739905][ T6650] Hardware name: VMware, Inc. VMware Virtual Platform/440BX Desktop Reference Platform, BIOS 6.00 02/27/2020
[   47.743602][ T6650] RIP: 0010:kernfs_remove_by_name_ns+0x6f/0x80
[   47.745897][ T6650] Code: bb 38 01 31 c0 5d 41 5c 41 5d c3 48 c7 c7 e0 7d 7d 83 e8 b4 bb 38 01 b8 fe ff ff ff eb e7 48 c7 c7 18 39 2a 83 e8 41 9a 29 01 <0f> 0b b8 fe ff ff ff eb d2 0f 1f 84 00 00 00 00 00 41 57 41 56 41
[   47.752712][ T6650] RSP: 0018:ffffc90001673df0 EFLAGS: 00010286
[   47.754781][ T6650] RAX: 0000000000000000 RBX: ffffffff83804c40 RCX: 0000000000000027
[   47.757805][ T6650] RDX: 0000000000000027 RSI: 00000000ffffdfff RDI: ffff88807cfe78b8
[   47.760520][ T6650] RBP: 0000000000000000 R08: ffff88807cfe78b0 R09: 0000000000000000
[   47.763314][ T6650] R10: 0000000000000001 R11: 0000000000000001 R12: ffffffff832b699f
[   47.765957][ T6650] R13: 0000000000000001 R14: ffff888010cba340 R15: 0000000000000000
[   47.768742][ T6650] FS:  00007f2a594ce580(0000) GS:ffff88807ce00000(0000) knlGS:0000000000000000
[   47.771947][ T6650] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[   47.774165][ T6650] CR2: 00005651cf34e6b8 CR3: 0000000007541000 CR4: 00000000001506e0
[   47.776826][ T6650] Call Trace:
[   47.777929][ T6650]  remove_files.isra.0+0x2b/0x60
[   47.779816][ T6650]  sysfs_remove_group+0x38/0x80
[   47.781543][ T6650]  sysfs_remove_groups+0x24/0x40
[   47.783155][ T6650]  __kobject_del+0x1b/0x80
[   47.784479][ T6650]  kobject_del+0xf/0x20
[   47.785724][ T6650]  blk_integrity_del+0x1d/0x30
[   47.787259][ T6650]  del_gendisk+0x3c/0x1d0
[   47.788687][ T6650]  loop_remove+0x10/0x40 [loop]
[   47.790402][ T6650]  loop_control_ioctl+0x1a1/0x1b0 [loop]
[   47.792090][ T6650]  __x64_sys_ioctl+0x6a/0xa0
[   47.793511][ T6650]  do_syscall_64+0x35/0xb0
[   47.794943][ T6650]  entry_SYSCALL_64_after_hwframe+0x44/0xae
[   47.797167][ T6650] RIP: 0033:0x7f2a593f689d
[   47.798585][ T6650] Code: 00 c3 66 2e 0f 1f 84 00 00 00 00 00 90 f3 0f 1e fa 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 8b 0d c3 f5 0c 00 f7 d8 64 89 01 48
[   47.804763][ T6650] RSP: 002b:00007ffe1f075b78 EFLAGS: 00000246 ORIG_RAX: 0000000000000010
[   47.807396][ T6650] RAX: ffffffffffffffda RBX: 431bde82d7b634db RCX: 00007f2a593f689d
[   47.809802][ T6650] RDX: 0000000000000001 RSI: 0000000000004c81 RDI: 0000000000000005
[   47.812567][ T6650] RBP: 00007ffe1f075bb0 R08: 0000000000000000 R09: 0000000000000000
[   47.815142][ T6650] R10: 0000000000000000 R11: 0000000000000246 R12: 00007ffe1f075bb0
[   47.817622][ T6650] R13: 000000000000b44f R14: 00007ffe1f075b8c R15: 0000000000000000
[   47.820127][ T6650] irq event stamp: 0
[   47.821451][ T6650] hardirqs last  enabled at (0): [<0000000000000000>] 0x0
[   47.823604][ T6650] hardirqs last disabled at (0): [<ffffffff811262d4>] copy_process+0x984/0x2010
[   47.826320][ T6650] softirqs last  enabled at (0): [<ffffffff811262d4>] copy_process+0x984/0x2010
[   47.829671][ T6650] softirqs last disabled at (0): [<0000000000000000>] 0x0
[   47.831940][ T6650] ---[ end trace 864118b148d3643b ]---
[   47.833574][ T6650] ------------[ cut here ]------------
[   47.835257][ T6650] kernfs: can not remove 'write_generate', no directory
[   47.837521][ T6650] WARNING: CPU: 2 PID: 6650 at fs/kernfs/dir.c:1508 kernfs_remove_by_name_ns+0x6f/0x80
[   47.840695][ T6650] Modules linked in: loop(E)
[   47.842135][ T6650] CPU: 2 PID: 6650 Comm: a.out Tainted: G        W   E     5.14.0-rc6+ #747
[   47.844971][ T6650] Hardware name: VMware, Inc. VMware Virtual Platform/440BX Desktop Reference Platform, BIOS 6.00 02/27/2020
[   47.848917][ T6650] RIP: 0010:kernfs_remove_by_name_ns+0x6f/0x80
[   47.850797][ T6650] Code: bb 38 01 31 c0 5d 41 5c 41 5d c3 48 c7 c7 e0 7d 7d 83 e8 b4 bb 38 01 b8 fe ff ff ff eb e7 48 c7 c7 18 39 2a 83 e8 41 9a 29 01 <0f> 0b b8 fe ff ff ff eb d2 0f 1f 84 00 00 00 00 00 41 57 41 56 41
[   47.856857][ T6650] RSP: 0018:ffffc90001673df0 EFLAGS: 00010286
[   47.858698][ T6650] RAX: 0000000000000000 RBX: ffffffff83804c48 RCX: 0000000000000000
[   47.861422][ T6650] RDX: ffff88807cff7298 RSI: ffff88807cfe78b0 RDI: ffff88807cfe78b0
[   47.864174][ T6650] RBP: 0000000000000000 R08: ffff88807cfe78b0 R09: 0000000000000000
[   47.866632][ T6650] R10: 0000000000000001 R11: 0000000000000001 R12: ffffffff832b6990
[   47.869145][ T6650] R13: 0000000000000001 R14: ffff888010cba340 R15: 0000000000000000
[   47.871616][ T6650] FS:  00007f2a594ce580(0000) GS:ffff88807ce00000(0000) knlGS:0000000000000000
[   47.874333][ T6650] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[   47.876383][ T6650] CR2: 00005651cf34e6b8 CR3: 0000000007541000 CR4: 00000000001506e0
[   47.879038][ T6650] Call Trace:
[   47.880101][ T6650]  remove_files.isra.0+0x2b/0x60
[   47.881725][ T6650]  sysfs_remove_group+0x38/0x80
[   47.883177][ T6650]  sysfs_remove_groups+0x24/0x40
[   47.884789][ T6650]  __kobject_del+0x1b/0x80
[   47.886112][ T6650]  kobject_del+0xf/0x20
[   47.887475][ T6650]  blk_integrity_del+0x1d/0x30
[   47.889081][ T6650]  del_gendisk+0x3c/0x1d0
[   47.890460][ T6650]  loop_remove+0x10/0x40 [loop]
[   47.892233][ T6650]  loop_control_ioctl+0x1a1/0x1b0 [loop]
[   47.893923][ T6650]  __x64_sys_ioctl+0x6a/0xa0
[   47.895566][ T6650]  do_syscall_64+0x35/0xb0
[   47.896910][ T6650]  entry_SYSCALL_64_after_hwframe+0x44/0xae
[   47.898759][ T6650] RIP: 0033:0x7f2a593f689d
[   47.900215][ T6650] Code: 00 c3 66 2e 0f 1f 84 00 00 00 00 00 90 f3 0f 1e fa 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 8b 0d c3 f5 0c 00 f7 d8 64 89 01 48
[   47.906156][ T6650] RSP: 002b:00007ffe1f075b78 EFLAGS: 00000246 ORIG_RAX: 0000000000000010
[   47.908869][ T6650] RAX: ffffffffffffffda RBX: 431bde82d7b634db RCX: 00007f2a593f689d
[   47.911283][ T6650] RDX: 0000000000000001 RSI: 0000000000004c81 RDI: 0000000000000005
[   47.914069][ T6650] RBP: 00007ffe1f075bb0 R08: 0000000000000000 R09: 0000000000000000
[   47.916676][ T6650] R10: 0000000000000000 R11: 0000000000000246 R12: 00007ffe1f075bb0
[   47.919200][ T6650] R13: 000000000000b44f R14: 00007ffe1f075b8c R15: 0000000000000000
[   47.921709][ T6650] irq event stamp: 0
[   47.922952][ T6650] hardirqs last  enabled at (0): [<0000000000000000>] 0x0
[   47.925358][ T6650] hardirqs last disabled at (0): [<ffffffff811262d4>] copy_process+0x984/0x2010
[   47.928268][ T6650] softirqs last  enabled at (0): [<ffffffff811262d4>] copy_process+0x984/0x2010
[   47.931498][ T6650] softirqs last disabled at (0): [<0000000000000000>] 0x0
[   47.933852][ T6650] ---[ end trace 864118b148d3643c ]---
[   47.935591][ T6650] ------------[ cut here ]------------
[   47.937425][ T6650] kernfs: can not remove 'device_is_integrity_capable', no directory
[   47.940207][ T6650] WARNING: CPU: 2 PID: 6650 at fs/kernfs/dir.c:1508 kernfs_remove_by_name_ns+0x6f/0x80
[   47.943277][ T6650] Modules linked in: loop(E)
[   47.944652][ T6650] CPU: 2 PID: 6650 Comm: a.out Tainted: G        W   E     5.14.0-rc6+ #747
[   47.947858][ T6650] Hardware name: VMware, Inc. VMware Virtual Platform/440BX Desktop Reference Platform, BIOS 6.00 02/27/2020
[   47.951643][ T6650] RIP: 0010:kernfs_remove_by_name_ns+0x6f/0x80
[   47.953546][ T6650] Code: bb 38 01 31 c0 5d 41 5c 41 5d c3 48 c7 c7 e0 7d 7d 83 e8 b4 bb 38 01 b8 fe ff ff ff eb e7 48 c7 c7 18 39 2a 83 e8 41 9a 29 01 <0f> 0b b8 fe ff ff ff eb d2 0f 1f 84 00 00 00 00 00 41 57 41 56 41
[   47.959582][ T6650] RSP: 0018:ffffc90001673df0 EFLAGS: 00010286
[   47.961695][ T6650] RAX: 0000000000000000 RBX: ffffffff83804c50 RCX: 0000000000000027
[   47.964495][ T6650] RDX: 0000000000000027 RSI: 00000000ffffdfff RDI: ffff88807cfe78b8
[   47.967082][ T6650] RBP: 0000000000000000 R08: ffff88807cfe78b0 R09: 0000000000000000
[   47.970046][ T6650] R10: 0000000000000001 R11: 0000000000000001 R12: ffffffff832b6974
[   47.972639][ T6650] R13: 0000000000000001 R14: ffff888010cba340 R15: 0000000000000000
[   47.975300][ T6650] FS:  00007f2a594ce580(0000) GS:ffff88807ce00000(0000) knlGS:0000000000000000
[   47.978324][ T6650] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[   47.980753][ T6650] CR2: 00005651cf34e6b8 CR3: 0000000007541000 CR4: 00000000001506e0
[   47.983200][ T6650] Call Trace:
[   47.984185][ T6650]  remove_files.isra.0+0x2b/0x60
[   47.985968][ T6650]  sysfs_remove_group+0x38/0x80
[   47.987600][ T6650]  sysfs_remove_groups+0x24/0x40
[   47.989451][ T6650]  __kobject_del+0x1b/0x80
[   47.990779][ T6650]  kobject_del+0xf/0x20
[   47.992091][ T6650]  blk_integrity_del+0x1d/0x30
[   47.993517][ T6650]  del_gendisk+0x3c/0x1d0
[   47.994813][ T6650]  loop_remove+0x10/0x40 [loop]
[   47.996663][ T6650]  loop_control_ioctl+0x1a1/0x1b0 [loop]
[   47.998397][ T6650]  __x64_sys_ioctl+0x6a/0xa0
[   47.999876][ T6650]  do_syscall_64+0x35/0xb0
[   48.001201][ T6650]  entry_SYSCALL_64_after_hwframe+0x44/0xae
[   48.003003][ T6650] RIP: 0033:0x7f2a593f689d
[   48.004386][ T6650] Code: 00 c3 66 2e 0f 1f 84 00 00 00 00 00 90 f3 0f 1e fa 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 8b 0d c3 f5 0c 00 f7 d8 64 89 01 48
[   48.010505][ T6650] RSP: 002b:00007ffe1f075b78 EFLAGS: 00000246 ORIG_RAX: 0000000000000010
[   48.013686][ T6650] RAX: ffffffffffffffda RBX: 431bde82d7b634db RCX: 00007f2a593f689d
[   48.016190][ T6650] RDX: 0000000000000001 RSI: 0000000000004c81 RDI: 0000000000000005
[   48.018747][ T6650] RBP: 00007ffe1f075bb0 R08: 0000000000000000 R09: 0000000000000000
[   48.021360][ T6650] R10: 0000000000000000 R11: 0000000000000246 R12: 00007ffe1f075bb0
[   48.023806][ T6650] R13: 000000000000b44f R14: 00007ffe1f075b8c R15: 0000000000000000
[   48.026206][ T6650] irq event stamp: 0
[   48.027547][ T6650] hardirqs last  enabled at (0): [<0000000000000000>] 0x0
[   48.030407][ T6650] hardirqs last disabled at (0): [<ffffffff811262d4>] copy_process+0x984/0x2010
[   48.033184][ T6650] softirqs last  enabled at (0): [<ffffffff811262d4>] copy_process+0x984/0x2010
[   48.035888][ T6650] softirqs last disabled at (0): [<0000000000000000>] 0x0
[   48.038266][ T6650] ---[ end trace 864118b148d3643d ]---
[   48.039939][ T6650] ------------[ cut here ]------------
[   48.041610][ T6650] kernfs: can not remove 'bdi', no directory
[   48.043416][ T6650] WARNING: CPU: 2 PID: 6650 at fs/kernfs/dir.c:1508 kernfs_remove_by_name_ns+0x6f/0x80
[   48.046747][ T6650] Modules linked in: loop(E)
[   48.048240][ T6650] CPU: 2 PID: 6650 Comm: a.out Tainted: G        W   E     5.14.0-rc6+ #747
[   48.050851][ T6650] Hardware name: VMware, Inc. VMware Virtual Platform/440BX Desktop Reference Platform, BIOS 6.00 02/27/2020
[   48.054640][ T6650] RIP: 0010:kernfs_remove_by_name_ns+0x6f/0x80
[   48.056488][ T6650] Code: bb 38 01 31 c0 5d 41 5c 41 5d c3 48 c7 c7 e0 7d 7d 83 e8 b4 bb 38 01 b8 fe ff ff ff eb e7 48 c7 c7 18 39 2a 83 e8 41 9a 29 01 <0f> 0b b8 fe ff ff ff eb d2 0f 1f 84 00 00 00 00 00 41 57 41 56 41
[   48.063272][ T6650] RSP: 0018:ffffc90001673e88 EFLAGS: 00010282
[   48.065255][ T6650] RAX: 0000000000000000 RBX: ffff88800cdb1000 RCX: 0000000000000027
[   48.067812][ T6650] RDX: 0000000000000027 RSI: 00000000ffffdfff RDI: ffff88807cfe78b8
[   48.070366][ T6650] RBP: ffff888035d5d840 R08: ffff88807cfe78b0 R09: 0000000000000000
[   48.072797][ T6650] R10: 0000000000000001 R11: 0000000000000001 R12: ffffffff8329031f
[   48.075132][ T6650] R13: 0000000000000001 R14: ffff888010cba340 R15: 0000000000000000
[   48.077741][ T6650] FS:  00007f2a594ce580(0000) GS:ffff88807ce00000(0000) knlGS:0000000000000000
[   48.080951][ T6650] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[   48.082969][ T6650] CR2: 00005651cf34e6b8 CR3: 0000000007541000 CR4: 00000000001506e0
[   48.085432][ T6650] Call Trace:
[   48.086474][ T6650]  del_gendisk+0x1b3/0x1d0
[   48.087839][ T6650]  loop_remove+0x10/0x40 [loop]
[   48.089397][ T6650]  loop_control_ioctl+0x1a1/0x1b0 [loop]
[   48.091101][ T6650]  __x64_sys_ioctl+0x6a/0xa0
[   48.092474][ T6650]  do_syscall_64+0x35/0xb0
[   48.093839][ T6650]  entry_SYSCALL_64_after_hwframe+0x44/0xae
[   48.095824][ T6650] RIP: 0033:0x7f2a593f689d
[   48.097205][ T6650] Code: 00 c3 66 2e 0f 1f 84 00 00 00 00 00 90 f3 0f 1e fa 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 8b 0d c3 f5 0c 00 f7 d8 64 89 01 48
[   48.103356][ T6650] RSP: 002b:00007ffe1f075b78 EFLAGS: 00000246 ORIG_RAX: 0000000000000010
[   48.105880][ T6650] RAX: ffffffffffffffda RBX: 431bde82d7b634db RCX: 00007f2a593f689d
[   48.108297][ T6650] RDX: 0000000000000001 RSI: 0000000000004c81 RDI: 0000000000000005
[   48.110806][ T6650] RBP: 00007ffe1f075bb0 R08: 0000000000000000 R09: 0000000000000000
[   48.113462][ T6650] R10: 0000000000000000 R11: 0000000000000246 R12: 00007ffe1f075bb0
[   48.115938][ T6650] R13: 000000000000b44f R14: 00007ffe1f075b8c R15: 0000000000000000
[   48.118411][ T6650] irq event stamp: 0
[   48.119606][ T6650] hardirqs last  enabled at (0): [<0000000000000000>] 0x0
[   48.121771][ T6650] hardirqs last disabled at (0): [<ffffffff811262d4>] copy_process+0x984/0x2010
[   48.124858][ T6650] softirqs last  enabled at (0): [<ffffffff811262d4>] copy_process+0x984/0x2010
[   48.127996][ T6650] softirqs last disabled at (0): [<0000000000000000>] 0x0
[   48.130546][ T6650] ---[ end trace 864118b148d3643e ]---
[   48.132559][ T6650] BUG: kernel NULL pointer dereference, address: 0000000000000110
[   48.135053][ T6650] #PF: supervisor read access in kernel mode
[   48.136835][ T6650] #PF: error_code(0x0000) - not-present page
[   48.138685][ T6650] PGD 1f595067 P4D 1f595067 PUD b382067 PMD 0 
[   48.140520][ T6650] Oops: 0000 [#1] PREEMPT SMP
[   48.141990][ T6650] CPU: 2 PID: 6650 Comm: a.out Tainted: G        W   E     5.14.0-rc6+ #747
[   48.144537][ T6650] Hardware name: VMware, Inc. VMware Virtual Platform/440BX Desktop Reference Platform, BIOS 6.00 02/27/2020
[   48.148343][ T6650] RIP: 0010:device_del+0x46/0x410
[   48.150045][ T6650] Code: 48 89 ef 65 48 8b 04 25 28 00 00 00 48 89 44 24 10 31 c0 e8 9c fb 07 01 8b 05 42 94 2d 02 85 c0 0f 85 8c 03 00 00 48 8b 53 48 <0f> b6 82 10 01 00 00 a8 01 75 09 83 c8 01 88 82 10 01 00 00 48 89
[   48.155842][ T6650] RSP: 0018:ffffc90001673e80 EFLAGS: 00010246
[   48.157620][ T6650] RAX: 0000000000000000 RBX: ffff888035d5d880 RCX: 0000000000000000
[   48.160000][ T6650] RDX: 0000000000000000 RSI: ffffffff817736a4 RDI: 0000000000000000
[   48.162767][ T6650] RBP: ffff888035d5d9a0 R08: 0000000000000000 R09: 0000000000000001
[   48.166281][ T6650] R10: ffffc90001673e80 R11: ffff88800e8782b8 R12: 0000000000000000
[   48.168662][ T6650] R13: 0000000000000001 R14: ffff888010cba340 R15: 0000000000000000
[   48.171244][ T6650] FS:  00007f2a594ce580(0000) GS:ffff88807ce00000(0000) knlGS:0000000000000000
[   48.174117][ T6650] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[   48.176102][ T6650] CR2: 0000000000000110 CR3: 0000000007541000 CR4: 00000000001506e0
[   48.178665][ T6650] Call Trace:
[   48.180000][ T6650]  ? kernfs_remove_by_name_ns+0x5c/0x80
[   48.182079][ T6650]  loop_remove+0x10/0x40 [loop]
[   48.183585][ T6650]  loop_control_ioctl+0x1a1/0x1b0 [loop]
[   48.185286][ T6650]  __x64_sys_ioctl+0x6a/0xa0
[   48.186660][ T6650]  do_syscall_64+0x35/0xb0
[   48.188024][ T6650]  entry_SYSCALL_64_after_hwframe+0x44/0xae
[   48.189781][ T6650] RIP: 0033:0x7f2a593f689d
[   48.191199][ T6650] Code: 00 c3 66 2e 0f 1f 84 00 00 00 00 00 90 f3 0f 1e fa 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 8b 0d c3 f5 0c 00 f7 d8 64 89 01 48
[   48.197405][ T6650] RSP: 002b:00007ffe1f075b78 EFLAGS: 00000246 ORIG_RAX: 0000000000000010
[   48.199943][ T6650] RAX: ffffffffffffffda RBX: 431bde82d7b634db RCX: 00007f2a593f689d
[   48.202364][ T6650] RDX: 0000000000000001 RSI: 0000000000004c81 RDI: 0000000000000005
[   48.204803][ T6650] RBP: 00007ffe1f075bb0 R08: 0000000000000000 R09: 0000000000000000
[   48.207191][ T6650] R10: 0000000000000000 R11: 0000000000000246 R12: 00007ffe1f075bb0
[   48.209799][ T6650] R13: 000000000000b44f R14: 00007ffe1f075b8c R15: 0000000000000000
[   48.212396][ T6650] Modules linked in: loop(E)
[   48.213774][ T6650] CR2: 0000000000000110
[   48.215095][ T6650] ---[ end trace 864118b148d3643f ]---
[   48.217741][ T6650] RIP: 0010:device_del+0x46/0x410
[   48.220866][ T6650] Code: 48 89 ef 65 48 8b 04 25 28 00 00 00 48 89 44 24 10 31 c0 e8 9c fb 07 01 8b 05 42 94 2d 02 85 c0 0f 85 8c 03 00 00 48 8b 53 48 <0f> b6 82 10 01 00 00 a8 01 75 09 83 c8 01 88 82 10 01 00 00 48 89
[   48.232486][ T6650] RSP: 0018:ffffc90001673e80 EFLAGS: 00010246
[   48.236009][ T6650] RAX: 0000000000000000 RBX: ffff888035d5d880 RCX: 0000000000000000
[   48.241064][ T6650] RDX: 0000000000000000 RSI: ffffffff817736a4 RDI: 0000000000000000
[   48.246055][ T6650] RBP: ffff888035d5d9a0 R08: 0000000000000000 R09: 0000000000000001
[   48.250737][ T6650] R10: ffffc90001673e80 R11: ffff88800e8782b8 R12: 0000000000000000
[   48.253477][ T6650] R13: 0000000000000001 R14: ffff888010cba340 R15: 0000000000000000
[   48.256002][ T6650] FS:  00007f2a594ce580(0000) GS:ffff88807ce00000(0000) knlGS:0000000000000000
[   48.258903][ T6650] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[   48.261021][ T6650] CR2: 0000000000000110 CR3: 0000000007541000 CR4: 00000000001506e0
[   48.263737][ T6650] Kernel panic - not syncing: Fatal exception
[   48.265651][ T6650] Kernel Offset: disabled
[   48.569511][ T6650] Rebooting in 10 seconds..
----------------------------------------

Your series description is

  this series sorts out lock order reversals involving the block layer
  open_mutex by drastically reducing the scope of loop_ctl_mutex.  To do
  so it first merges the cryptoloop module into the main loop driver
  as the unregistrtion of transfers on live loop devices was causing
  some nasty locking interactions.

but the actual result after your patch is

  Circular locking dependency problem was not fixed at all.
  The kernel crashed in 2 seconds due to NULL pointer dereference.
  syzbot will crash earlier due to add_disk()/del_gendisk() racing

> 
>> That is, you decided not to provide patches which can be backported.
> 
> Please stop this bullshit.
> 

Please stop posting broken series.

 b/drivers/block/Kconfig    |    6 +--
 b/drivers/block/Makefile   |    1
 b/drivers/block/loop.c     |  327 +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++-------------------------------------------------------------------------------------------
 b/drivers/block/loop.h     |   30 +++---------------
 drivers/block/cryptoloop.c |  204 ------------------------------------------------------------------------------------------------------------------------------
 5 files changed, 188 insertions(+), 380 deletions(-)

You need to also read Documentation/process/stable-kernel-rules.rst .

 - It must be obviously correct and tested.
 - It cannot be bigger than 100 lines, with context.
 - It must fix only one thing.
 - It must fix a real bug that bothers people (not a, "This could be a
   problem..." type thing).

Your series is far away from conforming to the stable kernel rules.

My "block: genhd: don't call probe function with major_names_lock held" patch is

 block/genhd.c         | 33 ++++++++++++++++++++++++++-------
 include/linux/genhd.h | 11 +++++++++--
 2 files changed, 35 insertions(+), 9 deletions(-)

without any dependent commit, and my "loop: break loop_ctl_mutex into
loop_idr_spinlock and loop_removal_mutex" patch is

 drivers/block/loop.c | 130 +++++++++++++++++++++++++++++--------------
 1 file changed, 89 insertions(+), 41 deletions(-)

which is border line for stable due to dependent commit.
Therefore, I propose "block: genhd: don't call probe function with major_names_lock held"
for 5.14 and stable, then "loop: break loop_ctl_mutex into loop_idr_spinlock and
loop_removal_mutex" for 5.15, and then your patch (which removes cryptoloop module)
for 5.16 and later.

Please read on the paragraphs after the paragraph which you called it "bullshit".
These are suggestions which helps you to write thechnically correct and safe patches.

If you don't like my patches, please do post patches that are thechnically correct
and safe. Can you do it?

