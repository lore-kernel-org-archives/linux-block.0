Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B26F3C433EF
	for <linux-block@archiver.kernel.org>; Mon, 10 Jan 2022 15:09:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232399AbiAJPJ1 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 10 Jan 2022 10:09:27 -0500
Received: from www262.sakura.ne.jp ([202.181.97.72]:55227 "EHLO
        www262.sakura.ne.jp" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229775AbiAJPJZ (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 10 Jan 2022 10:09:25 -0500
Received: from fsav311.sakura.ne.jp (fsav311.sakura.ne.jp [153.120.85.142])
        by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTP id 20AF93Fd050400;
        Tue, 11 Jan 2022 00:09:03 +0900 (JST)
        (envelope-from penguin-kernel@I-love.SAKURA.ne.jp)
Received: from www262.sakura.ne.jp (202.181.97.72)
 by fsav311.sakura.ne.jp (F-Secure/fsigk_smtp/550/fsav311.sakura.ne.jp);
 Tue, 11 Jan 2022 00:09:03 +0900 (JST)
X-Virus-Status: clean(F-Secure/fsigk_smtp/550/fsav311.sakura.ne.jp)
Received: from [192.168.1.9] (M106072142033.v4.enabler.ne.jp [106.72.142.33])
        (authenticated bits=0)
        by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTPSA id 20AF91CV050394
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NO);
        Tue, 11 Jan 2022 00:09:02 +0900 (JST)
        (envelope-from penguin-kernel@I-love.SAKURA.ne.jp)
Message-ID: <d1ca4fa4-ac3e-1354-3d94-1bf55f2000a9@I-love.SAKURA.ne.jp>
Date:   Tue, 11 Jan 2022 00:08:56 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 6.3; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.4.1
Subject: Re: [PATCH v2 2/2] loop: use task_work for autoclear operation
Content-Language: en-US
To:     Jan Kara <jack@suse.cz>
Cc:     Jens Axboe <axboe@kernel.dk>, Christoph Hellwig <hch@lst.de>,
        Dan Schatzberg <schatzberg.dan@gmail.com>,
        kernel test robot <oliver.sang@intel.com>,
        Jan Stancek <jstancek@redhat.com>,
        linux-block <linux-block@vger.kernel.org>
References: <969f764d-0e0f-6c64-de72-ecfee30bdcf7@I-love.SAKURA.ne.jp>
 <bcaf38e6-055e-0d83-fd1d-cb7c0c649372@I-love.SAKURA.ne.jp>
 <20220110103057.h775jv2br2xr2l5k@quack3.lan>
 <fc15d4a1-a9d2-1a26-71dc-827b0445d957@I-love.SAKURA.ne.jp>
 <20220110134234.qebxn5gghqupsc7t@quack3.lan>
From:   Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
In-Reply-To: <20220110134234.qebxn5gghqupsc7t@quack3.lan>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 2022/01/10 22:42, Jan Kara wrote:
> a) We didn't fully establish a real deadlock scenario from the lockdep
> report, did we? The lockdep report involved suspend locks, some locks on
> accessing files in /proc etc. and it was not clear whether it all reflects
> a real deadlock possibility or just a fact that lockdep tracking is rather
> coarse-grained at times. Now lockdep report is unpleasant and loop device
> locking was ugly anyway so your async change made sense but once lockdep is
> silenced we should really establish whether there is real deadlock and more
> work is needed or not.

Not /proc files but /sys/power/resume file.
Here is a reproducer but I can't test whether we can trigger a real deadlock.

----------------------------------------
#include <stdio.h>
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
	char filename[128] = { };
	const int loop_num = ioctl(open("/dev/loop-control", 3), LOOP_CTL_GET_FREE, 0);
	snprintf(filename, sizeof(filename) - 1, "/dev/loop%d", loop_num);
	const int loop_fd_1 = open(filename, O_RDWR);
	ioctl(loop_fd_1, LOOP_SET_FD, file_fd);
	const int loop_fd_2 = open(filename, O_RDWR);
	ioctl(loop_fd_1, LOOP_CLR_FD, 0);
	const int sysfs_fd = open("/sys/power/resume", O_RDWR);
	sendfile(file_fd, sysfs_fd, 0, 1048576);
	sendfile(loop_fd_2, file_fd, 0, 1048576);
	write(sysfs_fd, "700", 3);
	close(loop_fd_2);
	close(loop_fd_1); // Lockdep complains.
	close(file_fd);
	return 0;
}
----------------------------------------

