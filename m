Return-Path: <yu.chen.surf@gmail.com>
MIME-Version: 1.0
In-Reply-To: <CADjb_WQWzAGVSfzw_9j9DxSD4EPX7e76dZkaAFGv-37cKbdGEg@mail.gmail.com>
References: <CADjb_WQWzAGVSfzw_9j9DxSD4EPX7e76dZkaAFGv-37cKbdGEg@mail.gmail.com>
From: Yu Chen <yu.chen.surf@gmail.com>
Date: Thu, 9 Nov 2017 16:40:39 +0800
Message-ID: <CADjb_WRFd++SH0mFc=mwrJ0RFGx0A8FeTqqBdcu0TL8ddd7kNg@mail.gmail.com>
Subject: Re: [General protection fault] in bio_integrity_advance
To: linux-block@vger.kernel.org
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Jens Axboe <axboe@kernel.dk>,
	Milan Broz <gmazyland@gmail.com>, Christoph Hellwig <hch@lst.de>,
	Dan Williams <dan.j.williams@gmail.com>, Dmitry Monakhov <dmonakhov@openvz.org>,
	Dan Carpenter <dan.carpenter@oracle.com>, Keith Busch <keith.busch@intel.com>,
	Dan Williams <dan.j.williams@intel.com>
Content-Type: text/plain; charset="UTF-8"
List-ID: <linux-block@vger.kernel.org>

