Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED57D2820D7;
	Fri, 20 Jun 2025 09:28:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750411710; cv=none; b=f3Y2bUA1VCUt+R9FQUiFewYrFZEmL8nnAw6DWqqsjsRu7BNVrndiOcYDiqAxRyi+bHnZytESl7np065P+j/9misGtDKQefSa288FC1dUR+s9LxulSDFsryJFL9/zDtd7VrCMGRNp1P+MxFYuqI8M5Yt9XtB8BFdcQhcFoSq01bs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750411710; c=relaxed/simple;
	bh=knVDR/Pst0l0QQNgdTPf2UPxlZW5sCob3oxd2wHjePI=;
	h=Subject:To:References:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=OvaXWnRzI0ba6Vi9yDfoxvm4gHY8HYRqR1ghHigMApYdCvF4d6VlBaJZUTnV+HCinJO9uLEtsSlo9BpguPkul7WfcwEM5tnlgvAYwrVloLy2Eea4DrWB3dWI23MzCmGcRF1dZTZjlCARQ0uICitqg9JlmSbWJhRgUZV4tx3fvco=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.235])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTPS id 4bNsbR5CJMzYQv21;
	Fri, 20 Jun 2025 17:28:19 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.128])
	by mail.maildlp.com (Postfix) with ESMTP id A6EF41A0C2D;
	Fri, 20 Jun 2025 17:28:18 +0800 (CST)
Received: from [10.174.179.143] (unknown [10.174.179.143])
	by APP4 (Coremail) with SMTP id gCh0CgBXvGCtKVVo5jVfQA--.2368S3;
	Fri, 20 Jun 2025 17:28:14 +0800 (CST)
Subject: Re: [syzbot] [block?] possible deadlock in bdev_release
To: syzbot <syzbot+2bcecf3c38cb3e8fdc8d@syzkaller.appspotmail.com>,
 axboe@kernel.dk, linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
 syzkaller-bugs@googlegroups.com, Ming Lei <ming.lei@redhat.com>,
 "yukuai (C)" <yukuai3@huawei.com>
References: <6855034f.a00a0220.137b3.0031.GAE@google.com>
From: Yu Kuai <yukuai1@huaweicloud.com>
Message-ID: <c572fb51-80ca-b664-2c9d-493d7caca1f5@huaweicloud.com>
Date: Fri, 20 Jun 2025 17:28:13 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.1
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <6855034f.a00a0220.137b3.0031.GAE@google.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:gCh0CgBXvGCtKVVo5jVfQA--.2368S3
X-Coremail-Antispam: 1UD129KBjvJXoWfJrW8WrWktF4DJr17Kr45ZFb_yoWkJr15pF
	W5WFZ7JrWjq348ZayIqw1a9ry8Zw15Cw13CFn7tr1rAFsIkr17Jw1vvFsxWryDKr92yF9x
	t3Z8WFW093WUXrDanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUvjb4IE77IF4wAFF20E14v26r4j6ryUM7CY07I20VC2zVCF04k2
	6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4
	vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Ar0_tr1l84ACjcxK6xIIjxv20xvEc7Cj
	xVAFwI0_Gr1j6F4UJwA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x
	0267AKxVW0oVCq3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG
	6I80ewAv7VC0I7IYx2IY67AKxVWUJVWUGwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFV
	Cjc4AY6r1j6r4UM4x0Y48IcVAKI48JMxk0xIA0c2IEe2xFo4CEbIxvr21lc7CjxVAaw2AF
	wI0_JF0_Jw1l42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4
	xG67AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r126r1D
	MIIYrxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6xkF7I
	0E14v26r1j6r4UMIIF0xvE42xK8VAvwI8IcIk0rVWUJVWUCwCI42IY6I8E87Iv67AKxVWU
	JVW8JwCI42IY6I8E87Iv6xkF7I0E14v26r4j6r4UJbIYCTnIWIevJa73UjIFyTuYvjxUwx
	hLUUUUU
X-CM-SenderInfo: 51xn3trlr6x35dzhxuhorxvhhfrp/

Hi,

+CC Ming

