Return-Path: <jack@suse.cz>
Date: Wed, 11 Apr 2018 15:58:44 +0200
From: Jan Kara <jack@suse.cz>
To: Jens Axboe <axboe@kernel.dk>
Cc: Jan Kara <jack@suse.cz>, Bart Van Assche <bart.vanassche@wdc.com>,
	linux-scsi <linux-scsi@vger.kernel.org>,
	"linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
Subject: Re: Hotplug
Message-ID: <20180411135844.yn4zj6q2x535xfk3@quack2.suse.cz>
References: <d74ccb4d-512d-ab58-c4c6-22b6c6a3da2a@kernel.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <d74ccb4d-512d-ab58-c4c6-22b6c6a3da2a@kernel.dk>
List-ID: <linux-block@vger.kernel.org>

Hi,

On Tue 10-04-18 11:17:46, Jens Axboe wrote:
> Been running some tests and I keep running into issues with hotplug.
> This looks similar to what Bart posted the other day, but it looks
> more deeply rooted than just having to protect the queue in
> generic_make_request_checks(). The test run is blktests,
> block/001. Current -git doesn't survive it. I've seen at least two
> different oopses, pasted below.
> 
> [  102.163442] NULL pointer dereference at 0000000000000010
> [  102.163444] PGD 0 P4D 0 
> [  102.163447] Oops: 0000 [#1] PREEMPT SMP
> [  102.163449] Modules linked in:
> [  102.175540] sr 12:0:0:0: [sr2] scsi-1 drive
> [  102.180112]  scsi_debug crc_t10dif crct10dif_generic crct10dif_common nvme nvme_core sb_edac xl
> [  102.186934] sr 12:0:0:0: Attached scsi CD-ROM sr2
> [  102.191896]  sr_mod cdrom btrfs xor zstd_decompress zstd_compress xxhash lzo_compress zlib_defc
> [  102.197169] sr 12:0:0:0: Attached scsi generic sg7 type 5
> [  102.203475]  igb ahci libahci i2c_algo_bit libata dca [last unloaded: crc_t10dif]
> [  102.203484] CPU: 43 PID: 4629 Comm: systemd-udevd Not tainted 4.16.0+ #650
> [  102.203487] Hardware name: Dell Inc. PowerEdge T630/0NT78X, BIOS 2.3.4 11/09/2016
> [  102.350882] RIP: 0010:sr_block_revalidate_disk+0x23/0x190 [sr_mod]
> [  102.358299] RSP: 0018:ffff883ff357bb58 EFLAGS: 00010292
> [  102.364734] RAX: ffffffffa00b07d0 RBX: ffff883ff3058000 RCX: ffff883ff357bb66
> [  102.373220] RDX: 0000000000000003 RSI: 0000000000007530 RDI: ffff881fea631000
> [  102.381705] RBP: 0000000000000000 R08: ffff881fe4d38400 R09: 0000000000000000
> [  102.390185] R10: 0000000000000000 R11: 00000000000001b6 R12: 000000000800005d
> [  102.398671] R13: 000000000800005d R14: ffff883ffd9b3790 R15: 0000000000000000
> [  102.407156] FS:  00007f7dc8e6d8c0(0000) GS:ffff883fff340000(0000) knlGS:0000000000000000
> [  102.417138] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> [  102.424066] CR2: 0000000000000010 CR3: 0000003ffda98005 CR4: 00000000003606e0
> [  102.432545] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
> [  102.441024] DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
> [  102.449502] Call Trace:
> [  102.452744]  ? __invalidate_device+0x48/0x60
> [  102.458022]  check_disk_change+0x4c/0x60
> [  102.462900]  sr_block_open+0x16/0xd0 [sr_mod]
> [  102.468270]  __blkdev_get+0xb9/0x450
> [  102.472774]  ? iget5_locked+0x1c0/0x1e0
> [  102.477568]  blkdev_get+0x11e/0x320
> [  102.481969]  ? bdget+0x11d/0x150
> [  102.486083]  ? _raw_spin_unlock+0xa/0x20
> [  102.490968]  ? bd_acquire+0xc0/0xc0
> [  102.495368]  do_dentry_open+0x1b0/0x320
> [  102.500159]  ? inode_permission+0x24/0xc0
> [  102.505140]  path_openat+0x4e6/0x1420
> [  102.509741]  ? cpumask_any_but+0x1f/0x40
> [  102.514630]  ? flush_tlb_mm_range+0xa0/0x120
> [  102.519903]  do_filp_open+0x8c/0xf0
> [  102.524305]  ? __seccomp_filter+0x28/0x230
> [  102.529389]  ? _raw_spin_unlock+0xa/0x20
> [  102.534283]  ? __handle_mm_fault+0x7d6/0x9b0
> [  102.539559]  ? list_lru_add+0xa8/0xc0
> [  102.544157]  ? _raw_spin_unlock+0xa/0x20
> [  102.549047]  ? __alloc_fd+0xaf/0x160
> [  102.553549]  ? do_sys_open+0x1a6/0x230
> [  102.558244]  do_sys_open+0x1a6/0x230
> [  102.562742]  do_syscall_64+0x5a/0x100
> [  102.567336]  entry_SYSCALL_64_after_hwframe+0x3d/0xa2

Interesting. Thinking out loud: This is cd->device dereference I guess
which means disk->private_data was NULL. That gets set in sr_probe()
together with disk->fops which are certainly set as they must have led us
to the crashing function sr_block_revalidate_disk(). So likely
disk->private_data got already cleared. That happens in sr_kref_release()
and the fact that that function got called means struct scsi_cd went away -
so sr_remove() must have been called as well. That all seems possible like:

CPU1		CPU2
sr_probe()
		__blkdev_get()
		  disk = bdev_get_gendisk();
<device removed>
sr_remove()
  del_gendisk()
  ...
  kref_put(&cd->kref, sr_kref_release);
    disk->private_data = NULL;
    put_disk(disk);
    kfree(cd);
		  if (disk->fops->open) {
		    ret = disk->fops->open(bdev, mode); => sr_block_open
		      check_disk_change(bdev);
		        sr_block_revalidate_disk()
			  CRASH

And I think the problem is in sr_block_revalidate_disk() itself as the
scsi_cd() call is not guaranteed that the caller holds reference to 'cd'
and thus that 'cd' does not disappear under it. IMHO it needs to use
scsi_cd_get() to get struct scsi_cd from gendisk. Am I missing something?

> and this one, similar to Barts:
> 
> [ 4676.738069] NULL pointer dereference at 0000000000000154
> [ 4676.738071] PGD 0 P4D 0 
> [ 4676.738073] Oops: 0000 [#1] PREEMPT SMP
> [ 4676.738075] Modules linked in: scsi_debug crc_t10dif nvme nvme_core loop configfs crct10dif_ge]
> [ 4676.859272] CPU: 10 PID: 16598 Comm: systemd-udevd Not tainted 4.16.0+ #651
> [ 4676.867525] Hardware name: Dell Inc. PowerEdge T630/0NT78X, BIOS 2.3.4 11/09/2016
> [ 4676.876765] RIP: 0010:blk_throtl_bio+0x45/0x9b0
> [ 4676.882296] RSP: 0018:ffff881ff0c8bb38 EFLAGS: 00010246
> [ 4676.888610] RAX: 0000000000000000 RBX: ffff881ffa273a40 RCX: 0000000000000000
> [ 4676.897059] RDX: ffff881ffa273a40 RSI: 0000000000000000 RDI: 0000000000000000
> [ 4676.905507] RBP: 0000000000000000 R08: ffff881ffa273ac0 R09: ffff881ff123f458
> [ 4676.913955] R10: ffff881ff0c8bc70 R11: 0000000000001000 R12: 0000000000000000
> [ 4676.922402] R13: ffffffff82600980 R14: ffff882081130000 R15: 0000000000000000
> [ 4676.930856] FS:  00007fe63e5228c0(0000) GS:ffff881fff740000(0000) knlGS:0000000000000000
> [ 4676.940773] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> [ 4676.947667] CR2: 0000000000000154 CR3: 0000001fed2a0003 CR4: 00000000003606e0
> [ 4676.956116] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
> [ 4676.964568] DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
> [ 4676.973021] Call Trace:
> [ 4676.976229]  generic_make_request_checks+0x640/0x660
> [ 4676.982245]  ? kmem_cache_alloc+0x37/0x190
> [ 4676.987295]  generic_make_request+0x29/0x2f0
> [ 4676.992534]  ? submit_bio+0x5c/0x110
> [ 4676.996998]  ? bio_alloc_bioset+0x99/0x1c0
> [ 4677.002050]  submit_bio+0x5c/0x110
> [ 4677.006317]  ? guard_bio_eod+0x42/0x120
> [ 4677.011074]  submit_bh_wbc.isra.49+0x132/0x160
> [ 4677.016517]  ? bh_uptodate_or_lock+0x90/0x90
> [ 4677.021757]  block_read_full_page+0x216/0x330
> [ 4677.027095]  ? check_disk_change+0x60/0x60
> [ 4677.032144]  ? __atime_needs_update+0x7f/0x190
> [ 4677.037576]  ? find_get_entry+0x98/0xf0
> [ 4677.042329]  ? pagecache_get_page+0x30/0x220
> [ 4677.047567]  ? touch_atime+0x27/0xb0
> [ 4677.052029]  generic_file_read_iter+0x60b/0x970
> [ 4677.057561]  ? _copy_to_user+0x56/0x70
> [ 4677.062221]  ? __seccomp_filter+0x28/0x230
> [ 4677.067269]  __vfs_read+0xd1/0x120
> [ 4677.071539]  vfs_read+0x9b/0x140
> [ 4677.075614]  ksys_read+0x45/0xa0
> [ 4677.079686]  do_syscall_64+0x5a/0x100
> [ 4677.084241]  entry_SYSCALL_64_after_hwframe+0x3d/0xa2
> [ 4677.090345] RIP: 0033:0x7fe63d6741f0
> [ 4677.094808] RSP: 002b:00007ffcb901f918 EFLAGS: 00000246 ORIG_RAX: 0000000000000000
> [ 4677.104143] RAX: ffffffffffffffda RBX: 000055b1645c33c0 RCX: 00007fe63d6741f0
> [ 4677.112584] RDX: 0000000000000400 RSI: 000055b1645c33e8 RDI: 000000000000000f
> [ 4677.121037] RBP: 000055b1645c32b0 R08: 00007fe63d65f008 R09: 0000000000000430
> [ 4677.129489] R10: 000055b1645c33d8 R11: 0000000000000246 R12: 0000000000000000
> [ 4677.137934] R13: 0000000000000400 R14: 000055b1645c3300 R15: 0000000000000400
> [ 4677.146385] Code: 85 f6 74 4e 48 63 05 ab 33 d6 00 4c 8b bc c6 c8 02 00 00 0f b7 43 14 f6 c4 0 
> [ 4677.168785] RIP: blk_throtl_bio+0x45/0x9b0 RSP: ffff881ff0c8bb38

I'm not really sure where this is crashing and 'Code' line is incomplete to
tell me.

								Honza

-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