On Tue, Nov 7, 2017 at 4:38 PM, Yu Chen <yu.chen.surf@gmail.com> wrote:
> Hi all,
> We are using 4.13.5-100.fc25.x86_64 and a panic was found during
> resume from hibernation, the backtrace is illustrated as below, would
> someone please take a look if this has already been fixed or is this issue still
> in the upstream kernel? thanks!
> [  114.846213] PM: Using 3 thread(s) for decompression.
> [  114.846213] PM: Loading and decompressing image data (6555729 pages)...
> [  115.143169] PM: Image loading progress:   0%
> [  156.386990] PM: Image loading progress:  10%
> [  175.114169] PM: Image loading progress:  20%
> [  185.364073] PM: Image loading progress:  30%
> [  191.345652] PM: Image loading progress:  40%
> [  200.655883] PM: Image loading progress:  50%
> [  220.084360] PM: Image loading progress:  60%
> [  240.581079] PM: Image loading progress:  70%
> [  250.406290] general protection fault: 0000 [#1] SMP
> [  250.411779] Modules linked in: nouveau video mxm_wmi i2c_algo_bit
> drm_kms_helper ttm drm crc32c_intel wmi
> [  250.422524] CPU: 99 PID: 0 Comm: swapper/99 Not tainted
> 4.13.5-100.fc25.x86_64 #1
> [  250.430902] Hardware name: Intel Corporation PURLEY/PURLEY, BIOS
> PLYXCRB1.86B.0521.D18.1710241520 10/24/2017
> [  250.441901] task: ffff97f5827c0000 task.stack: ffffb0e418cdc000^M
> [  250.448528] RIP: 0010:bio_integrity_advance+0x1a/0xf0
> [  250.454182] RSP: 0018:ffff97f58f6c3da8 EFLAGS: 00010202
> [  250.460024] RAX: db19e5a5b91ff161 RBX: 58b38c0def2b26b8 RCX: 0000000180400021
> [  250.468008] RDX: 0000000000000000 RSI: 0000000000008000 RDI: ffff97f56eb7fd20
> [  250.475993] RBP: ffff97f58f6c3db0 R08: ffff97f56d8d3600 R09: 0000000180400021
> [  250.483976] R10: ffff97f58f6c3c48 R11: 00000000000a8000 R12: 0000000000008000
> [  250.491961] R13: ffff9739fcdfd400 R14: 00000000000a0000 R15: 0000000000008000
> [  250.499944] FS:  0000000000000000(0000) GS:ffff97f58f6c0000(0000)
> knlGS:0000000000000000
> [  250.508997] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> [  250.515427] CR2: 0000565407552e40 CR3: 00000115b7a67000 CR4: 00000000007406e0
> [  250.523412] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
> [  250.533458] DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
> [  250.543500] PKRU: 55555554
> [  250.548604] Call Trace:
> [  250.553415]  <IRQ>
> [  250.557729]  bio_advance+0x28/0xf0
> [  250.563598]  blk_update_request+0x92/0x2f0
> [  250.570223]  scsi_end_request+0x37/0x1d0
> [  250.576654]  scsi_io_completion+0x20e/0x690
> [  250.583362]  ? rebalance_domains+0x160/0x2b0
> [  250.590187]  scsi_finish_command+0xd9/0x120
> [  250.596924]  scsi_softirq_done+0x125/0x140
> [  250.603562]  blk_done_softirq+0x9e/0xd0
> [  250.609916]  __do_softirq+0x10c/0x2a5
> [  250.616073]  irq_exit+0xff/0x110
> [  250.621737]  smp_call_function_single_interrupt+0x33/0x40
> [  250.629831]  call_function_single_interrupt+0x93/0xa0
> [  250.637544] RIP: 0010:cpuidle_enter_state+0x126/0x2c0
> [  250.645263] RSP: 0018:ffffb0e418cdfe60 EFLAGS: 00000246 ORIG_RAX:
> ffffffffffffff04
> [  250.655814] RAX: 0000000000000000 RBX: 0000000000000002 RCX: 000000000000001f
> [  250.665885] RDX: 0000003a4d5f2d20 RSI: ffffffc820eb310b RDI: 0000000000000000
> [  250.675956] RBP: ffffb0e418cdfe98 R08: 0000000000000176 R09: 0000000000000018
> [  250.686018] R10: ffffb0e418cdfe30 R11: 0000000000000094 R12: ffff97f58f6e3b00
> [  250.696080] R13: ffffffffb1f72a78 R14: 0000003a4d5f2d20 R15: ffffffffb1f72a60
> [  250.706123]  </IRQ>
> [  250.710547]  cpuidle_enter+0x17/0x20
> [  250.716609]  call_cpuidle+0x23/0x40
> [  250.722550]  do_idle+0x18e/0x1e0
> [  250.728177]  cpu_startup_entry+0x73/0x80
> [  250.734560]  start_secondary+0x156/0x190
> [  250.740930]  secondary_startup_64+0x9f/0x9f
> [  250.747578] Code: 01 79 cc b1 e8 09 16 ce ff 31 c0 eb e6 0f 1f 40
> 00 0f 1f 44 00 00 55 48 89 e5 53 31 db f6 47 16 01 74 04 48 8b 5f 68
> 48 8b 47 08 <48> 8b 80 80 00 00 00 48 8b 90 d0 03 00 00 48 83 ba 48 02
> 00 00
> [  250.770821] RIP: bio_integrity_advance+0x1a/0xf0 RSP: ffff97f58f6c3da8^M
> [  250.780481] ---[ end trace d7b00b76aab34156 ]---
> [  250.841521] Kernel panic - not syncing: Fatal exception in interrupt
> [  250.851158] Kernel Offset: 0x30000000 from 0xffffffff81000000
> (relocation range: 0xffffffff80000000-0xffffffffbfffffff)
> [  250.912067] ---[ end Kernel panic - not syncing: Fatal exception in interrupt

According to the log, the exception was triggered when trying to
access:
bio->bi_bdev->bd_disk:

00000000000003b0 <bio_integrity_advance>:
     3b0:   e8 00 00 00 00          callq  3b5 <bio_integrity_advance+0x5>
     ...
     3c2:   48 8b 5f 68             mov    0x68(%rdi),%rbx
     3c6:   48 8b 47 08             mov    0x8(%rdi),%rax

     bio->bi_bdev->bd_disk, BOOM!
     3ca:   48 8b 80 80 00 00 00    mov    0x80(%rax),%rax

When the exception was triggered, the bio->bi_bdev is:
RAX: db19e5a5b91ff161
besides, we can see that bio->bi_integrity is
RBX: 58b38c0def2b26b8
which is also a random value.

So, is it possible that, during hibernation,
1. either the bio has not been initialized yet, AKA, use-before-inialize,
2. or, the  bio has already been released, thus cause a
    access-after-free scenario?

Any idea here?


thanks,
    Yu
