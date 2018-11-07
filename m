Return-Path: <jianchao.w.wang@oracle.com>
Subject: Re: [LKP] a9f38e1dec [ 245.678853] INFO: task mount:580 blocked for
 more than 120 seconds.
To: kernel test robot <rong.a.chen@intel.com>, Omar Sandoval <osandov@fb.com>
Cc: Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org, LKP <lkp@01.org>
References: <20181107031643.GD24195@shao2-debian>
From: "jianchao.wang" <jianchao.w.wang@oracle.com>
Message-ID: <f5f81267-0aea-4ae1-0112-88279598eb07@oracle.com>
Date: Wed, 7 Nov 2018 16:22:20 +0800
MIME-Version: 1.0
In-Reply-To: <20181107031643.GD24195@shao2-debian>
Content-Type: text/plain; charset=windows-1252
List-ID: <linux-block@vger.kernel.org>



On 11/7/18 11:16 AM, kernel test robot wrote:
> Greetings,
> 
> 0day kernel testing robot got the below dmesg and the first bad commit is
> 
> https://urldefense.proofpoint.com/v2/url?u=https-3A__git.kernel.org_pub_scm_linux_kernel_git_torvalds_linux.git&d=DwIBaQ&c=RoP1YumCXCgaWHvlZYR8PZh8Bv7qIrMUB65eapI_JnE&r=7WdAxUBeiTUTCy8v-7zXyr4qk7sx26ATvfo6QSTvZyQ&m=8qsZc_c8QfZOGoITiebvlt5BO9GBK61cAY4xLOCegFU&s=ZGRhkdRCPvSKvbZzx-HAQtWcDZfzce60e2TMvBQyORo&e= master
> 
> commit a9f38e1dec107af70d81338332494bf0a1e76597
> Author:     Omar Sandoval <osandov@fb.com>
> AuthorDate: Mon Oct 15 09:21:34 2018 -0600
> Commit:     Jens Axboe <axboe@kernel.dk>
> CommitDate: Tue Oct 16 09:50:14 2018 -0600
> 
>     floppy: convert to blk-mq
>     
>     This driver likes to fetch requests from all over the place, so make
>     queue_rq put requests on a list so that the logic stays the same. Tested
>     with QEMU.
>     
>     Signed-off-by: Omar Sandoval <osandov@fb.com>
>     
>     Converted to blk_mq_init_sq_queue() and fixed a few spots where the
>     tag_set leaked on cleanup.
>     
>     Signed-off-by: Jens Axboe <axboe@kernel.dk>
> 
> 6ec3938cff  ataflop: convert to blk-mq
> a9f38e1dec  floppy: convert to blk-mq
> 8053e5b93e  Merge tag 'trace-v4.20-rc1' of git://git.kernel.org/pub/scm/linux/kernel/git/rostedt/linux-trace
> 337734cbca  Add linux-next specific files for 20181106
> +---------------------------------------------------------+------------+------------+------------+---------------+
> |                                                         | 6ec3938cff | a9f38e1dec | 8053e5b93e | next-20181106 |
> +---------------------------------------------------------+------------+------------+------------+---------------+
> | boot_successes                                          | 251        | 68         | 69         | 74            |
> | boot_failures                                           | 48         | 27         | 25         | 23            |
> | Mem-Info                                                | 48         | 12         | 15         | 7             |
> | invoked_oom-killer:gfp_mask=0x                          | 6          | 4          | 3          | 2             |
> | EIP:iov_iter_fault_in_readable                          | 4          | 1          |            |               |
> | Out_of_memory:Kill_process                              | 3          | 2          | 2          |               |
> | Out_of_memory_and_no_killable_processes                 | 3          | 2          | 2          |               |
> | Kernel_panic-not_syncing:System_is_deadlocked_on_memory | 3          | 2          | 2          |               |
> | EIP:__put_user_4                                        | 1          |            |            |               |
> | INFO:task_blocked_for_more_than#seconds                 | 0          | 15         | 10         | 16            |
> | EIP:lock_is_held_type                                   | 0          | 1          | 0          | 1             |
> | EIP:native_safe_halt                                    | 0          | 3          |            |               |
> | Kernel_panic-not_syncing:hung_task:blocked_tasks        | 0          | 15         | 10         | 16            |
> | EIP:strnlen_user                                        | 0          | 1          |            |               |
> | EIP:_local_bh_enable                                    | 0          | 1          |            |               |
> | EIP:__lock_acquire                                      | 0          | 1          | 1          | 1             |
> | EIP:vprintk_emit                                        | 0          | 1          |            |               |
> | EIP:do_softirq_own_stack                                | 0          | 0          | 1          |               |
> | EIP:default_idle                                        | 0          | 0          | 2          | 1             |
> | EIP:reschedule_interrupt                                | 0          | 0          | 1          |               |
> | EIP:delay_tsc                                           | 0          | 0          | 0          | 1             |
> | EIP:copy_page_from_iter                                 | 0          | 0          | 0          | 1             |
> | EIP:_cond_resched                                       | 0          | 0          | 0          | 1             |
> +---------------------------------------------------------+------------+------------+------------+---------------+
> 
> [  244.196551] random: get_random_u32 called from arch_align_stack+0x2d/0x40 with crng_init=1
> [  245.254485] _warn_unseeded_randomness: 54 callbacks suppressed
> [  245.254491] random: get_random_u32 called from copy_process+0x1c8/0x17b0 with crng_init=1
> [  245.257366] random: get_random_u32 called from arch_pick_mmap_layout+0x110/0x140 with crng_init=1
> [  245.258675] random: get_random_u32 called from load_elf_binary+0x2b6/0xb48 with crng_init=1
> [  245.678853] INFO: task mount:580 blocked for more than 120 seconds.
> [  245.679906]       Tainted: G                T 4.19.0-rc6-00172-ga9f38e1 #1
> [  245.680959] "echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
> [  245.682181] mount           D 6372   580      1 0x00000004
> [  245.683023] Call Trace:
> [  245.683425]  __schedule+0x2df/0x570
> [  245.683975]  schedule+0x2d/0x80
> [  245.684476]  schedule_timeout+0x19d/0x330
> [  245.685090]  ? wait_for_common+0xa5/0x170
> [  245.685735]  wait_for_common+0xac/0x170
> [  245.686339]  ? do_sched_yield+0x90/0x90
> [  245.686935]  wait_for_completion+0x12/0x20
> [  245.687571]  __floppy_read_block_0+0xfb/0x150
> [  245.688244]  ? floppy_resume+0x40/0x40
> [  245.688844]  floppy_revalidate+0x20f/0x240
> [  245.689486]  check_disk_change+0x43/0x60
> [  245.690087]  floppy_open+0x1ea/0x360
> [  245.690653]  __blkdev_get+0xb4/0x4d0
> [  245.691212]  ? blkdev_get+0x1db/0x370
> [  245.691777]  blkdev_get+0x1f3/0x370
> [  245.692351]  ? path_put+0x15/0x20
> [  245.692871]  ? lookup_bdev+0x4b/0x90
> [  245.693539]  blkdev_get_by_path+0x3d/0x80
> [  245.694165]  mount_bdev+0x2a/0x190
> [  245.694695]  squashfs_mount+0x10/0x20
> [  245.695271]  ? squashfs_alloc_inode+0x30/0x30
> [  245.695960]  mount_fs+0xf/0x90
> [  245.696451]  vfs_kern_mount+0x43/0x130
> [  245.697036]  do_mount+0x187/0xc40
> [  245.697563]  ? memdup_user+0x28/0x50
> [  245.698124]  ksys_mount+0x60/0xc0
> [  245.698639]  sys_mount+0x19/0x20
> [  245.699167]  do_int80_syscall_32+0x61/0x130
> [  245.699813]  entry_INT80_32+0xc7/0xc7
> [  245.700391] EIP: 0x47f46fee
> [  245.700829] Code: 11 83 c8 ff eb e2 90 90 90 90 90 90 57 56 53 8b 7c 24 20 8b 74 24 1c 8b 54 24 18 8b 4c 24 14 8b 5c 24 10 b8 15 00 00 00 cd 80 <5b> 5e 5f 3d 01 f0 ff ff 73 01 c3 e8 e8 80 03 00 81 c1 f6 5f 09 00
> [  245.703680] EAX: ffffffda EBX: affa4efa ECX: affa4f03 EDX: 080d3630
> [  245.704642] ESI: 00008010 EDI: 00000000 EBP: 00000000 ESP: affa45c0
> [  245.705637] DS: 007b ES: 007b FS: 0000 GS: 0033 SS: 007b EFLAGS: 00000282

There is not a q->queue_lock as blk-legacy to serialize floppy_queue_rq from different contexts.

Thanks
Jianchao
