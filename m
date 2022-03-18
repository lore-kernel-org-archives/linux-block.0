Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BBC79C433EF
	for <linux-block@archiver.kernel.org>; Fri, 18 Mar 2022 12:05:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232569AbiCRMHG (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 18 Mar 2022 08:07:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46068 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235969AbiCRMHF (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 18 Mar 2022 08:07:05 -0400
Received: from www262.sakura.ne.jp (www262.sakura.ne.jp [202.181.97.72])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F295A2E0456
        for <linux-block@vger.kernel.org>; Fri, 18 Mar 2022 05:05:46 -0700 (PDT)
Received: from fsav118.sakura.ne.jp (fsav118.sakura.ne.jp [27.133.134.245])
        by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTP id 22IC5iuI066375;
        Fri, 18 Mar 2022 21:05:44 +0900 (JST)
        (envelope-from penguin-kernel@I-love.SAKURA.ne.jp)
Received: from www262.sakura.ne.jp (202.181.97.72)
 by fsav118.sakura.ne.jp (F-Secure/fsigk_smtp/550/fsav118.sakura.ne.jp);
 Fri, 18 Mar 2022 21:05:44 +0900 (JST)
X-Virus-Status: clean(F-Secure/fsigk_smtp/550/fsav118.sakura.ne.jp)
Received: from [192.168.1.9] (M106072142033.v4.enabler.ne.jp [106.72.142.33])
        (authenticated bits=0)
        by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTPSA id 22IC5iaJ066371
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NO);
        Fri, 18 Mar 2022 21:05:44 +0900 (JST)
        (envelope-from penguin-kernel@I-love.SAKURA.ne.jp)
Message-ID: <5542ef88-dcc9-0db5-7f01-ad5779d9bc07@I-love.SAKURA.ne.jp>
Date:   Fri, 18 Mar 2022 21:05:42 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 6.3; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: [PATCH] loop: add WQ_MEM_RECLAIM flag to per device workqueue
Content-Language: en-US
To:     Dan Schatzberg <schatzberg.dan@gmail.com>,
        Tejun Heo <tj@kernel.org>
Cc:     Jens Axboe <axboe@kernel.dk>, Ming Lei <ming.lei@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Jan Kara <jack@suse.cz>, Christoph Hellwig <hch@lst.de>,
        linux-block <linux-block@vger.kernel.org>
References: <e0a0bc94-e6de-b0e5-ee46-a76cd1570ea6@I-love.SAKURA.ne.jp>
 <YjNHzyTFHjh9v6k4@dschatzberg-fedora-PC0Y6AEN.dhcp.thefacebook.com>
From:   Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
In-Reply-To: <YjNHzyTFHjh9v6k4@dschatzberg-fedora-PC0Y6AEN.dhcp.thefacebook.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 2022/03/17 23:38, Dan Schatzberg wrote:
> On Thu, Mar 17, 2022 at 11:08:04PM +0900, Tetsuo Handa wrote:
>> Commit 87579e9b7d8dc36e ("loop: use worker per cgroup instead of kworker")
>> again started using per device workqueue
>>
>> -       lo->worker_task = kthread_run(loop_kthread_worker_fn,
>> -                       &lo->worker, "loop%d", lo->lo_number);
>> +       lo->workqueue = alloc_workqueue("loop%d",
>> +                                       WQ_UNBOUND | WQ_FREEZABLE,
>> +                                       0,
>> +                                       lo->lo_number);
>>
>> but forgot to restore WQ_MEM_RECLAIM flag.
> 
> Early versions of the patch did have WQ_MEM_RECLAIM but it was
> removed. I looked up my notes and found this:
> 
> Changes since V11:
> 
> * Removed WQ_MEM_RECLAIM flag from loop workqueue. Technically, this
>   can be driven by writeback, but this was causing a warning in xfs
>   and likely other filesystems aren't equipped to be driven by reclaim
>   at the VFS layer.
> 
> I don't know if this is still the case. Can you test it?

Well, indeed there was WQ_MEM_RECLAIM flag in
https://lore.kernel.org/all/20210316153655.500806-2-schatzberg.dan@gmail.com/
and the warning you are referring to seems to be
https://lore.kernel.org/all/20210322060334.GD32426@xsang-OptiPlex-9020/ .

----------------------------------------
[   49.143055] run fstests generic/361 at 2021-03-19 23:56:49
[   49.418726] loop: module loaded
[   49.642111] XFS (sda4): Mounting V5 Filesystem
[   49.761139] XFS (sda4): Ending clean mount
[   49.768167] xfs filesystem being mounted at /fs/scratch supports timestamps until 2038 (0x7fffffff)
[   49.799002] loop0: detected capacity change from 0 to 2097152
[   50.027339] XFS (loop0): Mounting V5 Filesystem
[   50.033830] XFS (loop0): Ending clean mount
[   50.038232] xfs filesystem being mounted at /fs/scratch/mnt supports timestamps until 2038 (0x7fffffff)
[   50.239610] XFS: attr2 mount option is deprecated.
[   50.423584] ------------[ cut here ]------------
[   50.428278] workqueue: WQ_MEM_RECLAIM loop0:loop_rootcg_workfn [loop] is flushing !WQ_MEM_RECLAIM xfs-sync/sda4:xfs_flush_inodes_worker [xfs]
[   50.428387] WARNING: CPU: 0 PID: 35 at kernel/workqueue.c:2613 check_flush_dependency+0x116/0x140
[   50.450013] Modules linked in: loop xfs dm_mod btrfs blake2b_generic xor zstd_compress raid6_pq libcrc32c sd_mod t10_pi sg ipmi_devintf ipmi_msghandler intel_rapl_msr intel_rapl_common x86_pkg_temp_thermal i915 intel_powerclamp coretemp crct10dif_pclmul crc32_pclmul hp_wmi sparse_keymap intel_gtt crc32c_intel ghash_clmulni_intel mei_wdt rfkill wmi_bmof rapl drm_kms_helper ahci intel_cstate syscopyarea mei_me libahci sysfillrect sysimgblt fb_sys_fops intel_uncore serio_raw mei drm libata intel_pch_thermal ie31200_edac wmi video tpm_infineon intel_pmc_core acpi_pad ip_tables
[   50.500731] CPU: 0 PID: 35 Comm: kworker/u8:3 Not tainted 5.12.0-rc2-00093-geaba74271070 #1
[   50.509081] Hardware name: HP HP Z238 Microtower Workstation/8183, BIOS N51 Ver. 01.63 10/05/2017
[   50.517963] Workqueue: loop0 loop_rootcg_workfn [loop]
[   50.523109] RIP: 0010:check_flush_dependency+0x116/0x140
[   50.528427] Code: 8d 8b b0 00 00 00 48 8b 50 18 49 89 e8 48 8d b1 b0 00 00 00 48 c7 c7 80 ed 34 82 4c 89 c9 c6 05 8a 11 ab 01 01 e8 29 9a a9 00 <0f> 0b e9 07 ff ff ff 80 3d 78 11 ab 01 00 75 92 e9 3b ff ff ff 66
[   50.547207] RSP: 0018:ffffc9000018fba0 EFLAGS: 00010086
[   50.552434] RAX: 0000000000000000 RBX: ffff88843a39b600 RCX: 0000000000000027
[   50.559567] RDX: 0000000000000027 RSI: 00000000ffff7fff RDI: ffff88843f4177f8
[   50.566713] RBP: ffffffffc091c760 R08: ffff88843f4177f0 R09: ffffc9000018f9b8
[   50.573875] R10: 0000000000000001 R11: 0000000000000001 R12: ffff88810d0fa800
[   50.581006] R13: 0000000000000001 R14: ffff88843f42ab80 R15: ffff88810d0fa800
[   50.588139] FS:  0000000000000000(0000) GS:ffff88843f400000(0000) knlGS:0000000000000000
[   50.596228] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[   50.601975] CR2: 00007fbda63ea7f8 CR3: 000000043da0a002 CR4: 00000000003706f0
[   50.609105] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
[   50.616240] DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
[   50.623379] Call Trace:
[   50.625837]  __flush_work+0xaf/0x220
[   50.629418]  ? __queue_work+0x142/0x400
[   50.633261]  xfs_file_buffered_write+0x1d0/0x2c0 [xfs]
[   50.638468]  do_iter_readv_writev+0x157/0x1c0
[   50.642833]  do_iter_write+0x7d/0x1c0
[   50.646513]  lo_write_bvec+0x62/0x1a0 [loop]
[   50.650804]  loop_process_work+0x20d/0xb80 [loop]
[   50.655543]  ? newidle_balance+0x1f0/0x400
[   50.659647]  process_one_work+0x1ed/0x3c0
[   50.663696]  worker_thread+0x50/0x3c0
[   50.667365]  ? process_one_work+0x3c0/0x3c0
[   50.671568]  kthread+0x116/0x160
[   50.674813]  ? kthread_park+0xa0/0xa0
[   50.678476]  ret_from_fork+0x22/0x30
[   50.682070] ---[ end trace cdbf6e08ae434f6c ]---
[   56.951496] loop: Write error at byte offset 1032134656, length 4096.
[   56.957973] blk_update_request: I/O error, dev loop0, sector 2015816 op 0x1:(WRITE) flags 0x4000 phys_seg 21 prio class 0
----------------------------------------

Since xfs_init_mount_workqueues() as of 5.17-rc8 is doing

	mp->m_sync_workqueue = alloc_workqueue("xfs-sync/%s",
			XFS_WQFLAGS(WQ_FREEZABLE), 0, mp->m_super->s_id);

, this will still be the case.

Since

  scsi_add_host_with_dma() in drivers/scsi/hosts.c is doing

		shost->work_q = alloc_workqueue("%s",
			WQ_SYSFS | __WQ_LEGACY | WQ_MEM_RECLAIM | WQ_UNBOUND,
			1, shost->work_q_name);

  iscsi_host_alloc() in drivers/scsi/libiscsi.c is doing

		ihost->workq = alloc_workqueue("%s",
			WQ_SYSFS | __WQ_LEGACY | WQ_MEM_RECLAIM | WQ_UNBOUND,
			1, ihost->workq_name);

  iscsi_transport_init() in drivers/scsi/scsi_transport_iscsi.c is doing

	iscsi_eh_timer_workq = alloc_workqueue("%s",
			WQ_SYSFS | __WQ_LEGACY | WQ_MEM_RECLAIM | WQ_UNBOUND,
			1, "iscsi_eh");

  include/linux/workqueue.h is doing

	#define create_workqueue(name)						\
		alloc_workqueue("%s", __WQ_LEGACY | WQ_MEM_RECLAIM, 1, (name))

, I guess that also adding __WQ_LEGACY flag would avoid hitting

	WARN_ONCE(worker && ((worker->current_pwq->wq->flags &
			      (WQ_MEM_RECLAIM | __WQ_LEGACY)) == WQ_MEM_RECLAIM),
		  "workqueue: WQ_MEM_RECLAIM %s:%ps is flushing !WQ_MEM_RECLAIM %s:%ps",
		  worker->current_pwq->wq->name, worker->current_func,
		  target_wq->name, target_func);

warning.

But since include/linux/workqueue.h only says

	__WQ_LEGACY		= 1 << 18, /* internal: create*_workqueue() */

, I can't tell when not to specify __WQ_LEGACY and WQ_MEM_RECLAIM together...

Tejun, what is the intent of this warning? Can the description of __WQ_LEGACY flag
be updated? I think that the loop module had better reserve one "struct task_struct"
for each loop device.

I guess that, in general, waiting for a work in !WQ_MEM_RECLAIM WQ from a
WQ_MEM_RECLAIM WQ is dangerous because that work may not be able to find
"struct task_struct" for processing that work. Then, what we should do is to
create mp->m_sync_workqueue with WQ_MEM_RECLAIM flag added instead of creating
lo->workqueue with __WQ_LEGACY + WQ_MEM_RECLAIM flags added...

Is __WQ_LEGACY + WQ_MEM_RECLAIM combination a hack for silencing this warning
without fixing various WQs used by xfs and other filesystems?

