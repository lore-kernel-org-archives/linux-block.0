Return-Path: <joseph.qi@linux.alibaba.com>
Subject: Re: [block regression] kernel oops triggered by removing scsi device
 dring IO
To: Ming Lei <ming.lei@redhat.com>, Jens Axboe <axboe@kernel.dk>,
 Bart Van Assche <bart.vanassche@wdc.com>
Cc: linux-block@vger.kernel.org
References: <20180408042112.GB19128@ming.t460p>
From: Joseph Qi <joseph.qi@linux.alibaba.com>
Message-ID: <0c744185-2374-1485-81da-068e4ed0d82f@linux.alibaba.com>
Date: Sun, 8 Apr 2018 16:11:51 +0800
MIME-Version: 1.0
In-Reply-To: <20180408042112.GB19128@ming.t460p>
Content-Type: text/plain; charset=utf-8
List-ID: <linux-block@vger.kernel.org>

This is because scsi_remove_device() will call blk_cleanup_queue(), and
then all blkgs have been destroyed and root_blkg is NULL.
Thus tg is NULL and trigger NULL pointer dereference when get td from
tg (tg->td).
It seems that we cannot simply move blkcg_exit_queue() up to
blk_cleanup_queue().

Thanks,
Joseph

On 18/4/8 12:21, Ming Lei wrote:
> Hi,
> 
> The following kernel oops is triggered by 'removing scsi device' during
> heavy IO.
> 
> 'git bisect' shows that commit a063057d7c731cffa7d10740(block: Fix a race
> between request queue removal and the block cgroup controller)
> introduced this regression:
> 
> [   42.268257] BUG: unable to handle kernel NULL pointer dereference at 0000000000000028
> [   42.269339] PGD 26bd9f067 P4D 26bd9f067 PUD 26bfec067 PMD 0 
> [   42.270077] Oops: 0000 [#1] PREEMPT SMP NOPTI
> [   42.270681] Dumping ftrace buffer:
> [   42.271141]    (ftrace buffer empty)
> [   42.271641] Modules linked in: scsi_debug iTCO_wdt iTCO_vendor_support crc32c_intel i2c_i801 i2c_core lpc_ich mfd_core usb_storage nvme shpchp nvme_core virtio_scsi qemu_fw_cfg ip_tables
> [   42.273770] CPU: 5 PID: 1076 Comm: fio Not tainted 4.16.0+ #49
> [   42.274530] Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.10.2-2.fc27 04/01/2014
> [   42.275634] RIP: 0010:blk_throtl_bio+0x41/0x904
> [   42.276225] RSP: 0018:ffffc900033cfaa0 EFLAGS: 00010246
> [   42.276907] RAX: 0000000080000000 RBX: ffff8801bdcc5118 RCX: 0000000000000001
> [   42.277818] RDX: ffff8801bdcc5118 RSI: 0000000000000000 RDI: ffff8802641f8870
> [   42.278733] RBP: 0000000000000000 R08: 0000000000000001 R09: ffffc900033cfb94
> [   42.279651] R10: ffffc900033cfc00 R11: 0000000006ea0000 R12: ffff8802641f8870
> [   42.280567] R13: ffff88026f34f000 R14: 0000000000000000 R15: ffff8801bdcc5118
> [   42.281489] FS:  00007fc123922d40(0000) GS:ffff880272f40000(0000) knlGS:0000000000000000
> [   42.282525] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> [   42.283270] CR2: 0000000000000028 CR3: 000000026d7ac004 CR4: 00000000007606e0
> [   42.284194] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
> [   42.285116] DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
> [   42.286036] PKRU: 55555554
> [   42.286393] Call Trace:
> [   42.286725]  ? try_to_wake_up+0x3a3/0x3c9
> [   42.287255]  ? blk_mq_hctx_notify_dead+0x135/0x135
> [   42.287880]  ? gup_pud_range+0xb5/0x7e1
> [   42.288381]  generic_make_request_checks+0x3cf/0x539
> [   42.289027]  ? gup_pgd_range+0x8e/0xaa
> [   42.289515]  generic_make_request+0x38/0x25b
> [   42.290078]  ? submit_bio+0x103/0x11f
> [   42.290555]  submit_bio+0x103/0x11f
> [   42.291018]  ? bio_iov_iter_get_pages+0xe4/0x104
> [   42.291620]  blkdev_direct_IO+0x2a3/0x3af
> [   42.292151]  ? kiocb_free+0x34/0x34
> [   42.292607]  ? ___preempt_schedule+0x16/0x18
> [   42.293168]  ? preempt_schedule_common+0x4c/0x65
> [   42.293771]  ? generic_file_read_iter+0x96/0x110
> [   42.294377]  generic_file_read_iter+0x96/0x110
> [   42.294962]  aio_read+0xca/0x13b
> [   42.295388]  ? preempt_count_add+0x6d/0x8c
> [   42.295926]  ? aio_read_events+0x287/0x2d6
> [   42.296460]  ? do_io_submit+0x4d2/0x62c
> [   42.296964]  do_io_submit+0x4d2/0x62c
> [   42.297446]  ? do_syscall_64+0x9d/0x15e
> [   42.297950]  do_syscall_64+0x9d/0x15e
> [   42.298431]  entry_SYSCALL_64_after_hwframe+0x3d/0xa2
> [   42.299090] RIP: 0033:0x7fc12244e687
> [   42.299556] RSP: 002b:00007ffe18388a68 EFLAGS: 00000202 ORIG_RAX: 00000000000000d1
> [   42.300528] RAX: ffffffffffffffda RBX: 00007fc0fde08670 RCX: 00007fc12244e687
> [   42.301442] RDX: 0000000001d1b388 RSI: 0000000000000001 RDI: 00007fc123782000
> [   42.302359] RBP: 00000000000022d8 R08: 0000000000000001 R09: 0000000001c461e0
> [   42.303275] R10: 0000000000000000 R11: 0000000000000202 R12: 00007fc0fde08670
> [   42.304195] R13: 0000000000000000 R14: 0000000001d1d0c0 R15: 0000000001b872f0
> [   42.305117] Code: 48 85 f6 48 89 7c 24 10 75 0e 48 8b b7 b8 05 00 00 31 ed 48 85 f6 74 0f 48 63 05 75 a4 e4 00 48 8b ac c6 28 02 00 00 f6 43 15 02 <48> 8b 45 28 48 89 04 24 0f 85 28 08 00 00 8b 43 10 45 31 e4 83 
> [   42.307553] RIP: blk_throtl_bio+0x41/0x904 RSP: ffffc900033cfaa0
> [   42.308328] CR2: 0000000000000028
> [   42.308920] ---[ end trace f53a144979f63b29 ]---
> [   42.309520] Kernel panic - not syncing: Fatal exception
> [   42.310635] Dumping ftrace buffer:
> [   42.311087]    (ftrace buffer empty)
> [   42.311583] Kernel Offset: disabled
> [   42.312163] ---[ end Kernel panic - not syncing: Fatal exception ]---
> 
