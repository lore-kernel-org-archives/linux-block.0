Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D5202C433F5
	for <linux-block@archiver.kernel.org>; Sun, 26 Dec 2021 07:09:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229663AbhLZHJe (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Sun, 26 Dec 2021 02:09:34 -0500
Received: from www262.sakura.ne.jp ([202.181.97.72]:63541 "EHLO
        www262.sakura.ne.jp" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229451AbhLZHJd (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Sun, 26 Dec 2021 02:09:33 -0500
Received: from fsav116.sakura.ne.jp (fsav116.sakura.ne.jp [27.133.134.243])
        by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTP id 1BQ79KBe031932;
        Sun, 26 Dec 2021 16:09:20 +0900 (JST)
        (envelope-from penguin-kernel@i-love.sakura.ne.jp)
Received: from www262.sakura.ne.jp (202.181.97.72)
 by fsav116.sakura.ne.jp (F-Secure/fsigk_smtp/550/fsav116.sakura.ne.jp);
 Sun, 26 Dec 2021 16:09:20 +0900 (JST)
X-Virus-Status: clean(F-Secure/fsigk_smtp/550/fsav116.sakura.ne.jp)
Received: from [192.168.1.9] (M106072142033.v4.enabler.ne.jp [106.72.142.33])
        (authenticated bits=0)
        by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTPSA id 1BQ79Ku8031928
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NO);
        Sun, 26 Dec 2021 16:09:20 +0900 (JST)
        (envelope-from penguin-kernel@i-love.sakura.ne.jp)
Message-ID: <6be20f77-ab25-0c74-09c4-22a46fed40a1@i-love.sakura.ne.jp>
Date:   Sun, 26 Dec 2021 16:09:18 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 6.3; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.4.1
Subject: Re: fix loop autoclear for xfstets xfs/049
Content-Language: en-US
To:     Christoph Hellwig <hch@lst.de>, Jan Kara <jack@suse.cz>
Cc:     Jens Axboe <axboe@kernel.dk>,
        Dan Schatzberg <schatzberg.dan@gmail.com>,
        linux-block@vger.kernel.org
References: <20211223112509.1116461-1-hch@lst.de>
 <20211223134050.GD19129@quack2.suse.cz> <20211224060205.GB12234@lst.de>
From:   Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>
In-Reply-To: <20211224060205.GB12234@lst.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 2021/12/24 15:02, Christoph Hellwig wrote:
> On Thu, Dec 23, 2021 at 02:40:50PM +0100, Jan Kara wrote:
>> Hum, I have nothing against this but I'm somewhat wondering: Lockdep was
>> originally complaining because it somehow managed to find a write whose
>> completion was indirectly dependent on disk->open_mutex and
>> destroy_workqueue() could wait for such write to complete under
>> disk->open_mutex. Now your patch will fix this lockdep complaint but we
>> still would wait for the write to complete through blk_mq_freeze_queue()
>> (just lockdep is not clever enough to detect this). So IHMO if there was a
>> deadlock before, it will be still there with your changes. Now I'm not 100%
>> sure the deadlock lockdep was complaining about is real in the first place
>> because it involved some writes to proc files (taking some locks) and
>> hibernation mutex and whatnot.  But it is true that writing to a backing
>> file will grab fs freeze protection and that can bring with it all sorts of
>> interesting dependencies.
> 
> I don't think the problem was a write completion, but the synchronous
> nature of the workqueue operations.  But I also have to admit the whole
> lockdep vs workqueue thing keeps confusing me.

Here is a simplified reproducer and a log. It was difficult to find a reproducer
because /proc/lockdep zaps dependency chain when a dynamically created object is destroyed.

----------------------------------------
#include <stdio.h>
#include <stdlib.h>
#include <sys/types.h>
#include <sys/stat.h>
#include <fcntl.h>
#include <unistd.h>
#include <sys/ioctl.h>
#include <linux/loop.h>
#include <sys/sendfile.h>

int main(int argc, char *argv[])
{
	const int file_fd = open("testfile", O_RDWR | O_CREAT, 0600);
	ftruncate(file_fd, 1048576);
	sendfile(file_fd, open("/proc/mounts", O_RDONLY), 0, 1048576);
	char filename[128] = { };
	const int loop_num = ioctl(open("/dev/loop-control", 3),  LOOP_CTL_GET_FREE, 0);
	snprintf(filename, sizeof(filename) - 1, "/dev/loop%d", loop_num);
	const int loop_fd_1 = open(filename, O_RDWR);
	ioctl(loop_fd_1, LOOP_SET_FD, file_fd);
	const int loop_fd_2 = open(filename, O_RDWR);
	ioctl(loop_fd_1, LOOP_CLR_FD, 0);
	sendfile(loop_fd_2, file_fd, 0, 1048576);
	fsync(loop_fd_2);
	write(open("/sys/power/resume", O_WRONLY), "700", 3);
	system("/bin/cat /proc/lockdep > /tmp/lockdep"); // Save before "zap on release" forgets the dependency.
	return 0;
}
----------------------------------------

----------------------------------------
[   36.910512] loop0: detected capacity change from 0 to 2048
[   37.014998] 
[   37.015573] ======================================================
[   37.017667] WARNING: possible circular locking dependency detected
[   37.019788] 5.16.0-rc4-next-20211210 #10 Not tainted
[   37.021516] ------------------------------------------------------
[   37.023602] systemd-udevd/2254 is trying to acquire lock:
[   37.025820] ffff888119656538 ((wq_completion)loop0){+.+.}-{0:0}, at: flush_workqueue+0x70/0x560
[   37.028874] 
[   37.028874] but task is already holding lock:
[   37.030871] ffff888104e54d18 (&disk->open_mutex){+.+.}-{3:3}, at: blkdev_put+0x4c/0x1c0
[   37.033653] 
[   37.033653] which lock already depends on the new lock.
[   37.033653] 
[   37.037679] 
[   37.037679] the existing dependency chain (in reverse order) is:
[   37.042074] 
[   37.042074] -> #6 (&disk->open_mutex){+.+.}-{3:3}:
[   37.045465]        lock_acquire+0xc7/0x1d0
[   37.047446]        __mutex_lock_common+0xb9/0xdd0
[   37.049567]        mutex_lock_nested+0x17/0x20
[   37.051610]        blkdev_get_by_dev+0xeb/0x2f0
[   37.053680]        swsusp_check+0x27/0x120
[   37.055634]        software_resume+0x5f/0x1f0
[   37.057721]        resume_store+0x6e/0x90
[   37.060020]        kernfs_fop_write_iter+0x120/0x1b0
[   37.062285]        vfs_write+0x2ed/0x360
[   37.064092]        ksys_write+0x67/0xd0
[   37.065886]        do_syscall_64+0x3d/0x90
[   37.067699]        entry_SYSCALL_64_after_hwframe+0x44/0xae
[   37.069991] 
[   37.069991] -> #5 (system_transition_mutex/1){+.+.}-{3:3}:
[   37.073194]        lock_acquire+0xc7/0x1d0
[   37.075694]        __mutex_lock_common+0xb9/0xdd0
[   37.077747]        mutex_lock_nested+0x17/0x20
[   37.079735]        software_resume+0x4d/0x1f0
[   37.081677]        resume_store+0x6e/0x90
[   37.083421]        kernfs_fop_write_iter+0x120/0x1b0
[   37.085514]        vfs_write+0x2ed/0x360
[   37.087280]        ksys_write+0x67/0xd0
[   37.089052]        do_syscall_64+0x3d/0x90
[   37.090947]        entry_SYSCALL_64_after_hwframe+0x44/0xae
[   37.094050] 
[   37.094050] -> #4 (&of->mutex){+.+.}-{3:3}:
[   37.096733]        lock_acquire+0xc7/0x1d0
[   37.098442]        __mutex_lock_common+0xb9/0xdd0
[   37.100461]        mutex_lock_nested+0x17/0x20
[   37.102221]        kernfs_seq_start+0x1d/0xf0
[   37.103975]        seq_read_iter+0xf8/0x3e0
[   37.105888]        vfs_read+0x2db/0x350
[   37.107838]        ksys_read+0x67/0xd0
[   37.110267]        do_syscall_64+0x3d/0x90
[   37.112066]        entry_SYSCALL_64_after_hwframe+0x44/0xae
[   37.114246] 
[   37.114246] -> #3 (&p->lock){+.+.}-{3:3}:
[   37.116809]        lock_acquire+0xc7/0x1d0
[   37.118552]        __mutex_lock_common+0xb9/0xdd0
[   37.120584]        mutex_lock_nested+0x17/0x20
[   37.122478]        seq_read_iter+0x37/0x3e0
[   37.125093]        generic_file_splice_read+0xf3/0x170
[   37.127174]        splice_direct_to_actor+0x13f/0x310
[   37.129128]        do_splice_direct+0x84/0xd0
[   37.130903]        do_sendfile+0x267/0x410
[   37.132534]        __se_sys_sendfile64+0x9f/0xd0
[   37.134395]        do_syscall_64+0x3d/0x90
[   37.136069]        entry_SYSCALL_64_after_hwframe+0x44/0xae
[   37.138175] 
[   37.138175] -> #2 (sb_writers#7){.+.+}-{0:0}:
[   37.141353]        lock_acquire+0xc7/0x1d0
[   37.143415]        loop_process_work+0x664/0x980 [loop]
[   37.145828]        process_one_work+0x230/0x3c0
[   37.147625]        worker_thread+0x21d/0x490
[   37.149382]        kthread+0x192/0x1b0
[   37.150934]        ret_from_fork+0x1f/0x30
[   37.152598] 
[   37.152598] -> #1 ((work_completion)(&worker->work)){+.+.}-{0:0}:
[   37.155702]        lock_acquire+0xc7/0x1d0
[   37.157923]        process_one_work+0x21d/0x3c0
[   37.160202]        worker_thread+0x21d/0x490
[   37.162134]        kthread+0x192/0x1b0
[   37.163678]        ret_from_fork+0x1f/0x30
[   37.165439] 
[   37.165439] -> #0 ((wq_completion)loop0){+.+.}-{0:0}:
[   37.168213]        validate_chain+0xba0/0x2ae0
[   37.170033]        __lock_acquire+0x8e0/0xbe0
[   37.171810]        lock_acquire+0xc7/0x1d0
[   37.173459]        flush_workqueue+0x8c/0x560
[   37.176198]        drain_workqueue+0x80/0x140
[   37.178126]        destroy_workqueue+0x36/0x3d0
[   37.180111]        __loop_clr_fd+0x98/0x350 [loop]
[   37.182035]        blkdev_put+0x14b/0x1c0
[   37.183710]        blkdev_close+0x12/0x20
[   37.185359]        __fput+0xfb/0x230
[   37.186867]        task_work_run+0x69/0xc0
[   37.188565]        exit_to_user_mode_loop+0x144/0x160
[   37.190611]        exit_to_user_mode_prepare+0xbd/0x130
[   37.193387]        syscall_exit_to_user_mode+0x26/0x60
[   37.195474]        do_syscall_64+0x49/0x90
[   37.197158]        entry_SYSCALL_64_after_hwframe+0x44/0xae
[   37.199520] 
[   37.199520] other info that might help us debug this:
[   37.199520] 
[   37.203310] Chain exists of:
[   37.203310]   (wq_completion)loop0 --> system_transition_mutex/1 --> &disk->open_mutex
[   37.203310] 
[   37.209552]  Possible unsafe locking scenario:
[   37.209552] 
[   37.212337]        CPU0                    CPU1
[   37.214255]        ----                    ----
[   37.216084]   lock(&disk->open_mutex);
[   37.217671]                                lock(system_transition_mutex/1);
[   37.220438]                                lock(&disk->open_mutex);
[   37.222862]   lock((wq_completion)loop0);
[   37.224902] 
[   37.224902]  *** DEADLOCK ***
[   37.224902] 
[   37.228403] 1 lock held by systemd-udevd/2254:
[   37.230301]  #0: ffff888104e54d18 (&disk->open_mutex){+.+.}-{3:3}, at: blkdev_put+0x4c/0x1c0
[   37.233386] 
[   37.233386] stack backtrace:
[   37.235654] CPU: 0 PID: 2254 Comm: systemd-udevd Kdump: loaded Not tainted 5.16.0-rc4-next-20211210 #10
[   37.239620] Hardware name: VMware, Inc. VMware Virtual Platform/440BX Desktop Reference Platform, BIOS 6.00 02/27/2020
[   37.244830] Call Trace:
[   37.246117]  <TASK>
[   37.247237]  dump_stack_lvl+0x79/0xbf
[   37.248946]  print_circular_bug+0x5df/0x5f0
[   37.250802]  ? stack_trace_save+0x70/0x70
[   37.252524]  ? rcu_lock_acquire+0x30/0x30
[   37.254292]  ? rcu_read_lock_sched_held+0x41/0x90
[   37.256306]  ? perf_trace_mem_return_failed+0xe0/0xe0
[   37.259439]  ? trace_lock_release+0x2d/0xd0
[   37.261471]  ? lock_release+0x27/0x2c0
[   37.263148]  ? stack_trace_save+0x70/0x70
[   37.264976]  ? is_bpf_text_address+0x11a/0x120
[   37.266947]  ? kernel_text_address+0xa8/0xc0
[   37.268834]  ? __kernel_text_address+0x9/0x40
[   37.270752]  ? unwind_get_return_address+0x12/0x20
[   37.272839]  ? arch_stack_walk+0x98/0xe0
[   37.275409]  ? stack_trace_save+0x43/0x70
[   37.277364]  ? save_trace+0x3d/0x2c0
[   37.279136]  check_noncircular+0x123/0x130
[   37.281006]  validate_chain+0xba0/0x2ae0
[   37.282757]  ? validate_chain+0x104/0x2ae0
[   37.284612]  ? validate_chain+0x104/0x2ae0
[   37.286465]  ? validate_chain+0x104/0x2ae0
[   37.288278]  ? validate_chain+0x104/0x2ae0
[   37.290075]  ? validate_chain+0x104/0x2ae0
[   37.292662]  ? validate_chain+0x104/0x2ae0
[   37.294480]  ? validate_chain+0x104/0x2ae0
[   37.296248]  ? rcu_lock_acquire+0x30/0x30
[   37.298066]  ? __lock_acquire+0x901/0xbe0
[   37.299889]  __lock_acquire+0x8e0/0xbe0
[   37.301623]  lock_acquire+0xc7/0x1d0
[   37.303135]  ? flush_workqueue+0x70/0x560
[   37.304778]  ? __raw_spin_lock_init+0x35/0x60
[   37.306742]  flush_workqueue+0x8c/0x560
[   37.308890]  ? flush_workqueue+0x70/0x560
[   37.310811]  drain_workqueue+0x80/0x140
[   37.312501]  destroy_workqueue+0x36/0x3d0
[   37.314193]  __loop_clr_fd+0x98/0x350 [loop]
[   37.315978]  blkdev_put+0x14b/0x1c0
[   37.317482]  blkdev_close+0x12/0x20
[   37.318984]  __fput+0xfb/0x230
[   37.320377]  task_work_run+0x69/0xc0
[   37.321958]  exit_to_user_mode_loop+0x144/0x160
[   37.323781]  exit_to_user_mode_prepare+0xbd/0x130
[   37.326347]  syscall_exit_to_user_mode+0x26/0x60
[   37.328160]  do_syscall_64+0x49/0x90
[   37.329658]  entry_SYSCALL_64_after_hwframe+0x44/0xae
[   37.331588] RIP: 0033:0x7f4537d62097
[   37.333027] Code: ff e8 6d 11 02 00 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 00 f3 0f 1e fa 64 8b 04 25 18 00 00 00 85 c0 75 10 b8 03 00 00 00 0f 05 <48> 3d 00 f0 ff ff 77 41 c3 48 83 ec 18 89 7c 24 0c e8 33 c8 f7 ff
[   37.339995] RSP: 002b:00007ffd77fdb008 EFLAGS: 00000246 ORIG_RAX: 0000000000000003
[   37.343761] RAX: 0000000000000000 RBX: 00007f45377d56c0 RCX: 00007f4537d62097
[   37.346617] RDX: 0000556b97cb0723 RSI: 0000556ec02be94c RDI: 0000000000000006
[   37.349287] RBP: 0000000000000006 R08: 0000556ec1273090 R09: 0000000000000000
[   37.351892] R10: 00007f45377d56c0 R11: 0000000000000246 R12: 0000000000000000
[   37.354543] R13: 0000000000000000 R14: 00007ffd77fdb090 R15: 00007ffd77fdb074
[   37.357171]  </TASK>
----------------------------------------

I was able to confirm that just writing a device number (e.g. major=7,minor=0) to
/sys/power/resume from shell causes system_transition_mutex to be held, and disk->open_mutex
is held with system_transition_mutex held. Therefore, while software_resume() says

        /*
         * name_to_dev_t() below takes a sysfs buffer mutex when sysfs
         * is configured into the kernel. Since the regular hibernate
         * trigger path is via sysfs which takes a buffer mutex before
         * calling hibernate functions (which take system_transition_mutex)
         * this can cause lockdep to complain about a possible ABBA deadlock
         * which cannot happen since we're in the boot code here and
         * sysfs can't be invoked yet. Therefore, we use a subclass
         * here to avoid lockdep complaining.
         */
        mutex_lock_nested(&system_transition_mutex, SINGLE_DEPTH_NESTING);

, system_transition_mutex => disk->open_mutex is a real dependency which can happen
outside of the boot code. I feel this _nested annotation might be wrong.

Anyway, many other locks are held while holding disk->open_mutex.

----------------------------------------
ffff888119656528 OPS:      25 FD:  470 BD:    1 +.+.: (wq_completion)loop0
 -> [ffffffffa0353078] (work_completion)(&worker->work)
 -> [ffffffffa0353088] (work_completion)(&lo->rootcg_work)
 
 ffffffffa0353078 OPS:     235 FD:  467 BD:    2 +.+.: (work_completion)(&worker->work)
 -> [ffffffffa0353068] &lo->lo_work_lock
 -> [ffffffff828683e0] mapping.invalidate_lock#2
 -> [ffffffff842cd5b8] &folio_wait_table[i]
 -> [ffffffff82f3a2c0] &rq->__lock
 -> [ffff88813b238410] lock#6
 -> [ffffffff82f36ea8] &p->pi_lock
 -> [ffffffff82868390] sb_writers#7

ffffffff82868390 OPS:    2993 FD:  466 BD:    4 .+.+: sb_writers#7
 -> [ffffffff82610710] mount_lock
 -> [ffff88813b238bc8] lock#2
 -> [ffffffff842ce7a8] &____s->seqcount
 -> [ffffffff842da468] &xa->xa_lock#3
 -> [ffff88813b238410] lock#6
 -> [ffffffff842d6050] &n->list_lock
 -> [ffffffff842da458] &mapping->private_lock
 -> [ffffffff828223c8] tk_core.seq.seqcount
 -> [ffffffff842f3310] &dd->lock
 -> [ffffffff82f36e98] &____s->seqcount#2
 -> [ffffffff82f3a2c0] &rq->__lock
 -> [ffffffff842f33f0] &obj_hash[i].lock
 -> [ffffffff82f3a590] bit_wait_table + i
 -> [ffffffff842c4e70] rcu_node_0
 -> [ffffffff828ab120] pool_lock
 -> [ffffffff828683f0] &type->i_mutex_dir_key#6
 -> [ffffffff82f36e38] &mm->mmap_lock#2
 -> [ffffffff828683d0] &sb->s_type->i_mutex_key#14
 -> [ffffffff82843c10] fs_reclaim
 -> [ffffffff828683f1] &type->i_mutex_dir_key#6/1
 -> [ffffffff842df2f0] &ei->xattr_sem
 -> [ffffffff82f3af58] &sem->wait_lock
 -> [ffffffff82f36ea8] &p->pi_lock
 -> [ffffffff828683c0] &sb->s_type->i_lock_key#23
 -> [ffffffff842da3a0] &dentry->d_lock
 -> [ffffffff842d7af0] &s->s_inode_list_lock
 -> [ffffffff828683b0] sb_internal
 -> [ffffffff82610698] inode_hash_lock
 -> [ffffffff842ce230] &wb->list_lock
 -> [ffffffff842cd8a0] &lruvec->lru_lock
 -> [ffffffff842da4e0] &p->lock

ffffffff842da4e0 OPS:   22875 FD:  455 BD:    5 +.+.: &p->lock
 -> [ffffffff82843c10] fs_reclaim
 -> [ffff88813b238bc8] lock#2
 -> [ffffffff842ce7a8] &____s->seqcount
 -> [ffffffff842d6050] &n->list_lock
 -> [ffffffff82f36e38] &mm->mmap_lock#2
 -> [ffffffff8284d058] file_systems_lock
 -> [ffffffff82f36e78] &p->alloc_lock
 -> [ffffffff82f36f38] &sighand->siglock
 -> [ffffffff842de040] &of->mutex
 -> [ffffffff82f3a2c0] &rq->__lock
 -> [ffffffff8284c4e8] chrdevs_lock
 -> [ffffffff828a87d8] major_names_spinlock
 -> [ffffffff828223c8] tk_core.seq.seqcount
 -> [ffffffff84423f20] &k->k_lock
 -> [ffffffff842f33f0] &obj_hash[i].lock
 -> [ffffffff828fda48] cpufreq_driver_lock
 -> [ffffffff82825be0] cgroup_mutex
 -> [ffffffff82655610] wq_pool_attach_mutex
 -> [ffffffff8284d140] namespace_sem
 -> [ffffffff82844988] swapon_mutex
 -> [ffffffff82f36e98] &____s->seqcount#2
 -> [ffffffff842d7af0] &s->s_inode_list_lock
 -> [ffffffff828448a0] swap_lock
 -> [ffffffff842ce3f8] key#11
 -> [ffffffff842c4e70] rcu_node_0
 -> [ffffffff8263e198] pgd_lock
 -> [ffffffff828fb3f0] pers_lock
 -> [ffffffff828fb440] all_mddevs_lock
 -> [ffffffff82652208] resource_lock
 -> [ffffffff82825b98] cgroup_mutex.wait_lock
 -> [ffffffff82f36ea8] &p->pi_lock
 -> [ffffffff8284d100] namespace_sem.wait_lock

ffffffff842de040 OPS:   22212 FD:  441 BD:    8 +.+.: &of->mutex
 -> [ffffffff82f3a2c0] &rq->__lock
 -> [ffffffff82825be0] cgroup_mutex
 -> [ffffffff8264f378] cpu_hotplug_lock
 -> [ffffffff8282ac58] cpuset_hotplug_work
 -> [ffffffff82825b98] cgroup_mutex.wait_lock
 -> [ffffffff82f36ea8] &p->pi_lock

ffffffff82656231 OPS:       2 FD:  333 BD:   10 +.+.: system_transition_mutex/1
 -> [ffffffff82610698] inode_hash_lock
 -> [ffffffff82610818] bdev_lock
 -> [ffffffff842f2f70] &disk->open_mutex
 -> [ffffffff842d6050] &n->list_lock
 -> [ffffffff828223c8] tk_core.seq.seqcount
 -> [ffffffff842f2568] &x->wait#24
 -> [ffffffff82f3a2c0] &rq->__lock
 -> [ffffffff842f33f0] &obj_hash[i].lock
 -> [ffffffff842c5118] &base->lock
 -> [ffffffff842c50d8] (&timer.timer)

ffffffff842f2f70 OPS:     493 FD:  331 BD:   14 +.+.: &disk->open_mutex
 -> [ffffffffa0212688] sd_ref_mutex
 -> [ffffffff82843c10] fs_reclaim
 -> [ffffffff842d6050] &n->list_lock
 -> [ffffffff828223c8] tk_core.seq.seqcount
 -> [ffffffff842f33f0] &obj_hash[i].lock
 -> [ffffffff842f2710] &hctx->lock
 -> [ffffffff842f26e0] &x->wait#21
 -> [ffff88813b238bc8] lock#2
 -> [ffffffff842ce7a8] &____s->seqcount
 -> [ffffffff842f25d8] &q->sysfs_dir_lock
 -> [ffffffff842f1dd0] &bdev->bd_size_lock
 -> [ffffffff828439d8] free_vmap_area_lock
 -> [ffffffff82843998] vmap_area_lock
 -> [ffffffff842da468] &xa->xa_lock#3
 -> [ffff88813b238410] lock#6
 -> [ffffffff842da458] &mapping->private_lock
 -> [ffffffff842f3310] &dd->lock
 -> [ffffffff842cd5b8] &folio_wait_table[i]
 -> [ffffffff82f3a2c0] &rq->__lock
 -> [ffffffff8265c630] (console_sem).lock
 -> [ffffffff828a59e8] &sb->s_type->i_lock_key#3
 -> [ffffffff842d7af0] &s->s_inode_list_lock
 -> [ffffffff8283d0d0] pcpu_alloc_mutex
 -> [ffffffff84432b38] &x->wait#9
 -> [ffffffff84423f30] &k->list_lock
 -> [ffff88813b2397c0] lock#3
 -> [ffffffff842de000] &root->kernfs_rwsem
 -> [ffffffff828b0480] bus_type_sem
 -> [ffffffff82857b78] sysfs_symlink_target_lock
 -> [ffffffff84432878] &dev->power.lock
 -> [ffffffff828c92f0] dpm_list_mtx
 -> [ffffffff828c8c18] req_lock
 -> [ffffffff82f36ea8] &p->pi_lock
 -> [ffffffff84432a48] &x->wait#10
 -> [ffffffff84423f20] &k->k_lock
 -> [ffffffff842f2f88] subsys mutex#49
 -> [ffffffff842f2f98] &xa->xa_lock#7
 -> [ffffffff82610698] inode_hash_lock
 -> [ffffffff82843b08] purge_vmap_area_lock
 -> [ffffffff842cd8a0] &lruvec->lru_lock
 -> [ffffffff828d0d18] sr_ref_mutex
 -> [ffffffff842f2fe8] &ev->block_mutex
 -> [ffffffff842f2fd8] &ev->lock
 -> [ffffffff842c5118] &base->lock
 -> [ffffffff842c50d8] (&timer.timer)
 -> [ffffffff8263e198] pgd_lock
 -> [ffffffff8284c3f8] sb_lock
 -> [ffffffff84433890] &cd->lock
 -> [ffffffff82610818] bdev_lock
 -> [ffffffff842ce230] &wb->list_lock
 -> [ffffffffa0353048] &lo->lo_mutex
 -> [ffffffff82f3af48] &lock->wait_lock
 -> [ffffffffa03532b0] loop_validate_mutex
 -> [ffffffff842f2608] &q->mq_freeze_lock
 -> [ffffffff828ab040] percpu_ref_switch_lock
 -> [ffffffff842f25f8] &q->mq_freeze_wq
 -> [ffffffff82f37a18] &wq->mutex
 -> [ffffffff826554d8] wq_pool_mutex
 -> [ffffffff82f37d19] &pool->lock/1
 -> [ffffffffa0353068] &lo->lo_work_lock
 -> [ffffffffa0353098] (&lo->timer)
 -> [ffffffffa0353058] &lo->lo_lock
 -> [ffffffffa0353350] kn->active#145
 -> [ffffffffa0353388] kn->active#144
 -> [ffffffffa03533c0] kn->active#146
 -> [ffffffffa03533f8] kn->active#143
 -> [ffffffffa0353430] kn->active#147
 -> [ffffffffa0353468] kn->active#148
 -> [ffffffff82f3af58] &sem->wait_lock
 -> [ffffffff828abae0] uevent_sock_mutex
 -> [ffffffff828aba98] uevent_sock_mutex.wait_lock
----------------------------------------

Therefore, to reduce locking dependency with disk->open_mutex held, while just avoiding
flush_workqueue() ( https://lkml.kernel.org/r/03f43407-c34b-b7b2-68cd-d4ca93a993b8@i-love.sakura.ne.jp )
would be possible, I think doing things as much as possible without disk->open_mutex
( https://lkml.kernel.org/r/9eff2034-2f32-54a3-e476-d0f609ab49c0@i-love.sakura.ne.jp ) is preferable.