Since many locks are held under disk->open_mutex, disk->open_mutex is getting
like a dependency aggregation hub.

----------------------------------------
ffffffff852c9920 OPS:     963 FD:  315 BD:    4 +.+.: &disk->open_mutex
 -> [ffffffffa01c0a48] sd_ref_mutex
 -> [ffffffff831bda60] fs_reclaim
 -> [ffffffff8529b260] &n->list_lock
 -> [ffffffff83330988] depot_lock
 -> [ffffffff8312bb08] tk_core.seq.seqcount
 -> [ffffffff83d85000] &rq->__lock
 -> [ffffffff852ca120] &obj_hash[i].lock
 -> [ffffffff852c8e60] &hctx->lock
 -> [ffffffff852c8e00] &x->wait#20
 -> [ffffffff85283d60] &base->lock
 -> [ffffffff85283ce0] (&timer.timer)
 -> [ffff88811aa44b60] lock#2
 -> [ffffffff85291860] &____s->seqcount
 -> [ffffffff852c8c00] &q->sysfs_dir_lock
 -> [ffffffff852c8160] &bdev->bd_size_lock
 -> [ffffffff831bc378] free_vmap_area_lock
 -> [ffffffff831bc318] vmap_area_lock
 -> [ffffffff852a8c00] &xa->xa_lock#3
 -> [ffff88811aa44390] lock#6
 -> [ffffffff852a8bf0] &mapping->private_lock
 -> [ffffffff852c9f20] &dd->lock
 -> [ffffffff8528fb40] &folio_wait_table[i]
 -> [ffffffff82ef6c18] (console_sem).lock
 -> [ffffffff8330b708] &sb->s_type->i_lock_key#3
 -> [ffffffff852a5720] &s->s_inode_list_lock
 -> [ffffffff831a9508] pcpu_alloc_mutex
 -> [ffffffff8544e5c0] &x->wait#9
 -> [ffffffff8543b160] &k->list_lock
 -> [ffff88811aa459c0] lock#3
 -> [ffffffff852adbc0] &root->kernfs_rwsem
 -> [ffffffff83356b50] bus_type_sem
 -> [ffffffff8321e358] sysfs_symlink_target_lock
 -> [ffffffff8544e020] &dev->power.lock
 -> [ffffffff833d75e8] dpm_list_mtx
 -> [ffffffff833d4b78] req_lock
 -> [ffffffff83d80860] &p->pi_lock
 -> [ffffffff8544e420] &x->wait#10
 -> [ffffffff8543b140] &k->k_lock
 -> [ffffffff852c9960] subsys mutex#47
 -> [ffffffff852c9980] &xa->xa_lock#5
 -> [ffffffff82e14698] inode_hash_lock
 -> [ffffffff831bc538] purge_vmap_area_lock
 -> [ffffffff852900a0] &lruvec->lru_lock
 -> [ffffffff83328c98] pool_lock
 -> [ffffffff834052c8] sr_ref_mutex
 -> [ffffffff852c9a20] &ev->block_mutex
 -> [ffffffff852c9a00] &ev->lock
 -> [ffffffff831e6ed8] sb_lock
 -> [ffffffff8544fae0] &cd->lock
 -> [ffffffff82e14818] bdev_lock
 -> [ffffffffa03d10c0] &lo->lo_mutex
 -> [ffffffff83d86320] &lock->wait_lock
 -> [ffffffff83195368] lock#5
 -> [ffffffff85290d60] &wb->list_lock
----------------------------------------

> 
> b) Unless we have a realistic plan of moving *all* blk_mq_freeze_queue()
> calls from under open_mutex in loop driver, moving stuff "where possible"
> from under open_mutex is IMO just muddying water.

As far as I know, only lo_open() and lo_release() are functions which are
called with disk->open_mutex held in loop driver. And only lo_release() calls
blk_mq_freeze_queue() with disk->open_mutex held.

blk_mq_freeze_queue() from __loop_clr_fd() from lo_release() (I mean, autoclear
part) can be done without disk->open_mutex held if we call __loop_clr_fd() from
task work context. And I think blk_mq_freeze_queue() from lo_release() (I mean,
"if (lo->lo_state == Lo_bound) { }" part) can be done in the same manner.

