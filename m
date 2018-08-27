Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:42078 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725878AbeH0HfR (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Mon, 27 Aug 2018 03:35:17 -0400
Date: Mon, 27 Aug 2018 11:50:08 +0800
From: Ming Lei <ming.lei@redhat.com>
To: Steve Wise <swise@opengridcomputing.com>
Cc: 'Sagi Grimberg' <sagi@grimberg.me>, linux-rdma@vger.kernel.org,
        linux-nvme@lists.infradead.org, linux-block@vger.kernel.org,
        'Max Gurtovoy' <maxg@mellanox.com>,
        'Christoph Hellwig' <hch@lst.de>
Subject: Re: [PATCH v2] block: fix rdma queue mapping
Message-ID: <20180827035001.GB18003@ming.t460p>
References: <20180820205420.25908-1-sagi@grimberg.me>
 <20180821020434.GA24247@ming.t460p>
 <e82f994b-76ec-2a04-b575-acb4439e4d5b@grimberg.me>
 <005801d43c6d$c4afbba0$4e0f32e0$@opengridcomputing.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <005801d43c6d$c4afbba0$4e0f32e0$@opengridcomputing.com>
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

On Sat, Aug 25, 2018 at 07:18:43AM -0500, Steve Wise wrote:
> > > I guess this way still can't fix the request allocation crash issue
> > > triggered by using blk_mq_alloc_request_hctx(), in which one hw queue
> > may
> > > not be mapped from any online CPU.
> > 
> > Not really. I guess we will need to simply skip queues that are
> > mapped to an offline cpu.
> > 
> > > Maybe this patch isn't for this issue, but it is closely related.
> > 
> > Yes, another patch is still needed.
> > 
> > Steve, do you still have that patch? I don't seem to
> > find it anywhere.
> 
> I have no such patch.  I don't remember this issue.

This issue can be reproduced when running IO by doing CPU hotplug, then
the following log can be triggered:

[  396.629000] smpboot: CPU 2 is now offline
[  396.640759] nvmet: creating controller 1 for subsystem testnqn for NQN nqn.2014-08.org.nvmexpress:uuid:aa7d7d4a-0ee1-4960-ad0d-dbfe768b88d4.
[  396.642036] nvme nvme1: creating 1 I/O queues.
[  396.642480] BUG: unable to handle kernel paging request at 000060fd0a6bff48
[  396.643128] PGD 0 P4D 0
[  396.643364] Oops: 0002 [#1] PREEMPT SMP PTI
[  396.643774] CPU: 3 PID: 7 Comm: kworker/u8:0 Not tainted 4.18.0_2923b27e5424_master+ #1
[  396.644588] Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.10.2-2.fc27 04/01/2014
[  396.645597] Workqueue: nvme-reset-wq nvme_loop_reset_ctrl_work [nvme_loop]
[  396.646371] RIP: 0010:blk_mq_get_request+0x2e2/0x375
[  396.646924] Code: 00 00 48 c7 83 28 01 00 00 00 00 00 00 48 c7 83 30 01 00 00 00 00 00 00 48 8b 55 10 74 0c 31 c0 41 f7 c4 00 08 06 00 0f 95 c0 <48> ff 44 c2 48 41 81 e4 00 00 06 00 c7 83 d8 00 00 00 01 00 00 00
[  396.648699] RSP: 0018:ffffc90000c87cc8 EFLAGS: 00010246
[  396.649212] RAX: 0000000000000000 RBX: ffff880276350000 RCX: 0000000000000017
[  396.649931] RDX: 000060fd0a6bff00 RSI: 000000000010e9e6 RDI: 00155563b3000000
[  396.650646] RBP: ffffc90000c87d08 R08: 00000000f461b8ce R09: 000000000000006c
[  396.651393] R10: ffffc90000c87e50 R11: 0000000000000000 R12: 0000000000000023
[  396.652100] R13: 0000000000000000 R14: 0000000000000000 R15: 0000000000000000
[  396.652831] FS:  0000000000000000(0000) GS:ffff880277b80000(0000) knlGS:0000000000000000
[  396.653652] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[  396.654254] CR2: 000060fd0a6bff48 CR3: 000000000200a006 CR4: 0000000000760ee0
[  396.655051] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
[  396.655841] DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
[  396.656542] PKRU: 55555554
[  396.656808] Call Trace:
[  396.657094]  blk_mq_alloc_request_hctx+0xd1/0x11c
[  396.657599]  ? pcpu_block_update_hint_alloc+0xa1/0x1a5
[  396.658101]  nvme_alloc_request+0x42/0x71
[  396.658517]  __nvme_submit_sync_cmd+0x2d/0xd1
[  396.658945]  nvmf_connect_io_queue+0x10b/0x162 [nvme_fabrics]
[  396.659543]  ? nvme_loop_connect_io_queues+0x2d/0x52 [nvme_loop]
[  396.660126]  nvme_loop_connect_io_queues+0x2d/0x52 [nvme_loop]
[  396.660743]  nvme_loop_reset_ctrl_work+0x62/0xcf [nvme_loop]
[  396.661296]  process_one_work+0x1c9/0x2f6
[  396.661694]  ? rescuer_thread+0x282/0x282
[  396.662080]  process_scheduled_works+0x27/0x2c
[  396.662510]  worker_thread+0x1e7/0x295
[  396.662960]  kthread+0x115/0x11d
[  396.663334]  ? kthread_park+0x76/0x76
[  396.663752]  ret_from_fork+0x35/0x40
[  396.664169] Modules linked in: nvme_loop nvmet nvme_fabrics null_blk scsi_debug isofs iTCO_wdt iTCO_vendor_support i2c_i801 lpc_ich i2c_core mfd_core ip_tables sr_mod cdrom usb_storage sd_mod ahci libahci libata crc32c_intel virtio_scsi qemu_fw_cfg dm_mirror dm_region_hash dm_log dm_mod [last unloaded: scsi_debug]
[  396.667015] Dumping ftrace buffer:
[  396.667348]    (ftrace buffer empty)
[  396.667758] CR2: 000060fd0a6bff48
[  396.668129] ---[ end trace 887712785c99c2ca ]---


Thanks,
Ming
