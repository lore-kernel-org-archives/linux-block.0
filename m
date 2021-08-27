Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.3 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 02B80C432BE
	for <linux-block@archiver.kernel.org>; Fri, 27 Aug 2021 00:30:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D0F4660F6F
	for <linux-block@archiver.kernel.org>; Fri, 27 Aug 2021 00:30:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231546AbhH0AbC (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 26 Aug 2021 20:31:02 -0400
Received: from www262.sakura.ne.jp ([202.181.97.72]:55843 "EHLO
        www262.sakura.ne.jp" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231509AbhH0AbC (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 26 Aug 2021 20:31:02 -0400
Received: from fsav112.sakura.ne.jp (fsav112.sakura.ne.jp [27.133.134.239])
        by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTP id 17R0UDUe054957;
        Fri, 27 Aug 2021 09:30:13 +0900 (JST)
        (envelope-from penguin-kernel@i-love.sakura.ne.jp)
Received: from www262.sakura.ne.jp (202.181.97.72)
 by fsav112.sakura.ne.jp (F-Secure/fsigk_smtp/550/fsav112.sakura.ne.jp);
 Fri, 27 Aug 2021 09:30:13 +0900 (JST)
X-Virus-Status: clean(F-Secure/fsigk_smtp/550/fsav112.sakura.ne.jp)
Received: from [192.168.1.9] (M106072142033.v4.enabler.ne.jp [106.72.142.33])
        (authenticated bits=0)
        by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTPSA id 17R0UCgA054949
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NO);
        Fri, 27 Aug 2021 09:30:13 +0900 (JST)
        (envelope-from penguin-kernel@i-love.sakura.ne.jp)
Subject: Re: sort out the lock order in the loop driver v2
To:     Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>
Cc:     Hillf Danton <hdanton@sina.com>,
        Pavel Tatashin <pasha.tatashin@soleen.com>,
        Tyler Hicks <tyhicks@linux.microsoft.com>,
        linux-block <linux-block@vger.kernel.org>,
        Milan Broz <gmazyland@gmail.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
References: <20210826133810.3700-1-hch@lst.de>
From:   Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>
Message-ID: <b34196f3-c407-1d8a-175c-485c4bf0b5d8@i-love.sakura.ne.jp>
Date:   Fri, 27 Aug 2021 09:30:12 +0900
User-Agent: Mozilla/5.0 (Windows NT 6.3; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <20210826133810.3700-1-hch@lst.de>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 2021/08/26 22:38, Christoph Hellwig wrote:
> Hi Jens,
> 
> this series sorts out lock order reversals involving the block layer
> open_mutex by drastically reducing the scope of loop_ctl_mutex.  To do
> so it first merges the cryptoloop module into the main loop driver
> as the unregistrtion of transfers on live loop devices was causing
> some nasty locking interactions.
> 
> Changes since v1:
>  - add a new patch to fix a pre-existing spare warning in the crypto code
>  - initialize various struct loop_dev fields earlier
>  - hold lo_mutex over lo_state updates
>  - take loop_ctl_mutex to delete from the idr in the loop_add failure
>    path
> 
> Diffstat:
>  b/drivers/block/Kconfig    |    6 
>  b/drivers/block/Makefile   |    1 
>  b/drivers/block/loop.c     |  334 ++++++++++++++++++++++++---------------------
>  b/drivers/block/loop.h     |   30 ----
>  drivers/block/cryptoloop.c |  204 ---------------------------
>  5 files changed, 189 insertions(+), 386 deletions(-)
> 

Again crashed in 3 seconds. We can't accept this series.

Jens, can we please apply "[PATCH v5] block: genhd: don't call probe function with major_names_lock held"
( https://lkml.kernel.org/r/b2af8a5b-3c1b-204e-7f56-bea0b15848d6@i-love.sakura.ne.jp ) for v5.14 (and also stable),
followed by "[PATCH] loop: replace loop_ctl_mutex with loop_idr_spinlock"
( https://lkml.kernel.org/r/2642808b-a7d0-28ff-f288-0f4eabc562f7@i-love.sakura.ne.jp ) for v5.15 (but not stable) ?

----------------------------------------
[   56.110978][ T6637] loop0: detected capacity change from 0 to 4096
[   56.116717][ T6637] EXT4-fs error (device loop0): ext4_fill_super:4956: inode #2: comm a.out: iget: root inode unallocated
[   56.125718][ T6637] EXT4-fs (loop0): get root inode failed
[   56.129558][ T6637] EXT4-fs (loop0): mount failed
[   56.252153][ T6642] loop0: detected capacity change from 0 to 4096
[   56.258165][ T6642] EXT4-fs error (device loop0): ext4_fill_super:4956: inode #2: comm a.out: iget: root inode unallocated
[   56.265403][ T6642] EXT4-fs (loop0): get root inode failed
[   56.268371][ T6642] EXT4-fs (loop0): mount failed
[   56.335800][ T6654] loop0: detected capacity change from 0 to 4096
[   56.340883][ T6654] EXT4-fs error (device loop0): ext4_fill_super:4956: inode #2: comm a.out: iget: root inode unallocated
[   56.345046][ T6654] EXT4-fs (loop0): get root inode failed
[   56.347450][ T6654] EXT4-fs (loop0): mount failed
[   56.412014][ T6659] loop0: detected capacity change from 0 to 4096
[   56.417593][ T6659] EXT4-fs error (device loop0): ext4_fill_super:4956: inode #2: comm a.out: iget: root inode unallocated
[   56.422250][ T6659] EXT4-fs (loop0): get root inode failed
[   56.425625][ T6659] EXT4-fs (loop0): mount failed
[   56.543382][ T6664] loop0: detected capacity change from 0 to 4096
[   56.548172][ T6664] EXT4-fs error (device loop0): ext4_fill_super:4956: inode #2: comm a.out: iget: root inode unallocated
[   56.552613][ T6664] EXT4-fs (loop0): get root inode failed
[   56.554906][ T6664] EXT4-fs (loop0): mount failed
[   56.633168][ T6671] loop0: detected capacity change from 0 to 4096
[   56.635267][ T4347] blk_update_request: I/O error, dev loop0, sector 0 op 0x1:(WRITE) flags 0x800 phys_seg 0 prio class 0
[   56.644605][ T6671] EXT4-fs error (device loop0): ext4_fill_super:4956: inode #2: comm a.out: iget: root inode unallocated
[   56.649600][ T6671] EXT4-fs (loop0): get root inode failed
[   56.652696][ T6671] EXT4-fs (loop0): mount failed
[   56.705027][ T6681] loop0: detected capacity change from 0 to 4096
[   56.711505][ T6681] EXT4-fs error (device loop0): ext4_fill_super:4956: inode #2: comm a.out: iget: root inode unallocated
[   56.716055][ T6681] EXT4-fs (loop0): get root inode failed
[   56.718494][ T6681] EXT4-fs (loop0): mount failed
[   56.812013][ T6686] loop0: detected capacity change from 0 to 4096
[   56.817925][ T6686] EXT4-fs error (device loop0): ext4_fill_super:4956: inode #2: comm a.out: iget: root inode unallocated
[   56.823146][ T6686] EXT4-fs (loop0): get root inode failed
[   56.826182][ T6686] EXT4-fs (loop0): mount failed
[   57.338534][ T6733] loop0: detected capacity change from 0 to 4096
[   57.344623][ T6733] EXT4-fs error (device loop0): ext4_fill_super:4956: inode #2: comm a.out: iget: root inode unallocated
[   57.352245][ T6733] EXT4-fs (loop0): get root inode failed
[   57.355118][ T6733] EXT4-fs (loop0): mount failed
[   57.369888][ T6617] sysfs: cannot create duplicate filename '/devices/virtual/block/loop1'
[   57.372738][ T6617] CPU: 2 PID: 6617 Comm: systemd-udevd Tainted: G            E     5.14.0-rc7+ #749
[   57.378013][ T6617] Hardware name: VMware, Inc. VMware Virtual Platform/440BX Desktop Reference Platform, BIOS 6.00 02/27/2020
[   57.382006][ T6617] Call Trace:
[   57.383106][ T6617]  dump_stack_lvl+0x57/0x7d
[   57.384722][ T6617]  sysfs_warn_dup.cold+0x17/0x24
[   57.386551][ T6617]  sysfs_create_dir_ns+0xb7/0xd0
[   57.388225][ T6617]  kobject_add_internal+0xa8/0x290
[   57.389915][ T6617]  kobject_add+0x7e/0xb0
[   57.391328][ T6617]  device_add+0x11d/0x910
[   57.392762][ T6617]  ? dev_set_name+0x4e/0x70
[   57.394396][ T6617]  __device_add_disk+0xbf/0x300
[   57.396091][ T6617]  loop_add+0x29b/0x310 [loop]
[   57.398432][ T6617]  ? blkdev_get_by_dev+0x330/0x330
[   57.400704][ T6617]  blk_request_module+0x63/0xc0
[   57.402374][ T6617]  blkdev_get_no_open+0x98/0xc0
[   57.404042][ T6617]  blkdev_get_by_dev+0x54/0x330
[   57.405717][ T6617]  ? blkdev_get_by_dev+0x330/0x330
[   57.407421][ T6617]  blkdev_open+0x59/0xa0
[   57.408834][ T6617]  do_dentry_open+0x14c/0x3a0
[   57.410547][ T6617]  path_openat+0x78e/0xa50
[   57.412073][ T6617]  do_filp_open+0xad/0x120
[   57.413534][ T6617]  ? alloc_fd+0x14c/0x1f0
[   57.415242][ T6617]  do_sys_openat2+0x241/0x310
[   57.416971][ T6617]  do_sys_open+0x3f/0x80
[   57.418455][ T6617]  do_syscall_64+0x35/0xb0
[   57.419955][ T6617]  entry_SYSCALL_64_after_hwframe+0x44/0xae
[   57.421973][ T6617] RIP: 0033:0x7f6846523eab
[   57.423471][ T6617] Code: 25 00 00 41 00 3d 00 00 41 00 74 4b 64 8b 04 25 18 00 00 00 85 c0 75 67 44 89 e2 48 89 ee bf 9c ff ff ff b8 01 01 00 00 0f 05 <48> 3d 00 f0 ff ff 0f 87 91 00 00 00 48 8b 4c 24 28 64 48 33 0c 25
[   57.430931][ T6617] RSP: 002b:00007fff3d4dfb70 EFLAGS: 00000246 ORIG_RAX: 0000000000000101
[   57.434173][ T6617] RAX: ffffffffffffffda RBX: 000055c2c4b8ed20 RCX: 00007f6846523eab
[   57.436897][ T6617] RDX: 00000000000a0800 RSI: 000055c2c4b92460 RDI: 00000000ffffff9c
[   57.439749][ T6617] RBP: 000055c2c4b92460 R08: 000055c2c330b270 R09: 00007fff3d5de090
[   57.442470][ T6617] R10: 0000000000000000 R11: 0000000000000246 R12: 00000000000a0800
[   57.445475][ T6617] R13: 0000000000000000 R14: 0000000000000001 R15: 0000000000000000
[   57.449450][ T6617] kobject_add_internal failed for loop1 with -EEXIST, don't try to register things with the same name in the same directory.
[   57.453822][ T6617] kobject_add_internal failed for queue (error: -2 parent: loop1)
[   57.456684][ T6617] kobject_add_internal failed for integrity (error: -2 parent: loop1)
[   57.489728][ T6618] 
[   57.490564][ T6618] ======================================================
[   57.492856][ T6618] WARNING: possible circular locking dependency detected
[   57.495348][ T6618] 5.14.0-rc7+ #749 Tainted: G            E    
[   57.499728][ T6618] ------------------------------------------------------
[   57.502053][ T6618] systemd-udevd/6618 is trying to acquire lock:
[   57.503968][ T6618] ffff88800e512948 ((wq_completion)loop0){+.+.}-{0:0}, at: flush_workqueue+0x85/0x560
[   57.507193][ T6618] 
[   57.507193][ T6618] but task is already holding lock:
[   57.509716][ T6618] ffff88800eee0c88 (&lo->lo_mutex){+.+.}-{3:3}, at: __loop_clr_fd+0x5b/0x610 [loop]
[   57.512777][ T6618] 
[   57.512777][ T6618] which lock already depends on the new lock.
[   57.512777][ T6618] 
[   57.516841][ T6618] 
[   57.516841][ T6618] the existing dependency chain (in reverse order) is:
[   57.519840][ T6618] 
[   57.519840][ T6618] -> #5 (&lo->lo_mutex){+.+.}-{3:3}:
[   57.522270][ T6618]        lock_acquire+0xd0/0x300
[   57.523797][ T6618]        __mutex_lock+0x97/0x950
[   57.525547][ T6618]        loop_add+0x2a5/0x310 [loop]
[   57.527298][ T6618]        blk_request_module+0x63/0xc0
[   57.529327][ T6618]        blkdev_get_no_open+0x98/0xc0
[   57.532256][ T6618]        blkdev_get_by_dev+0x54/0x330
[   57.534815][ T6618]        blkdev_open+0x59/0xa0
[   57.536509][ T6618]        do_dentry_open+0x14c/0x3a0
[   57.538250][ T6618]        path_openat+0x78e/0xa50
[   57.539826][ T6618]        do_filp_open+0xad/0x120
[   57.541646][ T6618]        do_sys_openat2+0x241/0x310
[   57.543417][ T6618]        do_sys_open+0x3f/0x80
[   57.545108][ T6618]        do_syscall_64+0x35/0xb0
[   57.546641][ T6618]        entry_SYSCALL_64_after_hwframe+0x44/0xae
[   57.549221][ T6618] 
[   57.549221][ T6618] -> #4 (major_names_lock){+.+.}-{3:3}:
[   57.551694][ T6618]        lock_acquire+0xd0/0x300
[   57.553291][ T6618]        __mutex_lock+0x97/0x950
[   57.555318][ T6618]        blkdev_show+0x18/0x90
[   57.557018][ T6618]        devinfo_show+0x58/0x70
[   57.558678][ T6618]        seq_read_iter+0x27b/0x3f0
[   57.560474][ T6618]        proc_reg_read_iter+0x3c/0x60
[   57.562250][ T6618]        new_sync_read+0x110/0x190
[   57.566270][ T6618]        vfs_read+0x11d/0x1b0
[   57.567857][ T6618]        ksys_read+0x63/0xe0
[   57.569405][ T6618]        do_syscall_64+0x35/0xb0
[   57.570974][ T6618]        entry_SYSCALL_64_after_hwframe+0x44/0xae
[   57.573177][ T6618] 
[   57.573177][ T6618] -> #3 (&p->lock){+.+.}-{3:3}:
[   57.575889][ T6618]        lock_acquire+0xd0/0x300
[   57.577762][ T6618]        __mutex_lock+0x97/0x950
[   57.579591][ T6618]        seq_read_iter+0x4c/0x3f0
[   57.581586][ T6618]        generic_file_splice_read+0xf7/0x1a0
[   57.583581][ T6618]        splice_direct_to_actor+0xc0/0x230
[   57.585619][ T6618]        do_splice_direct+0x8c/0xd0
[   57.587384][ T6618]        do_sendfile+0x319/0x5a0
[   57.589057][ T6618]        __x64_sys_sendfile64+0xad/0xc0
[   57.590983][ T6618]        do_syscall_64+0x35/0xb0
[   57.592599][ T6618]        entry_SYSCALL_64_after_hwframe+0x44/0xae
[   57.595116][ T6618] 
[   57.595116][ T6618] -> #2 (sb_writers#3){.+.+}-{0:0}:
[   57.598425][ T6618]        lock_acquire+0xd0/0x300
[   57.600526][ T6618]        lo_write_bvec+0xe1/0x260 [loop]
[   57.602563][ T6618]        loop_process_work+0x3fa/0xcf0 [loop]
[   57.604709][ T6618]        process_one_work+0x2aa/0x600
[   57.606488][ T6618]        worker_thread+0x48/0x3d0
[   57.608138][ T6618]        kthread+0x13e/0x170
[   57.609676][ T6618]        ret_from_fork+0x1f/0x30
[   57.611471][ T6618] 
[   57.611471][ T6618] -> #1 ((work_completion)(&lo->rootcg_work)){+.+.}-{0:0}:
[   57.615294][ T6618]        lock_acquire+0xd0/0x300
[   57.617627][ T6618]        process_one_work+0x27e/0x600
[   57.619537][ T6618]        worker_thread+0x48/0x3d0
[   57.621259][ T6618]        kthread+0x13e/0x170
[   57.622729][ T6618]        ret_from_fork+0x1f/0x30
[   57.624460][ T6618] 
[   57.624460][ T6618] -> #0 ((wq_completion)loop0){+.+.}-{0:0}:
[   57.627186][ T6618]        check_prev_add+0x91/0xc00
[   57.629378][ T6618]        __lock_acquire+0x14a8/0x1f40
[   57.632976][ T6618]        lock_acquire+0xd0/0x300
[   57.636343][ T6618]        flush_workqueue+0xa9/0x560
[   57.638067][ T6618]        drain_workqueue+0x9b/0x100
[   57.639873][ T6618]        destroy_workqueue+0x2f/0x210
[   57.641652][ T6618]        __loop_clr_fd+0xbf/0x610 [loop]
[   57.643588][ T6618]        blkdev_put+0xaf/0x180
[   57.645246][ T6618]        blkdev_close+0x20/0x30
[   57.646831][ T6618]        __fput+0xa0/0x240
[   57.648532][ T6618]        task_work_run+0x57/0xa0
[   57.650291][ T6618]        exit_to_user_mode_prepare+0x252/0x260
[   57.652219][ T6618]        syscall_exit_to_user_mode+0x19/0x60
[   57.654332][ T6618]        do_syscall_64+0x42/0xb0
[   57.655837][ T6618]        entry_SYSCALL_64_after_hwframe+0x44/0xae
[   57.658076][ T6618] 
[   57.658076][ T6618] other info that might help us debug this:
[   57.658076][ T6618] 
[   57.661564][ T6618] Chain exists of:
[   57.661564][ T6618]   (wq_completion)loop0 --> major_names_lock --> &lo->lo_mutex
[   57.661564][ T6618] 
[   57.668254][ T6618]  Possible unsafe locking scenario:
[   57.668254][ T6618] 
[   57.670679][ T6618]        CPU0                    CPU1
[   57.672409][ T6618]        ----                    ----
[   57.674184][ T6618]   lock(&lo->lo_mutex);
[   57.675666][ T6618]                                lock(major_names_lock);
[   57.677988][ T6618]                                lock(&lo->lo_mutex);
[   57.680277][ T6618]   lock((wq_completion)loop0);
[   57.682111][ T6618] 
[   57.682111][ T6618]  *** DEADLOCK ***
[   57.682111][ T6618] 
[   57.685254][ T6618] 2 locks held by systemd-udevd/6618:
[   57.687251][ T6618]  #0: ffff8880121c3528 (&disk->open_mutex){+.+.}-{3:3}, at: blkdev_put+0x30/0x180
[   57.690362][ T6618]  #1: ffff88800eee0c88 (&lo->lo_mutex){+.+.}-{3:3}, at: __loop_clr_fd+0x5b/0x610 [loop]
[   57.693750][ T6618] 
[   57.693750][ T6618] stack backtrace:
[   57.695809][ T6618] CPU: 0 PID: 6618 Comm: systemd-udevd Tainted: G            E     5.14.0-rc7+ #749
[   57.702462][ T6618] Hardware name: VMware, Inc. VMware Virtual Platform/440BX Desktop Reference Platform, BIOS 6.00 02/27/2020
[   57.706363][ T6618] Call Trace:
[   57.707412][ T6618]  dump_stack_lvl+0x57/0x7d
[   57.708790][ T6618]  check_noncircular+0x114/0x130
[   57.710580][ T6618]  check_prev_add+0x91/0xc00
[   57.712288][ T6618]  ? __lock_acquire+0x5c1/0x1f40
[   57.713803][ T6618]  __lock_acquire+0x14a8/0x1f40
[   57.715952][ T6618]  lock_acquire+0xd0/0x300
[   57.717529][ T6618]  ? flush_workqueue+0x85/0x560
[   57.719026][ T6618]  ? lockdep_init_map_type+0x51/0x220
[   57.720867][ T6618]  ? lockdep_init_map_type+0x51/0x220
[   57.722546][ T6618]  flush_workqueue+0xa9/0x560
[   57.724017][ T6618]  ? flush_workqueue+0x85/0x560
[   57.726079][ T6618]  ? drain_workqueue+0x9b/0x100
[   57.727810][ T6618]  drain_workqueue+0x9b/0x100
[   57.729645][ T6618]  destroy_workqueue+0x2f/0x210
[   57.731814][ T6618]  __loop_clr_fd+0xbf/0x610 [loop]
[   57.733713][ T6618]  ? __mutex_unlock_slowpath+0x40/0x2a0
[   57.735677][ T6618]  blkdev_put+0xaf/0x180
[   57.737056][ T6618]  blkdev_close+0x20/0x30
[   57.738540][ T6618]  __fput+0xa0/0x240
[   57.739845][ T6618]  task_work_run+0x57/0xa0
[   57.741366][ T6618]  exit_to_user_mode_prepare+0x252/0x260
[   57.743238][ T6618]  syscall_exit_to_user_mode+0x19/0x60
[   57.745468][ T6618]  do_syscall_64+0x42/0xb0
[   57.747135][ T6618]  entry_SYSCALL_64_after_hwframe+0x44/0xae
[   57.749417][ T6618] RIP: 0033:0x7f6846524987
[   57.750981][ T6618] Code: ff ff e8 9c 11 02 00 66 2e 0f 1f 84 00 00 00 00 00 66 90 f3 0f 1e fa 64 8b 04 25 18 00 00 00 85 c0 75 10 b8 03 00 00 00 0f 05 <48> 3d 00 f0 ff ff 77 41 c3 48 83 ec 18 89 7c 24 0c e8 c3 5d f8 ff
[   57.757556][ T6618] RSP: 002b:00007fff3d4dfbb8 EFLAGS: 00000246 ORIG_RAX: 0000000000000003
[   57.760477][ T6618] RAX: 0000000000000000 RBX: 00007f6845fac788 RCX: 00007f6846524987
[   57.763567][ T6618] RDX: 0000000000000000 RSI: 0000000000000000 RDI: 0000000000000006
[   57.767982][ T6618] RBP: 0000000000000006 R08: 000055c2c3318af0 R09: 0000000000000000
[   57.770460][ T6618] R10: 00007f6845fac788 R11: 0000000000000246 R12: 0000000000000000
[   57.773068][ T6618] R13: 0000000000000000 R14: 0000000000000000 R15: 000055c2c3300635
[   57.777617][ T6737] loop0: detected capacity change from 0 to 4096
[   57.782129][ T6737] EXT4-fs error (device loop0): ext4_fill_super:4956: inode #2: comm a.out: iget: root inode unallocated
[   57.788081][ T6737] EXT4-fs (loop0): get root inode failed
[   57.792922][ T6737] EXT4-fs (loop0): mount failed
[   57.801371][ T6743] ------------[ cut here ]------------
[   57.803882][ T6743] kernfs: can not remove 'format', no directory
[   57.807757][ T6743] WARNING: CPU: 1 PID: 6743 at fs/kernfs/dir.c:1508 kernfs_remove_by_name_ns+0x6f/0x80
[   57.811285][ T6743] Modules linked in: loop(E)
[   57.812856][ T6743] CPU: 1 PID: 6743 Comm: a.out Tainted: G            E     5.14.0-rc7+ #749
[   57.816084][ T6743] Hardware name: VMware, Inc. VMware Virtual Platform/440BX Desktop Reference Platform, BIOS 6.00 02/27/2020
[   57.820253][ T6743] RIP: 0010:kernfs_remove_by_name_ns+0x6f/0x80
[   57.822289][ T6743] Code: bb 38 01 31 c0 5d 41 5c 41 5d c3 48 c7 c7 e0 81 7d 83 e8 54 bb 38 01 b8 fe ff ff ff eb e7 48 c7 c7 50 3c 2a 83 e8 d1 99 29 01 <0f> 0b b8 fe ff ff ff eb d2 0f 1f 84 00 00 00 00 00 41 57 41 56 41
[   57.828947][ T6743] RSP: 0018:ffffc90001633df0 EFLAGS: 00010286
[   57.834146][ T6743] RAX: 0000000000000000 RBX: ffffffff83805028 RCX: 0000000000000027
[   57.836807][ T6743] RDX: 0000000000000027 RSI: 00000000ffffdfff RDI: ffff88807cbe78b8
[   57.839616][ T6743] RBP: 0000000000000000 R08: ffff88807cbe78b0 R09: 0000000000000000
[   57.842806][ T6743] R10: 0000000000000001 R11: 0000000000000001 R12: ffffffff833d7d30
[   57.849347][ T6743] R13: 0000000000000001 R14: ffff88801208dfc0 R15: 0000000000000000
[   57.852955][ T6743] FS:  00007f1199de5580(0000) GS:ffff88807ca00000(0000) knlGS:0000000000000000
[   57.857149][ T6743] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[   57.859391][ T6743] CR2: 00007f4a41af3048 CR3: 000000001d68d000 CR4: 00000000001506e0
[   57.862417][ T6743] Call Trace:
[   57.863546][ T6743]  remove_files.isra.0+0x2b/0x60
[   57.866726][ T6743]  sysfs_remove_group+0x38/0x80
[   57.869074][ T6743]  sysfs_remove_groups+0x24/0x40
[   57.870872][ T6743]  __kobject_del+0x1b/0x80
[   57.872336][ T6743]  kobject_del+0xf/0x20
[   57.873754][ T6743]  blk_integrity_del+0x1d/0x30
[   57.875388][ T6743]  del_gendisk+0x3c/0x1d0
[   57.876993][ T6743]  loop_remove+0x10/0x40 [loop]
[   57.878733][ T6743]  loop_control_ioctl+0x1a1/0x1b0 [loop]
[   57.880711][ T6743]  __x64_sys_ioctl+0x6a/0xa0
[   57.882980][ T6743]  do_syscall_64+0x35/0xb0
[   57.885024][ T6743]  entry_SYSCALL_64_after_hwframe+0x44/0xae
[   57.887120][ T6743] RIP: 0033:0x7f1199d0d89d
[   57.888565][ T6743] Code: 00 c3 66 2e 0f 1f 84 00 00 00 00 00 90 f3 0f 1e fa 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 8b 0d c3 f5 0c 00 f7 d8 64 89 01 48
[   57.895764][ T6743] RSP: 002b:00007ffd3c6a4b68 EFLAGS: 00000246 ORIG_RAX: 0000000000000010
[   57.901666][ T6743] RAX: ffffffffffffffda RBX: 431bde82d7b634db RCX: 00007f1199d0d89d
[   57.904538][ T6743] RDX: 0000000000000001 RSI: 0000000000004c81 RDI: 0000000000000005
[   57.907183][ T6743] RBP: 00007ffd3c6a4ba0 R08: 0000000000000000 R09: 0000000000000000
[   57.909933][ T6743] R10: 0000000000000000 R11: 0000000000000246 R12: 00007ffd3c6a4ba0
[   57.912723][ T6743] R13: 000000000000dc57 R14: 00007ffd3c6a4b7c R15: 0000000000000000
[   57.916447][ T6743] irq event stamp: 0
[   57.917748][ T6743] hardirqs last  enabled at (0): [<0000000000000000>] 0x0
[   57.920198][ T6743] hardirqs last disabled at (0): [<ffffffff811262d4>] copy_process+0x984/0x2010
[   57.923208][ T6743] softirqs last  enabled at (0): [<ffffffff811262d4>] copy_process+0x984/0x2010
[   57.926387][ T6743] softirqs last disabled at (0): [<0000000000000000>] 0x0
[   57.928738][ T6743] ---[ end trace b154f08dae0bfe9a ]---
[   57.931937][ T6743] ------------[ cut here ]------------
[   57.935504][ T6743] kernfs: can not remove 'tag_size', no directory
[   57.937628][ T6743] WARNING: CPU: 1 PID: 6743 at fs/kernfs/dir.c:1508 kernfs_remove_by_name_ns+0x6f/0x80
[   57.940909][ T6743] Modules linked in: loop(E)
[   57.942448][ T6743] CPU: 1 PID: 6743 Comm: a.out Tainted: G        W   E     5.14.0-rc7+ #749
[   57.945453][ T6743] Hardware name: VMware, Inc. VMware Virtual Platform/440BX Desktop Reference Platform, BIOS 6.00 02/27/2020
[   57.949611][ T6743] RIP: 0010:kernfs_remove_by_name_ns+0x6f/0x80
[   57.951657][ T6743] Code: bb 38 01 31 c0 5d 41 5c 41 5d c3 48 c7 c7 e0 81 7d 83 e8 54 bb 38 01 b8 fe ff ff ff eb e7 48 c7 c7 50 3c 2a 83 e8 d1 99 29 01 <0f> 0b b8 fe ff ff ff eb d2 0f 1f 84 00 00 00 00 00 41 57 41 56 41
[   57.958697][ T6743] RSP: 0018:ffffc90001633df0 EFLAGS: 00010286
[   57.960735][ T6743] RAX: 0000000000000000 RBX: ffffffff83805030 RCX: 0000000000000027
[   57.963418][ T6743] RDX: 0000000000000027 RSI: 00000000ffffdfff RDI: ffff88807cbe78b8
[   57.967478][ T6743] RBP: 0000000000000000 R08: ffff88807cbe78b0 R09: 0000000000000000
[   57.970021][ T6743] R10: 0000000000000001 R11: 0000000000000001 R12: ffffffff832b6cfd
[   57.972597][ T6743] R13: 0000000000000001 R14: ffff88801208dfc0 R15: 0000000000000000
[   57.975229][ T6743] FS:  00007f1199de5580(0000) GS:ffff88807ca00000(0000) knlGS:0000000000000000
[   57.978516][ T6743] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[   57.980798][ T6743] CR2: 00007f4a41af3048 CR3: 000000001d68d000 CR4: 00000000001506e0
[   57.983896][ T6743] Call Trace:
[   57.985248][ T6743]  remove_files.isra.0+0x2b/0x60
[   57.986968][ T6743]  sysfs_remove_group+0x38/0x80
[   57.988478][ T6743]  sysfs_remove_groups+0x24/0x40
[   57.990127][ T6743]  __kobject_del+0x1b/0x80
[   57.991609][ T6743]  kobject_del+0xf/0x20
[   57.993005][ T6743]  blk_integrity_del+0x1d/0x30
[   57.994744][ T6743]  del_gendisk+0x3c/0x1d0
[   57.996167][ T6743]  loop_remove+0x10/0x40 [loop]
[   57.999275][ T6743]  loop_control_ioctl+0x1a1/0x1b0 [loop]
[   58.001800][ T6743]  __x64_sys_ioctl+0x6a/0xa0
[   58.003278][ T6743]  do_syscall_64+0x35/0xb0
[   58.004890][ T6743]  entry_SYSCALL_64_after_hwframe+0x44/0xae
[   58.006874][ T6743] RIP: 0033:0x7f1199d0d89d
[   58.008365][ T6743] Code: 00 c3 66 2e 0f 1f 84 00 00 00 00 00 90 f3 0f 1e fa 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 8b 0d c3 f5 0c 00 f7 d8 64 89 01 48
[   58.015780][ T6743] RSP: 002b:00007ffd3c6a4b68 EFLAGS: 00000246 ORIG_RAX: 0000000000000010
[   58.018692][ T6743] RAX: ffffffffffffffda RBX: 431bde82d7b634db RCX: 00007f1199d0d89d
[   58.021324][ T6743] RDX: 0000000000000001 RSI: 0000000000004c81 RDI: 0000000000000005
[   58.024202][ T6743] RBP: 00007ffd3c6a4ba0 R08: 0000000000000000 R09: 0000000000000000
[   58.027030][ T6743] R10: 0000000000000000 R11: 0000000000000246 R12: 00007ffd3c6a4ba0
[   58.030145][ T6743] R13: 000000000000dc57 R14: 00007ffd3c6a4b7c R15: 0000000000000000
[   58.034380][ T6743] irq event stamp: 0
[   58.035696][ T6743] hardirqs last  enabled at (0): [<0000000000000000>] 0x0
[   58.038008][ T6743] hardirqs last disabled at (0): [<ffffffff811262d4>] copy_process+0x984/0x2010
[   58.040948][ T6743] softirqs last  enabled at (0): [<ffffffff811262d4>] copy_process+0x984/0x2010
[   58.044553][ T6743] softirqs last disabled at (0): [<0000000000000000>] 0x0
[   58.047127][ T6743] ---[ end trace b154f08dae0bfe9b ]---
[   58.049331][ T6743] ------------[ cut here ]------------
[   58.051183][ T6743] kernfs: can not remove 'protection_interval_bytes', no directory
[   58.053723][ T6743] WARNING: CPU: 1 PID: 6743 at fs/kernfs/dir.c:1508 kernfs_remove_by_name_ns+0x6f/0x80
[   58.056979][ T6743] Modules linked in: loop(E)
[   58.058576][ T6743] CPU: 1 PID: 6743 Comm: a.out Tainted: G        W   E     5.14.0-rc7+ #749
[   58.061800][ T6743] Hardware name: VMware, Inc. VMware Virtual Platform/440BX Desktop Reference Platform, BIOS 6.00 02/27/2020
[   58.068176][ T6743] RIP: 0010:kernfs_remove_by_name_ns+0x6f/0x80
[   58.070188][ T6743] Code: bb 38 01 31 c0 5d 41 5c 41 5d c3 48 c7 c7 e0 81 7d 83 e8 54 bb 38 01 b8 fe ff ff ff eb e7 48 c7 c7 50 3c 2a 83 e8 d1 99 29 01 <0f> 0b b8 fe ff ff ff eb d2 0f 1f 84 00 00 00 00 00 41 57 41 56 41
[   58.076383][ T6743] RSP: 0018:ffffc90001633df0 EFLAGS: 00010286
[   58.078511][ T6743] RAX: 0000000000000000 RBX: ffffffff83805038 RCX: 0000000000000027
[   58.081187][ T6743] RDX: 0000000000000027 RSI: 00000000ffffdfff RDI: ffff88807cbe78b8
[   58.084307][ T6743] RBP: 0000000000000000 R08: ffff88807cbe78b0 R09: 0000000000000000
[   58.087393][ T6743] R10: 0000000000000001 R11: 0000000000000001 R12: ffffffff832b6ce3
[   58.090024][ T6743] R13: 0000000000000001 R14: ffff88801208dfc0 R15: 0000000000000000
[   58.092657][ T6743] FS:  00007f1199de5580(0000) GS:ffff88807ca00000(0000) knlGS:0000000000000000
[   58.095739][ T6743] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[   58.101789][ T6743] CR2: 00007f4a41af3048 CR3: 000000001d68d000 CR4: 00000000001506e0
[   58.104768][ T6743] Call Trace:
[   58.105996][ T6743]  remove_files.isra.0+0x2b/0x60
[   58.107680][ T6743]  sysfs_remove_group+0x38/0x80
[   58.109369][ T6743]  sysfs_remove_groups+0x24/0x40
[   58.111183][ T6743]  __kobject_del+0x1b/0x80
[   58.112672][ T6743]  kobject_del+0xf/0x20
[   58.114169][ T6743]  blk_integrity_del+0x1d/0x30
[   58.116165][ T6743]  del_gendisk+0x3c/0x1d0
[   58.117811][ T6743]  loop_remove+0x10/0x40 [loop]
[   58.119517][ T6743]  loop_control_ioctl+0x1a1/0x1b0 [loop]
[   58.121391][ T6743]  __x64_sys_ioctl+0x6a/0xa0
[   58.122905][ T6743]  do_syscall_64+0x35/0xb0
[   58.124538][ T6743]  entry_SYSCALL_64_after_hwframe+0x44/0xae
[   58.126733][ T6743] RIP: 0033:0x7f1199d0d89d
[   58.128409][ T6743] Code: 00 c3 66 2e 0f 1f 84 00 00 00 00 00 90 f3 0f 1e fa 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 8b 0d c3 f5 0c 00 f7 d8 64 89 01 48
[   58.136499][ T6743] RSP: 002b:00007ffd3c6a4b68 EFLAGS: 00000246 ORIG_RAX: 0000000000000010
[   58.139334][ T6743] RAX: ffffffffffffffda RBX: 431bde82d7b634db RCX: 00007f1199d0d89d
[   58.142078][ T6743] RDX: 0000000000000001 RSI: 0000000000004c81 RDI: 0000000000000005
[   58.144915][ T6743] RBP: 00007ffd3c6a4ba0 R08: 0000000000000000 R09: 0000000000000000
[   58.147621][ T6743] R10: 0000000000000000 R11: 0000000000000246 R12: 00007ffd3c6a4ba0
[   58.150715][ T6743] R13: 000000000000dc57 R14: 00007ffd3c6a4b7c R15: 0000000000000000
[   58.153291][ T6743] irq event stamp: 0
[   58.154750][ T6743] hardirqs last  enabled at (0): [<0000000000000000>] 0x0
[   58.157462][ T6743] hardirqs last disabled at (0): [<ffffffff811262d4>] copy_process+0x984/0x2010
[   58.160664][ T6743] softirqs last  enabled at (0): [<ffffffff811262d4>] copy_process+0x984/0x2010
[   58.163946][ T6743] softirqs last disabled at (0): [<0000000000000000>] 0x0
[   58.168205][ T6743] ---[ end trace b154f08dae0bfe9c ]---
[   58.170103][ T6743] ------------[ cut here ]------------
[   58.171926][ T6743] kernfs: can not remove 'read_verify', no directory
[   58.174109][ T6743] WARNING: CPU: 1 PID: 6743 at fs/kernfs/dir.c:1508 kernfs_remove_by_name_ns+0x6f/0x80
[   58.177522][ T6743] Modules linked in: loop(E)
[   58.179196][ T6743] CPU: 1 PID: 6743 Comm: a.out Tainted: G        W   E     5.14.0-rc7+ #749
[   58.182641][ T6743] Hardware name: VMware, Inc. VMware Virtual Platform/440BX Desktop Reference Platform, BIOS 6.00 02/27/2020
[   58.186674][ T6743] RIP: 0010:kernfs_remove_by_name_ns+0x6f/0x80
[   58.188719][ T6743] Code: bb 38 01 31 c0 5d 41 5c 41 5d c3 48 c7 c7 e0 81 7d 83 e8 54 bb 38 01 b8 fe ff ff ff eb e7 48 c7 c7 50 3c 2a 83 e8 d1 99 29 01 <0f> 0b b8 fe ff ff ff eb d2 0f 1f 84 00 00 00 00 00 41 57 41 56 41
[   58.195913][ T6743] RSP: 0018:ffffc90001633df0 EFLAGS: 00010286
[   58.198936][ T6743] RAX: 0000000000000000 RBX: ffffffff83805040 RCX: 0000000000000027
[   58.202205][ T6743] RDX: 0000000000000027 RSI: 00000000ffffdfff RDI: ffff88807cbe78b8
[   58.205001][ T6743] RBP: 0000000000000000 R08: ffff88807cbe78b0 R09: 0000000000000000
[   58.207572][ T6743] R10: 0000000000000001 R11: 0000000000000001 R12: ffffffff832b6cd7
[   58.210242][ T6743] R13: 0000000000000001 R14: ffff88801208dfc0 R15: 0000000000000000
[   58.212951][ T6743] FS:  00007f1199de5580(0000) GS:ffff88807ca00000(0000) knlGS:0000000000000000
[   58.217251][ T6743] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[   58.219500][ T6743] CR2: 00007f4a41af3048 CR3: 000000001d68d000 CR4: 00000000001506e0
[   58.222253][ T6743] Call Trace:
[   58.223316][ T6743]  remove_files.isra.0+0x2b/0x60
[   58.225064][ T6743]  sysfs_remove_group+0x38/0x80
[   58.226662][ T6743]  sysfs_remove_groups+0x24/0x40
[   58.228382][ T6743]  __kobject_del+0x1b/0x80
[   58.229928][ T6743]  kobject_del+0xf/0x20
[   58.232272][ T6743]  blk_integrity_del+0x1d/0x30
[   58.236728][ T6743]  del_gendisk+0x3c/0x1d0
[   58.238122][ T6743]  loop_remove+0x10/0x40 [loop]
[   58.239822][ T6743]  loop_control_ioctl+0x1a1/0x1b0 [loop]
[   58.241611][ T6743]  __x64_sys_ioctl+0x6a/0xa0
[   58.243024][ T6743]  do_syscall_64+0x35/0xb0
[   58.244702][ T6743]  entry_SYSCALL_64_after_hwframe+0x44/0xae
[   58.246462][ T6743] RIP: 0033:0x7f1199d0d89d
[   58.247814][ T6743] Code: 00 c3 66 2e 0f 1f 84 00 00 00 00 00 90 f3 0f 1e fa 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 8b 0d c3 f5 0c 00 f7 d8 64 89 01 48
[   58.255046][ T6743] RSP: 002b:00007ffd3c6a4b68 EFLAGS: 00000246 ORIG_RAX: 0000000000000010
[   58.258335][ T6743] RAX: ffffffffffffffda RBX: 431bde82d7b634db RCX: 00007f1199d0d89d
[   58.261208][ T6743] RDX: 0000000000000001 RSI: 0000000000004c81 RDI: 0000000000000005
[   58.264295][ T6743] RBP: 00007ffd3c6a4ba0 R08: 0000000000000000 R09: 0000000000000000
[   58.267761][ T6743] R10: 0000000000000000 R11: 0000000000000246 R12: 00007ffd3c6a4ba0
[   58.270599][ T6743] R13: 000000000000dc57 R14: 00007ffd3c6a4b7c R15: 0000000000000000
[   58.273415][ T6743] irq event stamp: 0
[   58.274965][ T6743] hardirqs last  enabled at (0): [<0000000000000000>] 0x0
[   58.277685][ T6743] hardirqs last disabled at (0): [<ffffffff811262d4>] copy_process+0x984/0x2010
[   58.280915][ T6743] softirqs last  enabled at (0): [<ffffffff811262d4>] copy_process+0x984/0x2010
[   58.284267][ T6743] softirqs last disabled at (0): [<0000000000000000>] 0x0
[   58.286752][ T6743] ---[ end trace b154f08dae0bfe9d ]---
[   58.288508][ T6743] ------------[ cut here ]------------
[   58.290354][ T6743] kernfs: can not remove 'write_generate', no directory
[   58.292657][ T6743] WARNING: CPU: 1 PID: 6743 at fs/kernfs/dir.c:1508 kernfs_remove_by_name_ns+0x6f/0x80
[   58.295959][ T6743] Modules linked in: loop(E)
[   58.297762][ T6743] CPU: 1 PID: 6743 Comm: a.out Tainted: G        W   E     5.14.0-rc7+ #749
[   58.305316][ T6743] Hardware name: VMware, Inc. VMware Virtual Platform/440BX Desktop Reference Platform, BIOS 6.00 02/27/2020
[   58.309104][ T6743] RIP: 0010:kernfs_remove_by_name_ns+0x6f/0x80
[   58.311318][ T6743] Code: bb 38 01 31 c0 5d 41 5c 41 5d c3 48 c7 c7 e0 81 7d 83 e8 54 bb 38 01 b8 fe ff ff ff eb e7 48 c7 c7 50 3c 2a 83 e8 d1 99 29 01 <0f> 0b b8 fe ff ff ff eb d2 0f 1f 84 00 00 00 00 00 41 57 41 56 41
[   58.318333][ T6743] RSP: 0018:ffffc90001633df0 EFLAGS: 00010286
[   58.320422][ T6743] RAX: 0000000000000000 RBX: ffffffff83805048 RCX: 0000000000000027
[   58.322980][ T6743] RDX: 0000000000000027 RSI: 00000000ffffdfff RDI: ffff88807cbe78b8
[   58.326021][ T6743] RBP: 0000000000000000 R08: ffff88807cbe78b0 R09: 0000000000000000
[   58.328989][ T6743] R10: 0000000000000001 R11: 0000000000000001 R12: ffffffff832b6cc8
[   58.333216][ T6743] R13: 0000000000000001 R14: ffff88801208dfc0 R15: 0000000000000000
[   58.336144][ T6743] FS:  00007f1199de5580(0000) GS:ffff88807ca00000(0000) knlGS:0000000000000000
[   58.339067][ T6743] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[   58.341185][ T6743] CR2: 00007f4a41af3048 CR3: 000000001d68d000 CR4: 00000000001506e0
[   58.344024][ T6743] Call Trace:
[   58.345458][ T6743]  remove_files.isra.0+0x2b/0x60
[   58.347259][ T6743]  sysfs_remove_group+0x38/0x80
[   58.349310][ T6743]  sysfs_remove_groups+0x24/0x40
[   58.351049][ T6743]  __kobject_del+0x1b/0x80
[   58.352405][ T6743]  kobject_del+0xf/0x20
[   58.353801][ T6743]  blk_integrity_del+0x1d/0x30
[   58.355441][ T6743]  del_gendisk+0x3c/0x1d0
[   58.356886][ T6743]  loop_remove+0x10/0x40 [loop]
[   58.358434][ T6743]  loop_control_ioctl+0x1a1/0x1b0 [loop]
[   58.360475][ T6743]  __x64_sys_ioctl+0x6a/0xa0
[   58.362207][ T6743]  do_syscall_64+0x35/0xb0
[   58.364024][ T6743]  entry_SYSCALL_64_after_hwframe+0x44/0xae
[   58.367281][ T6743] RIP: 0033:0x7f1199d0d89d
[   58.368860][ T6743] Code: 00 c3 66 2e 0f 1f 84 00 00 00 00 00 90 f3 0f 1e fa 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 8b 0d c3 f5 0c 00 f7 d8 64 89 01 48
[   58.375338][ T6743] RSP: 002b:00007ffd3c6a4b68 EFLAGS: 00000246 ORIG_RAX: 0000000000000010
[   58.378157][ T6743] RAX: ffffffffffffffda RBX: 431bde82d7b634db RCX: 00007f1199d0d89d
[   58.380858][ T6743] RDX: 0000000000000001 RSI: 0000000000004c81 RDI: 0000000000000005
[   58.384278][ T6743] RBP: 00007ffd3c6a4ba0 R08: 0000000000000000 R09: 0000000000000000
[   58.387384][ T6743] R10: 0000000000000000 R11: 0000000000000246 R12: 00007ffd3c6a4ba0
[   58.390188][ T6743] R13: 000000000000dc57 R14: 00007ffd3c6a4b7c R15: 0000000000000000
[   58.393211][ T6743] irq event stamp: 0
[   58.394873][ T6743] hardirqs last  enabled at (0): [<0000000000000000>] 0x0
[   58.397596][ T6743] hardirqs last disabled at (0): [<ffffffff811262d4>] copy_process+0x984/0x2010
[   58.402257][ T6743] softirqs last  enabled at (0): [<ffffffff811262d4>] copy_process+0x984/0x2010
[   58.405594][ T6743] softirqs last disabled at (0): [<0000000000000000>] 0x0
[   58.407966][ T6743] ---[ end trace b154f08dae0bfe9e ]---
[   58.409864][ T6743] ------------[ cut here ]------------
[   58.411743][ T6743] kernfs: can not remove 'device_is_integrity_capable', no directory
[   58.414502][ T6743] WARNING: CPU: 1 PID: 6743 at fs/kernfs/dir.c:1508 kernfs_remove_by_name_ns+0x6f/0x80
[   58.418733][ T6743] Modules linked in: loop(E)
[   58.420290][ T6743] CPU: 1 PID: 6743 Comm: a.out Tainted: G        W   E     5.14.0-rc7+ #749
[   58.423113][ T6743] Hardware name: VMware, Inc. VMware Virtual Platform/440BX Desktop Reference Platform, BIOS 6.00 02/27/2020
[   58.427386][ T6743] RIP: 0010:kernfs_remove_by_name_ns+0x6f/0x80
[   58.429510][ T6743] Code: bb 38 01 31 c0 5d 41 5c 41 5d c3 48 c7 c7 e0 81 7d 83 e8 54 bb 38 01 b8 fe ff ff ff eb e7 48 c7 c7 50 3c 2a 83 e8 d1 99 29 01 <0f> 0b b8 fe ff ff ff eb d2 0f 1f 84 00 00 00 00 00 41 57 41 56 41
[   58.439072][ T6743] RSP: 0018:ffffc90001633df0 EFLAGS: 00010286
[   58.441062][ T6743] RAX: 0000000000000000 RBX: ffffffff83805050 RCX: 0000000000000027
[   58.443588][ T6743] RDX: 0000000000000027 RSI: 00000000ffffdfff RDI: ffff88807cbe78b8
[   58.446972][ T6743] RBP: 0000000000000000 R08: ffff88807cbe78b0 R09: 0000000000000000
[   58.450085][ T6743] R10: 0000000000000001 R11: 0000000000000001 R12: ffffffff832b6cac
[   58.452711][ T6743] R13: 0000000000000001 R14: ffff88801208dfc0 R15: 0000000000000000
[   58.455398][ T6743] FS:  00007f1199de5580(0000) GS:ffff88807ca00000(0000) knlGS:0000000000000000
[   58.458350][ T6743] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[   58.460682][ T6743] CR2: 00007f4a41af3048 CR3: 000000001d68d000 CR4: 00000000001506e0
[   58.463531][ T6743] Call Trace:
[   58.465589][ T6743]  remove_files.isra.0+0x2b/0x60
[   58.468652][ T6743]  sysfs_remove_group+0x38/0x80
[   58.470317][ T6743]  sysfs_remove_groups+0x24/0x40
[   58.471864][ T6743]  __kobject_del+0x1b/0x80
[   58.473276][ T6743]  kobject_del+0xf/0x20
[   58.474797][ T6743]  blk_integrity_del+0x1d/0x30
[   58.476335][ T6743]  del_gendisk+0x3c/0x1d0
[   58.477852][ T6743]  loop_remove+0x10/0x40 [loop]
[   58.479488][ T6743]  loop_control_ioctl+0x1a1/0x1b0 [loop]
[   58.481469][ T6743]  __x64_sys_ioctl+0x6a/0xa0
[   58.483516][ T6743]  do_syscall_64+0x35/0xb0
[   58.485186][ T6743]  entry_SYSCALL_64_after_hwframe+0x44/0xae
[   58.486984][ T6743] RIP: 0033:0x7f1199d0d89d
[   58.488359][ T6743] Code: 00 c3 66 2e 0f 1f 84 00 00 00 00 00 90 f3 0f 1e fa 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 8b 0d c3 f5 0c 00 f7 d8 64 89 01 48
[   58.495307][ T6743] RSP: 002b:00007ffd3c6a4b68 EFLAGS: 00000246 ORIG_RAX: 0000000000000010
[   58.501911][ T6743] RAX: ffffffffffffffda RBX: 431bde82d7b634db RCX: 00007f1199d0d89d
[   58.504713][ T6743] RDX: 0000000000000001 RSI: 0000000000004c81 RDI: 0000000000000005
[   58.507431][ T6743] RBP: 00007ffd3c6a4ba0 R08: 0000000000000000 R09: 0000000000000000
[   58.510259][ T6743] R10: 0000000000000000 R11: 0000000000000246 R12: 00007ffd3c6a4ba0
[   58.513018][ T6743] R13: 000000000000dc57 R14: 00007ffd3c6a4b7c R15: 0000000000000000
[   58.516976][ T6743] irq event stamp: 0
[   58.518276][ T6743] hardirqs last  enabled at (0): [<0000000000000000>] 0x0
[   58.520709][ T6743] hardirqs last disabled at (0): [<ffffffff811262d4>] copy_process+0x984/0x2010
[   58.523953][ T6743] softirqs last  enabled at (0): [<ffffffff811262d4>] copy_process+0x984/0x2010
[   58.526884][ T6743] softirqs last disabled at (0): [<0000000000000000>] 0x0
[   58.529328][ T6743] ---[ end trace b154f08dae0bfe9f ]---
[   58.531361][ T6743] ------------[ cut here ]------------
[   58.535516][ T6743] kernfs: can not remove 'bdi', no directory
[   58.537520][ T6743] WARNING: CPU: 1 PID: 6743 at fs/kernfs/dir.c:1508 kernfs_remove_by_name_ns+0x6f/0x80
[   58.540812][ T6743] Modules linked in: loop(E)
[   58.542259][ T6743] CPU: 1 PID: 6743 Comm: a.out Tainted: G        W   E     5.14.0-rc7+ #749
[   58.545443][ T6743] Hardware name: VMware, Inc. VMware Virtual Platform/440BX Desktop Reference Platform, BIOS 6.00 02/27/2020
[   58.549422][ T6743] RIP: 0010:kernfs_remove_by_name_ns+0x6f/0x80
[   58.551525][ T6743] Code: bb 38 01 31 c0 5d 41 5c 41 5d c3 48 c7 c7 e0 81 7d 83 e8 54 bb 38 01 b8 fe ff ff ff eb e7 48 c7 c7 50 3c 2a 83 e8 d1 99 29 01 <0f> 0b b8 fe ff ff ff eb d2 0f 1f 84 00 00 00 00 00 41 57 41 56 41
[   58.558869][ T6743] RSP: 0018:ffffc90001633e88 EFLAGS: 00010282
[   58.561018][ T6743] RAX: 0000000000000000 RBX: ffff88800e505800 RCX: 0000000000000027
[   58.563747][ T6743] RDX: 0000000000000027 RSI: 00000000ffffdfff RDI: ffff88807cbe78b8
[   58.567899][ T6743] RBP: ffff888019562c40 R08: ffff88807cbe78b0 R09: 0000000000000000
[   58.570718][ T6743] R10: 0000000000000001 R11: 0000000000000001 R12: ffffffff83290587
[   58.573295][ T6743] R13: 0000000000000001 R14: ffff88801208dfc0 R15: 0000000000000000
[   58.577017][ T6743] FS:  00007f1199de5580(0000) GS:ffff88807ca00000(0000) knlGS:0000000000000000
[   58.580048][ T6743] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[   58.582390][ T6743] CR2: 00007f4a41af3048 CR3: 000000001d68d000 CR4: 00000000001506e0
[   58.585500][ T6743] Call Trace:
[   58.586566][ T6743]  del_gendisk+0x1b3/0x1d0
[   58.588063][ T6743]  loop_remove+0x10/0x40 [loop]
[   58.589669][ T6743]  loop_control_ioctl+0x1a1/0x1b0 [loop]
[   58.591579][ T6743]  __x64_sys_ioctl+0x6a/0xa0
[   58.593114][ T6743]  do_syscall_64+0x35/0xb0
[   58.595256][ T6743]  entry_SYSCALL_64_after_hwframe+0x44/0xae
[   58.597709][ T6743] RIP: 0033:0x7f1199d0d89d
[   58.599860][ T6743] Code: 00 c3 66 2e 0f 1f 84 00 00 00 00 00 90 f3 0f 1e fa 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 8b 0d c3 f5 0c 00 f7 d8 64 89 01 48
[   58.606860][ T6743] RSP: 002b:00007ffd3c6a4b68 EFLAGS: 00000246 ORIG_RAX: 0000000000000010
[   58.609623][ T6743] RAX: ffffffffffffffda RBX: 431bde82d7b634db RCX: 00007f1199d0d89d
[   58.612461][ T6743] RDX: 0000000000000001 RSI: 0000000000004c81 RDI: 0000000000000005
[   58.617000][ T6743] RBP: 00007ffd3c6a4ba0 R08: 0000000000000000 R09: 0000000000000000
[   58.619703][ T6743] R10: 0000000000000000 R11: 0000000000000246 R12: 00007ffd3c6a4ba0
[   58.622204][ T6743] R13: 000000000000dc57 R14: 00007ffd3c6a4b7c R15: 0000000000000000
[   58.625194][ T6743] irq event stamp: 0
[   58.626979][ T6743] hardirqs last  enabled at (0): [<0000000000000000>] 0x0
[   58.629419][ T6743] hardirqs last disabled at (0): [<ffffffff811262d4>] copy_process+0x984/0x2010
[   58.637066][ T6743] softirqs last  enabled at (0): [<ffffffff811262d4>] copy_process+0x984/0x2010
[   58.640146][ T6743] softirqs last disabled at (0): [<0000000000000000>] 0x0
[   58.642448][ T6743] ---[ end trace b154f08dae0bfea0 ]---
[   58.644743][ T6743] BUG: kernel NULL pointer dereference, address: 0000000000000110
[   58.647371][ T6743] #PF: supervisor read access in kernel mode
[   58.649595][ T6743] #PF: error_code(0x0000) - not-present page
[   58.651527][ T6743] PGD e6cf067 P4D e6cf067 PUD 1d69b067 PMD 0 
[   58.653403][ T6743] Oops: 0000 [#1] PREEMPT SMP
[   58.655058][ T6743] CPU: 1 PID: 6743 Comm: a.out Tainted: G        W   E     5.14.0-rc7+ #749
[   58.657741][ T6743] Hardware name: VMware, Inc. VMware Virtual Platform/440BX Desktop Reference Platform, BIOS 6.00 02/27/2020
[   58.661484][ T6743] RIP: 0010:device_del+0x46/0x410
[   58.663064][ T6743] Code: 48 89 ef 65 48 8b 04 25 28 00 00 00 48 89 44 24 10 31 c0 e8 4c fb 07 01 8b 05 52 96 2d 02 85 c0 0f 85 8c 03 00 00 48 8b 53 48 <0f> b6 82 10 01 00 00 a8 01 75 09 83 c8 01 88 82 10 01 00 00 48 89
[   58.672214][ T6743] RSP: 0018:ffffc90001633e80 EFLAGS: 00010246
[   58.674192][ T6743] RAX: 0000000000000000 RBX: ffff888019562c80 RCX: 0000000000000000
[   58.676821][ T6743] RDX: 0000000000000000 RSI: ffffffff817738d4 RDI: 0000000000000000
[   58.679648][ T6743] RBP: ffff888019562da0 R08: 0000000000000000 R09: 0000000000000001
[   58.682572][ T6743] R10: ffffc90001633e80 R11: ffff88800f62b838 R12: 0000000000000000
[   58.685825][ T6743] R13: 0000000000000001 R14: ffff88801208dfc0 R15: 0000000000000000
[   58.688554][ T6743] FS:  00007f1199de5580(0000) GS:ffff88807ca00000(0000) knlGS:0000000000000000
[   58.691499][ T6743] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[   58.693581][ T6743] CR2: 0000000000000110 CR3: 000000001d68d000 CR4: 00000000001506e0
[   58.696457][ T6743] Call Trace:
[   58.697916][ T6743]  ? kernfs_remove_by_name_ns+0x5c/0x80
[   58.703342][ T6743]  loop_remove+0x10/0x40 [loop]
[   58.705048][ T6743]  loop_control_ioctl+0x1a1/0x1b0 [loop]
[   58.706932][ T6743]  __x64_sys_ioctl+0x6a/0xa0
[   58.708429][ T6743]  do_syscall_64+0x35/0xb0
[   58.709868][ T6743]  entry_SYSCALL_64_after_hwframe+0x44/0xae
[   58.711987][ T6743] RIP: 0033:0x7f1199d0d89d
[   58.713428][ T6743] Code: 00 c3 66 2e 0f 1f 84 00 00 00 00 00 90 f3 0f 1e fa 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 8b 0d c3 f5 0c 00 f7 d8 64 89 01 48
[   58.720308][ T6743] RSP: 002b:00007ffd3c6a4b68 EFLAGS: 00000246 ORIG_RAX: 0000000000000010
[   58.722928][ T6743] RAX: ffffffffffffffda RBX: 431bde82d7b634db RCX: 00007f1199d0d89d
[   58.726121][ T6743] RDX: 0000000000000001 RSI: 0000000000004c81 RDI: 0000000000000005
[   58.728838][ T6743] RBP: 00007ffd3c6a4ba0 R08: 0000000000000000 R09: 0000000000000000
[   58.731837][ T6743] R10: 0000000000000000 R11: 0000000000000246 R12: 00007ffd3c6a4ba0
[   58.735598][ T6743] R13: 000000000000dc57 R14: 00007ffd3c6a4b7c R15: 0000000000000000
[   58.738251][ T6743] Modules linked in: loop(E)
[   58.739747][ T6743] CR2: 0000000000000110
[   58.741153][ T6743] ---[ end trace b154f08dae0bfea1 ]---
[   58.743734][ T6743] RIP: 0010:device_del+0x46/0x410
[   58.747855][ T6743] Code: 48 89 ef 65 48 8b 04 25 28 00 00 00 48 89 44 24 10 31 c0 e8 4c fb 07 01 8b 05 52 96 2d 02 85 c0 0f 85 8c 03 00 00 48 8b 53 48 <0f> b6 82 10 01 00 00 a8 01 75 09 83 c8 01 88 82 10 01 00 00 48 89
[   58.759456][ T6743] RSP: 0018:ffffc90001633e80 EFLAGS: 00010246
[   58.762723][ T6743] RAX: 0000000000000000 RBX: ffff888019562c80 RCX: 0000000000000000
[   58.767547][ T6743] RDX: 0000000000000000 RSI: ffffffff817738d4 RDI: 0000000000000000
[   58.771715][ T6743] RBP: ffff888019562da0 R08: 0000000000000000 R09: 0000000000000001
[   58.774548][ T6743] R10: ffffc90001633e80 R11: ffff88800f62b838 R12: 0000000000000000
[   58.777158][ T6743] R13: 0000000000000001 R14: ffff88801208dfc0 R15: 0000000000000000
[   58.779874][ T6743] FS:  00007f1199de5580(0000) GS:ffff88807ca00000(0000) knlGS:0000000000000000
[   58.783119][ T6743] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[   58.785333][ T6743] CR2: 0000000000000110 CR3: 000000001d68d000 CR4: 00000000001506e0
[   58.787951][ T6743] Kernel panic - not syncing: Fatal exception
[   58.790104][ T6743] Kernel Offset: disabled
[   58.796812][ T6743] Rebooting in 10 seconds..
----------------------------------------