Therefore, I think this is not "partial move" but "complete move".

> 
>>>                               I mean using task work in
>>> loop_schedule_rundown() makes a lot of sense because the loop
>>>
>>> while :; do mount -o loop,ro isofs.iso isofs/; umount isofs/; done
>>>
>>> will not fail because of dangling work in the workqueue after umount ->
>>> __loop_clr_fd().
>>
>> Using task work from lo_release() is for handling close() => umount() sequence.
>> Using task work in lo_open() is for handling close() => open() sequence.
>> The mount in
>>
>>   while :; do mount -o loop,ro isofs.iso isofs/; umount isofs/; done
>>
>> fails unless lo_open() waits for __loop_clr_fd() to complete.
> 
> Why? If we use task work, we are guaranteed the loop device is cleaned up
> before umount returns unless some other process also has the loop device
> open.

Since systemd-udevd opens this loop device asynchronously, __loop_clr_fd() from
lo_release() is called by not mount or umount but systemd-udevd. This means that
we are not guaranteed that the loop device is cleaned up before umount returns.

> 
>>>                  But when other processes like systemd-udevd start to mess
>>> with the loop device, then you have no control whether the following mount
>>> will see isofs.iso busy or not - it depends on when systemd-udevd decides
>>> to close the loop device.
>>
>> Right. But regarding that part the main problem is that the script is not
>> checking for errors. What we are expected to do is to restore barrier
>> which existed before commit 322c4293ecc58110 ("loop: make autoclear
>> operation asynchronous").
> 
> OK, can you explain what you exactly mean by the barrier?

/bin/mount opens the loop device and reads from that loop device in order to
read superblock for guessing/verifying filesystem type of the backing file.

disk->open_mutex was blocking open() of the loop device until autoclear via
close() from systemd-udevd completes. My patch is intended to restore/mimic
this behavior without holding disk->open_mutex.

>                                                           Because it my
> understanding your patch only makes one race somewhat less likely.

Yes, this barrier is for making one race less likely.
We need to try to avoid hitting this race because /bin/mount fails when we
hit this race while reading superblock of the backing file.

> 
>>
>>>                           What your waiting in lo_open() achieves is only
>>> that if __loop_clr_fd() from systemd-udevd happens to run at the same time
>>> as lo_open() from mount, then we won't see EBUSY.
>>
>> My waiting in lo_open() is to fix a regression that
>>
>>   while :; do mount -o loop,ro isofs.iso isofs/; umount isofs/; done
>>
>> started to fail.
> 
> OK, so you claim this loop fails even with using task work in __loop_clr_fd(),
> correct?

Correct. If we run this loop with
https://lkml.kernel.org/r/9eff2034-2f32-54a3-e476-d0f609ab49c0@i-love.sakura.ne.jp ,
we get errors like below.

----------------------------------------
root@fuzz:/mnt# while :; do mount -o loop,ro isofs.iso isofs/; umount isofs/; done
mount: /mnt/isofs: can't read superblock on /dev/loop0.
umount: isofs/: not mounted.
mount: /mnt/isofs: can't read superblock on /dev/loop0.
umount: isofs/: not mounted.
mount: /mnt/isofs: can't read superblock on /dev/loop0.
umount: isofs/: not mounted.
mount: /mnt/isofs: can't read superblock on /dev/loop0.
umount: isofs/: not mounted.
mount: /mnt/isofs: can't read superblock on /dev/loop0.
umount: isofs/: not mounted.
mount: /mnt/isofs: can't read superblock on /dev/loop0.
umount: isofs/: not mounted.
mount: /mnt/isofs: can't read superblock on /dev/loop0.
umount: isofs/: not mounted.
mount: /mnt/isofs: can't read superblock on /dev/loop0.
umount: isofs/: not mounted.
----------------------------------------

----------------------------------------
[  172.907151] loop0: detected capacity change from 0 to 1992704
[  173.034450] LoadPin: kernel-module pinning-ignored obj="/usr/lib/modules/5.16.0-rc8-next-20220107+/kernel/fs/isofs/isofs.ko" pid=6124 cmdline="/sbin/modprobe -q -- fs-iso9660"
[  173.130665] ISO 9660 Extensions: Microsoft Joliet Level 3
[  173.132227] ISO 9660 Extensions: RRIP_1991A
[  173.271904] loop0: detected capacity change from 0 to 1992704
[  173.303460] ISO 9660 Extensions: Microsoft Joliet Level 3
[  173.304261] ISO 9660 Extensions: RRIP_1991A
[  173.431772] ISO 9660 Extensions: Microsoft Joliet Level 3
[  173.435583] ISO 9660 Extensions: RRIP_1991A
[  173.559952] ISO 9660 Extensions: Microsoft Joliet Level 3
[  173.561014] ISO 9660 Extensions: RRIP_1991A
[  173.673018] I/O error, dev loop0, sector 1992576 op 0x0:(READ) flags 0x80700 phys_seg 1 prio class 0
[  173.683062] I/O error, dev loop0, sector 2 op 0x0:(READ) flags 0x1000 phys_seg 1 prio class 0
[  173.685547] EXT4-fs (loop0): unable to read superblock
[  173.763214] loop0: detected capacity change from 0 to 1992704
[  173.792790] ISO 9660 Extensions: Microsoft Joliet Level 3
[  173.802959] ISO 9660 Extensions: RRIP_1991A
[  173.918140] ISO 9660 Extensions: Microsoft Joliet Level 3
[  173.920018] ISO 9660 Extensions: RRIP_1991A
[  173.991678] loop0: detected capacity change from 0 to 1992704
[  174.019262] ISO 9660 Extensions: Microsoft Joliet Level 3
[  174.020914] ISO 9660 Extensions: RRIP_1991A
[  174.111092] ISO 9660 Extensions: Microsoft Joliet Level 3
[  174.111862] ISO 9660 Extensions: RRIP_1991A
[  174.210594] ISO 9660 Extensions: Microsoft Joliet Level 3
[  174.211624] ISO 9660 Extensions: RRIP_1991A
[  174.310668] ISO 9660 Extensions: Microsoft Joliet Level 3
[  174.312334] ISO 9660 Extensions: RRIP_1991A
[  174.424918] loop0: detected capacity change from 0 to 1992704
[  174.455070] ISO 9660 Extensions: Microsoft Joliet Level 3
[  174.455944] ISO 9660 Extensions: RRIP_1991A
[  174.540379] loop0: detected capacity change from 0 to 1992704
[  174.576673] ISO 9660 Extensions: Microsoft Joliet Level 3
[  174.578195] ISO 9660 Extensions: RRIP_1991A
[  174.655124] I/O error, dev loop0, sector 1992576 op 0x0:(READ) flags 0x80700 phys_seg 1 prio class 0
[  174.665039] I/O error, dev loop0, sector 2 op 0x0:(READ) flags 0x1000 phys_seg 1 prio class 0
[  174.667435] EXT4-fs (loop0): unable to read superblock
[  174.745809] loop0: detected capacity change from 0 to 1992704
[  174.783917] ISO 9660 Extensions: Microsoft Joliet Level 3
[  174.789040] ISO 9660 Extensions: RRIP_1991A
[  174.888963] I/O error, dev loop0, sector 1992576 op 0x0:(READ) flags 0x80700 phys_seg 1 prio class 0
[  174.896654] I/O error, dev loop0, sector 2 op 0x0:(READ) flags 0x1000 phys_seg 1 prio class 0
[  174.898893] EXT4-fs (loop0): unable to read superblock
----------------------------------------

>          And does it fail even without systemd-udev?

I don't have an environment without systemd-udevd.
But probably it won't fail if there is nobody who opens asynchronously.

> 
>>>                                                   But IMO that is not worth
>>> the complexity in lo_open() because if systemd-udevd happens to close the
>>> loop device a millisecond later, you will get EBUSY anyway (and you would
>>> get it even in the past) Or am I missing something?
>>
>> Excuse me, but lo_open() does not return EBUSY?
>> What operation are you talking about?
> 
> I didn't mean EBUSY from lo_open() but EBUSY from LOOP_SET_FD ioctl(2). But
> maybe I misunderstood the failure. Where exactly does mount(1) fail? Because
> with the options you mention it should do something like:
>   ioctl(LOOP_CTL_GET_FREE) -> get free loop dev
>   ioctl(LOOP_SET_FD) -> bind isofs.iso to free loop dev
>   mount(loop_dev, isofs/)
> 
> and I though it is the second syscall that fails.

/bin/mount is failing at read() of superblock after open() of the loop device.