在 2025/06/20 14:44, syzbot 写道:
> Hello,
> 
> syzbot found the following issue on:
> 
> HEAD commit:    306e57988197 Merge patch "riscv: defconfig: run savedefcon..
> git tree:       git://git.kernel.org/pub/scm/linux/kernel/git/riscv/linux.git for-next
> console output: https://syzkaller.appspot.com/x/log.txt?x=12cc0182580000
> kernel config:  https://syzkaller.appspot.com/x/.config?x=618b9468db3872f5
> dashboard link: https://syzkaller.appspot.com/bug?extid=2bcecf3c38cb3e8fdc8d
> compiler:       riscv64-linux-gnu-gcc (Debian 12.2.0-13) 12.2.0, GNU ld (GNU Binutils for Debian) 2.40
> userspace arch: riscv64
> 
> Unfortunately, I don't have any reproducer for this issue yet.
> 
> Downloadable assets:
> disk image (non-bootable): https://storage.googleapis.com/syzbot-assets/a741b348759c/non_bootable_disk-306e5798.raw.xz
> vmlinux: https://storage.googleapis.com/syzbot-assets/5fee9bbe87f3/vmlinux-306e5798.xz
> kernel image: https://storage.googleapis.com/syzbot-assets/e959580bb405/Image-306e5798.xz
> 
> IMPORTANT: if you fix the issue, please add the following tag to the commit:
> Reported-by: syzbot+2bcecf3c38cb3e8fdc8d@syzkaller.appspotmail.com
> 
> ======================================================
> WARNING: possible circular locking dependency detected
> 6.16.0-rc1-syzkaller-g306e57988197 #0 Not tainted
> ------------------------------------------------------
> syz.1.344/5839 is trying to acquire lock:
> ffffaf8019912a30 (&nbd->config_lock){+.+.}-{4:4}, at: refcount_dec_and_mutex_lock+0x60/0xd8 lib/refcount.c:118
> 
> but task is already holding lock:
> ffffaf8019fae358 (&disk->open_mutex){+.+.}-{4:4}, at: bdev_release+0x12c/0x600 block/bdev.c:1128
> 
> which lock already depends on the new lock.
> 
> 
> the existing dependency chain (in reverse order) is:
> 
> -> #2 (&disk->open_mutex){+.+.}-{4:4}:
>         lock_acquire kernel/locking/lockdep.c:5871 [inline]
>         lock_acquire+0x1ac/0x448 kernel/locking/lockdep.c:5828
>         __mutex_lock_common kernel/locking/mutex.c:602 [inline]
>         __mutex_lock+0x166/0x1292 kernel/locking/mutex.c:747
>         mutex_lock_nested+0x14/0x1c kernel/locking/mutex.c:799
>         __del_gendisk+0x132/0xac6 block/genhd.c:706
>         del_gendisk+0xf6/0x19a block/genhd.c:819
>         nbd_dev_remove+0x3c/0xf2 drivers/block/nbd.c:268
>         nbd_dev_remove_work+0x1c/0x26 drivers/block/nbd.c:284
>         process_one_work+0x96a/0x1f32 kernel/workqueue.c:3238
>         process_scheduled_works kernel/workqueue.c:3321 [inline]
>         worker_thread+0x5ce/0xde8 kernel/workqueue.c:3402
>         kthread+0x39c/0x7d4 kernel/kthread.c:464
>         ret_from_fork_kernel+0x2a/0xbb2 arch/riscv/kernel/process.c:214
>         ret_from_fork_kernel_asm+0x16/0x18 arch/riscv/kernel/entry.S:327
> 
> -> #1 (&set->update_nr_hwq_lock){++++}-{4:4}:
>         lock_acquire kernel/locking/lockdep.c:5871 [inline]
>         lock_acquire+0x1ac/0x448 kernel/locking/lockdep.c:5828
>         down_write+0x9c/0x19a kernel/locking/rwsem.c:1577
>         blk_mq_update_nr_hw_queues+0x3e/0xb86 block/blk-mq.c:5041
>         nbd_start_device+0x140/0xb2c drivers/block/nbd.c:1476
>         nbd_genl_connect+0xae0/0x1b24 drivers/block/nbd.c:2201
>         genl_family_rcv_msg_doit+0x206/0x2e6 net/netlink/genetlink.c:1115
>         genl_family_rcv_msg net/netlink/genetlink.c:1195 [inline]
>         genl_rcv_msg+0x514/0x78e net/netlink/genetlink.c:1210
>         netlink_rcv_skb+0x206/0x3be net/netlink/af_netlink.c:2534
>         genl_rcv+0x36/0x4c net/netlink/genetlink.c:1219
>         netlink_unicast_kernel net/netlink/af_netlink.c:1313 [inline]
>         netlink_unicast+0x4f0/0x82c net/netlink/af_netlink.c:1339
>         netlink_sendmsg+0x85e/0xdd6 net/netlink/af_netlink.c:1883
>         sock_sendmsg_nosec net/socket.c:712 [inline]
>         __sock_sendmsg+0xcc/0x160 net/socket.c:727
>         ____sys_sendmsg+0x63e/0x79c net/socket.c:2566
>         ___sys_sendmsg+0x144/0x1e6 net/socket.c:2620
>         __sys_sendmsg+0x188/0x246 net/socket.c:2652
>         __do_sys_sendmsg net/socket.c:2657 [inline]
>         __se_sys_sendmsg net/socket.c:2655 [inline]
>         __riscv_sys_sendmsg+0x70/0xa2 net/socket.c:2655
>         syscall_handler+0x94/0x118 arch/riscv/include/asm/syscall.h:112
>         do_trap_ecall_u+0x396/0x530 arch/riscv/kernel/traps.c:341
>         handle_exception+0x146/0x152 arch/riscv/kernel/entry.S:197
> 
> -> #0 (&nbd->config_lock){+.+.}-{4:4}:
>         check_noncircular+0x132/0x146 kernel/locking/lockdep.c:2178
>         check_prev_add kernel/locking/lockdep.c:3168 [inline]
>         check_prevs_add kernel/locking/lockdep.c:3287 [inline]
>         validate_chain kernel/locking/lockdep.c:3911 [inline]
>         __lock_acquire+0x12b2/0x24ea kernel/locking/lockdep.c:5240
>         lock_acquire kernel/locking/lockdep.c:5871 [inline]
>         lock_acquire+0x1ac/0x448 kernel/locking/lockdep.c:5828
>         __mutex_lock_common kernel/locking/mutex.c:602 [inline]
>         __mutex_lock+0x166/0x1292 kernel/locking/mutex.c:747
>         mutex_lock_nested+0x14/0x1c kernel/locking/mutex.c:799
>         refcount_dec_and_mutex_lock+0x60/0xd8 lib/refcount.c:118
>         nbd_config_put+0x3a/0x610 drivers/block/nbd.c:1423
>         nbd_release+0x94/0x15c drivers/block/nbd.c:1735
>         blkdev_put_whole+0xac/0xee block/bdev.c:721
>         bdev_release+0x3fe/0x600 block/bdev.c:1144
>         blkdev_release+0x1a/0x26 block/fops.c:684
>         __fput+0x382/0xa8c fs/file_table.c:465
>         ____fput+0x1c/0x26 fs/file_table.c:493
>         task_work_run+0x16a/0x25e kernel/task_work.c:227
>         resume_user_mode_work include/linux/resume_user_mode.h:50 [inline]
>         exit_to_user_mode_loop+0x118/0x134 kernel/entry/common.c:114
>         exit_to_user_mode_prepare include/linux/entry-common.h:330 [inline]
>         syscall_exit_to_user_mode_work include/linux/entry-common.h:414 [inline]
>         syscall_exit_to_user_mode include/linux/entry-common.h:449 [inline]
>         do_trap_ecall_u+0x3f0/0x530 arch/riscv/kernel/traps.c:355
>         handle_exception+0x146/0x152 arch/riscv/kernel/entry.S:197
> 
> other info that might help us debug this:

The lock order looks problematic:

t0: disk->open_mutex -> nbd->config_lock
t1: nbd->config_lock -> set->update_nr_hwq_lock
t2: set->update_nr_hwq_lock -> disk->open_mutex

However,the above deadlock is not possible because nbd reference should
still be positive at t0, hence nbd_dev_remove_work() from t2 can't be
triggered concurrently.

Thanks,
Kuai

> 
> Chain exists of:
>    &nbd->config_lock --> &set->update_nr_hwq_lock --> &disk->open_mutex
> 
>   Possible unsafe locking scenario:
> 
>         CPU0                    CPU1
>         ----                    ----
>    lock(&disk->open_mutex);
>                                 lock(&set->update_nr_hwq_lock);
>                                 lock(&disk->open_mutex);
>    lock(&nbd->config_lock);
> 
>   *** DEADLOCK ***
> 
> 1 lock held by syz.1.344/5839:
>   #0: ffffaf8019fae358 (&disk->open_mutex){+.+.}-{4:4}, at: bdev_release+0x12c/0x600 block/bdev.c:1128
> 
> stack backtrace:
> CPU: 0 UID: 0 PID: 5839 Comm: syz.1.344 Not tainted 6.16.0-rc1-syzkaller-g306e57988197 #0 PREEMPT
> Hardware name: riscv-virtio,qemu (DT)
> Call Trace:
> [<ffffffff80078bbe>] dump_backtrace+0x2e/0x3c arch/riscv/kernel/stacktrace.c:132
> [<ffffffff8000327a>] show_stack+0x30/0x3c arch/riscv/kernel/stacktrace.c:138
> [<ffffffff8006103e>] __dump_stack lib/dump_stack.c:94 [inline]
> [<ffffffff8006103e>] dump_stack_lvl+0x12e/0x1a6 lib/dump_stack.c:120
> [<ffffffff800610d2>] dump_stack+0x1c/0x24 lib/dump_stack.c:129
> [<ffffffff802ce116>] print_circular_bug+0x254/0x29a kernel/locking/lockdep.c:2046
> [<ffffffff802ce28e>] check_noncircular+0x132/0x146 kernel/locking/lockdep.c:2178
> [<ffffffff802d1468>] check_prev_add kernel/locking/lockdep.c:3168 [inline]
> [<ffffffff802d1468>] check_prevs_add kernel/locking/lockdep.c:3287 [inline]
> [<ffffffff802d1468>] validate_chain kernel/locking/lockdep.c:3911 [inline]
> [<ffffffff802d1468>] __lock_acquire+0x12b2/0x24ea kernel/locking/lockdep.c:5240
> [<ffffffff802d32de>] lock_acquire kernel/locking/lockdep.c:5871 [inline]
> [<ffffffff802d32de>] lock_acquire+0x1ac/0x448 kernel/locking/lockdep.c:5828
> [<ffffffff8630e424>] __mutex_lock_common kernel/locking/mutex.c:602 [inline]
> [<ffffffff8630e424>] __mutex_lock+0x166/0x1292 kernel/locking/mutex.c:747
> [<ffffffff8630f564>] mutex_lock_nested+0x14/0x1c kernel/locking/mutex.c:799
> [<ffffffff8173119c>] refcount_dec_and_mutex_lock+0x60/0xd8 lib/refcount.c:118
> [<ffffffff82c30b40>] nbd_config_put+0x3a/0x610 drivers/block/nbd.c:1423
> [<ffffffff82c31336>] nbd_release+0x94/0x15c drivers/block/nbd.c:1735
> [<ffffffff815304f6>] blkdev_put_whole+0xac/0xee block/bdev.c:721
> [<ffffffff81534274>] bdev_release+0x3fe/0x600 block/bdev.c:1144
> [<ffffffff81535462>] blkdev_release+0x1a/0x26 block/fops.c:684
> [<ffffffff80bfbe7a>] __fput+0x382/0xa8c fs/file_table.c:465
> [<ffffffff80bfc632>] ____fput+0x1c/0x26 fs/file_table.c:493
> [<ffffffff801d7c16>] task_work_run+0x16a/0x25e kernel/task_work.c:227
> [<ffffffff803b556e>] resume_user_mode_work include/linux/resume_user_mode.h:50 [inline]
> [<ffffffff803b556e>] exit_to_user_mode_loop+0x118/0x134 kernel/entry/common.c:114
> [<ffffffff862fcc8c>] exit_to_user_mode_prepare include/linux/entry-common.h:330 [inline]
> [<ffffffff862fcc8c>] syscall_exit_to_user_mode_work include/linux/entry-common.h:414 [inline]
> [<ffffffff862fcc8c>] syscall_exit_to_user_mode include/linux/entry-common.h:449 [inline]
> [<ffffffff862fcc8c>] do_trap_ecall_u+0x3f0/0x530 arch/riscv/kernel/traps.c:355
> [<ffffffff863250ca>] handle_exception+0x146/0x152 arch/riscv/kernel/entry.S:197
> 
> 
> ---
> This report is generated by a bot. It may contain errors.
> See https://goo.gl/tpsmEJ for more information about syzbot.
> syzbot engineers can be reached at syzkaller@googlegroups.com.
> 
> syzbot will keep track of this issue. See:
> https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
> 
> If the report is already addressed, let syzbot know by replying with:
> #syz fix: exact-commit-title
> 
> If you want to overwrite report's subsystems, reply with:
> #syz set subsystems: new-subsystem
> (See the list of subsystem names on the web dashboard)
> 
> If the report is a duplicate of another one, reply with:
> #syz dup: exact-subject-of-another-report
> 
> If you want to undo deduplication, reply with:
> #syz undup
> 
> .
> 

