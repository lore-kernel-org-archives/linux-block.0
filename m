Return-Path: <jack@suse.cz>
Date: Tue, 7 Mar 2017 14:57:30 +0100
From: Jan Kara <jack@suse.cz>
To: Omar Sandoval <osandov@osandov.com>
Cc: Jan Kara <jack@suse.cz>, Jens Axboe <axboe@kernel.dk>,
	linux-block@vger.kernel.org, Christoph Hellwig <hch@infradead.org>,
	Dan Williams <dan.j.williams@intel.com>,
	Thiago Jung Bauermann <bauerman@linux.vnet.ibm.com>,
	Lekshmi Pillai <lekshmicpillai@in.ibm.com>,
	Tejun Heo <tj@kernel.org>, NeilBrown <neilb@suse.de>
Subject: Re: [PATCH 0/13 v2] block: Fix block device shutdown related races
Message-ID: <20170307135730.GG2578@quack2.suse.cz>
References: <20170221170958.21845-1-jack@suse.cz>
 <7734fd93-e4fd-65a7-bf32-08012de83c1e@kernel.dk>
 <20170222102425.GB23312@quack2.suse.cz>
 <20170301072528.GA9377@vader>
 <20170301072653.GB9377@vader>
 <20170301151109.GI20512@quack2.suse.cz>
 <20170306203818.GC16893@vader.DHCP.thefacebook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20170306203818.GC16893@vader.DHCP.thefacebook.com>
List-ID: <linux-block@vger.kernel.org>

On Mon 06-03-17 12:38:18, Omar Sandoval wrote:
> On Wed, Mar 01, 2017 at 04:11:09PM +0100, Jan Kara wrote:
> > On Tue 28-02-17 23:26:53, Omar Sandoval wrote:
> > > On Tue, Feb 28, 2017 at 11:25:28PM -0800, Omar Sandoval wrote:
> > > > On Wed, Feb 22, 2017 at 11:24:25AM +0100, Jan Kara wrote:
> > > > > On Tue 21-02-17 10:19:28, Jens Axboe wrote:
> > > > > > On 02/21/2017 10:09 AM, Jan Kara wrote:
> > > > > > > Hello,
> > > > > > > 
> > > > > > > this is a second revision of the patch set to fix several different races and
> > > > > > > issues I've found when testing device shutdown and reuse. The first three
> > > > > > > patches are fixes to problems in my previous series fixing BDI lifetime issues.
> > > > > > > Patch 4 fixes issues with reuse of BDI name with scsi devices. With it I cannot
> > > > > > > reproduce the BDI name reuse issues using Omar's stress test using scsi_debug
> > > > > > > so it can be used as a replacement of Dan's patches. Patches 5-11 fix oops that
> > > > > > > is triggered by __blkdev_put() calling inode_detach_wb() too early (the problem
> > > > > > > reported by Thiago). Patches 12 and 13 fix oops due to a bug in gendisk code
> > > > > > > where get_gendisk() can return already freed gendisk structure (again triggered
> > > > > > > by Omar's stress test).
> > > > > > > 
> > > > > > > People, please have a look at patches. They are mostly simple however the
> > > > > > > interactions are rather complex so I may have missed something. Also I'm
> > > > > > > happy for any additional testing these patches can get - I've stressed them
> > > > > > > with Omar's script, tested memcg writeback, tested static (not udev managed)
> > > > > > > device inodes.
> > > > > > > 
> > > > > > > Jens, I think at least patches 1-3 should go in together with my fixes you
> > > > > > > already have in your tree (or shortly after them). It is up to you whether
> > > > > > > you decide to delay my first fixes or pick these up quickly. Patch 4 is
> > > > > > > (IMHO a cleaner) replacement of Dan's patches so consider whether you want
> > > > > > > to use it instead of those patches.
> > > > > > 
> > > > > > I have applied 1-3 to my for-linus branch, which will go in after
> > > > > > the initial pull request has been pulled by Linus. Consider fixing up
> > > > > > #4 so it applies, I like it.
> > > > > 
> > > > > OK, attached is patch 4 rebased on top of Linus' tree from today which
> > > > > already has linux-block changes pulled in. I've left put_disk_devt() in
> > > > > blk_cleanup_queue() to maintain the logic in the original patch (now commit
> > > > > 0dba1314d4f8) that request_queue and gendisk each hold one devt reference.
> > > > > The bdi_unregister() call that is moved to del_gendisk() by this patch is
> > > > > now protected by the gendisk reference instead of the request_queue one
> > > > > so it still maintains the property that devt reference protects bdi
> > > > > registration-unregistration lifetime (as much as that is not needed anymore
> > > > > after this patch).
> > > > > 
> > > > > I have also updated the comment in the code and the changelog - they were
> > > > > somewhat stale after changes to the whole series Tejun suggested.
> > > > > 
> > > > > 								Honza
> > > > 
> > > > Hey, Jan, I just tested this out when I was seeing similar crashes with
> > > > sr instead of sd, and this fixed it.
> > > > 
> > > > Tested-by: Omar Sandoval <osandov@fb.com>
> > > 
> > > Just realized it wasn't clear, I'm talking about patch 4 specifically.
> > 
> > Thanks for confirmation!
> > 
> > 								Honza
> 
> Unfortunately, this patch actually seems to have introduced a
> regression. Reverting the patch fixes it.
> 
> I'm running a QEMU kvm vm with a virtio-scsi device and I get oopses
> like this:

What workload do you run? Or is it enough to just boot the kvm with
virtio-scsi enabled? Can you send me the kvm setup so that I can reproduce
this?

At least the KASAN error could be a result of the situation where someone
called bdi_register() but didn't call bdi_unregister() before dropping the
last bdi reference (which would make sense given I've moved
bdi_unregister() call). However I'd expect a warning from bdi_exit() in that
case and I don't see that in your kernel log. So I'll try to reproduce the
issue and debug more.

								Honza

> 
> [    6.741773] BUG: unable to handle kernel NULL pointer dereference at 0000000000000004
> [    6.744401] IP: virtscsi_queuecommand_single+0x21/0x40 [virtio_scsi]
> [    6.744985] PGD 0
> [    6.744985]
> [    6.744985] Oops: 0002 [#1] PREEMPT SMP
> [    6.744985] Modules linked in: virtio_scsi scsi_mod virtio_net
> [    6.744985] CPU: 3 PID: 5 Comm: kworker/u8:0 Not tainted 4.11.0-rc1 #36
> [    6.744985] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.10.1-20161122_114906-anatol 04/01/2014
> [    6.744985] Workqueue: events_unbound async_run_entry_fn
> [    6.744985] task: ffff88007c8672c0 task.stack: ffffc9000033c000
> [    6.750038] RIP: 0010:virtscsi_queuecommand_single+0x21/0x40 [virtio_scsi]
> [    6.750038] RSP: 0018:ffffc9000033f8b0 EFLAGS: 00010246
> [    6.750038] RAX: ffff88007c98d000 RBX: ffff880078c814c8 RCX: 0000000000000000
> [    6.750038] RDX: ffff880078c814c8 RSI: ffff880078c814c8 RDI: ffff88007c98d000
> [    6.750038] RBP: ffffc9000033f8b0 R08: 0000000000000000 R09: 0000000000000400
> [    6.750038] R10: ffff88007b1fe748 R11: 0000000000000024 R12: ffff880078c814c8
> [    6.750038] R13: ffff88007c98d000 R14: ffff880078c81380 R15: ffff88007b532000
> [    6.750038] FS:  0000000000000000(0000) GS:ffff88007fd80000(0000) knlGS:0000000000000000
> [    6.750038] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> [    6.750038] CR2: 0000000000000004 CR3: 0000000001c09000 CR4: 00000000000006e0
> [    6.750038] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
> [    6.750038] DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
> [    6.750038] Call Trace:
> [    6.750038]  scsi_dispatch_cmd+0xa3/0x1d0 [scsi_mod]
> [    6.750038]  scsi_queue_rq+0x586/0x740 [scsi_mod]
> [    6.750038]  blk_mq_dispatch_rq_list+0x22a/0x420
> [    6.750038]  blk_mq_sched_dispatch_requests+0x142/0x1b0
> [    6.750038]  __blk_mq_run_hw_queue+0x94/0xb0
> [    6.750038]  blk_mq_run_hw_queue+0x82/0xa0
> [    6.750038]  blk_mq_sched_insert_request+0x89/0x1a0
> [    6.750038]  ? blk_execute_rq+0xc0/0xc0
> [    6.750038]  blk_execute_rq_nowait+0x9a/0x140
> [    6.750038]  ? bio_phys_segments+0x19/0x20
> [    6.750038]  blk_execute_rq+0x56/0xc0
> [    6.750038]  scsi_execute+0x128/0x270 [scsi_mod]
> [    6.750038]  scsi_probe_and_add_lun+0x247/0xc60 [scsi_mod]
> [    6.750038]  ? __pm_runtime_resume+0x4c/0x60
> [    6.750038]  __scsi_scan_target+0x102/0x520 [scsi_mod]
> [    6.750038]  ? account_entity_dequeue+0xab/0xe0
> [    6.750038]  scsi_scan_channel+0x81/0xa0 [scsi_mod]
> [    6.750038]  scsi_scan_host_selected+0xcc/0x100 [scsi_mod]
> [    6.750038]  do_scsi_scan_host+0x8d/0x90 [scsi_mod]
> [    6.750038]  do_scan_async+0x1c/0x1a0 [scsi_mod]
> [    6.750038]  async_run_entry_fn+0x4a/0x170
> [    6.750038]  process_one_work+0x165/0x430
> [    6.750038]  worker_thread+0x4e/0x490
> [    6.750038]  kthread+0x101/0x140
> [    6.750038]  ? process_one_work+0x430/0x430
> [    6.750038]  ? kthread_create_on_node+0x60/0x60
> [    6.750038]  ret_from_fork+0x2c/0x40
> [    6.750038] Code: ff ff 0f 1f 84 00 00 00 00 00 0f 1f 44 00 00 55 48 8b 4e 30 48 89 f8 48 89 f2 48 89 e5 48 8b 89 88 01 00 00 48 8b 89 08 03 00 00 <f0> ff 41 04 48 8d bf c0 07 00 00 48 8d b0 c8 09 00 00 e8 08 fd
> [    6.750038] RIP: virtscsi_queuecommand_single+0x21/0x40 [virtio_scsi] RSP: ffffc9000033f8b0
> [    6.750038] CR2: 0000000000000004
> [    6.750038] ---[ end trace cee5df55872abfa0 ]---
> [    6.750038] note: kworker/u8:0[5] exited with preempt_count 1
> 
> Arch Linux 4.11.0-rc1 (ttyS0)
> 
> silver login: [   27.370267] scsi 0:0:53:0: tag#766 abort
> [   27.374501] scsi 0:0:53:0: device reset
> [   27.378539] scsi 0:0:53:0: Device offlined - not ready after error recovery
> 
> That crash is because tgt is NULL here:
> 
> ----
> static int virtscsi_queuecommand_single(struct Scsi_Host *sh,
> 					struct scsi_cmnd *sc)
> {
> 	struct virtio_scsi *vscsi = shost_priv(sh);
> 	struct virtio_scsi_target_state *tgt =
> 				scsi_target(sc->device)->hostdata;
> 
> ======> atomic_inc(&tgt->reqs);
> 	return virtscsi_queuecommand(vscsi, &vscsi->req_vqs[0], sc);
> }
> ----
> 
> Applying the rest of this patch set didn't fix it. Additionally,
> enabling KASAN gives this use-after-free spew:
> ----
> [    7.789280] SCSI subsystem initialized
> [    7.809991] virtio_net virtio0 ens2: renamed from eth0
> [    7.828301] scsi host0: Virtio SCSI HBA
> [    7.916214] scsi 0:0:0:0: Direct-Access     QEMU     QEMU HARDDISK    2.5+ PQ: 0 ANSI: 5
> [    7.946713] ==================================================================
> [    7.947609] BUG: KASAN: use-after-free in rb_erase+0x13a2/0x1a20 at addr ffff88006a915e30
> [    7.948583] Write of size 8 by task dhcpcd-run-hook/146
> [    7.949202] CPU: 0 PID: 146 Comm: dhcpcd-run-hook Not tainted 4.11.0-rc1-00011-gc35ccd2d43e9 #42
> [    7.950021] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.10.1-20161122_114906-anatol 04/01/2014
> [    7.950021] Call Trace:
> [    7.950021]  <IRQ>
> [    7.950021]  dump_stack+0x63/0x86
> [    7.950021]  kasan_object_err+0x21/0x70
> [    7.950021]  kasan_report.part.1+0x23a/0x520
> [    7.950021]  ? rb_erase+0x13a2/0x1a20
> [    7.950021]  ? swake_up_locked+0x94/0x1c0
> [    7.950021]  __asan_report_store8_noabort+0x31/0x40
> [    7.950021]  rb_erase+0x13a2/0x1a20
> [    7.950021]  wb_congested_put+0x6a/0xd0
> [    7.950021]  __blkg_release_rcu+0x16b/0x230
> [    7.950021]  rcu_process_callbacks+0x602/0xfc0
> [    7.950021]  __do_softirq+0x14e/0x5b3
> [    7.950021]  irq_exit+0x14e/0x180
> [    7.950021]  smp_apic_timer_interrupt+0x7b/0xa0
> [    7.950021]  apic_timer_interrupt+0x89/0x90
> [    7.950021] RIP: 0010:copy_strings.isra.7+0x312/0x6b0
> [    7.950021] RSP: 0018:ffff880063bffcd0 EFLAGS: 00000202 ORIG_RAX: ffffffffffffff10
> [    7.950021] RAX: 0000000000002000 RBX: 0000000000000fe3 RCX: 0000000000000002
> [    7.950021] RDX: ffff88006a734880 RSI: 0000000000000002 RDI: ffff880069750808
> [    7.950021] RBP: ffff880063bffdd0 R08: 8000000063ec3067 R09: 0000000000000040
> [    7.950021] R10: ffffed000c7d8600 R11: ffffffff82afa6a0 R12: 00007fffffffefe3
> [    7.950021] R13: 0000000000000015 R14: ffff880069750780 R15: dffffc0000000000
> [    7.950021]  </IRQ>
> [    7.950021]  ? set_binfmt+0x120/0x120
> [    7.950021]  ? insert_vm_struct+0x148/0x2e0
> [    7.950021]  ? kasan_slab_alloc+0x12/0x20
> [    7.950021]  ? count.isra.6.constprop.16+0x52/0x100
> [    7.950021]  do_execveat_common.isra.14+0xef1/0x1b80
> [    7.950021]  ? prepare_bprm_creds+0x100/0x100
> [    7.950021]  ? getname_flags+0x90/0x3f0
> [    7.950021]  ? __do_page_fault+0x5cc/0xbc0
> [    7.950021]  SyS_execve+0x3a/0x50
> [    7.950021]  ? ptregs_sys_vfork+0x10/0x10
> [    7.950021]  do_syscall_64+0x180/0x380
> [    7.950021]  entry_SYSCALL64_slow_path+0x25/0x25
> [    7.950021] RIP: 0033:0x7f85de145477
> [    7.950021] RSP: 002b:00007ffdf2da3568 EFLAGS: 00000202 ORIG_RAX: 000000000000003b
> [    7.950021] RAX: ffffffffffffffda RBX: 0000000000d771c0 RCX: 00007f85de145477
> [    7.950021] RDX: 0000000000d35fb0 RSI: 0000000000d697e0 RDI: 0000000000d771c0
> [    7.950021] RBP: 0000000000000000 R08: 00007ffdf2da3560 R09: 0000000000000030
> [    7.950021] R10: 000000000000059a R11: 0000000000000202 R12: 0000000000d771c0
> [    7.950021] R13: 0000000000d697e0 R14: 0000000000d35fb0 R15: 0000000000000000
> [    7.950021] Object at ffff88006a915b00, in cache kmalloc-1024 size: 1024
> [    7.950021] Allocated:
> [    7.950021] PID = 72
> [    7.950021]  save_stack_trace+0x1b/0x20
> [    7.950021]  kasan_kmalloc+0xee/0x190
> [    7.950021]  kmem_cache_alloc_node_trace+0x138/0x200
> [    7.950021]  bdi_alloc_node+0x4c/0xa0
> [    7.950021]  blk_alloc_queue_node+0xdd/0x870
> [    7.950021]  blk_mq_init_queue+0x41/0x90
> [    7.950021]  scsi_mq_alloc_queue+0x41/0x130 [scsi_mod]
> [    7.950021]  scsi_alloc_sdev+0x90e/0xd00 [scsi_mod]
> [    7.950021]  scsi_probe_and_add_lun+0x14b3/0x2250 [scsi_mod]
> [    7.950021]  __scsi_scan_target+0x23d/0xb60 [scsi_mod]
> [    7.950021]  scsi_scan_channel+0x107/0x160 [scsi_mod]
> [    7.950021]  scsi_scan_host_selected+0x1bf/0x250 [scsi_mod]
> [    7.950021]  do_scsi_scan_host+0x1bc/0x250 [scsi_mod]
> [    7.950021]  do_scan_async+0x41/0x4b0 [scsi_mod]
> [    7.950021]  async_run_entry_fn+0xc3/0x630
> [    7.950021]  process_one_work+0x531/0xf40
> [    7.950021]  worker_thread+0xe4/0x10d0
> [    7.950021]  kthread+0x298/0x390
> [    7.950021]  ret_from_fork+0x2c/0x40
> [    7.950021] Freed:
> [    7.950021] PID = 72
> [    7.950021]  save_stack_trace+0x1b/0x20
> [    7.950021]  kasan_slab_free+0xb0/0x180
> [    7.950021]  kfree+0x9f/0x1d0
> [    7.950021]  bdi_put+0x2a/0x30
> [    7.950021]  blk_release_queue+0x51/0x320
> [    7.950021]  kobject_put+0x154/0x430
> [    7.950021]  blk_put_queue+0x15/0x20
> [    7.950021]  scsi_device_dev_release_usercontext+0x59b/0x880 [scsi_mod]
> [    7.950021]  execute_in_process_context+0xd9/0x130
> [    7.950021]  scsi_device_dev_release+0x1c/0x20 [scsi_mod]
> [    7.950021]  device_release+0x76/0x1e0
> [    7.950021]  kobject_put+0x154/0x430
> [    7.950021]  put_device+0x17/0x20
> [    7.950021]  __scsi_remove_device+0x18d/0x250 [scsi_mod]
> [    7.950021]  scsi_probe_and_add_lun+0x14d6/0x2250 [scsi_mod]
> [    7.950021]  __scsi_scan_target+0x23d/0xb60 [scsi_mod]
> [    7.950021]  scsi_scan_channel+0x107/0x160 [scsi_mod]
> [    7.950021]  scsi_scan_host_selected+0x1bf/0x250 [scsi_mod]
> [    7.950021]  do_scsi_scan_host+0x1bc/0x250 [scsi_mod]
> [    7.950021]  do_scan_async+0x41/0x4b0 [scsi_mod]
> [    7.950021]  async_run_entry_fn+0xc3/0x630
> [    7.950021]  process_one_work+0x531/0xf40
> [    7.950021]  worker_thread+0xe4/0x10d0
> [    7.950021]  kthread+0x298/0x390
> [    7.950021]  ret_from_fork+0x2c/0x40
> [    7.950021] Memory state around the buggy address:
> [    7.950021]  ffff88006a915d00: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
> [    7.950021]  ffff88006a915d80: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
> [    7.950021] >ffff88006a915e00: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
> [    7.950021]                                      ^
> [    7.950021]  ffff88006a915e80: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
> [    7.950021]  ffff88006a915f00: fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc
> ----
> 
> Any ideas Jan?
> 
> Thanks.
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
